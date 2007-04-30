From: Daniel Drake <dsd@gentoo.org>
Subject: [PATCH] snd-usb-audio: explicitly match Logitech
	QuickCam
Date: Mon, 30 Apr 2007 04:13:00 +0100 (BST)
Message-ID: <20070430031301.206B07B409F@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mtaout01-winn.ispmail.ntl.com (mtaout01-winn.ispmail.ntl.com
	[81.103.221.47]) by alsa0.perex.cz (Postfix) with ESMTP id DA515245B0
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Apr 2007 05:13:07 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, stern@rowland.harvard.edu, linux-usb-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Commit 93c8bf45e083b89dffe3a708363c15c1b220c723 modified the USB device
matching behaviour to ignore interface class matches if the device class
is vendor-specific.

This patch adds an explicit ID match for the Logitech QuickCam Messenger,
which has a vendor specific device class (but standards-compliant audio
interfaces).

This fixes a 2.6.20 regression where the audio component of this device was
no longer usable.

http://bugs.gentoo.org/show_bug.cgi?id=175715
https://bugs.launchpad.net/ubuntu/+source/linux-source-2.6.20/+bug/93822
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3040

Based on a patch from sergiom

Signed-off-by: Daniel Drake <dsd@gentoo.org>

Index: linux/sound/usb/usbquirks.h
===================================================================
--- linux.orig/sound/usb/usbquirks.h
+++ linux/sound/usb/usbquirks.h
@@ -40,6 +40,21 @@
 	.bInterfaceClass = USB_CLASS_VENDOR_SPEC
 
 /*
+ * Logitech QuickCam: bDeviceClass is vendor-specific, so generic interface
+ * class matches do not take effect without an explicit ID match.
+ */
+
+{
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
+		       USB_DEVICE_ID_MATCH_INT_CLASS |
+		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+	.idVendor = 0x046d,
+	.idProduct = 0x08f0,
+	.bInterfaceClass = USB_CLASS_AUDIO,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIO_CONTROL
+},
+
+/*
  * Yamaha devices
  */
