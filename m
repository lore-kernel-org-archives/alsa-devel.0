From: Jason Lee Cragg <jcragg@gmail.com>
Subject: [PATCH] Add Logitech Webcam C210 to list of Logitech webcams that require mic volume fix
Date: Sat, 17 Jan 2015 12:28:29 -0500
Message-ID: <1421515709-9923-1-git-send-email-jcragg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jason Lee Cragg <jcragg@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Jason Lee Cragg <jcragg@gmail.com>

Signed-off-by: Jason Lee Cragg <jcragg@gmail.com>
---
 sound/usb/mixer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 41650d5..3e2ef61 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -913,6 +913,7 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 	case USB_ID(0x046d, 0x0807): /* Logitech Webcam C500 */
 	case USB_ID(0x046d, 0x0808):
 	case USB_ID(0x046d, 0x0809):
+	case USB_ID(0x046d, 0x0819): /* Logitech Webcam C210 */
 	case USB_ID(0x046d, 0x081b): /* HD Webcam c310 */
 	case USB_ID(0x046d, 0x081d): /* HD Webcam c510 */
 	case USB_ID(0x046d, 0x0825): /* HD Webcam c270 */
-- 
1.9.1
