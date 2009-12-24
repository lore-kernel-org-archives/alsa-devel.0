From: John S Gruber <johnsgruber@gmail.com>
Subject: Re: [PATCH - usb/usbaudio.c 1/1] sound/usb: Relax urb
	data align. restriction for HVR-950Q and HVR-850 only
Date: Wed, 23 Dec 2009 23:38:09 -0500
Message-ID: <44c6f3de0912232038h3adb73e1wdd03434e4d8b2c7d@mail.gmail.com>
References: <44c6f3de0912131651y7fc6a0el4d3c9f20cb18873b@mail.gmail.com>
	<4B28A659.6070303@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 9027E103802
	for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2009 05:38:29 +0100 (CET)
Received: by bwz9 with SMTP id 9so11846278bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 20:38:29 -0800 (PST)
In-Reply-To: <4B28A659.6070303@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

[PATCH 2/2] sound: usb-audio: relax urb data align. restriction
HVR-950Q and HVR-850 only

Detect the HVR-950Q HVR-850 urb data alignment quirk using usbquirk.h
rather than using a case statement in snd_usb_audio_probe.

Signed-off-by: John S. Gruber <JohnSGruber@gmail.com>
---
 usb/usbaudio.c  |   30 +++++++-------
 usb/usbaudio.h  |    1 +
 usb/usbquirks.h |  114 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 15 deletions(-)

diff --git a/usb/usbaudio.c b/usb/usbaudio.c
index 8618be2..1f93a47 100644
--- a/usb/usbaudio.c
+++ b/usb/usbaudio.c
@@ -3240,6 +3240,18 @@ static int ignore_interface_quirk(struct
snd_usb_audio *chip,
 	return 0;
 }

+/*
+ * Allow alignment on audio sub-slot (channel samples) rather than
+ * on audio slots (audio frames)
+ */
+static int create_align_transfer_quirk(struct snd_usb_audio *chip,
+				  struct usb_interface *iface,
+				  const struct snd_usb_audio_quirk *quirk)
+{
+	chip->txfr_quirk = 1;
+	return 1;	/* Continue with creating streams and mixer */
+}
+

 /*
  * boot quirks
@@ -3415,7 +3427,8 @@ static int snd_usb_create_quirk(struct
snd_usb_audio *chip,
 		[QUIRK_AUDIO_FIXED_ENDPOINT] = create_fixed_stream_quirk,
 		[QUIRK_AUDIO_EDIROL_UA1000] = create_ua1000_quirk,
 		[QUIRK_AUDIO_EDIROL_UA101] = create_ua101_quirk,
-		[QUIRK_AUDIO_EDIROL_UAXX] = create_uaxx_quirk
+		[QUIRK_AUDIO_EDIROL_UAXX] = create_uaxx_quirk,
+		[QUIRK_AUDIO_ALIGN_TRANSFER] = create_align_transfer_quirk
 	};

 	if (quirk->type < QUIRK_TYPE_COUNT) {
@@ -3669,20 +3682,7 @@ static void *snd_usb_audio_probe(struct usb_device *dev,
 		}
 	}

-	switch (chip->usb_id) {
-	case USB_ID(0x2040, 0x7200): /* Hauppage hvr950Q */
-	case USB_ID(0x2040, 0x7221): /* Hauppage hvr950Q */
-	case USB_ID(0x2040, 0x7222): /* Hauppage hvr950Q */
-	case USB_ID(0x2040, 0x7223): /* Hauppage hvr950Q */
-	case USB_ID(0x2040, 0x7224): /* Hauppage hvr950Q */
-	case USB_ID(0x2040, 0x7225): /* Hauppage hvr950Q */
-	case USB_ID(0x2040, 0x7230): /* Hauppage hvr850 */
-	case USB_ID(0x2040, 0x7250): /* Hauppage hvr950Q */
-		chip->txfr_quirk = 1;
-		break;
-	default:
-		chip->txfr_quirk = 0;
-		}
+	chip->txfr_quirk = 0;
 	err = 1; /* continue */
 	if (quirk && quirk->ifnum != QUIRK_NO_INTERFACE) {
 		/* need some special handlings */
diff --git a/usb/usbaudio.h b/usb/usbaudio.h
index f48742d..6aa26d1 100644
--- a/usb/usbaudio.h
+++ b/usb/usbaudio.h
@@ -162,6 +162,7 @@ enum quirk_type {
 	QUIRK_AUDIO_EDIROL_UA1000,
 	QUIRK_AUDIO_EDIROL_UA101,
 	QUIRK_AUDIO_EDIROL_UAXX,
+	QUIRK_AUDIO_ALIGN_TRANSFER,

 	QUIRK_TYPE_COUNT
 };
diff --git a/usb/usbquirks.h b/usb/usbquirks.h
index a892bda..e58f959 100644
--- a/usb/usbquirks.h
+++ b/usb/usbquirks.h
@@ -2105,6 +2105,120 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },

+/* Hauppauge HVR-950Q and HVR-850 */
+{
+	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7200),
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
+		       USB_DEVICE_ID_MATCH_INT_CLASS |
+		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+	.bInterfaceClass = USB_CLASS_AUDIO,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL,
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "Hauppauge",
+		.product_name = "HVR-950Q",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_AUDIO_ALIGN_TRANSFER,
+	}
+},
+{
+	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7201),
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
+		       USB_DEVICE_ID_MATCH_INT_CLASS |
+		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+	.bInterfaceClass = USB_CLASS_AUDIO,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL,
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "Hauppauge",
+		.product_name = "HVR-950Q",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_AUDIO_ALIGN_TRANSFER,
+	}
+},
+{
+	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7202),
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
+		       USB_DEVICE_ID_MATCH_INT_CLASS |
+		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+	.bInterfaceClass = USB_CLASS_AUDIO,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL,
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "Hauppauge",
+		.product_name = "HVR-950Q",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_AUDIO_ALIGN_TRANSFER,
+	}
+},
+{
+	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7203),
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
+		       USB_DEVICE_ID_MATCH_INT_CLASS |
+		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+	.bInterfaceClass = USB_CLASS_AUDIO,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL,
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "Hauppauge",
+		.product_name = "HVR-950Q",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_AUDIO_ALIGN_TRANSFER,
+	}
+},
+{
+	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7204),
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
+		       USB_DEVICE_ID_MATCH_INT_CLASS |
+		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+	.bInterfaceClass = USB_CLASS_AUDIO,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL,
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "Hauppauge",
+		.product_name = "HVR-950Q",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_AUDIO_ALIGN_TRANSFER,
+	}
+},
+{
+	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7205),
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
+		       USB_DEVICE_ID_MATCH_INT_CLASS |
+		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+	.bInterfaceClass = USB_CLASS_AUDIO,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL,
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "Hauppauge",
+		.product_name = "HVR-950Q",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_AUDIO_ALIGN_TRANSFER,
+	}
+},
+{
+	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7250),
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
+		       USB_DEVICE_ID_MATCH_INT_CLASS |
+		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+	.bInterfaceClass = USB_CLASS_AUDIO,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL,
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "Hauppauge",
+		.product_name = "HVR-950Q",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_AUDIO_ALIGN_TRANSFER,
+	}
+},
+{
+	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7230),
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
+		       USB_DEVICE_ID_MATCH_INT_CLASS |
+		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+	.bInterfaceClass = USB_CLASS_AUDIO,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL,
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "Hauppauge",
+		.product_name = "HVR-850",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_AUDIO_ALIGN_TRANSFER,
+	}
+},
+
 {
 	/*
 	 * Some USB MIDI devices don't have an audio control interface,
-- 
1.6.3.3
