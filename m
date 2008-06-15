From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 2/2] ad1848: replace duplicated constants in
	cs4231
Date: Sun, 15 Jun 2008 12:41:28 +0200
Message-ID: <20080615124128.48486ddc.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id E71C0103818
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Jun 2008 12:38:25 +0200 (CEST)
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
Cc: Rene Herman <rene.herman@keyaccess.nl>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Use AD1848 register names in the cs4231 library as well.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This patch contains just mindless replacement
of names and should not contain any changes in the code.

diff -urp linux-ref/include/sound/cs4231-regs.h linux-mm/include/sound/cs4231-regs.h
--- linux-ref/include/sound/cs4231-regs.h	2008-06-15 12:16:32.452543595 +0200
+++ linux-mm/include/sound/cs4231-regs.h	2008-06-15 07:23:22.033524688 +0200
@@ -22,33 +22,14 @@
  *
  */
 
-/* IO ports */
+#include "ad1848-regs.h"
 
-#define CS4231P(x)		(c_d_c_CS4231##x)
+/* IO ports */
 
-#define c_d_c_CS4231REGSEL	0
-#define c_d_c_CS4231REG		1
-#define c_d_c_CS4231STATUS	2
-#define c_d_c_CS4231PIO		3
+#define CS4231P(x)		(c_d_c_AD1848##x)
 
 /* codec registers */
 
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
-#define CS4231_MISC_INFO	0x0c	/* miscellaneous information */
-#define CS4231_LOOPBACK		0x0d	/* loopback control */
-#define CS4231_PLY_UPR_CNT	0x0e	/* playback upper base count */
-#define CS4231_PLY_LWR_CNT	0x0f	/* playback lower base count */
 #define CS4231_ALT_FEATURE_1	0x10	/* alternate #1 feature enable */
 #define AD1845_AF1_MIC_LEFT	0x10	/* alternate #1 feature + MIC left */
 #define CS4231_ALT_FEATURE_2	0x11	/* alternate #2 feature enable */
@@ -76,16 +57,6 @@
 #define CS4231_REC_UPR_CNT	0x1e	/* record upper count */
 #define CS4231_REC_LWR_CNT	0x1f	/* record lower count */
 
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
 /* definitions for codec irq status */
 
 #define CS4231_PLAYBACK_IRQ	0x10
@@ -97,48 +68,10 @@
 #define CS4231_PLY_OVERRUN	0x02
 #define CS4231_PLY_UNDERRUN	0x01
 
-/* definitions for CS4231_LEFT_INPUT and CS4231_RIGHT_INPUT registers */
-
-#define CS4231_ENABLE_MIC_GAIN	0x20
-
-#define CS4231_MIXS_LINE	0x00
-#define CS4231_MIXS_AUX1	0x40
-#define CS4231_MIXS_MIC		0x80
-#define CS4231_MIXS_ALL		0xc0
-
 /* definitions for clock and data format register - CS4231_PLAYBK_FORMAT */
 
-#define CS4231_LINEAR_8		0x00	/* 8-bit unsigned data */
-#define CS4231_ALAW_8		0x60	/* 8-bit A-law companded */
-#define CS4231_ULAW_8		0x20	/* 8-bit U-law companded */
-#define CS4231_LINEAR_16	0x40	/* 16-bit twos complement data - little endian */
 #define CS4231_LINEAR_16_BIG	0xc0	/* 16-bit twos complement data - big endian */
 #define CS4231_ADPCM_16		0xa0	/* 16-bit ADPCM */
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
 
 /* definitions for misc control register - CS4231_MISC_INFO */
 
diff -urp linux-ref/sound/isa/cs423x/cs4231_lib.c linux-mm/sound/isa/cs423x/cs4231_lib.c
--- linux-ref/sound/isa/cs423x/cs4231_lib.c	2008-06-15 12:16:32.480545191 +0200
+++ linux-mm/sound/isa/cs423x/cs4231_lib.c	2008-06-15 12:13:35.000000000 +0200
@@ -51,20 +51,20 @@ MODULE_LICENSE("GPL");
  */
 
 static unsigned char freq_bits[14] = {
-	/* 5510 */	0x00 | CS4231_XTAL2,
-	/* 6620 */	0x0E | CS4231_XTAL2,
-	/* 8000 */	0x00 | CS4231_XTAL1,
-	/* 9600 */	0x0E | CS4231_XTAL1,
-	/* 11025 */	0x02 | CS4231_XTAL2,
-	/* 16000 */	0x02 | CS4231_XTAL1,
-	/* 18900 */	0x04 | CS4231_XTAL2,
-	/* 22050 */	0x06 | CS4231_XTAL2,
-	/* 27042 */	0x04 | CS4231_XTAL1,
-	/* 32000 */	0x06 | CS4231_XTAL1,
-	/* 33075 */	0x0C | CS4231_XTAL2,
-	/* 37800 */	0x08 | CS4231_XTAL2,
-	/* 44100 */	0x0A | CS4231_XTAL2,
-	/* 48000 */	0x0C | CS4231_XTAL1
+	/* 5510 */	0x00 | AD1848_XTAL2,
+	/* 6620 */	0x0E | AD1848_XTAL2,
+	/* 8000 */	0x00 | AD1848_XTAL1,
+	/* 9600 */	0x0E | AD1848_XTAL1,
+	/* 11025 */	0x02 | AD1848_XTAL2,
+	/* 16000 */	0x02 | AD1848_XTAL1,
+	/* 18900 */	0x04 | AD1848_XTAL2,
+	/* 22050 */	0x06 | AD1848_XTAL2,
+	/* 27042 */	0x04 | AD1848_XTAL1,
+	/* 32000 */	0x06 | AD1848_XTAL1,
+	/* 33075 */	0x0C | AD1848_XTAL2,
+	/* 37800 */	0x08 | AD1848_XTAL2,
+	/* 44100 */	0x0A | AD1848_XTAL2,
+	/* 48000 */	0x0C | AD1848_XTAL1
 };
 
 static unsigned int rates[14] = {
@@ -94,7 +94,7 @@ static unsigned char snd_cs4231_original
 	0xbf,			/* 06/06 - loc */
 	0xbf,			/* 07/07 - roc */
 	0x20,			/* 08/08 - pdfr */
-	CS4231_AUTOCALIB,	/* 09/09 - ic */
+	AD1848_AUTOCALIB,	/* 09/09 - ic */
 	0x00,			/* 0a/10 - pc */
 	0x00,			/* 0b/11 - ti */
 	CS4231_MODE2,		/* 0c/12 - mi */
@@ -174,7 +174,7 @@ static void snd_cs4231_wait(struct snd_c
 	int timeout;
 
 	for (timeout = 250;
-	     timeout > 0 && (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT);
+	     timeout > 0 && (cs4231_inb(chip, CS4231P(REGSEL)) & AD1848_INIT);
 	     timeout--)
 	     	udelay(100);
 }
@@ -186,7 +186,7 @@ static void snd_cs4231_outm(struct snd_c
 
 	snd_cs4231_wait(chip);
 #ifdef CONFIG_SND_DEBUG
-	if (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
+	if (cs4231_inb(chip, CS4231P(REGSEL)) & AD1848_INIT)
 		snd_printk("outm: auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
 #endif
 	chip->image[reg] = tmp;
@@ -203,7 +203,7 @@ static void snd_cs4231_dout(struct snd_c
 	int timeout;
 
 	for (timeout = 250;
-	     timeout > 0 && (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT);
+	     timeout > 0 && (cs4231_inb(chip, CS4231P(REGSEL)) & AD1848_INIT);
 	     timeout--)
 	     	udelay(10);
 	cs4231_outb(chip, CS4231P(REGSEL), chip->mce_bit | reg);
@@ -215,7 +215,7 @@ void snd_cs4231_out(struct snd_cs4231 *c
 {
 	snd_cs4231_wait(chip);
 #ifdef CONFIG_SND_DEBUG
-	if (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
+	if (cs4231_inb(chip, CS4231P(REGSEL)) & AD1848_INIT)
 		snd_printk("out: auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
 #endif
 	cs4231_outb(chip, CS4231P(REGSEL), chip->mce_bit | reg);
@@ -230,7 +230,7 @@ unsigned char snd_cs4231_in(struct snd_c
 {
 	snd_cs4231_wait(chip);
 #ifdef CONFIG_SND_DEBUG
-	if (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
+	if (cs4231_inb(chip, CS4231P(REGSEL)) & AD1848_INIT)
 		snd_printk("in: auto calibration time out - reg = 0x%x\n", reg);
 #endif
 	cs4231_outb(chip, CS4231P(REGSEL), chip->mce_bit | reg);
@@ -320,7 +320,7 @@ static void snd_cs4231_busy_wait(struct 
 		cs4231_inb(chip, CS4231P(REGSEL));
 	/* end of cleanup sequence */
 	for (timeout = 250;
-	     timeout > 0 && (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT);
+	     timeout > 0 && (cs4231_inb(chip, CS4231P(REGSEL)) & AD1848_INIT);
 	     timeout--)
 	     	udelay(10);
 }
@@ -332,15 +332,15 @@ void snd_cs4231_mce_up(struct snd_cs4231
 
 	snd_cs4231_wait(chip);
 #ifdef CONFIG_SND_DEBUG
-	if (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
+	if (cs4231_inb(chip, CS4231P(REGSEL)) & AD1848_INIT)
 		snd_printk("mce_up - auto calibration time out (0)\n");
 #endif
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	chip->mce_bit |= CS4231_MCE;
+	chip->mce_bit |= AD1848_MCE;
 	timeout = cs4231_inb(chip, CS4231P(REGSEL));
 	if (timeout == 0x80)
 		snd_printk("mce_up [0x%lx]: serious init problem - codec still busy\n", chip->port);
-	if (!(timeout & CS4231_MCE))
+	if (!(timeout & AD1848_MCE))
 		cs4231_outb(chip, CS4231P(REGSEL), chip->mce_bit | (timeout & 0x1f));
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
@@ -354,17 +354,17 @@ void snd_cs4231_mce_down(struct snd_cs42
 	snd_cs4231_busy_wait(chip);
 
 #ifdef CONFIG_SND_DEBUG
-	if (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
+	if (cs4231_inb(chip, CS4231P(REGSEL)) & AD1848_INIT)
 		snd_printk("mce_down [0x%lx] - auto calibration time out (0)\n", (long)CS4231P(REGSEL));
 #endif
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	chip->mce_bit &= ~CS4231_MCE;
+	chip->mce_bit &= ~AD1848_MCE;
 	timeout = cs4231_inb(chip, CS4231P(REGSEL));
 	cs4231_outb(chip, CS4231P(REGSEL), chip->mce_bit | (timeout & 0x1f));
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	if (timeout == 0x80)
 		snd_printk("mce_down [0x%lx]: serious init problem - codec still busy\n", chip->port);
-	if ((timeout & CS4231_MCE) == 0 ||
+	if ((timeout & AD1848_MCE) == 0 ||
 	    !(chip->hardware & (CS4231_HW_CS4231_MASK | CS4231_HW_CS4232_MASK))) {
 		return;
 	}
@@ -380,8 +380,8 @@ void snd_cs4231_mce_down(struct snd_cs42
 
 	/* check condition up to 250 ms */
 	end_time = jiffies + msecs_to_jiffies(250);
-	while (snd_cs4231_in(chip, CS4231_TEST_INIT) &
-		CS4231_CALIB_IN_PROGRESS) {
+	while (snd_cs4231_in(chip, AD1848_TEST_INIT) &
+		AD1848_CALIB_IN_PROGRESS) {
 
 		if (time_after(jiffies, end_time)) {
 			snd_printk(KERN_ERR "mce_down - "
@@ -395,7 +395,7 @@ void snd_cs4231_mce_down(struct snd_cs42
 
 	/* check condition up to 100 ms */
 	end_time = jiffies + msecs_to_jiffies(100);
-	while (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT) {
+	while (cs4231_inb(chip, CS4231P(REGSEL)) & AD1848_INIT) {
 		if (time_after(jiffies, end_time)) {
 			snd_printk(KERN_ERR "mce_down - auto calibration time out (3)\n");
 			return;
@@ -410,14 +410,14 @@ void snd_cs4231_mce_down(struct snd_cs42
 static unsigned int snd_cs4231_get_count(unsigned char format, unsigned int size)
 {
 	switch (format & 0xe0) {
-	case CS4231_LINEAR_16:
+	case AD1848_LINEAR_16:
 	case CS4231_LINEAR_16_BIG:
 		size >>= 1;
 		break;
 	case CS4231_ADPCM_16:
 		return size >> 2;
 	}
-	if (format & CS4231_STEREO)
+	if (format & AD1848_STEREO)
 		size >>= 1;
 	return size;
 }
@@ -449,24 +449,24 @@ static int snd_cs4231_trigger(struct snd
 	what = 0;
 	snd_pcm_group_for_each_entry(s, substream) {
 		if (s == chip->playback_substream) {
-			what |= CS4231_PLAYBACK_ENABLE;
+			what |= AD1848_PLAYBACK_ENABLE;
 			snd_pcm_trigger_done(s, substream);
 		} else if (s == chip->capture_substream) {
-			what |= CS4231_RECORD_ENABLE;
+			what |= AD1848_CAPTURE_ENABLE;
 			snd_pcm_trigger_done(s, substream);
 		}
 	}
 	spin_lock(&chip->reg_lock);
 	if (do_start) {
-		chip->image[CS4231_IFACE_CTRL] |= what;
+		chip->image[AD1848_IFACE_CTRL] |= what;
 		if (chip->trigger)
 			chip->trigger(chip, what, 1);
 	} else {
-		chip->image[CS4231_IFACE_CTRL] &= ~what;
+		chip->image[AD1848_IFACE_CTRL] &= ~what;
 		if (chip->trigger)
 			chip->trigger(chip, what, 0);
 	}
-	snd_cs4231_out(chip, CS4231_IFACE_CTRL, chip->image[CS4231_IFACE_CTRL]);
+	snd_cs4231_out(chip, AD1848_IFACE_CTRL, chip->image[AD1848_IFACE_CTRL]);
 	spin_unlock(&chip->reg_lock);
 #if 0
 	snd_cs4231_debug(chip);
@@ -495,16 +495,16 @@ static unsigned char snd_cs4231_get_form
 {
 	unsigned char rformat;
 
-	rformat = CS4231_LINEAR_8;
+	rformat = AD1848_LINEAR_8;
 	switch (format) {
-	case SNDRV_PCM_FORMAT_MU_LAW:	rformat = CS4231_ULAW_8; break;
-	case SNDRV_PCM_FORMAT_A_LAW:	rformat = CS4231_ALAW_8; break;
-	case SNDRV_PCM_FORMAT_S16_LE:	rformat = CS4231_LINEAR_16; break;
+	case SNDRV_PCM_FORMAT_MU_LAW:	rformat = AD1848_ULAW_8; break;
+	case SNDRV_PCM_FORMAT_A_LAW:	rformat = AD1848_ALAW_8; break;
+	case SNDRV_PCM_FORMAT_S16_LE:	rformat = AD1848_LINEAR_16; break;
 	case SNDRV_PCM_FORMAT_S16_BE:	rformat = CS4231_LINEAR_16_BIG; break;
 	case SNDRV_PCM_FORMAT_IMA_ADPCM:	rformat = CS4231_ADPCM_16; break;
 	}
 	if (channels > 1)
-		rformat |= CS4231_STEREO;
+		rformat |= AD1848_STEREO;
 #if 0
 	snd_printk("get_format: 0x%x (mode=0x%x)\n", format, mode);
 #endif
@@ -522,16 +522,16 @@ static void snd_cs4231_calibrate_mute(st
 		return;
 	}
 	if (!mute) {
-		snd_cs4231_dout(chip, CS4231_LEFT_INPUT, chip->image[CS4231_LEFT_INPUT]);
-		snd_cs4231_dout(chip, CS4231_RIGHT_INPUT, chip->image[CS4231_RIGHT_INPUT]);
-		snd_cs4231_dout(chip, CS4231_LOOPBACK, chip->image[CS4231_LOOPBACK]);
-	}
-	snd_cs4231_dout(chip, CS4231_AUX1_LEFT_INPUT, mute ? 0x80 : chip->image[CS4231_AUX1_LEFT_INPUT]);
-	snd_cs4231_dout(chip, CS4231_AUX1_RIGHT_INPUT, mute ? 0x80 : chip->image[CS4231_AUX1_RIGHT_INPUT]);
-	snd_cs4231_dout(chip, CS4231_AUX2_LEFT_INPUT, mute ? 0x80 : chip->image[CS4231_AUX2_LEFT_INPUT]);
-	snd_cs4231_dout(chip, CS4231_AUX2_RIGHT_INPUT, mute ? 0x80 : chip->image[CS4231_AUX2_RIGHT_INPUT]);
-	snd_cs4231_dout(chip, CS4231_LEFT_OUTPUT, mute ? 0x80 : chip->image[CS4231_LEFT_OUTPUT]);
-	snd_cs4231_dout(chip, CS4231_RIGHT_OUTPUT, mute ? 0x80 : chip->image[CS4231_RIGHT_OUTPUT]);
+		snd_cs4231_dout(chip, AD1848_LEFT_INPUT, chip->image[AD1848_LEFT_INPUT]);
+		snd_cs4231_dout(chip, AD1848_RIGHT_INPUT, chip->image[AD1848_RIGHT_INPUT]);
+		snd_cs4231_dout(chip, AD1848_LOOPBACK, chip->image[AD1848_LOOPBACK]);
+	}
+	snd_cs4231_dout(chip, AD1848_AUX1_LEFT_INPUT, mute ? 0x80 : chip->image[AD1848_AUX1_LEFT_INPUT]);
+	snd_cs4231_dout(chip, AD1848_AUX1_RIGHT_INPUT, mute ? 0x80 : chip->image[AD1848_AUX1_RIGHT_INPUT]);
+	snd_cs4231_dout(chip, AD1848_AUX2_LEFT_INPUT, mute ? 0x80 : chip->image[AD1848_AUX2_LEFT_INPUT]);
+	snd_cs4231_dout(chip, AD1848_AUX2_RIGHT_INPUT, mute ? 0x80 : chip->image[AD1848_AUX2_RIGHT_INPUT]);
+	snd_cs4231_dout(chip, AD1848_LEFT_OUTPUT, mute ? 0x80 : chip->image[AD1848_LEFT_OUTPUT]);
+	snd_cs4231_dout(chip, AD1848_RIGHT_OUTPUT, mute ? 0x80 : chip->image[AD1848_RIGHT_OUTPUT]);
 	snd_cs4231_dout(chip, CS4231_LEFT_LINE_IN, mute ? 0x80 : chip->image[CS4231_LEFT_LINE_IN]);
 	snd_cs4231_dout(chip, CS4231_RIGHT_LINE_IN, mute ? 0x80 : chip->image[CS4231_RIGHT_LINE_IN]);
 	snd_cs4231_dout(chip, CS4231_MONO_CTRL, mute ? 0xc0 : chip->image[CS4231_MONO_CTRL]);
@@ -557,9 +557,9 @@ static void snd_cs4231_playback_format(s
 	if (chip->hardware == CS4231_HW_CS4231A ||
 	    (chip->hardware & CS4231_HW_CS4232_MASK)) {
 		spin_lock_irqsave(&chip->reg_lock, flags);
-		if ((chip->image[CS4231_PLAYBK_FORMAT] & 0x0f) == (pdfr & 0x0f)) {	/* rate is same? */
+		if ((chip->image[AD1848_DATA_FORMAT] & 0x0f) == (pdfr & 0x0f)) {	/* rate is same? */
 			snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1] | 0x10);
-			snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT, chip->image[CS4231_PLAYBK_FORMAT] = pdfr);
+			snd_cs4231_out(chip, AD1848_DATA_FORMAT, chip->image[AD1848_DATA_FORMAT] = pdfr);
 			snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1] &= ~0x10);
 			udelay(100); /* Fixes audible clicks at least on GUS MAX */
 			full_calib = 0;
@@ -570,12 +570,12 @@ static void snd_cs4231_playback_format(s
 		snd_cs4231_mce_up(chip);
 		spin_lock_irqsave(&chip->reg_lock, flags);
 		if (chip->hardware != CS4231_HW_INTERWAVE && !chip->single_dma) {
-			snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT,
-					(chip->image[CS4231_IFACE_CTRL] & CS4231_RECORD_ENABLE) ?
+			snd_cs4231_out(chip, AD1848_DATA_FORMAT,
+					(chip->image[AD1848_IFACE_CTRL] & AD1848_CAPTURE_ENABLE) ?
 					(pdfr & 0xf0) | (chip->image[CS4231_REC_FORMAT] & 0x0f) :
 				        pdfr);
 		} else {
-			snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT, chip->image[CS4231_PLAYBK_FORMAT] = pdfr);
+			snd_cs4231_out(chip, AD1848_DATA_FORMAT, chip->image[AD1848_DATA_FORMAT] = pdfr);
 		}
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
 		if (chip->hardware == CS4231_HW_OPL3SA2)
@@ -598,8 +598,8 @@ static void snd_cs4231_capture_format(st
 	if (chip->hardware == CS4231_HW_CS4231A ||
 	    (chip->hardware & CS4231_HW_CS4232_MASK)) {
 		spin_lock_irqsave(&chip->reg_lock, flags);
-		if ((chip->image[CS4231_PLAYBK_FORMAT] & 0x0f) == (cdfr & 0x0f) ||	/* rate is same? */
-		    (chip->image[CS4231_IFACE_CTRL] & CS4231_PLAYBACK_ENABLE)) {
+		if ((chip->image[AD1848_DATA_FORMAT] & 0x0f) == (cdfr & 0x0f) ||	/* rate is same? */
+		    (chip->image[AD1848_IFACE_CTRL] & AD1848_PLAYBACK_ENABLE)) {
 			snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1] | 0x20);
 			snd_cs4231_out(chip, CS4231_REC_FORMAT, chip->image[CS4231_REC_FORMAT] = cdfr);
 			snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1] &= ~0x20);
@@ -611,9 +611,9 @@ static void snd_cs4231_capture_format(st
 		snd_cs4231_mce_up(chip);
 		spin_lock_irqsave(&chip->reg_lock, flags);
 		if (chip->hardware != CS4231_HW_INTERWAVE) {
-			if (!(chip->image[CS4231_IFACE_CTRL] & CS4231_PLAYBACK_ENABLE)) {
-				snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT,
-					       ((chip->single_dma ? cdfr : chip->image[CS4231_PLAYBK_FORMAT]) & 0xf0) |
+			if (!(chip->image[AD1848_IFACE_CTRL] & AD1848_PLAYBACK_ENABLE)) {
+				snd_cs4231_out(chip, AD1848_DATA_FORMAT,
+					       ((chip->single_dma ? cdfr : chip->image[AD1848_DATA_FORMAT]) & 0xf0) |
 					       (cdfr & 0x0f));
 				spin_unlock_irqrestore(&chip->reg_lock, flags);
 				snd_cs4231_mce_down(chip);
@@ -639,7 +639,7 @@ static unsigned long snd_cs4231_timer_re
 	if (chip->hardware & CS4231_HW_CS4236B_MASK)
 		return 14467;
 	else
-		return chip->image[CS4231_PLAYBK_FORMAT] & 1 ? 9969 : 9920;
+		return chip->image[AD1848_DATA_FORMAT] & 1 ? 9969 : 9920;
 }
 
 static int snd_cs4231_timer_start(struct snd_timer * timer)
@@ -681,11 +681,11 @@ static void snd_cs4231_init(struct snd_c
 #endif
 	snd_cs4231_mce_up(chip);
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	chip->image[CS4231_IFACE_CTRL] &= ~(CS4231_PLAYBACK_ENABLE | CS4231_PLAYBACK_PIO |
-			     CS4231_RECORD_ENABLE | CS4231_RECORD_PIO |
-			     CS4231_CALIB_MODE);
-	chip->image[CS4231_IFACE_CTRL] |= CS4231_AUTOCALIB;
-	snd_cs4231_out(chip, CS4231_IFACE_CTRL, chip->image[CS4231_IFACE_CTRL]);
+	chip->image[AD1848_IFACE_CTRL] &= ~(AD1848_PLAYBACK_ENABLE | AD1848_PLAYBACK_PIO |
+			     AD1848_CAPTURE_ENABLE | AD1848_CAPTURE_PIO |
+			     AD1848_CALIB_MODE);
+	chip->image[AD1848_IFACE_CTRL] |= AD1848_AUTOCALIB;
+	snd_cs4231_out(chip, AD1848_IFACE_CTRL, chip->image[AD1848_IFACE_CTRL]);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	snd_cs4231_mce_down(chip);
 
@@ -709,7 +709,7 @@ static void snd_cs4231_init(struct snd_c
 
 	snd_cs4231_mce_up(chip);
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT, chip->image[CS4231_PLAYBK_FORMAT]);
+	snd_cs4231_out(chip, AD1848_DATA_FORMAT, chip->image[AD1848_DATA_FORMAT]);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	snd_cs4231_mce_down(chip);
 
@@ -751,8 +751,8 @@ static int snd_cs4231_open(struct snd_cs
 	snd_cs4231_out(chip, CS4231_IRQ_STATUS, 0);
 	cs4231_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
 	cs4231_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
-	chip->image[CS4231_PIN_CTRL] |= CS4231_IRQ_ENABLE;
-	snd_cs4231_out(chip, CS4231_PIN_CTRL, chip->image[CS4231_PIN_CTRL]);
+	chip->image[AD1848_PIN_CTRL] |= AD1848_IRQ_ENABLE;
+	snd_cs4231_out(chip, AD1848_PIN_CTRL, chip->image[AD1848_PIN_CTRL]);
 	snd_cs4231_out(chip, CS4231_IRQ_STATUS, CS4231_PLAYBACK_IRQ |
 		       CS4231_RECORD_IRQ |
 		       CS4231_TIMER_IRQ);
@@ -781,19 +781,19 @@ static void snd_cs4231_close(struct snd_
 	snd_cs4231_out(chip, CS4231_IRQ_STATUS, 0);
 	cs4231_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
 	cs4231_outb(chip, CS4231P(STATUS), 0);	/* clear IRQ */
-	chip->image[CS4231_PIN_CTRL] &= ~CS4231_IRQ_ENABLE;
-	snd_cs4231_out(chip, CS4231_PIN_CTRL, chip->image[CS4231_PIN_CTRL]);
+	chip->image[AD1848_PIN_CTRL] &= ~AD1848_IRQ_ENABLE;
+	snd_cs4231_out(chip, AD1848_PIN_CTRL, chip->image[AD1848_PIN_CTRL]);
 
 	/* now disable record & playback */
 
-	if (chip->image[CS4231_IFACE_CTRL] & (CS4231_PLAYBACK_ENABLE | CS4231_PLAYBACK_PIO |
-					       CS4231_RECORD_ENABLE | CS4231_RECORD_PIO)) {
+	if (chip->image[AD1848_IFACE_CTRL] & (AD1848_PLAYBACK_ENABLE | AD1848_PLAYBACK_PIO |
+					       AD1848_CAPTURE_ENABLE | AD1848_CAPTURE_PIO)) {
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
 		snd_cs4231_mce_up(chip);
 		spin_lock_irqsave(&chip->reg_lock, flags);
-		chip->image[CS4231_IFACE_CTRL] &= ~(CS4231_PLAYBACK_ENABLE | CS4231_PLAYBACK_PIO |
-						     CS4231_RECORD_ENABLE | CS4231_RECORD_PIO);
-		snd_cs4231_out(chip, CS4231_IFACE_CTRL, chip->image[CS4231_IFACE_CTRL]);
+		chip->image[AD1848_IFACE_CTRL] &= ~(AD1848_PLAYBACK_ENABLE | AD1848_PLAYBACK_PIO |
+						     AD1848_CAPTURE_ENABLE | AD1848_CAPTURE_PIO);
+		snd_cs4231_out(chip, AD1848_IFACE_CTRL, chip->image[AD1848_IFACE_CTRL]);
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
 		snd_cs4231_mce_down(chip);
 		spin_lock_irqsave(&chip->reg_lock, flags);
@@ -875,11 +875,11 @@ static int snd_cs4231_playback_prepare(s
 
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	chip->p_dma_size = size;
-	chip->image[CS4231_IFACE_CTRL] &= ~(CS4231_PLAYBACK_ENABLE | CS4231_PLAYBACK_PIO);
+	chip->image[AD1848_IFACE_CTRL] &= ~(AD1848_PLAYBACK_ENABLE | AD1848_PLAYBACK_PIO);
 	snd_dma_program(chip->dma1, runtime->dma_addr, size, DMA_MODE_WRITE | DMA_AUTOINIT);
-	count = snd_cs4231_get_count(chip->image[CS4231_PLAYBK_FORMAT], count) - 1;
-	snd_cs4231_out(chip, CS4231_PLY_LWR_CNT, (unsigned char) count);
-	snd_cs4231_out(chip, CS4231_PLY_UPR_CNT, (unsigned char) (count >> 8));
+	count = snd_cs4231_get_count(chip->image[AD1848_DATA_FORMAT], count) - 1;
+	snd_cs4231_out(chip, AD1848_DATA_LWR_CNT, (unsigned char) count);
+	snd_cs4231_out(chip, AD1848_DATA_UPR_CNT, (unsigned char) (count >> 8));
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 #if 0
 	snd_cs4231_debug(chip);
@@ -917,12 +917,12 @@ static int snd_cs4231_capture_prepare(st
 
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	chip->c_dma_size = size;
-	chip->image[CS4231_IFACE_CTRL] &= ~(CS4231_RECORD_ENABLE | CS4231_RECORD_PIO);
+	chip->image[AD1848_IFACE_CTRL] &= ~(AD1848_CAPTURE_ENABLE | AD1848_CAPTURE_PIO);
 	snd_dma_program(chip->dma2, runtime->dma_addr, size, DMA_MODE_READ | DMA_AUTOINIT);
 	count = snd_cs4231_get_count(chip->image[CS4231_REC_FORMAT], count) - 1;
 	if (chip->single_dma && chip->hardware != CS4231_HW_INTERWAVE) {
-		snd_cs4231_out(chip, CS4231_PLY_LWR_CNT, (unsigned char) count);
-		snd_cs4231_out(chip, CS4231_PLY_UPR_CNT, (unsigned char) (count >> 8));
+		snd_cs4231_out(chip, AD1848_DATA_LWR_CNT, (unsigned char) count);
+		snd_cs4231_out(chip, AD1848_DATA_UPR_CNT, (unsigned char) (count >> 8));
 	} else {
 		snd_cs4231_out(chip, CS4231_REC_LWR_CNT, (unsigned char) count);
 		snd_cs4231_out(chip, CS4231_REC_UPR_CNT, (unsigned char) (count >> 8));
@@ -937,7 +937,7 @@ void snd_cs4231_overrange(struct snd_cs4
 	unsigned char res;
 
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	res = snd_cs4231_in(chip, CS4231_TEST_INIT);
+	res = snd_cs4231_in(chip, AD1848_TEST_INIT);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	if (res & (0x08 | 0x02))	/* detect overrange only above 0dB; may be user selectable? */
 		chip->capture_substream->runtime->overrange++;
@@ -990,7 +990,7 @@ static snd_pcm_uframes_t snd_cs4231_play
 	struct snd_cs4231 *chip = snd_pcm_substream_chip(substream);
 	size_t ptr;
 
-	if (!(chip->image[CS4231_IFACE_CTRL] & CS4231_PLAYBACK_ENABLE))
+	if (!(chip->image[AD1848_IFACE_CTRL] & AD1848_PLAYBACK_ENABLE))
 		return 0;
 	ptr = snd_dma_pointer(chip->dma1, chip->p_dma_size);
 	return bytes_to_frames(substream->runtime, ptr);
@@ -1001,7 +1001,7 @@ static snd_pcm_uframes_t snd_cs4231_capt
 	struct snd_cs4231 *chip = snd_pcm_substream_chip(substream);
 	size_t ptr;
 	
-	if (!(chip->image[CS4231_IFACE_CTRL] & CS4231_RECORD_ENABLE))
+	if (!(chip->image[AD1848_IFACE_CTRL] & AD1848_CAPTURE_ENABLE))
 		return 0;
 	ptr = snd_dma_pointer(chip->dma2, chip->c_dma_size);
 	return bytes_to_frames(substream->runtime, ptr);
@@ -1024,12 +1024,12 @@ static int snd_cs4231_probe(struct snd_c
 	id = 0;
 	for (i = 0; i < 50; i++) {
 		mb();
-		if (cs4231_inb(chip, CS4231P(REGSEL)) & CS4231_INIT)
+		if (cs4231_inb(chip, CS4231P(REGSEL)) & AD1848_INIT)
 			udelay(2000);
 		else {
 			spin_lock_irqsave(&chip->reg_lock, flags);
-			snd_cs4231_out(chip, CS4231_MISC_INFO, CS4231_MODE2);
-			id = snd_cs4231_in(chip, CS4231_MISC_INFO) & 0x0f;
+			snd_cs4231_out(chip, AD1848_MISC_INFO, CS4231_MODE2);
+			id = snd_cs4231_in(chip, AD1848_MISC_INFO) & 0x0f;
 			spin_unlock_irqrestore(&chip->reg_lock, flags);
 			if (id == 0x0a)
 				break;	/* this is valid value */
@@ -1070,10 +1070,10 @@ static int snd_cs4231_probe(struct snd_c
 	mb();
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 
-	chip->image[CS4231_MISC_INFO] = CS4231_MODE2;
+	chip->image[AD1848_MISC_INFO] = CS4231_MODE2;
 	switch (chip->hardware) {
 	case CS4231_HW_INTERWAVE:
-		chip->image[CS4231_MISC_INFO] = CS4231_IW_MODE3;
+		chip->image[AD1848_MISC_INFO] = CS4231_IW_MODE3;
 		break;
 	case CS4231_HW_CS4235:
 	case CS4231_HW_CS4236B:
@@ -1081,15 +1081,15 @@ static int snd_cs4231_probe(struct snd_c
 	case CS4231_HW_CS4238B:
 	case CS4231_HW_CS4239:
 		if (hw == CS4231_HW_DETECT3)
-			chip->image[CS4231_MISC_INFO] = CS4231_4236_MODE3;
+			chip->image[AD1848_MISC_INFO] = CS4231_4236_MODE3;
 		else
 			chip->hardware = CS4231_HW_CS4236;
 		break;
 	}
 
-	chip->image[CS4231_IFACE_CTRL] =
-	    (chip->image[CS4231_IFACE_CTRL] & ~CS4231_SINGLE_DMA) |
-	    (chip->single_dma ? CS4231_SINGLE_DMA : 0);
+	chip->image[AD1848_IFACE_CTRL] =
+	    (chip->image[AD1848_IFACE_CTRL] & ~AD1848_SINGLE_DMA) |
+	    (chip->single_dma ? AD1848_SINGLE_DMA : 0);
 	if (chip->hardware != CS4231_HW_OPTI93X) {
 		chip->image[CS4231_ALT_FEATURE_1] = 0x80;
 		chip->image[CS4231_ALT_FEATURE_2] =
@@ -1355,13 +1355,13 @@ static void snd_cs4231_resume(struct snd
 	   */
 	snd_cs4231_busy_wait(chip);
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	chip->mce_bit &= ~CS4231_MCE;
+	chip->mce_bit &= ~AD1848_MCE;
 	timeout = cs4231_inb(chip, CS4231P(REGSEL));
 	cs4231_outb(chip, CS4231P(REGSEL), chip->mce_bit | (timeout & 0x1f));
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	if (timeout == 0x80)
 		snd_printk("down [0x%lx]: serious init problem - codec still busy\n", chip->port);
-	if ((timeout & CS4231_MCE) == 0 ||
+	if ((timeout & AD1848_MCE) == 0 ||
 	    !(chip->hardware & (CS4231_HW_CS4231_MASK | CS4231_HW_CS4232_MASK))) {
 		return;
 	}
@@ -1665,8 +1665,8 @@ static int snd_cs4231_get_mux(struct snd
 	unsigned long flags;
 	
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	ucontrol->value.enumerated.item[0] = (chip->image[CS4231_LEFT_INPUT] & CS4231_MIXS_ALL) >> 6;
-	ucontrol->value.enumerated.item[1] = (chip->image[CS4231_RIGHT_INPUT] & CS4231_MIXS_ALL) >> 6;
+	ucontrol->value.enumerated.item[0] = (chip->image[AD1848_LEFT_INPUT] & AD1848_MIXS_ALL) >> 6;
+	ucontrol->value.enumerated.item[1] = (chip->image[AD1848_RIGHT_INPUT] & AD1848_MIXS_ALL) >> 6;
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	return 0;
 }
@@ -1684,12 +1684,12 @@ static int snd_cs4231_put_mux(struct snd
 	left = ucontrol->value.enumerated.item[0] << 6;
 	right = ucontrol->value.enumerated.item[1] << 6;
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	left = (chip->image[CS4231_LEFT_INPUT] & ~CS4231_MIXS_ALL) | left;
-	right = (chip->image[CS4231_RIGHT_INPUT] & ~CS4231_MIXS_ALL) | right;
-	change = left != chip->image[CS4231_LEFT_INPUT] ||
-	         right != chip->image[CS4231_RIGHT_INPUT];
-	snd_cs4231_out(chip, CS4231_LEFT_INPUT, left);
-	snd_cs4231_out(chip, CS4231_RIGHT_INPUT, right);
+	left = (chip->image[AD1848_LEFT_INPUT] & ~AD1848_MIXS_ALL) | left;
+	right = (chip->image[AD1848_RIGHT_INPUT] & ~AD1848_MIXS_ALL) | right;
+	change = left != chip->image[AD1848_LEFT_INPUT] ||
+		 right != chip->image[AD1848_RIGHT_INPUT];
+	snd_cs4231_out(chip, AD1848_LEFT_INPUT, left);
+	snd_cs4231_out(chip, AD1848_RIGHT_INPUT, right);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	return change;
 }
@@ -1810,19 +1810,19 @@ int snd_cs4231_put_double(struct snd_kco
 }
 
 static struct snd_kcontrol_new snd_cs4231_controls[] = {
-CS4231_DOUBLE("PCM Playback Switch", 0, CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("PCM Playback Volume", 0, CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 63, 1),
+CS4231_DOUBLE("PCM Playback Switch", 0, AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT, 7, 7, 1, 1),
+CS4231_DOUBLE("PCM Playback Volume", 0, AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT, 0, 0, 63, 1),
 CS4231_DOUBLE("Line Playback Switch", 0, CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 7, 7, 1, 1),
 CS4231_DOUBLE("Line Playback Volume", 0, CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 0, 0, 31, 1),
-CS4231_DOUBLE("Aux Playback Switch", 0, CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("Aux Playback Volume", 0, CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 0, 0, 31, 1),
-CS4231_DOUBLE("Aux Playback Switch", 1, CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("Aux Playback Volume", 1, CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 0, 0, 31, 1),
+CS4231_DOUBLE("Aux Playback Switch", 0, AD1848_AUX1_LEFT_INPUT, AD1848_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
+CS4231_DOUBLE("Aux Playback Volume", 0, AD1848_AUX1_LEFT_INPUT, AD1848_AUX1_RIGHT_INPUT, 0, 0, 31, 1),
+CS4231_DOUBLE("Aux Playback Switch", 1, AD1848_AUX2_LEFT_INPUT, AD1848_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
+CS4231_DOUBLE("Aux Playback Volume", 1, AD1848_AUX2_LEFT_INPUT, AD1848_AUX2_RIGHT_INPUT, 0, 0, 31, 1),
 CS4231_SINGLE("Mono Playback Switch", 0, CS4231_MONO_CTRL, 7, 1, 1),
 CS4231_SINGLE("Mono Playback Volume", 0, CS4231_MONO_CTRL, 0, 15, 1),
 CS4231_SINGLE("Mono Output Playback Switch", 0, CS4231_MONO_CTRL, 6, 1, 1),
 CS4231_SINGLE("Mono Output Playback Bypass", 0, CS4231_MONO_CTRL, 5, 1, 0),
-CS4231_DOUBLE("Capture Volume", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 0, 0, 15, 0),
+CS4231_DOUBLE("Capture Volume", 0, AD1848_LEFT_INPUT, AD1848_RIGHT_INPUT, 0, 0, 15, 0),
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Capture Source",
@@ -1830,24 +1830,24 @@ CS4231_DOUBLE("Capture Volume", 0, CS423
 	.get = snd_cs4231_get_mux,
 	.put = snd_cs4231_put_mux,
 },
-CS4231_DOUBLE("Mic Boost", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 5, 5, 1, 0),
-CS4231_SINGLE("Loopback Capture Switch", 0, CS4231_LOOPBACK, 0, 1, 0),
-CS4231_SINGLE("Loopback Capture Volume", 0, CS4231_LOOPBACK, 2, 63, 1)
+CS4231_DOUBLE("Mic Boost", 0, AD1848_LEFT_INPUT, AD1848_RIGHT_INPUT, 5, 5, 1, 0),
+CS4231_SINGLE("Loopback Capture Switch", 0, AD1848_LOOPBACK, 0, 1, 0),
+CS4231_SINGLE("Loopback Capture Volume", 0, AD1848_LOOPBACK, 2, 63, 1)
 };
-                                        
+
 static struct snd_kcontrol_new snd_opti93x_controls[] = {
 CS4231_DOUBLE("Master Playback Switch", 0,
 	      OPTi93X_OUT_LEFT, OPTi93X_OUT_RIGHT, 7, 7, 1, 1),
 CS4231_DOUBLE("Master Playback Volume", 0,
 	      OPTi93X_OUT_LEFT, OPTi93X_OUT_RIGHT, 1, 1, 31, 1),
 CS4231_DOUBLE("PCM Playback Switch", 0,
-	      CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
+	      AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT, 7, 7, 1, 1),
 CS4231_DOUBLE("PCM Playback Volume", 0,
-	      CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 31, 1),
+	      AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT, 0, 0, 31, 1),
 CS4231_DOUBLE("FM Playback Switch", 0,
-	      CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
+	      AD1848_AUX2_LEFT_INPUT, AD1848_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
 CS4231_DOUBLE("FM Playback Volume", 0,
-	      CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 1, 1, 15, 1),
+	      AD1848_AUX2_LEFT_INPUT, AD1848_AUX2_RIGHT_INPUT, 1, 1, 15, 1),
 CS4231_DOUBLE("Line Playback Switch", 0,
 	      CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 7, 7, 1, 1),
 CS4231_DOUBLE("Line Playback Volume", 0,
@@ -1857,17 +1857,17 @@ CS4231_DOUBLE("Mic Playback Switch", 0,
 CS4231_DOUBLE("Mic Playback Volume", 0,
 	      OPTi93X_MIC_LEFT_INPUT, OPTi93X_MIC_RIGHT_INPUT, 1, 1, 15, 1),
 CS4231_DOUBLE("Mic Boost", 0,
-	      CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 5, 5, 1, 0),
+	      AD1848_LEFT_INPUT, AD1848_RIGHT_INPUT, 5, 5, 1, 0),
 CS4231_DOUBLE("CD Playback Switch", 0,
-	      CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
+	      AD1848_AUX1_LEFT_INPUT, AD1848_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
 CS4231_DOUBLE("CD Playback Volume", 0,
-	      CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 1, 1, 15, 1),
+	      AD1848_AUX1_LEFT_INPUT, AD1848_AUX1_RIGHT_INPUT, 1, 1, 15, 1),
 CS4231_DOUBLE("Aux Playback Switch", 0,
 	      OPTi931_AUX_LEFT_INPUT, OPTi931_AUX_RIGHT_INPUT, 7, 7, 1, 1),
 CS4231_DOUBLE("Aux Playback Volume", 0,
 	      OPTi931_AUX_LEFT_INPUT, OPTi931_AUX_RIGHT_INPUT, 1, 1, 15, 1),
 CS4231_DOUBLE("Capture Volume", 0,
-	      CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 0, 0, 15, 0),
+	      AD1848_LEFT_INPUT, AD1848_RIGHT_INPUT, 0, 0, 15, 0),
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Capture Source",
diff -urp linux-ref/sound/isa/cs423x/cs4236_lib.c linux-mm/sound/isa/cs423x/cs4236_lib.c
--- linux-ref/sound/isa/cs423x/cs4236_lib.c	2008-06-15 12:16:32.492545497 +0200
+++ linux-mm/sound/isa/cs423x/cs4236_lib.c	2008-06-15 07:23:22.069571493 +0200
@@ -188,7 +188,7 @@ static void snd_cs4236_playback_format(s
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	/* set fast playback format change and clean playback FIFO */
 	snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1] | 0x10);
-	snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT, pdfr & 0xf0);
+	snd_cs4231_out(chip, AD1848_DATA_FORMAT, pdfr & 0xf0);
 	snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1] & ~0x10);
 	snd_cs4236_ext_out(chip, CS4236_DAC_RATE, rate);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
@@ -330,12 +330,12 @@ int snd_cs4236_create(struct snd_card *c
 		snd_cs4236_ext_out(chip, CS4236_I23VAL(reg), snd_cs4236_ext_map[reg]);
 
         /* initialize compatible but more featured registers */
-	snd_cs4231_out(chip, CS4231_LEFT_INPUT, 0x40);
-	snd_cs4231_out(chip, CS4231_RIGHT_INPUT, 0x40);
-	snd_cs4231_out(chip, CS4231_AUX1_LEFT_INPUT, 0xff);
-	snd_cs4231_out(chip, CS4231_AUX1_RIGHT_INPUT, 0xff);
-	snd_cs4231_out(chip, CS4231_AUX2_LEFT_INPUT, 0xdf);
-	snd_cs4231_out(chip, CS4231_AUX2_RIGHT_INPUT, 0xdf);
+	snd_cs4231_out(chip, AD1848_LEFT_INPUT, 0x40);
+	snd_cs4231_out(chip, AD1848_RIGHT_INPUT, 0x40);
+	snd_cs4231_out(chip, AD1848_AUX1_LEFT_INPUT, 0xff);
+	snd_cs4231_out(chip, AD1848_AUX1_RIGHT_INPUT, 0xff);
+	snd_cs4231_out(chip, AD1848_AUX2_LEFT_INPUT, 0xdf);
+	snd_cs4231_out(chip, AD1848_AUX2_RIGHT_INPUT, 0xdf);
 	snd_cs4231_out(chip, CS4231_RIGHT_LINE_IN, 0xff);
 	snd_cs4231_out(chip, CS4231_LEFT_LINE_IN, 0xff);
 	snd_cs4231_out(chip, CS4231_RIGHT_LINE_IN, 0xff);
@@ -715,8 +715,8 @@ CS4236_MASTER_DIGITAL("Master Digital Vo
 
 CS4236_DOUBLE("Capture Boost Volume", 0, CS4236_LEFT_MIX_CTRL, CS4236_RIGHT_MIX_CTRL, 5, 5, 3, 1),
 
-CS4231_DOUBLE("PCM Playback Switch", 0, CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("PCM Playback Volume", 0, CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 63, 1),
+CS4231_DOUBLE("PCM Playback Switch", 0, AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT, 7, 7, 1, 1),
+CS4231_DOUBLE("PCM Playback Volume", 0, AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT, 0, 0, 63, 1),
 
 CS4236_DOUBLE("DSP Playback Switch", 0, CS4236_LEFT_DSP, CS4236_RIGHT_DSP, 7, 7, 1, 1),
 CS4236_DOUBLE("DSP Playback Volume", 0, CS4236_LEFT_DSP, CS4236_RIGHT_DSP, 0, 0, 63, 1),
@@ -737,25 +737,25 @@ CS4236_DOUBLE("Mic Capture Switch", 0, C
 CS4236_DOUBLE("Mic Volume", 0, CS4236_LEFT_MIC, CS4236_RIGHT_MIC, 0, 0, 31, 1),
 CS4236_DOUBLE("Mic Playback Boost", 0, CS4236_LEFT_MIC, CS4236_RIGHT_MIC, 5, 5, 1, 0),
 
-CS4231_DOUBLE("Line Playback Switch", 0, CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("Line Volume", 0, CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 0, 0, 31, 1),
-CS4231_DOUBLE("Line Capture Switch", 0, CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 6, 6, 1, 1),
-CS4231_DOUBLE("Line Capture Bypass", 0, CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 5, 5, 1, 1),
-
-CS4231_DOUBLE("CD Playback Switch", 0, CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("CD Volume", 0, CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 0, 0, 31, 1),
-CS4231_DOUBLE("CD Capture Switch", 0, CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 6, 6, 1, 1),
+CS4231_DOUBLE("Line Playback Switch", 0, AD1848_AUX1_LEFT_INPUT, AD1848_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
+CS4231_DOUBLE("Line Volume", 0, AD1848_AUX1_LEFT_INPUT, AD1848_AUX1_RIGHT_INPUT, 0, 0, 31, 1),
+CS4231_DOUBLE("Line Capture Switch", 0, AD1848_AUX1_LEFT_INPUT, AD1848_AUX1_RIGHT_INPUT, 6, 6, 1, 1),
+CS4231_DOUBLE("Line Capture Bypass", 0, AD1848_AUX1_LEFT_INPUT, AD1848_AUX1_RIGHT_INPUT, 5, 5, 1, 1),
+
+CS4231_DOUBLE("CD Playback Switch", 0, AD1848_AUX2_LEFT_INPUT, AD1848_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
+CS4231_DOUBLE("CD Volume", 0, AD1848_AUX2_LEFT_INPUT, AD1848_AUX2_RIGHT_INPUT, 0, 0, 31, 1),
+CS4231_DOUBLE("CD Capture Switch", 0, AD1848_AUX2_LEFT_INPUT, AD1848_AUX2_RIGHT_INPUT, 6, 6, 1, 1),
 
 CS4236_DOUBLE1("Mono Output Playback Switch", 0, CS4231_MONO_CTRL, CS4236_RIGHT_MIX_CTRL, 6, 7, 1, 1),
 CS4236_DOUBLE1("Mono Playback Switch", 0, CS4231_MONO_CTRL, CS4236_LEFT_MIX_CTRL, 7, 7, 1, 1),
 CS4231_SINGLE("Mono Playback Volume", 0, CS4231_MONO_CTRL, 0, 15, 1),
 CS4231_SINGLE("Mono Playback Bypass", 0, CS4231_MONO_CTRL, 5, 1, 0),
 
-CS4231_DOUBLE("Capture Volume", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 0, 0, 15, 0),
-CS4231_DOUBLE("Analog Loopback Capture Switch", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 7, 7, 1, 0),
+CS4231_DOUBLE("Capture Volume", 0, AD1848_LEFT_INPUT, AD1848_RIGHT_INPUT, 0, 0, 15, 0),
+CS4231_DOUBLE("Analog Loopback Capture Switch", 0, AD1848_LEFT_INPUT, AD1848_RIGHT_INPUT, 7, 7, 1, 0),
 
-CS4231_SINGLE("Digital Loopback Playback Switch", 0, CS4231_LOOPBACK, 0, 1, 0),
-CS4236_DOUBLE1("Digital Loopback Playback Volume", 0, CS4231_LOOPBACK, CS4236_RIGHT_LOOPBACK, 2, 0, 63, 1)
+CS4231_SINGLE("Digital Loopback Playback Switch", 0, AD1848_LOOPBACK, 0, 1, 0),
+CS4236_DOUBLE1("Digital Loopback Playback Volume", 0, AD1848_LOOPBACK, CS4236_RIGHT_LOOPBACK, 2, 0, 63, 1)
 };
 
 static struct snd_kcontrol_new snd_cs4235_controls[] = {
@@ -775,8 +775,8 @@ CS4231_DOUBLE("Master Digital Volume", 1
 
 CS4236_DOUBLE("Capture Volume", 0, CS4236_LEFT_MIX_CTRL, CS4236_RIGHT_MIX_CTRL, 5, 5, 3, 1),
 
-CS4231_DOUBLE("PCM Switch", 0, CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("PCM Volume", 0, CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 63, 1),
+CS4231_DOUBLE("PCM Switch", 0, AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT, 7, 7, 1, 1),
+CS4231_DOUBLE("PCM Volume", 0, AD1848_LEFT_OUTPUT, AD1848_RIGHT_OUTPUT, 0, 0, 63, 1),
 
 CS4236_DOUBLE("DSP Switch", 0, CS4236_LEFT_DSP, CS4236_RIGHT_DSP, 7, 7, 1, 1),
 
@@ -789,20 +789,20 @@ CS4236_DOUBLE("Mic Playback Switch", 0, 
 CS4236_SINGLE("Mic Volume", 0, CS4236_LEFT_MIC, 0, 31, 1),
 CS4236_SINGLE("Mic Playback Boost", 0, CS4236_LEFT_MIC, 5, 1, 0),
 
-CS4231_DOUBLE("Aux Playback Switch", 0, CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("Aux Capture Switch", 0, CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 6, 6, 1, 1),
-CS4231_DOUBLE("Aux Volume", 0, CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 0, 0, 31, 1),
-
-CS4231_DOUBLE("Aux Playback Switch", 1, CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("Aux Capture Switch", 1, CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 6, 6, 1, 1),
-CS4231_DOUBLE("Aux Volume", 1, CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 0, 0, 31, 1),
+CS4231_DOUBLE("Aux Playback Switch", 0, AD1848_AUX1_LEFT_INPUT, AD1848_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
+CS4231_DOUBLE("Aux Capture Switch", 0, AD1848_AUX1_LEFT_INPUT, AD1848_AUX1_RIGHT_INPUT, 6, 6, 1, 1),
+CS4231_DOUBLE("Aux Volume", 0, AD1848_AUX1_LEFT_INPUT, AD1848_AUX1_RIGHT_INPUT, 0, 0, 31, 1),
+
+CS4231_DOUBLE("Aux Playback Switch", 1, AD1848_AUX2_LEFT_INPUT, AD1848_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
+CS4231_DOUBLE("Aux Capture Switch", 1, AD1848_AUX2_LEFT_INPUT, AD1848_AUX2_RIGHT_INPUT, 6, 6, 1, 1),
+CS4231_DOUBLE("Aux Volume", 1, AD1848_AUX2_LEFT_INPUT, AD1848_AUX2_RIGHT_INPUT, 0, 0, 31, 1),
 
 CS4236_DOUBLE1("Master Mono Switch", 0, CS4231_MONO_CTRL, CS4236_RIGHT_MIX_CTRL, 6, 7, 1, 1),
 
 CS4236_DOUBLE1("Mono Switch", 0, CS4231_MONO_CTRL, CS4236_LEFT_MIX_CTRL, 7, 7, 1, 1),
 CS4231_SINGLE("Mono Volume", 0, CS4231_MONO_CTRL, 0, 15, 1),
 
-CS4231_DOUBLE("Analog Loopback Switch", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 7, 7, 1, 0),
+CS4231_DOUBLE("Analog Loopback Switch", 0, AD1848_LEFT_INPUT, AD1848_RIGHT_INPUT, 7, 7, 1, 0),
 };
 
 #define CS4236_IEC958_ENABLE(xname, xindex) \
diff -urp linux-ref/sound/isa/sscape.c linux-mm/sound/isa/sscape.c
--- linux-ref/sound/isa/sscape.c	2008-06-15 12:16:32.504618272 +0200
+++ linux-mm/sound/isa/sscape.c	2008-06-15 07:23:22.077521453 +0200
@@ -983,7 +983,7 @@ static void ad1845_playback_format(struc
 	 * NOTE: We seem to need to write to the MSB before the LSB
 	 *       to get the correct sample frequency.
 	 */
-	snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT, (format & 0xf0));
+	snd_cs4231_out(chip, AD1848_DATA_FORMAT, (format & 0xf0));
 	snd_cs4231_out(chip, AD1845_FREQ_SEL_MSB, (unsigned char) (rate >> 8));
 	snd_cs4231_out(chip, AD1845_FREQ_SEL_LSB, (unsigned char) rate);
 
@@ -1089,7 +1089,7 @@ static int __devinit create_ad1845(struc
 			 * b) enable frequency selection (for capture/playback)
 			 */
 			spin_lock_irqsave(&chip->reg_lock, flags);
-			snd_cs4231_out(chip, CS4231_MISC_INFO,
+			snd_cs4231_out(chip, AD1848_MISC_INFO,
 					CS4231_MODE2 | 0x10);
 			val = snd_cs4231_in(chip, AD1845_PWR_DOWN_CTRL);
 			snd_cs4231_out(chip, AD1845_PWR_DOWN_CTRL,
diff -urp linux-ref/sound/sparc/cs4231.c linux-mm/sound/sparc/cs4231.c
--- linux-ref/sound/sparc/cs4231.c	2008-06-14 00:05:03.000000000 +0200
+++ linux-mm/sound/sparc/cs4231.c	2008-06-15 12:18:45.786928299 +0200
@@ -137,7 +137,7 @@ static struct snd_cs4231 *cs4231_list;
 #include <sound/cs4231-regs.h>
 
 /* XXX offsets are different than PC ISA chips... */
-#define CS4231U(chip, x)	((chip)->port + ((c_d_c_CS4231##x) << 2))
+#define CS4231U(chip, x)	((chip)->port + ((c_d_c_AD1848##x) << 2))
 
 /* SBUS DMA register defines.  */
 
@@ -196,20 +196,20 @@ static struct snd_cs4231 *cs4231_list;
  */
 
 static unsigned char freq_bits[14] = {
-	/* 5510 */	0x00 | CS4231_XTAL2,
-	/* 6620 */	0x0E | CS4231_XTAL2,
-	/* 8000 */	0x00 | CS4231_XTAL1,
-	/* 9600 */	0x0E | CS4231_XTAL1,
-	/* 11025 */	0x02 | CS4231_XTAL2,
-	/* 16000 */	0x02 | CS4231_XTAL1,
-	/* 18900 */	0x04 | CS4231_XTAL2,
-	/* 22050 */	0x06 | CS4231_XTAL2,
-	/* 27042 */	0x04 | CS4231_XTAL1,
-	/* 32000 */	0x06 | CS4231_XTAL1,
-	/* 33075 */	0x0C | CS4231_XTAL2,
-	/* 37800 */	0x08 | CS4231_XTAL2,
-	/* 44100 */	0x0A | CS4231_XTAL2,
-	/* 48000 */	0x0C | CS4231_XTAL1
+	/* 5510 */	0x00 | AD1848_XTAL2,
+	/* 6620 */	0x0E | AD1848_XTAL2,
+	/* 8000 */	0x00 | AD1848_XTAL1,
+	/* 9600 */	0x0E | AD1848_XTAL1,
+	/* 11025 */	0x02 | AD1848_XTAL2,
+	/* 16000 */	0x02 | AD1848_XTAL1,
+	/* 18900 */	0x04 | AD1848_XTAL2,
+	/* 22050 */	0x06 | AD1848_XTAL2,
+	/* 27042 */	0x04 | AD1848_XTAL1,
+	/* 32000 */	0x06 | AD1848_XTAL1,
+	/* 33075 */	0x0C | AD1848_XTAL2,
+	/* 37800 */	0x08 | AD1848_XTAL2,
+	/* 44100 */	0x0A | AD1848_XTAL2,
+	/* 48000 */	0x0C | AD1848_XTAL1
 };
 
 static unsigned int rates[14] = {
@@ -240,7 +240,7 @@ static unsigned char snd_cs4231_original
 	0xbf,			/* 06/06 - loc */
 	0xbf,			/* 07/07 - roc */
 	0x20,			/* 08/08 - pdfr */
-	CS4231_AUTOCALIB,	/* 09/09 - ic */
+	AD1848_AUTOCALIB,	/* 09/09 - ic */
 	0x00,			/* 0a/10 - pc */
 	0x00,			/* 0b/11 - ti */
 	CS4231_MODE2,		/* 0c/12 - mi */
@@ -300,7 +300,7 @@ static void snd_cs4231_ready(struct snd_
 
 	for (timeout = 250; timeout > 0; timeout--) {
 		int val = __cs4231_readb(chip, CS4231U(chip, REGSEL));
-		if ((val & CS4231_INIT) == 0)
+		if ((val & AD1848_INIT) == 0)
 			break;
 		udelay(100);
 	}
@@ -311,7 +311,7 @@ static void snd_cs4231_dout(struct snd_c
 {
 	snd_cs4231_ready(chip);
 #ifdef CONFIG_SND_DEBUG
-	if (__cs4231_readb(chip, CS4231U(chip, REGSEL)) & CS4231_INIT)
+	if (__cs4231_readb(chip, CS4231U(chip, REGSEL)) & AD1848_INIT)
 		snd_printdd("out: auto calibration time out - reg = 0x%x, "
 			    "value = 0x%x\n",
 			    reg, value);
@@ -344,7 +344,7 @@ static unsigned char snd_cs4231_in(struc
 {
 	snd_cs4231_ready(chip);
 #ifdef CONFIG_SND_DEBUG
-	if (__cs4231_readb(chip, CS4231U(chip, REGSEL)) & CS4231_INIT)
+	if (__cs4231_readb(chip, CS4231U(chip, REGSEL)) & AD1848_INIT)
 		snd_printdd("in: auto calibration time out - reg = 0x%x\n",
 			    reg);
 #endif
@@ -368,7 +368,7 @@ static void snd_cs4231_busy_wait(struct 
 	/* end of cleanup sequence */
 	for (timeout = 500; timeout > 0; timeout--) {
 		int val = __cs4231_readb(chip, CS4231U(chip, REGSEL));
-		if ((val & CS4231_INIT) == 0)
+		if ((val & AD1848_INIT) == 0)
 			break;
 		msleep(1);
 	}
@@ -382,16 +382,16 @@ static void snd_cs4231_mce_up(struct snd
 	spin_lock_irqsave(&chip->lock, flags);
 	snd_cs4231_ready(chip);
 #ifdef CONFIG_SND_DEBUG
-	if (__cs4231_readb(chip, CS4231U(chip, REGSEL)) & CS4231_INIT)
+	if (__cs4231_readb(chip, CS4231U(chip, REGSEL)) & AD1848_INIT)
 		snd_printdd("mce_up - auto calibration time out (0)\n");
 #endif
-	chip->mce_bit |= CS4231_MCE;
+	chip->mce_bit |= AD1848_MCE;
 	timeout = __cs4231_readb(chip, CS4231U(chip, REGSEL));
 	if (timeout == 0x80)
 		snd_printdd("mce_up [%p]: serious init problem - "
 			    "codec still busy\n",
 			    chip->port);
-	if (!(timeout & CS4231_MCE))
+	if (!(timeout & AD1848_MCE))
 		__cs4231_writeb(chip, chip->mce_bit | (timeout & 0x1f),
 				CS4231U(chip, REGSEL));
 	spin_unlock_irqrestore(&chip->lock, flags);
@@ -405,18 +405,18 @@ static void snd_cs4231_mce_down(struct s
 	snd_cs4231_busy_wait(chip);
 	spin_lock_irqsave(&chip->lock, flags);
 #ifdef CONFIG_SND_DEBUG
-	if (__cs4231_readb(chip, CS4231U(chip, REGSEL)) & CS4231_INIT)
+	if (__cs4231_readb(chip, CS4231U(chip, REGSEL)) & AD1848_INIT)
 		snd_printdd("mce_down [%p] - auto calibration time out (0)\n",
 			    CS4231U(chip, REGSEL));
 #endif
-	chip->mce_bit &= ~CS4231_MCE;
+	chip->mce_bit &= ~AD1848_MCE;
 	reg = __cs4231_readb(chip, CS4231U(chip, REGSEL));
 	__cs4231_writeb(chip, chip->mce_bit | (reg & 0x1f),
 			CS4231U(chip, REGSEL));
 	if (reg == 0x80)
 		snd_printdd("mce_down [%p]: serious init problem "
 			    "- codec still busy\n", chip->port);
-	if ((reg & CS4231_MCE) == 0) {
+	if ((reg & AD1848_MCE) == 0) {
 		spin_unlock_irqrestore(&chip->lock, flags);
 		return;
 	}
@@ -429,8 +429,8 @@ static void snd_cs4231_mce_down(struct s
 		spin_unlock_irqrestore(&chip->lock, flags);
 		msleep(1);
 		spin_lock_irqsave(&chip->lock, flags);
-		reg = snd_cs4231_in(chip, CS4231_TEST_INIT);
-		reg &= CS4231_CALIB_IN_PROGRESS;
+		reg = snd_cs4231_in(chip, AD1848_TEST_INIT);
+		reg &= AD1848_CALIB_IN_PROGRESS;
 	} while (reg && time_before(jiffies, timeout));
 	spin_unlock_irqrestore(&chip->lock, flags);
 
@@ -464,7 +464,7 @@ static void cs4231_dma_trigger(struct sn
 	struct snd_cs4231 *chip = snd_pcm_substream_chip(substream);
 	struct cs4231_dma_control *dma_cont;
 
-	if (what & CS4231_PLAYBACK_ENABLE) {
+	if (what & AD1848_PLAYBACK_ENABLE) {
 		dma_cont = &chip->p_dma;
 		if (on) {
 			dma_cont->prepare(dma_cont, 0);
@@ -476,7 +476,7 @@ static void cs4231_dma_trigger(struct sn
 			dma_cont->enable(dma_cont, 0);
 		}
 	}
-	if (what & CS4231_RECORD_ENABLE) {
+	if (what & AD1848_CAPTURE_ENABLE) {
 		dma_cont = &chip->c_dma;
 		if (on) {
 			dma_cont->prepare(dma_cont, 1);
@@ -505,10 +505,10 @@ static int snd_cs4231_trigger(struct snd
 
 		snd_pcm_group_for_each_entry(s, substream) {
 			if (s == chip->playback_substream) {
-				what |= CS4231_PLAYBACK_ENABLE;
+				what |= AD1848_PLAYBACK_ENABLE;
 				snd_pcm_trigger_done(s, substream);
 			} else if (s == chip->capture_substream) {
-				what |= CS4231_RECORD_ENABLE;
+				what |= AD1848_CAPTURE_ENABLE;
 				snd_pcm_trigger_done(s, substream);
 			}
 		}
@@ -516,13 +516,13 @@ static int snd_cs4231_trigger(struct snd
 		spin_lock_irqsave(&chip->lock, flags);
 		if (cmd == SNDRV_PCM_TRIGGER_START) {
 			cs4231_dma_trigger(substream, what, 1);
-			chip->image[CS4231_IFACE_CTRL] |= what;
+			chip->image[AD1848_IFACE_CTRL] |= what;
 		} else {
 			cs4231_dma_trigger(substream, what, 0);
-			chip->image[CS4231_IFACE_CTRL] &= ~what;
+			chip->image[AD1848_IFACE_CTRL] &= ~what;
 		}
-		snd_cs4231_out(chip, CS4231_IFACE_CTRL,
-			       chip->image[CS4231_IFACE_CTRL]);
+		snd_cs4231_out(chip, AD1848_IFACE_CTRL,
+			       chip->image[AD1848_IFACE_CTRL]);
 		spin_unlock_irqrestore(&chip->lock, flags);
 		break;
 	}
@@ -554,16 +554,16 @@ static unsigned char snd_cs4231_get_form
 {
 	unsigned char rformat;
 
-	rformat = CS4231_LINEAR_8;
+	rformat = AD1848_LINEAR_8;
 	switch (format) {
 	case SNDRV_PCM_FORMAT_MU_LAW:
-		rformat = CS4231_ULAW_8;
+		rformat = AD1848_ULAW_8;
 		break;
 	case SNDRV_PCM_FORMAT_A_LAW:
-		rformat = CS4231_ALAW_8;
+		rformat = AD1848_ALAW_8;
 		break;
 	case SNDRV_PCM_FORMAT_S16_LE:
-		rformat = CS4231_LINEAR_16;
+		rformat = AD1848_LINEAR_16;
 		break;
 	case SNDRV_PCM_FORMAT_S16_BE:
 		rformat = CS4231_LINEAR_16_BIG;
@@ -573,7 +573,7 @@ static unsigned char snd_cs4231_get_form
 		break;
 	}
 	if (channels > 1)
-		rformat |= CS4231_STEREO;
+		rformat |= AD1848_STEREO;
 	return rformat;
 }
 
@@ -588,25 +588,25 @@ static void snd_cs4231_calibrate_mute(st
 		return;
 	}
 	if (!mute) {
-		snd_cs4231_dout(chip, CS4231_LEFT_INPUT,
-				chip->image[CS4231_LEFT_INPUT]);
-		snd_cs4231_dout(chip, CS4231_RIGHT_INPUT,
-				chip->image[CS4231_RIGHT_INPUT]);
-		snd_cs4231_dout(chip, CS4231_LOOPBACK,
-				chip->image[CS4231_LOOPBACK]);
-	}
-	snd_cs4231_dout(chip, CS4231_AUX1_LEFT_INPUT,
-			mute ? 0x80 : chip->image[CS4231_AUX1_LEFT_INPUT]);
-	snd_cs4231_dout(chip, CS4231_AUX1_RIGHT_INPUT,
-			mute ? 0x80 : chip->image[CS4231_AUX1_RIGHT_INPUT]);
-	snd_cs4231_dout(chip, CS4231_AUX2_LEFT_INPUT,
-			mute ? 0x80 : chip->image[CS4231_AUX2_LEFT_INPUT]);
-	snd_cs4231_dout(chip, CS4231_AUX2_RIGHT_INPUT,
-			mute ? 0x80 : chip->image[CS4231_AUX2_RIGHT_INPUT]);
-	snd_cs4231_dout(chip, CS4231_LEFT_OUTPUT,
-			mute ? 0x80 : chip->image[CS4231_LEFT_OUTPUT]);
-	snd_cs4231_dout(chip, CS4231_RIGHT_OUTPUT,
-			mute ? 0x80 : chip->image[CS4231_RIGHT_OUTPUT]);
+		snd_cs4231_dout(chip, AD1848_LEFT_INPUT,
+				chip->image[AD1848_LEFT_INPUT]);
+		snd_cs4231_dout(chip, AD1848_RIGHT_INPUT,
+				chip->image[AD1848_RIGHT_INPUT]);
+		snd_cs4231_dout(chip, AD1848_LOOPBACK,
+				chip->image[AD1848_LOOPBACK]);
+	}
+	snd_cs4231_dout(chip, AD1848_AUX1_LEFT_INPUT,
+			mute ? 0x80 : chip->image[AD1848_AUX1_LEFT_INPUT]);
+	snd_cs4231_dout(chip, AD1848_AUX1_RIGHT_INPUT,
+			mute ? 0x80 : chip->image[AD1848_AUX1_RIGHT_INPUT]);
+	snd_cs4231_dout(chip, AD1848_AUX2_LEFT_INPUT,
+			mute ? 0x80 : chip->image[AD1848_AUX2_LEFT_INPUT]);
+	snd_cs4231_dout(chip, AD1848_AUX2_RIGHT_INPUT,
+			mute ? 0x80 : chip->image[AD1848_AUX2_RIGHT_INPUT]);
+	snd_cs4231_dout(chip, AD1848_LEFT_OUTPUT,
+			mute ? 0x80 : chip->image[AD1848_LEFT_OUTPUT]);
+	snd_cs4231_dout(chip, AD1848_RIGHT_OUTPUT,
+			mute ? 0x80 : chip->image[AD1848_RIGHT_OUTPUT]);
 	snd_cs4231_dout(chip, CS4231_LEFT_LINE_IN,
 			mute ? 0x80 : chip->image[CS4231_LEFT_LINE_IN]);
 	snd_cs4231_dout(chip, CS4231_RIGHT_LINE_IN,
@@ -629,8 +629,8 @@ static void snd_cs4231_playback_format(s
 	snd_cs4231_mce_up(chip);
 
 	spin_lock_irqsave(&chip->lock, flags);
-	snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT,
-		       (chip->image[CS4231_IFACE_CTRL] & CS4231_RECORD_ENABLE) ?
+	snd_cs4231_out(chip, AD1848_DATA_FORMAT,
+		       (chip->image[AD1848_IFACE_CTRL] & AD1848_CAPTURE_ENABLE) ?
 		       (pdfr & 0xf0) | (chip->image[CS4231_REC_FORMAT] & 0x0f) :
 		       pdfr);
 	spin_unlock_irqrestore(&chip->lock, flags);
@@ -653,9 +653,9 @@ static void snd_cs4231_capture_format(st
 	snd_cs4231_mce_up(chip);
 
 	spin_lock_irqsave(&chip->lock, flags);
-	if (!(chip->image[CS4231_IFACE_CTRL] & CS4231_PLAYBACK_ENABLE)) {
-		snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT,
-			       ((chip->image[CS4231_PLAYBK_FORMAT]) & 0xf0) |
+	if (!(chip->image[AD1848_IFACE_CTRL] & AD1848_PLAYBACK_ENABLE)) {
+		snd_cs4231_out(chip, AD1848_DATA_FORMAT,
+			       ((chip->image[AD1848_DATA_FORMAT]) & 0xf0) |
 			       (cdfr & 0x0f));
 		spin_unlock_irqrestore(&chip->lock, flags);
 		snd_cs4231_mce_down(chip);
@@ -679,7 +679,7 @@ static unsigned long snd_cs4231_timer_re
 {
 	struct snd_cs4231 *chip = snd_timer_chip(timer);
 
-	return chip->image[CS4231_PLAYBK_FORMAT] & 1 ? 9969 : 9920;
+	return chip->image[AD1848_DATA_FORMAT] & 1 ? 9969 : 9920;
 }
 
 static int snd_cs4231_timer_start(struct snd_timer *timer)
@@ -733,13 +733,13 @@ static void __init snd_cs4231_init(struc
 #endif
 	snd_cs4231_mce_up(chip);
 	spin_lock_irqsave(&chip->lock, flags);
-	chip->image[CS4231_IFACE_CTRL] &= ~(CS4231_PLAYBACK_ENABLE |
-					    CS4231_PLAYBACK_PIO |
-					    CS4231_RECORD_ENABLE |
-					    CS4231_RECORD_PIO |
-					    CS4231_CALIB_MODE);
-	chip->image[CS4231_IFACE_CTRL] |= CS4231_AUTOCALIB;
-	snd_cs4231_out(chip, CS4231_IFACE_CTRL, chip->image[CS4231_IFACE_CTRL]);
+	chip->image[AD1848_IFACE_CTRL] &= ~(AD1848_PLAYBACK_ENABLE |
+					    AD1848_PLAYBACK_PIO |
+					    AD1848_CAPTURE_ENABLE |
+					    AD1848_CAPTURE_PIO |
+					    AD1848_CALIB_MODE);
+	chip->image[AD1848_IFACE_CTRL] |= AD1848_AUTOCALIB;
+	snd_cs4231_out(chip, AD1848_IFACE_CTRL, chip->image[AD1848_IFACE_CTRL]);
 	spin_unlock_irqrestore(&chip->lock, flags);
 	snd_cs4231_mce_down(chip);
 
@@ -766,8 +766,8 @@ static void __init snd_cs4231_init(struc
 
 	snd_cs4231_mce_up(chip);
 	spin_lock_irqsave(&chip->lock, flags);
-	snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT,
-			chip->image[CS4231_PLAYBK_FORMAT]);
+	snd_cs4231_out(chip, AD1848_DATA_FORMAT,
+			chip->image[AD1848_DATA_FORMAT]);
 	spin_unlock_irqrestore(&chip->lock, flags);
 	snd_cs4231_mce_down(chip);
 
@@ -841,17 +841,17 @@ static void snd_cs4231_close(struct snd_
 
 	/* now disable record & playback */
 
-	if (chip->image[CS4231_IFACE_CTRL] &
-	    (CS4231_PLAYBACK_ENABLE | CS4231_PLAYBACK_PIO |
-	     CS4231_RECORD_ENABLE | CS4231_RECORD_PIO)) {
+	if (chip->image[AD1848_IFACE_CTRL] &
+	    (AD1848_PLAYBACK_ENABLE | AD1848_PLAYBACK_PIO |
+	     AD1848_CAPTURE_ENABLE | AD1848_CAPTURE_PIO)) {
 		spin_unlock_irqrestore(&chip->lock, flags);
 		snd_cs4231_mce_up(chip);
 		spin_lock_irqsave(&chip->lock, flags);
-		chip->image[CS4231_IFACE_CTRL] &=
-			~(CS4231_PLAYBACK_ENABLE | CS4231_PLAYBACK_PIO |
-			  CS4231_RECORD_ENABLE | CS4231_RECORD_PIO);
-		snd_cs4231_out(chip, CS4231_IFACE_CTRL,
-				chip->image[CS4231_IFACE_CTRL]);
+		chip->image[AD1848_IFACE_CTRL] &=
+			~(AD1848_PLAYBACK_ENABLE | AD1848_PLAYBACK_PIO |
+			  AD1848_CAPTURE_ENABLE | AD1848_CAPTURE_PIO);
+		snd_cs4231_out(chip, AD1848_IFACE_CTRL,
+				chip->image[AD1848_IFACE_CTRL]);
 		spin_unlock_irqrestore(&chip->lock, flags);
 		snd_cs4231_mce_down(chip);
 		spin_lock_irqsave(&chip->lock, flags);
@@ -929,8 +929,8 @@ static int snd_cs4231_playback_prepare(s
 
 	spin_lock_irqsave(&chip->lock, flags);
 
-	chip->image[CS4231_IFACE_CTRL] &= ~(CS4231_PLAYBACK_ENABLE |
-					    CS4231_PLAYBACK_PIO);
+	chip->image[AD1848_IFACE_CTRL] &= ~(AD1848_PLAYBACK_ENABLE |
+					    AD1848_PLAYBACK_PIO);
 
 	BUG_ON(runtime->period_size > 0xffff + 1);
 
@@ -965,8 +965,8 @@ static int snd_cs4231_capture_prepare(st
 	unsigned long flags;
 
 	spin_lock_irqsave(&chip->lock, flags);
-	chip->image[CS4231_IFACE_CTRL] &= ~(CS4231_RECORD_ENABLE |
-					    CS4231_RECORD_PIO);
+	chip->image[AD1848_IFACE_CTRL] &= ~(AD1848_CAPTURE_ENABLE |
+					    AD1848_CAPTURE_PIO);
 
 
 	chip->c_periods_sent = 0;
@@ -981,7 +981,7 @@ static void snd_cs4231_overrange(struct 
 	unsigned char res;
 
 	spin_lock_irqsave(&chip->lock, flags);
-	res = snd_cs4231_in(chip, CS4231_TEST_INIT);
+	res = snd_cs4231_in(chip, AD1848_TEST_INIT);
 	spin_unlock_irqrestore(&chip->lock, flags);
 
 	/* detect overrange only above 0dB; may be user selectable? */
@@ -991,7 +991,7 @@ static void snd_cs4231_overrange(struct 
 
 static void snd_cs4231_play_callback(struct snd_cs4231 *chip)
 {
-	if (chip->image[CS4231_IFACE_CTRL] & CS4231_PLAYBACK_ENABLE) {
+	if (chip->image[AD1848_IFACE_CTRL] & AD1848_PLAYBACK_ENABLE) {
 		snd_pcm_period_elapsed(chip->playback_substream);
 		snd_cs4231_advance_dma(&chip->p_dma, chip->playback_substream,
 					    &chip->p_periods_sent);
@@ -1000,7 +1000,7 @@ static void snd_cs4231_play_callback(str
 
 static void snd_cs4231_capture_callback(struct snd_cs4231 *chip)
 {
-	if (chip->image[CS4231_IFACE_CTRL] & CS4231_RECORD_ENABLE) {
+	if (chip->image[AD1848_IFACE_CTRL] & AD1848_CAPTURE_ENABLE) {
 		snd_pcm_period_elapsed(chip->capture_substream);
 		snd_cs4231_advance_dma(&chip->c_dma, chip->capture_substream,
 					    &chip->c_periods_sent);
@@ -1014,7 +1014,7 @@ static snd_pcm_uframes_t snd_cs4231_play
 	struct cs4231_dma_control *dma_cont = &chip->p_dma;
 	size_t ptr;
 
-	if (!(chip->image[CS4231_IFACE_CTRL] & CS4231_PLAYBACK_ENABLE))
+	if (!(chip->image[AD1848_IFACE_CTRL] & AD1848_PLAYBACK_ENABLE))
 		return 0;
 	ptr = dma_cont->address(dma_cont);
 	if (ptr != 0)
@@ -1030,7 +1030,7 @@ static snd_pcm_uframes_t snd_cs4231_capt
 	struct cs4231_dma_control *dma_cont = &chip->c_dma;
 	size_t ptr;
 
-	if (!(chip->image[CS4231_IFACE_CTRL] & CS4231_RECORD_ENABLE))
+	if (!(chip->image[AD1848_IFACE_CTRL] & AD1848_CAPTURE_ENABLE))
 		return 0;
 	ptr = dma_cont->address(dma_cont);
 	if (ptr != 0)
@@ -1049,12 +1049,12 @@ static int __init snd_cs4231_probe(struc
 
 	for (i = 0; i < 50; i++) {
 		mb();
-		if (__cs4231_readb(chip, CS4231U(chip, REGSEL)) & CS4231_INIT)
+		if (__cs4231_readb(chip, CS4231U(chip, REGSEL)) & AD1848_INIT)
 			msleep(2);
 		else {
 			spin_lock_irqsave(&chip->lock, flags);
-			snd_cs4231_out(chip, CS4231_MISC_INFO, CS4231_MODE2);
-			id = snd_cs4231_in(chip, CS4231_MISC_INFO) & 0x0f;
+			snd_cs4231_out(chip, AD1848_MISC_INFO, CS4231_MODE2);
+			id = snd_cs4231_in(chip, AD1848_MISC_INFO) & 0x0f;
 			vers = snd_cs4231_in(chip, CS4231_VERSION);
 			spin_unlock_irqrestore(&chip->lock, flags);
 			if (id == 0x0a)
@@ -1074,9 +1074,9 @@ static int __init snd_cs4231_probe(struc
 
 	spin_unlock_irqrestore(&chip->lock, flags);
 
-	chip->image[CS4231_MISC_INFO] = CS4231_MODE2;
-	chip->image[CS4231_IFACE_CTRL] =
-		chip->image[CS4231_IFACE_CTRL] & ~CS4231_SINGLE_DMA;
+	chip->image[AD1848_MISC_INFO] = CS4231_MODE2;
+	chip->image[AD1848_IFACE_CTRL] =
+		chip->image[AD1848_IFACE_CTRL] & ~AD1848_SINGLE_DMA;
 	chip->image[CS4231_ALT_FEATURE_1] = 0x80;
 	chip->image[CS4231_ALT_FEATURE_2] = 0x01;
 	if (vers & 0x20)
@@ -1319,9 +1319,9 @@ static int snd_cs4231_get_mux(struct snd
 
 	spin_lock_irqsave(&chip->lock, flags);
 	ucontrol->value.enumerated.item[0] =
-		(chip->image[CS4231_LEFT_INPUT] & CS4231_MIXS_ALL) >> 6;
+		(chip->image[AD1848_LEFT_INPUT] & AD1848_MIXS_ALL) >> 6;
 	ucontrol->value.enumerated.item[1] =
-		(chip->image[CS4231_RIGHT_INPUT] & CS4231_MIXS_ALL) >> 6;
+		(chip->image[AD1848_RIGHT_INPUT] & AD1848_MIXS_ALL) >> 6;
 	spin_unlock_irqrestore(&chip->lock, flags);
 
 	return 0;
@@ -1343,12 +1343,12 @@ static int snd_cs4231_put_mux(struct snd
 
 	spin_lock_irqsave(&chip->lock, flags);
 
-	left = (chip->image[CS4231_LEFT_INPUT] & ~CS4231_MIXS_ALL) | left;
-	right = (chip->image[CS4231_RIGHT_INPUT] & ~CS4231_MIXS_ALL) | right;
-	change = left != chip->image[CS4231_LEFT_INPUT] ||
-		 right != chip->image[CS4231_RIGHT_INPUT];
-	snd_cs4231_out(chip, CS4231_LEFT_INPUT, left);
-	snd_cs4231_out(chip, CS4231_RIGHT_INPUT, right);
+	left = (chip->image[AD1848_LEFT_INPUT] & ~AD1848_MIXS_ALL) | left;
+	right = (chip->image[AD1848_RIGHT_INPUT] & ~AD1848_MIXS_ALL) | right;
+	change = left != chip->image[AD1848_LEFT_INPUT] ||
+		 right != chip->image[AD1848_RIGHT_INPUT];
+	snd_cs4231_out(chip, AD1848_LEFT_INPUT, left);
+	snd_cs4231_out(chip, AD1848_RIGHT_INPUT, right);
 
 	spin_unlock_irqrestore(&chip->lock, flags);
 
@@ -1517,27 +1517,27 @@ static int snd_cs4231_put_double(struct 
 		   ((shift_right) << 19) | ((mask) << 24) | ((invert) << 22) }
 
 static struct snd_kcontrol_new snd_cs4231_controls[] __initdata = {
-CS4231_DOUBLE("PCM Playback Switch", 0, CS4231_LEFT_OUTPUT,
-		CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("PCM Playback Volume", 0, CS4231_LEFT_OUTPUT,
-		CS4231_RIGHT_OUTPUT, 0, 0, 63, 1),
+CS4231_DOUBLE("PCM Playback Switch", 0, AD1848_LEFT_OUTPUT,
+		AD1848_RIGHT_OUTPUT, 7, 7, 1, 1),
+CS4231_DOUBLE("PCM Playback Volume", 0, AD1848_LEFT_OUTPUT,
+		AD1848_RIGHT_OUTPUT, 0, 0, 63, 1),
 CS4231_DOUBLE("Line Playback Switch", 0, CS4231_LEFT_LINE_IN,
 		CS4231_RIGHT_LINE_IN, 7, 7, 1, 1),
 CS4231_DOUBLE("Line Playback Volume", 0, CS4231_LEFT_LINE_IN,
 		CS4231_RIGHT_LINE_IN, 0, 0, 31, 1),
-CS4231_DOUBLE("Aux Playback Switch", 0, CS4231_AUX1_LEFT_INPUT,
-		CS4231_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("Aux Playback Volume", 0, CS4231_AUX1_LEFT_INPUT,
-		CS4231_AUX1_RIGHT_INPUT, 0, 0, 31, 1),
-CS4231_DOUBLE("Aux Playback Switch", 1, CS4231_AUX2_LEFT_INPUT,
-		CS4231_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
-CS4231_DOUBLE("Aux Playback Volume", 1, CS4231_AUX2_LEFT_INPUT,
-		CS4231_AUX2_RIGHT_INPUT, 0, 0, 31, 1),
+CS4231_DOUBLE("Aux Playback Switch", 0, AD1848_AUX1_LEFT_INPUT,
+		AD1848_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
+CS4231_DOUBLE("Aux Playback Volume", 0, AD1848_AUX1_LEFT_INPUT,
+		AD1848_AUX1_RIGHT_INPUT, 0, 0, 31, 1),
+CS4231_DOUBLE("Aux Playback Switch", 1, AD1848_AUX2_LEFT_INPUT,
+		AD1848_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
+CS4231_DOUBLE("Aux Playback Volume", 1, AD1848_AUX2_LEFT_INPUT,
+		AD1848_AUX2_RIGHT_INPUT, 0, 0, 31, 1),
 CS4231_SINGLE("Mono Playback Switch", 0, CS4231_MONO_CTRL, 7, 1, 1),
 CS4231_SINGLE("Mono Playback Volume", 0, CS4231_MONO_CTRL, 0, 15, 1),
 CS4231_SINGLE("Mono Output Playback Switch", 0, CS4231_MONO_CTRL, 6, 1, 1),
 CS4231_SINGLE("Mono Output Playback Bypass", 0, CS4231_MONO_CTRL, 5, 1, 0),
-CS4231_DOUBLE("Capture Volume", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 0, 0,
+CS4231_DOUBLE("Capture Volume", 0, AD1848_LEFT_INPUT, AD1848_RIGHT_INPUT, 0, 0,
 		15, 0),
 {
 	.iface	= SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -1546,13 +1546,13 @@ CS4231_DOUBLE("Capture Volume", 0, CS423
 	.get	= snd_cs4231_get_mux,
 	.put	= snd_cs4231_put_mux,
 },
-CS4231_DOUBLE("Mic Boost", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 5, 5,
+CS4231_DOUBLE("Mic Boost", 0, AD1848_LEFT_INPUT, AD1848_RIGHT_INPUT, 5, 5,
 		1, 0),
-CS4231_SINGLE("Loopback Capture Switch", 0, CS4231_LOOPBACK, 0, 1, 0),
-CS4231_SINGLE("Loopback Capture Volume", 0, CS4231_LOOPBACK, 2, 63, 1),
+CS4231_SINGLE("Loopback Capture Switch", 0, AD1848_LOOPBACK, 0, 1, 0),
+CS4231_SINGLE("Loopback Capture Volume", 0, AD1848_LOOPBACK, 2, 63, 1),
 /* SPARC specific uses of XCTL{0,1} general purpose outputs.  */
-CS4231_SINGLE("Line Out Switch", 0, CS4231_PIN_CTRL, 6, 1, 1),
-CS4231_SINGLE("Headphone Out Switch", 0, CS4231_PIN_CTRL, 7, 1, 1)
+CS4231_SINGLE("Line Out Switch", 0, AD1848_PIN_CTRL, 6, 1, 1),
+CS4231_SINGLE("Headphone Out Switch", 0, AD1848_PIN_CTRL, 7, 1, 1)
 };
 
 static int __init snd_cs4231_mixer(struct snd_card *card)
@@ -1647,7 +1647,7 @@ static irqreturn_t snd_cs4231_sbus_inter
 	struct snd_cs4231 *chip = dev_id;
 
 	/*This is IRQ is not raised by the cs4231*/
-	if (!(__cs4231_readb(chip, CS4231U(chip, STATUS)) & CS4231_GLOBALIRQ))
+	if (!(__cs4231_readb(chip, CS4231U(chip, STATUS)) & AD1848_GLOBALIRQ))
 		return IRQ_NONE;
 
 	/* ACK the APC interrupt. */

----------------------------------------------------------------------
Z Map24 Twoja droga jest prosta! Sprawdz!
kliknij >>> http://link.interia.pl/f1e3b
