From: Eric Lammerts <alsa-devel@lists.lammerts.org>
Subject: [PATCH] cm6206: turn off de-emphasis in s/pdif
Date: Tue, 16 Nov 2010 19:22:37 -0500 (EST)
Message-ID: <Pine.LNX.4.61.1011161859260.551@kermit.ultrawaves>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.ultrawaves.com (rrcs-71-43-195-114.se.biz.rr.com
	[71.43.195.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 49DFE10381B
	for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2010 01:22:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Dan Allongo <gongo2k1@gmail.com>
List-Id: alsa-devel@alsa-project.org


Hi,
I just bought a device with a CM6206. Thank you for the quirk that 
made it work out-of-the-box! I noticed on my DAC that the de-emphasis 
LED was on. Is this by accident? Below is a patch (based on the info 
in the CM6206+datasheet+1.7.pdf that I found somewhere) that turns it 
off.

cheers,

Eric


Index: linux-2.6.36/sound/usb/quirks.c
===================================================================
--- linux-2.6.36.orig/sound/usb/quirks.c	2010-11-16 18:55:51.000000000 -0500
+++ linux-2.6.36/sound/usb/quirks.c	2010-11-16 18:55:57.000000000 -0500
@@ -387,7 +387,7 @@
  static int snd_usb_cm6206_boot_quirk(struct usb_device *dev)
  {
  	int err, reg;
-	int val[] = {0x200c, 0x3000, 0xf800, 0x143f, 0x0000, 0x3000};
+	int val[] = {0x2004, 0x3000, 0xf800, 0x143f, 0x0000, 0x3000};

  	for (reg = 0; reg < ARRAY_SIZE(val); reg++) {
  		err = snd_usb_cm106_write_int_reg(dev, reg, val[reg]);
