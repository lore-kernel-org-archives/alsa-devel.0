From: saranya.gopal@intel.com
Subject: [PATCH V3] usbcore: Select only first configuration for non-UAC3 compliant devices
Date: Sun,  6 Jan 2019 08:14:02 +0530
Message-ID: <1546742642-29269-1-git-send-email-saranya.gopal@intel.com>
References: <CABqErrHKFshAMBPHJp2vmGFE6k1GL1oDMSMbDRcBJNfUSxt9KQ@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABqErrHKFshAMBPHJp2vmGFE6k1GL1oDMSMbDRcBJNfUSxt9KQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel@kolivas.org
Cc: gregkh@linuxfoundation.org, pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, tiwai@suse.de, felipe.balbi@linux.intel.com, Saranya Gopal <saranya.gopal@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Saranya Gopal <saranya.gopal@intel.com>

In most of the UAC1 and UAC2 audio devices, the first
configuration is most often the best configuration.
However, with recent patch to support UAC3 configuration,
second configuration was unintentionally chosen for
some of the UAC1/2 devices that had more than one
configuration. This was because of the existing check
after the audio config check which selected any config
which had a non-vendor class. This patch fixes this issue.

Fixes: f13912d3f014 ("usbcore: Select UAC3 configuration for audio if present")
Reported-by: Con Kolivas <kernel@kolivas.org>
Signed-off-by: Saranya Gopal <saranya.gopal@intel.com>
Tested-by: Con Kolivas <kernel@kolivas.org>
---
Changes from V2: Added Tested-by tag
Changes from V1: Added full commit name and more SHA1 numbers in Fixes tag

 drivers/usb/core/generic.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
index 356b05c..f713cec 100644
--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -143,9 +143,12 @@ int usb_choose_configuration(struct usb_device *udev)
 			continue;
 		}
 
-		if (i > 0 && desc && is_audio(desc) && is_uac3_config(desc)) {
-			best = c;
-			break;
+		if (i > 0 && desc && is_audio(desc)) {
+			if (is_uac3_config(desc)) {
+				best = c;
+				break;
+			}
+			continue;
 		}
 
 		/* From the remaining configs, choose the first one whose
-- 
1.9.1
