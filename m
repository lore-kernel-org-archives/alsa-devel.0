From: Daniel Drake <dsd@gentoo.org>
Subject: [PATCH] usb-audio: another Logitech camera/microphone
	ID match
Date: Mon,  9 Jul 2007 03:19:12 +0100 (BST)
Message-ID: <20070709021912.8F7BB7B409F@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mtaout01-winn.ispmail.ntl.com (mtaout01-winn.ispmail.ntl.com
	[81.103.221.47]) by alsa0.perex.cz (Postfix) with ESMTP id B1C1C24445
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jul 2007 04:19:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, george@gentoo.org
List-Id: alsa-devel@alsa-project.org

From: George Shapovalov <george@gentoo.org>

Another case of ALSA ticket #3040: we need an explicit USB ID match for
another Logitech camera/microphone device.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

Index: linux/sound/usb/usbquirks.h
===================================================================
--- linux.orig/sound/usb/usbquirks.h
+++ linux/sound/usb/usbquirks.h
@@ -57,6 +57,15 @@
 		       USB_DEVICE_ID_MATCH_INT_CLASS |
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
 	.idVendor = 0x046d,
+	.idProduct = 0x08ae,
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
