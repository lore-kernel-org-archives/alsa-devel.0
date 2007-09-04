From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] sun-cs4231: use cs4231-regs.h
Date: Tue, 4 Sep 2007 22:28:15 +0200
Message-ID: <20070904222815.5422b546.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.wp.pl (mx1.wp.pl [212.77.101.5])
	by alsa0.perex.cz (Postfix) with ESMTP id BEFA6103964
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Sep 2007 22:22:02 +0200 (CEST)
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <alsa-devel@alsa-project.org>; 4 Sep 2007 22:21:53 +0200
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

This patch replaces cs4231 registers definitions with
common include.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-2.6.23.ref/sound/sparc/cs4231.c linux-2.6.23/sound/sparc/cs4231.c
--- linux-2.6.23.ref/sound/sparc/cs4231.c	2007-09-04 19:04:30.000000000 +0200
+++ linux-2.6.23/sound/sparc/cs4231.c	2007-09-04 19:10:13.000000000 +0200
@@ -130,129 +130,10 @@ static struct snd_cs4231 *cs4231_list;
  */
 
 /* IO ports */
-
-#define CS4231P(chip, x)	((chip)->port + c_d_c_CS4231##x)
+#include <sound/cs4231-regs.h>
 
 /* XXX offsets are different than PC ISA chips... */
-#define c_d_c_CS4231REGSEL	0x0
-#define c_d_c_CS4231REG		0x4
-#define c_d_c_CS4231STATUS	0x8
-#define c_d_c_CS4231PIO		0xc
-
-/* codec registers */
-
-#define CS4231_LEFT_INPUT	0x00	/* left input control */
-#define CS4231_RIGHT_INPUT	0x01	/* right input control */
-#define CS4231_AUX1_LEFT_INPUT	0x02	/* left AUX1 input control */
-#define CS4231_AUX1_RIGHT_INPUT	0x03	/* right AUX1 input control */
-#define CS4231_AUX2_LEFT_INPUT	0x04	/* left AUX2 input control */
-#define CS4231_AUX2_RIGHT_INPUT	0x05	/* right AUX2 input control */
-#define CS4231_LEFT_OUTPUT	0x06	/* left output control register */
-#define CS4231_RIGHT_OUTPUT	0x07	/* right output control register */
-#define CS4231_PLAYBK_FORMAT	0x08	/* clock and data format - playback - bits 7-0 MCE */
-#define CS4231_IFACE_CTRL	0x09	/* interface control - bits 7-2 MCE */
-#define CS4231_PIN_CTRL		0x0a	/* pin control */
-#define CS4231_TEST_INIT	0x0b	/* test and initialization */
-#define CS4231_MISC_INFO	0x0c	/* miscellaneaous information */
-#define CS4231_LOOPBACK		0x0d	/* loopback control */
-#define CS4231_PLY_UPR_CNT	0x0e	/* playback upper base count */
-#define CS4231_PLY_LWR_CNT	0x0f	/* playback lower base count */
-#define CS4231_ALT_FEATURE_1	0x10	/* alternate #1 feature enable */
-#define CS4231_ALT_FEATURE_2	0x11	/* alternate #2 feature enable */
-#define CS4231_LEFT_LINE_IN	0x12	/* left line input control */
-#define CS4231_RIGHT_LINE_IN	0x13	/* right line input control */
-#define CS4231_TIMER_LOW	0x14	/* timer low byte */
-#define CS4231_TIMER_HIGH	0x15	/* timer high byte */
-#define CS4231_LEFT_MIC_INPUT	0x16	/* left MIC input control register (InterWave only) */
-#define CS4231_RIGHT_MIC_INPUT	0x17	/* right MIC input control register (InterWave only) */
-#define CS4236_EXT_REG		0x17	/* extended register access */
-#define CS4231_IRQ_STATUS	0x18	/* irq status register */
-#define CS4231_LINE_LEFT_OUTPUT	0x19	/* left line output control register (InterWave only) */
-#define CS4231_VERSION		0x19	/* CS4231(A) - version values */
-#define CS4231_MONO_CTRL	0x1a	/* mono input/output control */
-#define CS4231_LINE_RIGHT_OUTPUT 0x1b	/* right line output control register (InterWave only) */
-#define CS4235_LEFT_MASTER	0x1b	/* left master output control */
-#define CS4231_REC_FORMAT	0x1c	/* clock and data format - record - bits 7-0 MCE */
-#define CS4231_PLY_VAR_FREQ	0x1d	/* playback variable frequency */
-#define CS4235_RIGHT_MASTER	0x1d	/* right master output control */
-#define CS4231_REC_UPR_CNT	0x1e	/* record upper count */
-#define CS4231_REC_LWR_CNT	0x1f	/* record lower count */
-
-/* definitions for codec register select port - CODECP( REGSEL ) */
-
-#define CS4231_INIT		0x80	/* CODEC is initializing */
-#define CS4231_MCE		0x40	/* mode change enable */
-#define CS4231_TRD		0x20	/* transfer request disable */
-
-/* definitions for codec status register - CODECP( STATUS ) */
-
-#define CS4231_GLOBALIRQ	0x01	/* IRQ is active */
-
-/* definitions for codec irq status - CS4231_IRQ_STATUS	*/
-
-#define CS4231_PLAYBACK_IRQ	0x10
-#define CS4231_RECORD_IRQ	0x20
-#define CS4231_TIMER_IRQ	0x40
-#define CS4231_ALL_IRQS		0x70
-#define CS4231_REC_UNDERRUN	0x08
-#define CS4231_REC_OVERRUN	0x04
-#define CS4231_PLY_OVERRUN	0x02
-#define CS4231_PLY_UNDERRUN	0x01
-
-/* definitions for CS4231_LEFT_INPUT and CS4231_RIGHT_INPUT registers */
-
-#define CS4231_ENABLE_MIC_GAIN	0x20
-
-#define CS4231_MIXS_LINE	0x00
-#define CS4231_MIXS_AUX1	0x40
-#define CS4231_MIXS_MIC		0x80
-#define CS4231_MIXS_ALL		0xc0
-
-/* definitions for clock and data format register - CS4231_PLAYBK_FORMAT */
-
-#define CS4231_LINEAR_8		0x00	/* 8-bit unsigned data */
-#define CS4231_ALAW_8		0x60	/* 8-bit A-law companded */
-#define CS4231_ULAW_8		0x20	/* 8-bit U-law companded */
-#define CS4231_LINEAR_16	0x40	/* 16-bit twos complement data - little endian */
-#define CS4231_LINEAR_16_BIG	0xc0	/* 16-bit twos complement data - big endian */
-#define CS4231_ADPCM_16		0xa0	/* 16-bit ADPCM */
-#define CS4231_STEREO		0x10	/* stereo mode */
-/* bits 3-1 define frequency divisor */
-#define CS4231_XTAL1		0x00	/* 24.576 crystal */
-#define CS4231_XTAL2		0x01	/* 16.9344 crystal */
-
-/* definitions for interface control register - CS4231_IFACE_CTRL */
-
-#define CS4231_RECORD_PIO	0x80	/* record PIO enable */
-#define CS4231_PLAYBACK_PIO	0x40	/* playback PIO enable */
-#define CS4231_CALIB_MODE	0x18	/* calibration mode bits */
-#define CS4231_AUTOCALIB	0x08	/* auto calibrate */
-#define CS4231_SINGLE_DMA	0x04	/* use single DMA channel */
-#define CS4231_RECORD_ENABLE	0x02	/* record enable */
-#define CS4231_PLAYBACK_ENABLE	0x01	/* playback enable */
-
-/* definitions for pin control register - CS4231_PIN_CTRL */
-
-#define CS4231_IRQ_ENABLE	0x02	/* enable IRQ */
-#define CS4231_XCTL1		0x40	/* external control #1 */
-#define CS4231_XCTL0		0x80	/* external control #0 */
-
-/* definitions for test and init register - CS4231_TEST_INIT */
-
-#define CS4231_CALIB_IN_PROGRESS 0x20	/* auto calibrate in progress */
-#define CS4231_DMA_REQUEST	0x10	/* DMA request in progress */
-
-/* definitions for misc control register - CS4231_MISC_INFO */
-
-#define CS4231_MODE2		0x40	/* MODE 2 */
-#define CS4231_IW_MODE3		0x6c	/* MODE 3 - InterWave enhanced mode */
-#define CS4231_4236_MODE3	0xe0	/* MODE 3 - CS4236+ enhanced mode */
-
-/* definitions for alternate feature 1 register - CS4231_ALT_FEATURE_1 */
-
-#define	CS4231_DACZ		0x01	/* zero DAC when underrun */
-#define CS4231_TIMER_ENABLE	0x40	/* codec timer enable */
-#define CS4231_OLB		0x80	/* output level bit */
+#define CS4231U(chip, x)	((chip)->port + ((c_d_c_CS4231##x) << 2))
 
 /* SBUS DMA register defines.  */
 
@@ -412,24 +293,26 @@ static void snd_cs4231_ready(struct snd_
 {
 	int timeout;
 
-	for (timeout = 250;
-	     timeout > 0 && (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT);
-	     timeout--)
-	     	udelay(100);
+	for (timeout = 250; timeout > 0; timeout--) {
+		int val = __cs4231_readb(chip, CS4231U(chip, REGSEL));
+		if ((val & CS4231_INIT) == 0)
+			break;
+		udelay(100);
+	}
 }
 
 static void snd_cs4231_dout(struct snd_cs4231 *chip, unsigned char reg, unsigned char value)
 {
 	snd_cs4231_ready(chip);
 #ifdef CONFIG_SND_DEBUG
-	if (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT)
+	if (__cs4231_readb(chip, CS4231U(chip, REGSEL)) & CS4231_INIT)
 		snd_printdd("out: auto calibration time out - reg = 0x%x, "
 			    "value = 0x%x\n",
 			    reg, value);
 #endif
-	__cs4231_writeb(chip, chip->mce_bit | reg, CS4231P(chip, REGSEL));
+	__cs4231_writeb(chip, chip->mce_bit | reg, CS4231U(chip, REGSEL));
 	wmb();
-	__cs4231_writeb(chip, value, CS4231P(chip, REG));
+	__cs4231_writeb(chip, value, CS4231U(chip, REG));
 	mb();
 }
 
@@ -455,13 +338,13 @@ static unsigned char snd_cs4231_in(struc
 {
 	snd_cs4231_ready(chip);
 #ifdef CONFIG_SND_DEBUG
-	if (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT)
+	if (__cs4231_readb(chip, CS4231U(chip, REGSEL)) & CS4231_INIT)
 		snd_printdd("in: auto calibration time out - reg = 0x%x\n",
 			    reg);
 #endif
-	__cs4231_writeb(chip, chip->mce_bit | reg, CS4231P(chip, REGSEL));
+	__cs4231_writeb(chip, chip->mce_bit | reg, CS4231U(chip, REGSEL));
 	mb();
-	return __cs4231_readb(chip, CS4231P(chip, REG));
+	return __cs4231_readb(chip, CS4231U(chip, REG));
 }
 
 /*
@@ -474,13 +357,15 @@ static void snd_cs4231_busy_wait(struct 
 
 	/* huh.. looks like this sequence is proper for CS4231A chip (GUS MAX) */
 	for (timeout = 5; timeout > 0; timeout--)
-		__cs4231_readb(chip, CS4231P(chip, REGSEL));
+		__cs4231_readb(chip, CS4231U(chip, REGSEL));
 
 	/* end of cleanup sequence */
-	for (timeout = 500;
-	     timeout > 0 && (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT);
-	     timeout--)
+	for (timeout = 500; timeout > 0; timeout--) {
+		int val = __cs4231_readb(chip, CS4231U(chip, REGSEL));
+		if ((val & CS4231_INIT) == 0)
+			break;
 		msleep(1);
+	}
 }
 
 static void snd_cs4231_mce_up(struct snd_cs4231 *chip)
@@ -491,15 +376,16 @@ static void snd_cs4231_mce_up(struct snd
 	spin_lock_irqsave(&chip->lock, flags);
 	snd_cs4231_ready(chip);
 #ifdef CONFIG_SND_DEBUG
-	if (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT)
+	if (__cs4231_readb(chip, CS4231U(chip, REGSEL)) & CS4231_INIT)
 		snd_printdd("mce_up - auto calibration time out (0)\n");
 #endif
 	chip->mce_bit |= CS4231_MCE;
-	timeout = __cs4231_readb(chip, CS4231P(chip, REGSEL));
+	timeout = __cs4231_readb(chip, CS4231U(chip, REGSEL));
 	if (timeout == 0x80)
 		snd_printdd("mce_up [%p]: serious init problem - codec still busy\n", chip->port);
 	if (!(timeout & CS4231_MCE))
-		__cs4231_writeb(chip, chip->mce_bit | (timeout & 0x1f), CS4231P(chip, REGSEL));
+		__cs4231_writeb(chip, chip->mce_bit | (timeout & 0x1f),
+				CS4231U(chip, REGSEL));
 	spin_unlock_irqrestore(&chip->lock, flags);
 }
 
@@ -511,12 +397,14 @@ static void snd_cs4231_mce_down(struct s
 	spin_lock_irqsave(&chip->lock, flags);
 	snd_cs4231_busy_wait(chip);
 #ifdef CONFIG_SND_DEBUG
-	if (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT)
-		snd_printdd("mce_down [%p] - auto calibration time out (0)\n", CS4231P(chip, REGSEL));
+	if (__cs4231_readb(chip, CS4231U(chip, REGSEL)) & CS4231_INIT)
+		snd_printdd("mce_down [%p] - auto calibration time out (0)\n",
+			    CS4231U(chip, REGSEL));
 #endif
 	chip->mce_bit &= ~CS4231_MCE;
-	timeout = __cs4231_readb(chip, CS4231P(chip, REGSEL));
-	__cs4231_writeb(chip, chip->mce_bit | (timeout & 0x1f), CS4231P(chip, REGSEL));
+	timeout = __cs4231_readb(chip, CS4231U(chip, REGSEL));
+	__cs4231_writeb(chip, chip->mce_bit | (timeout & 0x1f),
+			CS4231U(chip, REGSEL));
 	if (timeout == 0x80)
 		snd_printdd("mce_down [%p]: serious init problem - codec still busy\n", chip->port);
 	if ((timeout & CS4231_MCE) == 0) {
@@ -549,7 +437,7 @@ static void snd_cs4231_mce_down(struct s
 
 	/* in 10ms increments, check condition, up to 100ms */
 	timeout = 10;
-	while (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT) {
+	while (__cs4231_readb(chip, CS4231U(chip, REGSEL)) & CS4231_INIT) {
 		spin_unlock_irqrestore(&chip->lock, flags);
 		if (--timeout < 0) {
 			snd_printk("mce_down - auto calibration time out (3)\n");
@@ -906,8 +794,8 @@ static int snd_cs4231_open(struct snd_cs
 		       CS4231_RECORD_IRQ |
 		       CS4231_TIMER_IRQ);
 	snd_cs4231_out(chip, CS4231_IRQ_STATUS, 0);
-	__cs4231_writeb(chip, 0, CS4231P(chip, STATUS));	/* clear IRQ */
-	__cs4231_writeb(chip, 0, CS4231P(chip, STATUS));	/* clear IRQ */
+	__cs4231_writeb(chip, 0, CS4231U(chip, STATUS));	/* clear IRQ */
+	__cs4231_writeb(chip, 0, CS4231U(chip, STATUS));	/* clear IRQ */
 
 	snd_cs4231_out(chip, CS4231_IRQ_STATUS, CS4231_PLAYBACK_IRQ |
 		       CS4231_RECORD_IRQ |
@@ -936,8 +824,8 @@ static void snd_cs4231_close(struct snd_
 	/* disable IRQ */
 	spin_lock_irqsave(&chip->lock, flags);
 	snd_cs4231_out(chip, CS4231_IRQ_STATUS, 0);
-	__cs4231_writeb(chip, 0, CS4231P(chip, STATUS));	/* clear IRQ */
-	__cs4231_writeb(chip, 0, CS4231P(chip, STATUS));	/* clear IRQ */
+	__cs4231_writeb(chip, 0, CS4231U(chip, STATUS));	/* clear IRQ */
+	__cs4231_writeb(chip, 0, CS4231U(chip, STATUS));	/* clear IRQ */
 
 	/* now disable record & playback */
 
@@ -958,8 +846,8 @@ static void snd_cs4231_close(struct snd_
 
 	/* clear IRQ again */
 	snd_cs4231_out(chip, CS4231_IRQ_STATUS, 0);
-	__cs4231_writeb(chip, 0, CS4231P(chip, STATUS));	/* clear IRQ */
-	__cs4231_writeb(chip, 0, CS4231P(chip, STATUS));	/* clear IRQ */
+	__cs4231_writeb(chip, 0, CS4231U(chip, STATUS));	/* clear IRQ */
+	__cs4231_writeb(chip, 0, CS4231U(chip, STATUS));	/* clear IRQ */
 	spin_unlock_irqrestore(&chip->lock, flags);
 
 	snd_cs4231_calibrate_mute(chip, 0);
@@ -1143,7 +1031,7 @@ static int __init snd_cs4231_probe(struc
 	id = vers = 0;
 	for (i = 0; i < 50; i++) {
 		mb();
-		if (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT)
+		if (__cs4231_readb(chip, CS4231U(chip, REGSEL)) & CS4231_INIT)
 			udelay(2000);
 		else {
 			spin_lock_irqsave(&chip->lock, flags);
@@ -1161,8 +1049,9 @@ static int __init snd_cs4231_probe(struc
 
 	spin_lock_irqsave(&chip->lock, flags);
 
-	__cs4231_readb(chip, CS4231P(chip, STATUS));	/* clear any pendings IRQ */
-	__cs4231_writeb(chip, 0, CS4231P(chip, STATUS));
+	/* clear any pendings IRQ */
+	__cs4231_readb(chip, CS4231U(chip, STATUS));
+	__cs4231_writeb(chip, 0, CS4231U(chip, STATUS));
 	mb();
 
 	spin_unlock_irqrestore(&chip->lock, flags);
@@ -1712,7 +1601,7 @@ static irqreturn_t snd_cs4231_sbus_inter
 	struct snd_cs4231 *chip = dev_id;
 
 	/*This is IRQ is not raised by the cs4231*/
-	if (!(__cs4231_readb(chip, CS4231P(chip, STATUS)) & CS4231_GLOBALIRQ))
+	if (!(__cs4231_readb(chip, CS4231U(chip, STATUS)) & CS4231_GLOBALIRQ))
 		return IRQ_NONE;
 
 	/* ACK the APC interrupt. */
