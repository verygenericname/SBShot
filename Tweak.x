#import <Foundation/Foundation.h>
#import <rootless.h>
#import <UIKit/UIKit.h>

#define PATH ROOT_PATH_NS(@"/var/mobile/Library/Preferences/com.icraze.sbshotenabled")

OBJC_EXTERN UIImage *_UICreateScreenUIImage(void);
void takeScreenshotAndSave() {
	UIImage *image = _UICreateScreenUIImage();
	if (image == nil) return;
	UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

%hook SBCombinationHardwareButton
-(void)screenshotGesture:(id)gesture {
	// only pref value is on/off, so i just check file existence
	[[NSFileManager defaultManager] fileExistsAtPath:PATH] ? takeScreenshotAndSave() : %orig;
}
%end
