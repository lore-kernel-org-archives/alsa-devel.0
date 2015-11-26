From: shal@free.fr
Subject: Sound UsbPre : minimal patch for support
Date: Thu, 26 Nov 2015 21:28:57 +0100 (CET)
Message-ID: <1805025243.580922365.1448569737961.JavaMail.root@spooler2-g27.priv.proxad.net>
References: <2021858721.580826702.1448568518907.JavaMail.root@spooler2-g27.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E37626058A
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 21:28:59 +0100 (CET)
Received: from spooler2-g27.priv.proxad.net (unknown [172.20.243.240])
 by smtp3-g21.free.fr (Postfix) with ESMTP id 7560AA620B
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 21:28:30 +0100 (CET)
In-Reply-To: <2021858721.580826702.1448568518907.JavaMail.root@spooler2-g27.priv.proxad.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I have a Sound UsbPre (the first not the UsbPRe2) sound card.
There is no support for this card in alsa.
I do a usb packet sniffing on Windows for detect problem.
Some control quirk should be added at boot in order to use the card.

It works to play and record in 44100 khz.
It works only with 44100khz (for example, if you play a 88200 file, it will be played too slow).
This patch is not well tested, work on my desktop : Linux Ubuntu with 4.2.19-lowlatency kernel.

The button emulation is not done (by a control packet, you can change the card configuration, like phantom power activation).
If somebody is interested, I can provide needed information.

If Alsa's developer is interested, I can provide support for test patches or develop a second version of this patch in order to integrate the support for this card in the linux kernel 

Regards,
Olivier


linux-source-4.2.0/sound/usb$ diff -rub quirks.c.ORIG quirks.c 
--- quirks.c.ORIG	2015-11-24 22:43:16.878635155 +0100
+++ quirks.c	2015-11-26 20:56:09.492126460 +0100
@@ -601,6 +601,40 @@
 	return 0;
 }
 
+/* Add some control messages needed by Sound Devices UsbPre. 
+ * Values here are chosen based on sniffing USB traffic
+ * under Windows.*/
+static int snd_usb_usbpre_boot_quirk(struct usb_device *dev)
+{
+    u8 buf = 1;
+    u8 data1[1] = {0x81};
+    u8 data2[1] = {0xc1};
+    u8 data3[3] = {0x44,0xac,0x00};
+
+	snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), 1,
+				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+				0x00f0, 496, data1, 1);
+	snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), 0x81 ,
+			    USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			    0x00f0, 0, &buf, 1);		
+	if (buf == 0) {
+		return -ENODEV;
+	}
+	snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), 1,
+				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+				0x00f0, 496, data2, 1);
+	snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), 0x81 ,
+			    USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			    0x00f0, 0, &buf, 1);		
+	if (buf == 0) {
+		return -ENODEV;
+	}
+	snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), 1,
+				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_ENDPOINT,
+				0x0100, 133, data3, 3);
+	return 0;
+}
+
 static int snd_usb_fasttrackpro_boot_quirk(struct usb_device *dev)
 {
 	int err;
@@ -985,6 +1019,10 @@
 		/* SB Audigy 2 NX needs its own boot-up magic, too */
 		return snd_usb_audigy2nx_boot_quirk(dev);
 
+	case USB_ID(0x0926, 0x0100):
+		/* Sound Devices UsbPre needs its own boot-up magic, too */
+		return snd_usb_usbpre_boot_quirk(dev);
+
 	case USB_ID(0x10f5, 0x0200):
 		/* C-Media CM106 / Turtle Beach Audio Advantage Roadie */
 		return snd_usb_cm106_boot_quirk(dev);
