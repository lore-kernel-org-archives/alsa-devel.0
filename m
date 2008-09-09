From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 05/24] sound/pci: coding style fixes: cs46xx
Date: Tue, 9 Sep 2008 05:48:34 +0400
Message-ID: <20080909014834.GI6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by alsa0.perex.cz (Postfix) with ESMTP id AED29103807
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 03:48:45 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1534843fgg.44
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 18:48:45 -0700 (PDT)
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

 sound/pci/cs46xx/cs46xx.c           |    2 +-
 sound/pci/cs46xx/cs46xx_lib.c       |  316 ++++++++++----------
 sound/pci/cs46xx/dsp_spos.c         |  428 ++++++++++++++--------------
 sound/pci/cs46xx/dsp_spos.h         |    8 +-
 sound/pci/cs46xx/dsp_spos_scb_lib.c |  546 +++++++++++++++++-----------------
 sound/pci/cs46xx/imgs/cwcbinhack.h  |    2 +-
 6 files changed, 651 insertions(+), 651 deletions(-)

diff --git a/sound/pci/cs46xx/cs46xx.c b/sound/pci/cs46xx/cs46xx.c
index e876b32..d766d85 100644
--- a/sound/pci/cs46xx/cs46xx.c
+++ b/sound/pci/cs46xx/cs46xx.c
@@ -21,7 +21,7 @@
 
 /*
   NOTES:
-  - sometimes the sound is metallic and sibilant, unloading and 
+  - sometimes the sound is metallic and sibilant, unloading and
     reloading the module may solve this.
 */
 
diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index a10ab82..d8ab1ad 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -7,7 +7,7 @@
  *  KNOWN BUGS:
  *    - Sometimes the SPDIF input DSP tasks get's unsynchronized
  *      and the SPDIF get somewhat "distorcionated", or/and left right channel
- *      are swapped. To get around this problem when it happens, mute and unmute 
+ *      are swapped. To get around this problem when it happens, mute and unmute
  *      the SPDIF input mixer control.
  *    - On the Hercules Game Theater XP the amplifier are sometimes turned
  *      off on inadecuate moments which causes distorcions on sound.
@@ -22,13 +22,13 @@
  *        is default configuration), no SPDIF, no secondary codec, no
  *        multi channel PCM.  But known to work.
  *
- *  FINALLY: A credit to the developers Tom and Jordan 
+ *  FINALLY: A credit to the developers Tom and Jordan
  *           at Cirrus for have helping me out with the DSP, however we
  *           still don't have sufficient documentation and technical
  *           references to be able to implement all fancy feutures
- *           supported by the cs46xx DSP's. 
+ *           supported by the cs46xx DSP's.
  *           Benny <benny@hostmobility.com>
- *                
+ *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
  *   the Free Software Foundation; either version 2 of the License, or
@@ -62,7 +62,7 @@
 #include <sound/pcm_params.h>
 #include <sound/cs46xx.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include "cs46xx_lib.h"
 #include "dsp_spos.h"
@@ -102,7 +102,7 @@ static unsigned short snd_cs46xx_codec_read(struct snd_cs46xx *chip,
 
 	/*
 	 *  1. Write ACCAD = Command Address Register = 46Ch for AC97 register address
-	 *  2. Write ACCDA = Command Data Register = 470h    for data to write to AC97 
+	 *  2. Write ACCDA = Command Data Register = 470h    for data to write to AC97
 	 *  3. Write ACCTL = Control Register = 460h for initiating the write7---55
 	 *  4. Read ACCTL = 460h, DCV should be reset by now and 460h = 17h
 	 *  5. if DCV not cleared, break and return error
@@ -114,10 +114,10 @@ static unsigned short snd_cs46xx_codec_read(struct snd_cs46xx *chip,
 	tmp = snd_cs46xx_peekBA0(chip, BA0_ACCTL);
 	if ((tmp & ACCTL_VFRM) == 0) {
 		snd_printk(KERN_WARNING  "cs46xx: ACCTL_VFRM not set 0x%x\n",tmp);
-		snd_cs46xx_pokeBA0(chip, BA0_ACCTL, (tmp & (~ACCTL_ESYN)) | ACCTL_VFRM );
+		snd_cs46xx_pokeBA0(chip, BA0_ACCTL, (tmp & (~ACCTL_ESYN)) | ACCTL_VFRM);
 		msleep(50);
 		tmp = snd_cs46xx_peekBA0(chip, BA0_ACCTL + offset);
-		snd_cs46xx_pokeBA0(chip, BA0_ACCTL, tmp | ACCTL_ESYN | ACCTL_VFRM );
+		snd_cs46xx_pokeBA0(chip, BA0_ACCTL, tmp | ACCTL_ESYN | ACCTL_VFRM);
 
 	}
 
@@ -137,7 +137,7 @@ static unsigned short snd_cs46xx_codec_read(struct snd_cs46xx *chip,
 	snd_cs46xx_pokeBA0(chip, BA0_ACCAD, reg);
 	snd_cs46xx_pokeBA0(chip, BA0_ACCDA, 0);
 	if (codec_index == CS46XX_PRIMARY_CODEC_INDEX) {
-		snd_cs46xx_pokeBA0(chip, BA0_ACCTL,/* clear ACCTL_DCV */ ACCTL_CRW | 
+		snd_cs46xx_pokeBA0(chip, BA0_ACCTL,/* clear ACCTL_DCV */ ACCTL_CRW |
 				   ACCTL_VFRM | ACCTL_ESYN |
 				   ACCTL_RSTN);
 		snd_cs46xx_pokeBA0(chip, BA0_ACCTL, ACCTL_DCV | ACCTL_CRW |
@@ -168,7 +168,7 @@ static unsigned short snd_cs46xx_codec_read(struct snd_cs46xx *chip,
 	snd_printk(KERN_ERR "AC'97 read problem (ACCTL_DCV), reg = 0x%x\n", reg);
 	result = 0xffff;
 	goto end;
-	
+
  ok1:
 	/*
 	 *  Wait for the valid status bit to go active.
@@ -183,7 +183,7 @@ static unsigned short snd_cs46xx_codec_read(struct snd_cs46xx *chip,
 			goto ok2;
 		udelay(10);
 	}
-	
+
 	snd_printk(KERN_ERR "AC'97 read problem (ACSTS_VSTS), codec_index %d, reg = 0x%x\n", codec_index, reg);
 	result = 0xffff;
 	goto end;
@@ -199,14 +199,14 @@ static unsigned short snd_cs46xx_codec_read(struct snd_cs46xx *chip,
 			snd_cs46xx_peekBA0(chip, BA0_ACCAD));
 #endif
 
-	//snd_cs46xx_peekBA0(chip, BA0_ACCAD);
+	/* snd_cs46xx_peekBA0(chip, BA0_ACCAD); */
 	result = snd_cs46xx_peekBA0(chip, BA0_ACSDA + offset);
  end:
 	chip->active_ctrl(chip, -1);
 	return result;
 }
 
-static unsigned short snd_cs46xx_ac97_read(struct snd_ac97 * ac97,
+static unsigned short snd_cs46xx_ac97_read(struct snd_ac97 *ac97,
 					    unsigned short reg)
 {
 	struct snd_cs46xx *chip = ac97->private_data;
@@ -339,7 +339,7 @@ int snd_cs46xx_download(struct snd_cs46xx *chip,
 
 int snd_cs46xx_clear_BA1(struct snd_cs46xx *chip,
                          unsigned long offset,
-                         unsigned long len) 
+                         unsigned long len)
 {
 	void __iomem *dst;
 	unsigned int bank = offset >> 16;
@@ -374,7 +374,7 @@ int snd_cs46xx_download_image(struct snd_cs46xx *chip)
 					       BA1Struct.memory[idx].size)) < 0)
 			return err;
 		offset += BA1Struct.memory[idx].size >> 2;
-	}	
+	}
 	return 0;
 }
 #endif /* CONFIG_SND_CS46XX_NEW_DSP */
@@ -412,23 +412,23 @@ static void snd_cs46xx_reset(struct snd_cs46xx *chip)
 	snd_cs46xx_poke(chip, BA1_FRMT, 0xadf);
 }
 
-static int cs46xx_wait_for_fifo(struct snd_cs46xx * chip,int retry_timeout) 
+static int cs46xx_wait_for_fifo(struct snd_cs46xx *chip, int retry_timeout)
 {
 	u32 i, status = 0;
 	/*
 	 * Make sure the previous FIFO write operation has completed.
 	 */
-	for(i = 0; i < 50; i++){
+	for (i = 0; i < 50; i++){
 		status = snd_cs46xx_peekBA0(chip, BA0_SERBST);
-    
-		if( !(status & SERBST_WBSY) )
+
+		if (!(status & SERBST_WBSY))
 			break;
 
 		mdelay(retry_timeout);
 	}
-  
-	if(status & SERBST_WBSY) {
-		snd_printk( KERN_ERR "cs46xx: failure waiting for FIFO command to complete\n");
+
+	if (status & SERBST_WBSY) {
+		snd_printk(KERN_ERR "cs46xx: failure waiting for FIFO command to complete\n");
 
 		return -EINVAL;
 	}
@@ -470,7 +470,7 @@ static void snd_cs46xx_clear_serial_FIFOs(struct snd_cs46xx *chip)
 
 			if (powerdown)
 				snd_cs46xx_pokeBA0(chip, BA0_CLKCR1, tmp);
-          
+
 			break;
 		}
 		/*
@@ -668,7 +668,7 @@ static void snd_cs46xx_set_capture_sample_rate(struct snd_cs46xx *chip, unsigned
 		frameGroupLength *= 3;
 	}
 	for (cnt = 5; cnt <= 125; cnt *= 5) {
-		if (((rate / cnt) * cnt) != rate) 
+		if (((rate / cnt) * cnt) != rate)
 			frameGroupLength *= 5;
         }
 
@@ -778,7 +778,7 @@ static int snd_cs46xx_playback_trigger(struct snd_pcm_substream *substream,
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	struct snd_cs46xx_pcm *cpcm = substream->runtime->private_data;
-	if (! cpcm->pcm_channel) {
+	if (!cpcm->pcm_channel) {
 		return -ENXIO;
 	}
 #endif
@@ -787,7 +787,7 @@ static int snd_cs46xx_playback_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_RESUME:
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 		/* magic value to unmute PCM stream  playback volume */
-		snd_cs46xx_poke(chip, (cpcm->pcm_channel->pcm_reader_scb->address + 
+		snd_cs46xx_poke(chip, (cpcm->pcm_channel->pcm_reader_scb->address +
 				       SCBVolumeCtrl) << 2, 0x80008000);
 
 		if (cpcm->pcm_channel->unlinked)
@@ -811,7 +811,7 @@ static int snd_cs46xx_playback_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 		/* magic mute channel */
-		snd_cs46xx_poke(chip, (cpcm->pcm_channel->pcm_reader_scb->address + 
+		snd_cs46xx_poke(chip, (cpcm->pcm_channel->pcm_reader_scb->address +
 				       SCBVolumeCtrl) << 2, 0xffffffff);
 
 		if (!cpcm->pcm_channel->unlinked)
@@ -865,13 +865,13 @@ static int snd_cs46xx_capture_trigger(struct snd_pcm_substream *substream,
 }
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
-static int _cs46xx_adjust_sample_rate (struct snd_cs46xx *chip, struct snd_cs46xx_pcm *cpcm,
-				       int sample_rate) 
+static int _cs46xx_adjust_sample_rate(struct snd_cs46xx *chip, struct snd_cs46xx_pcm *cpcm,
+				       int sample_rate)
 {
 
 	/* If PCMReaderSCB and SrcTaskSCB not created yet ... */
-	if ( cpcm->pcm_channel == NULL) {
-		cpcm->pcm_channel = cs46xx_dsp_create_pcm_channel (chip, sample_rate, 
+	if (cpcm->pcm_channel == NULL) {
+		cpcm->pcm_channel = cs46xx_dsp_create_pcm_channel(chip, sample_rate,
 								   cpcm, cpcm->hw_buf.addr,cpcm->pcm_channel_id);
 		if (cpcm->pcm_channel == NULL) {
 			snd_printk(KERN_ERR "cs46xx: failed to create virtual PCM channel\n");
@@ -882,9 +882,9 @@ static int _cs46xx_adjust_sample_rate (struct snd_cs46xx *chip, struct snd_cs46x
 	/* if sample rate is changed */
 	if ((int)cpcm->pcm_channel->sample_rate != sample_rate) {
 		int unlinked = cpcm->pcm_channel->unlinked;
-		cs46xx_dsp_destroy_pcm_channel (chip,cpcm->pcm_channel);
+		cs46xx_dsp_destroy_pcm_channel(chip,cpcm->pcm_channel);
 
-		if ( (cpcm->pcm_channel = cs46xx_dsp_create_pcm_channel (chip, sample_rate, cpcm, 
+		if ((cpcm->pcm_channel = cs46xx_dsp_create_pcm_channel(chip, sample_rate, cpcm,
 									 cpcm->hw_buf.addr,
 									 cpcm->pcm_channel_id)) == NULL) {
 			snd_printk(KERN_ERR "cs46xx: failed to re-create virtual PCM channel\n");
@@ -1017,7 +1017,7 @@ static int snd_cs46xx_playback_hw_free(struct snd_pcm_substream *substream)
 
 	if (runtime->dma_area != cpcm->hw_buf.area)
 		snd_pcm_lib_free_pages(substream);
-    
+
 	runtime->dma_area = NULL;
 	runtime->dma_addr = 0;
 	runtime->dma_bytes = 0;
@@ -1039,7 +1039,7 @@ static int snd_cs46xx_playback_prepare(struct snd_pcm_substream *substream)
 	if (snd_BUG_ON(!cpcm->pcm_channel))
 		return -ENXIO;
 
-	pfie = snd_cs46xx_peek(chip, (cpcm->pcm_channel->pcm_reader_scb->address + 1) << 2 );
+	pfie = snd_cs46xx_peek(chip, (cpcm->pcm_channel->pcm_reader_scb->address + 1) << 2);
 	pfie &= ~0x0000f03f;
 #else
 	/* old dsp */
@@ -1068,7 +1068,7 @@ static int snd_cs46xx_playback_prepare(struct snd_pcm_substream *substream)
 		if (snd_pcm_format_big_endian(runtime->format))
 			pfie |= 0x00004000;
 	}
-	
+
 	memset(&cpcm->pcm_rec, 0, sizeof(cpcm->pcm_rec));
 	cpcm->pcm_rec.sw_buffer_size = snd_pcm_lib_buffer_bytes(substream);
 	cpcm->pcm_rec.hw_buffer_size = runtime->period_size * CS46XX_FRAGS << cpcm->shift;
@@ -1161,7 +1161,7 @@ static irqreturn_t snd_cs46xx_interrupt(int irq, void *dev_id)
 	struct snd_cs46xx *chip = dev_id;
 	u32 status1;
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 	u32 status2;
 	int i;
 	struct snd_cs46xx_pcm *cpcm = NULL;
@@ -1181,7 +1181,7 @@ static irqreturn_t snd_cs46xx_interrupt(int irq, void *dev_id)
 
 	for (i = 0; i < DSP_MAX_PCM_CHANNELS; ++i) {
 		if (i <= 15) {
-			if ( status1 & (1 << i) ) {
+			if (status1 & (1 << i)) {
 				if (i == CS46XX_DSP_CAPTURE_CHANNEL) {
 					if (chip->capt.substream)
 						snd_pcm_period_elapsed(chip->capt.substream);
@@ -1195,8 +1195,8 @@ static irqreturn_t snd_cs46xx_interrupt(int irq, void *dev_id)
 				}
 			}
 		} else {
-			if ( status2 & (1 << (i - 16))) {
-				if (ins->pcm_channels[i].active && 
+			if (status2 & (1 << (i - 16))) {
+				if (ins->pcm_channels[i].active &&
 				    ins->pcm_channels[i].private_data &&
 				    !ins->pcm_channels[i].unlinked) {
 					cpcm = ins->pcm_channels[i].private_data;
@@ -1220,7 +1220,7 @@ static irqreturn_t snd_cs46xx_interrupt(int irq, void *dev_id)
 
 	if ((status1 & HISR_MIDI) && chip->rmidi) {
 		unsigned char c;
-		
+
 		spin_lock(&chip->reg_lock);
 		while ((snd_cs46xx_peekBA0(chip, BA0_MIDSR) & MIDSR_RBE) == 0) {
 			c = snd_cs46xx_peekBA0(chip, BA0_MIDRP);
@@ -1251,7 +1251,7 @@ static irqreturn_t snd_cs46xx_interrupt(int irq, void *dev_id)
 static struct snd_pcm_hardware snd_cs46xx_playback =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP |
-				 SNDRV_PCM_INFO_INTERLEAVED | 
+				 SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER /*|*/
 				 /*SNDRV_PCM_INFO_RESUME*/),
 	.formats =		(SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_U8 |
@@ -1307,7 +1307,7 @@ static void snd_cs46xx_pcm_free_substream(struct snd_pcm_runtime *runtime)
 	kfree(runtime->private_data);
 }
 
-static int _cs46xx_playback_open_channel (struct snd_pcm_substream *substream,int pcm_channel_id)
+static int _cs46xx_playback_open_channel(struct snd_pcm_substream *substream, int pcm_channel_id)
 {
 	struct snd_cs46xx *chip = snd_pcm_substream_chip(substream);
 	struct snd_cs46xx_pcm * cpcm;
@@ -1329,12 +1329,12 @@ static int _cs46xx_playback_open_channel (struct snd_pcm_substream *substream,in
 	cpcm->substream = substream;
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	mutex_lock(&chip->spos_mutex);
-	cpcm->pcm_channel = NULL; 
+	cpcm->pcm_channel = NULL;
 	cpcm->pcm_channel_id = pcm_channel_id;
 
 
 	snd_pcm_hw_constraint_list(runtime, 0,
-				   SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 
+				   SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
 				   &hw_constraints_period_sizes);
 
 	mutex_unlock(&chip->spos_mutex);
@@ -1389,7 +1389,7 @@ static int snd_cs46xx_playback_close_iec958(struct snd_pcm_substream *substream)
 {
 	int err;
 	struct snd_cs46xx *chip = snd_pcm_substream_chip(substream);
-  
+
 	snd_printdd("close raw iec958 channel\n");
 
 	err = snd_cs46xx_playback_close(substream);
@@ -1419,7 +1419,7 @@ static int snd_cs46xx_capture_open(struct snd_pcm_substream *substream)
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	snd_pcm_hw_constraint_list(substream->runtime, 0,
-				   SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 
+				   SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
 				   &hw_constraints_period_sizes);
 #endif
 	return 0;
@@ -1734,7 +1734,7 @@ static void snd_cs46xx_mixer_free_ac97(struct snd_ac97 *ac97)
 		chip->ac97[CS46XX_SECONDARY_CODEC_INDEX] = NULL;
 }
 
-static int snd_cs46xx_vol_info(struct snd_kcontrol *kcontrol, 
+static int snd_cs46xx_vol_info(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
@@ -1758,7 +1758,7 @@ static int snd_cs46xx_vol_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem
 {
 	struct snd_cs46xx *chip = snd_kcontrol_chip(kcontrol);
 	int reg = kcontrol->private_value;
-	unsigned int val = ((0xffff - ucontrol->value.integer.value[0]) << 16 | 
+	unsigned int val = ((0xffff - ucontrol->value.integer.value[0]) << 16 |
 			    (0xffff - ucontrol->value.integer.value[1]));
 	unsigned int old = snd_cs46xx_peek(chip, reg);
 	int change = (old != val);
@@ -1827,7 +1827,7 @@ static int snd_cs46xx_vol_iec958_put(struct snd_kcontrol *kcontrol, struct snd_c
 
 #define snd_mixer_boolean_info		snd_ctl_boolean_mono_info
 
-static int snd_cs46xx_iec958_get(struct snd_kcontrol *kcontrol, 
+static int snd_cs46xx_iec958_get(struct snd_kcontrol *kcontrol,
                                  struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_cs46xx *chip = snd_kcontrol_chip(kcontrol);
@@ -1841,7 +1841,7 @@ static int snd_cs46xx_iec958_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int snd_cs46xx_iec958_put(struct snd_kcontrol *kcontrol, 
+static int snd_cs46xx_iec958_put(struct snd_kcontrol *kcontrol,
                                   struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_cs46xx *chip = snd_kcontrol_chip(kcontrol);
@@ -1851,7 +1851,7 @@ static int snd_cs46xx_iec958_put(struct snd_kcontrol *kcontrol,
 	case CS46XX_MIXER_SPDIF_OUTPUT_ELEMENT:
 		mutex_lock(&chip->spos_mutex);
 		change = (chip->dsp_spos_instance->spdif_status_out & DSP_SPDIF_STATUS_OUTPUT_ENABLED);
-		if (ucontrol->value.integer.value[0] && !change) 
+		if (ucontrol->value.integer.value[0] && !change)
 			cs46xx_dsp_enable_spdif_out(chip);
 		else if (change && !ucontrol->value.integer.value[0])
 			cs46xx_dsp_disable_spdif_out(chip);
@@ -1867,7 +1867,7 @@ static int snd_cs46xx_iec958_put(struct snd_kcontrol *kcontrol,
 		}
 		else if (change && !ucontrol->value.integer.value[0])
 			cs46xx_dsp_disable_spdif_in(chip);
-		
+
 		res = (change != chip->dsp_spos_instance->spdif_status_in);
 		break;
 	default:
@@ -1878,25 +1878,25 @@ static int snd_cs46xx_iec958_put(struct snd_kcontrol *kcontrol,
 	return res;
 }
 
-static int snd_cs46xx_adc_capture_get(struct snd_kcontrol *kcontrol, 
+static int snd_cs46xx_adc_capture_get(struct snd_kcontrol *kcontrol,
                                       struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_cs46xx *chip = snd_kcontrol_chip(kcontrol);
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 
-	if (ins->adc_input != NULL) 
+	if (ins->adc_input != NULL)
 		ucontrol->value.integer.value[0] = 1;
-	else 
+	else
 		ucontrol->value.integer.value[0] = 0;
-	
+
 	return 0;
 }
 
-static int snd_cs46xx_adc_capture_put(struct snd_kcontrol *kcontrol, 
+static int snd_cs46xx_adc_capture_put(struct snd_kcontrol *kcontrol,
                                       struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_cs46xx *chip = snd_kcontrol_chip(kcontrol);
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 	int change = 0;
 
 	if (ucontrol->value.integer.value[0] && !ins->adc_input) {
@@ -1909,26 +1909,26 @@ static int snd_cs46xx_adc_capture_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static int snd_cs46xx_pcm_capture_get(struct snd_kcontrol *kcontrol, 
+static int snd_cs46xx_pcm_capture_get(struct snd_kcontrol *kcontrol,
                                       struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_cs46xx *chip = snd_kcontrol_chip(kcontrol);
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 
-	if (ins->pcm_input != NULL) 
+	if (ins->pcm_input != NULL)
 		ucontrol->value.integer.value[0] = 1;
-	else 
+	else
 		ucontrol->value.integer.value[0] = 0;
 
 	return 0;
 }
 
 
-static int snd_cs46xx_pcm_capture_put(struct snd_kcontrol *kcontrol, 
+static int snd_cs46xx_pcm_capture_put(struct snd_kcontrol *kcontrol,
                                       struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_cs46xx *chip = snd_kcontrol_chip(kcontrol);
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 	int change = 0;
 
 	if (ucontrol->value.integer.value[0] && !ins->pcm_input) {
@@ -1942,7 +1942,7 @@ static int snd_cs46xx_pcm_capture_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static int snd_herc_spdif_select_get(struct snd_kcontrol *kcontrol, 
+static int snd_herc_spdif_select_get(struct snd_kcontrol *kcontrol,
                                      struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_cs46xx *chip = snd_kcontrol_chip(kcontrol);
@@ -1959,8 +1959,8 @@ static int snd_herc_spdif_select_get(struct snd_kcontrol *kcontrol,
 
 /*
  *	Game Theatre XP card - EGPIO[0] is used to select SPDIF input optical or coaxial.
- */ 
-static int snd_herc_spdif_select_put(struct snd_kcontrol *kcontrol, 
+ */
+static int snd_herc_spdif_select_put(struct snd_kcontrol *kcontrol,
                                        struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_cs46xx *chip = snd_kcontrol_chip(kcontrol);
@@ -1969,9 +1969,9 @@ static int snd_herc_spdif_select_put(struct snd_kcontrol *kcontrol,
 
 	if (ucontrol->value.integer.value[0]) {
 		/* optical is default */
-		snd_cs46xx_pokeBA0(chip, BA0_EGPIODR, 
+		snd_cs46xx_pokeBA0(chip, BA0_EGPIODR,
 				   EGPIODR_GPOE0 | val1);  /* enable EGPIO0 output */
-		snd_cs46xx_pokeBA0(chip, BA0_EGPIOPTR, 
+		snd_cs46xx_pokeBA0(chip, BA0_EGPIOPTR,
 				   EGPIOPTR_GPPT0 | val2); /* open-drain on output */
 	} else {
 		/* coaxial */
@@ -1979,7 +1979,7 @@ static int snd_herc_spdif_select_put(struct snd_kcontrol *kcontrol,
 		snd_cs46xx_pokeBA0(chip, BA0_EGPIOPTR, val2 & ~EGPIOPTR_GPPT0); /* disable */
 	}
 
-	/* checking diff from the EGPIO direction register 
+	/* checking diff from the EGPIO direction register
 	   should be enough */
 	return (val1 != (int)snd_cs46xx_peekBA0(chip, BA0_EGPIODR));
 }
@@ -1996,7 +1996,7 @@ static int snd_cs46xx_spdif_default_get(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_cs46xx *chip = snd_kcontrol_chip(kcontrol);
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 
 	mutex_lock(&chip->spos_mutex);
 	ucontrol->value.iec958.status[0] = _wrap_all_bits((ins->spdif_csuv_default >> 24) & 0xff);
@@ -2012,7 +2012,7 @@ static int snd_cs46xx_spdif_default_put(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_cs46xx * chip = snd_kcontrol_chip(kcontrol);
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 	unsigned int val;
 	int change;
 
@@ -2027,7 +2027,7 @@ static int snd_cs46xx_spdif_default_put(struct snd_kcontrol *kcontrol,
 	change = (unsigned int)ins->spdif_csuv_default != val;
 	ins->spdif_csuv_default = val;
 
-	if ( !(ins->spdif_status_out & DSP_SPDIF_STATUS_PLAYBACK_OPEN) )
+	if (!(ins->spdif_status_out & DSP_SPDIF_STATUS_PLAYBACK_OPEN))
 		cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV,val);
 
 	mutex_unlock(&chip->spos_mutex);
@@ -2049,7 +2049,7 @@ static int snd_cs46xx_spdif_stream_get(struct snd_kcontrol *kcontrol,
                                          struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_cs46xx *chip = snd_kcontrol_chip(kcontrol);
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 
 	mutex_lock(&chip->spos_mutex);
 	ucontrol->value.iec958.status[0] = _wrap_all_bits((ins->spdif_csuv_stream >> 24) & 0xff);
@@ -2065,7 +2065,7 @@ static int snd_cs46xx_spdif_stream_put(struct snd_kcontrol *kcontrol,
                                         struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_cs46xx * chip = snd_kcontrol_chip(kcontrol);
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 	unsigned int val;
 	int change;
 
@@ -2080,7 +2080,7 @@ static int snd_cs46xx_spdif_stream_put(struct snd_kcontrol *kcontrol,
 	change = ins->spdif_csuv_stream != val;
 	ins->spdif_csuv_stream = val;
 
-	if ( ins->spdif_status_out & DSP_SPDIF_STATUS_PLAYBACK_OPEN )
+	if (ins->spdif_status_out & DSP_SPDIF_STATUS_PLAYBACK_OPEN)
 		cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV,val);
 
 	mutex_unlock(&chip->spos_mutex);
@@ -2187,7 +2187,7 @@ static struct snd_kcontrol_new snd_cs46xx_controls[] __devinitdata = {
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 /* set primary cs4294 codec into Extended Audio Mode */
-static int snd_cs46xx_front_dup_get(struct snd_kcontrol *kcontrol, 
+static int snd_cs46xx_front_dup_get(struct snd_kcontrol *kcontrol,
 				    struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_cs46xx *chip = snd_kcontrol_chip(kcontrol);
@@ -2197,7 +2197,7 @@ static int snd_cs46xx_front_dup_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int snd_cs46xx_front_dup_put(struct snd_kcontrol *kcontrol, 
+static int snd_cs46xx_front_dup_put(struct snd_kcontrol *kcontrol,
 				    struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_cs46xx *chip = snd_kcontrol_chip(kcontrol);
@@ -2228,13 +2228,13 @@ static struct snd_kcontrol_new snd_hercules_controls[] = {
 };
 
 
-static void snd_cs46xx_codec_reset (struct snd_ac97 * ac97)
+static void snd_cs46xx_codec_reset(struct snd_ac97 *ac97)
 {
 	unsigned long end_time;
 	int err;
 
 	/* reset to defaults */
-	snd_ac97_write(ac97, AC97_RESET, 0);	
+	snd_ac97_write(ac97, AC97_RESET, 0);
 
 	/* set the desired CODEC mode */
 	if (ac97->num == CS46XX_PRIMARY_CODEC_INDEX) {
@@ -2255,7 +2255,7 @@ static void snd_cs46xx_codec_reset (struct snd_ac97 * ac97)
 	end_time = jiffies + HZ;
 	do {
 		unsigned short ext_mid;
-    
+
 		/* use preliminary reads to settle the communication */
 		snd_ac97_read(ac97, AC97_RESET);
 		snd_ac97_read(ac97, AC97_VENDOR_ID1);
@@ -2273,7 +2273,7 @@ static void snd_cs46xx_codec_reset (struct snd_ac97 * ac97)
 		msleep(10);
 	} while (time_after_eq(end_time, jiffies));
 
-	snd_printk(KERN_ERR "CS46xx secondary codec doesn't respond!\n");  
+	snd_printk(KERN_ERR "CS46xx secondary codec doesn't respond!\n");
 }
 #endif
 
@@ -2338,7 +2338,7 @@ int __devinit snd_cs46xx_mixer(struct snd_cs46xx *chip, int spdif_device)
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	snd_printdd("snd_cs46xx: detecting seconadry codec\n");
 	/* try detect a secondary codec */
-	if (! cs46xx_detect_codec(chip, CS46XX_SECONDARY_CODEC_INDEX))
+	if (!cs46xx_detect_codec(chip, CS46XX_SECONDARY_CODEC_INDEX))
 		chip->nr_ac97_codecs = 2;
 #endif /* CONFIG_SND_CS46XX_NEW_DSP */
 
@@ -2357,7 +2357,7 @@ int __devinit snd_cs46xx_mixer(struct snd_cs46xx *chip, int spdif_device)
 	id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 	strcpy(id.name, "External Amplifier");
 	chip->eapd_switch = snd_ctl_find_id(chip->card, &id);
-    
+
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	if (chip->nr_ac97_codecs == 1) {
 		unsigned int id2 = chip->ac97[CS46XX_PRIMARY_CODEC_INDEX]->id & 0xffff;
@@ -2378,7 +2378,7 @@ int __devinit snd_cs46xx_mixer(struct snd_cs46xx *chip, int spdif_device)
 
  	/* turn on amplifier */
 	chip->amplifier_ctrl(chip, 1);
-    
+
 	return 0;
 }
 
@@ -2563,7 +2563,7 @@ static void snd_cs46xx_gameport_trigger(struct gameport *gameport)
 
 	if (snd_BUG_ON(!chip))
 		return;
-	snd_cs46xx_pokeBA0(chip, BA0_JSPT, 0xFF);  //outb(gameport->io, 0xFF);
+	snd_cs46xx_pokeBA0(chip, BA0_JSPT, 0xFF);  /* outb(gameport->io, 0xFF); */
 }
 
 static unsigned char snd_cs46xx_gameport_read(struct gameport *gameport)
@@ -2572,7 +2572,7 @@ static unsigned char snd_cs46xx_gameport_read(struct gameport *gameport)
 
 	if (snd_BUG_ON(!chip))
 		return 0;
-	return snd_cs46xx_peekBA0(chip, BA0_JSPT); //inb(gameport->io);
+	return snd_cs46xx_peekBA0(chip, BA0_JSPT); /* inb(gameport->io); */
 }
 
 static int snd_cs46xx_gameport_cooked_read(struct gameport *gameport, int *axes, int *buttons)
@@ -2586,16 +2586,16 @@ static int snd_cs46xx_gameport_cooked_read(struct gameport *gameport, int *axes,
 	js1 = snd_cs46xx_peekBA0(chip, BA0_JSC1);
 	js2 = snd_cs46xx_peekBA0(chip, BA0_JSC2);
 	jst = snd_cs46xx_peekBA0(chip, BA0_JSPT);
-	
-	*buttons = (~jst >> 4) & 0x0F; 
-	
+
+	*buttons = (~jst >> 4) & 0x0F;
+
 	axes[0] = ((js1 & JSC1_Y1V_MASK) >> JSC1_Y1V_SHIFT) & 0xFFFF;
 	axes[1] = ((js1 & JSC1_X1V_MASK) >> JSC1_X1V_SHIFT) & 0xFFFF;
 	axes[2] = ((js2 & JSC2_Y2V_MASK) >> JSC2_Y2V_SHIFT) & 0xFFFF;
 	axes[3] = ((js2 & JSC2_X2V_MASK) >> JSC2_X2V_SHIFT) & 0xFFFF;
 
-	for(jst=0;jst<4;++jst)
-		if(axes[jst]==0xFFFF) axes[jst] = -1;
+	for (jst=0; jst<4; ++jst)
+		if (axes[jst]==0xFFFF) axes[jst] = -1;
 	return 0;
 }
 
@@ -2632,7 +2632,7 @@ int __devinit snd_cs46xx_gameport(struct snd_cs46xx *chip)
 	gp->trigger = snd_cs46xx_gameport_trigger;
 	gp->cooked_read = snd_cs46xx_gameport_cooked_read;
 
-	snd_cs46xx_pokeBA0(chip, BA0_JSIO, 0xFF); // ?
+	snd_cs46xx_pokeBA0(chip, BA0_JSIO, 0xFF); /* ? */
 	snd_cs46xx_pokeBA0(chip, BA0_JSCTL, JSCTL_SP_MEDIUM_SLOW);
 
 	gameport_register_port(gp);
@@ -2663,7 +2663,7 @@ static long snd_cs46xx_io_read(struct snd_info_entry *entry, void *file_private_
 {
 	long size;
 	struct snd_cs46xx_region *region = entry->private_data;
-	
+
 	size = count;
 	if (pos + (size_t)size > region->size)
 		size = region->size - pos;
@@ -2682,10 +2682,10 @@ static int __devinit snd_cs46xx_proc_init(struct snd_card *card, struct snd_cs46
 {
 	struct snd_info_entry *entry;
 	int idx;
-	
+
 	for (idx = 0; idx < 5; idx++) {
 		struct snd_cs46xx_region *region = &chip->region.idx[idx];
-		if (! snd_card_proc_new(card, region->name, &entry)) {
+		if (!snd_card_proc_new(card, region->name, &entry)) {
 			entry->content = SNDRV_INFO_CONTENT_DATA;
 			entry->private_data = chip;
 			entry->c.ops = &snd_cs46xx_proc_io_ops;
@@ -2753,7 +2753,7 @@ static void snd_cs46xx_hw_stop(struct snd_cs46xx *chip)
 	snd_cs46xx_pokeBA0(chip, BA0_CLKCR1, 0);
 
 	/*
-	 *  Turn off the Processor by turning off the software clock enable flag in 
+	 *  Turn off the Processor by turning off the software clock enable flag in
 	 *  the clock control register.
 	 */
 	tmp = snd_cs46xx_peekBA0(chip, BA0_CLKCR1) & ~CLKCR1_SWCE;
@@ -2775,7 +2775,7 @@ static int snd_cs46xx_free(struct snd_cs46xx *chip)
 
 	if (chip->amplifier_ctrl)
 		chip->amplifier_ctrl(chip, -chip->amplifier); /* force to off */
-	
+
 	snd_cs46xx_proc_done(chip);
 
 	if (chip->region.idx[0].resource)
@@ -2800,7 +2800,7 @@ static int snd_cs46xx_free(struct snd_cs46xx *chip)
 		chip->dsp_spos_instance = NULL;
 	}
 #endif
-	
+
 #ifdef CONFIG_PM
 	kfree(chip->saved_regs);
 #endif
@@ -2823,7 +2823,7 @@ static int snd_cs46xx_chip_init(struct snd_cs46xx *chip)
 {
 	int timeout;
 
-	/* 
+	/*
 	 *  First, blast the clock control register to zero so that the PLL starts
          *  out in a known state, and blast the master serial port control register
          *  to zero so that the serial ports also start out in a known state.
@@ -2834,9 +2834,9 @@ static int snd_cs46xx_chip_init(struct snd_cs46xx *chip)
 	/*
 	 *  If we are in AC97 mode, then we must set the part to a host controlled
          *  AC-link.  Otherwise, we won't be able to bring up the link.
-         */        
+         */
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
-	snd_cs46xx_pokeBA0(chip, BA0_SERACC, SERACC_HSP | SERACC_CHIP_TYPE_2_0 | 
+	snd_cs46xx_pokeBA0(chip, BA0_SERACC, SERACC_HSP | SERACC_CHIP_TYPE_2_0 |
 			   SERACC_TWO_CODECS);	/* 2.00 dual codecs */
 	/* snd_cs46xx_pokeBA0(chip, BA0_SERACC, SERACC_HSP | SERACC_CHIP_TYPE_2_0); */ /* 2.00 codec */
 #else
@@ -2858,7 +2858,7 @@ static int snd_cs46xx_chip_init(struct snd_cs46xx *chip)
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	snd_cs46xx_pokeBA0(chip, BA0_ACCTL2, ACCTL_RSTN);
 #endif
-    
+
 	/*
 	 *  The first thing we do here is to enable sync generation.  As soon
 	 *  as we start receiving bit clock, we'll start producing the SYNC
@@ -2966,7 +2966,7 @@ static int snd_cs46xx_chip_init(struct snd_cs46xx *chip)
 		for (count = 0; count < 150; count++) {
 			/* First, we want to wait for a short time. */
 			udelay(25);
-        
+
 			if (snd_cs46xx_peekBA0(chip, BA0_ACSTS2) & ACSTS_CRDY)
 				break;
 		}
@@ -3009,7 +3009,7 @@ static int snd_cs46xx_chip_init(struct snd_cs46xx *chip)
 	return -EIO;
 #else
 	/* This may happen on a cold boot with a Terratec SiXPack 5.1.
-	   Reloading the driver may help, if there's other soundcards 
+	   Reloading the driver may help, if there's other soundcards
 	   with the same problem I would like to know. (Benny) */
 
 	snd_printk(KERN_ERR "ERROR: snd-cs46xx: never read ISV3 & ISV4 from AC'97\n");
@@ -3036,7 +3036,7 @@ static int snd_cs46xx_chip_init(struct snd_cs46xx *chip)
 	/* snd_cs46xx_pokeBA0(chip, BA0_AC97_POWERDOWN, 0x300); */
 
 	/*
-	 *  Turn off the Processor by turning off the software clock enable flag in 
+	 *  Turn off the Processor by turning off the software clock enable flag in
 	 *  the clock control register.
 	 */
 	/* tmp = snd_cs46xx_peekBA0(chip, BA0_CLKCR1) & ~CLKCR1_SWCE; */
@@ -3046,7 +3046,7 @@ static int snd_cs46xx_chip_init(struct snd_cs46xx *chip)
 }
 
 /*
- *  start and load DSP 
+ *  start and load DSP
  */
 
 static void cs46xx_enable_stream_irqs(struct snd_cs46xx *chip)
@@ -3054,7 +3054,7 @@ static void cs46xx_enable_stream_irqs(struct snd_cs46xx *chip)
 	unsigned int tmp;
 
 	snd_cs46xx_pokeBA0(chip, BA0_HICR, HICR_IEV | HICR_CHGM);
-        
+
 	tmp = snd_cs46xx_peek(chip, BA1_PFIE);
 	tmp &= ~0x0000f03f;
 	snd_cs46xx_poke(chip, BA1_PFIE, tmp);	/* playback interrupt enable */
@@ -3066,7 +3066,7 @@ static void cs46xx_enable_stream_irqs(struct snd_cs46xx *chip)
 }
 
 int __devinit snd_cs46xx_start_dsp(struct snd_cs46xx *chip)
-{	
+{
 	unsigned int tmp;
 	/*
 	 *  Reset the processor.
@@ -3140,9 +3140,9 @@ int __devinit snd_cs46xx_start_dsp(struct snd_cs46xx *chip)
 	snd_cs46xx_proc_start(chip);
 
 	cs46xx_enable_stream_irqs(chip);
-	
+
 #ifndef CONFIG_SND_CS46XX_NEW_DSP
-	/* set the attenuation to 0dB */ 
+	/* set the attenuation to 0dB */
 	snd_cs46xx_poke(chip, BA1_PVOL, 0x80008000);
 	snd_cs46xx_poke(chip, BA1_CVOL, 0x80008000);
 #endif
@@ -3154,15 +3154,15 @@ int __devinit snd_cs46xx_start_dsp(struct snd_cs46xx *chip)
 /*
  *	AMP control - null AMP
  */
- 
+
 static void amp_none(struct snd_cs46xx *chip, int change)
-{	
+{
 }
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 static int voyetra_setup_eapd_slot(struct snd_cs46xx *chip)
 {
-	
+
 	u32 idx, valid_slots,tmp,powerdown = 0;
 	u16 modem_power,pin_config,logic_type;
 
@@ -3183,39 +3183,39 @@ static int voyetra_setup_eapd_slot(struct snd_cs46xx *chip)
 	 * Clear PRA.  The Bonzo chip will be used for GPIO not for modem
 	 * stuff.
 	 */
-	if(chip->nr_ac97_codecs != 2) {
+	if (chip->nr_ac97_codecs != 2) {
 		snd_printk (KERN_ERR "cs46xx: cs46xx_setup_eapd_slot() - no secondary codec configured\n");
 		return -EINVAL;
 	}
 
-	modem_power = snd_cs46xx_codec_read (chip, 
+	modem_power = snd_cs46xx_codec_read (chip,
 					     AC97_EXTENDED_MSTATUS,
 					     CS46XX_SECONDARY_CODEC_INDEX);
 	modem_power &=0xFEFF;
 
-	snd_cs46xx_codec_write(chip, 
+	snd_cs46xx_codec_write(chip,
 			       AC97_EXTENDED_MSTATUS, modem_power,
 			       CS46XX_SECONDARY_CODEC_INDEX);
 
 	/*
 	 * Set GPIO pin's 7 and 8 so that they are configured for output.
 	 */
-	pin_config = snd_cs46xx_codec_read (chip, 
+	pin_config = snd_cs46xx_codec_read (chip,
 					    AC97_GPIO_CFG,
 					    CS46XX_SECONDARY_CODEC_INDEX);
 	pin_config &=0x27F;
 
-	snd_cs46xx_codec_write(chip, 
+	snd_cs46xx_codec_write(chip,
 			       AC97_GPIO_CFG, pin_config,
 			       CS46XX_SECONDARY_CODEC_INDEX);
-    
+
 	/*
 	 * Set GPIO pin's 7 and 8 so that they are compatible with CMOS logic.
 	 */
 
 	logic_type = snd_cs46xx_codec_read(chip, AC97_GPIO_POLARITY,
 					   CS46XX_SECONDARY_CODEC_INDEX);
-	logic_type &=0x27F; 
+	logic_type &=0x27F;
 
 	snd_cs46xx_codec_write (chip, AC97_GPIO_POLARITY, logic_type,
 				CS46XX_SECONDARY_CODEC_INDEX);
@@ -3224,16 +3224,16 @@ static int voyetra_setup_eapd_slot(struct snd_cs46xx *chip)
 	valid_slots |= 0x200;
 	snd_cs46xx_pokeBA0(chip, BA0_ACOSV, valid_slots);
 
-	if ( cs46xx_wait_for_fifo(chip,1) ) {
+	if (cs46xx_wait_for_fifo(chip,1)) {
 	  snd_printdd("FIFO is busy\n");
-	  
+
 	  return -EINVAL;
 	}
 
 	/*
-	 * Fill slots 12 with the correct value for the GPIO pins. 
+	 * Fill slots 12 with the correct value for the GPIO pins.
 	 */
-	for(idx = 0x90; idx <= 0x9F; idx++) {
+	for (idx = 0x90; idx <= 0x9F; idx++) {
 		/*
 		 * Initialize the fifo so that bits 7 and 8 are on.
 		 *
@@ -3245,17 +3245,17 @@ static int voyetra_setup_eapd_slot(struct snd_cs46xx *chip)
 		/*
 		 * Wait for command to complete
 		 */
-		if ( cs46xx_wait_for_fifo(chip,200) ) {
+		if (cs46xx_wait_for_fifo(chip,200)) {
 			snd_printdd("failed waiting for FIFO at addr (%02X)\n",idx);
 
 			return -EINVAL;
 		}
-            
+
 		/*
 		 * Write the serial port FIFO index.
 		 */
 		snd_cs46xx_pokeBA0(chip, BA0_SERBAD, idx);
-      
+
 		/*
 		 * Tell the serial port to load the new value into the FIFO location.
 		 */
@@ -3279,17 +3279,17 @@ static int voyetra_setup_eapd_slot(struct snd_cs46xx *chip)
 /*
  *	Crystal EAPD mode
  */
- 
+
 static void amp_voyetra(struct snd_cs46xx *chip, int change)
 {
-	/* Manage the EAPD bit on the Crystal 4297 
+	/* Manage the EAPD bit on the Crystal 4297
 	   and the Analog AD1885 */
-	   
+
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	int old = chip->amplifier;
 #endif
 	int oval, val;
-	
+
 	chip->amplifier += change;
 	oval = snd_cs46xx_codec_read(chip, AC97_POWERDOWN,
 				     CS46XX_PRIMARY_CODEC_INDEX);
@@ -3316,7 +3316,7 @@ static void amp_voyetra(struct snd_cs46xx *chip, int change)
 #endif
 }
 
-static void hercules_init(struct snd_cs46xx *chip) 
+static void hercules_init(struct snd_cs46xx *chip)
 {
 	/* default: AMP off, and SPDIF input optical */
 	snd_cs46xx_pokeBA0(chip, BA0_EGPIODR, EGPIODR_GPOE0);
@@ -3326,7 +3326,7 @@ static void hercules_init(struct snd_cs46xx *chip)
 
 /*
  *	Game Theatre XP card - EGPIO[2] is used to enable the external amp.
- */ 
+ */
 static void amp_hercules(struct snd_cs46xx *chip, int change)
 {
 	int old = chip->amplifier;
@@ -3337,9 +3337,9 @@ static void amp_hercules(struct snd_cs46xx *chip, int change)
 	if (chip->amplifier && !old) {
 		snd_printdd ("Hercules amplifier ON\n");
 
-		snd_cs46xx_pokeBA0(chip, BA0_EGPIODR, 
+		snd_cs46xx_pokeBA0(chip, BA0_EGPIODR,
 				   EGPIODR_GPOE2 | val1);     /* enable EGPIO2 output */
-		snd_cs46xx_pokeBA0(chip, BA0_EGPIOPTR, 
+		snd_cs46xx_pokeBA0(chip, BA0_EGPIOPTR,
 				   EGPIOPTR_GPPT2 | val2);   /* open-drain on output */
 	} else if (old && !chip->amplifier) {
 		snd_printdd ("Hercules amplifier OFF\n");
@@ -3348,7 +3348,7 @@ static void amp_hercules(struct snd_cs46xx *chip, int change)
 	}
 }
 
-static void voyetra_mixer_init (struct snd_cs46xx *chip)
+static void voyetra_mixer_init(struct snd_cs46xx *chip)
 {
 	snd_printdd ("initializing Voyetra mixer\n");
 
@@ -3357,7 +3357,7 @@ static void voyetra_mixer_init (struct snd_cs46xx *chip)
 	snd_cs46xx_pokeBA0(chip, BA0_EGPIOPTR, EGPIODR_GPOE0);
 }
 
-static void hercules_mixer_init (struct snd_cs46xx *chip)
+static void hercules_mixer_init(struct snd_cs46xx *chip)
 {
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	unsigned int idx;
@@ -3374,7 +3374,7 @@ static void hercules_mixer_init (struct snd_cs46xx *chip)
 	if (chip->in_suspend)
 		return;
 
-	for (idx = 0 ; idx < ARRAY_SIZE(snd_hercules_controls); idx++) {
+	for (idx = 0; idx < ARRAY_SIZE(snd_hercules_controls); idx++) {
 		struct snd_kcontrol *kctl;
 
 		kctl = snd_ctl_new1(&snd_hercules_controls[idx], chip);
@@ -3391,7 +3391,7 @@ static void hercules_mixer_init (struct snd_cs46xx *chip)
 /*
  *	Untested
  */
- 
+
 static void amp_voyetra_4294(struct snd_cs46xx *chip, int change)
 {
 	chip->amplifier += change;
@@ -3421,21 +3421,21 @@ static void amp_voyetra_4294(struct snd_cs46xx *chip, int change)
  *	Linuxcare. Perhaps one day Crystal will document their chips well
  *	enough to make them useful.
  */
- 
+
 static void clkrun_hack(struct snd_cs46xx *chip, int change)
 {
 	u16 control, nval;
-	
+
 	if (!chip->acpi_port)
 		return;
 
 	chip->amplifier += change;
-	
-	/* Read ACPI port */	
+
+	/* Read ACPI port */
 	nval = control = inw(chip->acpi_port + 0x10);
 
 	/* Flip CLKRUN off while running */
-	if (! chip->amplifier)
+	if (!chip->amplifier)
 		nval |= 0x2000;
 	else
 		nval &= ~0x2000;
@@ -3443,7 +3443,7 @@ static void clkrun_hack(struct snd_cs46xx *chip, int change)
 		outw(nval, chip->acpi_port + 0x10);
 }
 
-	
+
 /*
  * detect intel piix4
  */
@@ -3453,13 +3453,13 @@ static void clkrun_init(struct snd_cs46xx *chip)
 	u8 pp;
 
 	chip->acpi_port = 0;
-	
+
 	pdev = pci_get_device(PCI_VENDOR_ID_INTEL,
 		PCI_DEVICE_ID_INTEL_82371AB_3, NULL);
 	if (pdev == NULL)
 		return;		/* Not a thinkpad thats for sure */
 
-	/* Find the control port */		
+	/* Find the control port */
 	pci_read_config_byte(pdev, 0x41, &pp);
 	chip->acpi_port = pp << 8;
 	pci_dev_put(pdev);
@@ -3469,7 +3469,7 @@ static void clkrun_init(struct snd_cs46xx *chip)
 /*
  * Card subid table
  */
- 
+
 struct cs_card_type
 {
 	u16 vendor;
@@ -3595,8 +3595,8 @@ int snd_cs46xx_suspend(struct pci_dev *pci, pm_message_t state)
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 	chip->in_suspend = 1;
 	snd_pcm_suspend_all(chip->pcm);
-	// chip->ac97_powerdown = snd_cs46xx_codec_read(chip, AC97_POWER_CONTROL);
-	// chip->ac97_general_purpose = snd_cs46xx_codec_read(chip, BA0_AC97_GENERAL_PURPOSE);
+	/* chip->ac97_powerdown = snd_cs46xx_codec_read(chip, AC97_POWER_CONTROL); */
+	/* chip->ac97_general_purpose = snd_cs46xx_codec_read(chip, BA0_AC97_GENERAL_PURPOSE); */
 
 	snd_ac97_suspend(chip->ac97[CS46XX_PRIMARY_CODEC_INDEX]);
 	snd_ac97_suspend(chip->ac97[CS46XX_SECONDARY_CODEC_INDEX]);
@@ -3652,9 +3652,9 @@ int snd_cs46xx_resume(struct pci_dev *pci)
 #endif
 
 #if 0
-	snd_cs46xx_codec_write(chip, BA0_AC97_GENERAL_PURPOSE, 
+	snd_cs46xx_codec_write(chip, BA0_AC97_GENERAL_PURPOSE,
 			       chip->ac97_general_purpose);
-	snd_cs46xx_codec_write(chip, AC97_POWER_CONTROL, 
+	snd_cs46xx_codec_write(chip, AC97_POWER_CONTROL,
 			       chip->ac97_powerdown);
 	mdelay(10);
 	snd_cs46xx_codec_write(chip, BA0_AC97_POWERDOWN,
@@ -3700,7 +3700,7 @@ int __devinit snd_cs46xx_create(struct snd_card *card,
 	static struct snd_device_ops ops = {
 		.dev_free =	snd_cs46xx_dev_free,
 	};
-	
+
 	*rchip = NULL;
 
 	/* enable PCI device */
@@ -3782,7 +3782,7 @@ int __devinit snd_cs46xx_create(struct snd_card *card,
 		chip->active_ctrl = clkrun_hack;
 		clkrun_init(chip);
 	}
-	
+
 	if (chip->amplifier_ctrl == NULL)
 		chip->amplifier_ctrl = amp_none;
 	if (chip->active_ctrl == NULL)
@@ -3835,7 +3835,7 @@ int __devinit snd_cs46xx_create(struct snd_card *card,
 		snd_cs46xx_free(chip);
 		return err;
 	}
-	
+
 	snd_cs46xx_proc_init(card, chip);
 
 #ifdef CONFIG_PM
diff --git a/sound/pci/cs46xx/dsp_spos.c b/sound/pci/cs46xx/dsp_spos.c
index f4f0c8f..ad6e433 100644
--- a/sound/pci/cs46xx/dsp_spos.c
+++ b/sound/pci/cs46xx/dsp_spos.c
@@ -20,7 +20,7 @@
  */
 
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/init.h>
@@ -37,10 +37,10 @@
 #include "cs46xx_lib.h"
 #include "dsp_spos.h"
 
-static int cs46xx_dsp_async_init (struct snd_cs46xx *chip,
-				  struct dsp_scb_descriptor * fg_entry);
+static int cs46xx_dsp_async_init(struct snd_cs46xx *chip,
+				  struct dsp_scb_descriptor *fg_entry);
 
-static enum wide_opcode wide_opcodes[] = { 
+static enum wide_opcode wide_opcodes[] = {
 	WIDE_FOR_BEGIN_LOOP,
 	WIDE_FOR_BEGIN_LOOP2,
 	WIDE_COND_GOTO_ADDR,
@@ -55,17 +55,17 @@ static enum wide_opcode wide_opcodes[] = {
 	WIDE_TBEQ_NCOND_CALL1_ADDR
 };
 
-static int shadow_and_reallocate_code (struct snd_cs46xx * chip, u32 * data, u32 size,
+static int shadow_and_reallocate_code(struct snd_cs46xx *chip, u32 *data, u32 size,
 				       u32 overlay_begin_address)
 {
 	unsigned int i = 0, j, nreallocated = 0;
 	u32 hival,loval,address;
 	u32 mop_operands,mop_type,wide_op;
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 
 	if (snd_BUG_ON(size %2))
 		return -EINVAL;
-  
+
 	while (i < size) {
 		loval = data[i++];
 		hival = data[i++];
@@ -73,37 +73,37 @@ static int shadow_and_reallocate_code (struct snd_cs46xx * chip, u32 * data, u32
 		if (ins->code.offset > 0) {
 			mop_operands = (hival >> 6) & 0x03fff;
 			mop_type = mop_operands >> 10;
-      
+
 			/* check for wide type instruction */
 			if (mop_type == 0 &&
 			    (mop_operands & WIDE_LADD_INSTR_MASK) == 0 &&
 			    (mop_operands & WIDE_INSTR_MASK) != 0) {
 				wide_op = loval & 0x7f;
-				for (j = 0;j < ARRAY_SIZE(wide_opcodes); ++j) {
+				for (j = 0; j < ARRAY_SIZE(wide_opcodes); ++j) {
 					if (wide_opcodes[j] == wide_op) {
 						/* need to reallocate instruction */
 						address  = (hival & 0x00FFF) << 5;
 						address |=  loval >> 15;
-            
+
 						snd_printdd("handle_wideop[1]: %05x:%05x addr %04x\n",hival,loval,address);
-            
-						if ( !(address & 0x8000) ) {
+
+						if (!(address & 0x8000)) {
 							address += (ins->code.offset / 2) - overlay_begin_address;
 						} else {
 							snd_printdd("handle_wideop[1]: ROM symbol not reallocated\n");
 						}
-            
+
 						hival &= 0xFF000;
 						loval &= 0x07FFF;
-            
+
 						hival |= ( (address >> 5)  & 0x00FFF);
 						loval |= ( (address << 15) & 0xF8000);
-            
+
 						address  = (hival & 0x00FFF) << 5;
 						address |=  loval >> 15;
-            
-						snd_printdd("handle_wideop:[2] %05x:%05x addr %04x\n",hival,loval,address);            
-						nreallocated ++;
+
+						snd_printdd("handle_wideop:[2] %05x:%05x addr %04x\n",hival,loval,address);
+						nreallocated++;
 					} /* wide_opcodes[j] == wide_op */
 				} /* for */
 			} /* mod_type == 0 ... */
@@ -117,10 +117,10 @@ static int shadow_and_reallocate_code (struct snd_cs46xx * chip, u32 * data, u32
 	return nreallocated;
 }
 
-static struct dsp_segment_desc * get_segment_desc (struct dsp_module_desc * module, int seg_type)
+static struct dsp_segment_desc *get_segment_desc(struct dsp_module_desc *module, int seg_type)
 {
 	int i;
-	for (i = 0;i < module->nsegments; ++i) {
+	for (i = 0; i < module->nsegments; ++i) {
 		if (module->segments[i].segment_type == seg_type) {
 			return (module->segments + i);
 		}
@@ -129,7 +129,7 @@ static struct dsp_segment_desc * get_segment_desc (struct dsp_module_desc * modu
 	return NULL;
 };
 
-static int find_free_symbol_index (struct dsp_spos_instance * ins)
+static int find_free_symbol_index(struct dsp_spos_instance *ins)
 {
 	int index = ins->symbol_table.nsymbols,i;
 
@@ -143,19 +143,19 @@ static int find_free_symbol_index (struct dsp_spos_instance * ins)
 	return index;
 }
 
-static int add_symbols (struct snd_cs46xx * chip, struct dsp_module_desc * module)
+static int add_symbols(struct snd_cs46xx *chip, struct dsp_module_desc *module)
 {
 	int i;
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 
 	if (module->symbol_table.nsymbols > 0) {
 		if (!strcmp(module->symbol_table.symbols[0].symbol_name, "OVERLAYBEGINADDRESS") &&
-		    module->symbol_table.symbols[0].symbol_type == SYMBOL_CONSTANT ) {
+		    module->symbol_table.symbols[0].symbol_type == SYMBOL_CONSTANT) {
 			module->overlay_begin_address = module->symbol_table.symbols[0].address;
 		}
 	}
 
-	for (i = 0;i < module->symbol_table.nsymbols; ++i) {
+	for (i = 0; i < module->symbol_table.nsymbols; ++i) {
 		if (ins->symbol_table.nsymbols == (DSP_MAX_SYMBOLS - 1)) {
 			snd_printk(KERN_ERR "dsp_spos: symbol table is full\n");
 			return -ENOMEM;
@@ -171,7 +171,7 @@ static int add_symbols (struct snd_cs46xx * chip, struct dsp_module_desc * modul
 			ins->symbol_table.symbols[ins->symbol_table.nsymbols].module = module;
 			ins->symbol_table.symbols[ins->symbol_table.nsymbols].deleted = 0;
 
-			if (ins->symbol_table.nsymbols > ins->symbol_table.highest_frag_index) 
+			if (ins->symbol_table.nsymbols > ins->symbol_table.highest_frag_index)
 				ins->symbol_table.highest_frag_index = ins->symbol_table.nsymbols;
 
 			ins->symbol_table.nsymbols++;
@@ -185,17 +185,17 @@ static int add_symbols (struct snd_cs46xx * chip, struct dsp_module_desc * modul
 }
 
 static struct dsp_symbol_entry *
-add_symbol (struct snd_cs46xx * chip, char * symbol_name, u32 address, int type)
+add_symbol(struct snd_cs46xx *chip, char *symbol_name, u32 address, int type)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
-	struct dsp_symbol_entry * symbol = NULL;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
+	struct dsp_symbol_entry *symbol = NULL;
 	int index;
 
 	if (ins->symbol_table.nsymbols == (DSP_MAX_SYMBOLS - 1)) {
 		snd_printk(KERN_ERR "dsp_spos: symbol table is full\n");
 		return NULL;
 	}
-  
+
 	if (cs46xx_dsp_lookup_symbol(chip,
 				     symbol_name,
 				     type) != NULL) {
@@ -212,7 +212,7 @@ add_symbol (struct snd_cs46xx * chip, char * symbol_name, u32 address, int type)
 	ins->symbol_table.symbols[index].deleted = 0;
 	symbol = (ins->symbol_table.symbols + index);
 
-	if (index > ins->symbol_table.highest_frag_index) 
+	if (index > ins->symbol_table.highest_frag_index)
 		ins->symbol_table.highest_frag_index = index;
 
 	if (index == ins->symbol_table.nsymbols)
@@ -221,11 +221,11 @@ add_symbol (struct snd_cs46xx * chip, char * symbol_name, u32 address, int type)
 	return symbol;
 }
 
-struct dsp_spos_instance *cs46xx_dsp_spos_create (struct snd_cs46xx * chip)
+struct dsp_spos_instance *cs46xx_dsp_spos_create(struct snd_cs46xx *chip)
 {
-	struct dsp_spos_instance * ins = kzalloc(sizeof(struct dsp_spos_instance), GFP_KERNEL);
+	struct dsp_spos_instance *ins = kzalloc(sizeof(struct dsp_spos_instance), GFP_KERNEL);
 
-	if (ins == NULL) 
+	if (ins == NULL)
 		return NULL;
 
 	/* better to use vmalloc for this big table */
@@ -271,8 +271,8 @@ struct dsp_spos_instance *cs46xx_dsp_spos_create (struct snd_cs46xx * chip)
 
 	/* set left and right validity bits and
 	   default channel status */
-	ins->spdif_csuv_default = 
-		ins->spdif_csuv_stream =  
+	ins->spdif_csuv_default =
+		ins->spdif_csuv_stream =
 	 /* byte 0 */  ((unsigned int)_wrap_all_bits(  (SNDRV_PCM_DEFAULT_CON_SPDIF        & 0xff)) << 24) |
 	 /* byte 1 */  ((unsigned int)_wrap_all_bits( ((SNDRV_PCM_DEFAULT_CON_SPDIF >> 8) & 0xff)) << 16) |
 	 /* byte 3 */   (unsigned int)_wrap_all_bits(  (SNDRV_PCM_DEFAULT_CON_SPDIF >> 24) & 0xff) |
@@ -285,10 +285,10 @@ error:
 	return NULL;
 }
 
-void  cs46xx_dsp_spos_destroy (struct snd_cs46xx * chip)
+void  cs46xx_dsp_spos_destroy(struct snd_cs46xx *chip)
 {
 	int i;
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 
 	if (snd_BUG_ON(!ins))
 		return;
@@ -297,7 +297,7 @@ void  cs46xx_dsp_spos_destroy (struct snd_cs46xx * chip)
 	for (i = 0; i < ins->nscb; ++i) {
 		if (ins->scbs[i].deleted) continue;
 
-		cs46xx_dsp_proc_free_scb_desc ( (ins->scbs + i) );
+		cs46xx_dsp_proc_free_scb_desc ( (ins->scbs + i));
 	}
 
 	kfree(ins->code.data);
@@ -354,10 +354,10 @@ static int dsp_load_sample(struct snd_cs46xx *chip,
 	return 0;
 }
 
-int cs46xx_dsp_load_module (struct snd_cs46xx * chip, struct dsp_module_desc * module)
+int cs46xx_dsp_load_module(struct snd_cs46xx *chip, struct dsp_module_desc *module)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
-	struct dsp_segment_desc * code = get_segment_desc (module,SEGTYPE_SP_PROGRAM);
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
+	struct dsp_segment_desc *code = get_segment_desc (module,SEGTYPE_SP_PROGRAM);
 	u32 doffset, dsize;
 	int err;
 
@@ -367,12 +367,12 @@ int cs46xx_dsp_load_module (struct snd_cs46xx * chip, struct dsp_module_desc * m
 	}
 
 	snd_printdd("dsp_spos: loading module %s into DSP\n", module->module_name);
-  
+
 	if (ins->nmodules == 0) {
 		snd_printdd("dsp_spos: clearing parameter area\n");
 		snd_cs46xx_clear_BA1(chip, DSP_PARAMETER_BYTE_OFFSET, DSP_PARAMETER_BYTE_SIZE);
 	}
-  
+
 	err = dsp_load_parameter(chip, get_segment_desc(module,
 							SEGTYPE_SP_PARAMETER));
 	if (err < 0)
@@ -412,11 +412,11 @@ int cs46xx_dsp_load_module (struct snd_cs46xx * chip, struct dsp_module_desc * m
 			snd_printk(KERN_ERR "dsp_spos: failed to load symbol table\n");
 			return -ENOMEM;
 		}
-    
+
 		doffset = (code->offset * 4 + ins->code.offset * 4 + DSP_CODE_BYTE_OFFSET);
 		dsize   = code->size * 4;
 		snd_printdd("dsp_spos: downloading code to chip (%08x-%08x)\n",
-			    doffset,doffset + dsize);   
+			    doffset,doffset + dsize);
 
 		module->nfixups = shadow_and_reallocate_code(chip,code->data,code->size,module->overlay_begin_address);
 
@@ -438,12 +438,12 @@ int cs46xx_dsp_load_module (struct snd_cs46xx * chip, struct dsp_module_desc * m
 }
 
 struct dsp_symbol_entry *
-cs46xx_dsp_lookup_symbol (struct snd_cs46xx * chip, char * symbol_name, int symbol_type)
+cs46xx_dsp_lookup_symbol(struct snd_cs46xx *chip, char *symbol_name, int symbol_type)
 {
 	int i;
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 
-	for ( i = 0; i < ins->symbol_table.nsymbols; ++i ) {
+	for (i = 0; i < ins->symbol_table.nsymbols; ++i) {
 
 		if (ins->symbol_table.symbols[i].deleted)
 			continue;
@@ -465,12 +465,12 @@ cs46xx_dsp_lookup_symbol (struct snd_cs46xx * chip, char * symbol_name, int symb
 
 #ifdef CONFIG_PROC_FS
 static struct dsp_symbol_entry *
-cs46xx_dsp_lookup_symbol_addr (struct snd_cs46xx * chip, u32 address, int symbol_type)
+cs46xx_dsp_lookup_symbol_addr(struct snd_cs46xx *chip, u32 address, int symbol_type)
 {
 	int i;
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 
-	for ( i = 0; i < ins->symbol_table.nsymbols; ++i ) {
+	for (i = 0; i < ins->symbol_table.nsymbols; ++i) {
 
 		if (ins->symbol_table.symbols[i].deleted)
 			continue;
@@ -486,15 +486,15 @@ cs46xx_dsp_lookup_symbol_addr (struct snd_cs46xx * chip, u32 address, int symbol
 }
 
 
-static void cs46xx_dsp_proc_symbol_table_read (struct snd_info_entry *entry,
+static void cs46xx_dsp_proc_symbol_table_read(struct snd_info_entry *entry,
 					       struct snd_info_buffer *buffer)
 {
 	struct snd_cs46xx *chip = entry->private_data;
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 	int i;
 
 	snd_iprintf(buffer, "SYMBOLS:\n");
-	for ( i = 0; i < ins->symbol_table.nsymbols; ++i ) {
+	for (i = 0; i < ins->symbol_table.nsymbols; ++i) {
 		char *module_str = "system";
 
 		if (ins->symbol_table.symbols[i].deleted)
@@ -504,32 +504,32 @@ static void cs46xx_dsp_proc_symbol_table_read (struct snd_info_entry *entry,
 			module_str = ins->symbol_table.symbols[i].module->module_name;
 		}
 
-    
+
 		snd_iprintf(buffer, "%04X <%02X> %s [%s]\n",
 			    ins->symbol_table.symbols[i].address,
 			    ins->symbol_table.symbols[i].symbol_type,
 			    ins->symbol_table.symbols[i].symbol_name,
-			    module_str);    
+			    module_str);
 	}
 }
 
 
-static void cs46xx_dsp_proc_modules_read (struct snd_info_entry *entry,
+static void cs46xx_dsp_proc_modules_read(struct snd_info_entry *entry,
 					  struct snd_info_buffer *buffer)
 {
 	struct snd_cs46xx *chip = entry->private_data;
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 	int i,j;
 
 	mutex_lock(&chip->spos_mutex);
 	snd_iprintf(buffer, "MODULES:\n");
-	for ( i = 0; i < ins->nmodules; ++i ) {
+	for (i = 0; i < ins->nmodules; ++i) {
 		snd_iprintf(buffer, "\n%s:\n", ins->modules[i].module_name);
 		snd_iprintf(buffer, "   %d symbols\n", ins->modules[i].symbol_table.nsymbols);
 		snd_iprintf(buffer, "   %d fixups\n", ins->modules[i].nfixups);
 
 		for (j = 0; j < ins->modules[i].nsegments; ++ j) {
-			struct dsp_segment_desc * desc = (ins->modules[i].segments + j);
+			struct dsp_segment_desc *desc = (ins->modules[i].segments + j);
 			snd_iprintf(buffer, "   segment %02x offset %08x size %08x\n",
 				    desc->segment_type,desc->offset, desc->size);
 		}
@@ -537,20 +537,20 @@ static void cs46xx_dsp_proc_modules_read (struct snd_info_entry *entry,
 	mutex_unlock(&chip->spos_mutex);
 }
 
-static void cs46xx_dsp_proc_task_tree_read (struct snd_info_entry *entry,
+static void cs46xx_dsp_proc_task_tree_read(struct snd_info_entry *entry,
 					    struct snd_info_buffer *buffer)
 {
 	struct snd_cs46xx *chip = entry->private_data;
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 	int i, j, col;
 	void __iomem *dst = chip->region.idx[1].remap_addr + DSP_PARAMETER_BYTE_OFFSET;
 
 	mutex_lock(&chip->spos_mutex);
 	snd_iprintf(buffer, "TASK TREES:\n");
-	for ( i = 0; i < ins->ntask; ++i) {
+	for (i = 0; i < ins->ntask; ++i) {
 		snd_iprintf(buffer,"\n%04x %s:\n",ins->tasks[i].address,ins->tasks[i].task_name);
 
-		for (col = 0,j = 0;j < ins->tasks[i].size; j++,col++) {
+		for (col = 0,j = 0; j < ins->tasks[i].size; j++, col++) {
 			u32 val;
 			if (col == 4) {
 				snd_iprintf(buffer,"\n");
@@ -561,26 +561,26 @@ static void cs46xx_dsp_proc_task_tree_read (struct snd_info_entry *entry,
 		}
 	}
 
-	snd_iprintf(buffer,"\n");  
+	snd_iprintf(buffer,"\n");
 	mutex_unlock(&chip->spos_mutex);
 }
 
-static void cs46xx_dsp_proc_scb_read (struct snd_info_entry *entry,
+static void cs46xx_dsp_proc_scb_read(struct snd_info_entry *entry,
 				      struct snd_info_buffer *buffer)
 {
 	struct snd_cs46xx *chip = entry->private_data;
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 	int i;
 
 	mutex_lock(&chip->spos_mutex);
 	snd_iprintf(buffer, "SCB's:\n");
-	for ( i = 0; i < ins->nscb; ++i) {
+	for (i = 0; i < ins->nscb; ++i) {
 		if (ins->scbs[i].deleted)
 			continue;
 		snd_iprintf(buffer,"\n%04x %s:\n\n",ins->scbs[i].address,ins->scbs[i].scb_name);
 
 		if (ins->scbs[i].parent_scb_ptr != NULL) {
-			snd_iprintf(buffer,"parent [%s:%04x] ", 
+			snd_iprintf(buffer,"parent [%s:%04x] ",
 				    ins->scbs[i].parent_scb_ptr->scb_name,
 				    ins->scbs[i].parent_scb_ptr->address);
 		} else snd_iprintf(buffer,"parent [none] ");
@@ -598,22 +598,22 @@ static void cs46xx_dsp_proc_scb_read (struct snd_info_entry *entry,
 	mutex_unlock(&chip->spos_mutex);
 }
 
-static void cs46xx_dsp_proc_parameter_dump_read (struct snd_info_entry *entry,
+static void cs46xx_dsp_proc_parameter_dump_read(struct snd_info_entry *entry,
 						 struct snd_info_buffer *buffer)
 {
 	struct snd_cs46xx *chip = entry->private_data;
-	/*struct dsp_spos_instance * ins = chip->dsp_spos_instance; */
+	/*struct dsp_spos_instance *ins = chip->dsp_spos_instance; */
 	unsigned int i, col = 0;
 	void __iomem *dst = chip->region.idx[1].remap_addr + DSP_PARAMETER_BYTE_OFFSET;
-	struct dsp_symbol_entry * symbol; 
+	struct dsp_symbol_entry *symbol;
 
-	for (i = 0;i < DSP_PARAMETER_BYTE_SIZE; i += sizeof(u32),col ++) {
+	for (i = 0; i < DSP_PARAMETER_BYTE_SIZE; i += sizeof(u32), col++) {
 		if (col == 4) {
 			snd_iprintf(buffer,"\n");
 			col = 0;
 		}
 
-		if ( (symbol = cs46xx_dsp_lookup_symbol_addr (chip,i / sizeof(u32), SYMBOL_PARAMETER)) != NULL) {
+		if ((symbol = cs46xx_dsp_lookup_symbol_addr (chip,i / sizeof(u32), SYMBOL_PARAMETER)) != NULL) {
 			col = 0;
 			snd_iprintf (buffer,"\n%s:\n",symbol->symbol_name);
 		}
@@ -626,15 +626,15 @@ static void cs46xx_dsp_proc_parameter_dump_read (struct snd_info_entry *entry,
 	}
 }
 
-static void cs46xx_dsp_proc_sample_dump_read (struct snd_info_entry *entry,
+static void cs46xx_dsp_proc_sample_dump_read(struct snd_info_entry *entry,
 					      struct snd_info_buffer *buffer)
 {
 	struct snd_cs46xx *chip = entry->private_data;
-	int i,col = 0;
+	int i, col = 0;
 	void __iomem *dst = chip->region.idx[2].remap_addr;
 
 	snd_iprintf(buffer,"PCMREADER:\n");
-	for (i = PCM_READER_BUF1;i < PCM_READER_BUF1 + 0x30; i += sizeof(u32),col ++) {
+	for (i = PCM_READER_BUF1; i < PCM_READER_BUF1 + 0x30; i += sizeof(u32), col++) {
 		if (col == 4) {
 			snd_iprintf(buffer,"\n");
 			col = 0;
@@ -650,7 +650,7 @@ static void cs46xx_dsp_proc_sample_dump_read (struct snd_info_entry *entry,
 	snd_iprintf(buffer,"\nMIX_SAMPLE_BUF1:\n");
 
 	col = 0;
-	for (i = MIX_SAMPLE_BUF1;i < MIX_SAMPLE_BUF1 + 0x40; i += sizeof(u32),col ++) {
+	for (i = MIX_SAMPLE_BUF1; i < MIX_SAMPLE_BUF1 + 0x40; i += sizeof(u32), col++) {
 		if (col == 4) {
 			snd_iprintf(buffer,"\n");
 			col = 0;
@@ -665,12 +665,12 @@ static void cs46xx_dsp_proc_sample_dump_read (struct snd_info_entry *entry,
 
 	snd_iprintf(buffer,"\nSRC_TASK_SCB1:\n");
 	col = 0;
-	for (i = 0x2480 ; i < 0x2480 + 0x40 ; i += sizeof(u32),col ++) {
+	for (i = 0x2480; i < 0x2480 + 0x40; i += sizeof(u32), col++) {
 		if (col == 4) {
 			snd_iprintf(buffer,"\n");
 			col = 0;
 		}
-		
+
 		if (col == 0) {
 			snd_iprintf(buffer, "%04X ",i);
 		}
@@ -681,7 +681,7 @@ static void cs46xx_dsp_proc_sample_dump_read (struct snd_info_entry *entry,
 
 	snd_iprintf(buffer,"\nSPDIFO_BUFFER:\n");
 	col = 0;
-	for (i = SPDIFO_IP_OUTPUT_BUFFER1;i < SPDIFO_IP_OUTPUT_BUFFER1 + 0x30; i += sizeof(u32),col ++) {
+	for (i = SPDIFO_IP_OUTPUT_BUFFER1; i < SPDIFO_IP_OUTPUT_BUFFER1 + 0x30; i += sizeof(u32), col++) {
 		if (col == 4) {
 			snd_iprintf(buffer,"\n");
 			col = 0;
@@ -697,7 +697,7 @@ static void cs46xx_dsp_proc_sample_dump_read (struct snd_info_entry *entry,
 	snd_iprintf(buffer,"\n...\n");
 	col = 0;
 
-	for (i = SPDIFO_IP_OUTPUT_BUFFER1+0xD0;i < SPDIFO_IP_OUTPUT_BUFFER1 + 0x110; i += sizeof(u32),col ++) {
+	for (i = SPDIFO_IP_OUTPUT_BUFFER1+0xD0; i < SPDIFO_IP_OUTPUT_BUFFER1 + 0x110; i += sizeof(u32), col++) {
 		if (col == 4) {
 			snd_iprintf(buffer,"\n");
 			col = 0;
@@ -713,7 +713,7 @@ static void cs46xx_dsp_proc_sample_dump_read (struct snd_info_entry *entry,
 
 	snd_iprintf(buffer,"\nOUTPUT_SNOOP:\n");
 	col = 0;
-	for (i = OUTPUT_SNOOP_BUFFER;i < OUTPUT_SNOOP_BUFFER + 0x40; i += sizeof(u32),col ++) {
+	for (i = OUTPUT_SNOOP_BUFFER; i < OUTPUT_SNOOP_BUFFER + 0x40; i += sizeof(u32), col++) {
 		if (col == 4) {
 			snd_iprintf(buffer,"\n");
 			col = 0;
@@ -728,7 +728,7 @@ static void cs46xx_dsp_proc_sample_dump_read (struct snd_info_entry *entry,
 
 	snd_iprintf(buffer,"\nCODEC_INPUT_BUF1: \n");
 	col = 0;
-	for (i = CODEC_INPUT_BUF1;i < CODEC_INPUT_BUF1 + 0x40; i += sizeof(u32),col ++) {
+	for (i = CODEC_INPUT_BUF1; i < CODEC_INPUT_BUF1 + 0x40; i += sizeof(u32), col++) {
 		if (col == 4) {
 			snd_iprintf(buffer,"\n");
 			col = 0;
@@ -743,7 +743,7 @@ static void cs46xx_dsp_proc_sample_dump_read (struct snd_info_entry *entry,
 #if 0
 	snd_iprintf(buffer,"\nWRITE_BACK_BUF1: \n");
 	col = 0;
-	for (i = WRITE_BACK_BUF1;i < WRITE_BACK_BUF1 + 0x40; i += sizeof(u32),col ++) {
+	for (i = WRITE_BACK_BUF1; i < WRITE_BACK_BUF1 + 0x40; i += sizeof(u32), col++) {
 		if (col == 4) {
 			snd_iprintf(buffer,"\n");
 			col = 0;
@@ -759,7 +759,7 @@ static void cs46xx_dsp_proc_sample_dump_read (struct snd_info_entry *entry,
 
 	snd_iprintf(buffer,"\nSPDIFI_IP_OUTPUT_BUFFER1: \n");
 	col = 0;
-	for (i = SPDIFI_IP_OUTPUT_BUFFER1;i < SPDIFI_IP_OUTPUT_BUFFER1 + 0x80; i += sizeof(u32),col ++) {
+	for (i = SPDIFI_IP_OUTPUT_BUFFER1; i < SPDIFI_IP_OUTPUT_BUFFER1 + 0x80; i += sizeof(u32), col++) {
 		if (col == 4) {
 			snd_iprintf(buffer,"\n");
 			col = 0;
@@ -768,16 +768,16 @@ static void cs46xx_dsp_proc_sample_dump_read (struct snd_info_entry *entry,
 		if (col == 0) {
 			snd_iprintf(buffer, "%04X ",i);
 		}
-		
+
 		snd_iprintf(buffer,"%08X ",readl(dst + i));
 	}
 	snd_iprintf(buffer,"\n");
 }
 
-int cs46xx_dsp_proc_init (struct snd_card *card, struct snd_cs46xx *chip)
+int cs46xx_dsp_proc_init(struct snd_card *card, struct snd_cs46xx *chip)
 {
 	struct snd_info_entry *entry;
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 	int i;
 
 	ins->snd_card = card;
@@ -785,7 +785,7 @@ int cs46xx_dsp_proc_init (struct snd_card *card, struct snd_cs46xx *chip)
 	if ((entry = snd_info_create_card_entry(card, "dsp", card->proc_root)) != NULL) {
 		entry->content = SNDRV_INFO_CONTENT_TEXT;
 		entry->mode = S_IFDIR | S_IRUGO | S_IXUGO;
-      
+
 		if (snd_info_register(entry) < 0) {
 			snd_info_free_entry(entry);
 			entry = NULL;
@@ -808,7 +808,7 @@ int cs46xx_dsp_proc_init (struct snd_card *card, struct snd_cs46xx *chip)
 		}
 	}
 	ins->proc_sym_info_entry = entry;
-    
+
 	if ((entry = snd_info_create_card_entry(card, "spos_modules", ins->proc_dsp_dir)) != NULL) {
 		entry->content = SNDRV_INFO_CONTENT_TEXT;
 		entry->private_data = chip;
@@ -881,9 +881,9 @@ int cs46xx_dsp_proc_init (struct snd_card *card, struct snd_cs46xx *chip)
 	return 0;
 }
 
-int cs46xx_dsp_proc_done (struct snd_cs46xx *chip)
+int cs46xx_dsp_proc_done(struct snd_cs46xx *chip)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 	int i;
 
 	snd_info_free_entry(ins->proc_sym_info_entry);
@@ -907,7 +907,7 @@ int cs46xx_dsp_proc_done (struct snd_cs46xx *chip)
 	mutex_lock(&chip->spos_mutex);
 	for (i = 0; i < ins->nscb; ++i) {
 		if (ins->scbs[i].deleted) continue;
-		cs46xx_dsp_proc_free_scb_desc ( (ins->scbs + i) );
+		cs46xx_dsp_proc_free_scb_desc ( (ins->scbs + i));
 	}
 	mutex_unlock(&chip->spos_mutex);
 
@@ -919,10 +919,10 @@ int cs46xx_dsp_proc_done (struct snd_cs46xx *chip)
 #endif /* CONFIG_PROC_FS */
 
 static int debug_tree;
-static void _dsp_create_task_tree (struct snd_cs46xx *chip, u32 * task_data,
+static void _dsp_create_task_tree(struct snd_cs46xx *chip, u32 *task_data,
 				   u32  dest, int size)
 {
-	void __iomem *spdst = chip->region.idx[1].remap_addr + 
+	void __iomem *spdst = chip->region.idx[1].remap_addr +
 		DSP_PARAMETER_BYTE_OFFSET + dest * sizeof(u32);
 	int i;
 
@@ -934,9 +934,9 @@ static void _dsp_create_task_tree (struct snd_cs46xx *chip, u32 * task_data,
 }
 
 static int debug_scb;
-static void _dsp_create_scb (struct snd_cs46xx *chip, u32 * scb_data, u32 dest)
+static void _dsp_create_scb(struct snd_cs46xx *chip, u32 *scb_data, u32 dest)
 {
-	void __iomem *spdst = chip->region.idx[1].remap_addr + 
+	void __iomem *spdst = chip->region.idx[1].remap_addr +
 		DSP_PARAMETER_BYTE_OFFSET + dest * sizeof(u32);
 	int i;
 
@@ -947,7 +947,7 @@ static void _dsp_create_scb (struct snd_cs46xx *chip, u32 * scb_data, u32 dest)
 	}
 }
 
-static int find_free_scb_index (struct dsp_spos_instance * ins)
+static int find_free_scb_index(struct dsp_spos_instance *ins)
 {
 	int index = ins->nscb, i;
 
@@ -961,10 +961,10 @@ static int find_free_scb_index (struct dsp_spos_instance * ins)
 	return index;
 }
 
-static struct dsp_scb_descriptor * _map_scb (struct snd_cs46xx *chip, char * name, u32 dest)
+static struct dsp_scb_descriptor *_map_scb(struct snd_cs46xx *chip, char *name, u32 dest)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
-	struct dsp_scb_descriptor * desc = NULL;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
+	struct dsp_scb_descriptor *desc = NULL;
 	int index;
 
 	if (ins->nscb == DSP_MAX_SCB_DESC - 1) {
@@ -995,10 +995,10 @@ static struct dsp_scb_descriptor * _map_scb (struct snd_cs46xx *chip, char * nam
 }
 
 static struct dsp_task_descriptor *
-_map_task_tree (struct snd_cs46xx *chip, char * name, u32 dest, u32 size)
+_map_task_tree(struct snd_cs46xx *chip, char *name, u32 dest, u32 size)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
-	struct dsp_task_descriptor * desc = NULL;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
+	struct dsp_task_descriptor *desc = NULL;
 
 	if (ins->ntask == DSP_MAX_TASK_DESC - 1) {
 		snd_printk(KERN_ERR "dsp_spos: got no place for other TASK\n");
@@ -1023,9 +1023,9 @@ _map_task_tree (struct snd_cs46xx *chip, char * name, u32 dest, u32 size)
 }
 
 struct dsp_scb_descriptor *
-cs46xx_dsp_create_scb (struct snd_cs46xx *chip, char * name, u32 * scb_data, u32 dest)
+cs46xx_dsp_create_scb(struct snd_cs46xx *chip, char *name, u32 *scb_data, u32 dest)
 {
-	struct dsp_scb_descriptor * desc;
+	struct dsp_scb_descriptor *desc;
 
 	desc = _map_scb (chip,name,dest);
 	if (desc) {
@@ -1040,10 +1040,10 @@ cs46xx_dsp_create_scb (struct snd_cs46xx *chip, char * name, u32 * scb_data, u32
 
 
 static struct dsp_task_descriptor *
-cs46xx_dsp_create_task_tree (struct snd_cs46xx *chip, char * name, u32 * task_data,
+cs46xx_dsp_create_task_tree(struct snd_cs46xx *chip, char *name, u32 *task_data,
 			     u32 dest, int size)
 {
-	struct dsp_task_descriptor * desc;
+	struct dsp_task_descriptor *desc;
 
 	desc = _map_task_tree (chip,name,dest,size);
 	if (desc) {
@@ -1056,28 +1056,28 @@ cs46xx_dsp_create_task_tree (struct snd_cs46xx *chip, char * name, u32 * task_da
 	return desc;
 }
 
-int cs46xx_dsp_scb_and_task_init (struct snd_cs46xx *chip)
+int cs46xx_dsp_scb_and_task_init(struct snd_cs46xx *chip)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
-	struct dsp_symbol_entry * fg_task_tree_header_code;
-	struct dsp_symbol_entry * task_tree_header_code;
-	struct dsp_symbol_entry * task_tree_thread;
-	struct dsp_symbol_entry * null_algorithm;
-	struct dsp_symbol_entry * magic_snoop_task;
-
-	struct dsp_scb_descriptor * timing_master_scb;
-	struct dsp_scb_descriptor * codec_out_scb;
-	struct dsp_scb_descriptor * codec_in_scb;
-	struct dsp_scb_descriptor * src_task_scb;
-	struct dsp_scb_descriptor * master_mix_scb;
-	struct dsp_scb_descriptor * rear_mix_scb;
-	struct dsp_scb_descriptor * record_mix_scb;
-	struct dsp_scb_descriptor * write_back_scb;
-	struct dsp_scb_descriptor * vari_decimate_scb;
-	struct dsp_scb_descriptor * rear_codec_out_scb;
-	struct dsp_scb_descriptor * clfe_codec_out_scb;
-	struct dsp_scb_descriptor * magic_snoop_scb;
-	
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
+	struct dsp_symbol_entry *fg_task_tree_header_code;
+	struct dsp_symbol_entry *task_tree_header_code;
+	struct dsp_symbol_entry *task_tree_thread;
+	struct dsp_symbol_entry *null_algorithm;
+	struct dsp_symbol_entry *magic_snoop_task;
+
+	struct dsp_scb_descriptor *timing_master_scb;
+	struct dsp_scb_descriptor *codec_out_scb;
+	struct dsp_scb_descriptor *codec_in_scb;
+	struct dsp_scb_descriptor *src_task_scb;
+	struct dsp_scb_descriptor *master_mix_scb;
+	struct dsp_scb_descriptor *rear_mix_scb;
+	struct dsp_scb_descriptor *record_mix_scb;
+	struct dsp_scb_descriptor *write_back_scb;
+	struct dsp_scb_descriptor *vari_decimate_scb;
+	struct dsp_scb_descriptor *rear_codec_out_scb;
+	struct dsp_scb_descriptor *clfe_codec_out_scb;
+	struct dsp_scb_descriptor *magic_snoop_scb;
+
 	int fifo_addr, fifo_span, valid_slots;
 
 	static struct dsp_spos_control_block sposcb = {
@@ -1107,18 +1107,18 @@ int cs46xx_dsp_scb_and_task_init (struct snd_cs46xx *chip)
 		return -EIO;
 	}
 
-	fg_task_tree_header_code = cs46xx_dsp_lookup_symbol(chip, "FGTASKTREEHEADERCODE", SYMBOL_CODE);  
+	fg_task_tree_header_code = cs46xx_dsp_lookup_symbol(chip, "FGTASKTREEHEADERCODE", SYMBOL_CODE);
 	if (fg_task_tree_header_code == NULL) {
 		snd_printk(KERN_ERR "dsp_spos: symbol FGTASKTREEHEADERCODE not found\n");
 		return -EIO;
 	}
 
-	task_tree_header_code = cs46xx_dsp_lookup_symbol(chip, "TASKTREEHEADERCODE", SYMBOL_CODE);  
+	task_tree_header_code = cs46xx_dsp_lookup_symbol(chip, "TASKTREEHEADERCODE", SYMBOL_CODE);
 	if (task_tree_header_code == NULL) {
 		snd_printk(KERN_ERR "dsp_spos: symbol TASKTREEHEADERCODE not found\n");
 		return -EIO;
 	}
-  
+
 	task_tree_thread = cs46xx_dsp_lookup_symbol(chip, "TASKTREETHREAD", SYMBOL_CODE);
 	if (task_tree_thread == NULL) {
 		snd_printk(KERN_ERR "dsp_spos: symbol TASKTREETHREAD not found\n");
@@ -1130,7 +1130,7 @@ int cs46xx_dsp_scb_and_task_init (struct snd_cs46xx *chip)
 		snd_printk(KERN_ERR "dsp_spos: symbol MAGICSNOOPTASK not found\n");
 		return -EIO;
 	}
-  
+
 	{
 		/* create the null SCB */
 		static struct dsp_generic_scb null_scb = {
@@ -1165,14 +1165,14 @@ int cs46xx_dsp_scb_and_task_init (struct snd_cs46xx *chip)
 			  DSP_SPOS_DC_DC,
 			  DSP_SPOS_DC_DC,
 			  DSP_SPOS_DC,DSP_SPOS_DC },
-    
+
 			{
-				BG_TREE_SCB_ADDR,TIMINGMASTER_SCB_ADDR, 
+				BG_TREE_SCB_ADDR,TIMINGMASTER_SCB_ADDR,
 				0,
-				FG_TASK_HEADER_ADDR + TCBData,                  
+				FG_TASK_HEADER_ADDR + TCBData,
 			},
 
-			{    
+			{
 				4,0,
 				1,0,
 				2,SPOSCB_ADDR + HFGFlags,
@@ -1215,9 +1215,9 @@ int cs46xx_dsp_scb_and_task_init (struct snd_cs46xx *chip)
 				DSP_SPOS_DCDC,
 				DSP_SPOS_DCDC,
 				DSP_SPOS_DCDC,
-				DSP_SPOS_DCDC 
-			},                                               
-			{ 
+				DSP_SPOS_DCDC
+			},
+			{
 				FG_INTERVAL_TIMER_PERIOD,DSP_SPOS_UU,
 				0,0
 			}
@@ -1241,14 +1241,14 @@ int cs46xx_dsp_scb_and_task_init (struct snd_cs46xx *chip)
 			  DSP_SPOS_DC_DC,
 			  DSP_SPOS_DC_DC,
 			  DSP_SPOS_DC,DSP_SPOS_DC },
-    
+
 			{
 				NULL_SCB_ADDR,NULL_SCB_ADDR,  /* Set up the background to do nothing */
 				0,
 				BG_TREE_SCB_ADDR + TCBData,
 			},
 
-			{    
+			{
 				9999,0,
 				0,1,
 				0,SPOSCB_ADDR + HFGFlags,
@@ -1291,9 +1291,9 @@ int cs46xx_dsp_scb_and_task_init (struct snd_cs46xx *chip)
 				DSP_SPOS_DCDC,
 				DSP_SPOS_DCDC,
 				DSP_SPOS_DCDC,
-				DSP_SPOS_DCDC 
-			},                                               
-			{ 
+				DSP_SPOS_DCDC
+			},
+			{
 				BG_INTERVAL_TIMER_PERIOD,DSP_SPOS_UU,
 				0,0
 			}
@@ -1344,7 +1344,7 @@ int cs46xx_dsp_scb_and_task_init (struct snd_cs46xx *chip)
 			0x00020000,
 			0x0000ffff
 		};
-    
+
 		if (!cs46xx_dsp_create_task_tree(chip, NULL,
 						 (u32 *)&mix2_ostream_spb,
 						 WRITE_BACK_SPB, 2))
@@ -1376,7 +1376,7 @@ int cs46xx_dsp_scb_and_task_init (struct snd_cs46xx *chip)
 		goto _fail_end;
 
 	if (chip->nr_ac97_codecs == 1) {
-		/* output on slot 5 and 11 
+		/* output on slot 5 and 11
 		   on primary CODEC */
 		fifo_addr = 0x20;
 		fifo_span = 0x60;
@@ -1384,7 +1384,7 @@ int cs46xx_dsp_scb_and_task_init (struct snd_cs46xx *chip)
 		/* enable slot 5 and 11 */
 		valid_slots |= ACOSV_SLV5 | ACOSV_SLV11;
 	} else {
-		/* output on slot 7 and 8 
+		/* output on slot 7 and 8
 		   on secondary CODEC */
 		fifo_addr = 0x40;
 		fifo_span = 0x10;
@@ -1398,8 +1398,8 @@ int cs46xx_dsp_scb_and_task_init (struct snd_cs46xx *chip)
 							     REAR_CODECOUT_SCB_ADDR,codec_in_scb,
 							     SCB_ON_PARENT_NEXT_SCB);
 	if (!rear_codec_out_scb) goto _fail_end;
-	
-	
+
+
 	/* create the rear PCM channel  mixer SCB */
 	rear_mix_scb = cs46xx_dsp_create_mix_only_scb(chip,"RearMixerSCB",
 						      MIX_SAMPLE_BUF3,
@@ -1408,9 +1408,9 @@ int cs46xx_dsp_scb_and_task_init (struct snd_cs46xx *chip)
 						      SCB_ON_PARENT_SUBLIST_SCB);
 	ins->rear_mix_scb = rear_mix_scb;
 	if (!rear_mix_scb) goto _fail_end;
-	
+
 	if (chip->nr_ac97_codecs == 2) {
-		/* create CODEC tasklet for rear Center/LFE output 
+		/* create CODEC tasklet for rear Center/LFE output
 		   slot 6 and 9 on seconadry CODEC */
 		clfe_codec_out_scb = cs46xx_dsp_create_codec_out_scb(chip,"CodecOutSCB_CLFE",0x0030,0x0030,
 								     CLFE_MIXER_SCB_ADDR,
@@ -1418,8 +1418,8 @@ int cs46xx_dsp_scb_and_task_init (struct snd_cs46xx *chip)
 								     rear_codec_out_scb,
 								     SCB_ON_PARENT_NEXT_SCB);
 		if (!clfe_codec_out_scb) goto _fail_end;
-		
-		
+
+
 		/* create the rear PCM channel  mixer SCB */
 		ins->center_lfe_mix_scb = cs46xx_dsp_create_mix_only_scb(chip,"CLFEMixerSCB",
 									 MIX_SAMPLE_BUF4,
@@ -1445,7 +1445,7 @@ int cs46xx_dsp_scb_and_task_init (struct snd_cs46xx *chip)
 							     clfe_codec_out_scb,
 							     SCB_ON_PARENT_NEXT_SCB);
 
-    
+
 	if (!magic_snoop_scb) goto _fail_end;
 	ins->ref_snoop_scb = magic_snoop_scb;
 
@@ -1473,19 +1473,19 @@ int cs46xx_dsp_scb_and_task_init (struct snd_cs46xx *chip)
 	cs46xx_dsp_async_init(chip,timing_master_scb);
 	return 0;
 
- _fail_end:
+_fail_end:
 	snd_printk(KERN_ERR "dsp_spos: failed to setup SCB's in DSP\n");
 	return -EINVAL;
 }
 
-static int cs46xx_dsp_async_init (struct snd_cs46xx *chip,
-				  struct dsp_scb_descriptor * fg_entry)
+static int cs46xx_dsp_async_init(struct snd_cs46xx *chip,
+				  struct dsp_scb_descriptor *fg_entry)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
-	struct dsp_symbol_entry * s16_async_codec_input_task;
-	struct dsp_symbol_entry * spdifo_task;
-	struct dsp_symbol_entry * spdifi_task;
-	struct dsp_scb_descriptor * spdifi_scb_desc, * spdifo_scb_desc, * async_codec_scb_desc;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
+	struct dsp_symbol_entry *s16_async_codec_input_task;
+	struct dsp_symbol_entry *spdifo_task;
+	struct dsp_symbol_entry *spdifi_task;
+	struct dsp_scb_descriptor *spdifi_scb_desc, *spdifo_scb_desc, *async_codec_scb_desc;
 
 	s16_async_codec_input_task = cs46xx_dsp_lookup_symbol(chip, "S16_ASYNCCODECINPUTTASK", SYMBOL_CODE);
 	if (s16_async_codec_input_task == NULL) {
@@ -1509,10 +1509,10 @@ static int cs46xx_dsp_async_init (struct snd_cs46xx *chip,
 		struct dsp_spdifoscb spdifo_scb = {
 			/* 0 */ DSP_SPOS_UUUU,
 			{
-				/* 1 */ 0xb0, 
-				/* 2 */ 0, 
-				/* 3 */ 0, 
-				/* 4 */ 0, 
+				/* 1 */ 0xb0,
+				/* 2 */ 0,
+				/* 3 */ 0,
+				/* 4 */ 0,
 			},
 			/* NOTE: the SPDIF output task read samples in mono
 			   format, the AsynchFGTxSCB task writes to buffer
@@ -1520,9 +1520,9 @@ static int cs46xx_dsp_async_init (struct snd_cs46xx *chip,
 			*/
 			/* 5 */ RSCONFIG_SAMPLE_16MONO + RSCONFIG_MODULO_256,
 			/* 6 */ ( SPDIFO_IP_OUTPUT_BUFFER1 << 0x10 )  |  0xFFFC,
-			/* 7 */ 0,0, 
-			/* 8 */ 0, 
-			/* 9 */ FG_TASK_HEADER_ADDR, NULL_SCB_ADDR, 
+			/* 7 */ 0,0,
+			/* 8 */ 0,
+			/* 9 */ FG_TASK_HEADER_ADDR, NULL_SCB_ADDR,
 			/* A */ spdifo_task->address,
 			SPDIFO_SCB_INST + SPDIFOFIFOPointer,
 			{
@@ -1539,7 +1539,7 @@ static int cs46xx_dsp_async_init (struct snd_cs46xx *chip,
 			/* 0 */ DSP_SPOS_UULO,DSP_SPOS_UUHI,
 			/* 1 */ 0,
 			/* 2 */ 0,
-			/* 3 */ 1,4000,        /* SPDIFICountLimit SPDIFICount */ 
+			/* 3 */ 1,4000,        /* SPDIFICountLimit SPDIFICount */
 			/* 4 */ DSP_SPOS_UUUU, /* SPDIFIStatusData */
 			/* 5 */ 0,DSP_SPOS_UUHI, /* StatusData, Free4 */
 			/* 6 */ DSP_SPOS_UUUU,  /* Free3 */
@@ -1549,8 +1549,8 @@ static int cs46xx_dsp_async_init (struct snd_cs46xx *chip,
 			/* A */ spdifi_task->address,
 			SPDIFI_SCB_INST + SPDIFIFIFOPointer,
 			/* NOTE: The SPDIF input task write the sample in mono
-			   format from the HW FIFO, the AsynchFGRxSCB task  reads 
-			   them in stereo 
+			   format from the HW FIFO, the AsynchFGRxSCB task  reads
+			   them in stereo
 			*/
 			/* B */ RSCONFIG_SAMPLE_16MONO + RSCONFIG_MODULO_128,
 			/* C */ (SPDIFI_IP_OUTPUT_BUFFER1 << 0x10) | 0xFFFC,
@@ -1573,40 +1573,40 @@ static int cs46xx_dsp_async_init (struct snd_cs46xx *chip,
 			/* 9 */ SPDIFI_SCB_INST,NULL_SCB_ADDR,
 			/* A */ s16_async_codec_input_task->address,
 			HFG_TREE_SCB + AsyncCIOFIFOPointer,
-              
+
 			/* B */ RSCONFIG_SAMPLE_16STEREO + RSCONFIG_MODULO_64,
 			/* C */ (ASYNC_IP_OUTPUT_BUFFER1 << 0x10),  /*(ASYNC_IP_OUTPUT_BUFFER1 << 0x10) | 0xFFFC,*/
-      
+
 #ifdef UseASER1Input
-			/* short AsyncCIFIFOPointer:AsyncCIStatRegAddr;	       
+			/* short AsyncCIFIFOPointer:AsyncCIStatRegAddr;
 			   Init. 0000:8042: for ASER1
 			   0000:8044: for ASER2 */
 			/* D */ 0x8042,0,
-      
+
 			/* short AsyncCIStMoFormat:AsyncCIFIFOBaseAddr;
 			   Init 1 stero:8050 ASER1
 			   Init 0  mono:8070 ASER2
 			   Init 1 Stereo : 0100 ASER1 (Set by script) */
 			/* E */ 0x0100,0x0001,
-      
+
 #endif
-      
+
 #ifdef UseASER2Input
 			/* short AsyncCIFIFOPointer:AsyncCIStatRegAddr;
 			   Init. 0000:8042: for ASER1
 			   0000:8044: for ASER2 */
 			/* D */ 0x8044,0,
-      
+
 			/* short AsyncCIStMoFormat:AsyncCIFIFOBaseAddr;
 			   Init 1 stero:8050 ASER1
 			   Init 0  mono:8070 ASER2
 			   Init 1 Stereo : 0100 ASER1 (Set by script) */
 			/* E */ 0x0110,0x0001,
-      
+
 #endif
-      
+
 			/* short AsyncCIOutputBufModulo:AsyncCIFree;
-			   AsyncCIOutputBufModulo: The modulo size for   
+			   AsyncCIOutputBufModulo: The modulo size for
 			   the output buffer of this task */
 			/* F */ 0, /* DSP_SPOS_UUUU */
 		};
@@ -1647,15 +1647,15 @@ static int cs46xx_dsp_async_init (struct snd_cs46xx *chip,
 		cs46xx_dsp_proc_register_scb_desc (chip,async_codec_scb_desc);
 
 		/* Async MASTER ENABLE, affects both SPDIF input and output */
-		snd_cs46xx_pokeBA0(chip, BA0_ASER_MASTER, 0x1 );
+		snd_cs46xx_pokeBA0(chip, BA0_ASER_MASTER, 0x1);
 	}
 
 	return 0;
 }
 
-static void cs46xx_dsp_disable_spdif_hw (struct snd_cs46xx *chip)
+static void cs46xx_dsp_disable_spdif_hw(struct snd_cs46xx *chip)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 
 	/* set SPDIF output FIFO slot */
 	snd_cs46xx_pokeBA0(chip, BA0_ASER_FADDR, 0);
@@ -1674,16 +1674,16 @@ static void cs46xx_dsp_disable_spdif_hw (struct snd_cs46xx *chip)
 	ins->spdif_status_out &= ~DSP_SPDIF_STATUS_HW_ENABLED;
 }
 
-int cs46xx_dsp_enable_spdif_hw (struct snd_cs46xx *chip)
+int cs46xx_dsp_enable_spdif_hw(struct snd_cs46xx *chip)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 
 	/* if hw-ctrl already enabled, turn off to reset logic ... */
 	cs46xx_dsp_disable_spdif_hw (chip);
 	udelay(50);
 
 	/* set SPDIF output FIFO slot */
-	snd_cs46xx_pokeBA0(chip, BA0_ASER_FADDR, ( 0x8000 | ((SP_SPDOUT_FIFO >> 4) << 4) ));
+	snd_cs46xx_pokeBA0(chip, BA0_ASER_FADDR, ( 0x8000 | ((SP_SPDOUT_FIFO >> 4) << 4)));
 
 	/* SPDIF output MASTER ENABLE */
 	cs46xx_poke_via_dsp (chip,SP_SPDOUT_CONTROL, 0x80000000);
@@ -1699,7 +1699,7 @@ int cs46xx_dsp_enable_spdif_hw (struct snd_cs46xx *chip)
 
 int cs46xx_dsp_enable_spdif_in (struct snd_cs46xx *chip)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 
 	/* turn on amplifier */
 	chip->active_ctrl(chip, 1);
@@ -1712,7 +1712,7 @@ int cs46xx_dsp_enable_spdif_in (struct snd_cs46xx *chip)
 
 	mutex_lock(&chip->spos_mutex);
 
-	if ( ! (ins->spdif_status_out & DSP_SPDIF_STATUS_INPUT_CTRL_ENABLED) ) {
+	if (!(ins->spdif_status_out & DSP_SPDIF_STATUS_INPUT_CTRL_ENABLED)) {
 		/* time countdown enable */
 		cs46xx_poke_via_dsp (chip,SP_ASER_COUNTDOWN, 0x80000005);
 		/* NOTE: 80000005 value is just magic. With all values
@@ -1761,7 +1761,7 @@ int cs46xx_dsp_enable_spdif_in (struct snd_cs46xx *chip)
 
 int cs46xx_dsp_disable_spdif_in (struct snd_cs46xx *chip)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 
 	if (snd_BUG_ON(!ins->asynch_rx_scb))
 		return -EINVAL;
@@ -1787,9 +1787,9 @@ int cs46xx_dsp_disable_spdif_in (struct snd_cs46xx *chip)
 	return 0;
 }
 
-int cs46xx_dsp_enable_pcm_capture (struct snd_cs46xx *chip)
+int cs46xx_dsp_enable_pcm_capture(struct snd_cs46xx *chip)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 
 	if (snd_BUG_ON(ins->pcm_input))
 		return -EINVAL;
@@ -1804,9 +1804,9 @@ int cs46xx_dsp_enable_pcm_capture (struct snd_cs46xx *chip)
 	return 0;
 }
 
-int cs46xx_dsp_disable_pcm_capture (struct snd_cs46xx *chip)
+int cs46xx_dsp_disable_pcm_capture(struct snd_cs46xx *chip)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 
 	if (snd_BUG_ON(!ins->pcm_input))
 		return -EINVAL;
@@ -1819,9 +1819,9 @@ int cs46xx_dsp_disable_pcm_capture (struct snd_cs46xx *chip)
 	return 0;
 }
 
-int cs46xx_dsp_enable_adc_capture (struct snd_cs46xx *chip)
+int cs46xx_dsp_enable_adc_capture(struct snd_cs46xx *chip)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 
 	if (snd_BUG_ON(ins->adc_input))
 		return -EINVAL;
@@ -1836,9 +1836,9 @@ int cs46xx_dsp_enable_adc_capture (struct snd_cs46xx *chip)
 	return 0;
 }
 
-int cs46xx_dsp_disable_adc_capture (struct snd_cs46xx *chip)
+int cs46xx_dsp_disable_adc_capture(struct snd_cs46xx *chip)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 
 	if (snd_BUG_ON(!ins->adc_input))
 		return -EINVAL;
@@ -1851,7 +1851,7 @@ int cs46xx_dsp_disable_adc_capture (struct snd_cs46xx *chip)
 	return 0;
 }
 
-int cs46xx_poke_via_dsp (struct snd_cs46xx *chip, u32 address, u32 data)
+int cs46xx_poke_via_dsp(struct snd_cs46xx *chip, u32 address, u32 data)
 {
 	u32 temp;
 	int  i;
@@ -1860,19 +1860,19 @@ int cs46xx_poke_via_dsp (struct snd_cs46xx *chip, u32 address, u32 data)
 	   a rough guess from looking at the controller spec.) */
 	if (address < 0x8000 || address >= 0x9000)
 		return -EINVAL;
-        
+
 	/* initialize the SP_IO_WRITE SCB with the data. */
 	temp = ( address << 16 ) | ( address & 0x0000FFFF);   /* offset 0 <-- address2 : address1 */
 
 	snd_cs46xx_poke(chip,( SPIOWRITE_SCB_ADDR      << 2), temp);
 	snd_cs46xx_poke(chip,((SPIOWRITE_SCB_ADDR + 1) << 2), data); /* offset 1 <-- data1 */
 	snd_cs46xx_poke(chip,((SPIOWRITE_SCB_ADDR + 2) << 2), data); /* offset 1 <-- data2 */
-    
+
 	/* Poke this location to tell the task to start */
 	snd_cs46xx_poke(chip,((SPIOWRITE_SCB_ADDR + 6) << 2), SPIOWRITE_SCB_ADDR << 0x10);
 
 	/* Verify that the task ran */
-	for (i=0; i<25; i++) {
+	for (i = 0; i < 25; i++) {
 		udelay(125);
 
 		temp =  snd_cs46xx_peek(chip,((SPIOWRITE_SCB_ADDR + 6) << 2));
@@ -1888,13 +1888,13 @@ int cs46xx_poke_via_dsp (struct snd_cs46xx *chip, u32 address, u32 data)
 	return 0;
 }
 
-int cs46xx_dsp_set_dac_volume (struct snd_cs46xx * chip, u16 left, u16 right)
+int cs46xx_dsp_set_dac_volume(struct snd_cs46xx *chip, u16 left, u16 right)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
-	struct dsp_scb_descriptor * scb; 
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
+	struct dsp_scb_descriptor *scb;
 
 	mutex_lock(&chip->spos_mutex);
-	
+
 	/* main output */
 	scb = ins->master_mix_scb->sub_list_ptr;
 	while (scb != ins->the_null_scb) {
@@ -1917,9 +1917,9 @@ int cs46xx_dsp_set_dac_volume (struct snd_cs46xx * chip, u16 left, u16 right)
 	return 0;
 }
 
-int cs46xx_dsp_set_iec958_volume (struct snd_cs46xx * chip, u16 left, u16 right)
+int cs46xx_dsp_set_iec958_volume(struct snd_cs46xx *chip, u16 left, u16 right)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 
 	mutex_lock(&chip->spos_mutex);
 
@@ -1936,9 +1936,9 @@ int cs46xx_dsp_set_iec958_volume (struct snd_cs46xx * chip, u16 left, u16 right)
 }
 
 #ifdef CONFIG_PM
-int cs46xx_dsp_resume(struct snd_cs46xx * chip)
+int cs46xx_dsp_resume(struct snd_cs46xx *chip)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 	int i, err;
 
 	/* clear parameter, sample and code areas */
diff --git a/sound/pci/cs46xx/dsp_spos.h b/sound/pci/cs46xx/dsp_spos.h
index f9e169d..a005f85 100644
--- a/sound/pci/cs46xx/dsp_spos.h
+++ b/sound/pci/cs46xx/dsp_spos.h
@@ -189,9 +189,9 @@ enum wide_opcode {
 static inline u8 _wrap_all_bits (u8 val)
 {
 	u8 wrapped;
-	
+
 	/* wrap all 8 bits */
-	wrapped = 
+	wrapped =
 		((val & 0x1 ) << 7) |
 		((val & 0x2 ) << 5) |
 		((val & 0x4 ) << 3) |
@@ -205,13 +205,13 @@ static inline u8 _wrap_all_bits (u8 val)
 }
 
 static inline void cs46xx_dsp_spos_update_scb (struct snd_cs46xx * chip,
-					       struct dsp_scb_descriptor * scb) 
+					       struct dsp_scb_descriptor * scb)
 {
 	/* update nextSCB and subListPtr in SCB */
 	snd_cs46xx_poke(chip,
 			(scb->address + SCBsubListPtr) << 2,
 			(scb->sub_list_ptr->address << 0x10) |
-			(scb->next_scb_ptr->address));	
+			(scb->next_scb_ptr->address));
 }
 
 static inline void cs46xx_dsp_scb_set_volume (struct snd_cs46xx * chip,
diff --git a/sound/pci/cs46xx/dsp_spos_scb_lib.c b/sound/pci/cs46xx/dsp_spos_scb_lib.c
index dd7c41b..ac14c46 100644
--- a/sound/pci/cs46xx/dsp_spos_scb_lib.c
+++ b/sound/pci/cs46xx/dsp_spos_scb_lib.c
@@ -21,7 +21,7 @@
  */
 
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/init.h>
@@ -37,13 +37,13 @@
 #include "dsp_spos.h"
 
 struct proc_scb_info {
-	struct dsp_scb_descriptor * scb_desc;
+	struct dsp_scb_descriptor *scb_desc;
 	struct snd_cs46xx *chip;
 };
 
-static void remove_symbol (struct snd_cs46xx * chip, struct dsp_symbol_entry * symbol)
+static void remove_symbol(struct snd_cs46xx *chip, struct dsp_symbol_entry *symbol)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 	int symbol_index = (int)(symbol - ins->symbol_table.symbols);
 
 	if (snd_BUG_ON(ins->symbol_table.nsymbols <= 0))
@@ -57,7 +57,7 @@ static void remove_symbol (struct snd_cs46xx * chip, struct dsp_symbol_entry * s
 	if (symbol_index < ins->symbol_table.highest_frag_index) {
 		ins->symbol_table.highest_frag_index = symbol_index;
 	}
-  
+
 	if (symbol_index == ins->symbol_table.nsymbols - 1)
 		ins->symbol_table.nsymbols --;
 
@@ -68,14 +68,14 @@ static void remove_symbol (struct snd_cs46xx * chip, struct dsp_symbol_entry * s
 }
 
 #ifdef CONFIG_PROC_FS
-static void cs46xx_dsp_proc_scb_info_read (struct snd_info_entry *entry,
+static void cs46xx_dsp_proc_scb_info_read(struct snd_info_entry *entry,
 					   struct snd_info_buffer *buffer)
 {
-	struct proc_scb_info * scb_info  = entry->private_data;
-	struct dsp_scb_descriptor * scb = scb_info->scb_desc;
-	struct dsp_spos_instance * ins;
+	struct proc_scb_info *scb_info  = entry->private_data;
+	struct dsp_scb_descriptor *scb = scb_info->scb_desc;
+	struct dsp_spos_instance *ins;
 	struct snd_cs46xx *chip = scb_info->chip;
-	int j,col;
+	int j, col;
 	void __iomem *dst = chip->region.idx[1].remap_addr + DSP_PARAMETER_BYTE_OFFSET;
 
 	ins = chip->dsp_spos_instance;
@@ -83,22 +83,22 @@ static void cs46xx_dsp_proc_scb_info_read (struct snd_info_entry *entry,
 	mutex_lock(&chip->spos_mutex);
 	snd_iprintf(buffer,"%04x %s:\n",scb->address,scb->scb_name);
 
-	for (col = 0,j = 0;j < 0x10; j++,col++) {
+	for (col = 0,j = 0; j < 0x10; j++, col++) {
 		if (col == 4) {
 			snd_iprintf(buffer,"\n");
 			col = 0;
 		}
 		snd_iprintf(buffer,"%08x ",readl(dst + (scb->address + j) * sizeof(u32)));
 	}
-  
+
 	snd_iprintf(buffer,"\n");
 
 	if (scb->parent_scb_ptr != NULL) {
-		snd_iprintf(buffer,"parent [%s:%04x] ", 
+		snd_iprintf(buffer,"parent [%s:%04x] ",
 			    scb->parent_scb_ptr->scb_name,
 			    scb->parent_scb_ptr->address);
 	} else snd_iprintf(buffer,"parent [none] ");
-  
+
 	snd_iprintf(buffer,"sub_list_ptr [%s:%04x]\nnext_scb_ptr [%s:%04x]  task_entry [%s:%04x]\n",
 		    scb->sub_list_ptr->scb_name,
 		    scb->sub_list_ptr->address,
@@ -107,22 +107,22 @@ static void cs46xx_dsp_proc_scb_info_read (struct snd_info_entry *entry,
 		    scb->task_entry->symbol_name,
 		    scb->task_entry->address);
 
-	snd_iprintf(buffer,"index [%d] ref_count [%d]\n",scb->index,scb->ref_count);  
+	snd_iprintf(buffer,"index [%d] ref_count [%d]\n",scb->index,scb->ref_count);
 	mutex_unlock(&chip->spos_mutex);
 }
 #endif
 
-static void _dsp_unlink_scb (struct snd_cs46xx *chip, struct dsp_scb_descriptor * scb)
+static void _dsp_unlink_scb(struct snd_cs46xx *chip, struct dsp_scb_descriptor *scb)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 	unsigned long flags;
 
-	if ( scb->parent_scb_ptr ) {
+	if (scb->parent_scb_ptr) {
 		/* unlink parent SCB */
 		if (snd_BUG_ON(scb->parent_scb_ptr->sub_list_ptr != scb &&
 			       scb->parent_scb_ptr->next_scb_ptr != scb))
 			return;
-  
+
 		if (scb->parent_scb_ptr->sub_list_ptr == scb) {
 
 			if (scb->next_scb_ptr == ins->the_null_scb) {
@@ -153,7 +153,7 @@ static void _dsp_unlink_scb (struct snd_cs46xx *chip, struct dsp_scb_descriptor
 			scb->next_scb_ptr = ins->the_null_scb;
 		}
 
-		spin_lock_irqsave(&chip->reg_lock, flags);    
+		spin_lock_irqsave(&chip->reg_lock, flags);
 
 		/* update parent first entry in DSP RAM */
 		cs46xx_dsp_spos_update_scb(chip,scb->parent_scb_ptr);
@@ -166,21 +166,21 @@ static void _dsp_unlink_scb (struct snd_cs46xx *chip, struct dsp_scb_descriptor
 	}
 }
 
-static void _dsp_clear_sample_buffer (struct snd_cs46xx *chip, u32 sample_buffer_addr,
-				      int dword_count) 
+static void _dsp_clear_sample_buffer(struct snd_cs46xx *chip, u32 sample_buffer_addr,
+				      int dword_count)
 {
 	void __iomem *dst = chip->region.idx[2].remap_addr + sample_buffer_addr;
 	int i;
-  
-	for (i = 0; i < dword_count ; ++i ) {
+
+	for (i = 0; i < dword_count; ++i) {
 		writel(0, dst);
 		dst += 4;
-	}  
+	}
 }
 
-void cs46xx_dsp_remove_scb (struct snd_cs46xx *chip, struct dsp_scb_descriptor * scb)
+void cs46xx_dsp_remove_scb(struct snd_cs46xx *chip, struct dsp_scb_descriptor *scb)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 	unsigned long flags;
 
 	/* check integrety */
@@ -190,7 +190,7 @@ void cs46xx_dsp_remove_scb (struct snd_cs46xx *chip, struct dsp_scb_descriptor *
 		return;
 
 #if 0
-	/* can't remove a SCB with childs before 
+	/* can't remove a SCB with childs before
 	   removing childs first  */
 	if (snd_BUG_ON(scb->sub_list_ptr != ins->the_null_scb ||
 		       scb->next_scb_ptr != ins->the_null_scb))
@@ -221,7 +221,7 @@ void cs46xx_dsp_remove_scb (struct snd_cs46xx *chip, struct dsp_scb_descriptor *
 
 #if 0
 	/* !!!! THIS IS A PIECE OF SHIT MADE BY ME !!! */
-	for(i = scb->index + 1;i < ins->nscb; ++i) {
+	for (i = scb->index + 1; i < ins->nscb; ++i) {
 		ins->scbs[i - 1].index = i - 1;
 	}
 #endif
@@ -229,10 +229,10 @@ void cs46xx_dsp_remove_scb (struct snd_cs46xx *chip, struct dsp_scb_descriptor *
 
 
 #ifdef CONFIG_PROC_FS
-void cs46xx_dsp_proc_free_scb_desc (struct dsp_scb_descriptor * scb)
+void cs46xx_dsp_proc_free_scb_desc(struct dsp_scb_descriptor *scb)
 {
 	if (scb->proc_info) {
-		struct proc_scb_info * scb_info = scb->proc_info->private_data;
+		struct proc_scb_info *scb_info = scb->proc_info->private_data;
 
 		snd_printdd("cs46xx_dsp_proc_free_scb_desc: freeing %s\n",scb->scb_name);
 
@@ -243,18 +243,18 @@ void cs46xx_dsp_proc_free_scb_desc (struct dsp_scb_descriptor * scb)
 	}
 }
 
-void cs46xx_dsp_proc_register_scb_desc (struct snd_cs46xx *chip,
-					struct dsp_scb_descriptor * scb)
+void cs46xx_dsp_proc_register_scb_desc(struct snd_cs46xx *chip,
+					struct dsp_scb_descriptor *scb)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 	struct snd_info_entry * entry;
-	struct proc_scb_info * scb_info;
+	struct proc_scb_info *scb_info;
 
 	/* register to proc */
 	if (ins->snd_card != NULL && ins->proc_dsp_dir != NULL &&
 	    scb->proc_info == NULL) {
-  
-		if ((entry = snd_info_create_card_entry(ins->snd_card, scb->scb_name, 
+
+		if ((entry = snd_info_create_card_entry(ins->snd_card, scb->scb_name,
 							ins->proc_dsp_dir)) != NULL) {
 			scb_info = kmalloc(sizeof(struct proc_scb_info), GFP_KERNEL);
 			if (!scb_info) {
@@ -265,13 +265,13 @@ void cs46xx_dsp_proc_register_scb_desc (struct snd_cs46xx *chip,
 
 			scb_info->chip = chip;
 			scb_info->scb_desc = scb;
-      
+
 			entry->content = SNDRV_INFO_CONTENT_TEXT;
 			entry->private_data = scb_info;
 			entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
-      
+
 			entry->c.text.read = cs46xx_dsp_proc_scb_info_read;
-      
+
 			if (snd_info_register(entry) < 0) {
 				snd_info_free_entry(entry);
 				kfree (scb_info);
@@ -284,22 +284,22 @@ out:
 }
 #endif /* CONFIG_PROC_FS */
 
-static struct dsp_scb_descriptor * 
-_dsp_create_generic_scb (struct snd_cs46xx *chip, char * name, u32 * scb_data, u32 dest,
-                         struct dsp_symbol_entry * task_entry,
-                         struct dsp_scb_descriptor * parent_scb,
+static struct dsp_scb_descriptor *
+_dsp_create_generic_scb(struct snd_cs46xx *chip, char *name, u32 *scb_data, u32 dest,
+                         struct dsp_symbol_entry *task_entry,
+                         struct dsp_scb_descriptor *parent_scb,
                          int scb_child_type)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
-	struct dsp_scb_descriptor * scb;
-  
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
+	struct dsp_scb_descriptor *scb;
+
 	unsigned long flags;
 
 	if (snd_BUG_ON(!ins->the_null_scb))
 		return NULL;
 
 	/* fill the data that will be wroten to DSP */
-	scb_data[SCBsubListPtr] = 
+	scb_data[SCBsubListPtr] =
 		(ins->the_null_scb->address << 0x10) | ins->the_null_scb->address;
 
 	scb_data[SCBfuncEntryPtr] &= 0xFFFF0000;
@@ -316,7 +316,7 @@ _dsp_create_generic_scb (struct snd_cs46xx *chip, char * name, u32 * scb_data, u
 	scb->parent_scb_ptr = parent_scb;
 	scb->task_entry = task_entry;
 
-  
+
 	/* update parent SCB */
 	if (scb->parent_scb_ptr) {
 #if 0
@@ -356,31 +356,31 @@ _dsp_create_generic_scb (struct snd_cs46xx *chip, char * name, u32 * scb_data, u
 	return scb;
 }
 
-static struct dsp_scb_descriptor * 
-cs46xx_dsp_create_generic_scb (struct snd_cs46xx *chip, char * name, u32 * scb_data,
-			       u32 dest, char * task_entry_name,
-                               struct dsp_scb_descriptor * parent_scb,
+static struct dsp_scb_descriptor *
+cs46xx_dsp_create_generic_scb(struct snd_cs46xx *chip, char *name, u32 *scb_data,
+			       u32 dest, char *task_entry_name,
+                               struct dsp_scb_descriptor *parent_scb,
                                int scb_child_type)
 {
-	struct dsp_symbol_entry * task_entry;
+	struct dsp_symbol_entry *task_entry;
 
 	task_entry = cs46xx_dsp_lookup_symbol (chip,task_entry_name,
 					       SYMBOL_CODE);
-  
+
 	if (task_entry == NULL) {
 		snd_printk (KERN_ERR "dsp_spos: symbol %s not found\n",task_entry_name);
 		return NULL;
 	}
-  
+
 	return _dsp_create_generic_scb (chip,name,scb_data,dest,task_entry,
 					parent_scb,scb_child_type);
 }
 
-struct dsp_scb_descriptor * 
-cs46xx_dsp_create_timing_master_scb (struct snd_cs46xx *chip)
+struct dsp_scb_descriptor *
+cs46xx_dsp_create_timing_master_scb(struct snd_cs46xx *chip)
 {
-	struct dsp_scb_descriptor * scb;
-  
+	struct dsp_scb_descriptor *scb;
+
 	struct dsp_timing_master_scb timing_master_scb = {
 		{ 0,
 		  0,
@@ -400,8 +400,8 @@ cs46xx_dsp_create_timing_master_scb (struct snd_cs46xx *chip)
 		0x0001,0x8000,   /* fracSampAccumQm1:TMfrmsLeftInGroup */
 		0x0001,0x0000,   /* fracSampCorrectionQm1:TMfrmGroupLength */
 		0x00060000       /* nSampPerFrmQ15 */
-	};    
-  
+	};
+
 	scb = cs46xx_dsp_create_generic_scb(chip,"TimingMasterSCBInst",(u32 *)&timing_master_scb,
 					    TIMINGMASTER_SCB_ADDR,
 					    "TIMINGMASTER",NULL,SCB_NO_PARENT);
@@ -410,14 +410,14 @@ cs46xx_dsp_create_timing_master_scb (struct snd_cs46xx *chip)
 }
 
 
-struct dsp_scb_descriptor * 
-cs46xx_dsp_create_codec_out_scb(struct snd_cs46xx * chip, char * codec_name,
+struct dsp_scb_descriptor *
+cs46xx_dsp_create_codec_out_scb(struct snd_cs46xx *chip, char *codec_name,
                                 u16 channel_disp, u16 fifo_addr, u16 child_scb_addr,
-                                u32 dest, struct dsp_scb_descriptor * parent_scb,
+                                u32 dest, struct dsp_scb_descriptor *parent_scb,
                                 int scb_child_type)
 {
-	struct dsp_scb_descriptor * scb;
-  
+	struct dsp_scb_descriptor *scb;
+
 	struct dsp_codec_output_scb codec_out_scb = {
 		{ 0,
 		  0,
@@ -439,23 +439,23 @@ cs46xx_dsp_create_codec_out_scb(struct snd_cs46xx * chip, char * codec_name,
 		0x0000,0x0080,          /* (!AC97!) COexpVolChangeRate:COscaleShiftCount */
 		0,child_scb_addr        /* COreserved - need child scb to work with rom code */
 	};
-  
-  
+
+
 	scb = cs46xx_dsp_create_generic_scb(chip,codec_name,(u32 *)&codec_out_scb,
 					    dest,"S16_CODECOUTPUTTASK",parent_scb,
 					    scb_child_type);
-  
+
 	return scb;
 }
 
-struct dsp_scb_descriptor * 
-cs46xx_dsp_create_codec_in_scb(struct snd_cs46xx * chip, char * codec_name,
+struct dsp_scb_descriptor *
+cs46xx_dsp_create_codec_in_scb(struct snd_cs46xx *chip, char *codec_name,
 			       u16 channel_disp, u16 fifo_addr, u16 sample_buffer_addr,
-			       u32 dest, struct dsp_scb_descriptor * parent_scb,
+			       u32 dest, struct dsp_scb_descriptor *parent_scb,
 			       int scb_child_type)
 {
 
-	struct dsp_scb_descriptor * scb;
+	struct dsp_scb_descriptor *scb;
 	struct dsp_codec_input_scb codec_input_scb = {
 		{ 0,
 		  0,
@@ -469,7 +469,7 @@ cs46xx_dsp_create_codec_in_scb(struct snd_cs46xx * chip, char * codec_name,
 			0,
 			0
 		},
-    
+
 #if 0  /* cs4620 */
 		SyncIOSCB,NULL_SCB_ADDR
 #else
@@ -479,13 +479,13 @@ cs46xx_dsp_create_codec_in_scb(struct snd_cs46xx * chip, char * codec_name,
 
 		RSCONFIG_SAMPLE_16STEREO + RSCONFIG_MODULO_64,  /* strmRsConfig */
 		sample_buffer_addr << 0x10,       /* strmBufPtr; defined as a dword ptr, used as a byte ptr */
-		channel_disp,fifo_addr,           /* (!AC97!) leftChanBaseINaddr=AC97primary 
+		channel_disp,fifo_addr,           /* (!AC97!) leftChanBaseINaddr=AC97primary
 						     link input slot 3 :rightChanINdisp=""slot 4 */
-		0x0000,0x0000,                    /* (!AC97!) ????:scaleShiftCount; no shift needed 
+		0x0000,0x0000,                    /* (!AC97!) ????:scaleShiftCount; no shift needed
 						     because AC97 is already 20 bits */
 		0x80008000                        /* ??clw cwcgame.scb has 0 */
 	};
-  
+
 	scb = cs46xx_dsp_create_generic_scb(chip,codec_name,(u32 *)&codec_input_scb,
 					    dest,"S16_CODECINPUTTASK",parent_scb,
 					    scb_child_type);
@@ -493,18 +493,18 @@ cs46xx_dsp_create_codec_in_scb(struct snd_cs46xx * chip, char * codec_name,
 }
 
 
-static struct dsp_scb_descriptor * 
-cs46xx_dsp_create_pcm_reader_scb(struct snd_cs46xx * chip, char * scb_name,
+static struct dsp_scb_descriptor *
+cs46xx_dsp_create_pcm_reader_scb(struct snd_cs46xx *chip, char *scb_name,
                                  u16 sample_buffer_addr, u32 dest,
                                  int virtual_channel, u32 playback_hw_addr,
-                                 struct dsp_scb_descriptor * parent_scb,
+                                 struct dsp_scb_descriptor *parent_scb,
                                  int scb_child_type)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
-	struct dsp_scb_descriptor * scb;
-  
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
+	struct dsp_scb_descriptor *scb;
+
 	struct dsp_generic_scb pcm_reader_scb = {
-    
+
 		/*
 		  Play DMA Task xfers data from host buffer to SP buffer
 		  init/runtime variables:
@@ -524,7 +524,7 @@ cs46xx_dsp_create_pcm_reader_scb(struct snd_cs46xx * chip, char * scb_name,
 		  DMA_RQ_C2_AC_MONO_TO_STEREO     0x00002000L
 		  DMA_RQ_C2_AC_ENDIAN_CONVERT     0x00004000L
 		  DMA_RQ_C2_AC_SIGNED_CONVERT     0x00008000L
-        
+
 		  HostBuffAddr: Host Buffer Physical Byte Address - SCB loc:3rd dword, Mask: 0xFFFFFFFFL
 		  aligned to dword boundary
 		*/
@@ -551,7 +551,7 @@ cs46xx_dsp_create_pcm_reader_scb(struct snd_cs46xx * chip, char * scb_name,
 			0,
 			0,
 			0,
-			0 
+			0
 		},
 		/* Sublist pointer & next stream control block (SCB) link. */
 		NULL_SCB_ADDR,NULL_SCB_ADDR,
@@ -568,7 +568,7 @@ cs46xx_dsp_create_pcm_reader_scb(struct snd_cs46xx * chip, char * scb_name,
 		/* Stream sample pointer & MAC-unit mode for this stream */
 		(sample_buffer_addr << 0x10),
 		/* Fractional increment per output sample in the input sample buffer */
-		0, 
+		0,
 		{
 			/* Standard stereo volume control
 			   default muted */
@@ -580,34 +580,34 @@ cs46xx_dsp_create_pcm_reader_scb(struct snd_cs46xx * chip, char * scb_name,
 	if (ins->null_algorithm == NULL) {
 		ins->null_algorithm =  cs46xx_dsp_lookup_symbol (chip,"NULLALGORITHM",
 								 SYMBOL_CODE);
-    
+
 		if (ins->null_algorithm == NULL) {
 			snd_printk (KERN_ERR "dsp_spos: symbol NULLALGORITHM not found\n");
 			return NULL;
-		}    
+		}
 	}
 
 	scb = _dsp_create_generic_scb(chip,scb_name,(u32 *)&pcm_reader_scb,
 				      dest,ins->null_algorithm,parent_scb,
 				      scb_child_type);
-  
+
 	return scb;
 }
 
 #define GOF_PER_SEC 200
 
-struct dsp_scb_descriptor * 
-cs46xx_dsp_create_src_task_scb(struct snd_cs46xx * chip, char * scb_name,
+struct dsp_scb_descriptor *
+cs46xx_dsp_create_src_task_scb(struct snd_cs46xx *chip, char *scb_name,
 			       int rate,
                                u16 src_buffer_addr,
                                u16 src_delay_buffer_addr, u32 dest,
-                               struct dsp_scb_descriptor * parent_scb,
+                               struct dsp_scb_descriptor *parent_scb,
                                int scb_child_type,
 	                       int pass_through)
 {
 
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
-	struct dsp_scb_descriptor * scb;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
+	struct dsp_scb_descriptor *scb;
 	unsigned int tmp1, tmp2;
 	unsigned int phiIncr;
 	unsigned int correctionPerGOF, correctionPerSec;
@@ -650,35 +650,35 @@ cs46xx_dsp_create_src_task_scb(struct snd_cs46xx * chip, char * scb_name,
 			0x0000,0x0000,
 			src_buffer_addr,1,
 			correctionPerGOF,correctionPerSec,
-			RSCONFIG_SAMPLE_16STEREO + RSCONFIG_MODULO_32,  
-			0x0000,src_delay_buffer_addr,                  
-			0x0,                                            
+			RSCONFIG_SAMPLE_16STEREO + RSCONFIG_MODULO_32,
+			0x0000,src_delay_buffer_addr,
+			0x0,
 			0x080,(src_delay_buffer_addr + (24 * 4)),
 			0,0, /* next_scb, sub_list_ptr */
 			0,0, /* entry, this_spb */
 			RSCONFIG_SAMPLE_16STEREO + RSCONFIG_MODULO_8,
 			src_buffer_addr << 0x10,
 			phiIncr,
-			{ 
+			{
 				0xffff - ins->dac_volume_right,0xffff - ins->dac_volume_left,
 				0xffff - ins->dac_volume_right,0xffff - ins->dac_volume_left
 			}
 		};
-		
+
 		if (ins->s16_up == NULL) {
 			ins->s16_up =  cs46xx_dsp_lookup_symbol (chip,"S16_UPSRC",
 								 SYMBOL_CODE);
-			
+
 			if (ins->s16_up == NULL) {
 				snd_printk (KERN_ERR "dsp_spos: symbol S16_UPSRC not found\n");
 				return NULL;
-			}    
+			}
 		}
-		
+
 		/* clear buffers */
 		_dsp_clear_sample_buffer (chip,src_buffer_addr,8);
 		_dsp_clear_sample_buffer (chip,src_delay_buffer_addr,32);
-				
+
 		if (pass_through) {
 			/* wont work with any other rate than
 			   the native DSP rate */
@@ -700,13 +700,13 @@ cs46xx_dsp_create_src_task_scb(struct snd_cs46xx * chip, char * scb_name,
 }
 
 #if 0 /* not used */
-struct dsp_scb_descriptor * 
-cs46xx_dsp_create_filter_scb(struct snd_cs46xx * chip, char * scb_name,
+struct dsp_scb_descriptor *
+cs46xx_dsp_create_filter_scb(struct snd_cs46xx *chip, char *scb_name,
 			     u16 buffer_addr, u32 dest,
-			     struct dsp_scb_descriptor * parent_scb,
+			     struct dsp_scb_descriptor *parent_scb,
 			     int scb_child_type) {
-	struct dsp_scb_descriptor * scb;
-	
+	struct dsp_scb_descriptor *scb;
+
 	struct dsp_filter_scb filter_scb = {
 		.a0_right            = 0x41a9,
 		.a0_left             = 0x41a9,
@@ -714,7 +714,7 @@ cs46xx_dsp_create_filter_scb(struct snd_cs46xx * chip, char * scb_name,
 		.a1_left             = 0xb8e4,
 		.a2_right            = 0x3e55,
 		.a2_left             = 0x3e55,
-		
+
 		.filter_unused3      = 0x0000,
 		.filter_unused2      = 0x0000,
 
@@ -750,14 +750,14 @@ cs46xx_dsp_create_filter_scb(struct snd_cs46xx * chip, char * scb_name,
 }
 #endif /* not used */
 
-struct dsp_scb_descriptor * 
-cs46xx_dsp_create_mix_only_scb(struct snd_cs46xx * chip, char * scb_name,
+struct dsp_scb_descriptor *
+cs46xx_dsp_create_mix_only_scb(struct snd_cs46xx *chip, char *scb_name,
                                u16 mix_buffer_addr, u32 dest,
-                               struct dsp_scb_descriptor * parent_scb,
+                               struct dsp_scb_descriptor *parent_scb,
                                int scb_child_type)
 {
-	struct dsp_scb_descriptor * scb;
-  
+	struct dsp_scb_descriptor *scb;
+
 	struct dsp_mix_only_scb master_mix_scb = {
 		/* 0 */ { 0,
 			  /* 1 */   0,
@@ -774,7 +774,7 @@ cs46xx_dsp_create_mix_only_scb(struct snd_cs46xx * chip, char * scb_name,
 		/* 9 */ 0,0,
 		/* A */ 0,0,
 		/* B */ RSCONFIG_SAMPLE_16STEREO + RSCONFIG_MODULO_32,
-		/* C */ (mix_buffer_addr  + (16 * 4)) << 0x10, 
+		/* C */ (mix_buffer_addr  + (16 * 4)) << 0x10,
 		/* D */ 0,
 		{
 			/* E */ 0x8000,0x8000,
@@ -790,92 +790,92 @@ cs46xx_dsp_create_mix_only_scb(struct snd_cs46xx * chip, char * scb_name,
 }
 
 
-struct dsp_scb_descriptor * 
-cs46xx_dsp_create_mix_to_ostream_scb(struct snd_cs46xx * chip, char * scb_name,
+struct dsp_scb_descriptor *
+cs46xx_dsp_create_mix_to_ostream_scb(struct snd_cs46xx *chip, char *scb_name,
                                      u16 mix_buffer_addr, u16 writeback_spb, u32 dest,
-                                     struct dsp_scb_descriptor * parent_scb,
+                                     struct dsp_scb_descriptor *parent_scb,
                                      int scb_child_type)
 {
-	struct dsp_scb_descriptor * scb;
+	struct dsp_scb_descriptor *scb;
 
 	struct dsp_mix2_ostream_scb mix2_ostream_scb = {
 		/* Basic (non scatter/gather) DMA requestor (4 ints) */
-		{ 
+		{
 			DMA_RQ_C1_SOURCE_MOD64 +
 			DMA_RQ_C1_DEST_ON_HOST +
 			DMA_RQ_C1_DEST_MOD1024 +
-			DMA_RQ_C1_WRITEBACK_SRC_FLAG + 
+			DMA_RQ_C1_WRITEBACK_SRC_FLAG +
 			DMA_RQ_C1_WRITEBACK_DEST_FLAG +
-			15,                            
-      
+			15,
+
 			DMA_RQ_C2_AC_NONE +
-			DMA_RQ_C2_SIGNAL_DEST_PINGPONG + 
-      
-			CS46XX_DSP_CAPTURE_CHANNEL,                                 
-			DMA_RQ_SD_SP_SAMPLE_ADDR + 
-			mix_buffer_addr, 
-			0x0                   
+			DMA_RQ_C2_SIGNAL_DEST_PINGPONG +
+
+			CS46XX_DSP_CAPTURE_CHANNEL,
+			DMA_RQ_SD_SP_SAMPLE_ADDR +
+			mix_buffer_addr,
+			0x0
 		},
-    
+
 		{ 0, 0, 0, 0, 0, },
 		0,0,
 		0,writeback_spb,
-    
-		RSCONFIG_DMA_ENABLE + 
-		(19 << RSCONFIG_MAX_DMA_SIZE_SHIFT) + 
-    
+
+		RSCONFIG_DMA_ENABLE +
+		(19 << RSCONFIG_MAX_DMA_SIZE_SHIFT) +
+
 		((dest >> 4) << RSCONFIG_STREAM_NUM_SHIFT) +
-		RSCONFIG_DMA_TO_HOST + 
+		RSCONFIG_DMA_TO_HOST +
 		RSCONFIG_SAMPLE_16STEREO +
-		RSCONFIG_MODULO_64,    
+		RSCONFIG_MODULO_64,
 		(mix_buffer_addr + (32 * 4)) << 0x10,
-		1,0,            
+		1,0,
 		0x0001,0x0080,
 		0xFFFF,0
 	};
 
 
 	scb = cs46xx_dsp_create_generic_scb(chip,scb_name,(u32 *)&mix2_ostream_scb,
-				
+
 	    dest,"S16_MIX_TO_OSTREAM",parent_scb,
 					    scb_child_type);
-  
+
 	return scb;
 }
 
 
-struct dsp_scb_descriptor * 
-cs46xx_dsp_create_vari_decimate_scb(struct snd_cs46xx * chip,char * scb_name,
+struct dsp_scb_descriptor *
+cs46xx_dsp_create_vari_decimate_scb(struct snd_cs46xx *chip,char *scb_name,
                                     u16 vari_buffer_addr0,
                                     u16 vari_buffer_addr1,
                                     u32 dest,
-                                    struct dsp_scb_descriptor * parent_scb,
+                                    struct dsp_scb_descriptor *parent_scb,
                                     int scb_child_type)
 {
 
-	struct dsp_scb_descriptor * scb;
-  
+	struct dsp_scb_descriptor *scb;
+
 	struct dsp_vari_decimate_scb vari_decimate_scb = {
 		0x0028,0x00c8,
 		0x5555,0x0000,
 		0x0000,0x0000,
 		vari_buffer_addr0,vari_buffer_addr1,
-    
+
 		0x0028,0x00c8,
-		RSCONFIG_SAMPLE_16STEREO + RSCONFIG_MODULO_256, 
-    
-		0xFF800000,   
+		RSCONFIG_SAMPLE_16STEREO + RSCONFIG_MODULO_256,
+
+		0xFF800000,
 		0,
-		0x0080,vari_buffer_addr1 + (25 * 4), 
-    
-		0,0, 
+		0x0080,vari_buffer_addr1 + (25 * 4),
+
+		0,0,
 		0,0,
 
 		RSCONFIG_SAMPLE_16STEREO + RSCONFIG_MODULO_8,
-		vari_buffer_addr0 << 0x10,   
-		0x04000000,                   
+		vari_buffer_addr0 << 0x10,
+		0x04000000,
 		{
-			0x8000,0x8000, 
+			0x8000,0x8000,
 			0xFFFF,0xFFFF
 		}
 	};
@@ -883,19 +883,19 @@ cs46xx_dsp_create_vari_decimate_scb(struct snd_cs46xx * chip,char * scb_name,
 	scb = cs46xx_dsp_create_generic_scb(chip,scb_name,(u32 *)&vari_decimate_scb,
 					    dest,"VARIDECIMATE",parent_scb,
 					    scb_child_type);
-  
+
 	return scb;
 }
 
 
-static struct dsp_scb_descriptor * 
-cs46xx_dsp_create_pcm_serial_input_scb(struct snd_cs46xx * chip, char * scb_name, u32 dest,
+static struct dsp_scb_descriptor *
+cs46xx_dsp_create_pcm_serial_input_scb(struct snd_cs46xx *chip, char *scb_name, u32 dest,
                                        struct dsp_scb_descriptor * input_scb,
-                                       struct dsp_scb_descriptor * parent_scb,
+                                       struct dsp_scb_descriptor *parent_scb,
                                        int scb_child_type)
 {
 
-	struct dsp_scb_descriptor * scb;
+	struct dsp_scb_descriptor *scb;
 
 
 	struct dsp_pcm_serial_input_scb pcm_serial_input_scb = {
@@ -931,15 +931,15 @@ cs46xx_dsp_create_pcm_serial_input_scb(struct snd_cs46xx * chip, char * scb_name
 }
 
 
-static struct dsp_scb_descriptor * 
-cs46xx_dsp_create_asynch_fg_tx_scb(struct snd_cs46xx * chip, char * scb_name, u32 dest,
+static struct dsp_scb_descriptor *
+cs46xx_dsp_create_asynch_fg_tx_scb(struct snd_cs46xx *chip, char *scb_name, u32 dest,
                                    u16 hfg_scb_address,
                                    u16 asynch_buffer_address,
-                                   struct dsp_scb_descriptor * parent_scb,
+                                   struct dsp_scb_descriptor *parent_scb,
                                    int scb_child_type)
 {
 
-	struct dsp_scb_descriptor * scb;
+	struct dsp_scb_descriptor *scb;
 
 	struct dsp_asynch_fg_tx_scb asynch_fg_tx_scb = {
 		0xfc00,0x03ff,      /*  Prototype sample buffer size of 256 dwords */
@@ -949,27 +949,27 @@ cs46xx_dsp_create_asynch_fg_tx_scb(struct snd_cs46xx * chip, char * scb_name, u3
 		0,0,		    /* Initialize current Delta and Consumer ptr adjustment count */
 		0,                  /* Initialize accumulated Phi to 0 */
 		0,0x2aab,           /* Const 1/3 */
-    
+
 		{
 			0,         /* Define the unused elements */
 			0,
 			0
 		},
-    
+
 		0,0,
 		0,dest + AFGTxAccumPhi,
-    
+
 		RSCONFIG_SAMPLE_16STEREO + RSCONFIG_MODULO_256, /* Stereo, 256 dword */
 		(asynch_buffer_address) << 0x10,  /* This should be automagically synchronized
                                                      to the producer pointer */
-    
+
 		/* There is no correct initial value, it will depend upon the detected
 		   rate etc  */
 		0x18000000,                     /* Phi increment for approx 32k operation */
 		0x8000,0x8000,                  /* Volume controls are unused at this time */
 		0x8000,0x8000
 	};
-  
+
 	scb = cs46xx_dsp_create_generic_scb(chip,scb_name,(u32 *)&asynch_fg_tx_scb,
 					    dest,"ASYNCHFGTXCODE",parent_scb,
 					    scb_child_type);
@@ -978,15 +978,15 @@ cs46xx_dsp_create_asynch_fg_tx_scb(struct snd_cs46xx * chip, char * scb_name, u3
 }
 
 
-struct dsp_scb_descriptor * 
-cs46xx_dsp_create_asynch_fg_rx_scb(struct snd_cs46xx * chip, char * scb_name, u32 dest,
+struct dsp_scb_descriptor *
+cs46xx_dsp_create_asynch_fg_rx_scb(struct snd_cs46xx *chip, char *scb_name, u32 dest,
                                    u16 hfg_scb_address,
                                    u16 asynch_buffer_address,
-                                   struct dsp_scb_descriptor * parent_scb,
+                                   struct dsp_scb_descriptor *parent_scb,
                                    int scb_child_type)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
-	struct dsp_scb_descriptor * scb;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
+	struct dsp_scb_descriptor *scb;
 
 	struct dsp_asynch_fg_rx_scb asynch_fg_rx_scb = {
 		0xfe00,0x01ff,      /*  Prototype sample buffer size of 128 dwords */
@@ -1001,18 +1001,18 @@ cs46xx_dsp_create_asynch_fg_rx_scb(struct snd_cs46xx * chip, char * scb_name, u3
 			0,
 			0
 		},
-      
+
 		0,0,
 		0,dest,
-    
+
 		RSCONFIG_MODULO_128 |
         RSCONFIG_SAMPLE_16STEREO,                         /* Stereo, 128 dword */
-		( (asynch_buffer_address + (16 * 4))  << 0x10),   /* This should be automagically 
+		( (asynch_buffer_address + (16 * 4))  << 0x10),   /* This should be automagically
 							                                  synchrinized to the producer pointer */
-    
+
 		/* There is no correct initial value, it will depend upon the detected
 		   rate etc  */
-		0x18000000,         
+		0x18000000,
 
 		/* Set IEC958 input volume */
 		0xffff - ins->spdif_input_volume_right,0xffff - ins->spdif_input_volume_left,
@@ -1028,16 +1028,16 @@ cs46xx_dsp_create_asynch_fg_rx_scb(struct snd_cs46xx * chip, char * scb_name, u3
 
 
 #if 0 /* not used */
-struct dsp_scb_descriptor * 
-cs46xx_dsp_create_output_snoop_scb(struct snd_cs46xx * chip, char * scb_name, u32 dest,
+struct dsp_scb_descriptor *
+cs46xx_dsp_create_output_snoop_scb(struct snd_cs46xx *chip, char *scb_name, u32 dest,
                                    u16 snoop_buffer_address,
                                    struct dsp_scb_descriptor * snoop_scb,
-                                   struct dsp_scb_descriptor * parent_scb,
+                                   struct dsp_scb_descriptor *parent_scb,
                                    int scb_child_type)
 {
 
-	struct dsp_scb_descriptor * scb;
-  
+	struct dsp_scb_descriptor *scb;
+
 	struct dsp_output_snoop_scb output_snoop_scb = {
 		{ 0,	/*  not used.  Zero */
 		  0,
@@ -1051,17 +1051,17 @@ cs46xx_dsp_create_output_snoop_scb(struct snd_cs46xx * chip, char * scb_name, u3
 			0,
 			0
 		},
-    
+
 		0,0,
 		0,0,
-    
+
 		RSCONFIG_SAMPLE_16STEREO + RSCONFIG_MODULO_64,
-		snoop_buffer_address << 0x10,  
+		snoop_buffer_address << 0x10,
 		0,0,
 		0,
 		0,snoop_scb->address
 	};
-  
+
 	scb = cs46xx_dsp_create_generic_scb(chip,scb_name,(u32 *)&output_snoop_scb,
 					    dest,"OUTPUTSNOOP",parent_scb,
 					    scb_child_type);
@@ -1070,13 +1070,13 @@ cs46xx_dsp_create_output_snoop_scb(struct snd_cs46xx * chip, char * scb_name, u3
 #endif /* not used */
 
 
-struct dsp_scb_descriptor * 
-cs46xx_dsp_create_spio_write_scb(struct snd_cs46xx * chip, char * scb_name, u32 dest,
-                                 struct dsp_scb_descriptor * parent_scb,
+struct dsp_scb_descriptor *
+cs46xx_dsp_create_spio_write_scb(struct snd_cs46xx *chip, char *scb_name, u32 dest,
+                                 struct dsp_scb_descriptor *parent_scb,
                                  int scb_child_type)
 {
-	struct dsp_scb_descriptor * scb;
-  
+	struct dsp_scb_descriptor *scb;
+
 	struct dsp_spio_write_scb spio_write_scb = {
 		0,0,         /*   SPIOWAddress2:SPIOWAddress1; */
 		0,           /*   SPIOWData1; */
@@ -1086,11 +1086,11 @@ cs46xx_dsp_create_spio_write_scb(struct snd_cs46xx * chip, char * scb_name, u32
 		0,           /*   SPIOWData4; */
 		0,0,         /*   SPIOWDataPtr:Unused1; */
 		{ 0,0 },     /*   Unused2[2]; */
-    
+
 		0,0,	     /*   SPIOWChildPtr:SPIOWSiblingPtr; */
 		0,0,         /*   SPIOWThisPtr:SPIOWEntryPoint; */
-    
-		{ 
+
+		{
 			0,
 			0,
 			0,
@@ -1107,14 +1107,14 @@ cs46xx_dsp_create_spio_write_scb(struct snd_cs46xx * chip, char * scb_name, u32
 }
 
 struct dsp_scb_descriptor *
-cs46xx_dsp_create_magic_snoop_scb(struct snd_cs46xx * chip, char * scb_name, u32 dest,
+cs46xx_dsp_create_magic_snoop_scb(struct snd_cs46xx *chip, char *scb_name, u32 dest,
 				  u16 snoop_buffer_address,
 				  struct dsp_scb_descriptor * snoop_scb,
-				  struct dsp_scb_descriptor * parent_scb,
+				  struct dsp_scb_descriptor *parent_scb,
 				  int scb_child_type)
 {
-	struct dsp_scb_descriptor * scb;
-  
+	struct dsp_scb_descriptor *scb;
+
 	struct dsp_magic_snoop_task magic_snoop_scb = {
 		/* 0 */ 0, /* i0 */
 		/* 1 */ 0, /* i1 */
@@ -1143,10 +1143,10 @@ cs46xx_dsp_create_magic_snoop_scb(struct snd_cs46xx * chip, char * scb_name, u32
 }
 
 static struct dsp_scb_descriptor *
-find_next_free_scb (struct snd_cs46xx * chip, struct dsp_scb_descriptor * from)
+find_next_free_scb(struct snd_cs46xx *chip, struct dsp_scb_descriptor *from)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
-	struct dsp_scb_descriptor * scb = from;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
+	struct dsp_scb_descriptor *scb = from;
 
 	while (scb->next_scb_ptr != ins->the_null_scb) {
 		if (snd_BUG_ON(!scb->next_scb_ptr))
@@ -1198,9 +1198,9 @@ static u32 src_output_buffer_addr[DSP_MAX_SRC_NR] = {
 	0x2BA0,
 	0x2BC0,
 	0x2BE0,
-	0x2D00,  
-	0x2D20,  
-	0x2D40,  
+	0x2D00,
+	0x2D20,
+	0x2D40,
 	0x2D60,
 	0x2D80,
 	0x2DA0,
@@ -1228,16 +1228,16 @@ static u32 src_delay_buffer_addr[DSP_MAX_SRC_NR] = {
 };
 
 struct dsp_pcm_channel_descriptor *
-cs46xx_dsp_create_pcm_channel (struct snd_cs46xx * chip,
-			       u32 sample_rate, void * private_data, 
+cs46xx_dsp_create_pcm_channel(struct snd_cs46xx *chip,
+			       u32 sample_rate, void * private_data,
 			       u32 hw_dma_addr,
 			       int pcm_channel_id)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
-	struct dsp_scb_descriptor * src_scb = NULL, * pcm_scb, * mixer_scb = NULL;
-	struct dsp_scb_descriptor * src_parent_scb = NULL;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
+	struct dsp_scb_descriptor *src_scb = NULL, *pcm_scb, *mixer_scb = NULL;
+	struct dsp_scb_descriptor *src_parent_scb = NULL;
 
-	/* struct dsp_scb_descriptor * pcm_parent_scb; */
+	/* struct dsp_scb_descriptor *pcm_parent_scb; */
 	char scb_name[DSP_MAX_SCB_NAME];
 	int i, pcm_index = -1, insert_point, src_index = -1, pass_through = 0;
 	unsigned long flags;
@@ -1278,19 +1278,19 @@ cs46xx_dsp_create_pcm_channel (struct snd_cs46xx * chip,
 	if (!sample_rate) sample_rate = 44100;
 
 	/* search for a already created SRC SCB with the same sample rate */
-	for (i = 0; i < DSP_MAX_PCM_CHANNELS && 
+	for (i = 0; i < DSP_MAX_PCM_CHANNELS &&
 		     (pcm_index == -1 || src_scb == NULL); ++i) {
 
-		/* virtual channel reserved 
+		/* virtual channel reserved
 		   for capture */
 		if (i == CS46XX_DSP_CAPTURE_CHANNEL) continue;
 
 		if (ins->pcm_channels[i].active) {
-			if (!src_scb && 
+			if (!src_scb &&
 			    ins->pcm_channels[i].sample_rate == sample_rate &&
 			    ins->pcm_channels[i].mixer_scb == mixer_scb) {
 				src_scb = ins->pcm_channels[i].src_scb;
-				ins->pcm_channels[i].src_scb->ref_count ++;
+				ins->pcm_channels[i].src_scb->ref_count++;
 				src_index = ins->pcm_channels[i].src_slot;
 			}
 		} else if (pcm_index == -1) {
@@ -1330,7 +1330,7 @@ cs46xx_dsp_create_pcm_channel (struct snd_cs46xx * chip,
 		}
 
 		snprintf (scb_name,DSP_MAX_SCB_NAME,"SrcTask_SCB%d",src_index);
-		
+
 		snd_printdd( "dsp_spos: creating SRC \"%s\"\n",scb_name);
 		src_scb = cs46xx_dsp_create_src_task_scb(chip,scb_name,
 							 sample_rate,
@@ -1349,10 +1349,10 @@ cs46xx_dsp_create_pcm_channel (struct snd_cs46xx * chip,
 
 		/* cs46xx_dsp_set_src_sample_rate(chip,src_scb,sample_rate); */
 
-		ins->nsrc_scb ++;
-	} 
-  
-  
+		ins->nsrc_scb++;
+	}
+
+
 	snprintf (scb_name,DSP_MAX_SCB_NAME,"PCMReader_SCB%d",pcm_index);
 
 	snd_printdd( "dsp_spos: creating PCM \"%s\" (%d)\n",scb_name,
@@ -1365,14 +1365,14 @@ cs46xx_dsp_create_pcm_channel (struct snd_cs46xx * chip,
 						   pcm_index,    /* virtual channel 0-31 */
 						   hw_dma_addr,  /* pcm hw addr */
                            NULL,         /* parent SCB ptr */
-                           0             /* insert point */ 
-                           );
+                           0             /* insert point */
+                          );
 
 	if (!pcm_scb) {
 		snd_printk (KERN_ERR "dsp_spos: failed to create PCMreaderSCB\n");
 		return NULL;
 	}
-	
+
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	ins->pcm_channels[pcm_index].sample_rate = sample_rate;
 	ins->pcm_channels[pcm_index].pcm_reader_scb = pcm_scb;
@@ -1383,14 +1383,14 @@ cs46xx_dsp_create_pcm_channel (struct snd_cs46xx * chip,
 	ins->pcm_channels[pcm_index].active = 1;
 	ins->pcm_channels[pcm_index].pcm_slot = pcm_index;
 	ins->pcm_channels[pcm_index].mixer_scb = mixer_scb;
-	ins->npcm_channels ++;
+	ins->npcm_channels++;
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 
 	return (ins->pcm_channels + pcm_index);
 }
 
-int cs46xx_dsp_pcm_channel_set_period (struct snd_cs46xx * chip,
-				       struct dsp_pcm_channel_descriptor * pcm_channel,
+int cs46xx_dsp_pcm_channel_set_period(struct snd_cs46xx *chip,
+				       struct dsp_pcm_channel_descriptor *pcm_channel,
 				       int period_size)
 {
 	u32 temp = snd_cs46xx_peek (chip,pcm_channel->pcm_reader_scb->address << 2);
@@ -1414,10 +1414,10 @@ int cs46xx_dsp_pcm_channel_set_period (struct snd_cs46xx * chip,
 		break;
 	case 64:
 		temp |= DMA_RQ_C1_SOURCE_MOD32;
-		break;		      
+		break;
 	case 32:
 		temp |= DMA_RQ_C1_SOURCE_MOD16;
-		break; 
+		break;
 	default:
 		snd_printdd ("period size (%d) not supported by HW\n", period_size);
 		return -EINVAL;
@@ -1428,7 +1428,7 @@ int cs46xx_dsp_pcm_channel_set_period (struct snd_cs46xx * chip,
 	return 0;
 }
 
-int cs46xx_dsp_pcm_ostream_set_period (struct snd_cs46xx * chip,
+int cs46xx_dsp_pcm_ostream_set_period(struct snd_cs46xx *chip,
 				       int period_size)
 {
 	u32 temp = snd_cs46xx_peek (chip,WRITEBACK_SCB_ADDR << 2);
@@ -1452,10 +1452,10 @@ int cs46xx_dsp_pcm_ostream_set_period (struct snd_cs46xx * chip,
 		break;
 	case 64:
 		temp |= DMA_RQ_C1_DEST_MOD32;
-		break;		      
+		break;
 	case 32:
 		temp |= DMA_RQ_C1_DEST_MOD16;
-		break; 
+		break;
 	default:
 		snd_printdd ("period size (%d) not supported by HW\n", period_size);
 		return -EINVAL;
@@ -1466,10 +1466,10 @@ int cs46xx_dsp_pcm_ostream_set_period (struct snd_cs46xx * chip,
 	return 0;
 }
 
-void cs46xx_dsp_destroy_pcm_channel (struct snd_cs46xx * chip,
-				     struct dsp_pcm_channel_descriptor * pcm_channel)
+void cs46xx_dsp_destroy_pcm_channel(struct snd_cs46xx *chip,
+				     struct dsp_pcm_channel_descriptor *pcm_channel)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 	unsigned long flags;
 
 	if (snd_BUG_ON(!pcm_channel->active ||
@@ -1499,8 +1499,8 @@ void cs46xx_dsp_destroy_pcm_channel (struct snd_cs46xx * chip,
 	}
 }
 
-int cs46xx_dsp_pcm_unlink (struct snd_cs46xx * chip,
-			   struct dsp_pcm_channel_descriptor * pcm_channel)
+int cs46xx_dsp_pcm_unlink(struct snd_cs46xx *chip,
+			   struct dsp_pcm_channel_descriptor *pcm_channel)
 {
 	unsigned long flags;
 
@@ -1525,12 +1525,12 @@ int cs46xx_dsp_pcm_unlink (struct snd_cs46xx * chip,
 	return 0;
 }
 
-int cs46xx_dsp_pcm_link (struct snd_cs46xx * chip,
-			 struct dsp_pcm_channel_descriptor * pcm_channel)
+int cs46xx_dsp_pcm_link(struct snd_cs46xx *chip,
+			 struct dsp_pcm_channel_descriptor *pcm_channel)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
-	struct dsp_scb_descriptor * parent_scb;
-	struct dsp_scb_descriptor * src_scb = pcm_channel->src_scb;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
+	struct dsp_scb_descriptor *parent_scb;
+	struct dsp_scb_descriptor *src_scb = pcm_channel->src_scb;
 	unsigned long flags;
 
 	spin_lock(&pcm_channel->src_scb->lock);
@@ -1568,12 +1568,12 @@ int cs46xx_dsp_pcm_link (struct snd_cs46xx * chip,
 }
 
 struct dsp_scb_descriptor *
-cs46xx_add_record_source (struct snd_cs46xx *chip, struct dsp_scb_descriptor * source,
-			  u16 addr, char * scb_name)
+cs46xx_add_record_source(struct snd_cs46xx *chip, struct dsp_scb_descriptor * source,
+			  u16 addr, char *scb_name)
 {
-  	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
-	struct dsp_scb_descriptor * parent;
-	struct dsp_scb_descriptor * pcm_input;
+  	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
+	struct dsp_scb_descriptor *parent;
+	struct dsp_scb_descriptor *pcm_input;
 	int insert_point;
 
 	if (snd_BUG_ON(!ins->record_mixer_scb))
@@ -1594,7 +1594,7 @@ cs46xx_add_record_source (struct snd_cs46xx *chip, struct dsp_scb_descriptor * s
 	return pcm_input;
 }
 
-int cs46xx_src_unlink(struct snd_cs46xx *chip, struct dsp_scb_descriptor * src)
+int cs46xx_src_unlink(struct snd_cs46xx *chip, struct dsp_scb_descriptor *src)
 {
 	if (snd_BUG_ON(!src->parent_scb_ptr))
 		return -EINVAL;
@@ -1607,10 +1607,10 @@ int cs46xx_src_unlink(struct snd_cs46xx *chip, struct dsp_scb_descriptor * src)
 	return 0;
 }
 
-int cs46xx_src_link(struct snd_cs46xx *chip, struct dsp_scb_descriptor * src)
+int cs46xx_src_link(struct snd_cs46xx *chip, struct dsp_scb_descriptor *src)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
-	struct dsp_scb_descriptor * parent_scb;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
+	struct dsp_scb_descriptor *parent_scb;
 
 	if (snd_BUG_ON(src->parent_scb_ptr))
 		return -EINVAL;
@@ -1629,20 +1629,20 @@ int cs46xx_src_link(struct snd_cs46xx *chip, struct dsp_scb_descriptor * src)
 
 	/* update entry in DSP RAM */
 	cs46xx_dsp_spos_update_scb(chip,parent_scb);
-  
+
 	return 0;
 }
 
-int cs46xx_dsp_enable_spdif_out (struct snd_cs46xx *chip)
+int cs46xx_dsp_enable_spdif_out(struct snd_cs46xx *chip)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 
-	if ( ! (ins->spdif_status_out & DSP_SPDIF_STATUS_HW_ENABLED) ) {
+	if (!(ins->spdif_status_out & DSP_SPDIF_STATUS_HW_ENABLED)) {
 		cs46xx_dsp_enable_spdif_hw (chip);
 	}
 
 	/* dont touch anything if SPDIF is open */
-	if ( ins->spdif_status_out & DSP_SPDIF_STATUS_PLAYBACK_OPEN) {
+	if (ins->spdif_status_out & DSP_SPDIF_STATUS_PLAYBACK_OPEN) {
 		/* when cs46xx_iec958_post_close(...) is called it
 		   will call this function if necessary depending on
 		   this bit */
@@ -1659,8 +1659,8 @@ int cs46xx_dsp_enable_spdif_out (struct snd_cs46xx *chip)
 
 	/* reset output snooper sample buffer pointer */
 	snd_cs46xx_poke (chip, (ins->ref_snoop_scb->address + 2) << 2,
-			 (OUTPUT_SNOOP_BUFFER + 0x10) << 0x10 );
-	
+			 (OUTPUT_SNOOP_BUFFER + 0x10) << 0x10);
+
 	/* The asynch. transfer task */
 	ins->asynch_tx_scb = cs46xx_dsp_create_asynch_fg_tx_scb(chip,"AsynchFGTxSCB",ASYNCTX_SCB_ADDR,
 								SPDIFO_SCB_INST,
@@ -1674,8 +1674,8 @@ int cs46xx_dsp_enable_spdif_out (struct snd_cs46xx *chip)
 									  ins->ref_snoop_scb,
 									  ins->asynch_tx_scb,
 									  SCB_ON_PARENT_SUBLIST_SCB);
-  
-	
+
+
 	if (!ins->spdif_pcm_input_scb) return -ENOMEM;
 
 	/* monitor state */
@@ -1684,12 +1684,12 @@ int cs46xx_dsp_enable_spdif_out (struct snd_cs46xx *chip)
 	return 0;
 }
 
-int  cs46xx_dsp_disable_spdif_out (struct snd_cs46xx *chip)
+int  cs46xx_dsp_disable_spdif_out(struct snd_cs46xx *chip)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 
 	/* dont touch anything if SPDIF is open */
-	if ( ins->spdif_status_out & DSP_SPDIF_STATUS_PLAYBACK_OPEN) {
+	if (ins->spdif_status_out & DSP_SPDIF_STATUS_PLAYBACK_OPEN) {
 		ins->spdif_status_out &= ~DSP_SPDIF_STATUS_OUTPUT_ENABLED;
 		return -EBUSY;
 	}
@@ -1723,18 +1723,18 @@ int  cs46xx_dsp_disable_spdif_out (struct snd_cs46xx *chip)
 
 int cs46xx_iec958_pre_open (struct snd_cs46xx *chip)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 
-	if ( ins->spdif_status_out & DSP_SPDIF_STATUS_OUTPUT_ENABLED ) {
+	if (ins->spdif_status_out & DSP_SPDIF_STATUS_OUTPUT_ENABLED) {
 		/* remove AsynchFGTxSCB and and PCMSerialInput_II */
 		cs46xx_dsp_disable_spdif_out (chip);
 
 		/* save state */
 		ins->spdif_status_out |= DSP_SPDIF_STATUS_OUTPUT_ENABLED;
 	}
-	
+
 	/* if not enabled already */
-	if ( !(ins->spdif_status_out & DSP_SPDIF_STATUS_HW_ENABLED) ) {
+	if (!(ins->spdif_status_out & DSP_SPDIF_STATUS_HW_ENABLED)) {
 		cs46xx_dsp_enable_spdif_hw (chip);
 	}
 
@@ -1754,9 +1754,9 @@ int cs46xx_iec958_pre_open (struct snd_cs46xx *chip)
 	return 0;
 }
 
-int cs46xx_iec958_post_close (struct snd_cs46xx *chip)
+int cs46xx_iec958_post_close(struct snd_cs46xx *chip)
 {
-	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	struct dsp_spos_instance *ins = chip->dsp_spos_instance;
 
 	if (snd_BUG_ON(!ins->asynch_tx_scb))
 		return -EINVAL;
@@ -1765,7 +1765,7 @@ int cs46xx_iec958_post_close (struct snd_cs46xx *chip)
 
 	/* restore settings */
 	cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, ins->spdif_csuv_default);
-	
+
 	/* deallocate stuff */
 	if (ins->spdif_pcm_input_scb != NULL) {
 		cs46xx_dsp_remove_scb (chip,ins->spdif_pcm_input_scb);
@@ -1779,9 +1779,9 @@ int cs46xx_iec958_post_close (struct snd_cs46xx *chip)
 	_dsp_clear_sample_buffer(chip,SPDIFO_IP_OUTPUT_BUFFER1,256);
 
 	/* restore state */
-	if ( ins->spdif_status_out & DSP_SPDIF_STATUS_OUTPUT_ENABLED ) {
+	if (ins->spdif_status_out & DSP_SPDIF_STATUS_OUTPUT_ENABLED) {
 		cs46xx_dsp_enable_spdif_out (chip);
 	}
-	
+
 	return 0;
 }
diff --git a/sound/pci/cs46xx/imgs/cwcbinhack.h b/sound/pci/cs46xx/imgs/cwcbinhack.h
index f4d9368..0587ab3 100644
--- a/sound/pci/cs46xx/imgs/cwcbinhack.h
+++ b/sound/pci/cs46xx/imgs/cwcbinhack.h
@@ -1,4 +1,4 @@
-/* generated by Benny 
+/* generated by Benny
    MODIFY ON YOUR OWN RISK */
 
 #ifndef __HEADER_cwcbinhack_H__
