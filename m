From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: [PATCH] ad1848: remove redundant autocalibration
Date: Tue, 18 Sep 2007 11:35:17 +0200
Message-ID: <20070918113517.fe854a79.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by alsa0.perex.cz (Postfix) with ESMTP id CCF202448F
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 11:27:58 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so1208327nfd
	for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2007 02:27:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch removes redundant auto-calibration 
(mce up/down sequence) from snd_ad1848_open().

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

The docs says that changing the Interface Configuration register
and the Format/Clock register requires the MCE bit set.
However, the docs do not say that additional auto-calibration is
required after setting one register and before setting the other.
Now, both registers are set at once.

Tested on SC-6000.

This should reduce opening latency by one auto-calibration period.

diff -urp linux-2.6.22.old/sound/isa/ad1848/ad1848_lib.c linux-2.6.23/sound/isa/ad1848/ad1848_lib.c
--- linux-2.6.22.old/sound/isa/ad1848/ad1848_lib.c	2007-09-12 13:33:51.000000000 +0200
+++ linux-2.6.23/sound/isa/ad1848/ad1848_lib.c	2007-09-18 00:36:33.000000000 +0200
@@ -408,17 +408,8 @@ static int snd_ad1848_open(struct snd_ad
 			     AD1848_CALIB_MODE);
 	chip->image[AD1848_IFACE_CTRL] |= AD1848_AUTOCALIB;
 	snd_ad1848_out(chip, AD1848_IFACE_CTRL, chip->image[AD1848_IFACE_CTRL]);
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	snd_ad1848_mce_down(chip);
-
-#ifdef SNDRV_DEBUG_MCE
-	snd_printk("open: (2)\n");
-#endif
 
 	snd_ad1848_set_data_format(chip, NULL);
-
-	snd_ad1848_mce_up(chip);
-	spin_lock_irqsave(&chip->reg_lock, flags);
 	snd_ad1848_out(chip, AD1848_DATA_FORMAT, chip->image[AD1848_DATA_FORMAT]);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	snd_ad1848_mce_down(chip);
