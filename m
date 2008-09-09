From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 09/24] sound/pci: coding style fixes:
	sound/pci/e*
Date: Tue, 9 Sep 2008 06:07:19 +0400
Message-ID: <20080909020719.GB6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 42CD124475
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 04:07:30 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 21so727938eyc.56
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 19:07:30 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



- <asm/io.h> -> <linux/io.h>
- remove trailing whitespaces
- convert comments

Only compile tested.

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 sound/pci/ens1370.c |   60 ++++++++++++++++++++--------------------
 sound/pci/es1938.c  |   68 +++++++++++++++++++++++-----------------------
 sound/pci/es1968.c  |   74 +++++++++++++++++++++++++-------------------------
 3 files changed, 101 insertions(+), 101 deletions(-)

diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 9bf9536..56a8f7c 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -26,7 +26,7 @@
  * by Kurt J. Bosch
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -467,13 +467,13 @@ MODULE_DEVICE_TABLE(pci, snd_audiopci_ids);
 static unsigned int snd_es1370_fixed_rates[] =
 	{5512, 11025, 22050, 44100};
 static struct snd_pcm_hw_constraint_list snd_es1370_hw_constraints_rates = {
-	.count = 4, 
+	.count = 4,
 	.list = snd_es1370_fixed_rates,
 	.mask = 0,
 };
 static struct snd_ratnum es1370_clock = {
 	.num = ES_1370_SRCLOCK,
-	.den_min = 29, 
+	.den_min = 29,
 	.den_max = 353,
 	.den_step = 1,
 };
@@ -494,7 +494,7 @@ static struct snd_pcm_hw_constraint_ratdens snd_es1371_hw_constraints_dac_clock
 };
 static struct snd_ratnum es1371_adc_clock = {
 	.num = 48000 << 15,
-	.den_min = 32768, 
+	.den_min = 32768,
 	.den_max = 393216,
 	.den_step = 1,
 };
@@ -542,7 +542,7 @@ static unsigned int snd_es1371_src_read(struct ensoniq * ensoniq, unsigned short
 
 	/* now, wait for busy and the correct time to read */
 	temp = snd_es1371_wait_src_ready(ensoniq);
-	
+
 	if ((temp & 0x00870000) != 0x00010000) {
 		/* wait for the right state */
 		for (i = 0; i < POLL_COUNT; i++) {
@@ -552,12 +552,12 @@ static unsigned int snd_es1371_src_read(struct ensoniq * ensoniq, unsigned short
 		}
 	}
 
-	/* hide the state bits */	
+	/* hide the state bits */
 	r = orig & (ES_1371_SRC_DISABLE | ES_1371_DIS_P1 |
 		   ES_1371_DIS_P2 | ES_1371_DIS_R1);
 	r |= ES_1371_SRC_RAM_ADDRO(reg);
 	outl(r, ES_REG(ensoniq, 1371_SMPRATE));
-	
+
 	return temp;
 }
 
@@ -648,7 +648,7 @@ static unsigned short snd_es1371_codec_read(struct snd_ac97 *ac97,
 	struct ensoniq *ensoniq = ac97->private_data;
 	unsigned int t, x, fail = 0;
 
-      __again:
+__again:
 	mutex_lock(&ensoniq->src_mutex);
 	for (t = 0; t < POLL_COUNT; t++) {
 		if (!(inl(ES_REG(ensoniq, 1371_CODEC)) & ES_1371_CODEC_WIP)) {
@@ -677,7 +677,7 @@ static unsigned short snd_es1371_codec_read(struct snd_ac97 *ac97,
 			/* wait for WIP again */
 			for (t = 0; t < POLL_COUNT; t++) {
 				if (!(inl(ES_REG(ensoniq, 1371_CODEC)) & ES_1371_CODEC_WIP))
-					break;		
+					break;
 			}
 			/* now wait for the stinkin' data (RDY) */
 			for (t = 0; t < POLL_COUNT; t++) {
@@ -1053,7 +1053,7 @@ static struct snd_pcm_hardware snd_ensoniq_playback1 =
 				SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
 #else
 				(SNDRV_PCM_RATE_KNOT | 	/* 5512Hz rate */
-				 SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_22050 | 
+				 SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_22050 |
 				 SNDRV_PCM_RATE_44100),
 #endif
 	.rate_min =		4000,
@@ -1072,7 +1072,7 @@ static struct snd_pcm_hardware snd_ensoniq_playback2 =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
-				 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_PAUSE | 
+				 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_PAUSE |
 				 SNDRV_PCM_INFO_SYNC_START),
 	.formats =		SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
 	.rates =		SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
@@ -1424,7 +1424,7 @@ static int snd_es1371_spdif_get(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
 	struct ensoniq *ensoniq = snd_kcontrol_chip(kcontrol);
-	
+
 	spin_lock_irq(&ensoniq->reg_lock);
 	ucontrol->value.integer.value[0] = ensoniq->ctrl & ES_1373_SPDIF_THRU ? 1 : 0;
 	spin_unlock_irq(&ensoniq->reg_lock);
@@ -1437,7 +1437,7 @@ static int snd_es1371_spdif_put(struct snd_kcontrol *kcontrol,
 	struct ensoniq *ensoniq = snd_kcontrol_chip(kcontrol);
 	unsigned int nval1, nval2;
 	int change;
-	
+
 	nval1 = ucontrol->value.integer.value[0] ? ES_1373_SPDIF_THRU : 0;
 	nval2 = ucontrol->value.integer.value[0] ? ES_1373_SPDIF_EN : 0;
 	spin_lock_irq(&ensoniq->reg_lock);
@@ -1487,7 +1487,7 @@ static int snd_es1373_rear_get(struct snd_kcontrol *kcontrol,
 {
 	struct ensoniq *ensoniq = snd_kcontrol_chip(kcontrol);
 	int val = 0;
-	
+
 	spin_lock_irq(&ensoniq->reg_lock);
 	if ((ensoniq->cssr & (ES_1373_REAR_BIT27|ES_1373_REAR_BIT26|
 			      ES_1373_REAR_BIT24)) == ES_1373_REAR_BIT26)
@@ -1503,7 +1503,7 @@ static int snd_es1373_rear_put(struct snd_kcontrol *kcontrol,
 	struct ensoniq *ensoniq = snd_kcontrol_chip(kcontrol);
 	unsigned int nval1;
 	int change;
-	
+
 	nval1 = ucontrol->value.integer.value[0] ?
 		ES_1373_REAR_BIT26 : (ES_1373_REAR_BIT27|ES_1373_REAR_BIT24);
 	spin_lock_irq(&ensoniq->reg_lock);
@@ -1532,7 +1532,7 @@ static int snd_es1373_line_get(struct snd_kcontrol *kcontrol,
 {
 	struct ensoniq *ensoniq = snd_kcontrol_chip(kcontrol);
 	int val = 0;
-	
+
 	spin_lock_irq(&ensoniq->reg_lock);
 	if ((ensoniq->ctrl & ES_1371_GPIO_OUTM) >= 4)
 	    	val = 1;
@@ -1547,7 +1547,7 @@ static int snd_es1373_line_put(struct snd_kcontrol *kcontrol,
 	struct ensoniq *ensoniq = snd_kcontrol_chip(kcontrol);
 	int changed;
 	unsigned int ctrl;
-	
+
 	spin_lock_irq(&ensoniq->reg_lock);
 	ctrl = ensoniq->ctrl;
 	if (ucontrol->value.integer.value[0])
@@ -1690,7 +1690,7 @@ static int snd_ensoniq_control_get(struct snd_kcontrol *kcontrol,
 {
 	struct ensoniq *ensoniq = snd_kcontrol_chip(kcontrol);
 	int mask = kcontrol->private_value;
-	
+
 	spin_lock_irq(&ensoniq->reg_lock);
 	ucontrol->value.integer.value[0] = ensoniq->ctrl & mask ? 1 : 0;
 	spin_unlock_irq(&ensoniq->reg_lock);
@@ -1704,7 +1704,7 @@ static int snd_ensoniq_control_put(struct snd_kcontrol *kcontrol,
 	int mask = kcontrol->private_value;
 	unsigned int nval;
 	int change;
-	
+
 	nval = ucontrol->value.integer.value[0] ? mask : 0;
 	spin_lock_irq(&ensoniq->reg_lock);
 	change = (ensoniq->ctrl & mask) != nval;
@@ -1864,7 +1864,7 @@ static inline void snd_ensoniq_free_gameport(struct ensoniq *ensoniq) { }
 
  */
 
-static void snd_ensoniq_proc_read(struct snd_info_entry *entry, 
+static void snd_ensoniq_proc_read(struct snd_info_entry *entry,
 				  struct snd_info_buffer *buffer)
 {
 	struct ensoniq *ensoniq = entry->private_data;
@@ -1891,7 +1891,7 @@ static void __devinit snd_ensoniq_proc_init(struct ensoniq * ensoniq)
 {
 	struct snd_info_entry *entry;
 
-	if (! snd_card_proc_new(ensoniq->card, "audiopci", &entry))
+	if (!snd_card_proc_new(ensoniq->card, "audiopci", &entry))
 		snd_info_set_text_ops(entry, ensoniq, snd_ensoniq_proc_read);
 }
 
@@ -1914,7 +1914,7 @@ static int snd_ensoniq_free(struct ensoniq *ensoniq)
 	if (ensoniq->irq >= 0)
 		synchronize_irq(ensoniq->irq);
 	pci_set_power_state(ensoniq->pci, 3);
-      __hw_end:
+__hw_end:
 #ifdef CHIP1370
 	if (ensoniq->dma_bug.area)
 		snd_dma_free_pages(&ensoniq->dma_bug);
@@ -1982,7 +1982,7 @@ static void snd_ensoniq_chip_init(struct ensoniq *ensoniq)
 	udelay(20);
 	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
 	/* Init the sample rate converter */
-	snd_es1371_wait_src_ready(ensoniq);	
+	snd_es1371_wait_src_ready(ensoniq);
 	outl(ES_1371_SRC_DISABLE, ES_REG(ensoniq, 1371_SMPRATE));
 	for (idx = 0; idx < 0x80; idx++)
 		snd_es1371_src_write(ensoniq, idx, 0);
@@ -2021,13 +2021,13 @@ static int snd_ensoniq_suspend(struct pci_dev *pci, pm_message_t state)
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct ensoniq *ensoniq = card->private_data;
-	
+
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 
 	snd_pcm_suspend_all(ensoniq->pcm1);
 	snd_pcm_suspend_all(ensoniq->pcm2);
-	
-#ifdef CHIP1371	
+
+#ifdef CHIP1371
 	snd_ac97_suspend(ensoniq->u.es1371.ac97);
 #else
 	/* try to reset AK4531 */
@@ -2038,7 +2038,7 @@ static int snd_ensoniq_suspend(struct pci_dev *pci, pm_message_t state)
 	inw(ES_REG(ensoniq, 1370_CODEC));
 	udelay(100);
 	snd_ak4531_suspend(ensoniq->u.es1370.ak4531);
-#endif	
+#endif
 
 	pci_disable_device(pci);
 	pci_save_state(pci);
@@ -2063,11 +2063,11 @@ static int snd_ensoniq_resume(struct pci_dev *pci)
 
 	snd_ensoniq_chip_init(ensoniq);
 
-#ifdef CHIP1371	
+#ifdef CHIP1371
 	snd_ac97_resume(ensoniq->u.es1371.ac97);
 #else
 	snd_ak4531_resume(ensoniq->u.es1370.ak4531);
-#endif	
+#endif
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
 	return 0;
 }
@@ -2482,7 +2482,7 @@ static struct pci_driver driver = {
 	.resume = snd_ensoniq_resume,
 #endif
 };
-	
+
 static int __init alsa_card_ens137x_init(void)
 {
 	return pci_register_driver(&driver);
diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index 4cd9a1f..87effdc 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -5,7 +5,7 @@
  *                   Thomas Sailer <sailer@ife.ee.ethz.ch>,
  *                   Abramo Bagnara <abramo@alsa-project.org>,
  *                   Markus Gruber <gruber@eikon.tum.de>
- * 
+ *
  * Rewritten from sonicvibes.c source.
  *
  *  TODO:
@@ -63,7 +63,7 @@
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 
 MODULE_AUTHOR("Jaromir Koutek <miri@punknet.cz>");
 MODULE_DESCRIPTION("ESS Solo-1");
@@ -167,7 +167,7 @@ MODULE_PARM_DESC(enable, "Enable ESS Solo-1 soundcard.");
 #define ESS_CMD_SETFORMAT2		0xb7
 #define ESS_CMD_DMACONTROL		0xb8
 #define ESS_CMD_DMATYPE			0xb9
-#define ESS_CMD_OFFSETLEFT		0xba	
+#define ESS_CMD_OFFSETLEFT		0xba
 #define ESS_CMD_OFFSETRIGHT		0xbb
 #define ESS_CMD_READREG			0xc0
 #define ESS_CMD_ENABLEEXT		0xc6
@@ -418,7 +418,7 @@ static void snd_es1938_reset(struct es1938 *chip)
 	}
 	snd_printk(KERN_ERR "ESS Solo-1 reset failed\n");
 
-     __next:
+__next:
 	snd_es1938_write_cmd(chip, ESS_CMD_ENABLEEXT);
 
 	/* Demand transfer DMA: 4 bytes per DMA request */
@@ -426,7 +426,7 @@ static void snd_es1938_reset(struct es1938 *chip)
 
 	/* Change behaviour of register A1
 	   4x oversampling
-	   2nd channel DAC asynchronous */                                                      
+	   2nd channel DAC asynchronous */
 	snd_es1938_mixer_write(chip, ESSSB_IREG_AUDIO2MODE, 0x32);
 	/* enable/select DMA channel and IRQ channel */
 	snd_es1938_bits(chip, ESS_CMD_IRQCONTROL, 0xf0, 0x50);
@@ -469,7 +469,7 @@ static struct snd_pcm_hw_constraint_ratnums hw_constraints_clocks = {
 };
 
 
-static void snd_es1938_rate_set(struct es1938 *chip, 
+static void snd_es1938_rate_set(struct es1938 *chip,
 				struct snd_pcm_substream *substream,
 				int mode)
 {
@@ -482,7 +482,7 @@ static void snd_es1938_rate_set(struct es1938 *chip,
 
 	/* set filter register */
 	div0 = 256 - 7160000*20/(8*82*runtime->rate);
-		
+
 	if (mode == DAC2) {
 		snd_es1938_mixer_write(chip, 0x70, bits);
 		snd_es1938_mixer_write(chip, 0x72, div0);
@@ -650,7 +650,7 @@ static int snd_es1938_capture_prepare(struct snd_pcm_substream *substream)
 	chip->dma1_shift = 2 - mono - is8;
 
 	snd_es1938_reset_fifo(chip);
-	
+
 	/* program type */
 	snd_es1938_bits(chip, ESS_CMD_ANALOGCONTROL, 0x03, (mono ? 2 : 1));
 
@@ -663,12 +663,12 @@ static int snd_es1938_capture_prepare(struct snd_pcm_substream *substream)
 
 	/* initialize and configure ADC */
 	snd_es1938_write(chip, ESS_CMD_SETFORMAT2, u ? 0x51 : 0x71);
-	snd_es1938_write(chip, ESS_CMD_SETFORMAT2, 0x90 | 
-		       (u ? 0x00 : 0x20) | 
-		       (is8 ? 0x00 : 0x04) | 
+	snd_es1938_write(chip, ESS_CMD_SETFORMAT2, 0x90 |
+		       (u ? 0x00 : 0x20) |
+		       (is8 ? 0x00 : 0x04) |
 		       (mono ? 0x40 : 0x08));
 
-	//	snd_es1938_reset_fifo(chip);	
+	/*	snd_es1938_reset_fifo(chip); */
 
 	/* 11. configure system interrupt controller and DMA controller */
 	snd_es1938_capture_setdma(chip);
@@ -713,7 +713,7 @@ static int snd_es1938_playback1_prepare(struct snd_pcm_substream *substream)
 
 	/* program DMA */
 	snd_es1938_playback1_setdma(chip);
-	
+
 	return 0;
 }
 
@@ -735,10 +735,10 @@ static int snd_es1938_playback2_prepare(struct snd_pcm_substream *substream)
 	chip->dma1_shift = 2 - mono - is8;
 
 	count = 0x10000 - count;
- 
+
 	/* reset */
 	snd_es1938_reset_fifo(chip);
-	
+
 	snd_es1938_bits(chip, ESS_CMD_ANALOGCONTROL, 0x03, (mono ? 2 : 1));
 
 	/* set clock and counters */
@@ -749,13 +749,13 @@ static int snd_es1938_playback2_prepare(struct snd_pcm_substream *substream)
 	/* initialized and configure DAC */
         snd_es1938_write(chip, ESS_CMD_SETFORMAT, u ? 0x80 : 0x00);
         snd_es1938_write(chip, ESS_CMD_SETFORMAT, u ? 0x51 : 0x71);
-        snd_es1938_write(chip, ESS_CMD_SETFORMAT2, 
+        snd_es1938_write(chip, ESS_CMD_SETFORMAT2,
 			 0x90 | (mono ? 0x40 : 0x08) |
 			 (is8 ? 0x00 : 0x04) | (u ? 0x00 : 0x20));
 
 	/* program DMA */
 	snd_es1938_playback2_setdma(chip);
-	
+
 	return 0;
 }
 
@@ -1036,7 +1036,7 @@ static int __devinit snd_es1938_new_pcm(struct es1938 *chip, int device)
 		return err;
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_es1938_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_es1938_capture_ops);
-	
+
 	pcm->private_data = chip;
 	pcm->info_flags = 0;
 	strcpy(pcm->name, "ESS Solo-1");
@@ -1049,7 +1049,7 @@ static int __devinit snd_es1938_new_pcm(struct es1938 *chip, int device)
 }
 
 /* -------------------------------------------------------------------
- * 
+ *
  *                       *** Mixer part ***
  */
 
@@ -1083,7 +1083,7 @@ static int snd_es1938_put_mux(struct snd_kcontrol *kcontrol,
 {
 	struct es1938 *chip = snd_kcontrol_chip(kcontrol);
 	unsigned char val = ucontrol->value.enumerated.item[0];
-	
+
 	if (val > 7)
 		return -EINVAL;
 	return snd_es1938_mixer_bits(chip, 0x1c, 0x07, val) != val;
@@ -1207,7 +1207,7 @@ static int snd_es1938_get_single(struct snd_kcontrol *kcontrol,
 	int mask = (kcontrol->private_value >> 16) & 0xff;
 	int invert = (kcontrol->private_value >> 24) & 0xff;
 	int val;
-	
+
 	val = snd_es1938_reg_read(chip, reg);
 	ucontrol->value.integer.value[0] = (val >> shift) & mask;
 	if (invert)
@@ -1224,7 +1224,7 @@ static int snd_es1938_put_single(struct snd_kcontrol *kcontrol,
 	int mask = (kcontrol->private_value >> 16) & 0xff;
 	int invert = (kcontrol->private_value >> 24) & 0xff;
 	unsigned char val;
-	
+
 	val = (ucontrol->value.integer.value[0] & mask);
 	if (invert)
 		val = mask - val;
@@ -1270,7 +1270,7 @@ static int snd_es1938_get_double(struct snd_kcontrol *kcontrol,
 	int mask = (kcontrol->private_value >> 24) & 0xff;
 	int invert = (kcontrol->private_value >> 22) & 1;
 	unsigned char left, right;
-	
+
 	left = snd_es1938_reg_read(chip, left_reg);
 	if (left_reg != right_reg)
 		right = snd_es1938_reg_read(chip, right_reg);
@@ -1297,7 +1297,7 @@ static int snd_es1938_put_double(struct snd_kcontrol *kcontrol,
 	int invert = (kcontrol->private_value >> 22) & 1;
 	int change;
 	unsigned char val1, val2, mask1, mask2;
-	
+
 	val1 = ucontrol->value.integer.value[0] & mask;
 	val2 = ucontrol->value.integer.value[1] & mask;
 	if (invert) {
@@ -1315,7 +1315,7 @@ static int snd_es1938_put_double(struct snd_kcontrol *kcontrol,
 		if (snd_es1938_reg_bits(chip, right_reg, mask2, val2) != val2)
 			change = 1;
 	} else {
-		change = (snd_es1938_reg_bits(chip, left_reg, mask1 | mask2, 
+		change = (snd_es1938_reg_bits(chip, left_reg, mask1 | mask2,
 					      val1 | val2) != (val1 | val2));
 	}
 	return change;
@@ -1675,7 +1675,7 @@ static irqreturn_t snd_es1938_interrupt(int irq, void *dev_id)
 #if 0
 	printk("Es1938debug - interrupt status: =0x%x\n", status);
 #endif
-	
+
 	/* AUDIO 1 */
 	if (status & 0x10) {
 #if 0
@@ -1695,7 +1695,7 @@ static irqreturn_t snd_es1938_interrupt(int irq, void *dev_id)
 		else if (chip->active & DAC1)
 			snd_pcm_period_elapsed(chip->playback2_substream);
 	}
-	
+
 	/* AUDIO 2 */
 	if (status & 0x20) {
 #if 0
@@ -1731,10 +1731,10 @@ static irqreturn_t snd_es1938_interrupt(int irq, void *dev_id)
 
 	/* MPU401 */
 	if (status & 0x80) {
-		// the following line is evil! It switches off MIDI interrupt handling after the first interrupt received.
-		// replacing the last 0 by 0x40 works for ESS-Solo1, but just doing nothing works as well!
-		// andreas@flying-snail.de
-		// snd_es1938_mixer_bits(chip, ESSSB_IREG_MPU401CONTROL, 0x40, 0); /* ack? */
+		/* the following line is evil! It switches off MIDI interrupt handling after the first interrupt received. */
+		/* replacing the last 0 by 0x40 works for ESS-Solo1, but just doing nothing works as well! */
+		/* andreas@flying-snail.de */
+		/* snd_es1938_mixer_bits(chip, ESSSB_IREG_MPU401CONTROL, 0x40, 0); ack? */
 		if (chip->rmidi) {
 			handled = 1;
 			snd_mpu401_uart_interrupt(irq, chip->rmidi->private_data);
@@ -1781,7 +1781,7 @@ static int __devinit snd_es1938_mixer(struct es1938 *chip)
 	}
 	return 0;
 }
-       
+
 
 static int __devinit snd_es1938_probe(struct pci_dev *pci,
 				      const struct pci_device_id *pci_id)
@@ -1851,8 +1851,8 @@ static int __devinit snd_es1938_probe(struct pci_dev *pci,
 				chip->irq, 0, &chip->rmidi) < 0) {
 		printk(KERN_ERR "es1938: unable to initialize MPU-401\n");
 	} else {
-		// this line is vital for MIDI interrupt handling on ess-solo1
-		// andreas@flying-snail.de
+		/* this line is vital for MIDI interrupt handling on ess-solo1 */
+		/* andreas@flying-snail.de */
 		snd_es1938_mixer_bits(chip, ESSSB_IREG_MPU401CONTROL, 0x40, 0x40);
 	}
 
diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index 20ee759..46c383f 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -2,7 +2,7 @@
  *  Driver for ESS Maestro 1/2/2E Sound Card (started 21.8.99)
  *  Copyright (c) by Matze Braun <MatzeBraun@gmx.de>.
  *                   Takashi Iwai <tiwai@suse.de>
- *                  
+ *
  *  Most of the driver code comes from Zach Brown(zab@redhat.com)
  *	Alan Cox OSS Driver
  *  Rewritted from card-es1938.c source.
@@ -29,7 +29,7 @@
  *
  *  Hardware Description
  *
- *	A working Maestro setup contains the Maestro chip wired to a 
+ *	A working Maestro setup contains the Maestro chip wired to a
  *	codec or 2.  In the Maestro we have the APUs, the ASSP, and the
  *	Wavecache.  The APUs can be though of as virtual audio routing
  *	channels.  They can take data from a number of sources and perform
@@ -38,7 +38,7 @@
  *	APUs.  The ASSP is a wacky DSP like device that ESS is loth
  *	to release docs on.  Thankfully it isn't required on the Maestro
  *	until you start doing insane things like FM emulation and surround
- *	encoding.  The codecs are almost always AC-97 compliant codecs, 
+ *	encoding.  The codecs are almost always AC-97 compliant codecs,
  *	but it appears that early Maestros may have had PT101 (an ESS
  *	part?) wired to them.  The only real difference in the Maestro
  *	families is external goop like docking capability, memory for
@@ -76,7 +76,7 @@
  *	on open time.  The sonicvibes OSS routines we inherited really want
  *	power of 2 buffers, so we have all those next to each other, then
  *	512 byte regions for the recording wavecaches.  This ends up
- *	wasting quite a bit of memory.  The only fixes I can see would be 
+ *	wasting quite a bit of memory.  The only fixes I can see would be
  *	getting a kernel allocator that could work in zones, or figuring out
  *	just how to coerce the WP into doing what we want.
  *
@@ -86,7 +86,7 @@
  *	like the APU interface that is indirect registers gotten at through
  *	the main maestro indirection.  Ouch.  We spinlock around the actual
  *	ports on a per card basis.  This means spinlock activity at each IO
- *	operation, but the only IO operation clusters are in non critical 
+ *	operation, but the only IO operation clusters are in non critical
  *	paths and it makes the code far easier to follow.  Interrupts are
  *	blocked while holding the locks because the int handler has to
  *	get at some of them :(.  The mixer interface doesn't, however.
@@ -94,7 +94,7 @@
  *	places.
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -896,7 +896,7 @@ snd_es1968_calc_bob_rate(struct es1968 *chip, struct esschan *es,
 static u32 snd_es1968_compute_rate(struct es1968 *chip, u32 freq)
 {
 	u32 rate = (freq << 16) / chip->clock;
-#if 0 /* XXX: do we need this? */ 
+#if 0 /* XXX: do we need this? */
 	if (rate > 0x10000)
 		rate = 0x10000;
 #endif
@@ -971,7 +971,7 @@ static void snd_es1968_program_wavecache(struct es1968 *chip, struct esschan *es
 {
 	u32 tmpval = (addr - 0x10) & 0xFFF8;
 
-	if (! capture) {
+	if (!capture) {
 		if (!(es->fmt & ESS_FMT_16BIT))
 			tmpval |= 4;	/* 8bit */
 		if (es->fmt & ESS_FMT_STEREO)
@@ -1059,7 +1059,7 @@ static void snd_es1968_playback_setup(struct es1968 *chip, struct esschan *es,
 			   and not the APU Regs 4-5. */
 			apu_set_register(chip, apu, 10,
 					 0x8F00 | (channel ? 0 : 0x10));
-			es->apu_mode[channel] += 1;	/* stereo */
+			es->apu_mode[channel]++;	/* stereo */
 		} else
 			apu_set_register(chip, apu, 10, 0x8F08);
 	}
@@ -1255,7 +1255,7 @@ static int snd_es1968_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		if (! es->running)
+		if (!es->running)
 			break;
 		snd_es1968_pcm_stop(chip, es);
 		es->running = 0;
@@ -1273,7 +1273,7 @@ static snd_pcm_uframes_t snd_es1968_pcm_pointer(struct snd_pcm_substream *substr
 	unsigned int ptr;
 
 	ptr = snd_es1968_get_dma_ptr(chip, es) << es->wav_shift;
-	
+
 	return bytes_to_frames(substream->runtime, ptr % es->dma_size);
 }
 
@@ -1407,7 +1407,7 @@ static void snd_es1968_free_dmabuf(struct es1968 *chip)
 {
 	struct list_head *p;
 
-	if (! chip->dma.area)
+	if (!chip->dma.area)
 		return;
 	snd_dma_reserve_buf(&chip->dma, snd_dma_pci_buf_id(chip->pci));
 	while ((p = chip->buf_list.next) != &chip->buf_list) {
@@ -1425,11 +1425,11 @@ snd_es1968_init_dmabuf(struct es1968 *chip)
 
 	chip->dma.dev.type = SNDRV_DMA_TYPE_DEV;
 	chip->dma.dev.dev = snd_dma_pci_data(chip->pci);
-	if (! snd_dma_get_reserved_buf(&chip->dma, snd_dma_pci_buf_id(chip->pci))) {
+	if (!snd_dma_get_reserved_buf(&chip->dma, snd_dma_pci_buf_id(chip->pci))) {
 		err = snd_dma_alloc_pages_fallback(SNDRV_DMA_TYPE_DEV,
 						   snd_dma_pci_data(chip->pci),
 						   chip->total_bufsize, &chip->dma);
-		if (err < 0 || ! chip->dma.area) {
+		if (err < 0 || !chip->dma.area) {
 			snd_printk(KERN_ERR "es1968: can't allocate dma pages for size %d\n",
 				   chip->total_bufsize);
 			return -ENOMEM;
@@ -1478,7 +1478,7 @@ static int snd_es1968_hw_params(struct snd_pcm_substream *substream,
 	}
 	chan->memory = snd_es1968_new_memory(chip, size);
 	if (chan->memory == NULL) {
-		// snd_printd("cannot allocate dma buffer: size = %d\n", size);
+		/* snd_printd("cannot allocate dma buffer: size = %d\n", size); */
 		return -ENOMEM;
 	}
 	snd_pcm_set_runtime_buffer(substream, &chan->memory->buf);
@@ -1491,7 +1491,7 @@ static int snd_es1968_hw_free(struct snd_pcm_substream *substream)
 	struct es1968 *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct esschan *chan;
-	
+
 	if (runtime->private_data == NULL)
 		return 0;
 	chan = runtime->private_data;
@@ -1586,7 +1586,7 @@ static int snd_es1968_capture_open(struct snd_pcm_substream *substream)
 		snd_es1968_free_apu_pair(chip, apu1);
 		return apu2;
 	}
-	
+
 	es = kzalloc(sizeof(*es), GFP_KERNEL);
 	if (!es) {
 		snd_es1968_free_apu_pair(chip, apu1);
@@ -1854,7 +1854,7 @@ static void snd_es1968_update_pcm(struct es1968 *chip, struct esschan *es)
 	unsigned int hwptr;
 	unsigned int diff;
 	struct snd_pcm_substream *subs = es->substream;
-        
+
 	if (subs == NULL || !es->running)
 		return;
 
@@ -1895,7 +1895,7 @@ static void es1968_update_hw_volume(unsigned long private_data)
 	if (chip->in_suspend)
 		return;
 
-	if (! chip->master_switch || ! chip->master_volume)
+	if (!chip->master_switch || ! chip->master_volume)
 		return;
 
 	/* FIXME: we can't call snd_ac97_* functions since here is in tasklet. */
@@ -2038,7 +2038,7 @@ static void snd_es1968_ac97_reset(struct es1968 *chip)
 	/* save configuration */
 	save_ringbus_a = inw(ioaddr + 0x36);
 
-	//outw(inw(ioaddr + 0x38) & 0xfffc, ioaddr + 0x38); /* clear second codec id? */
+	/* outw(inw(ioaddr + 0x38) & 0xfffc, ioaddr + 0x38); clear second codec id? */
 	/* set command/status address i/o to 1st codec */
 	outw(inw(ioaddr + 0x3a) & 0xfffc, ioaddr + 0x3a);
 	outw(inw(ioaddr + 0x3c) & 0xfffc, ioaddr + 0x3c);
@@ -2072,7 +2072,7 @@ static void snd_es1968_ac97_reset(struct es1968 *chip)
 	udelay(20);
 	outw(0x0009, ioaddr + 0x60);	/* write 9 to gpio */
 	msleep(500);
-	//outw(inw(ioaddr + 0x38) & 0xfffc, ioaddr + 0x38);
+	/* outw(inw(ioaddr + 0x38) & 0xfffc, ioaddr + 0x38); */
 	outw(inw(ioaddr + 0x3a) & 0xfffc, ioaddr + 0x3a);
 	outw(inw(ioaddr + 0x3c) & 0xfffc, ioaddr + 0x3c);
 
@@ -2154,15 +2154,15 @@ static void snd_es1968_chip_init(struct es1968 *chip)
 
 	/* We used to muck around with pci config space that
 	 * we had no business messing with.  We don't know enough
-	 * about the machine to know which DMA mode is appropriate, 
+	 * about the machine to know which DMA mode is appropriate,
 	 * etc.  We were guessing wrong on some machines and making
 	 * them unhappy.  We now trust in the BIOS to do things right,
 	 * which almost certainly means a new host of problems will
-	 * arise with broken BIOS implementations.  screw 'em. 
+	 * arise with broken BIOS implementations.  screw 'em.
 	 * We're already intolerant of machines that don't assign
 	 * IRQs.
 	 */
-	
+
 	/* Config Reg A */
 	pci_read_config_word(pci, ESM_CONFIG_A, &w);
 
@@ -2172,7 +2172,7 @@ static void snd_es1968_chip_init(struct es1968 *chip)
 	w |= POST_WRITE;	/* Posted write */
 	w |= PCI_TIMING;	/* PCI timing on */
 	/* XXX huh?  claims to be reserved.. */
-	w &= ~SWAP_LR;		/* swap left/right 
+	w &= ~SWAP_LR;		/* swap left/right
 				   seems to only have effect on SB
 				   Emulation */
 	w &= ~SUBTR_DECODE;	/* Subtractive decode off */
@@ -2223,7 +2223,7 @@ static void snd_es1968_chip_init(struct es1968 *chip)
 	w|=1<<3;	/* Turn on 978 hardware volume control. */
 	w&=~(1<<11);	/* Turn on 978 mixer volume control. */
 	pci_write_config_word(pci, 0x58, w);
-	
+
 	/* Sound Reset */
 
 	snd_es1968_reset(chip);
@@ -2241,14 +2241,14 @@ static void snd_es1968_chip_init(struct es1968 *chip)
 	/*
 	 *	Reset the CODEC
 	 */
-	 
+
 	snd_es1968_ac97_reset(chip);
 
 	/* Ring Bus Control B */
 
 	n = inl(iobase + ESM_RING_BUS_CONTR_B);
 	n &= ~RINGB_EN_SPDIF;	/* SPDIF off */
-	//w |= RINGB_EN_2CODEC;	/* enable 2nd codec */
+	/* w |= RINGB_EN_2CODEC;	enable 2nd codec */
 	outl(n, iobase + ESM_RING_BUS_CONTR_B);
 
 	/* Set hardware volume control registers to midpoints.
@@ -2306,7 +2306,7 @@ static void snd_es1968_chip_init(struct es1968 *chip)
 
 	maestro_write(chip, 0x0D, 0x7632);
 
-	/* Wave cache control on - test off, sg off, 
+	/* Wave cache control on - test off, sg off,
 	   enable, enable extra chans 1Mb */
 
 	w = inw(iobase + WC_CONTROL);
@@ -2353,7 +2353,7 @@ static int es1968_suspend(struct pci_dev *pci, pm_message_t state)
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct es1968 *chip = card->private_data;
 
-	if (! chip->do_pm)
+	if (!chip->do_pm)
 		return 0;
 
 	chip->in_suspend = 1;
@@ -2374,7 +2374,7 @@ static int es1968_resume(struct pci_dev *pci)
 	struct es1968 *chip = card->private_data;
 	struct esschan *es;
 
-	if (! chip->do_pm)
+	if (!chip->do_pm)
 		return 0;
 
 	/* restore all our config */
@@ -2390,7 +2390,7 @@ static int es1968_resume(struct pci_dev *pci)
 
 	snd_es1968_chip_init(chip);
 
-	/* need to restore the base pointers.. */ 
+	/* need to restore the base pointers.. */
 	if (chip->dma.addr) {
 		/* set PCMBAR */
 		wave_set_register(chip, 0x01FC, chip->dma.addr >> 12);
@@ -2547,7 +2547,7 @@ static int __devinit snd_es1968_create(struct snd_card *card,
 	}
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (! chip) {
+	if (!chip) {
 		pci_disable_device(pci);
 		return -ENOMEM;
 	}
@@ -2581,7 +2581,7 @@ static int __devinit snd_es1968_create(struct snd_card *card,
 		return -EBUSY;
 	}
 	chip->irq = pci->irq;
-	        
+
 	/* Clear Maestro_map */
 	for (i = 0; i < 32; i++)
 		chip->maestro_map[i] = 0;
@@ -2648,14 +2648,14 @@ static int __devinit snd_es1968_probe(struct pci_dev *pci,
 	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
 	if (!card)
 		return -ENOMEM;
-                
+
 	if (total_bufsize[dev] < 128)
 		total_bufsize[dev] = 128;
 	if (total_bufsize[dev] > 4096)
 		total_bufsize[dev] = 4096;
 	if ((err = snd_es1968_create(card, pci,
 				     total_bufsize[dev] * 1024, /* in bytes */
-				     pcm_substreams_p[dev], 
+				     pcm_substreams_p[dev],
 				     pcm_substreams_c[dev],
 				     pci_id->driver_data,
 				     use_pm[dev],
@@ -2716,7 +2716,7 @@ static int __devinit snd_es1968_probe(struct pci_dev *pci,
 	snd_es1968_start_irq(chip);
 
 	chip->clock = clock[dev];
-	if (! chip->clock)
+	if (!chip->clock)
 		es1968_measure_clock(chip);
 
 	sprintf(card->longname, "%s at 0x%lx, irq %i",
