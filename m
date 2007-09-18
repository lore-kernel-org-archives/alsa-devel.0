From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: [PATCH] cs4231: remove two auto-calibrations during
 chip initialization
Date: Tue, 18 Sep 2007 12:17:58 +0200
Message-ID: <20070918121758.5686aa96.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 54D8C24497
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 12:10:37 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so1215623nfd
	for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2007 03:10:34 -0700 (PDT)
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

The initialization function did auto-calibration after each
register setting. This patch merges more register changes
before auto-calibration is done.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This is in the init() function so it is called just once.
The patch is about cutting fat from cs4231 drivers as
this change does not affect how they operate in any
major way.

diff -urp alsa-driver-1.0.15rc2/sound/isa/cs423x/cs4231_lib.c linux-2.6.23/sound/isa/cs423x/cs4231_lib.c
--- alsa-driver-1.0.15rc2/sound/isa/cs423x/cs4231_lib.c	2007-09-12 13:33:51.000000000 +0200
+++ linux-2.6.23/sound/isa/cs423x/cs4231_lib.c	2007-09-18 08:37:08.000000000 +0200
@@ -652,15 +652,7 @@ static void snd_cs4231_init(struct snd_c
 			     CS4231_CALIB_MODE);
 	chip->image[CS4231_IFACE_CTRL] |= CS4231_AUTOCALIB;
 	snd_cs4231_out(chip, CS4231_IFACE_CTRL, chip->image[CS4231_IFACE_CTRL]);
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	snd_cs4231_mce_down(chip);
-
-#ifdef SNDRV_DEBUG_MCE
-	snd_printk("init: (2)\n");
-#endif
 
-	snd_cs4231_mce_up(chip);
-	spin_lock_irqsave(&chip->reg_lock, flags);
 	snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1]);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	snd_cs4231_mce_down(chip);
@@ -676,15 +668,6 @@ static void snd_cs4231_init(struct snd_c
 	snd_cs4231_mce_up(chip);
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT, chip->image[CS4231_PLAYBK_FORMAT]);
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	snd_cs4231_mce_down(chip);
-
-#ifdef SNDRV_DEBUG_MCE
-	snd_printk("init: (4)\n");
-#endif
-
-	snd_cs4231_mce_up(chip);
-	spin_lock_irqsave(&chip->reg_lock, flags);
 	snd_cs4231_out(chip, CS4231_REC_FORMAT, chip->image[CS4231_REC_FORMAT]);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	snd_cs4231_mce_down(chip);
diff -urp linux-2.6.23.ref/sound/sparc/cs4231.c linux-2.6.23/sound/sparc/cs4231.c
--- linux-2.6.23.ref/sound/sparc/cs4231.c	2007-09-18 09:26:12.000000000 +0200
+++ linux-2.6.23/sound/sparc/cs4231.c	2007-09-18 09:26:54.000000000 +0200
@@ -733,15 +733,6 @@ static void __init snd_cs4231_init(struc
 					    CS4231_CALIB_MODE);
 	chip->image[CS4231_IFACE_CTRL] |= CS4231_AUTOCALIB;
 	snd_cs4231_out(chip, CS4231_IFACE_CTRL, chip->image[CS4231_IFACE_CTRL]);
-	spin_unlock_irqrestore(&chip->lock, flags);
-	snd_cs4231_mce_down(chip);
-
-#ifdef SNDRV_DEBUG_MCE
-	snd_printdd("init: (2)\n");
-#endif
-
-	snd_cs4231_mce_up(chip);
-	spin_lock_irqsave(&chip->lock, flags);
 	snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1]);
 	spin_unlock_irqrestore(&chip->lock, flags);
 	snd_cs4231_mce_down(chip);
@@ -757,15 +748,6 @@ static void __init snd_cs4231_init(struc
 	snd_cs4231_mce_up(chip);
 	spin_lock_irqsave(&chip->lock, flags);
 	snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT, chip->image[CS4231_PLAYBK_FORMAT]);
-	spin_unlock_irqrestore(&chip->lock, flags);
-	snd_cs4231_mce_down(chip);
-
-#ifdef SNDRV_DEBUG_MCE
-	snd_printdd("init: (4)\n");
-#endif
-
-	snd_cs4231_mce_up(chip);
-	spin_lock_irqsave(&chip->lock, flags);
 	snd_cs4231_out(chip, CS4231_REC_FORMAT, chip->image[CS4231_REC_FORMAT]);
 	spin_unlock_irqrestore(&chip->lock, flags);
 	snd_cs4231_mce_down(chip);
