From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: [PATCH 2/3] sound: simplify au0828 quirk table
Date: Sat, 14 Jun 2014 13:16:10 -0300
Message-ID: <1402762571-6316-3-git-send-email-m.chehab@samsung.com>
References: <1402762571-6316-1-git-send-email-m.chehab@samsung.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1402762571-6316-1-git-send-email-m.chehab@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mauro Carvalho Chehab <m.chehab@samsung.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add a macro to simplify au0828 quirk table. That makes easier
to check it against the USB IDs at drivers/media/usb/au0828-card.c

Cc: stable@vger.kernel.org
Signed-off-by: Mauro Carvalho Chehab <m.chehab@samsung.com>
---
 sound/usb/quirks-table.h | 159 ++++++++++-------------------------------------
 1 file changed, 32 insertions(+), 127 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 236adf61d27a..30add0bfee8e 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -232,6 +232,7 @@
  * Yamaha devices
  */
 
+
 #define YAMAHA_DEVICE(id, name) { \
 	USB_DEVICE(0x0499, id), \
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) { \
@@ -2745,133 +2746,37 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 
-/* Hauppauge HVR-950Q and HVR-850 */
-{
-	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7200),
-	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
-		       USB_DEVICE_ID_MATCH_INT_CLASS |
-		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
-	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.vendor_name = "Hauppauge",
-		.product_name = "HVR-950Q",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_AUDIO_AUVITEK_0828,
-	}
-},
-{
-	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7210),
-	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
-		       USB_DEVICE_ID_MATCH_INT_CLASS |
-		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
-	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.vendor_name = "Hauppauge",
-		.product_name = "HVR-950Q",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_AUDIO_AUVITEK_0828,
-	}
-},
-{
-	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7217),
-	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
-		       USB_DEVICE_ID_MATCH_INT_CLASS |
-		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
-	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.vendor_name = "Hauppauge",
-		.product_name = "HVR-950Q",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_AUDIO_AUVITEK_0828,
-	}
-},
-{
-	USB_DEVICE_VENDOR_SPEC(0x2040, 0x721b),
-	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
-		       USB_DEVICE_ID_MATCH_INT_CLASS |
-		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
-	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.vendor_name = "Hauppauge",
-		.product_name = "HVR-950Q",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_AUDIO_AUVITEK_0828,
-	}
-},
-{
-	USB_DEVICE_VENDOR_SPEC(0x2040, 0x721e),
-	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
-		       USB_DEVICE_ID_MATCH_INT_CLASS |
-		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
-	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.vendor_name = "Hauppauge",
-		.product_name = "HVR-950Q",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_AUDIO_AUVITEK_0828,
-	}
-},
-{
-	USB_DEVICE_VENDOR_SPEC(0x2040, 0x721f),
-	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
-		       USB_DEVICE_ID_MATCH_INT_CLASS |
-		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
-	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.vendor_name = "Hauppauge",
-		.product_name = "HVR-950Q",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_AUDIO_AUVITEK_0828,
-	}
-},
-{
-	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7240),
-	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
-		       USB_DEVICE_ID_MATCH_INT_CLASS |
-		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
-	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.vendor_name = "Hauppauge",
-		.product_name = "HVR-850",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_AUDIO_AUVITEK_0828,
-	}
-},
-{
-	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7280),
-	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
-		       USB_DEVICE_ID_MATCH_INT_CLASS |
-		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
-	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.vendor_name = "Hauppauge",
-		.product_name = "HVR-950Q",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_AUDIO_AUVITEK_0828,
-	}
-},
-{
-	USB_DEVICE_VENDOR_SPEC(0x0fd9, 0x0008),
-	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
-		       USB_DEVICE_ID_MATCH_INT_CLASS |
-		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
-	.bInterfaceClass = USB_CLASS_AUDIO,
-	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.vendor_name = "Hauppauge",
-		.product_name = "HVR-950Q",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_AUDIO_AUVITEK_0828,
-	}
-},
+/*
+ * Auvitek au0828 devices with audio interface.
+ * This should be kept in sync with drivers/media/usb/au0828-card.c
+ * Please notice that some drivers are DVB only, and don't need to be
+ * here. That's the case, for example, of DVICO_FUSIONHDTV7.
+ */
+
+#define AU0828_DEVICE(vid, pid, vname, pname) { \
+	USB_DEVICE_VENDOR_SPEC(vid, pid), \
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE | \
+		       USB_DEVICE_ID_MATCH_INT_CLASS | \
+		       USB_DEVICE_ID_MATCH_INT_SUBCLASS, \
+	.bInterfaceClass = USB_CLASS_AUDIO, \
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL, \
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) { \
+		.vendor_name = vname, \
+		.product_name = pname, \
+		.ifnum = QUIRK_ANY_INTERFACE, \
+		.type = QUIRK_AUDIO_AUVITEK_0828, \
+	} \
+}
+
+AU0828_DEVICE(0x2040, 0x7200, "Hauppauge", "HVR-950Q"),
+AU0828_DEVICE(0x2040, 0x7210, "Hauppauge", "HVR-950Q"),
+AU0828_DEVICE(0x2040, 0x7217, "Hauppauge", "HVR-950Q"),
+AU0828_DEVICE(0x2040, 0x721b, "Hauppauge", "HVR-950Q"),
+AU0828_DEVICE(0x2040, 0x721e, "Hauppauge", "HVR-950Q"),
+AU0828_DEVICE(0x2040, 0x721f, "Hauppauge", "HVR-950Q"),
+AU0828_DEVICE(0x2040, 0x7240, "Hauppauge", "HVR-850"),
+AU0828_DEVICE(0x2040, 0x7280, "Hauppauge", "HVR-950Q"),
+AU0828_DEVICE(0x0fd9, 0x0008, "Hauppauge", "HVR-950Q"),
 
 /* Digidesign Mbox */
 {
-- 
1.9.3
