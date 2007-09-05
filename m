From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] cs4231-lib: replace common delay loop by
	function
Date: Wed, 5 Sep 2007 19:09:11 +0200
Message-ID: <20070905190911.34f41d66.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.wp.pl (mx1.wp.pl [212.77.101.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 390F4103827
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 19:03:01 +0200 (CEST)
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <alsa-devel@alsa-project.org>; 5 Sep 2007 19:02:45 +0200
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

This patch replaces a common delay loop by a function.
It also uses ARRAY_SIZE macro for the rates table.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-2.6.23.orig/sound/isa/cs423x/cs4231_lib.c linux-2.6.23/sound/isa/cs423x/cs4231_lib.c
--- linux-2.6.23.orig/sound/isa/cs423x/cs4231_lib.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.23/sound/isa/cs423x/cs4231_lib.c	2007-09-05 19:07:35.242811960 +0200
@@ -74,7 +74,7 @@ static unsigned int rates[14] = {
 };
 
 static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
-	.count = 14,
+	.count = ARRAY_SIZE(rates),
 	.list = rates,
 	.mask = 0,
 };
@@ -134,29 +134,31 @@ static inline u8 cs4231_inb(struct snd_c
 	return inb(chip->port + offset);
 }
 
-static void snd_cs4231_outm(struct snd_cs4231 *chip, unsigned char reg,
-			    unsigned char mask, unsigned char value)
+static void snd_cs4231_wait(struct snd_cs4231 *chip)
 {
 	int timeout;
-	unsigned char tmp;
 
 	for (timeout = 250;
 	     timeout > 0 && (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT);
 	     timeout--)
 	     	udelay(100);
+}
+
+static void snd_cs4231_outm(struct snd_cs4231 *chip, unsigned char reg,
+			    unsigned char mask, unsigned char value)
+{
+	unsigned char tmp = (chip->image[reg] & mask) | value;
+
+	snd_cs4231_wait(chip);
 #ifdef CONFIG_SND_DEBUG
 	if (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
 		snd_printk("outm: auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
 #endif
-	if (chip->calibrate_mute) {
-		chip->image[reg] &= mask;
-		chip->image[reg] |= value;
-	} else {
+	chip->image[reg] = tmp;
+	if (!chip->calibrate_mute) {
 		cs4231_outb(chip, CS4231P(REGSEL), chip->mce_bit | reg);
-		mb();
-		tmp = (chip->image[reg] & mask) | value;
+		wmb();
 		cs4231_outb(chip, CS4231P(REG), tmp);
-		chip->image[reg] = tmp;
 		mb();
 	}
 }
@@ -176,12 +178,7 @@ static void snd_cs4231_dout(struct snd_c
 
 void snd_cs4231_out(struct snd_cs4231 *chip, unsigned char reg, unsigned char value)
 {
-	int timeout;
-
-	for (timeout = 250;
-	     timeout > 0 && (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT);
-	     timeout--)
-	     	udelay(100);
+	snd_cs4231_wait(chip);
 #ifdef CONFIG_SND_DEBUG
 	if (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
 		snd_printk("out: auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
@@ -190,19 +187,13 @@ void snd_cs4231_out(struct snd_cs4231 *c
 	cs4231_outb(chip, CS4231P(REG), value);
 	chip->image[reg] = value;
 	mb();
-#if 0
-	printk("codec out - reg 0x%x = 0x%x\n", chip->mce_bit | reg, value);
-#endif
+	snd_printdd("codec out - reg 0x%x = 0x%x\n",
+			chip->mce_bit | reg, value);
 }
 
 unsigned char snd_cs4231_in(struct snd_cs4231 *chip, unsigned char reg)
 {
-	int timeout;
-
-	for (timeout = 250;
-	     timeout > 0 && (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT);
-	     timeout--)
-	     	udelay(100);
+	snd_cs4231_wait(chip);
 #ifdef CONFIG_SND_DEBUG
 	if (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
 		snd_printk("in: auto calibration time out - reg = 0x%x\n", reg);
@@ -304,8 +295,7 @@ void snd_cs4231_mce_up(struct snd_cs4231
 	unsigned long flags;
 	int timeout;
 
-	for (timeout = 250; timeout > 0 && (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT); timeout--)
-		udelay(100);
+	snd_cs4231_wait(chip);
 #ifdef CONFIG_SND_DEBUG
 	if (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
 		snd_printk("mce_up - auto calibration time out (0)\n");
@@ -459,11 +449,11 @@ static unsigned char snd_cs4231_get_rate
 {
 	int i;
 
-	for (i = 0; i < 14; i++)
+	for (i = 0; i < ARRAY_SIZE(rates); i++)
 		if (rate == rates[i])
 			return freq_bits[i];
 	// snd_BUG();
-	return freq_bits[13];
+	return freq_bits[ARRAY_SIZE(rates) - 1];
 }
 
 static unsigned char snd_cs4231_get_format(struct snd_cs4231 *chip,
