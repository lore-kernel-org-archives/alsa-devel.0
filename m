From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH] Add quirk for Stanton ScratchAmp v1
Date: Thu, 9 Aug 2007 22:12:08 +0100 (BST)
Message-ID: <Pine.BSO.4.64.0707292305080.12870@metheny.ijneb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metheny.ijneb.com (mailout.ijneb.com [212.13.201.26])
	by alsa0.perex.cz (Postfix) with ESMTP id B4F7010386F
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Aug 2007 23:12:09 +0200 (CEST)
Received: from localhost ([127.0.0.1] ident=mark)
	by metheny.ijneb.com with esmtp (Exim 4.62)
	(envelope-from <mark@pogo.org.uk>) id 1IJFIe-0005bE-I4
	for alsa-devel@alsa-project.org; Thu, 09 Aug 2007 22:12:08 +0100
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

Hello,

This patch is a USB quirk to ensure the Stanton Scratchamp v1 is detected 
(bugtrack #2932). The interface is two USB devices in the same physical 
box. Note that this is the USB ScratchAmp v1 and not the later v2 
(firewire) model.

Signed-off-by: Mark Hills <mark@pogo.org.uk>

diff -r d19ec80205a5 usb/usbquirks.h
--- a/usb/usbquirks.h	Fri Jul 27 19:15:54 2007 +0200
+++ b/usb/usbquirks.h	Sun Jul 29 23:45:00 2007 +0100
@@ -1774,4 +1774,22 @@ YAMAHA_DEVICE(0x7010, "UB99"),
  	}
  },

+/* Stanton/N2IT Final Scratch v1 device ('Scratchamp') */
+{
+	USB_DEVICE(0x103d, 0x0100),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.vendor_name = "Stanton",
+		.product_name = "ScratchAmp",
+		.ifnum = QUIRK_NO_INTERFACE
+	}
+},
+{
+	USB_DEVICE(0x103d, 0x0101),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.vendor_name = "Stanton",
+		.product_name = "ScratchAmp",
+		.ifnum = QUIRK_NO_INTERFACE
+	}
+},
+
  #undef USB_DEVICE_VENDOR_SPEC
