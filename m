From: Rene Herman <rene.herman@gmail.com>
Subject: [PATCH] ad1848/cs4231: replace commented out debug
	code with snd-printd{, d}
Date: Mon, 10 Sep 2007 21:06:57 +0200
Message-ID: <46E595D1.50503@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000704090707020204020401"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id C9B40103886
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Sep 2007 21:13:58 +0200 (CEST)
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
--------------000704090707020204020401
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

While I'm at it another "while I'm there" -- replace commented out debug 
code with snd-printd{,d}.

(I saw Krysztof was busy tweaking the sleeping granularity in these 
functions, so I'm leaving the code alone after this).

Rene.

--------------000704090707020204020401
Content-Type: text/plain;
 name="ad1848_cs4231_snd_printd.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ad1848_cs4231_snd_printd.diff"

diff --git a/sound/isa/ad1848/ad1848_lib.c b/sound/isa/ad1848/ad1848_lib.c
index 161da11..ace2a9b 100644
--- a/sound/isa/ad1848/ad1848_lib.c
+++ b/sound/isa/ad1848/ad1848_lib.c
@@ -211,13 +211,14 @@ static void snd_ad1848_mce_down(struct snd_ad1848 *chip)
 	/* end of cleanup sequence */
 	for (timeout = 12000; timeout > 0 && (inb(AD1848P(chip, REGSEL)) & AD1848_INIT); timeout--)
 		udelay(100);
-#if 0
-	printk("(1) timeout = %i\n", timeout);
-#endif
+
+	snd_printdd("(1) timeout = %d\n", timeout);
+
 #ifdef CONFIG_SND_DEBUG
 	if (inb(AD1848P(chip, REGSEL)) & AD1848_INIT)
 		snd_printk(KERN_WARNING "mce_down [0x%lx] - auto calibration time out (0)\n", AD1848P(chip, REGSEL));
 #endif
+
 	chip->mce_bit &= ~AD1848_MCE;
 	timeout = inb(AD1848P(chip, REGSEL));
 	outb(chip->mce_bit | (timeout & 0x1f), AD1848P(chip, REGSEL));
@@ -234,9 +235,9 @@ static void snd_ad1848_mce_down(struct snd_ad1848 *chip)
          * which at the slowest possible rate of 5.5125 kHz means 907 us.
          */
         msleep(1);
-#if 0
-	printk("(2) jiffies = %li\n", jiffies);
-#endif
+
+	snd_printdd("(2) jiffies = %lu\n", jiffies);
+
 	time = msecs_to_jiffies(250);
 	while (snd_ad1848_in(chip, AD1848_TEST_INIT) & AD1848_CALIB_IN_PROGRESS) {
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
@@ -247,9 +248,9 @@ static void snd_ad1848_mce_down(struct snd_ad1848 *chip)
 		time = schedule_timeout_interruptible(time);
 		spin_lock_irqsave(&chip->reg_lock, flags);
 	}
-#if 0
-	printk("(3) jiffies = %li\n", jiffies);
-#endif
+
+	snd_printdd("(3) jiffies = %lu\n", jiffies);
+
 	time = msecs_to_jiffies(100);
 	while (inb(AD1848P(chip, REGSEL)) & AD1848_INIT) {
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
@@ -261,10 +262,9 @@ static void snd_ad1848_mce_down(struct snd_ad1848 *chip)
 		spin_lock_irqsave(&chip->reg_lock, flags);
 	}
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
-#if 0
-	printk("(4) jiffies = %li\n", jiffies);
-	snd_printk("mce_down - exit = 0x%x\n", inb(AD1848P(chip, REGSEL)));
-#endif
+
+	snd_printdd("(4) jiffies = %lu\n", jiffies);
+	snd_printd("mce_down - exit = 0x%x\n", inb(AD1848P(chip, REGSEL)));
 }
 
 static unsigned int snd_ad1848_get_count(unsigned char format,
diff --git a/sound/isa/cs423x/cs4231_lib.c b/sound/isa/cs423x/cs4231_lib.c
index 9e8e0f1..d3a7b59 100644
--- a/sound/isa/cs423x/cs4231_lib.c
+++ b/sound/isa/cs423x/cs4231_lib.c
@@ -326,9 +326,7 @@ void snd_cs4231_mce_down(struct snd_cs4231 *chip)
 	int timeout;
 
 	snd_cs4231_busy_wait(chip);
-#if 0
-	printk("(1) timeout = %i\n", timeout);
-#endif
+
 #ifdef CONFIG_SND_DEBUG
 	if (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
 		snd_printk("mce_down [0x%lx] - auto calibration time out (0)\n", (long)CS4231P(REGSEL));
@@ -352,9 +350,9 @@ void snd_cs4231_mce_down(struct snd_cs4231 *chip)
 	 * which at the slowest possible rate of 5.5125 kHz means 907 us.
 	 */
 	msleep(1);
-#if 0
-	printk("(2) jiffies = %li\n", jiffies);
-#endif
+
+	snd_printdd("(1) jiffies = %lu\n", jiffies);
+
 	/* in 10 ms increments, check condition, up to 250 ms */
 	timeout = 25;
 	while (snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) {
@@ -364,9 +362,9 @@ void snd_cs4231_mce_down(struct snd_cs4231 *chip)
 		}
 		msleep(10);
 	}
-#if 0
-	printk("(3) jiffies = %li\n", jiffies);
-#endif
+
+	snd_printdd("(2) jiffies = %lu\n", jiffies);
+
 	/* in 10 ms increments, check condition, up to 100 ms */
 	timeout = 10;
 	while (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT) {
@@ -376,10 +374,9 @@ void snd_cs4231_mce_down(struct snd_cs4231 *chip)
 		}
 		msleep(10);
 	}
-#if 0
-	printk("(4) jiffies = %li\n", jiffies);
-	snd_printk("mce_down - exit = 0x%x\n", cs4231_inb(chip, CS4231P(REGSEL)));
-#endif
+
+	snd_printdd("(3) jiffies = %lu\n", jiffies);
+	snd_printd("mce_down - exit = 0x%x\n", cs4231_inb(chip, CS4231P(REGSEL)));
 }
 
 static unsigned int snd_cs4231_get_count(unsigned char format, unsigned int size)

--------------000704090707020204020401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000704090707020204020401--
