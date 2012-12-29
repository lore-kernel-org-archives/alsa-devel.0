From: Alexander Schremmer <alex@alexanderweb.de>
Subject: [PATCH] sound: Add support for Creative BT-D1 via usb sound quirks
Date: Sat, 29 Dec 2012 14:26:25 +0100
Message-ID: <50DEEF81.40008@alexanderweb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Alexander Schremmer <alex@alexanderweb.de>

Support the Creative BT-D1 Bluetooth USB audio device. Before this
patch, Linux had trouble finding the correct USB descriptors and bailed
out with these messages:

 no or invalid class specific endpoint descriptor

Now it still prints these messages on hotplug:

 snd-usb-audio: probe of ...:1.0 failed with error -5
 snd-usb-audio: probe of ...:1.2 failed with error -5
 snd-usb-audio: probe of ...:1.3 failed with error -5

But the device works correctly, including the HID support.

The patch is diff'ed against 3.8-rc1 but should apply to older kernels
as well.

Signed-off-by: Alexander Schremmer <alex@alexanderweb.de>

---
diff -uprN linux-3.8-rc1/sound/usb/quirks-table.h
linux-3.8-rc1-mod/sound/usb/quirks-table.h
--- linux-3.8-rc1/sound/usb/quirks-table.h      2012-12-22
02:19:00.000000000 +0100
+++ linux-3.8-rc1-mod/sound/usb/quirks-table.h  2012-12-26
11:41:28.000000000 +0100
@@ -50,6 +50,28 @@
        }
 },

+{
+       /* Creative BT-D1 */
+       USB_DEVICE(0x041e, 0x0005),
+       .driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+               .ifnum = 1,
+               .type = QUIRK_AUDIO_FIXED_ENDPOINT,
+               .data = &(const struct audioformat) {
+                       .formats = SNDRV_PCM_FMTBIT_S16_LE,
+                       .channels = 2,
+                       .iface = 1,
+                       .altsetting = 1,
+                       .altset_idx = 1,
+                       .endpoint = 0x03,
+                       .ep_attr = USB_ENDPOINT_XFER_ISOC,
+                       .attributes = 0,
+                       .rates = SNDRV_PCM_RATE_CONTINUOUS,
+                       .rate_min = 48000,
+                       .rate_max = 48000,
+               }
+       }
+},
+
 /* Creative/Toshiba Multimedia Center SB-0500 */
 {
        USB_DEVICE(0x041e, 0x3048),
