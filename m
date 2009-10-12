From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] Add match for JMTek USB sound card
Date: Mon, 12 Oct 2009 08:42:40 +0200
Message-ID: <1255329761-24449-1-git-send-email-lkundrak@v3.sk>
References: <s5hbpkdf7ft.wl%tiwai@suse.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754224AbZJLGxv@vger.kernel.org>
In-Reply-To: <s5hbpkdf7ft.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: alsa-devel@alsa-project.org

Entry for JMTek LLC., SSS USB Headphone Set in the quirk table.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 sound/usb/usbquirks.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/sound/usb/usbquirks.h b/sound/usb/usbquirks.h
index f6f201e..e98ff4c 100644
--- a/sound/usb/usbquirks.h
+++ b/sound/usb/usbquirks.h
@@ -80,6 +80,19 @@
 	.bInterfaceClass = USB_CLASS_AUDIO,
 },
 
+/* JMTek, LLC. SSS USB Headphone Set */
+{
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
+		       USB_DEVICE_ID_MATCH_DEV_CLASS |
+		       USB_DEVICE_ID_MATCH_INT_CLASS |
+		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+	.idVendor = 0x0c76,
+	.idProduct = 0x1605,
+	.bDeviceClass = USB_CLASS_PER_INTERFACE,
+	.bInterfaceClass = USB_CLASS_AUDIO,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL
+},
+
 /*
  * Logitech QuickCam: bDeviceClass is vendor-specific, so generic interface
  * class matches do not take effect without an explicit ID match.
-- 
1.6.2.5
