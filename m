From: johnsgruber@gmail.com
Subject: [PATCH 3/3] sound: usb-audio: relax urb data align.
	restriction HVR-950Q and HVR-850 only
Date: Sun, 27 Dec 2009 12:19:59 -0500
Message-ID: <4b379790.9653f10a.5e5e.ffffdb82@mx.google.com>
References: <s5hy6krtc1r.wl%tiwai@suse.de>
	<1261934399-2820-1-git-send-email-me>
	<1261934399-2820-2-git-send-email-me>
	<1261934399-2820-3-git-send-email-me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1261934399-2820-3-git-send-email-me>
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
Cc: patch@alsa-project.org, "John S. Gruber" <JohnSGruber@gmail.com>, johnsgruber@gmail.com
List-Id: alsa-devel@alsa-project.org

From: John S. Gruber <JohnSGruber@gmail.com>

Detect the HVR-950Q HVR-850 urb data alignment quirk using usbquirk.h
rather than using a case statement in snd_usb_audio_probe.

Signed-off-by: John S. Gruber <JohnSGruber@gmail.com>
---
 sound/usb/usbaudio.c  |   30 ++++++------
 sound/usb/usbaudio.h  |    1 +
 sound/usb/usbquirks.h |  114 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 15 deletions(-)

diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index be6f017..0cfff95 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -3152,6 +3152,18 @@ static int ignore_interface_quirk(struct snd_usb_audio *chip,
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
@@ -3326,7 +3338,8 @@ static int snd_usb_create_quirk(struct snd_usb_audio *chip,
 		[QUIRK_AUDIO_STANDARD_INTERFACE] = create_standard_audio_quirk,
 		[QUIRK_AUDIO_FIXED_ENDPOINT] = create_fixed_stream_quirk,
 		[QUIRK_AUDIO_EDIROL_UA1000] = create_ua1000_quirk,
-		[QUIRK_AUDIO_EDIROL_UAXX] = create_uaxx_quirk
+		[QUIRK_AUDIO_EDIROL_UAXX] = create_uaxx_quirk,
+		[QUIRK_AUDIO_ALIGN_TRANSFER] = create_align_transfer_quirk
 	};
 
 	if (quirk->type < QUIRK_TYPE_COUNT) {
@@ -3580,20 +3593,7 @@ static void *snd_usb_audio_probe(struct usb_device *dev,
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
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 228da06..9c88f60 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -161,6 +161,7 @@ enum quirk_type {
 	QUIRK_AUDIO_FIXED_ENDPOINT,
 	QUIRK_AUDIO_EDIROL_UA1000,
 	QUIRK_AUDIO_EDIROL_UAXX,
+	QUIRK_AUDIO_ALIGN_TRANSFER,
 
 	QUIRK_TYPE_COUNT
 };
diff --git a/sound/usb/usbquirks.h b/sound/usb/usbquirks.h
index bd6706c..65bbd22 100644
--- a/sound/usb/usbquirks.h
+++ b/sound/usb/usbquirks.h
@@ -2074,6 +2074,120 @@ YAMAHA_DEVICE(0x7010, "UB99"),
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
