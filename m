From: John S Gruber <johnsgruber@gmail.com>
Subject: [PATCH] Correct audio problem for Hauppage HVR-850 and
	others rel. to urb data align.
Date: Sun,  1 Aug 2010 09:53:37 -0400
Message-ID: <1280670817-2736-1-git-send-email-JohnSGruber@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id 733622433E
	for <alsa-devel@alsa-project.org>;
	Sun,  1 Aug 2010 15:54:23 +0200 (CEST)
Received: by qwi2 with SMTP id 2so1054129qwi.38
	for <alsa-devel@alsa-project.org>; Sun, 01 Aug 2010 06:54:22 -0700 (PDT)
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
Cc: John S Gruber <JohnSGruber@gmail.com>
List-Id: alsa-devel@alsa-project.org

Match usb ids in usb/quirks-table.h for some Hauppage HVR-950Q models
and for the HVR850 model to those ids at the end of au0828-cards.c

Thanks to nhJm449 for pointing out the problem.

Signed-off-by: John S Gruber <JohnSGruber@gmail.com>
---
 sound/usb/quirks-table.h |   30 ++++++++++++++++++++++--------
 1 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index f8797f6..2e8003f 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2152,7 +2152,21 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7201),
+	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7240),
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
+		       USB_DEVICE_ID_MATCH_INT_CLASS |
+		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+	.bInterfaceClass = USB_CLASS_AUDIO,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "Hauppauge",
+		.product_name = "HVR-850",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_AUDIO_ALIGN_TRANSFER,
+	}
+},
+{
+	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7210),
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
 		       USB_DEVICE_ID_MATCH_INT_CLASS |
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
@@ -2166,7 +2180,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7202),
+	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7217),
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
 		       USB_DEVICE_ID_MATCH_INT_CLASS |
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
@@ -2180,7 +2194,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7203),
+	USB_DEVICE_VENDOR_SPEC(0x2040, 0x721b),
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
 		       USB_DEVICE_ID_MATCH_INT_CLASS |
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
@@ -2194,7 +2208,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7204),
+	USB_DEVICE_VENDOR_SPEC(0x2040, 0x721e),
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
 		       USB_DEVICE_ID_MATCH_INT_CLASS |
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
@@ -2208,7 +2222,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7205),
+	USB_DEVICE_VENDOR_SPEC(0x2040, 0x721f),
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
 		       USB_DEVICE_ID_MATCH_INT_CLASS |
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
@@ -2222,7 +2236,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7250),
+	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7280),
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
 		       USB_DEVICE_ID_MATCH_INT_CLASS |
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
@@ -2236,7 +2250,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x2040, 0x7230),
+	USB_DEVICE_VENDOR_SPEC(0x0fd9, 0x0008),
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
 		       USB_DEVICE_ID_MATCH_INT_CLASS |
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
@@ -2244,7 +2258,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
 	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "Hauppauge",
-		.product_name = "HVR-850",
+		.product_name = "HVR-950Q",
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_AUDIO_ALIGN_TRANSFER,
 	}
-- 
1.7.0.4
