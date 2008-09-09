From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 03/24] sound/pci: coding style fixes:
	sound/pci/a*
Date: Tue, 9 Sep 2008 05:47:03 +0400
Message-ID: <20080909014703.GG6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.149])
	by alsa0.perex.cz (Postfix) with ESMTP id BEDC82447A
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 03:47:10 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 21so725435eyc.56
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 18:47:10 -0700 (PDT)
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

 sound/pci/ad1889.c          |  116 +++++++++++++++++++++---------------------
 sound/pci/ak4531_codec.c    |   14 +++---
 sound/pci/als300.c          |   16 +++---
 sound/pci/als4000.c         |   70 +++++++++++++-------------
 sound/pci/atiixp.c          |   64 ++++++++++++------------
 sound/pci/atiixp_modem.c    |   46 +++++++++---------
 sound/pci/aw2/aw2-alsa.c    |    2 +-
 sound/pci/aw2/aw2-saa7146.c |    2 +-
 sound/pci/azt3328.c         |   12 ++--
 sound/pci/azt3328.h         |    6 +-
 10 files changed, 174 insertions(+), 174 deletions(-)

diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index 92f3a97..5fdca0e 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -45,7 +45,7 @@
 #include <sound/initval.h>
 #include <sound/ac97_codec.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include "ad1889.h"
 #include "ac97/ac97_id.h"
@@ -137,7 +137,7 @@ static inline void
 ad1889_unmute(struct snd_ad1889 *chip)
 {
 	u16 st;
-	st = ad1889_readw(chip, AD_DS_WADA) & 
+	st = ad1889_readw(chip, AD_DS_WADA) &
 		~(AD_DS_WADA_RWAM | AD_DS_WADA_LWAM);
 	ad1889_writew(chip, AD_DS_WADA, st);
 	ad1889_readw(chip, AD_DS_WADA);
@@ -198,13 +198,13 @@ static void
 ad1889_channel_reset(struct snd_ad1889 *chip, unsigned int channel)
 {
 	u16 reg;
-	
+
 	if (channel & AD_CHAN_WAV) {
 		/* Disable wave channel */
 		reg = ad1889_readw(chip, AD_DS_WSMC) & ~AD_DS_WSMC_WAEN;
 		ad1889_writew(chip, AD_DS_WSMC, reg);
 		chip->wave.reg = reg;
-		
+
 		/* disable IRQs */
 		reg = ad1889_readw(chip, AD_DMA_WAV);
 		reg &= AD_DMA_IM_DIS;
@@ -219,7 +219,7 @@ ad1889_channel_reset(struct snd_ad1889 *chip, unsigned int channel)
 		/* flush */
 		ad1889_readw(chip, AD_DMA_WAV);
 	}
-	
+
 	if (channel & AD_CHAN_ADC) {
 		/* Disable ADC channel */
 		reg = ad1889_readw(chip, AD_DS_RAMC) & ~AD_DS_RAMC_ADEN;
@@ -230,7 +230,7 @@ ad1889_channel_reset(struct snd_ad1889 *chip, unsigned int channel)
 		reg &= AD_DMA_IM_DIS;
 		reg &= ~AD_DMA_LOOP;
 		ad1889_writew(chip, AD_DMA_ADC, reg);
-	
+
 		ad1889_load_adc_buffer_address(chip, 0x0);
 		ad1889_load_adc_buffer_count(chip, 0x0);
 		ad1889_load_adc_interrupt_count(chip, 0x0);
@@ -258,8 +258,8 @@ static int
 snd_ad1889_ac97_ready(struct snd_ad1889 *chip)
 {
 	int retry = 400; /* average needs 352 msec */
-	
-	while (!(ad1889_readw(chip, AD_AC97_ACIC) & AD_AC97_ACIC_ACRDY) 
+
+	while (!(ad1889_readw(chip, AD_AC97_ACIC) & AD_AC97_ACIC_ACRDY)
 			&& --retry)
 		mdelay(1);
 	if (!retry) {
@@ -272,11 +272,11 @@ snd_ad1889_ac97_ready(struct snd_ad1889 *chip)
 	return 0;
 }
 
-static int 
+static int
 snd_ad1889_hw_params(struct snd_pcm_substream *substream,
 			struct snd_pcm_hw_params *hw_params)
 {
-	return snd_pcm_lib_malloc_pages(substream, 
+	return snd_pcm_lib_malloc_pages(substream,
 					params_buffer_bytes(hw_params));
 }
 
@@ -372,7 +372,7 @@ snd_ad1889_playback_prepare(struct snd_pcm_substream *ss)
 	ad1889_channel_reset(chip, AD_CHAN_WAV);
 
 	reg = ad1889_readw(chip, AD_DS_WSMC);
-	
+
 	/* Mask out 16-bit / Stereo */
 	reg &= ~(AD_DS_WSMC_WA16 | AD_DS_WSMC_WAST);
 
@@ -384,13 +384,13 @@ snd_ad1889_playback_prepare(struct snd_pcm_substream *ss)
 
 	/* let's make sure we don't clobber ourselves */
 	spin_lock_irq(&chip->lock);
-	
+
 	chip->wave.size = size;
 	chip->wave.reg = reg;
 	chip->wave.addr = rt->dma_addr;
 
 	ad1889_writew(chip, AD_DS_WSMC, chip->wave.reg);
-	
+
 	/* Set sample rates on the codec */
 	ad1889_writew(chip, AD_DS_WAS, rt->rate);
 
@@ -401,9 +401,9 @@ snd_ad1889_playback_prepare(struct snd_pcm_substream *ss)
 
 	/* writes flush */
 	ad1889_readw(chip, AD_DS_WSMC);
-	
+
 	spin_unlock_irq(&chip->lock);
-	
+
 	ad1889_debug("prepare playback: addr = 0x%x, count = %u, "
 			"size = %u, reg = 0x%x, rate = %u\n", chip->wave.addr,
 			count, size, reg, rt->rate);
@@ -420,7 +420,7 @@ snd_ad1889_capture_prepare(struct snd_pcm_substream *ss)
 	u16 reg;
 
 	ad1889_channel_reset(chip, AD_CHAN_ADC);
-	
+
 	reg = ad1889_readw(chip, AD_DS_RAMC);
 
 	/* Mask out 16-bit / Stereo */
@@ -434,7 +434,7 @@ snd_ad1889_capture_prepare(struct snd_pcm_substream *ss)
 
 	/* let's make sure we don't clobber ourselves */
 	spin_lock_irq(&chip->lock);
-	
+
 	chip->ramc.size = size;
 	chip->ramc.reg = reg;
 	chip->ramc.addr = rt->dma_addr;
@@ -448,9 +448,9 @@ snd_ad1889_capture_prepare(struct snd_pcm_substream *ss)
 
 	/* writes flush */
 	ad1889_readw(chip, AD_DS_RAMC);
-	
+
 	spin_unlock_irq(&chip->lock);
-	
+
 	ad1889_debug("prepare capture: addr = 0x%x, count = %u, "
 			"size = %u, reg = 0x%x, rate = %u\n", chip->ramc.addr,
 			count, size, reg, rt->rate);
@@ -466,7 +466,7 @@ snd_ad1889_playback_trigger(struct snd_pcm_substream *ss, int cmd)
 {
 	u16 wsmc;
 	struct snd_ad1889 *chip = snd_pcm_substream_chip(ss);
-	
+
 	wsmc = ad1889_readw(chip, AD_DS_WSMC);
 
 	switch (cmd) {
@@ -486,9 +486,9 @@ snd_ad1889_playback_trigger(struct snd_pcm_substream *ss, int cmd)
 		snd_BUG();
 		return -EINVAL;
 	}
-	
+
 	chip->wave.reg = wsmc;
-	ad1889_writew(chip, AD_DS_WSMC, wsmc);	
+	ad1889_writew(chip, AD_DS_WSMC, wsmc);
 	ad1889_readw(chip, AD_DS_WSMC);	/* flush */
 
 	/* reset the chip when STOP - will disable IRQs */
@@ -509,7 +509,7 @@ snd_ad1889_capture_trigger(struct snd_pcm_substream *ss, int cmd)
 	struct snd_ad1889 *chip = snd_pcm_substream_chip(ss);
 
 	ramc = ad1889_readw(chip, AD_DS_RAMC);
-	
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		/* enable DMA loop & interrupts */
@@ -524,15 +524,15 @@ snd_ad1889_capture_trigger(struct snd_pcm_substream *ss, int cmd)
 	default:
 		return -EINVAL;
 	}
-	
+
 	chip->ramc.reg = ramc;
-	ad1889_writew(chip, AD_DS_RAMC, ramc);	
+	ad1889_writew(chip, AD_DS_RAMC, ramc);
 	ad1889_readw(chip, AD_DS_RAMC);	/* flush */
-	
+
 	/* reset the chip when STOP - will disable IRQs */
 	if (cmd == SNDRV_PCM_TRIGGER_STOP)
 		ad1889_channel_reset(chip, AD_CHAN_ADC);
-		
+
 	return 0;
 }
 
@@ -548,10 +548,10 @@ snd_ad1889_playback_pointer(struct snd_pcm_substream *ss)
 
 	ptr = ad1889_readl(chip, AD_DMA_WAVCA);
 	ptr -= chip->wave.addr;
-	
+
 	if (snd_BUG_ON(ptr >= chip->wave.size))
 		return 0;
-	
+
 	return bytes_to_frames(ss->runtime, ptr);
 }
 
@@ -570,7 +570,7 @@ snd_ad1889_capture_pointer(struct snd_pcm_substream *ss)
 
 	if (snd_BUG_ON(ptr >= chip->ramc.size))
 		return 0;
-	
+
 	return bytes_to_frames(ss->runtime, ptr);
 }
 
@@ -582,7 +582,7 @@ static struct snd_pcm_ops snd_ad1889_playback_ops = {
 	.hw_free = snd_ad1889_hw_free,
 	.prepare = snd_ad1889_playback_prepare,
 	.trigger = snd_ad1889_playback_trigger,
-	.pointer = snd_ad1889_playback_pointer, 
+	.pointer = snd_ad1889_playback_pointer,
 };
 
 static struct snd_pcm_ops snd_ad1889_capture_ops = {
@@ -593,7 +593,7 @@ static struct snd_pcm_ops snd_ad1889_capture_ops = {
 	.hw_free = snd_ad1889_hw_free,
 	.prepare = snd_ad1889_capture_prepare,
 	.trigger = snd_ad1889_capture_trigger,
-	.pointer = snd_ad1889_capture_pointer, 
+	.pointer = snd_ad1889_capture_pointer,
 };
 
 static irqreturn_t
@@ -636,7 +636,7 @@ snd_ad1889_pcm_init(struct snd_ad1889 *chip, int device, struct snd_pcm **rpcm)
 	if (err < 0)
 		return err;
 
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, 
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
 			&snd_ad1889_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
 			&snd_ad1889_capture_ops);
@@ -644,7 +644,7 @@ snd_ad1889_pcm_init(struct snd_ad1889 *chip, int device, struct snd_pcm **rpcm)
 	pcm->private_data = chip;
 	pcm->info_flags = 0;
 	strcpy(pcm->name, chip->card->shortname);
-	
+
 	chip->pcm = pcm;
 	chip->psubs = NULL;
 	chip->csubs = NULL;
@@ -658,10 +658,10 @@ snd_ad1889_pcm_init(struct snd_ad1889 *chip, int device, struct snd_pcm **rpcm)
 		snd_printk(KERN_ERR PFX "buffer allocation error: %d\n", err);
 		return err;
 	}
-	
+
 	if (rpcm)
 		*rpcm = pcm;
-	
+
 	return 0;
 }
 
@@ -679,24 +679,24 @@ snd_ad1889_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffe
 			(reg & AD_DS_WSMC_WAST) ? "stereo" : "mono");
 	snd_iprintf(buffer, "Wave Quality: %d-bit linear\n",
 			(reg & AD_DS_WSMC_WA16) ? 16 : 8);
-	
+
 	/* WARQ is at offset 12 */
 	tmp = (reg & AD_DS_WSMC_WARQ) ?
 			(((reg & AD_DS_WSMC_WARQ >> 12) & 0x01) ? 12 : 18) : 4;
 	tmp /= (reg & AD_DS_WSMC_WAST) ? 2 : 1;
-	
+
 	snd_iprintf(buffer, "Wave FIFO: %d %s words\n\n", tmp,
 			(reg & AD_DS_WSMC_WAST) ? "stereo" : "mono");
-				
-	
+
+
 	snd_iprintf(buffer, "Synthesis output: %s\n",
 			reg & AD_DS_WSMC_SYEN ? "enabled" : "disabled");
-	
+
 	/* SYRQ is at offset 4 */
 	tmp = (reg & AD_DS_WSMC_SYRQ) ?
 			(((reg & AD_DS_WSMC_SYRQ >> 4) & 0x01) ? 12 : 18) : 4;
 	tmp /= (reg & AD_DS_WSMC_WAST) ? 2 : 1;
-	
+
 	snd_iprintf(buffer, "Synthesis FIFO: %d %s words\n\n", tmp,
 			(reg & AD_DS_WSMC_WAST) ? "stereo" : "mono");
 
@@ -707,27 +707,27 @@ snd_ad1889_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffe
 			(reg & AD_DS_RAMC_ADST) ? "stereo" : "mono");
 	snd_iprintf(buffer, "ADC Quality: %d-bit linear\n",
 			(reg & AD_DS_RAMC_AD16) ? 16 : 8);
-	
+
 	/* ACRQ is at offset 4 */
 	tmp = (reg & AD_DS_RAMC_ACRQ) ?
 			(((reg & AD_DS_RAMC_ACRQ >> 4) & 0x01) ? 12 : 18) : 4;
 	tmp /= (reg & AD_DS_RAMC_ADST) ? 2 : 1;
-	
+
 	snd_iprintf(buffer, "ADC FIFO: %d %s words\n\n", tmp,
 			(reg & AD_DS_RAMC_ADST) ? "stereo" : "mono");
-	
+
 	snd_iprintf(buffer, "Resampler input: %s\n",
 			reg & AD_DS_RAMC_REEN ? "enabled" : "disabled");
-			
+
 	/* RERQ is at offset 12 */
 	tmp = (reg & AD_DS_RAMC_RERQ) ?
 			(((reg & AD_DS_RAMC_RERQ >> 12) & 0x01) ? 12 : 18) : 4;
 	tmp /= (reg & AD_DS_RAMC_ADST) ? 2 : 1;
-	
+
 	snd_iprintf(buffer, "Resampler FIFO: %d %s words\n\n", tmp,
 			(reg & AD_DS_WSMC_WAST) ? "stereo" : "mono");
-				
-	
+
+
 	/* doc says LSB represents -1.5dB, but the max value (-94.5dB)
 	suggests that LSB is -3dB, which is more coherent with the logarithmic
 	nature of the dB scale */
@@ -739,7 +739,7 @@ snd_ad1889_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffe
 	snd_iprintf(buffer, "Right: %s, -%d dB\n",
 			(reg & AD_DS_WADA_RWAM) ? "mute" : "unmute",
 			((reg & AD_DS_WADA_RWAA) >> 8) * 3);
-	
+
 	reg = ad1889_readw(chip, AD_DS_WAS);
 	snd_iprintf(buffer, "Wave samplerate: %u Hz\n", reg);
 	reg = ad1889_readw(chip, AD_DS_RES);
@@ -779,7 +779,7 @@ snd_ad1889_ac97_xinit(struct snd_ad1889 *chip)
 	/* Interface Enable */
 	reg |= AD_AC97_ACIC_ACIE;
 	ad1889_writew(chip, AD_AC97_ACIC, reg);
-	
+
 	snd_ad1889_ac97_ready(chip);
 
 	/* Audio Stream Output | Variable Sample Rate Mode */
@@ -820,7 +820,7 @@ snd_ad1889_ac97_init(struct snd_ad1889 *chip, const char *quirk_override)
 	err = snd_ac97_bus(chip->card, 0, &ops, chip, &chip->ac97_bus);
 	if (err < 0)
 		return err;
-	
+
 	chip->ac97_bus->private_free = snd_ad1889_ac97_bus_free;
 
 	memset(&ac97, 0, sizeof(ac97));
@@ -831,9 +831,9 @@ snd_ad1889_ac97_init(struct snd_ad1889 *chip, const char *quirk_override)
 	err = snd_ac97_mixer(chip->ac97_bus, &ac97, &chip->ac97);
 	if (err < 0)
 		return err;
-		
+
 	snd_ac97_tune_hardware(chip->ac97, ac97_quirks, quirk_override);
-	
+
 	return 0;
 }
 
@@ -871,14 +871,14 @@ skip_hw:
 }
 
 static int
-snd_ad1889_dev_free(struct snd_device *device) 
+snd_ad1889_dev_free(struct snd_device *device)
 {
 	struct snd_ad1889 *chip = device->device_data;
 	return snd_ad1889_free(chip);
 }
 
 static int __devinit
-snd_ad1889_init(struct snd_ad1889 *chip) 
+snd_ad1889_init(struct snd_ad1889 *chip)
 {
 	ad1889_writew(chip, AD_DS_CCS, AD_DS_CCS_CLKEN); /* turn on clock */
 	ad1889_readw(chip, AD_DS_CCS);	/* flush posted write */
@@ -938,7 +938,7 @@ snd_ad1889_create(struct snd_card *card,
 		err = -EBUSY;
 		goto free_and_ret;
 	}
-	
+
 	pci_set_master(pci);
 
 	spin_lock_init(&chip->lock);	/* only now can we call ad1889_free */
@@ -1017,7 +1017,7 @@ snd_ad1889_probe(struct pci_dev *pci,
 	err = snd_ad1889_ac97_init(chip, ac97_quirk[devno]);
 	if (err < 0)
 		goto free_and_ret;
-	
+
 	err = snd_ad1889_pcm_init(chip, 0, NULL);
 	if (err < 0)
 		goto free_and_ret;
diff --git a/sound/pci/ak4531_codec.c b/sound/pci/ak4531_codec.c
index 0f819dd..0275686 100644
--- a/sound/pci/ak4531_codec.c
+++ b/sound/pci/ak4531_codec.c
@@ -43,13 +43,13 @@ static void snd_ak4531_proc_init(struct snd_card *card, struct snd_ak4531 *ak453
 /*
  *
  */
- 
+
 #if 0
 
 static void snd_ak4531_dump(struct snd_ak4531 *ak4531)
 {
 	int idx;
-	
+
 	for (idx = 0; idx < 0x19; idx++)
 		printk("ak4531 0x%x: 0x%x\n", idx, ak4531->regs[idx]);
 }
@@ -84,7 +84,7 @@ static int snd_ak4531_info_single(struct snd_kcontrol *kcontrol, struct snd_ctl_
 	uinfo->value.integer.max = mask;
 	return 0;
 }
- 
+
 static int snd_ak4531_get_single(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ak4531 *ak4531 = snd_kcontrol_chip(kcontrol);
@@ -151,7 +151,7 @@ static int snd_ak4531_info_double(struct snd_kcontrol *kcontrol, struct snd_ctl_
 	uinfo->value.integer.max = mask;
 	return 0;
 }
- 
+
 static int snd_ak4531_get_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ak4531 *ak4531 = snd_kcontrol_chip(kcontrol);
@@ -226,7 +226,7 @@ static int snd_ak4531_info_input_sw(struct snd_kcontrol *kcontrol, struct snd_ct
 	uinfo->value.integer.max = 1;
 	return 0;
 }
- 
+
 static int snd_ak4531_get_input_sw(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ak4531 *ak4531 = snd_kcontrol_chip(kcontrol);
@@ -469,7 +469,7 @@ void snd_ak4531_resume(struct snd_ak4531 *ak4531)
  * /proc interface
  */
 
-static void snd_ak4531_proc_read(struct snd_info_entry *entry, 
+static void snd_ak4531_proc_read(struct snd_info_entry *entry,
 				 struct snd_info_buffer *buffer)
 {
 	struct snd_ak4531 *ak4531 = entry->private_data;
@@ -486,7 +486,7 @@ snd_ak4531_proc_init(struct snd_card *card, struct snd_ak4531 *ak4531)
 {
 	struct snd_info_entry *entry;
 
-	if (! snd_card_proc_new(card, "ak4531", &entry))
+	if (!snd_card_proc_new(card, "ak4531", &entry))
 		snd_info_set_text_ops(entry, ak4531, snd_ak4531_proc_read);
 }
 #endif
diff --git a/sound/pci/als300.c b/sound/pci/als300.c
index 8df6824..9799051 100644
--- a/sound/pci/als300.c
+++ b/sound/pci/als300.c
@@ -38,7 +38,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include <sound/core.h>
 #include <sound/control.h>
@@ -104,7 +104,7 @@
 #define snd_als300_dbgplay(format, args...) printk(KERN_ERR format, ##args)
 #else
 #define snd_als300_dbgplay(format, args...)
-#endif		
+#endif
 
 enum {DEVICE_ALS300, DEVICE_ALS300_PLUS};
 
@@ -136,7 +136,7 @@ struct snd_als300 {
 
 	int chip_type; /* ALS300 or ALS300+ */
 
-	char revision;	
+	char revision;
 };
 
 struct snd_als300_substream_data {
@@ -239,7 +239,7 @@ static irqreturn_t snd_als300plus_interrupt(int irq, void *dev_id)
 	u8 general, mpu, dram;
 	struct snd_als300 *chip = dev_id;
 	struct snd_als300_substream_data *data;
-	
+
 	general = inb(chip->port+ALS300P_IRQ_STATUS);
 	mpu = inb(chip->port+MPU_IRQ_STATUS);
 	dram = inb(chip->port+ALS300P_DRAM_IRQ_STATUS);
@@ -461,7 +461,7 @@ static int snd_als300_playback_prepare(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned short period_bytes = snd_pcm_lib_period_bytes(substream);
 	unsigned short buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
-	
+
 	snd_als300_dbgcallenter();
 	spin_lock_irq(&chip->reg_lock);
 	tmp = snd_als300_gcr_read(chip->port, PLAYBACK_CONTROL);
@@ -469,7 +469,7 @@ static int snd_als300_playback_prepare(struct snd_pcm_substream *substream)
 
 	snd_als300_dbgplay("Period bytes: %d Buffer bytes %d\n",
 						period_bytes, buffer_bytes);
-	
+
 	/* set block size */
 	tmp &= 0xffff0000;
 	tmp |= period_bytes - 1;
@@ -571,7 +571,7 @@ static snd_pcm_uframes_t snd_als300_pointer(struct snd_pcm_substream *substream)
 
 	data = substream->runtime->private_data;
 	period_bytes = snd_pcm_lib_period_bytes(substream);
-	
+
 	snd_als300_dbgcallenter();
 	spin_lock(&chip->reg_lock);
 	current_ptr = (u16) snd_als300_gcr_read(chip->port,
@@ -641,7 +641,7 @@ static void snd_als300_init(struct snd_als300 *chip)
 {
 	unsigned long flags;
 	u32 tmp;
-	
+
 	snd_als300_dbgcallenter();
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	chip->revision = (snd_als300_gcr_read(chip->port, MISC_CONTROL) >> 16)
diff --git a/sound/pci/als4000.c b/sound/pci/als4000.c
index ba57005..14d58d8 100644
--- a/sound/pci/als4000.c
+++ b/sound/pci/als4000.c
@@ -33,15 +33,15 @@
  *  refer to: ALS4000a.PDF specs Ver 1.0, May 28th, 1998.
  *
  *  The ALS4000 seems to be the PCI-cousin of the ALS100. It contains an
- *  ALS100-like SB DSP/mixer, an OPL3 synth, a MPU401 and a gameport 
- *  interface. These subsystems can be mapped into ISA io-port space, 
- *  using the PCI-interface. In addition, the PCI-bit provides DMA and IRQ 
+ *  ALS100-like SB DSP/mixer, an OPL3 synth, a MPU401 and a gameport
+ *  interface. These subsystems can be mapped into ISA io-port space,
+ *  using the PCI-interface. In addition, the PCI-bit provides DMA and IRQ
  *  services to the subsystems.
- * 
+ *
  * While ALS4000 is very similar to a SoundBlaster, the differences in
  * DMA and capturing require more changes to the SoundBlaster than
  * desirable, so I made this separate driver.
- * 
+ *
  * The ALS4000 can do real full duplex playback/capture.
  *
  * FMDAC:
@@ -65,7 +65,7 @@
  * - power management? (card can do voice wakeup according to datasheet!!)
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
@@ -228,7 +228,7 @@ static inline void snd_als4k_gcr_write(struct snd_sb *sb,
 					 u32 val)
 {
 	snd_als4k_gcr_write_addr(sb->alt_port, reg, val);
-}	
+}
 
 static inline u32 snd_als4k_gcr_read_addr(unsigned long iobase,
 						 enum als4k_gcr_t reg)
@@ -337,7 +337,7 @@ static const struct {
 } playback_cmd_vals[]={
 /* ALS4000_FORMAT_U8_MONO */
 { SB_DSP4_OUT8_AI, SB_DSP_DMA8_ON, SB_DSP_DMA8_OFF, SB_DSP4_MODE_UNS_MONO },
-/* ALS4000_FORMAT_S8_MONO */	
+/* ALS4000_FORMAT_S8_MONO */
 { SB_DSP4_OUT8_AI, SB_DSP_DMA8_ON, SB_DSP_DMA8_OFF, SB_DSP4_MODE_SIGN_MONO },
 /* ALS4000_FORMAT_U16L_MONO */
 { SB_DSP4_OUT16_AI, SB_DSP_DMA16_ON, SB_DSP_DMA16_OFF, SB_DSP4_MODE_UNS_MONO },
@@ -345,7 +345,7 @@ static const struct {
 { SB_DSP4_OUT16_AI, SB_DSP_DMA16_ON, SB_DSP_DMA16_OFF, SB_DSP4_MODE_SIGN_MONO },
 /* ALS4000_FORMAT_U8_STEREO */
 { SB_DSP4_OUT8_AI, SB_DSP_DMA8_ON, SB_DSP_DMA8_OFF, SB_DSP4_MODE_UNS_STEREO },
-/* ALS4000_FORMAT_S8_STEREO */	
+/* ALS4000_FORMAT_S8_STEREO */
 { SB_DSP4_OUT8_AI, SB_DSP_DMA8_ON, SB_DSP_DMA8_OFF, SB_DSP4_MODE_SIGN_STEREO },
 /* ALS4000_FORMAT_U16L_STEREO */
 { SB_DSP4_OUT16_AI, SB_DSP_DMA16_ON, SB_DSP_DMA16_OFF, SB_DSP4_MODE_UNS_STEREO },
@@ -359,14 +359,14 @@ enum { CMD_WIDTH8=0x04, CMD_SIGNED=0x10, CMD_MONO=0x80, CMD_STEREO=0xA0 };
 static const unsigned char capture_cmd_vals[]=
 {
 CMD_WIDTH8|CMD_MONO,			/* ALS4000_FORMAT_U8_MONO */
-CMD_WIDTH8|CMD_SIGNED|CMD_MONO,		/* ALS4000_FORMAT_S8_MONO */	
+CMD_WIDTH8|CMD_SIGNED|CMD_MONO,		/* ALS4000_FORMAT_S8_MONO */
 CMD_MONO,				/* ALS4000_FORMAT_U16L_MONO */
 CMD_SIGNED|CMD_MONO,			/* ALS4000_FORMAT_S16L_MONO */
 CMD_WIDTH8|CMD_STEREO,			/* ALS4000_FORMAT_U8_STEREO */
-CMD_WIDTH8|CMD_SIGNED|CMD_STEREO,	/* ALS4000_FORMAT_S8_STEREO */	
+CMD_WIDTH8|CMD_SIGNED|CMD_STEREO,	/* ALS4000_FORMAT_S8_STEREO */
 CMD_STEREO,				/* ALS4000_FORMAT_U16L_STEREO */
 CMD_SIGNED|CMD_STEREO,			/* ALS4000_FORMAT_S16L_STEREO */
-};	
+};
 #define capture_cmd(chip) (capture_cmd_vals[(chip)->capture_format])
 
 static int snd_als4000_hw_params(struct snd_pcm_substream *substream,
@@ -389,10 +389,10 @@ static int snd_als4000_capture_prepare(struct snd_pcm_substream *substream)
 	unsigned count;
 
 	chip->capture_format = snd_als4000_get_format(runtime);
-		
+
 	size = snd_pcm_lib_buffer_bytes(substream);
 	count = snd_pcm_lib_period_bytes(substream);
-	
+
 	if (chip->capture_format & ALS4000_FORMAT_16BIT)
 		count >>= 1;
 	count--;
@@ -416,14 +416,14 @@ static int snd_als4000_playback_prepare(struct snd_pcm_substream *substream)
 	unsigned count;
 
 	chip->playback_format = snd_als4000_get_format(runtime);
-	
+
 	size = snd_pcm_lib_buffer_bytes(substream);
 	count = snd_pcm_lib_period_bytes(substream);
-	
+
 	if (chip->playback_format & ALS4000_FORMAT_16BIT)
 		count >>= 1;
 	count--;
-	
+
 	/* FIXME: from second playback on, there's a lot more clicks and pops
 	 * involved here than on first playback. Fiddling with
 	 * tons of different settings didn't help (DMA, speaker on/off,
@@ -433,16 +433,16 @@ static int snd_als4000_playback_prepare(struct snd_pcm_substream *substream)
 	spin_lock_irq(&chip->reg_lock);
 	snd_als4000_set_rate(chip, runtime->rate);
 	snd_als4000_set_playback_dma(chip, runtime->dma_addr, size);
-	
+
 	/* SPEAKER_ON not needed, since dma_on seems to also enable speaker */
 	/* snd_sbdsp_command(chip, SB_DSP_SPEAKER_ON); */
 	snd_sbdsp_command(chip, playback_cmd(chip).dsp_cmd);
 	snd_sbdsp_command(chip, playback_cmd(chip).format);
 	snd_sbdsp_command(chip, count & 0xff);
 	snd_sbdsp_command(chip, count >> 8);
-	snd_sbdsp_command(chip, playback_cmd(chip).dma_off);	
+	snd_sbdsp_command(chip, playback_cmd(chip).dma_off);
 	spin_unlock_irq(&chip->reg_lock);
-	
+
 	return 0;
 }
 
@@ -450,7 +450,7 @@ static int snd_als4000_capture_trigger(struct snd_pcm_substream *substream, int
 {
 	struct snd_sb *chip = snd_pcm_substream_chip(substream);
 	int result = 0;
-	
+
 	/* FIXME race condition in here!!!
 	   chip->mode non-atomic update gets consistently protected
 	   by reg_lock always, _except_ for this place!!
@@ -509,11 +509,11 @@ static snd_pcm_uframes_t snd_als4000_capture_pointer(struct snd_pcm_substream *s
 	struct snd_sb *chip = snd_pcm_substream_chip(substream);
 	unsigned int result;
 
-	spin_lock(&chip->reg_lock);	
+	spin_lock(&chip->reg_lock);
 	result = snd_als4k_gcr_read(chip, ALS4K_GCRA4_FIFO2_CURRENT_ADDR);
 	spin_unlock(&chip->reg_lock);
 	result &= 0xffff;
-	return bytes_to_frames( substream->runtime, result );
+	return bytes_to_frames(substream->runtime, result);
 }
 
 static snd_pcm_uframes_t snd_als4000_playback_pointer(struct snd_pcm_substream *substream)
@@ -521,11 +521,11 @@ static snd_pcm_uframes_t snd_als4000_playback_pointer(struct snd_pcm_substream *
 	struct snd_sb *chip = snd_pcm_substream_chip(substream);
 	unsigned result;
 
-	spin_lock(&chip->reg_lock);	
+	spin_lock(&chip->reg_lock);
 	result = snd_als4k_gcr_read(chip, ALS4K_GCRA0_FIFO1_CURRENT_ADDR);
 	spin_unlock(&chip->reg_lock);
 	result &= 0xffff;
-	return bytes_to_frames( substream->runtime, result );
+	return bytes_to_frames(substream->runtime, result);
 }
 
 /* FIXME: this IRQ routine doesn't really support IRQ sharing (we always
@@ -563,12 +563,12 @@ static irqreturn_t snd_als4000_interrupt(int irq, void *dev_id)
 	/* ACK the PCI block IRQ */
 	snd_als4k_iobase_writeb(chip->alt_port,
 			 ALS4K_IOB_0E_IRQTYPE_SB_CR1E_MPU, pci_irqstatus);
-	
+
 	spin_lock(&chip->mixer_lock);
 	/* SPECS_PAGE: 20 */
 	sb_irqstatus = snd_sbmixer_read(chip, SB_DSP4_IRQSTATUS);
 	spin_unlock(&chip->mixer_lock);
-	
+
 	if (sb_irqstatus & SB_IRQTYPE_8BIT)
 		snd_sb_ack_8bit(chip);
 	if (sb_irqstatus & SB_IRQTYPE_16BIT)
@@ -755,7 +755,7 @@ static void snd_als4000_configure(struct snd_sb *chip)
 	snd_als4_cr_write(chip, ALS4K_CR0_SB_CONFIG,
 				 tmp & ~ALS4K_CR0_MX80_81_REG_WRITE_ENABLE);
 	spin_unlock_irq(&chip->mixer_lock);
-	
+
 	spin_lock_irq(&chip->reg_lock);
 	/* enable interrupts */
 	snd_als4k_gcr_write(chip, ALS4K_GCR8C_MISC_CTRL,
@@ -764,7 +764,7 @@ static void snd_als4000_configure(struct snd_sb *chip)
 	/* SPECS_PAGE: 39 */
 	for (i = ALS4K_GCR91_DMA0_ADDR; i <= ALS4K_GCR96_DMA3_MODE_COUNT; ++i)
 		snd_als4k_gcr_write(chip, i, 0);
-	
+
 	snd_als4k_gcr_write(chip, ALS4K_GCR99_DMA_EMULATION_CTRL,
 		snd_als4k_gcr_read(chip, ALS4K_GCR99_DMA_EMULATION_CTRL));
 	spin_unlock_irq(&chip->reg_lock);
@@ -836,7 +836,7 @@ static inline int snd_als4000_create_gameport(struct snd_card_als4000 *acard, in
 static inline void snd_als4000_free_gameport(struct snd_card_als4000 *acard) { }
 #endif
 
-static void snd_card_als4000_free( struct snd_card *card )
+static void snd_card_als4000_free(struct snd_card *card)
 {
 	struct snd_card_als4000 *acard = card->private_data;
 
@@ -888,8 +888,8 @@ static int __devinit snd_card_als4000_probe(struct pci_dev *pci,
 	pci_read_config_word(pci, PCI_COMMAND, &word);
 	pci_write_config_word(pci, PCI_COMMAND, word | PCI_COMMAND_IO);
 	pci_set_master(pci);
-	
-	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 
+
+	card = snd_card_new(index[dev], id[dev], THIS_MODULE,
 			    sizeof(*acard) /* private_data: acard */);
 	if (card == NULL) {
 		pci_release_regions(pci);
@@ -948,7 +948,7 @@ static int __devinit snd_card_als4000_probe(struct pci_dev *pci,
 	}
 	if ((err = snd_sbmixer_new(chip)) < 0) {
 		goto out_err;
-	}	    
+	}
 
 	if (snd_opl3_create(card,
 				iobase + ALS4K_IOB_10_ADLIB_ADDR0,
@@ -975,7 +975,7 @@ static int __devinit snd_card_als4000_probe(struct pci_dev *pci,
 
 out_err:
 	snd_card_free(card);
-	
+
 out:
 	return err;
 }
@@ -994,7 +994,7 @@ static int snd_als4000_suspend(struct pci_dev *pci, pm_message_t state)
 	struct snd_sb *chip = acard->chip;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	
+
 	snd_pcm_suspend_all(chip->pcm);
 	snd_sbmixer_suspend(chip);
 
diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index 085a52b..3f9a2c5 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -19,7 +19,7 @@
  *
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -265,7 +265,7 @@ struct atiixp {
 	unsigned long addr;
 	void __iomem *remap_addr;
 	int irq;
-	
+
 	struct snd_ac97_bus *ac97_bus;
 	struct snd_ac97 *ac97[NUM_ATI_CODECS];
 
@@ -350,7 +350,7 @@ static int snd_atiixp_update_bits(struct atiixp *chip, unsigned int reg,
  * list.  although we can change the list dynamically, in this version,
  * a static RING of buffer descriptors is used.
  *
- * the ring is built in this function, and is set up to the hardware. 
+ * the ring is built in this function, and is set up to the hardware.
  */
 static int atiixp_build_dma_packets(struct atiixp *chip, struct atiixp_dma *dma,
 				    struct snd_pcm_substream *substream,
@@ -430,7 +430,7 @@ static int snd_atiixp_acquire_codec(struct atiixp *chip)
 	int timeout = 1000;
 
 	while (atiixp_read(chip, PHYS_OUT_ADDR) & ATI_REG_PHYS_OUT_ADDR_EN) {
-		if (! timeout--) {
+		if (!timeout--) {
 			snd_printk(KERN_WARNING "atiixp: codec acquire timeout\n");
 			return -EBUSY;
 		}
@@ -471,7 +471,7 @@ static void snd_atiixp_codec_write(struct atiixp *chip, unsigned short codec,
 				   unsigned short reg, unsigned short val)
 {
 	unsigned int data;
-    
+
 	if (snd_atiixp_acquire_codec(chip) < 0)
 		return;
 	data = ((unsigned int)val << ATI_REG_PHYS_OUT_DATA_SHIFT) |
@@ -486,7 +486,7 @@ static unsigned short snd_atiixp_ac97_read(struct snd_ac97 *ac97,
 {
 	struct atiixp *chip = ac97->private_data;
 	return snd_atiixp_codec_read(chip, ac97->num, reg);
-    
+
 }
 
 static void snd_atiixp_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
@@ -512,9 +512,9 @@ static int snd_atiixp_aclink_reset(struct atiixp *chip)
 	atiixp_read(chip, CMD);
 	udelay(10);
 	atiixp_update(chip, CMD, ATI_REG_CMD_AC_SOFT_RESET, 0);
-    
+
 	timeout = 10;
-	while (! (atiixp_read(chip, CMD) & ATI_REG_CMD_ACLINK_ACTIVE)) {
+	while (!(atiixp_read(chip, CMD) & ATI_REG_CMD_ACLINK_ACTIVE)) {
 		/* do a hard reset */
 		atiixp_update(chip, CMD, ATI_REG_CMD_AC_SYNC|ATI_REG_CMD_AC_RESET,
 			      ATI_REG_CMD_AC_SYNC);
@@ -537,8 +537,8 @@ static int snd_atiixp_aclink_reset(struct atiixp *chip)
 #ifdef CONFIG_PM
 static int snd_atiixp_aclink_down(struct atiixp *chip)
 {
-	// if (atiixp_read(chip, MODEM_MIRROR) & 0x1) /* modem running, too? */
-	//	return -EBUSY;
+	/* if (atiixp_read(chip, MODEM_MIRROR) & 0x1) modem running, too? */
+	/*	return -EBUSY; */
 	atiixp_update(chip, CMD,
 		     ATI_REG_CMD_POWERDOWN | ATI_REG_CMD_AC_RESET,
 		     ATI_REG_CMD_POWERDOWN);
@@ -582,7 +582,7 @@ static int __devinit snd_atiixp_codec_detect(struct atiixp *chip)
 	if (ac97_codec == -1)
 		ac97_codec = ac97_probing_bugs(chip->pci);
 	if (ac97_codec >= 0) {
-		chip->codec_not_ready_bits |= 
+		chip->codec_not_ready_bits |=
 			CODEC_CHECK_BITS ^ (1 << (ac97_codec + 10));
 		return 0;
 	}
@@ -684,7 +684,7 @@ static snd_pcm_uframes_t snd_atiixp_pcm_pointer(struct snd_pcm_substream *substr
  */
 static void snd_atiixp_xrun_dma(struct atiixp *chip, struct atiixp_dma *dma)
 {
-	if (! dma->substream || ! dma->running)
+	if (!dma->substream || !dma->running)
 		return;
 	snd_printdd("atiixp: XRUN detected (DMA %d)\n", dma->ops->type);
 	snd_pcm_stop(dma->substream, SNDRV_PCM_STATE_XRUN);
@@ -695,7 +695,7 @@ static void snd_atiixp_xrun_dma(struct atiixp *chip, struct atiixp_dma *dma)
  */
 static void snd_atiixp_update_dma(struct atiixp *chip, struct atiixp_dma *dma)
 {
-	if (! dma->substream || ! dma->running)
+	if (!dma->substream || !dma->running)
 		return;
 	snd_pcm_period_elapsed(dma->substream);
 }
@@ -747,7 +747,7 @@ static int snd_atiixp_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		err = -EINVAL;
 		break;
 	}
-	if (! err) {
+	if (!err) {
 		snd_atiixp_check_bus_busy(chip);
 		if (cmd == SNDRV_PCM_TRIGGER_STOP) {
 			dma->ops->flush_dma(chip);
@@ -805,7 +805,7 @@ static void atiixp_in_enable_transfer(struct atiixp *chip, int on)
 {
 	if (on) {
 		unsigned int data = atiixp_read(chip, CMD);
-		if (! (data & ATI_REG_CMD_RECEIVE_EN)) {
+		if (!(data & ATI_REG_CMD_RECEIVE_EN)) {
 			data |= ATI_REG_CMD_RECEIVE_EN;
 #if 0 /* FIXME: this causes the endless loop */
 			/* wait until slot 3/4 are finished */
@@ -852,10 +852,10 @@ static void atiixp_spdif_flush_dma(struct atiixp *chip)
 	/* DMA off, transfer on */
 	atiixp_spdif_enable_dma(chip, 0);
 	atiixp_spdif_enable_transfer(chip, 1);
-	
+
 	timeout = 100;
 	do {
-		if (! (atiixp_read(chip, SPDF_DMA_DT_SIZE) & ATI_REG_DMA_FIFO_USED))
+		if (!(atiixp_read(chip, SPDF_DMA_DT_SIZE) & ATI_REG_DMA_FIFO_USED))
 			break;
 		udelay(1);
 	} while (timeout-- > 0);
@@ -930,7 +930,7 @@ static int snd_atiixp_playback_prepare(struct snd_pcm_substream *substream)
 	 */
 	atiixp_update(chip, 6CH_REORDER, ATI_REG_6CH_REORDER_EN,
 		      substream->runtime->channels >= 6 ? ATI_REG_6CH_REORDER_EN: 0);
-    
+
 	spin_unlock_irq(&chip->reg_lock);
 	return 0;
 }
@@ -1226,7 +1226,7 @@ static struct atiixp_dma_ops snd_atiixp_playback_dma_ops = {
 	.enable_transfer = atiixp_out_enable_transfer,
 	.flush_dma = atiixp_out_flush_dma,
 };
-	
+
 static struct atiixp_dma_ops snd_atiixp_capture_dma_ops = {
 	.type = ATI_DMA_CAPTURE,
 	.llp_offset = ATI_REG_IN_DMA_LINKPTR,
@@ -1235,7 +1235,7 @@ static struct atiixp_dma_ops snd_atiixp_capture_dma_ops = {
 	.enable_transfer = atiixp_in_enable_transfer,
 	.flush_dma = atiixp_in_flush_dma,
 };
-	
+
 static struct atiixp_dma_ops snd_atiixp_spdif_dma_ops = {
 	.type = ATI_DMA_SPDIF,
 	.llp_offset = ATI_REG_SPDF_DMA_LINKPTR,
@@ -1244,7 +1244,7 @@ static struct atiixp_dma_ops snd_atiixp_spdif_dma_ops = {
 	.enable_transfer = atiixp_spdif_enable_transfer,
 	.flush_dma = atiixp_spdif_flush_dma,
 };
-	
+
 
 static int __devinit snd_atiixp_pcm_new(struct atiixp *chip)
 {
@@ -1255,7 +1255,7 @@ static int __devinit snd_atiixp_pcm_new(struct atiixp *chip)
 	/* initialize constants */
 	chip->dmas[ATI_DMA_PLAYBACK].ops = &snd_atiixp_playback_dma_ops;
 	chip->dmas[ATI_DMA_CAPTURE].ops = &snd_atiixp_capture_dma_ops;
-	if (! chip->spdif_over_aclink)
+	if (!chip->spdif_over_aclink)
 		chip->dmas[ATI_DMA_SPDIF].ops = &snd_atiixp_spdif_dma_ops;
 
 	/* assign AC97 pcm */
@@ -1293,9 +1293,9 @@ static int __devinit snd_atiixp_pcm_new(struct atiixp *chip)
 					      64*1024, 128*1024);
 
 	/* no SPDIF support on codec? */
-	if (chip->pcms[ATI_PCM_SPDIF] && ! chip->pcms[ATI_PCM_SPDIF]->rates)
+	if (chip->pcms[ATI_PCM_SPDIF] && !chip->pcms[ATI_PCM_SPDIF]->rates)
 		return 0;
-		
+
 	/* FIXME: non-48k sample rate doesn't work on my test machine with AD1888 */
 	if (chip->pcms[ATI_PCM_SPDIF])
 		chip->pcms[ATI_PCM_SPDIF]->rates = SNDRV_PCM_RATE_48000;
@@ -1340,7 +1340,7 @@ static irqreturn_t snd_atiixp_interrupt(int irq, void *dev_id)
 
 	status = atiixp_read(chip, ISR);
 
-	if (! status)
+	if (!status)
 		return IRQ_NONE;
 
 	/* process audio DMA */
@@ -1352,7 +1352,7 @@ static irqreturn_t snd_atiixp_interrupt(int irq, void *dev_id)
 		snd_atiixp_xrun_dma(chip,  &chip->dmas[ATI_DMA_CAPTURE]);
 	else if (status & ATI_REG_ISR_IN_STATUS)
 		snd_atiixp_update_dma(chip, &chip->dmas[ATI_DMA_CAPTURE]);
-	if (! chip->spdif_over_aclink) {
+	if (!chip->spdif_over_aclink) {
 		if (status & ATI_REG_ISR_SPDF_XRUN)
 			snd_atiixp_xrun_dma(chip,  &chip->dmas[ATI_DMA_SPDIF]);
 		else if (status & ATI_REG_ISR_SPDF_STATUS)
@@ -1430,7 +1430,7 @@ static int __devinit snd_atiixp_mixer_new(struct atiixp *chip, int clock,
 		ac97.pci = chip->pci;
 		ac97.num = i;
 		ac97.scaps = AC97_SCAP_SKIP_MODEM | AC97_SCAP_POWER_SAVE;
-		if (! chip->spdif_over_aclink)
+		if (!chip->spdif_over_aclink)
 			ac97.scaps |= AC97_SCAP_NO_SPDIF;
 		if ((err = snd_ac97_mixer(pbus, &ac97, &chip->ac97[i])) < 0) {
 			chip->ac97[i] = NULL; /* to be sure */
@@ -1440,7 +1440,7 @@ static int __devinit snd_atiixp_mixer_new(struct atiixp *chip, int clock,
 		codec_count++;
 	}
 
-	if (! codec_count) {
+	if (!codec_count) {
 		snd_printk(KERN_ERR "atiixp: no codec available\n");
 		return -ENODEV;
 	}
@@ -1541,7 +1541,7 @@ static void __devinit snd_atiixp_proc_init(struct atiixp *chip)
 {
 	struct snd_info_entry *entry;
 
-	if (! snd_card_proc_new(chip->card, "atiixp", &entry))
+	if (!snd_card_proc_new(chip->card, "atiixp", &entry))
 		snd_info_set_text_ops(entry, chip, snd_atiixp_proc_read);
 }
 #else /* !CONFIG_PROC_FS */
@@ -1559,7 +1559,7 @@ static int snd_atiixp_free(struct atiixp *chip)
 		goto __hw_end;
 	snd_atiixp_chip_stop(chip);
 
-      __hw_end:
+__hw_end:
 	if (chip->irq >= 0)
 		free_irq(chip->irq, chip);
 	if (chip->remap_addr)
@@ -1665,7 +1665,7 @@ static int __devinit snd_atiixp_probe(struct pci_dev *pci,
 
 	if ((err = snd_atiixp_pcm_new(chip)) < 0)
 		goto __error;
-	
+
 	snd_atiixp_proc_init(chip);
 
 	snd_atiixp_chip_start(chip);
@@ -1682,7 +1682,7 @@ static int __devinit snd_atiixp_probe(struct pci_dev *pci,
 	pci_set_drvdata(pci, card);
 	return 0;
 
- __error:
+__error:
 	snd_card_free(card);
 	return err;
 }
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index 2f10630..b198f4c 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -19,7 +19,7 @@
  *
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -240,7 +240,7 @@ struct atiixp_modem {
 	unsigned long addr;
 	void __iomem *remap_addr;
 	int irq;
-	
+
 	struct snd_ac97_bus *ac97_bus;
 	struct snd_ac97 *ac97[NUM_ATI_CODECS];
 
@@ -319,7 +319,7 @@ static int snd_atiixp_update_bits(struct atiixp_modem *chip, unsigned int reg,
  * list.  although we can change the list dynamically, in this version,
  * a static RING of buffer descriptors is used.
  *
- * the ring is built in this function, and is set up to the hardware. 
+ * the ring is built in this function, and is set up to the hardware.
  */
 static int atiixp_build_dma_packets(struct atiixp_modem *chip,
 				    struct atiixp_dma *dma,
@@ -399,7 +399,7 @@ static int snd_atiixp_acquire_codec(struct atiixp_modem *chip)
 	int timeout = 1000;
 
 	while (atiixp_read(chip, PHYS_OUT_ADDR) & ATI_REG_PHYS_OUT_ADDR_EN) {
-		if (! timeout--) {
+		if (!timeout--) {
 			snd_printk(KERN_WARNING "atiixp-modem: codec acquire timeout\n");
 			return -EBUSY;
 		}
@@ -443,7 +443,7 @@ static void snd_atiixp_codec_write(struct atiixp_modem *chip,
 				   unsigned short reg, unsigned short val)
 {
 	unsigned int data;
-    
+
 	if (snd_atiixp_acquire_codec(chip) < 0)
 		return;
 	data = ((unsigned int)val << ATI_REG_PHYS_OUT_DATA_SHIFT) |
@@ -458,7 +458,7 @@ static unsigned short snd_atiixp_ac97_read(struct snd_ac97 *ac97,
 {
 	struct atiixp_modem *chip = ac97->private_data;
 	return snd_atiixp_codec_read(chip, ac97->num, reg);
-    
+
 }
 
 static void snd_atiixp_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
@@ -489,9 +489,9 @@ static int snd_atiixp_aclink_reset(struct atiixp_modem *chip)
 	atiixp_read(chip, CMD);
 	udelay(10);
 	atiixp_update(chip, CMD, ATI_REG_CMD_AC_SOFT_RESET, 0);
-    
+
 	timeout = 10;
-	while (! (atiixp_read(chip, CMD) & ATI_REG_CMD_ACLINK_ACTIVE)) {
+	while (!(atiixp_read(chip, CMD) & ATI_REG_CMD_ACLINK_ACTIVE)) {
 		/* do a hard reset */
 		atiixp_update(chip, CMD, ATI_REG_CMD_AC_SYNC|ATI_REG_CMD_AC_RESET,
 			      ATI_REG_CMD_AC_SYNC);
@@ -514,8 +514,8 @@ static int snd_atiixp_aclink_reset(struct atiixp_modem *chip)
 #ifdef CONFIG_PM
 static int snd_atiixp_aclink_down(struct atiixp_modem *chip)
 {
-	// if (atiixp_read(chip, MODEM_MIRROR) & 0x1) /* modem running, too? */
-	//	return -EBUSY;
+	/* if (atiixp_read(chip, MODEM_MIRROR) & 0x1) modem running, too? */
+	/*	return -EBUSY; */
 	atiixp_update(chip, CMD,
 		     ATI_REG_CMD_POWERDOWN | ATI_REG_CMD_AC_RESET,
 		     ATI_REG_CMD_POWERDOWN);
@@ -570,7 +570,7 @@ static int snd_atiixp_chip_start(struct atiixp_modem *chip)
 	/* set up spdif, enable burst mode */
 	reg = atiixp_read(chip, CMD);
 	reg |= ATI_REG_CMD_BURST_EN;
-	if(!(reg & ATI_REG_CMD_MODEM_PRESENT))
+	if (!(reg & ATI_REG_CMD_MODEM_PRESENT))
 		reg |= ATI_REG_CMD_MODEM_PRESENT;
 	atiixp_write(chip, CMD, reg);
 
@@ -635,7 +635,7 @@ static snd_pcm_uframes_t snd_atiixp_pcm_pointer(struct snd_pcm_substream *substr
 static void snd_atiixp_xrun_dma(struct atiixp_modem *chip,
 				struct atiixp_dma *dma)
 {
-	if (! dma->substream || ! dma->running)
+	if (!dma->substream || !dma->running)
 		return;
 	snd_printdd("atiixp-modem: XRUN detected (DMA %d)\n", dma->ops->type);
 	snd_pcm_stop(dma->substream, SNDRV_PCM_STATE_XRUN);
@@ -647,7 +647,7 @@ static void snd_atiixp_xrun_dma(struct atiixp_modem *chip,
 static void snd_atiixp_update_dma(struct atiixp_modem *chip,
 				  struct atiixp_dma *dma)
 {
-	if (! dma->substream || ! dma->running)
+	if (!dma->substream || !dma->running)
 		return;
 	snd_pcm_period_elapsed(dma->substream);
 }
@@ -692,7 +692,7 @@ static int snd_atiixp_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		err = -EINVAL;
 		break;
 	}
-	if (! err) {
+	if (!err) {
 	snd_atiixp_check_bus_busy(chip);
 	if (cmd == SNDRV_PCM_TRIGGER_STOP) {
 		dma->ops->flush_dma(chip);
@@ -750,7 +750,7 @@ static void atiixp_in_enable_transfer(struct atiixp_modem *chip, int on)
 {
 	if (on) {
 		unsigned int data = atiixp_read(chip, CMD);
-		if (! (data & ATI_REG_CMD_MODEM_RECEIVE_EN)) {
+		if (!(data & ATI_REG_CMD_MODEM_RECEIVE_EN)) {
 			data |= ATI_REG_CMD_MODEM_RECEIVE_EN;
 			atiixp_write(chip, CMD, data);
 		}
@@ -811,7 +811,7 @@ static int snd_atiixp_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	/* set up modem rate */
 	for (i = 0; i < NUM_ATI_CODECS; i++) {
-		if (! chip->ac97[i])
+		if (!chip->ac97[i])
 			continue;
 		snd_ac97_write(chip->ac97[i], AC97_LINE1_RATE, params_rate(hw_params));
 		snd_ac97_write(chip->ac97[i], AC97_LINE1_LEVEL, 0);
@@ -978,7 +978,7 @@ static struct atiixp_dma_ops snd_atiixp_playback_dma_ops = {
 	.enable_transfer = atiixp_out_enable_transfer,
 	.flush_dma = atiixp_out_flush_dma,
 };
-	
+
 static struct atiixp_dma_ops snd_atiixp_capture_dma_ops = {
 	.type = ATI_DMA_CAPTURE,
 	.llp_offset = ATI_REG_MODEM_IN_DMA_LINKPTR,
@@ -1027,7 +1027,7 @@ static irqreturn_t snd_atiixp_interrupt(int irq, void *dev_id)
 
 	status = atiixp_read(chip, ISR);
 
-	if (! status)
+	if (!status)
 		return IRQ_NONE;
 
 	/* process audio DMA */
@@ -1102,7 +1102,7 @@ static int __devinit snd_atiixp_mixer_new(struct atiixp_modem *chip, int clock)
 		codec_count++;
 	}
 
-	if (! codec_count) {
+	if (!codec_count) {
 		snd_printk(KERN_ERR "atiixp-modem: no codec available\n");
 		return -ENODEV;
 	}
@@ -1184,7 +1184,7 @@ static void __devinit snd_atiixp_proc_init(struct atiixp_modem *chip)
 {
 	struct snd_info_entry *entry;
 
-	if (! snd_card_proc_new(chip->card, "atiixp-modem", &entry))
+	if (!snd_card_proc_new(chip->card, "atiixp-modem", &entry))
 		snd_info_set_text_ops(entry, chip, snd_atiixp_proc_read);
 }
 #else
@@ -1202,7 +1202,7 @@ static int snd_atiixp_free(struct atiixp_modem *chip)
 		goto __hw_end;
 	snd_atiixp_chip_stop(chip);
 
-      __hw_end:
+__hw_end:
 	if (chip->irq >= 0)
 		free_irq(chip->irq, chip);
 	if (chip->remap_addr)
@@ -1306,7 +1306,7 @@ static int __devinit snd_atiixp_probe(struct pci_dev *pci,
 
 	if ((err = snd_atiixp_pcm_new(chip)) < 0)
 		goto __error;
-	
+
 	snd_atiixp_proc_init(chip);
 
 	snd_atiixp_chip_start(chip);
@@ -1320,7 +1320,7 @@ static int __devinit snd_atiixp_probe(struct pci_dev *pci,
 	pci_set_drvdata(pci, card);
 	return 0;
 
- __error:
+__error:
 	snd_card_free(card);
 	return err;
 }
diff --git a/sound/pci/aw2/aw2-alsa.c b/sound/pci/aw2/aw2-alsa.c
index 3f00ddf..efb0802 100644
--- a/sound/pci/aw2/aw2-alsa.c
+++ b/sound/pci/aw2/aw2-alsa.c
@@ -26,7 +26,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
diff --git a/sound/pci/aw2/aw2-saa7146.c b/sound/pci/aw2/aw2-saa7146.c
index 6a3891a..3be6ac2 100644
--- a/sound/pci/aw2/aw2-saa7146.c
+++ b/sound/pci/aw2/aw2-saa7146.c
@@ -29,7 +29,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <asm/system.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index 333007c..72cca10 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -159,7 +159,7 @@
  *  - use MMIO (memory-mapped I/O)? Slightly faster access, e.g. for gameport.
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
@@ -1360,7 +1360,7 @@ snd_azf3328_playback_pointer(struct snd_pcm_substream *substream)
 
 	/* calculate offset */
 	result -= bufptr;
-	frmres = bytes_to_frames( substream->runtime, result);
+	frmres = bytes_to_frames(substream->runtime, result);
 	snd_azf3328_dbgplay("PLAY @ 0x%8lx, frames %8ld\n", result, frmres);
 	return frmres;
 }
@@ -1381,7 +1381,7 @@ snd_azf3328_capture_pointer(struct snd_pcm_substream *substream)
 
 	/* calculate offset */
 	result -= bufptr;
-	frmres = bytes_to_frames( substream->runtime, result);
+	frmres = bytes_to_frames(substream->runtime, result);
 	snd_azf3328_dbgplay("REC  @ 0x%8lx, frames %8ld\n", result, frmres);
 	return frmres;
 }
@@ -2063,14 +2063,14 @@ snd_azf3328_debug_show_ports(const struct snd_azf3328 *chip)
 		snd_azf3328_game_inb(chip, 5)
 	);
 
-	for (tmp = 0; tmp < 0x07; tmp += 1)
+	for (tmp = 0; tmp < 0x07; tmp++)
 		snd_azf3328_dbgmisc("mpu_io 0x%04x\n", inb(chip->mpu_io + tmp));
 
-	for (tmp = 0; tmp <= 0x07; tmp += 1)
+	for (tmp = 0; tmp <= 0x07; tmp++)
 		snd_azf3328_dbgmisc("0x%02x: game200 0x%04x, game208 0x%04x\n",
 			tmp, inb(0x200 + tmp), inb(0x208 + tmp));
 
-	for (tmp = 0; tmp <= 0x01; tmp += 1)
+	for (tmp = 0; tmp <= 0x01; tmp++)
 		snd_azf3328_dbgmisc(
 			"0x%02x: mpu300 0x%04x, mpu310 0x%04x, mpu320 0x%04x, "
 			"mpu330 0x%04x opl388 0x%04x opl38c 0x%04x\n",
diff --git a/sound/pci/azt3328.h b/sound/pci/azt3328.h
index 974e051..3038efb 100644
--- a/sound/pci/azt3328.h
+++ b/sound/pci/azt3328.h
@@ -119,7 +119,7 @@ enum azf_freq_t {
 /* general */
 #define IDX_IO_42H		0x42 /* PU:0x0001 */
 
-/** DirectX timer, main interrupt area (FIXME: and something else?) **/ 
+/** DirectX timer, main interrupt area (FIXME: and something else?) **/
 #define IDX_IO_TIMER_VALUE	0x60 /* found this timer area by pure luck :-) */
   /* timer countdown value; triggers IRQ when timer is finished */
   #define TIMER_VALUE_MASK		0x000fffffUL
@@ -204,7 +204,7 @@ enum azf_freq_t {
 
 
 /*** Gameport area port indices ***/
-/* (only 0x06 of 0x08 bytes saved/restored by Windows driver) */ 
+/* (only 0x06 of 0x08 bytes saved/restored by Windows driver) */
 #define AZF_IO_SIZE_GAME		0x08
 #define AZF_IO_SIZE_GAME_PM	0x06
 
@@ -333,7 +333,7 @@ enum {
   #define MIXER_ADVCTL2_MIX		0x0200 /* Mono output select 0=Mix, 1=Mic; Win driver: "MonoSelectSource"?? */
   #define MIXER_ADVCTL2_3D		0x2000 /* 3D Enhancement 1=on */
   #define MIXER_ADVCTL2_POP		0x8000 /* Pcm Out Path, 0=pre 3D, 1=post 3D */
-  
+
 #define IDX_MIXER_SOMETHING30H	0x30 /* used, but unknown??? */
 
 /* driver internal flags */
