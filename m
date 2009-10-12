From: Tobias Hansen <Tobias.Hansen@physik.uni-hamburg.de>
Subject: [PATCH] snd-usb-us122l: corrent error number for not
 probing US-144 on ehci-hcd
Date: Mon, 12 Oct 2009 16:24:15 +0200
Message-ID: <4AD33C0F.7080003@physik.uni-hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.physnet.uni-hamburg.de (MAIL.PHYSnet.uni-hamburg.de
	[134.100.106.230])
	by alsa0.perex.cz (Postfix) with ESMTP id E44992434E
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Oct 2009 16:24:14 +0200 (CEST)
References: 4AB8E498.1070108@physik.uni-hamburg.de
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd-usb-us122l: corrent error number for not probing US-144 on ehci-hcd
This is the correct error number for telling the USB system that this 
driver is not for the device.

Signed-off-by: Tobias Hansen <Tobias.Hansen@physik.uni-hamburg.de>
---

--- us122l.c.orig    2009-10-12 08:46:01.000000000 +0200
+++ us122l.c    2009-10-12 14:51:05.255040655 +0200
@@ -601,7 +601,7 @@ static int snd_us122l_probe(struct usb_i
     if (device->descriptor.idProduct == USB_ID_US144
         && device->speed == USB_SPEED_HIGH) {
         snd_printk(KERN_ERR "disable ehci-hcd to run US-144 \n");
-        return -ENOENT;
+        return -ENODEV;
     }
 
     snd_printdd(KERN_DEBUG"%p:%i\n",
