img = imread('depthsense6.png');

left = img(1:1242, 1:2208, :);
right = img(1:1242, 2209:4416, :);

[LeftRect, RightRect] = rectifyStereoImages(left, right, stereoParams, 'OutputView', 'valid');

figure;
imtool(stereoAnaglyph(LeftRect, RightRect));

leftgray = rgb2gray(LeftRect);
rightgray = rgb2gray(RightRect);
disparitymap = disparity(leftgray, rightgray, 'BlockSize', 59);

figure;
imshow(disparitymap, [0, 64]);
title('disparity');
colormap jet
colorbar

points3D = reconstructScene(disparitymap, stereoParams);

points3D = points3D./1000;
ptCloud = pointCloud(points3D, 'Color', LeftRect);

pcwrite(ptCloud, 'pointcloud2');
