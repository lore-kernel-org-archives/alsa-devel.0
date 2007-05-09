From: Daniel Drake <dsd@gentoo.org>
Subject: [PATCH] snd-usb-audio: Another Logitech QuickCam ID
Date: Thu, 10 May 2007 00:17:16 +0100 (BST)
Message-ID: <20070509231716.BBC5C7B409F@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mtaout03-winn.ispmail.ntl.com (mtaout03-winn.ispmail.ntl.com
	[81.103.221.49]) by alsa0.perex.cz (Postfix) with ESMTP id 36D98244D0
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 01:17:12 +0200 (CEST)
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
	by mtaout03-winn.ispmail.ntl.com with ESMTP id
	<20070509231711.JALR16175.mtaout03-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2007 00:17:11 +0100
Received: from zog.reactivated.net ([86.14.211.88])
	by aamtaout03-winn.ispmail.ntl.com with ESMTP id
	<20070509231711.ZNGF26699.aamtaout03-winn.ispmail.ntl.com@zog.reactivated.net>
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2007 00:17:11 +0100
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
List-Id: alsa-devel@alsa-project.org

This patch adds the ID for another quickcam microphone, reported by freqmod
on ALSA ticket #0003040

I'm going to submit a USB patch separately to provide a macro to simplify these
entries, as suggested by Alan Stern. We could switch to using that in future.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

Index: linux/sound/usb/usbquirks.h
===================================================================
--- linux.orig/sound/usb/usbquirks.h
+++ linux/sound/usb/usbquirks.h
@@ -49,6 +49,15 @@
 		       USB_DEVICE_ID_MATCH_INT_CLASS |
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
 	.idVendor = 0x046d,
+	.idProduct = 0x0850,
+	.bInterfaceClass = USB_CLASS_AUDIO,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL
+},
+{
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
+		       USB_DEVICE_ID_MATCH_INT_CLASS |
+		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+	.idVendor = 0x046d,
 	.idProduct = 0x08f0,
 	.bInterfaceClass = USB_CLASS_AUDIO,
 	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL
