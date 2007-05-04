From: Daniel Drake <dsd@gentoo.org>
Subject: [PATCH] snd-usb-audio: Add another QuickCam ID
Date: Fri,  4 May 2007 02:28:44 +0100 (BST)
Message-ID: <20070504012844.955347B409F@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mtaout03-winn.ispmail.ntl.com (mtaout03-winn.ispmail.ntl.com
	[81.103.221.49]) by alsa0.perex.cz (Postfix) with ESMTP id 7A54B243D7
	for <alsa-devel@alsa-project.org>;
	Fri,  4 May 2007 03:28:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This adds another Logitech QuickCam USB ID. These devices have vendor-specific
device class values, but standards-compliant audio interfaces.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

Index: linux/sound/usb/usbquirks.h
===================================================================
--- linux.orig/sound/usb/usbquirks.h
+++ linux/sound/usb/usbquirks.h
@@ -53,6 +53,16 @@
 	.bInterfaceClass = USB_CLASS_AUDIO,
 	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL
 },
+{
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
+		       USB_DEVICE_ID_MATCH_INT_CLASS |
+		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+	.idVendor = 0x046d,
+	.idProduct = 0x08f6,
+	.bInterfaceClass = USB_CLASS_AUDIO,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL
+},
+
 
 /*
  * Yamaha devices
