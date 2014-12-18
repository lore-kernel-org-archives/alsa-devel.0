From: Jiri Jaburek <jjaburek@redhat.com>
Subject: [PATCH] ALSA: usb-audio: extend KEF X300A FU 10 tweak to Arcam rPAC
Date: Thu, 18 Dec 2014 02:03:19 +0100
Message-ID: <1418864599-7092-1-git-send-email-jjaburek@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The Arcam rPAC seems to have the same problem - whenever anything
(alsamixer, udevd, 3.9+ kernel from 60af3d037eb8c, ..) attempts to
access mixer / control interface of the card, the firmware "locks up"
the entire device, resulting in
  SNDRV_PCM_IOCTL_HW_PARAMS failed (-5): Input/output error
from alsa-lib.

Other operating systems can somehow read the mixer (there seems to be
playback volume/mute), but any manipulation is ignored by the device
(which has hardware volume controls).

Cc: <stable@vger.kernel.org>
Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
---
 sound/usb/mixer_maps.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 1994d41..b703cb3 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -333,8 +333,11 @@ static struct usbmix_name_map gamecom780_map[] = {
 	{}
 };
 
-static const struct usbmix_name_map kef_x300a_map[] = {
-	{ 10, NULL }, /* firmware locks up (?) when we try to access this FU */
+/* some (all?) SCMS USB3318 devices are affected by a firmware lock up
+ * when anything attempts to access FU 10 (control)
+ */
+static const struct usbmix_name_map scms_usb3318_map[] = {
+	{ 10, NULL },
 	{ 0 }
 };
 
@@ -434,8 +437,14 @@ static struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.map = ebox44_map,
 	},
 	{
+		/* KEF X300A */
 		.id = USB_ID(0x27ac, 0x1000),
-		.map = kef_x300a_map,
+		.map = scms_usb3318_map,
+	},
+	{
+		/* Arcam rPAC */
+		.id = USB_ID(0x25c4, 0x0003),
+		.map = scms_usb3318_map,
 	},
 	{ 0 } /* terminator */
 };
-- 
2.1.0
