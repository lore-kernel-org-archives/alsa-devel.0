From: Risto Suominen <risto.suominen@gmail.com>
Subject: [PATCH - powermac] Reverse HP detection on G4 DA
Date: Sun, 4 Apr 2010 07:59:30 +0300
Message-ID: <p2y46e1c7761004032159ma3fb51bcm23e8c8ce5aa24219@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 07B5024403
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Apr 2010 06:59:34 +0200 (CEST)
Received: by bwz20 with SMTP id 20so3454515bwz.32
	for <alsa-devel@alsa-project.org>; Sat, 03 Apr 2010 21:59:32 -0700 (PDT)
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

Reverse headphone detection bit on PowerMac G4 Digital Audio (Tumbler).

Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>
---
Kernel version 2.6.32.9 (probably any 2.6), ALSA 1.0.22.1.

The patch is available here, too:
http://ristosu.wippiespace.com/pub/alsa-tumbler-1.0.22.1-p15.diff

--- a/alsa-kernel/ppc/tumbler.c.org	2009-12-28 16:21:33.000000000 +0200
+++ b/alsa-kernel/ppc/tumbler.c	2010-03-16 19:59:01.000000000 +0200
@@ -30,6 +30,7 @@
 #include <linux/kmod.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/string.h>
 #include <sound/core.h>
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -46,6 +47,8 @@
 #define DBG(fmt...)
 #endif

+#define IS_G4DA (machine_is_compatible("PowerMac3,4"))
+
 /* i2c address for tumbler */
 #define TAS_I2C_ADDR	0x34

@@ -1134,7 +1137,7 @@ static long tumbler_find_device(const ch
 		gp->inactive_val = (*base) ? 0x4 : 0x5;
 	} else {
 		const u32 *prop = NULL;
-		gp->active_state = 0;
+		gp->active_state = IS_G4DA && !strcmp(device, "keywest-gpio15");
 		gp->active_val = 0x4;
 		gp->inactive_val = 0x5;
 		/* Here are some crude hacks to extract the GPIO polarity and
