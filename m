From: Chris J Arges <christopherarges@gmail.com>
Subject: [PATCH] ALSA: usb-audio: Add quirk for Focusrite Scarlett 18i8
Date: Wed, 17 Jul 2013 16:12:12 -0500
Message-ID: <1374095558-9949-1-git-send-email-christopherarges@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: martin@meltin.net, Chris J Arges <christopherarges@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Eldad Zack <eldad@fogrefinery.com>, Trulan Martin <trulanm@gmail.com>, Damien Zammit <damien@zamaudio.com>, Mark Hills <mark@xwax.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch is similar to commit 1762a59d8e8b5e99f6f4a0f292b40f3cacb108ba.
The same non-standard interface descriptor causes snd_usb_create_mixer()
to fail for the Focusrite Scarlett 18i8 as well.

Signed-off-by: Chris J Arges <christopherarges@gmail.com>
---
 sound/usb/quirks-table.h |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 7f1585b..b954ec5 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3232,6 +3232,52 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
+{
+	/*
+	 * Focusrite Scarlett 18i8
+	 *
+	 * Avoid mixer creation similar to the Scarlett 18i6 interface.
+	 */
+	USB_DEVICE(0x1235, 0x8014),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.vendor_name = "Focusrite",
+		.product_name = "Scarlett 18i8",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = & (const struct snd_usb_audio_quirk[]) {
+			{
+				/* InterfaceSubClass 1 (Control Device) */
+				.ifnum = 0,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				/* InterfaceSubClass 1 (Control Device) */
+				.ifnum = 3,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = 4,
+				.type = QUIRK_MIDI_STANDARD_INTERFACE
+			},
+			{
+				/* InterfaceSubClass 1 (Device Firmware Update) */
+				.ifnum = 5,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 
 {
 	/*
-- 
1.7.9.5
