From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] ad1848_lib: replace common delay loop by
	function
Date: Tue, 4 Sep 2007 23:53:32 +0200
Message-ID: <20070904235332.ca7a3c56.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.wp.pl (mx1.wp.pl [212.77.101.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 1715E2446D
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Sep 2007 23:47:19 +0200 (CEST)
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <alsa-devel@alsa-project.org>; 4 Sep 2007 23:47:09 +0200
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

It is the same as for the cs4231_lib.c file.

Please do not bounce this patch if you spot something wrong with formatting in the context lines.
I'll make a separate patch with checkpatch fixes for this library.

diff -urp linux-2.6.23.orig/sound/isa/ad1848/ad1848_lib.c linux-2.6.23/sound/isa/ad1848/ad1848_lib.c
--- linux-2.6.23.orig/sound/isa/ad1848/ad1848_lib.c	2007-09-02 12:49:15.281291412 +0200
+++ linux-2.6.23/sound/isa/ad1848/ad1848_lib.c	2007-09-04 23:44:55.684785358 +0200
@@ -70,7 +70,7 @@ static unsigned int rates[14] = {
 };
 
 static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
-	.count = 14,
+	.count = ARRAY_SIZE(rates),
 	.list = rates,
 	.mask = 0,
 };
@@ -99,24 +99,30 @@ static unsigned char snd_ad1848_original
  *  Basic I/O functions
  */
 
-void snd_ad1848_out(struct snd_ad1848 *chip,
-			   unsigned char reg,
-			   unsigned char value)
+static void snd_ad1848_ready(struct snd_ad1848 *chip)
 {
 	int timeout;
 
-	for (timeout = 250; timeout > 0 && (inb(AD1848P(chip, REGSEL)) & AD1848_INIT); timeout--)
+	for (timeout = 250; timeout > 0; timeout--) {
+		if ((inb(AD1848P(chip, REGSEL)) & AD1848_INIT) == 0)
+			break;
 		udelay(100);
+	}
+}
+
+void snd_ad1848_out(struct snd_ad1848 *chip,
+			   unsigned char reg,
+			   unsigned char value)
+{
+	snd_ad1848_ready(chip);
 #ifdef CONFIG_SND_DEBUG
 	if (inb(AD1848P(chip, REGSEL)) & AD1848_INIT)
-		snd_printk(KERN_WARNING "auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
+		snd_printk(KERN_WARNING "auto calibration time out - "
+			   "reg = 0x%x, value = 0x%x\n", reg, value);
 #endif
 	outb(chip->mce_bit | reg, AD1848P(chip, REGSEL));
 	outb(chip->image[reg] = value, AD1848P(chip, REG));
 	mb();
-#if 0
-	printk("codec out - reg 0x%x = 0x%x\n", chip->mce_bit | reg, value);
-#endif
 }
 
 EXPORT_SYMBOL(snd_ad1848_out);
@@ -124,10 +130,7 @@ EXPORT_SYMBOL(snd_ad1848_out);
 static void snd_ad1848_dout(struct snd_ad1848 *chip,
 			    unsigned char reg, unsigned char value)
 {
-	int timeout;
-
-	for (timeout = 250; timeout > 0 && (inb(AD1848P(chip, REGSEL)) & AD1848_INIT); timeout--)
-		udelay(100);
+	snd_ad1848_ready(chip);
 	outb(chip->mce_bit | reg, AD1848P(chip, REGSEL));
 	outb(value, AD1848P(chip, REG));
 	mb();
@@ -135,13 +138,11 @@ static void snd_ad1848_dout(struct snd_a
 
 static unsigned char snd_ad1848_in(struct snd_ad1848 *chip, unsigned char reg)
 {
-	int timeout;
-
-	for (timeout = 250; timeout > 0 && (inb(AD1848P(chip, REGSEL)) & AD1848_INIT); timeout--)
-		udelay(100);
+	snd_ad1848_ready(chip);
 #ifdef CONFIG_SND_DEBUG
 	if (inb(AD1848P(chip, REGSEL)) & AD1848_INIT)
-		snd_printk(KERN_WARNING "auto calibration time out - reg = 0x%x\n", reg);
+		snd_printk(KERN_WARNING "auto calibration time out - "
+			   "reg = 0x%x\n", reg);
 #endif
 	outb(chip->mce_bit | reg, AD1848P(chip, REGSEL));
 	mb();
@@ -183,8 +184,7 @@ static void snd_ad1848_mce_up(struct snd
 	unsigned long flags;
 	int timeout;
 
-	for (timeout = 250; timeout > 0 && (inb(AD1848P(chip, REGSEL)) & AD1848_INIT); timeout--)
-		udelay(100);
+	snd_ad1848_ready(chip);
 #ifdef CONFIG_SND_DEBUG
 	if (inb(AD1848P(chip, REGSEL)) & AD1848_INIT)
 		snd_printk(KERN_WARNING "mce_up - auto calibration time out (0)\n");
@@ -319,11 +319,11 @@ static unsigned char snd_ad1848_get_rate
 {
 	int i;
 
-	for (i = 0; i < 14; i++)
+	for (i = 0; i < ARRAY_SIZE(rates); i++)
 		if (rate == rates[i])
 			return freq_bits[i];
 	snd_BUG();
-	return freq_bits[13];
+	return freq_bits[ARRAY_SIZE(rates) - 1];
 }
 
 static int snd_ad1848_ioctl(struct snd_pcm_substream *substream,
