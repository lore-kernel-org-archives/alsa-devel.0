From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: [PATCH] cs4231-lib: improved waiting after mce_down
Date: Sun, 9 Sep 2007 22:11:31 +0200
Message-ID: <20070909221131.06372eb2.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 03875243DC
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Sep 2007 22:04:45 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so1116930fka
	for <alsa-devel@alsa-project.org>; Sun, 09 Sep 2007 13:04:45 -0700 (PDT)
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

This patch replaces long msleeps in waiting loops
with schedule_timeout() calls.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

The cs4231 is quite fast and calibration takes about 2ms 
at 48kHz (the quickest). Loops wait in 10ms steps which
is usually too long.

This is done after the ad1848-lib driver, which waits in
this improved way. This makes the cs4231-lib and ad1848-lib
more similar and should help merging of the two.

Regards,
Krzysztof

diff -urp linux-2.6.22.old/sound/isa/cs423x/cs4231_lib.c linux-2.6.22/sound/isa/cs423x/cs4231_lib.c
--- linux-2.6.22.old/sound/isa/cs423x/cs4231_lib.c	2007-09-09 20:33:52.000000000 +0200
+++ linux-2.6.22/sound/isa/cs423x/cs4231_lib.c	2007-09-09 20:31:27.000000000 +0200
@@ -314,6 +314,7 @@ void snd_cs4231_mce_down(struct snd_cs42
 {
 	unsigned long flags;
 	int timeout;
+	long time;
 
 	snd_cs4231_busy_wait(chip);
 #if 0
@@ -340,31 +341,34 @@ void snd_cs4231_mce_down(struct snd_cs42
 
 	snd_printd("(2) jiffies = %li\n", jiffies);
 
-	/* in 10 ms increments, check condition, up to 250 ms */
-	timeout = 25;
+	time = HZ / 4;
 	while (snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) {
-		if (--timeout < 0) {
-			snd_printk("mce_down - auto calibration time out (2)\n");
+		spin_unlock_irqrestore(&chip->reg_lock, flags);
+		if (time <= 0) {
+			snd_printk(KERN_ERR "mce_down - "
+				   "auto calibration time out (2)\n");
 			return;
 		}
-		msleep(10);
+		time = schedule_timeout(time);
+		spin_lock_irqsave(&chip->reg_lock, flags);
 	}
-#if 0
-	printk("(3) jiffies = %li\n", jiffies);
-#endif
-	/* in 10 ms increments, check condition, up to 100 ms */
-	timeout = 10;
+
+	snd_printd("(3) jiffies = %li\n", jiffies);
+
+	time = HZ / 10;
 	while (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT) {
-		if (--timeout < 0) {
-			snd_printk(KERN_ERR "mce_down - auto calibration time out (3)\n");
+		spin_unlock_irqrestore(&chip->reg_lock, flags);
+		if (time <= 0) {
+			snd_printk(KERN_ERR "mce_down - "
+				   "auto calibration time out (3)\n");
 			return;
 		}
-		msleep(10);
+		time = schedule_timeout(time);
+		spin_lock_irqsave(&chip->reg_lock, flags);
 	}
-#if 0
-	printk("(4) jiffies = %li\n", jiffies);
-	snd_printk("mce_down - exit = 0x%x\n", cs4231_inb(chip, CS4231P(REGSEL)));
-#endif
+	snd_printd("(4) jiffies = %li\n", jiffies);
+	snd_printk("mce_down - exit = 0x%x\n",
+		   cs4231_inb(chip, CS4231P(REGSEL)));
 }
 
 static unsigned int snd_cs4231_get_count(unsigned char format, unsigned int size)
