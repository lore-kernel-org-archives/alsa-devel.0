From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 13/21] ALSA: cs46xx: Remove always NULL
	parameters
Date: Fri,  2 Jan 2015 12:24:47 +0100
Message-ID: <1420197895-17696-14-git-send-email-lars@metafoo.de>
References: <1420197895-17696-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id C2285260540
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 12:25:16 +0100 (CET)
In-Reply-To: <1420197895-17696-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

The various PCM and MIDI allocation functions in this driver take a pointer
to a pointer of a PCM/MIDI object where if this parameter is provided the
newly allocated object is stored. All callers pass NULL though, so remove
the parameter. This makes the code a bit shorter and cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/pci/cs46xx/cs46xx.c     | 10 +++++-----
 sound/pci/cs46xx/cs46xx.h     | 10 +++++-----
 sound/pci/cs46xx/cs46xx_lib.c | 40 +++++-----------------------------------
 3 files changed, 15 insertions(+), 45 deletions(-)

diff --git a/sound/pci/cs46xx/cs46xx.c b/sound/pci/cs46xx/cs46xx.c
index 6a6858c..655fbea 100644
--- a/sound/pci/cs46xx/cs46xx.c
+++ b/sound/pci/cs46xx/cs46xx.c
@@ -100,16 +100,16 @@ static int snd_card_cs46xx_probe(struct pci_dev *pci,
 	}
 	card->private_data = chip;
 	chip->accept_valid = mmap_valid[dev];
-	if ((err = snd_cs46xx_pcm(chip, 0, NULL)) < 0) {
+	if ((err = snd_cs46xx_pcm(chip, 0)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
-	if ((err = snd_cs46xx_pcm_rear(chip,1, NULL)) < 0) {
+	if ((err = snd_cs46xx_pcm_rear(chip, 1)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_cs46xx_pcm_iec958(chip,2,NULL)) < 0) {
+	if ((err = snd_cs46xx_pcm_iec958(chip, 2)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -120,13 +120,13 @@ static int snd_card_cs46xx_probe(struct pci_dev *pci,
 	}
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	if (chip->nr_ac97_codecs ==2) {
-		if ((err = snd_cs46xx_pcm_center_lfe(chip,3,NULL)) < 0) {
+		if ((err = snd_cs46xx_pcm_center_lfe(chip, 3)) < 0) {
 			snd_card_free(card);
 			return err;
 		}
 	}
 #endif
-	if ((err = snd_cs46xx_midi(chip, 0, NULL)) < 0) {
+	if ((err = snd_cs46xx_midi(chip, 0)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
diff --git a/sound/pci/cs46xx/cs46xx.h b/sound/pci/cs46xx/cs46xx.h
index c49a082..9c9f89a 100644
--- a/sound/pci/cs46xx/cs46xx.h
+++ b/sound/pci/cs46xx/cs46xx.h
@@ -1737,12 +1737,12 @@ int snd_cs46xx_create(struct snd_card *card,
 		      struct snd_cs46xx **rcodec);
 extern const struct dev_pm_ops snd_cs46xx_pm;
 
-int snd_cs46xx_pcm(struct snd_cs46xx *chip, int device, struct snd_pcm **rpcm);
-int snd_cs46xx_pcm_rear(struct snd_cs46xx *chip, int device, struct snd_pcm **rpcm);
-int snd_cs46xx_pcm_iec958(struct snd_cs46xx *chip, int device, struct snd_pcm **rpcm);
-int snd_cs46xx_pcm_center_lfe(struct snd_cs46xx *chip, int device, struct snd_pcm **rpcm);
+int snd_cs46xx_pcm(struct snd_cs46xx *chip, int device);
+int snd_cs46xx_pcm_rear(struct snd_cs46xx *chip, int device);
+int snd_cs46xx_pcm_iec958(struct snd_cs46xx *chip, int device);
+int snd_cs46xx_pcm_center_lfe(struct snd_cs46xx *chip, int device);
 int snd_cs46xx_mixer(struct snd_cs46xx *chip, int spdif_device);
-int snd_cs46xx_midi(struct snd_cs46xx *chip, int device, struct snd_rawmidi **rmidi);
+int snd_cs46xx_midi(struct snd_cs46xx *chip, int device);
 int snd_cs46xx_start_dsp(struct snd_cs46xx *chip);
 int snd_cs46xx_gameport(struct snd_cs46xx *chip);
 
diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index 32b44f2..dfec84e 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -1778,13 +1778,11 @@ static struct snd_pcm_ops snd_cs46xx_capture_indirect_ops = {
 #define MAX_PLAYBACK_CHANNELS	1
 #endif
 
-int snd_cs46xx_pcm(struct snd_cs46xx *chip, int device, struct snd_pcm **rpcm)
+int snd_cs46xx_pcm(struct snd_cs46xx *chip, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
 	if ((err = snd_pcm_new(chip->card, "CS46xx", device, MAX_PLAYBACK_CHANNELS, 1, &pcm)) < 0)
 		return err;
 
@@ -1801,23 +1799,16 @@ int snd_cs46xx_pcm(struct snd_cs46xx *chip, int device, struct snd_pcm **rpcm)
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_pci_data(chip->pci), 64*1024, 256*1024);
 
-	if (rpcm)
-		*rpcm = pcm;
-
 	return 0;
 }
 
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
-int snd_cs46xx_pcm_rear(struct snd_cs46xx *chip, int device,
-			struct snd_pcm **rpcm)
+int snd_cs46xx_pcm_rear(struct snd_cs46xx *chip, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
-
 	if ((err = snd_pcm_new(chip->card, "CS46xx - Rear", device, MAX_PLAYBACK_CHANNELS, 0, &pcm)) < 0)
 		return err;
 
@@ -1833,21 +1824,14 @@ int snd_cs46xx_pcm_rear(struct snd_cs46xx *chip, int device,
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_pci_data(chip->pci), 64*1024, 256*1024);
 
-	if (rpcm)
-		*rpcm = pcm;
-
 	return 0;
 }
 
-int snd_cs46xx_pcm_center_lfe(struct snd_cs46xx *chip, int device,
-			      struct snd_pcm **rpcm)
+int snd_cs46xx_pcm_center_lfe(struct snd_cs46xx *chip, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
-
 	if ((err = snd_pcm_new(chip->card, "CS46xx - Center LFE", device, MAX_PLAYBACK_CHANNELS, 0, &pcm)) < 0)
 		return err;
 
@@ -1863,21 +1847,14 @@ int snd_cs46xx_pcm_center_lfe(struct snd_cs46xx *chip, int device,
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_pci_data(chip->pci), 64*1024, 256*1024);
 
-	if (rpcm)
-		*rpcm = pcm;
-
 	return 0;
 }
 
-int snd_cs46xx_pcm_iec958(struct snd_cs46xx *chip, int device,
-			  struct snd_pcm **rpcm)
+int snd_cs46xx_pcm_iec958(struct snd_cs46xx *chip, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
-
 	if ((err = snd_pcm_new(chip->card, "CS46xx - IEC958", device, 1, 0, &pcm)) < 0)
 		return err;
 
@@ -1893,9 +1870,6 @@ int snd_cs46xx_pcm_iec958(struct snd_cs46xx *chip, int device,
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_pci_data(chip->pci), 64*1024, 256*1024);
 
-	if (rpcm)
-		*rpcm = pcm;
-
 	return 0;
 }
 #endif
@@ -2724,13 +2698,11 @@ static struct snd_rawmidi_ops snd_cs46xx_midi_input =
 	.trigger =	snd_cs46xx_midi_input_trigger,
 };
 
-int snd_cs46xx_midi(struct snd_cs46xx *chip, int device, struct snd_rawmidi **rrawmidi)
+int snd_cs46xx_midi(struct snd_cs46xx *chip, int device)
 {
 	struct snd_rawmidi *rmidi;
 	int err;
 
-	if (rrawmidi)
-		*rrawmidi = NULL;
 	if ((err = snd_rawmidi_new(chip->card, "CS46XX", device, 1, 1, &rmidi)) < 0)
 		return err;
 	strcpy(rmidi->name, "CS46XX");
@@ -2739,8 +2711,6 @@ int snd_cs46xx_midi(struct snd_cs46xx *chip, int device, struct snd_rawmidi **rr
 	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT | SNDRV_RAWMIDI_INFO_INPUT | SNDRV_RAWMIDI_INFO_DUPLEX;
 	rmidi->private_data = chip;
 	chip->rmidi = rmidi;
-	if (rrawmidi)
-		*rrawmidi = NULL;
 	return 0;
 }
 
-- 
1.8.0
