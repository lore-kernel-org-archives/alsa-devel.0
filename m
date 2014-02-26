From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 35/48] ALSA: lola: Use standard printk helpers
Date: Wed, 26 Feb 2014 16:53:37 +0100
Message-ID: <1393430030-26704-36-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E9022657D0
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:54 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E555375041
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 15:53:53 +0000 (UTC)
In-Reply-To: <1393430030-26704-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Convert with dev_err() and co from snd_printk(), etc.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/lola/lola.c       | 42 +++++++++++++++++++++---------------------
 sound/pci/lola/lola_clock.c | 14 +++++++-------
 sound/pci/lola/lola_mixer.c | 22 ++++++++++++----------
 sound/pci/lola/lola_pcm.c   | 26 +++++++++++++++-----------
 4 files changed, 55 insertions(+), 49 deletions(-)

diff --git a/sound/pci/lola/lola.c b/sound/pci/lola/lola.c
index 56d4f94daea2..d63434d8c3fb 100644
--- a/sound/pci/lola/lola.c
+++ b/sound/pci/lola/lola.c
@@ -75,7 +75,7 @@ MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
 static int debug;
 module_param(debug, int, 0644);
 #define verbose_debug(fmt, args...)			\
-	do { if (debug > 1) printk(KERN_DEBUG SFX fmt, ##args); } while (0)
+	do { if (debug > 1) pr_debug(SFX fmt, ##args); } while (0)
 #else
 #define verbose_debug(fmt, args...)
 #endif
@@ -168,7 +168,7 @@ static int rirb_get_response(struct lola *chip, unsigned int *val,
 			verbose_debug("get_response: %x, %x\n",
 				      chip->res, chip->res_ex);
 			if (chip->res_ex & LOLA_RIRB_EX_ERROR) {
-				printk(KERN_WARNING SFX "RIRB ERROR: "
+				dev_warn(chip->card->dev, "RIRB ERROR: "
 				       "NID=%x, verb=%x, data=%x, ext=%x\n",
 				       chip->last_cmd_nid,
 				       chip->last_verb, chip->last_data,
@@ -182,9 +182,9 @@ static int rirb_get_response(struct lola *chip, unsigned int *val,
 		udelay(20);
 		cond_resched();
 	}
-	printk(KERN_WARNING SFX "RIRB response error\n");
+	dev_warn(chip->card->dev, "RIRB response error\n");
 	if (!chip->polling_mode) {
-		printk(KERN_WARNING SFX "switching to polling mode\n");
+		dev_warn(chip->card->dev, "switching to polling mode\n");
 		chip->polling_mode = 1;
 		goto again;
 	}
@@ -327,7 +327,7 @@ static int reset_controller(struct lola *chip)
 			break;
 	} while (time_before(jiffies, end_time));
 	if (!gctl) {
-		printk(KERN_ERR SFX "cannot reset controller\n");
+		dev_err(chip->card->dev, "cannot reset controller\n");
 		return -EIO;
 	}
 	return 0;
@@ -452,40 +452,40 @@ static int lola_parse_tree(struct lola *chip)
 
 	err = lola_read_param(chip, 0, LOLA_PAR_VENDOR_ID, &val);
 	if (err < 0) {
-		printk(KERN_ERR SFX "Can't read VENDOR_ID\n");
+		dev_err(chip->card->dev, "Can't read VENDOR_ID\n");
 		return err;
 	}
 	val >>= 16;
 	if (val != 0x1369) {
-		printk(KERN_ERR SFX "Unknown codec vendor 0x%x\n", val);
+		dev_err(chip->card->dev, "Unknown codec vendor 0x%x\n", val);
 		return -EINVAL;
 	}
 
 	err = lola_read_param(chip, 1, LOLA_PAR_FUNCTION_TYPE, &val);
 	if (err < 0) {
-		printk(KERN_ERR SFX "Can't read FUNCTION_TYPE\n");
+		dev_err(chip->card->dev, "Can't read FUNCTION_TYPE\n");
 		return err;
 	}
 	if (val != 1) {
-		printk(KERN_ERR SFX "Unknown function type %d\n", val);
+		dev_err(chip->card->dev, "Unknown function type %d\n", val);
 		return -EINVAL;
 	}
 
 	err = lola_read_param(chip, 1, LOLA_PAR_SPECIFIC_CAPS, &val);
 	if (err < 0) {
-		printk(KERN_ERR SFX "Can't read SPECCAPS\n");
+		dev_err(chip->card->dev, "Can't read SPECCAPS\n");
 		return err;
 	}
 	chip->lola_caps = val;
 	chip->pin[CAPT].num_pins = LOLA_AFG_INPUT_PIN_COUNT(chip->lola_caps);
 	chip->pin[PLAY].num_pins = LOLA_AFG_OUTPUT_PIN_COUNT(chip->lola_caps);
-	snd_printdd(SFX "speccaps=0x%x, pins in=%d, out=%d\n",
+	dev_dbg(chip->card->dev, "speccaps=0x%x, pins in=%d, out=%d\n",
 		    chip->lola_caps,
 		    chip->pin[CAPT].num_pins, chip->pin[PLAY].num_pins);
 
 	if (chip->pin[CAPT].num_pins > MAX_AUDIO_INOUT_COUNT ||
 	    chip->pin[PLAY].num_pins > MAX_AUDIO_INOUT_COUNT) {
-		printk(KERN_ERR SFX "Invalid Lola-spec caps 0x%x\n", val);
+		dev_err(chip->card->dev, "Invalid Lola-spec caps 0x%x\n", val);
 		return -EINVAL;
 	}
 
@@ -586,7 +586,7 @@ static int lola_create(struct snd_card *card, struct pci_dev *pci,
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (!chip) {
-		snd_printk(KERN_ERR SFX "cannot allocate chip\n");
+		dev_err(chip->card->dev, "cannot allocate chip\n");
 		pci_disable_device(pci);
 		return -ENOMEM;
 	}
@@ -609,7 +609,7 @@ static int lola_create(struct snd_card *card, struct pci_dev *pci,
 		chip->sample_rate_max = 192000;
 		break;
 	default:
-		snd_printk(KERN_WARNING SFX
+		dev_warn(chip->card->dev,
 			   "Invalid granularity %d, reset to %d\n",
 			   chip->granularity, LOLA_GRANULARITY_MAX);
 		chip->granularity = LOLA_GRANULARITY_MAX;
@@ -618,7 +618,7 @@ static int lola_create(struct snd_card *card, struct pci_dev *pci,
 	}
 	chip->sample_rate_min = sample_rate_min[dev];
 	if (chip->sample_rate_min > chip->sample_rate_max) {
-		snd_printk(KERN_WARNING SFX
+		dev_warn(chip->card->dev,
 			   "Invalid sample_rate_min %d, reset to 16000\n",
 			   chip->sample_rate_min);
 		chip->sample_rate_min = 16000;
@@ -636,7 +636,7 @@ static int lola_create(struct snd_card *card, struct pci_dev *pci,
 	chip->bar[1].addr = pci_resource_start(pci, 2);
 	chip->bar[1].remap_addr = pci_ioremap_bar(pci, 2);
 	if (!chip->bar[0].remap_addr || !chip->bar[1].remap_addr) {
-		snd_printk(KERN_ERR SFX "ioremap error\n");
+		dev_err(chip->card->dev, "ioremap error\n");
 		err = -ENXIO;
 		goto errout;
 	}
@@ -649,7 +649,7 @@ static int lola_create(struct snd_card *card, struct pci_dev *pci,
 
 	if (request_irq(pci->irq, lola_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
-		printk(KERN_ERR SFX "unable to grab IRQ %d\n", pci->irq);
+		dev_err(chip->card->dev, "unable to grab IRQ %d\n", pci->irq);
 		err = -EBUSY;
 		goto errout;
 	}
@@ -660,7 +660,7 @@ static int lola_create(struct snd_card *card, struct pci_dev *pci,
 	chip->pcm[CAPT].num_streams = (dever >> 0) & 0x3ff;
 	chip->pcm[PLAY].num_streams = (dever >> 10) & 0x3ff;
 	chip->version = (dever >> 24) & 0xff;
-	snd_printdd(SFX "streams in=%d, out=%d, version=0x%x\n",
+	dev_dbg(chip->card->dev, "streams in=%d, out=%d, version=0x%x\n",
 		    chip->pcm[CAPT].num_streams, chip->pcm[PLAY].num_streams,
 		    chip->version);
 
@@ -669,7 +669,7 @@ static int lola_create(struct snd_card *card, struct pci_dev *pci,
 	    chip->pcm[PLAY].num_streams > MAX_STREAM_OUT_COUNT ||
 	    (!chip->pcm[CAPT].num_streams &&
 	     !chip->pcm[PLAY].num_streams)) {
-		printk(KERN_ERR SFX "invalid DEVER = %x\n", dever);
+		dev_err(chip->card->dev, "invalid DEVER = %x\n", dever);
 		err = -EINVAL;
 		goto errout;
 	}
@@ -680,7 +680,7 @@ static int lola_create(struct snd_card *card, struct pci_dev *pci,
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
 	if (err < 0) {
-		snd_printk(KERN_ERR SFX "Error creating device [card]!\n");
+		dev_err(chip->card->dev, "Error creating device [card]!\n");
 		goto errout;
 	}
 
@@ -720,7 +720,7 @@ static int lola_probe(struct pci_dev *pci,
 	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
 			   0, &card);
 	if (err < 0) {
-		snd_printk(KERN_ERR SFX "Error creating card!\n");
+		dev_err(card->dev, "Error creating card!\n");
 		return err;
 	}
 
diff --git a/sound/pci/lola/lola_clock.c b/sound/pci/lola/lola_clock.c
index eb1d6b97df16..2bef6b412aee 100644
--- a/sound/pci/lola/lola_clock.c
+++ b/sound/pci/lola/lola_clock.c
@@ -128,21 +128,21 @@ int lola_init_clock_widget(struct lola *chip, int nid)
 
 	err = lola_read_param(chip, nid, LOLA_PAR_AUDIO_WIDGET_CAP, &val);
 	if (err < 0) {
-		printk(KERN_ERR SFX "Can't read wcaps for 0x%x\n", nid);
+		dev_err(chip->card->dev, "Can't read wcaps for 0x%x\n", nid);
 		return err;
 	}
 
 	if ((val & 0xfff00000) != 0x01f00000) { /* test SubType and Type */
-		snd_printdd("No valid clock widget\n");
+		dev_dbg(chip->card->dev, "No valid clock widget\n");
 		return 0;
 	}
 
 	chip->clock.nid = nid;
 	chip->clock.items = val & 0xff;
-	snd_printdd("clock_list nid=%x, entries=%d\n", nid,
+	dev_dbg(chip->card->dev, "clock_list nid=%x, entries=%d\n", nid,
 		    chip->clock.items);
 	if (chip->clock.items > MAX_SAMPLE_CLOCK_COUNT) {
-		printk(KERN_ERR SFX "CLOCK_LIST too big: %d\n",
+		dev_err(chip->card->dev, "CLOCK_LIST too big: %d\n",
 		       chip->clock.items);
 		return -EINVAL;
 	}
@@ -158,7 +158,7 @@ int lola_init_clock_widget(struct lola *chip, int nid)
 		err = lola_codec_read(chip, nid, LOLA_VERB_GET_CLOCK_LIST,
 				      idx, 0, &val, &res_ex);
 		if (err < 0) {
-			printk(KERN_ERR SFX "Can't read CLOCK_LIST\n");
+			dev_err(chip->card->dev, "Can't read CLOCK_LIST\n");
 			return -EINVAL;
 		}
 
@@ -223,7 +223,7 @@ int lola_enable_clock_events(struct lola *chip)
 	if (err < 0)
 		return err;
 	if (res) {
-		printk(KERN_WARNING SFX "error in enable_clock_events %d\n",
+		dev_warn(chip->card->dev, "error in enable_clock_events %d\n",
 		       res);
 		return -EINVAL;
 	}
@@ -242,7 +242,7 @@ int lola_set_clock_index(struct lola *chip, unsigned int idx)
 	if (err < 0)
 		return err;
 	if (res) {
-		printk(KERN_WARNING SFX "error in set_clock %d\n", res);
+		dev_warn(chip->card->dev, "error in set_clock %d\n", res);
 		return -EINVAL;
 	}
 	return 0;
diff --git a/sound/pci/lola/lola_mixer.c b/sound/pci/lola/lola_mixer.c
index 52c8d6b0f39b..782f4d8299ae 100644
--- a/sound/pci/lola/lola_mixer.c
+++ b/sound/pci/lola/lola_mixer.c
@@ -37,7 +37,7 @@ static int lola_init_pin(struct lola *chip, struct lola_pin *pin,
 	pin->nid = nid;
 	err = lola_read_param(chip, nid, LOLA_PAR_AUDIO_WIDGET_CAP, &val);
 	if (err < 0) {
-		printk(KERN_ERR SFX "Can't read wcaps for 0x%x\n", nid);
+		dev_err(chip->card->dev, "Can't read wcaps for 0x%x\n", nid);
 		return err;
 	}
 	val &= 0x00f00fff; /* test TYPE and bits 0..11 */
@@ -48,7 +48,7 @@ static int lola_init_pin(struct lola *chip, struct lola_pin *pin,
 	else if (val == 0x0040000c && dir == PLAY) /* Dig=0, OutAmp/ovrd */
 		pin->is_analog = true;
 	else {
-		printk(KERN_ERR SFX "Invalid wcaps 0x%x for 0x%x\n", val, nid);
+		dev_err(chip->card->dev, "Invalid wcaps 0x%x for 0x%x\n", val, nid);
 		return -EINVAL;
 	}
 
@@ -62,7 +62,7 @@ static int lola_init_pin(struct lola *chip, struct lola_pin *pin,
 	else
 		err = lola_read_param(chip, nid, LOLA_PAR_AMP_IN_CAP, &val);
 	if (err < 0) {
-		printk(KERN_ERR SFX "Can't read AMP-caps for 0x%x\n", nid);
+		dev_err(chip->card->dev, "Can't read AMP-caps for 0x%x\n", nid);
 		return err;
 	}
 
@@ -79,7 +79,7 @@ static int lola_init_pin(struct lola *chip, struct lola_pin *pin,
 	err = lola_codec_read(chip, nid, LOLA_VERB_GET_MAX_LEVEL, 0, 0, &val,
 			      NULL);
 	if (err < 0) {
-		printk(KERN_ERR SFX "Can't get MAX_LEVEL 0x%x\n", nid);
+		dev_err(chip->card->dev, "Can't get MAX_LEVEL 0x%x\n", nid);
 		return err;
 	}
 	pin->max_level = val & 0x3ff;   /* 10 bits */
@@ -119,12 +119,12 @@ int lola_init_mixer_widget(struct lola *chip, int nid)
 
 	err = lola_read_param(chip, nid, LOLA_PAR_AUDIO_WIDGET_CAP, &val);
 	if (err < 0) {
-		printk(KERN_ERR SFX "Can't read wcaps for 0x%x\n", nid);
+		dev_err(chip->card->dev, "Can't read wcaps for 0x%x\n", nid);
 		return err;
 	}
 
 	if ((val & 0xfff00000) != 0x02f00000) { /* test SubType and Type */
-		snd_printdd("No valid mixer widget\n");
+		dev_dbg(chip->card->dev, "No valid mixer widget\n");
 		return 0;
 	}
 
@@ -202,7 +202,7 @@ int lola_init_mixer_widget(struct lola *chip, int nid)
 	 */
 	if (chip->mixer.src_stream_out_ofs > MAX_AUDIO_INOUT_COUNT ||
 	    chip->mixer.dest_phys_out_ofs > MAX_STREAM_IN_COUNT) {
-		printk(KERN_ERR SFX "Invalid mixer widget size\n");
+		dev_err(chip->card->dev, "Invalid mixer widget size\n");
 		return -EINVAL;
 	}
 
@@ -213,7 +213,7 @@ int lola_init_mixer_widget(struct lola *chip, int nid)
 		(((1U << chip->mixer.dest_phys_outs) - 1)
 		 << chip->mixer.dest_phys_out_ofs);
 
-	snd_printdd("Mixer src_mask=%x, dest_mask=%x\n",
+	dev_dbg(chip->card->dev, "Mixer src_mask=%x, dest_mask=%x\n",
 		    chip->mixer.src_mask, chip->mixer.dest_mask);
 
 	return 0;
@@ -236,7 +236,8 @@ static int lola_mixer_set_src_gain(struct lola *chip, unsigned int id,
 	    (gain == readw(&chip->mixer.array->src_gain[id])))
 		return 0;
 
-	snd_printdd("lola_mixer_set_src_gain (id=%d, gain=%d) enable=%x\n",
+	dev_dbg(chip->card->dev,
+		"lola_mixer_set_src_gain (id=%d, gain=%d) enable=%x\n",
 			id, gain, val);
 	writew(gain, &chip->mixer.array->src_gain[id]);
 	writel(val, &chip->mixer.array->src_gain_enable);
@@ -409,7 +410,8 @@ static int set_analog_volume(struct lola *chip, int dir,
 		return 0;
 	if (external_call)
 		lola_codec_flush(chip);
-	snd_printdd("set_analog_volume (dir=%d idx=%d, volume=%d)\n",
+	dev_dbg(chip->card->dev,
+		"set_analog_volume (dir=%d idx=%d, volume=%d)\n",
 			dir, idx, val);
 	err = lola_codec_write(chip, pin->nid,
 			       LOLA_VERB_SET_AMP_GAIN_MUTE, val, 0);
diff --git a/sound/pci/lola/lola_pcm.c b/sound/pci/lola/lola_pcm.c
index 5ea85e8b83ab..3bd6985430e8 100644
--- a/sound/pci/lola/lola_pcm.c
+++ b/sound/pci/lola/lola_pcm.c
@@ -103,7 +103,7 @@ static void wait_for_srst_clear(struct lola *chip, struct lola_stream *str)
 			return;
 		msleep(1);
 	}
-	printk(KERN_WARNING SFX "SRST not clear (stream %d)\n", str->dsd);
+	dev_warn(chip->card->dev, "SRST not clear (stream %d)\n", str->dsd);
 }
 
 static int lola_stream_wait_for_fifo(struct lola *chip,
@@ -118,7 +118,7 @@ static int lola_stream_wait_for_fifo(struct lola *chip,
 			return 0;
 		msleep(1);
 	}
-	printk(KERN_WARNING SFX "FIFO not ready (stream %d)\n", str->dsd);
+	dev_warn(chip->card->dev, "FIFO not ready (stream %d)\n", str->dsd);
 	return -EIO;
 }
 
@@ -156,7 +156,7 @@ static int lola_sync_wait_for_fifo(struct lola *chip,
 			return 0;
 		msleep(1);
 	}
-	printk(KERN_WARNING SFX "FIFO not ready (pending %d)\n", pending - 1);
+	dev_warn(chip->card->dev, "FIFO not ready (pending %d)\n", pending - 1);
 	return -EIO;
 }
 
@@ -373,7 +373,7 @@ static int lola_setup_periods(struct lola *chip, struct lola_pcm *pcm,
 	return 0;
 
  error:
-	snd_printk(KERN_ERR SFX "Too many BDL entries: buffer=%d, period=%d\n",
+	dev_err(chip->card->dev, "Too many BDL entries: buffer=%d, period=%d\n",
 		   str->bufsize, period_bytes);
 	return -EINVAL;
 }
@@ -415,7 +415,7 @@ static int lola_set_stream_config(struct lola *chip,
 	err = lola_codec_read(chip, str->nid, LOLA_VERB_SET_STREAM_FORMAT,
 			      str->format_verb, 0, &val, NULL);
 	if (err < 0) {
-		printk(KERN_ERR SFX "Cannot set stream format 0x%x\n",
+		dev_err(chip->card->dev, "Cannot set stream format 0x%x\n",
 		       str->format_verb);
 		return err;
 	}
@@ -427,7 +427,8 @@ static int lola_set_stream_config(struct lola *chip,
 				      LOLA_VERB_SET_CHANNEL_STREAMID, 0, verb,
 				      &val, NULL);
 		if (err < 0) {
-			printk(KERN_ERR SFX "Cannot set stream channel %d\n", i);
+			dev_err(chip->card->dev,
+				"Cannot set stream channel %d\n", i);
 			return err;
 		}
 	}
@@ -651,13 +652,14 @@ static int lola_init_stream(struct lola *chip, struct lola_stream *str,
 		str->dsd += MAX_STREAM_IN_COUNT;
 	err = lola_read_param(chip, nid, LOLA_PAR_AUDIO_WIDGET_CAP, &val);
 	if (err < 0) {
-		printk(KERN_ERR SFX "Can't read wcaps for 0x%x\n", nid);
+		dev_err(chip->card->dev, "Can't read wcaps for 0x%x\n", nid);
 		return err;
 	}
 	if (dir == PLAY) {
 		/* test TYPE and bits 0..11 (no test bit9 : Digital = 0/1) */
 		if ((val & 0x00f00dff) != 0x00000010) {
-			printk(KERN_ERR SFX "Invalid wcaps 0x%x for 0x%x\n",
+			dev_err(chip->card->dev,
+				"Invalid wcaps 0x%x for 0x%x\n",
 			       val, nid);
 			return -EINVAL;
 		}
@@ -666,7 +668,8 @@ static int lola_init_stream(struct lola *chip, struct lola_stream *str,
 		 * (bug : ignore bit8: Conn list = 0/1)
 		 */
 		if ((val & 0x00f00cff) != 0x00100010) {
-			printk(KERN_ERR SFX "Invalid wcaps 0x%x for 0x%x\n",
+			dev_err(chip->card->dev,
+				"Invalid wcaps 0x%x for 0x%x\n",
 			       val, nid);
 			return -EINVAL;
 		}
@@ -677,14 +680,15 @@ static int lola_init_stream(struct lola *chip, struct lola_stream *str,
 
 	err = lola_read_param(chip, nid, LOLA_PAR_STREAM_FORMATS, &val);
 	if (err < 0) {
-		printk(KERN_ERR SFX "Can't read FORMATS 0x%x\n", nid);
+		dev_err(chip->card->dev, "Can't read FORMATS 0x%x\n", nid);
 		return err;
 	}
 	val &= 3;
 	if (val == 3)
 		str->can_float = true;
 	if (!(val & 1)) {
-		printk(KERN_ERR SFX "Invalid formats 0x%x for 0x%x", val, nid);
+		dev_err(chip->card->dev,
+			"Invalid formats 0x%x for 0x%x", val, nid);
 		return -EINVAL;
 	}
 	return 0;
-- 
1.9.0
