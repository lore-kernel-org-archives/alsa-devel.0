From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 24/24] sound/pci: coding style fixes: ymfpci
Date: Tue, 9 Sep 2008 06:03:32 +0400
Message-ID: <20080909020332.GA6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DA8C103855
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 04:03:37 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id b27so1407608fka.0
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 19:03:37 -0700 (PDT)
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

 sound/pci/ymfpci/ymfpci_main.c |   98 ++++++++++++++++++++--------------------
 1 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index 90d0d62..baf64b9 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -36,7 +36,7 @@
 #include <sound/asoundef.h>
 #include <sound/mpu401.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/byteorder.h>
 
 /*
@@ -79,7 +79,7 @@ static int snd_ymfpci_codec_ready(struct snd_ymfpci *chip, int secondary)
 {
 	unsigned long end_time;
 	u32 reg = secondary ? YDSXGR_SECSTATUSADR : YDSXGR_PRISTATUSADR;
-	
+
 	end_time = jiffies + msecs_to_jiffies(750);
 	do {
 		if ((snd_ymfpci_readw(chip, reg) & 0x8000) == 0)
@@ -94,7 +94,7 @@ static void snd_ymfpci_codec_write(struct snd_ac97 *ac97, u16 reg, u16 val)
 {
 	struct snd_ymfpci *chip = ac97->private_data;
 	u32 cmd;
-	
+
 	snd_ymfpci_codec_ready(chip, 0);
 	cmd = ((YDSXG_AC97WRITECMD | reg) << 16) | val;
 	snd_ymfpci_writel(chip, YDSXGR_AC97CMDDATA, cmd);
@@ -145,7 +145,7 @@ static u32 snd_ymfpci_calc_lpfK(u32 rate)
 		0x00570000, 0x06AA0000, 0x18B20000, 0x20930000,
 		0x2B9A0000, 0x35A10000, 0x3EAA0000, 0x40000000
 	};
-	
+
 	if (rate == 44100)
 		return 0x40000000;	/* FIXME: What's the right value? */
 	for (i = 0; i < 8; i++)
@@ -161,7 +161,7 @@ static u32 snd_ymfpci_calc_lpfQ(u32 rate)
 		0x35280000, 0x34A70000, 0x32020000, 0x31770000,
 		0x31390000, 0x31C90000, 0x33D00000, 0x40000000
 	};
-	
+
 	if (rate == 44100)
 		return 0x370A0000;
 	for (i = 0; i < 8; i++)
@@ -184,7 +184,7 @@ static void snd_ymfpci_hw_start(struct snd_ymfpci *chip)
 	snd_ymfpci_writel(chip, YDSXGR_MODE,
 			  snd_ymfpci_readl(chip, YDSXGR_MODE) | 3);
 	chip->active_bank = snd_ymfpci_readl(chip, YDSXGR_CTRLSELECT) & 1;
-      __end:
+__end:
       	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
 
@@ -206,7 +206,7 @@ static void snd_ymfpci_hw_stop(struct snd_ymfpci *chip)
 		atomic_set(&chip->interrupt_sleep_count, 0);
 		wake_up(&chip->interrupt_sleep);
 	}
-      __end:
+__end:
       	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
 
@@ -220,7 +220,7 @@ static int voice_alloc(struct snd_ymfpci *chip,
 {
 	struct snd_ymfpci_voice *voice, *voice2;
 	int idx;
-	
+
 	*rvoice = NULL;
 	for (idx = 0; idx < YDSXG_PLAYBACK_VOICES; idx += pair ? 2 : 1) {
 		voice = &chip->voices[idx];
@@ -258,12 +258,12 @@ static int snd_ymfpci_voice_alloc(struct snd_ymfpci *chip,
 {
 	unsigned long flags;
 	int result;
-	
+
 	if (snd_BUG_ON(!rvoice))
 		return -EINVAL;
 	if (snd_BUG_ON(pair && type != YMFPCI_PCM))
 		return -EINVAL;
-	
+
 	spin_lock_irqsave(&chip->voice_lock, flags);
 	for (;;) {
 		result = voice_alloc(chip, type, pair, rvoice);
@@ -272,14 +272,14 @@ static int snd_ymfpci_voice_alloc(struct snd_ymfpci *chip,
 		/* TODO: synth/midi voice deallocation */
 		break;
 	}
-	spin_unlock_irqrestore(&chip->voice_lock, flags);	
-	return result;		
+	spin_unlock_irqrestore(&chip->voice_lock, flags);
+	return result;
 }
 
 static int snd_ymfpci_voice_free(struct snd_ymfpci *chip, struct snd_ymfpci_voice *pvoice)
 {
 	unsigned long flags;
-	
+
 	if (snd_BUG_ON(!pvoice))
 		return -EINVAL;
 	snd_ymfpci_hw_stop(chip);
@@ -303,7 +303,7 @@ static void snd_ymfpci_pcm_interrupt(struct snd_ymfpci *chip, struct snd_ymfpci_
 {
 	struct snd_ymfpci_pcm *ypcm;
 	u32 pos, delta;
-	
+
 	if ((ypcm = voice->ypcm) == NULL)
 		return;
 	if (ypcm->substream == NULL)
@@ -318,7 +318,7 @@ static void snd_ymfpci_pcm_interrupt(struct snd_ymfpci *chip, struct snd_ymfpci_
 		ypcm->period_pos += delta;
 		ypcm->last_pos = pos;
 		if (ypcm->period_pos >= ypcm->period_size) {
-			// printk("done - active_bank = 0x%x, start = 0x%x\n", chip->active_bank, voice->bank[chip->active_bank].start);
+			/* printk("done - active_bank = 0x%x, start = 0x%x\n", chip->active_bank, voice->bank[chip->active_bank].start); */
 			ypcm->period_pos %= ypcm->period_size;
 			spin_unlock(&chip->reg_lock);
 			snd_pcm_period_elapsed(ypcm->substream);
@@ -330,7 +330,7 @@ static void snd_ymfpci_pcm_interrupt(struct snd_ymfpci *chip, struct snd_ymfpci_
 			unsigned int next_bank = 1 - chip->active_bank;
 			struct snd_ymfpci_playback_bank *bank;
 			u32 volume;
-			
+
 			bank = &voice->bank[next_bank];
 			volume = cpu_to_le32(chip->pcm_mixer[subs].left << 15);
 			bank->left_gain_end = volume;
@@ -354,7 +354,7 @@ static void snd_ymfpci_pcm_capture_interrupt(struct snd_pcm_substream *substream
 	struct snd_ymfpci_pcm *ypcm = runtime->private_data;
 	struct snd_ymfpci *chip = ypcm->chip;
 	u32 pos, delta;
-	
+
 	spin_lock(&chip->reg_lock);
 	if (ypcm->running) {
 		pos = le32_to_cpu(chip->bank_capture[ypcm->capture_bank_number][chip->active_bank]->start) >> ypcm->shift;
@@ -366,7 +366,7 @@ static void snd_ymfpci_pcm_capture_interrupt(struct snd_pcm_substream *substream
 		ypcm->last_pos = pos;
 		if (ypcm->period_pos >= ypcm->period_size) {
 			ypcm->period_pos %= ypcm->period_size;
-			// printk("done - active_bank = 0x%x, start = 0x%x\n", chip->active_bank, voice->bank[chip->active_bank].start);
+			/* printk("done - active_bank = 0x%x, start = 0x%x\n", chip->active_bank, voice->bank[chip->active_bank].start); */
 			spin_unlock(&chip->reg_lock);
 			snd_pcm_period_elapsed(substream);
 			spin_lock(&chip->reg_lock);
@@ -414,7 +414,7 @@ static int snd_ymfpci_playback_trigger(struct snd_pcm_substream *substream,
 		result = -EINVAL;
 		break;
 	}
-      __unlock:
+__unlock:
 	spin_unlock(&chip->reg_lock);
 	if (kctl)
 		snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_INFO, &kctl->id);
@@ -468,7 +468,7 @@ static int snd_ymfpci_pcm_voice_alloc(struct snd_ymfpci_pcm *ypcm, int voices)
 		if (ypcm->voices[0] != NULL && ypcm->voices[1] == NULL) {
 			snd_ymfpci_voice_free(ypcm->chip, ypcm->voices[0]);
 			ypcm->voices[0] = NULL;
-		}		
+		}
 	}
 	err = snd_ymfpci_voice_alloc(ypcm->chip, YMFPCI_PCM, voices > 1, &ypcm->voices[0]);
 	if (err < 0)
@@ -615,7 +615,7 @@ static int snd_ymfpci_ac3_done(struct snd_ymfpci *chip)
 	snd_ymfpci_writel(chip, YDSXGR_MAPOFEFFECT,
 			  snd_ymfpci_readl(chip, YDSXGR_MAPOFEFFECT) & ~(3 << 3));
 	spin_unlock_irq(&chip->reg_lock);
-	// snd_ymfpci_irq_wait(chip);
+	/* snd_ymfpci_irq_wait(chip); */
 	if (chip->ac3_tmp_base.area) {
 		snd_dma_free_pages(&chip->ac3_tmp_base);
 		chip->ac3_tmp_base.area = NULL;
@@ -642,7 +642,7 @@ static int snd_ymfpci_playback_hw_free(struct snd_pcm_substream *substream)
 	struct snd_ymfpci *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_ymfpci_pcm *ypcm;
-	
+
 	if (runtime->private_data == NULL)
 		return 0;
 	ypcm = runtime->private_data;
@@ -836,7 +836,7 @@ static irqreturn_t snd_ymfpci_interrupt(int irq, void *dev_id)
 static struct snd_pcm_hardware snd_ymfpci_playback =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP |
-				 SNDRV_PCM_INFO_MMAP_VALID | 
+				 SNDRV_PCM_INFO_MMAP_VALID |
 				 SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_PAUSE |
@@ -905,8 +905,8 @@ static int snd_ymfpci_playback_open_1(struct snd_pcm_substream *substream)
 /* call with spinlock held */
 static void ymfpci_open_extension(struct snd_ymfpci *chip)
 {
-	if (! chip->rear_opened) {
-		if (! chip->spdif_opened) /* set AC3 */
+	if (!chip->rear_opened) {
+		if (!chip->spdif_opened) /* set AC3 */
 			snd_ymfpci_writel(chip, YDSXGR_MODE,
 					  snd_ymfpci_readl(chip, YDSXGR_MODE) | (1 << 30));
 		/* enable second codec (4CHEN) */
@@ -918,8 +918,8 @@ static void ymfpci_open_extension(struct snd_ymfpci *chip)
 /* call with spinlock held */
 static void ymfpci_close_extension(struct snd_ymfpci *chip)
 {
-	if (! chip->rear_opened) {
-		if (! chip->spdif_opened)
+	if (!chip->rear_opened) {
+		if (!chip->spdif_opened)
 			snd_ymfpci_writel(chip, YDSXGR_MODE,
 					  snd_ymfpci_readl(chip, YDSXGR_MODE) & ~(1 << 30));
 		snd_ymfpci_writew(chip, YDSXGR_SECCONFIG,
@@ -933,7 +933,7 @@ static int snd_ymfpci_playback_open(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_ymfpci_pcm *ypcm;
 	int err;
-	
+
 	if ((err = snd_ymfpci_playback_open_1(substream)) < 0)
 		return err;
 	ypcm = runtime->private_data;
@@ -955,7 +955,7 @@ static int snd_ymfpci_playback_spdif_open(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_ymfpci_pcm *ypcm;
 	int err;
-	
+
 	if ((err = snd_ymfpci_playback_open_1(substream)) < 0)
 		return err;
 	ypcm = runtime->private_data;
@@ -983,7 +983,7 @@ static int snd_ymfpci_playback_4ch_open(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_ymfpci_pcm *ypcm;
 	int err;
-	
+
 	if ((err = snd_ymfpci_playback_open_1(substream)) < 0)
 		return err;
 	ypcm = runtime->private_data;
@@ -1009,7 +1009,7 @@ static int snd_ymfpci_capture_open(struct snd_pcm_substream *substream,
 		return -ENOMEM;
 	ypcm->chip = chip;
 	ypcm->type = capture_bank_number + CAPTURE_REC;
-	ypcm->substream = substream;	
+	ypcm->substream = substream;
 	ypcm->capture_bank_number = capture_bank_number;
 	chip->capture_substream[capture_bank_number] = substream;
 	runtime->hw = snd_ymfpci_capture;
@@ -1449,7 +1449,7 @@ static int snd_ymfpci_get_single(struct snd_kcontrol *kcontrol,
 	int reg = kcontrol->private_value & 0xffff;
 	unsigned int shift = (kcontrol->private_value >> 16) & 0xff;
 	unsigned int mask = 1;
-	
+
 	switch (reg) {
 	case YDSXGR_SPDIFOUTCTRL: break;
 	case YDSXGR_SPDIFINCTRL: break;
@@ -1469,7 +1469,7 @@ static int snd_ymfpci_put_single(struct snd_kcontrol *kcontrol,
  	unsigned int mask = 1;
 	int change;
 	unsigned int val, oval;
-	
+
 	switch (reg) {
 	case YDSXGR_SPDIFOUTCTRL: break;
 	case YDSXGR_SPDIFINCTRL: break;
@@ -1515,7 +1515,7 @@ static int snd_ymfpci_get_double(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 	unsigned int reg = kcontrol->private_value;
 	unsigned int shift_left = 0, shift_right = 16, mask = 16383;
 	unsigned int val;
-	
+
 	if (reg < 0x80 || reg >= 0xc0)
 		return -EINVAL;
 	spin_lock_irq(&chip->reg_lock);
@@ -1533,7 +1533,7 @@ static int snd_ymfpci_put_double(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 	unsigned int shift_left = 0, shift_right = 16, mask = 16383;
 	int change;
 	unsigned int val1, val2, oval;
-	
+
 	if (reg < 0x80 || reg >= 0xc0)
 		return -EINVAL;
 	val1 = ucontrol->value.integer.value[0] & mask;
@@ -1557,7 +1557,7 @@ static int snd_ymfpci_put_nativedacvol(struct snd_kcontrol *kcontrol,
 	unsigned int reg2 = YDSXGR_BUF441OUTVOL;
 	int change;
 	unsigned int value, oval;
-	
+
 	value = ucontrol->value.integer.value[0] & 0x3fff;
 	value |= (ucontrol->value.integer.value[1] & 0x3fff) << 16;
 	spin_lock_irq(&chip->reg_lock);
@@ -1937,12 +1937,12 @@ int __devinit snd_ymfpci_timer(struct snd_ymfpci *chip, int device)
  *  proc interface
  */
 
-static void snd_ymfpci_proc_read(struct snd_info_entry *entry, 
+static void snd_ymfpci_proc_read(struct snd_info_entry *entry,
 				 struct snd_info_buffer *buffer)
 {
 	struct snd_ymfpci *chip = entry->private_data;
 	int i;
-	
+
 	snd_iprintf(buffer, "YMFPCI\n\n");
 	for (i = 0; i <= YDSXGR_WORKBASE; i += 4)
 		snd_iprintf(buffer, "%04x: %04x\n", i, snd_ymfpci_readl(chip, i));
@@ -1951,8 +1951,8 @@ static void snd_ymfpci_proc_read(struct snd_info_entry *entry,
 static int __devinit snd_ymfpci_proc_init(struct snd_card *card, struct snd_ymfpci *chip)
 {
 	struct snd_info_entry *entry;
-	
-	if (! snd_card_proc_new(card, "ymfpci", &entry))
+
+	if (!snd_card_proc_new(card, "ymfpci", &entry))
 		snd_info_set_text_ops(entry, chip, snd_ymfpci_proc_read);
 	return 0;
 }
@@ -1966,7 +1966,7 @@ static void snd_ymfpci_aclink_reset(struct pci_dev * pci)
 	u8 cmd;
 
 	pci_read_config_byte(pci, PCIR_DSXG_CTRL, &cmd);
-#if 0 // force to reset
+#if 0 /* force to reset */
 	if (cmd & 0x03) {
 #endif
 		pci_write_config_byte(pci, PCIR_DSXG_CTRL, cmd & 0xfc);
@@ -2082,7 +2082,7 @@ static int __devinit snd_ymfpci_memalloc(struct snd_ymfpci *chip)
 	chip->bank_size_capture = snd_ymfpci_readl(chip, YDSXGR_RECCTRLSIZE) << 2;
 	chip->bank_size_effect = snd_ymfpci_readl(chip, YDSXGR_EFFCTRLSIZE) << 2;
 	chip->work_size = YDSXG_DEFAULT_WORK_SIZE;
-	
+
 	size = ALIGN(playback_ctrl_size, 0x100) +
 	       ALIGN(chip->bank_size_playback * 2 * YDSXG_PLAYBACK_VOICES, 0x100) +
 	       ALIGN(chip->bank_size_capture * 2 * YDSXG_CAPTURE_VOICES, 0x100) +
@@ -2091,7 +2091,7 @@ static int __devinit snd_ymfpci_memalloc(struct snd_ymfpci *chip)
 	/* work_ptr must be aligned to 256 bytes, but it's already
 	   covered with the kernel page allocation mechanism */
 	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(chip->pci),
-				size, &chip->work_ptr) < 0) 
+				size, &chip->work_ptr) < 0)
 		return -ENOMEM;
 	ptr = chip->work_ptr.area;
 	ptr_addr = chip->work_ptr.addr;
@@ -2137,7 +2137,7 @@ static int __devinit snd_ymfpci_memalloc(struct snd_ymfpci *chip)
 	ptr_addr = ALIGN(ptr_addr, 0x100);
 	chip->work_base = ptr;
 	chip->work_base_addr = ptr_addr;
-	
+
 	snd_BUG_ON(ptr + chip->work_size !=
 		   chip->work_ptr.area + chip->work_ptr.bytes);
 
@@ -2166,7 +2166,7 @@ static int __devinit snd_ymfpci_memalloc(struct snd_ymfpci *chip)
 	snd_ymfpci_writel(chip, YDSXGR_NATIVEDACINVOL, 0x3fff3fff);
 	snd_ymfpci_writel(chip, YDSXGR_PRIADCLOOPVOL, 0x3fff3fff);
 	snd_ymfpci_writel(chip, YDSXGR_LEGACYOUTVOL, 0x3fff3fff);
-	
+
 	return 0;
 }
 
@@ -2214,11 +2214,11 @@ static int snd_ymfpci_free(struct snd_ymfpci *chip)
 		iounmap(chip->reg_area_virt);
 	if (chip->work_ptr.area)
 		snd_dma_free_pages(&chip->work_ptr);
-	
+
 	release_and_free_resource(chip->res_reg_area);
 
 	pci_write_config_word(chip->pci, 0x40, chip->old_legacy_ctrl);
-	
+
 	pci_disable_device(chip->pci);
 	release_firmware(chip->dsp_microcode);
 	release_firmware(chip->controller_microcode);
@@ -2267,7 +2267,7 @@ int snd_ymfpci_suspend(struct pci_dev *pci, pm_message_t state)
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct snd_ymfpci *chip = card->private_data;
 	unsigned int i;
-	
+
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 	snd_pcm_suspend_all(chip->pcm);
 	snd_pcm_suspend_all(chip->pcm2);
@@ -2333,7 +2333,7 @@ int __devinit snd_ymfpci_create(struct snd_card *card,
 	static struct snd_device_ops ops = {
 		.dev_free =	snd_ymfpci_dev_free,
 	};
-	
+
 	*rchip = NULL;
 
 	/* enable PCI device */
