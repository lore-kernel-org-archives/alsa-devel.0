From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: [PATCH] ad1848 and cs4231 busy loop replacement
Date: Sun, 9 Sep 2007 00:12:08 +0200
Message-ID: <20070909001208.b2e54c13.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 01C501037FC
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Sep 2007 00:05:29 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so1166642mue
	for <alsa-devel@alsa-project.org>; Sat, 08 Sep 2007 15:05:29 -0700 (PDT)
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
Cc: Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch replaces busy loop with msleep and removes
incorrect debug message.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This should fix Rene's problem with the timeout message he got in his new Aztech driver.

The problem is that the driver wait for busy bit to go high but it may not happen if the 
auto-calibration is not set. The result is incorrect debug message (that timeout happened).
It is also possible (in theory) to get this message in the ad1848-lib on a slow CPU.

The patch just wait a period around the period needed for the auto-calibration. If there is
no auto-calibration set, the driver just loses few miliseconds. This may happen only
during driver start as both drivers set auto-calibration. If the auto-calibration is set
we give CPU more time to do something else then move to next waiting loop (for
the auto-calibration bit to get cleared).

The msleep delay is calculated as rounded down time of waiting number of cycles (from
ad1848k and cs4231a specs) with the highest frequency (48kHz).

Rene, please test this patch on the cs4231 codec.

diff -urp linux-2.6.22/sound/isa/ad1848/ad1848_lib.c linux-2.6.23/sound/isa/ad1848/ad1848_lib.c
--- linux-2.6.22/sound/isa/ad1848/ad1848_lib.c	2007-09-08 23:53:42.958067597 +0200
+++ linux-2.6.23/sound/isa/ad1848/ad1848_lib.c	2007-09-08 23:57:31.255077502 +0200
@@ -229,17 +229,12 @@ static void snd_ad1848_mce_down(struct s
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
 		return;
 	}
+
 	/* calibration process */
+	msleep(7);
+
+	snd_printd("(2) jiffies = %li\n", jiffies);
 
-	for (timeout = 500; timeout > 0 && (snd_ad1848_in(chip, AD1848_TEST_INIT) & AD1848_CALIB_IN_PROGRESS) == 0; timeout--);
-	if ((snd_ad1848_in(chip, AD1848_TEST_INIT) & AD1848_CALIB_IN_PROGRESS) == 0) {
-		snd_printd("mce_down - auto calibration time out (1)\n");
-		spin_unlock_irqrestore(&chip->reg_lock, flags);
-		return;
-	}
-#if 0
-	printk("(2) timeout = %i, jiffies = %li\n", timeout, jiffies);
-#endif
 	time = HZ / 4;
 	while (snd_ad1848_in(chip, AD1848_TEST_INIT) & AD1848_CALIB_IN_PROGRESS) {
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
diff -urp linux-2.6.22/sound/isa/cs423x/cs4231_lib.c linux-2.6.23/sound/isa/cs423x/cs4231_lib.c
--- linux-2.6.22/sound/isa/cs423x/cs4231_lib.c	2007-09-08 23:53:29.005272473 +0200
+++ linux-2.6.23/sound/isa/cs423x/cs4231_lib.c	2007-09-08 23:56:52.824887490 +0200
@@ -334,19 +334,12 @@ void snd_cs4231_mce_down(struct snd_cs42
 	    !(chip->hardware & (CS4231_HW_CS4231_MASK | CS4231_HW_CS4232_MASK))) {
 		return;
 	}
-	snd_cs4231_busy_wait(chip);
 
 	/* calibration process */
+	msleep(2);
+
+	snd_printd("(2) jiffies = %li\n", jiffies);
 
-	for (timeout = 500; timeout > 0 && (snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) == 0; timeout--)
-		udelay(10);
-	if ((snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) == 0) {
-		snd_printd("cs4231_mce_down - auto calibration time out (1)\n");
-		return;
-	}
-#if 0
-	printk("(2) timeout = %i, jiffies = %li\n", timeout, jiffies);
-#endif
 	/* in 10 ms increments, check condition, up to 250 ms */
 	timeout = 25;
 	while (snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) {
