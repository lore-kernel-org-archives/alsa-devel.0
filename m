From: Risto Suominen <risto.suominen@gmail.com>
Subject: [PATCH - powermac] Lineout detection on G4 DA
Date: Sun, 4 Apr 2010 08:00:00 +0300
Message-ID: <p2g46e1c7761004032200wb6c3a436t752b878c5e92480@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id B6E6924405
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Apr 2010 07:00:01 +0200 (CEST)
Received: by mail-bw0-f220.google.com with SMTP id 20so3454515bwz.32
	for <alsa-devel@alsa-project.org>; Sat, 03 Apr 2010 22:00:01 -0700 (PDT)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, "Risto.Suominen" <Risto.Suominen@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Risto Suominen <Risto.Suominen@gmail.com>

Lineout (Pro Speaker) detection on PowerMac G4 Digital Audio (Tumbler).

Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>
---
Kernel version 2.6.32.9 (probably any 2.6), ALSA 1.0.22.1.

The patch is available here, too:
http://ristosu.wippiespace.com/pub/alsa-tumbler-1.0.22.1-p16.diff

This has not been tested. Hopefully someone with that kind of machine
and those speakers can do it.

--- a/alsa-kernel/ppc/tumbler.c-p15	2010-03-16 19:59:01.000000000 +0200
+++ b/alsa-kernel/ppc/tumbler.c	2010-03-23 21:42:03.000000000 +0200
@@ -1137,7 +1141,8 @@ static long tumbler_find_device(const ch
 		gp->inactive_val = (*base) ? 0x4 : 0x5;
 	} else {
 		const u32 *prop = NULL;
-		gp->active_state = IS_G4DA && !strcmp(device, "keywest-gpio15");
+		gp->active_state = IS_G4DA
+				&& !strncmp(device, "keywest-gpio1", 13);
 		gp->active_val = 0x4;
 		gp->inactive_val = 0x5;
 		/* Here are some crude hacks to extract the GPIO polarity and
@@ -1315,6 +1320,9 @@ static int __devinit tumbler_init(struct
  	if (irq <= NO_IRQ)
 		irq = tumbler_find_device("line-output-detect",
 					  NULL, &mix->line_detect, 1);
+	if (IS_G4DA && irq <= NO_IRQ)
+		irq = tumbler_find_device("keywest-gpio16",
+					  NULL, &mix->line_detect, 1);
 	mix->lineout_irq = irq;

 	tumbler_reset_audio(chip);
