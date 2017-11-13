From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/4] ALSA: cs46xx: Adjust 33 function calls
 together with a variable assignment
Date: Mon, 13 Nov 2017 19:22:30 +0100
Message-ID: <5da69abe-0bcd-e2c3-cb11-04b44b4f8bd2@users.sourceforge.net>
References: <893b1dc2-d078-9ea6-4ad2-0e0327affddd@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id A08B82673B9
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 19:22:41 +0100 (CET)
In-Reply-To: <893b1dc2-d078-9ea6-4ad2-0e0327affddd@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Fabian Frederick <fabf@skynet.be>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 13 Nov 2017 18:50:19 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/cs46xx/cs46xx.c           | 31 ++++++++++------
 sound/pci/cs46xx/cs46xx_lib.c       | 71 ++++++++++++++++++++++++-------------
 sound/pci/cs46xx/dsp_spos.c         | 29 ++++++++++-----
 sound/pci/cs46xx/dsp_spos_scb_lib.c |  7 ++--
 4 files changed, 92 insertions(+), 46 deletions(-)

diff --git a/sound/pci/cs46xx/cs46xx.c b/sound/pci/cs46xx/cs46xx.c
index 655fbea1692c..520478a6e605 100644
--- a/sound/pci/cs46xx/cs46xx.c
+++ b/sound/pci/cs46xx/cs46xx.c
@@ -92,45 +92,53 @@ static int snd_card_cs46xx_probe(struct pci_dev *pci,
 			   0, &card);
 	if (err < 0)
 		return err;
-	if ((err = snd_cs46xx_create(card, pci,
-				     external_amp[dev], thinkpad[dev],
-				     &chip)) < 0) {
+
+	err = snd_cs46xx_create(card, pci, external_amp[dev],
+				thinkpad[dev], &chip);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 	card->private_data = chip;
 	chip->accept_valid = mmap_valid[dev];
-	if ((err = snd_cs46xx_pcm(chip, 0)) < 0) {
+	err = snd_cs46xx_pcm(chip, 0);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
-	if ((err = snd_cs46xx_pcm_rear(chip, 1)) < 0) {
+	err = snd_cs46xx_pcm_rear(chip, 1);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_cs46xx_pcm_iec958(chip, 2)) < 0) {
+	err = snd_cs46xx_pcm_iec958(chip, 2);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 #endif
-	if ((err = snd_cs46xx_mixer(chip, 2)) < 0) {
+	err = snd_cs46xx_mixer(chip, 2);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	if (chip->nr_ac97_codecs ==2) {
-		if ((err = snd_cs46xx_pcm_center_lfe(chip, 3)) < 0) {
+		err = snd_cs46xx_pcm_center_lfe(chip, 3);
+		if (err < 0) {
 			snd_card_free(card);
 			return err;
 		}
 	}
 #endif
-	if ((err = snd_cs46xx_midi(chip, 0)) < 0) {
+	err = snd_cs46xx_midi(chip, 0);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_cs46xx_start_dsp(chip)) < 0) {
+	err = snd_cs46xx_start_dsp(chip);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -146,7 +154,8 @@ static int snd_card_cs46xx_probe(struct pci_dev *pci,
 		chip->ba1_addr,
 		chip->irq);
 
-	if ((err = snd_card_register(card)) < 0) {
+	err = snd_card_register(card);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index 0020fd0efc46..164f86949b2d 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -1071,10 +1071,14 @@ static int _cs46xx_adjust_sample_rate (struct snd_cs46xx *chip, struct snd_cs46x
 	if ((int)cpcm->pcm_channel->sample_rate != sample_rate) {
 		int unlinked = cpcm->pcm_channel->unlinked;
 		cs46xx_dsp_destroy_pcm_channel (chip,cpcm->pcm_channel);
-
-		if ( (cpcm->pcm_channel = cs46xx_dsp_create_pcm_channel (chip, sample_rate, cpcm, 
-									 cpcm->hw_buf.addr,
-									 cpcm->pcm_channel_id)) == NULL) {
+		cpcm
+		->pcm_channel = cs46xx_dsp_create_pcm_channel(chip,
+							      sample_rate,
+							      cpcm,
+							      cpcm->hw_buf.addr,
+							      cpcm
+							      ->pcm_channel_id);
+		if (!cpcm->pcm_channel) {
 			dev_err(chip->card->dev,
 				"failed to re-create virtual PCM channel\n");
 			return -ENOMEM;
@@ -1161,7 +1165,10 @@ static int snd_cs46xx_playback_hw_params(struct snd_pcm_substream *substream,
 			runtime->dma_addr = 0;
 			runtime->dma_bytes = 0;
 		}
-		if ((err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params))) < 0) {
+
+		err = snd_pcm_lib_malloc_pages(substream,
+					       params_buffer_bytes(hw_params));
+		if (err < 0) {
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 			mutex_unlock(&chip->spos_mutex);
 #endif
@@ -1309,7 +1316,10 @@ static int snd_cs46xx_capture_hw_params(struct snd_pcm_substream *substream,
 			runtime->dma_addr = 0;
 			runtime->dma_bytes = 0;
 		}
-		if ((err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params))) < 0)
+
+		err = snd_pcm_lib_malloc_pages(substream,
+					       params_buffer_bytes(hw_params));
+		if (err < 0)
 			return err;
 		substream->ops = &snd_cs46xx_capture_indirect_ops;
 	}
@@ -1780,9 +1790,10 @@ static const struct snd_pcm_ops snd_cs46xx_capture_indirect_ops = {
 int snd_cs46xx_pcm(struct snd_cs46xx *chip, int device)
 {
 	struct snd_pcm *pcm;
-	int err;
+	int err = snd_pcm_new(chip->card, "CS46xx", device,
+			      MAX_PLAYBACK_CHANNELS, 1, &pcm);
 
-	if ((err = snd_pcm_new(chip->card, "CS46xx", device, MAX_PLAYBACK_CHANNELS, 1, &pcm)) < 0)
+	if (err < 0)
 		return err;
 
 	pcm->private_data = chip;
@@ -1806,9 +1817,10 @@ int snd_cs46xx_pcm(struct snd_cs46xx *chip, int device)
 int snd_cs46xx_pcm_rear(struct snd_cs46xx *chip, int device)
 {
 	struct snd_pcm *pcm;
-	int err;
+	int err = snd_pcm_new(chip->card, "CS46xx - Rear",
+			      device, MAX_PLAYBACK_CHANNELS, 0, &pcm);
 
-	if ((err = snd_pcm_new(chip->card, "CS46xx - Rear", device, MAX_PLAYBACK_CHANNELS, 0, &pcm)) < 0)
+	if (err < 0)
 		return err;
 
 	pcm->private_data = chip;
@@ -1829,9 +1841,10 @@ int snd_cs46xx_pcm_rear(struct snd_cs46xx *chip, int device)
 int snd_cs46xx_pcm_center_lfe(struct snd_cs46xx *chip, int device)
 {
 	struct snd_pcm *pcm;
-	int err;
+	int err = snd_pcm_new(chip->card, "CS46xx - Center LFE",
+			      device, MAX_PLAYBACK_CHANNELS, 0, &pcm);
 
-	if ((err = snd_pcm_new(chip->card, "CS46xx - Center LFE", device, MAX_PLAYBACK_CHANNELS, 0, &pcm)) < 0)
+	if (err < 0)
 		return err;
 
 	pcm->private_data = chip;
@@ -1852,9 +1865,10 @@ int snd_cs46xx_pcm_center_lfe(struct snd_cs46xx *chip, int device)
 int snd_cs46xx_pcm_iec958(struct snd_cs46xx *chip, int device)
 {
 	struct snd_pcm *pcm;
-	int err;
+	int err = snd_pcm_new(chip->card, "CS46xx - IEC958",
+			      device, 1, 0, &pcm);
 
-	if ((err = snd_pcm_new(chip->card, "CS46xx - IEC958", device, 1, 0, &pcm)) < 0)
+	if (err < 0)
 		return err;
 
 	pcm->private_data = chip;
@@ -2432,7 +2446,8 @@ static void snd_cs46xx_codec_reset (struct snd_ac97 * ac97)
 
 		/* test if we can write to the record gain volume register */
 		snd_ac97_write(ac97, AC97_REC_GAIN, 0x8a05);
-		if ((err = snd_ac97_read(ac97, AC97_REC_GAIN)) == 0x8a05)
+		err = snd_ac97_read(ac97, AC97_REC_GAIN);
+		if (err == 0x8a05)
 			return;
 
 		msleep(10);
@@ -2494,7 +2509,8 @@ int snd_cs46xx_mixer(struct snd_cs46xx *chip, int spdif_device)
 	/* detect primary codec */
 	chip->nr_ac97_codecs = 0;
 	dev_dbg(chip->card->dev, "detecting primary codec\n");
-	if ((err = snd_ac97_bus(card, 0, &ops, chip, &chip->ac97_bus)) < 0)
+	err = snd_ac97_bus(card, 0, &ops, chip, &chip->ac97_bus);
+	if (err < 0)
 		return err;
 	chip->ac97_bus->private_free = snd_cs46xx_mixer_free_ac97_bus;
 
@@ -2515,7 +2531,9 @@ int snd_cs46xx_mixer(struct snd_cs46xx *chip, int spdif_device)
 		kctl = snd_ctl_new1(&snd_cs46xx_controls[idx], chip);
 		if (kctl && kctl->id.iface == SNDRV_CTL_ELEM_IFACE_PCM)
 			kctl->id.device = spdif_device;
-		if ((err = snd_ctl_add(card, kctl)) < 0)
+
+		err = snd_ctl_add(card, kctl);
+		if (err < 0)
 			return err;
 	}
 
@@ -2700,9 +2718,9 @@ static const struct snd_rawmidi_ops snd_cs46xx_midi_input =
 int snd_cs46xx_midi(struct snd_cs46xx *chip, int device)
 {
 	struct snd_rawmidi *rmidi;
-	int err;
+	int err = snd_rawmidi_new(chip->card, "CS46XX", device, 1, 1, &rmidi);
 
-	if ((err = snd_rawmidi_new(chip->card, "CS46XX", device, 1, 1, &rmidi)) < 0)
+	if (err < 0)
 		return err;
 	strcpy(rmidi->name, "CS46XX");
 	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT, &snd_cs46xx_midi_output);
@@ -3544,7 +3562,8 @@ static void hercules_mixer_init (struct snd_cs46xx *chip)
 		struct snd_kcontrol *kctl;
 
 		kctl = snd_ctl_new1(&snd_hercules_controls[idx], chip);
-		if ((err = snd_ctl_add(card, kctl)) < 0) {
+		err = snd_ctl_add(card, kctl);
+		if (err < 0) {
 			dev_err(card->dev,
 				"failed to initialize Hercules mixer (%d)\n",
 				err);
@@ -3895,7 +3914,8 @@ int snd_cs46xx_create(struct snd_card *card,
 	*rchip = NULL;
 
 	/* enable PCI device */
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
@@ -3989,8 +4009,10 @@ int snd_cs46xx_create(struct snd_card *card,
 
 	for (idx = 0; idx < 5; idx++) {
 		region = &chip->region.idx[idx];
-		if ((region->resource = request_mem_region(region->base, region->size,
-							   region->name)) == NULL) {
+		region->resource = request_mem_region(region->base,
+						      region->size,
+						      region->name);
+		if (!region->resource) {
 			dev_err(chip->card->dev,
 				"unable to request memory region 0x%lx-0x%lx\n",
 				   region->base, region->base + region->size - 1);
@@ -4028,7 +4050,8 @@ int snd_cs46xx_create(struct snd_card *card,
 		return err;
 	}
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0) {
 		snd_cs46xx_free(chip);
 		return err;
 	}
diff --git a/sound/pci/cs46xx/dsp_spos.c b/sound/pci/cs46xx/dsp_spos.c
index aa61615288ff..c30bb557468c 100644
--- a/sound/pci/cs46xx/dsp_spos.c
+++ b/sound/pci/cs46xx/dsp_spos.c
@@ -627,7 +627,9 @@ static void cs46xx_dsp_proc_parameter_dump_read (struct snd_info_entry *entry,
 			col = 0;
 		}
 
-		if ( (symbol = cs46xx_dsp_lookup_symbol_addr (chip,i / sizeof(u32), SYMBOL_PARAMETER)) != NULL) {
+		symbol = cs46xx_dsp_lookup_symbol_addr(chip, i / sizeof(u32),
+						       SYMBOL_PARAMETER);
+		if (symbol) {
 			col = 0;
 			snd_iprintf (buffer,"\n%s:\n",symbol->symbol_name);
 		}
@@ -796,7 +798,8 @@ int cs46xx_dsp_proc_init (struct snd_card *card, struct snd_cs46xx *chip)
 
 	ins->snd_card = card;
 
-	if ((entry = snd_info_create_card_entry(card, "dsp", card->proc_root)) != NULL) {
+	entry = snd_info_create_card_entry(card, "dsp", card->proc_root);
+	if (entry) {
 		entry->content = SNDRV_INFO_CONTENT_TEXT;
 		entry->mode = S_IFDIR | S_IRUGO | S_IXUGO;
       
@@ -811,7 +814,9 @@ int cs46xx_dsp_proc_init (struct snd_card *card, struct snd_cs46xx *chip)
 	if (!ins->proc_dsp_dir)
 		return -ENOMEM;
 
-	if ((entry = snd_info_create_card_entry(card, "spos_symbols", ins->proc_dsp_dir)) != NULL) {
+	entry = snd_info_create_card_entry(card, "spos_symbols",
+					   ins->proc_dsp_dir);
+	if (entry) {
 		entry->content = SNDRV_INFO_CONTENT_TEXT;
 		entry->private_data = chip;
 		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
@@ -823,7 +828,9 @@ int cs46xx_dsp_proc_init (struct snd_card *card, struct snd_cs46xx *chip)
 	}
 	ins->proc_sym_info_entry = entry;
     
-	if ((entry = snd_info_create_card_entry(card, "spos_modules", ins->proc_dsp_dir)) != NULL) {
+	entry = snd_info_create_card_entry(card, "spos_modules",
+					   ins->proc_dsp_dir);
+	if (entry) {
 		entry->content = SNDRV_INFO_CONTENT_TEXT;
 		entry->private_data = chip;
 		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
@@ -835,7 +842,9 @@ int cs46xx_dsp_proc_init (struct snd_card *card, struct snd_cs46xx *chip)
 	}
 	ins->proc_modules_info_entry = entry;
 
-	if ((entry = snd_info_create_card_entry(card, "parameter", ins->proc_dsp_dir)) != NULL) {
+	entry = snd_info_create_card_entry(card, "parameter",
+					   ins->proc_dsp_dir);
+	if (entry) {
 		entry->content = SNDRV_INFO_CONTENT_TEXT;
 		entry->private_data = chip;
 		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
@@ -847,7 +856,8 @@ int cs46xx_dsp_proc_init (struct snd_card *card, struct snd_cs46xx *chip)
 	}
 	ins->proc_parameter_dump_info_entry = entry;
 
-	if ((entry = snd_info_create_card_entry(card, "sample", ins->proc_dsp_dir)) != NULL) {
+	entry = snd_info_create_card_entry(card, "sample", ins->proc_dsp_dir);
+	if (entry) {
 		entry->content = SNDRV_INFO_CONTENT_TEXT;
 		entry->private_data = chip;
 		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
@@ -859,7 +869,9 @@ int cs46xx_dsp_proc_init (struct snd_card *card, struct snd_cs46xx *chip)
 	}
 	ins->proc_sample_dump_info_entry = entry;
 
-	if ((entry = snd_info_create_card_entry(card, "task_tree", ins->proc_dsp_dir)) != NULL) {
+	entry = snd_info_create_card_entry(card, "task_tree",
+					   ins->proc_dsp_dir);
+	if (entry) {
 		entry->content = SNDRV_INFO_CONTENT_TEXT;
 		entry->private_data = chip;
 		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
@@ -871,7 +883,8 @@ int cs46xx_dsp_proc_init (struct snd_card *card, struct snd_cs46xx *chip)
 	}
 	ins->proc_task_info_entry = entry;
 
-	if ((entry = snd_info_create_card_entry(card, "scb_info", ins->proc_dsp_dir)) != NULL) {
+	entry = snd_info_create_card_entry(card, "scb_info", ins->proc_dsp_dir);
+	if (entry) {
 		entry->content = SNDRV_INFO_CONTENT_TEXT;
 		entry->private_data = chip;
 		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
diff --git a/sound/pci/cs46xx/dsp_spos_scb_lib.c b/sound/pci/cs46xx/dsp_spos_scb_lib.c
index 7488e1b7a770..f9564f42eb09 100644
--- a/sound/pci/cs46xx/dsp_spos_scb_lib.c
+++ b/sound/pci/cs46xx/dsp_spos_scb_lib.c
@@ -256,9 +256,10 @@ void cs46xx_dsp_proc_register_scb_desc (struct snd_cs46xx *chip,
 	/* register to proc */
 	if (ins->snd_card != NULL && ins->proc_dsp_dir != NULL &&
 	    scb->proc_info == NULL) {
-  
-		if ((entry = snd_info_create_card_entry(ins->snd_card, scb->scb_name, 
-							ins->proc_dsp_dir)) != NULL) {
+		entry = snd_info_create_card_entry(ins->snd_card,
+						   scb->scb_name,
+						   ins->proc_dsp_dir);
+		if (entry) {
 			scb_info = kmalloc(sizeof(struct proc_scb_info), GFP_KERNEL);
 			if (!scb_info) {
 				snd_info_free_entry(entry);
-- 
2.15.0
