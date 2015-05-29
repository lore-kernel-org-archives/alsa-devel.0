From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] ALSA: usb-audio: Add mic volume fix quirk for
	Logitech Quickcam Fusion
Date: Fri, 29 May 2015 19:50:56 +0900
Message-ID: <1432896656-3228-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 14E1126672E
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 12:51:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Wolfram Sang <wsa@the-dreams.de>
List-Id: alsa-devel@alsa-project.org

Fix this from the logs:

usb 7-1: New USB device found, idVendor=046d, idProduct=08ca
...
usb 7-1: Warning! Unlikely big volume range (=3072), cval->res is probably wrong.
usb 7-1: [5] FU [Mic Capture Volume] ch = 1, val = 4608/7680/1

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 sound/usb/mixer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 3e2ef61c627b83..4256fdedbd8009 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -918,6 +918,7 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 	case USB_ID(0x046d, 0x081d): /* HD Webcam c510 */
 	case USB_ID(0x046d, 0x0825): /* HD Webcam c270 */
 	case USB_ID(0x046d, 0x0826): /* HD Webcam c525 */
+	case USB_ID(0x046d, 0x08ca): /* Logitech Quickcam Fusion */
 	case USB_ID(0x046d, 0x0991):
 	/* Most audio usb devices lie about volume resolution.
 	 * Most Logitech webcams have res = 384.
-- 
2.1.4
