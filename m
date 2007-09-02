From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH] Support Rane SL 1 (aka. Serato Scratch Live)
	interface
Date: Sun, 2 Sep 2007 15:00:04 +0100 (BST)
Message-ID: <alpine.BSO.0.9999.0709021447440.32425@metheny.ijneb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metheny.ijneb.com (mailout.ijneb.com [212.13.201.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D38524380
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Sep 2007 16:00:05 +0200 (CEST)
Received: from localhost ([127.0.0.1] ident=mark)
	by metheny.ijneb.com with esmtp (Exim 4.62)
	(envelope-from <mark@pogo.org.uk>) id 1IRpzg-0004DP-PR
	for alsa-devel@alsa-project.org; Sun, 02 Sep 2007 15:00:04 +0100
Content-ID: <alpine.BSO.0.9999.0709021455571.32425@metheny.ijneb.com>
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

Support Rane SL 1 (aka. Serato Scratch Live) interface

This quirk ensures the SL 1 interface is detected and can be used. The 
interface is USB and is supplied with the Serato Scratch Live system for 
DJs.

Signed-off-by: Mark Hills <mark@pogo.org.uk>

--- alsa-driver-1.0.15rc1/sound/usb/usbquirks.h	Thu Aug 30 09:27:00 2007
+++ alsa-driver/sound/usb/usbquirks.h	Sun Sep  2 14:55:00 2007
@@ -1748,6 +1748,16 @@ YAMAHA_DEVICE(0x7010, "UB99"),
  	}
  },

+/* Rane SL 1 (aka. Serato Scratch Live) device */
+{
+	USB_DEVICE(0x13e5, 0x0001),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.vendor_name = "Rane",
+		.product_name = "SL-1",
+		.ifnum = QUIRK_NO_INTERFACE
+	}
+},
+
  /* Novation EMS devices */
  {
  	USB_DEVICE_VENDOR_SPEC(0x1235, 0x0001),
