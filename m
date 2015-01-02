From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 21/21] ALSA: ymfpci: Remove always NULL
	parameters
Date: Fri,  2 Jan 2015 12:24:55 +0100
Message-ID: <1420197895-17696-22-git-send-email-lars@metafoo.de>
References: <1420197895-17696-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C2DD2605CD
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 12:25:25 +0100 (CET)
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

The various PCM allocation functions in this driver take a pointer to a
pointer of a PCM where if this parameter is provided the newly allocated PCM
is stored. All callers pass NULL though, so remove the parameter. This makes
the code a bit shorter and cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/pci/ymfpci/ymfpci.c      |  8 ++++----
 sound/pci/ymfpci/ymfpci.h      |  8 ++++----
 sound/pci/ymfpci/ymfpci_main.c | 38 ++++++--------------------------------
 3 files changed, 14 insertions(+), 40 deletions(-)

diff --git a/sound/pci/ymfpci/ymfpci.c b/sound/pci/ymfpci/ymfpci.c
index 47a1923..812e27a 100644
--- a/sound/pci/ymfpci/ymfpci.c
+++ b/sound/pci/ymfpci/ymfpci.c
@@ -283,11 +283,11 @@ static int snd_card_ymfpci_probe(struct pci_dev *pci,
 		card->shortname,
 		chip->reg_area_phys,
 		chip->irq);
-	if ((err = snd_ymfpci_pcm(chip, 0, NULL)) < 0) {
+	if ((err = snd_ymfpci_pcm(chip, 0)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_ymfpci_pcm_spdif(chip, 1, NULL)) < 0) {
+	if ((err = snd_ymfpci_pcm_spdif(chip, 1)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -297,12 +297,12 @@ static int snd_card_ymfpci_probe(struct pci_dev *pci,
 		return err;
 	}
 	if (chip->ac97->ext_id & AC97_EI_SDAC) {
-		err = snd_ymfpci_pcm_4ch(chip, 2, NULL);
+		err = snd_ymfpci_pcm_4ch(chip, 2);
 		if (err < 0) {
 			snd_card_free(card);
 			return err;
 		}
-		err = snd_ymfpci_pcm2(chip, 3, NULL);
+		err = snd_ymfpci_pcm2(chip, 3);
 		if (err < 0) {
 			snd_card_free(card);
 			return err;
diff --git a/sound/pci/ymfpci/ymfpci.h b/sound/pci/ymfpci/ymfpci.h
index 4631a23..149d4cb 100644
--- a/sound/pci/ymfpci/ymfpci.h
+++ b/sound/pci/ymfpci/ymfpci.h
@@ -379,10 +379,10 @@ void snd_ymfpci_free_gameport(struct snd_ymfpci *chip);
 
 extern const struct dev_pm_ops snd_ymfpci_pm;
 
-int snd_ymfpci_pcm(struct snd_ymfpci *chip, int device, struct snd_pcm **rpcm);
-int snd_ymfpci_pcm2(struct snd_ymfpci *chip, int device, struct snd_pcm **rpcm);
-int snd_ymfpci_pcm_spdif(struct snd_ymfpci *chip, int device, struct snd_pcm **rpcm);
-int snd_ymfpci_pcm_4ch(struct snd_ymfpci *chip, int device, struct snd_pcm **rpcm);
+int snd_ymfpci_pcm(struct snd_ymfpci *chip, int device);
+int snd_ymfpci_pcm2(struct snd_ymfpci *chip, int device);
+int snd_ymfpci_pcm_spdif(struct snd_ymfpci *chip, int device);
+int snd_ymfpci_pcm_4ch(struct snd_ymfpci *chip, int device);
 int snd_ymfpci_mixer(struct snd_ymfpci *chip, int rear_switch);
 int snd_ymfpci_timer(struct snd_ymfpci *chip, int device);
 
diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index 81c916a..f5581a9 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -1145,13 +1145,11 @@ static struct snd_pcm_ops snd_ymfpci_capture_rec_ops = {
 	.pointer =		snd_ymfpci_capture_pointer,
 };
 
-int snd_ymfpci_pcm(struct snd_ymfpci *chip, int device, struct snd_pcm **rpcm)
+int snd_ymfpci_pcm(struct snd_ymfpci *chip, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
 	if ((err = snd_pcm_new(chip->card, "YMFPCI", device, 32, 1, &pcm)) < 0)
 		return err;
 	pcm->private_data = chip;
@@ -1167,14 +1165,8 @@ int snd_ymfpci_pcm(struct snd_ymfpci *chip, int device, struct snd_pcm **rpcm)
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_pci_data(chip->pci), 64*1024, 256*1024);
 
-	err = snd_pcm_add_chmap_ctls(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+	return snd_pcm_add_chmap_ctls(pcm, SNDRV_PCM_STREAM_PLAYBACK,
 				     snd_pcm_std_chmaps, 2, 0, NULL);
-	if (err < 0)
-		return err;
-
-	if (rpcm)
-		*rpcm = pcm;
-	return 0;
 }
 
 static struct snd_pcm_ops snd_ymfpci_capture_ac97_ops = {
@@ -1188,13 +1180,11 @@ static struct snd_pcm_ops snd_ymfpci_capture_ac97_ops = {
 	.pointer =		snd_ymfpci_capture_pointer,
 };
 
-int snd_ymfpci_pcm2(struct snd_ymfpci *chip, int device, struct snd_pcm **rpcm)
+int snd_ymfpci_pcm2(struct snd_ymfpci *chip, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
 	if ((err = snd_pcm_new(chip->card, "YMFPCI - PCM2", device, 0, 1, &pcm)) < 0)
 		return err;
 	pcm->private_data = chip;
@@ -1210,8 +1200,6 @@ int snd_ymfpci_pcm2(struct snd_ymfpci *chip, int device, struct snd_pcm **rpcm)
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_pci_data(chip->pci), 64*1024, 256*1024);
 
-	if (rpcm)
-		*rpcm = pcm;
 	return 0;
 }
 
@@ -1226,14 +1214,11 @@ static struct snd_pcm_ops snd_ymfpci_playback_spdif_ops = {
 	.pointer =		snd_ymfpci_playback_pointer,
 };
 
-int snd_ymfpci_pcm_spdif(struct snd_ymfpci *chip, int device,
-			 struct snd_pcm **rpcm)
+int snd_ymfpci_pcm_spdif(struct snd_ymfpci *chip, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
 	if ((err = snd_pcm_new(chip->card, "YMFPCI - IEC958", device, 1, 0, &pcm)) < 0)
 		return err;
 	pcm->private_data = chip;
@@ -1248,8 +1233,6 @@ int snd_ymfpci_pcm_spdif(struct snd_ymfpci *chip, int device,
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_pci_data(chip->pci), 64*1024, 256*1024);
 
-	if (rpcm)
-		*rpcm = pcm;
 	return 0;
 }
 
@@ -1272,14 +1255,11 @@ static const struct snd_pcm_chmap_elem surround_map[] = {
 	{ }
 };
 
-int snd_ymfpci_pcm_4ch(struct snd_ymfpci *chip, int device,
-		       struct snd_pcm **rpcm)
+int snd_ymfpci_pcm_4ch(struct snd_ymfpci *chip, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
 	if ((err = snd_pcm_new(chip->card, "YMFPCI - Rear", device, 1, 0, &pcm)) < 0)
 		return err;
 	pcm->private_data = chip;
@@ -1294,14 +1274,8 @@ int snd_ymfpci_pcm_4ch(struct snd_ymfpci *chip, int device,
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_pci_data(chip->pci), 64*1024, 256*1024);
 
-	err = snd_pcm_add_chmap_ctls(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+	return snd_pcm_add_chmap_ctls(pcm, SNDRV_PCM_STREAM_PLAYBACK,
 				     surround_map, 2, 0, NULL);
-	if (err < 0)
-		return err;
-
-	if (rpcm)
-		*rpcm = pcm;
-	return 0;
 }
 
 static int snd_ymfpci_spdif_default_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
-- 
1.8.0
