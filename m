From: Rene Herman <rene.herman@gmail.com>
Subject: [PATCH] ad1838/cs4231 -- fix MCE timeout upon initial
	load
Date: Mon, 10 Sep 2007 20:29:21 +0200
Message-ID: <46E58D01.9080809@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050400040707020305050000"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 17D4024458
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Sep 2007 20:36:21 +0200 (CEST)
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
Cc: Krzysztof Helt <krzysztof.h1@gmail.com>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050400040707020305050000
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

When the ad1848/cs2431 is first being initialized, auto-calibration may not 
be set causing a timeout waiting for it in snd_ad1848/cs4231_mce_down().

This has no dire consequences other than an alarming printk, but since what 
we need to wait for is for the calibration to _finish_, let's just check for 
that instead.

The early chips need a slight delay (as commented -- 5 sample periods) to be 
sure that _if_ calibration is going to happen, it has started when we check 
While the CS4231A datasheet implies it'll happen immediately on downing MCE, 
some testing is showing that there's a window there as well, so just do the 
delay everywhere.

Thanks to Krysztof Helt for pinpointing this problem.

Signed-off-by: Rene Herman <rene.herman@gmail.com>

Rene.

--------------050400040707020305050000
Content-Type: text/plain;
 name="mce_down.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mce_down.diff"

diff --git a/sound/isa/ad1848/ad1848_lib.c b/sound/isa/ad1848/ad1848_lib.c
index 8094282..dcd4435 100644
--- a/sound/isa/ad1848/ad1848_lib.c
+++ b/sound/isa/ad1848/ad1848_lib.c
@@ -227,16 +227,15 @@ static void snd_ad1848_mce_down(struct snd_ad1848 *chip)
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
 		return;
 	}
-	/* calibration process */
 
-	for (timeout = 500; timeout > 0 && (snd_ad1848_in(chip, AD1848_TEST_INIT) & AD1848_CALIB_IN_PROGRESS) == 0; timeout--);
-	if ((snd_ad1848_in(chip, AD1848_TEST_INIT) & AD1848_CALIB_IN_PROGRESS) == 0) {
-		snd_printd("mce_down - auto calibration time out (1)\n");
-		spin_unlock_irqrestore(&chip->reg_lock, flags);
-		return;
-	}
+        /*
+         * Wait for (possible -- during init auto-calibration may not be set)
+         * calibration process to start. Needs upto 5 sample periods on AD1848
+         * which at the slowest possible rate of 5.5125 kHz means 907 us.
+         */
+        msleep(1);
 #if 0
-	printk("(2) timeout = %i, jiffies = %li\n", timeout, jiffies);
+	printk("(2) jiffies = %li\n", jiffies);
 #endif
 	time = HZ / 4;
 	while (snd_ad1848_in(chip, AD1848_TEST_INIT) & AD1848_CALIB_IN_PROGRESS) {
diff --git a/sound/isa/cs423x/cs4231_lib.c b/sound/isa/cs423x/cs4231_lib.c
index 914d77b..9e8e0f1 100644
--- a/sound/isa/cs423x/cs4231_lib.c
+++ b/sound/isa/cs423x/cs4231_lib.c
@@ -346,16 +346,14 @@ void snd_cs4231_mce_down(struct snd_cs4231 *chip)
 	}
 	snd_cs4231_busy_wait(chip);
 
-	/* calibration process */
-
-	for (timeout = 500; timeout > 0 && (snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) == 0; timeout--)
-		udelay(10);
-	if ((snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) == 0) {
-		snd_printd("cs4231_mce_down - auto calibration time out (1)\n");
-		return;
-	}
+	/*
+	 * Wait for (possible -- during init auto-calibration may not be set)
+	 * calibration process to start. Needs upto 5 sample periods on AD1848
+	 * which at the slowest possible rate of 5.5125 kHz means 907 us.
+	 */
+	msleep(1);
 #if 0
-	printk("(2) timeout = %i, jiffies = %li\n", timeout, jiffies);
+	printk("(2) jiffies = %li\n", jiffies);
 #endif
 	/* in 10 ms increments, check condition, up to 250 ms */
 	timeout = 25;

--------------050400040707020305050000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050400040707020305050000--
