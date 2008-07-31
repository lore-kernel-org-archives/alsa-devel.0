From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 07/11] wss_lib: use CS4231P instead of AD1848P
 (kill the AD1848P)
Date: Thu, 31 Jul 2008 21:07:30 +0200
Message-ID: <20080731210730.a14d5262.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id A62962447B
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Jul 2008 21:02:16 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Use CS4231P instead of AD1848P (kill the AD1848P).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
Changes since previous version:

1. No reformatting of the snd_ad1848_debug()
   as the file is going to be killed.
1. Nicer formatting of WSS_SINGLE and WSS_DOUBLE
   macros.

diff -urp linux-ref/include/sound/ad1848.h linux-2.6.26/include/sound/ad1848.h
--- linux-ref/include/sound/ad1848.h	2008-07-31 18:59:20.000000000 +0200
+++ linux-2.6.26/include/sound/ad1848.h	2008-07-31 18:59:06.000000000 +0200
@@ -27,15 +27,6 @@
 
 #include "wss.h"	/* temporary till the driver is removed */
 
-/* IO ports */
-
-#define AD1848P( chip, x ) ( (chip) -> port + c_d_c_AD1848##x )
-
-#define c_d_c_AD1848REGSEL	0
-#define c_d_c_AD1848REG		1
-#define c_d_c_AD1848STATUS	2
-#define c_d_c_AD1848PIO		3
-
 /* codec registers */
 
 #define AD1848_LEFT_INPUT	0x00	/* left input control */
diff -urp linux-ref/sound/isa/ad1848/ad1848_lib.c linux-2.6.26/sound/isa/ad1848/ad1848_lib.c
--- linux-ref/sound/isa/ad1848/ad1848_lib.c	2008-07-31 18:59:20.000000000 +0200
+++ linux-2.6.26/sound/isa/ad1848/ad1848_lib.c	2008-07-31 19:01:10.000000000 +0200
@@ -103,7 +103,7 @@ static void snd_ad1848_wait(struct snd_w
 	int timeout;
 
 	for (timeout = 250; timeout > 0; timeout--) {
-		if ((inb(AD1848P(chip, REGSEL)) & AD1848_INIT) == 0)
+		if ((inb(chip->port + CS4231P(REGSEL)) & AD1848_INIT) == 0)
 			break;
 		udelay(100);
 	}
@@ -115,12 +115,12 @@ void snd_ad1848_out(struct snd_wss *chip
 {
 	snd_ad1848_wait(chip);
 #ifdef CONFIG_SND_DEBUG
-	if (inb(AD1848P(chip, REGSEL)) & AD1848_INIT)
+	if (inb(chip->port + CS4231P(REGSEL)) & AD1848_INIT)
 		snd_printk(KERN_WARNING "auto calibration time out - "
 			   "reg = 0x%x, value = 0x%x\n", reg, value);
 #endif
-	outb(chip->mce_bit | reg, AD1848P(chip, REGSEL));
-	outb(chip->image[reg] = value, AD1848P(chip, REG));
+	outb(chip->mce_bit | reg, chip->port + CS4231P(REGSEL));
+	outb(chip->image[reg] = value, chip->port + CS4231P(REG));
 	mb();
 	snd_printdd("codec out - reg 0x%x = 0x%x\n",
 			chip->mce_bit | reg, value);
@@ -132,8 +132,8 @@ static void snd_ad1848_dout(struct snd_w
 			    unsigned char reg, unsigned char value)
 {
 	snd_ad1848_wait(chip);
-	outb(chip->mce_bit | reg, AD1848P(chip, REGSEL));
-	outb(value, AD1848P(chip, REG));
+	outb(chip->mce_bit | reg, chip->port + CS4231P(REGSEL));
+	outb(value, chip->port + CS4231P(REG));
 	mb();
 }
 
@@ -141,37 +141,37 @@ static unsigned char snd_ad1848_in(struc
 {
 	snd_ad1848_wait(chip);
 #ifdef CONFIG_SND_DEBUG
-	if (inb(AD1848P(chip, REGSEL)) & AD1848_INIT)
+	if (inb(chip->port + CS4231P(REGSEL)) & AD1848_INIT)
 		snd_printk(KERN_WARNING "auto calibration time out - "
 			   "reg = 0x%x\n", reg);
 #endif
-	outb(chip->mce_bit | reg, AD1848P(chip, REGSEL));
+	outb(chip->mce_bit | reg, chip->port + CS4231P(REGSEL));
 	mb();
-	return inb(AD1848P(chip, REG));
+	return inb(chip->port + CS4231P(REG));
 }
 
 #if 0
 
 static void snd_ad1848_debug(struct snd_wss *chip)
 {
-	printk("AD1848 REGS:      INDEX = 0x%02x  ", inb(AD1848P(chip, REGSEL)));
-	printk("                 STATUS = 0x%02x\n", inb(AD1848P(chip, STATUS)));
-	printk("  0x00: left input      = 0x%02x  ", snd_ad1848_in(chip, 0x00));
-	printk("  0x08: playback format = 0x%02x\n", snd_ad1848_in(chip, 0x08));
-	printk("  0x01: right input     = 0x%02x  ", snd_ad1848_in(chip, 0x01));
-	printk("  0x09: iface (CFIG 1)  = 0x%02x\n", snd_ad1848_in(chip, 0x09));
-	printk("  0x02: AUXA left       = 0x%02x  ", snd_ad1848_in(chip, 0x02));
-	printk("  0x0a: pin control     = 0x%02x\n", snd_ad1848_in(chip, 0x0a));
-	printk("  0x03: AUXA right      = 0x%02x  ", snd_ad1848_in(chip, 0x03));
-	printk("  0x0b: init & status   = 0x%02x\n", snd_ad1848_in(chip, 0x0b));
-	printk("  0x04: AUXB left       = 0x%02x  ", snd_ad1848_in(chip, 0x04));
-	printk("  0x0c: revision & mode = 0x%02x\n", snd_ad1848_in(chip, 0x0c));
-	printk("  0x05: AUXB right      = 0x%02x  ", snd_ad1848_in(chip, 0x05));
-	printk("  0x0d: loopback        = 0x%02x\n", snd_ad1848_in(chip, 0x0d));
-	printk("  0x06: left output     = 0x%02x  ", snd_ad1848_in(chip, 0x06));
-	printk("  0x0e: data upr count  = 0x%02x\n", snd_ad1848_in(chip, 0x0e));
-	printk("  0x07: right output    = 0x%02x  ", snd_ad1848_in(chip, 0x07));
-	printk("  0x0f: data lwr count  = 0x%02x\n", snd_ad1848_in(chip, 0x0f));
+	printk(KERN_DEBUG "AD1848 REGS:      INDEX = 0x%02x  ", inb(chip->port + CS4231P(REGSEL)));
+	printk(KERN_DEBUG "                 STATUS = 0x%02x\n", inb(chip->port + CS4231P(STATUS)));
+	printk(KERN_DEBUG "  0x00: left input      = 0x%02x  ", snd_ad1848_in(chip, 0x00));
+	printk(KERN_DEBUG "  0x08: playback format = 0x%02x\n", snd_ad1848_in(chip, 0x08));
+	printk(KERN_DEBUG "  0x01: right input     = 0x%02x  ", snd_ad1848_in(chip, 0x01));
+	printk(KERN_DEBUG "  0x09: iface (CFIG 1)  = 0x%02x\n", snd_ad1848_in(chip, 0x09));
+	printk(KERN_DEBUG "  0x02: AUXA left       = 0x%02x  ", snd_ad1848_in(chip, 0x02));
+	printk(KERN_DEBUG "  0x0a: pin control     = 0x%02x\n", snd_ad1848_in(chip, 0x0a));
+	printk(KERN_DEBUG "  0x03: AUXA right      = 0x%02x  ", snd_ad1848_in(chip, 0x03));
+	printk(KERN_DEBUG "  0x0b: init & status   = 0x%02x\n", snd_ad1848_in(chip, 0x0b));
+	printk(KERN_DEBUG "  0x04: AUXB left       = 0x%02x  ", snd_ad1848_in(chip, 0x04));
+	printk(KERN_DEBUG "  0x0c: revision & mode = 0x%02x\n", snd_ad1848_in(chip, 0x0c));
+	printk(KERN_DEBUG "  0x05: AUXB right      = 0x%02x  ", snd_ad1848_in(chip, 0x05));
+	printk(KERN_DEBUG "  0x0d: loopback        = 0x%02x\n", snd_ad1848_in(chip, 0x0d));
+	printk(KERN_DEBUG "  0x06: left output     = 0x%02x  ", snd_ad1848_in(chip, 0x06));
+	printk(KERN_DEBUG "  0x0e: data upr count  = 0x%02x\n", snd_ad1848_in(chip, 0x0e));
+	printk(KERN_DEBUG "  0x07: right output    = 0x%02x  ", snd_ad1848_in(chip, 0x07));
+	printk(KERN_DEBUG "  0x0f: data lwr count  = 0x%02x\n", snd_ad1848_in(chip, 0x0f));
 }
 
 #endif
@@ -187,16 +187,17 @@ static void snd_ad1848_mce_up(struct snd
 
 	snd_ad1848_wait(chip);
 #ifdef CONFIG_SND_DEBUG
-	if (inb(AD1848P(chip, REGSEL)) & AD1848_INIT)
+	if (inb(chip->port + CS4231P(REGSEL)) & AD1848_INIT)
 		snd_printk(KERN_WARNING "mce_up - auto calibration time out (0)\n");
 #endif
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	chip->mce_bit |= AD1848_MCE;
-	timeout = inb(AD1848P(chip, REGSEL));
+	timeout = inb(chip->port + CS4231P(REGSEL));
 	if (timeout == 0x80)
 		snd_printk(KERN_WARNING "mce_up [0x%lx]: serious init problem - codec still busy\n", chip->port);
 	if (!(timeout & AD1848_MCE))
-		outb(chip->mce_bit | (timeout & 0x1f), AD1848P(chip, REGSEL));
+		outb(chip->mce_bit | (timeout & 0x1f),
+		     chip->port + CS4231P(REGSEL));
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
 
@@ -207,21 +208,25 @@ static void snd_ad1848_mce_down(struct s
 
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	for (timeout = 5; timeout > 0; timeout--)
-		inb(AD1848P(chip, REGSEL));
+		inb(chip->port + CS4231P(REGSEL));
 	/* end of cleanup sequence */
-	for (timeout = 12000; timeout > 0 && (inb(AD1848P(chip, REGSEL)) & AD1848_INIT); timeout--)
+	for (timeout = 12000;
+	     timeout > 0 && (inb(chip->port + CS4231P(REGSEL)) & AD1848_INIT);
+	     timeout--)
 		udelay(100);
 
 	snd_printdd("(1) timeout = %ld\n", timeout);
 
 #ifdef CONFIG_SND_DEBUG
-	if (inb(AD1848P(chip, REGSEL)) & AD1848_INIT)
-		snd_printk(KERN_WARNING "mce_down [0x%lx] - auto calibration time out (0)\n", AD1848P(chip, REGSEL));
+	if (inb(chip->port + CS4231P(REGSEL)) & AD1848_INIT)
+		snd_printk(KERN_WARNING
+			   "mce_down [0x%lx] - auto calibration time out (0)\n",
+			   chip->port + CS4231P(REGSEL));
 #endif
 
 	chip->mce_bit &= ~AD1848_MCE;
-	reg = inb(AD1848P(chip, REGSEL));
-	outb(chip->mce_bit | (reg & 0x1f), AD1848P(chip, REGSEL));
+	reg = inb(chip->port + CS4231P(REGSEL));
+	outb(chip->mce_bit | (reg & 0x1f), chip->port + CS4231P(REGSEL));
 	if (reg == 0x80)
 		snd_printk(KERN_WARNING "mce_down [0x%lx]: serious init problem - codec still busy\n", chip->port);
 	if ((reg & AD1848_MCE) == 0) {
@@ -252,7 +257,8 @@ static void snd_ad1848_mce_down(struct s
 			   "mce_down - auto calibration time out (2)\n");
 
 	snd_printdd("(4) jiffies = %lu\n", jiffies);
-	snd_printd("mce_down - exit = 0x%x\n", inb(AD1848P(chip, REGSEL)));
+	snd_printd("mce_down - exit = 0x%x\n",
+		   inb(chip->port + CS4231P(REGSEL)));
 }
 
 static unsigned int snd_ad1848_get_count(unsigned char format,
@@ -412,8 +418,8 @@ static int snd_ad1848_open(struct snd_ws
 
 	/* ok. now enable and ack CODEC IRQ */
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	outb(0, AD1848P(chip, STATUS));	/* clear IRQ */
-	outb(0, AD1848P(chip, STATUS));	/* clear IRQ */
+	outb(0, chip->port + CS4231P(STATUS));	/* clear IRQ */
+	outb(0, chip->port + CS4231P(STATUS));	/* clear IRQ */
 	chip->image[AD1848_PIN_CTRL] |= AD1848_IRQ_ENABLE;
 	snd_ad1848_out(chip, AD1848_PIN_CTRL, chip->image[AD1848_PIN_CTRL]);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
@@ -431,8 +437,8 @@ static void snd_ad1848_close(struct snd_
 		return;
 	/* disable IRQ */
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	outb(0, AD1848P(chip, STATUS));	/* clear IRQ */
-	outb(0, AD1848P(chip, STATUS));	/* clear IRQ */
+	outb(0, chip->port + CS4231P(STATUS));	/* clear IRQ */
+	outb(0, chip->port + CS4231P(STATUS));	/* clear IRQ */
 	chip->image[AD1848_PIN_CTRL] &= ~AD1848_IRQ_ENABLE;
 	snd_ad1848_out(chip, AD1848_PIN_CTRL, chip->image[AD1848_PIN_CTRL]);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
@@ -449,8 +455,8 @@ static void snd_ad1848_close(struct snd_
 
 	/* clear IRQ again */
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	outb(0, AD1848P(chip, STATUS));	/* clear IRQ */
-	outb(0, AD1848P(chip, STATUS));	/* clear IRQ */
+	outb(0, chip->port + CS4231P(STATUS));	/* clear IRQ */
+	outb(0, chip->port + CS4231P(STATUS));	/* clear IRQ */
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 
 	chip->mode = 0;
@@ -572,7 +578,7 @@ static irqreturn_t snd_ad1848_interrupt(
 		snd_pcm_period_elapsed(chip->playback_substream);
 	if ((chip->mode & WSS_MODE_RECORD) && chip->capture_substream)
 		snd_pcm_period_elapsed(chip->capture_substream);
-	outb(0, AD1848P(chip, STATUS));	/* clear global interrupt bit */
+	outb(0, chip->port + CS4231P(STATUS));	/* clear global interrupt bit */
 	return IRQ_HANDLED;
 }
 
@@ -638,8 +644,8 @@ static void snd_ad1848_resume(struct snd
 		snd_ad1848_thinkpad_twiddle(chip, 1);
 
 	/* clear any pendings IRQ */
-	inb(AD1848P(chip, STATUS));
-	outb(0, AD1848P(chip, STATUS));
+	inb(chip->port + CS4231P(STATUS));
+	outb(0, chip->port + CS4231P(STATUS));
 	mb();
 
 	snd_ad1848_mce_down(chip);
@@ -662,7 +668,7 @@ static int snd_ad1848_probe(struct snd_w
 	id = ad1847 = 0;
 	for (i = 0; i < 1000; i++) {
 		mb();
-		if (inb(AD1848P(chip, REGSEL)) & AD1848_INIT)
+		if (inb(chip->port + CS4231P(REGSEL)) & AD1848_INIT)
 			udelay(500);
 		else {
 			spin_lock_irqsave(&chip->reg_lock, flags);
@@ -707,8 +713,8 @@ static int snd_ad1848_probe(struct snd_w
 		}
 	}
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	inb(AD1848P(chip, STATUS));	/* clear any pendings IRQ */
-	outb(0, AD1848P(chip, STATUS));
+	inb(chip->port + CS4231P(STATUS));	/* clear any pendings IRQ */
+	outb(0, chip->port + CS4231P(STATUS));
 	mb();
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 

----------------------------------------------------------------------
Tanie rozmowy!
Sprawdz >>>  http://link.interia.pl/f1e91
