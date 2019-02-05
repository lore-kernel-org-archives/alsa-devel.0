From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/20] ALSA: pci: Drop superfluous PCM
	preallocation error checks
Date: Tue,  5 Feb 2019 20:42:04 +0100
Message-ID: <20190205194221.25924-4-tiwai@suse.de>
References: <20190205194221.25924-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BB552678FE
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 20:42:26 +0100 (CET)
In-Reply-To: <20190205194221.25924-1-tiwai@suse.de>
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
Cc: Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

snd_pcm_lib_preallocate_pages() and co always succeed, so the error
check is simply redundant.  Drop it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ad1889.c              |  7 +------
 sound/pci/aw2/aw2-alsa.c        | 40 ++++++++++++----------------------------
 sound/pci/bt87x.c               | 10 +++++-----
 sound/pci/ca0106/ca0106_main.c  | 16 ++++++----------
 sound/pci/echoaudio/echoaudio.c | 16 +++++++---------
 sound/pci/emu10k1/emupcm.c      | 22 +++++++++++++++-------
 sound/pci/emu10k1/p16v.c        | 17 +++++++----------
 sound/pci/lx6464es/lx6464es.c   |  8 +++-----
 sound/pci/rme9652/hdspm.c       | 20 ++++----------------
 sound/pci/via82xx_modem.c       |  8 +++-----
 10 files changed, 63 insertions(+), 101 deletions(-)

diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index d9c54c08e2db..410fefe5ebde 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -644,16 +644,11 @@ snd_ad1889_pcm_init(struct snd_ad1889 *chip, int device)
 	chip->psubs = NULL;
 	chip->csubs = NULL;
 
-	err = snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 						snd_dma_pci_data(chip->pci),
 						BUFFER_BYTES_MAX / 2,
 						BUFFER_BYTES_MAX);
 
-	if (err < 0) {
-		dev_err(chip->card->dev, "buffer allocation error: %d\n", err);
-		return err;
-	}
-	
 	return 0;
 }
 
diff --git a/sound/pci/aw2/aw2-alsa.c b/sound/pci/aw2/aw2-alsa.c
index 9a49e4243a9c..b07c5fc1da56 100644
--- a/sound/pci/aw2/aw2-alsa.c
+++ b/sound/pci/aw2/aw2-alsa.c
@@ -624,15 +624,10 @@ static int snd_aw2_new_pcm(struct aw2 *chip)
 
 	/* pre-allocation of buffers */
 	/* Preallocate continuous pages. */
-	err = snd_pcm_lib_preallocate_pages_for_all(pcm_playback_ana,
-						    SNDRV_DMA_TYPE_DEV,
-						    snd_dma_pci_data
-						    (chip->pci),
-						    64 * 1024, 64 * 1024);
-	if (err)
-		dev_err(chip->card->dev,
-			"snd_pcm_lib_preallocate_pages_for_all error (0x%X)\n",
-			err);
+	snd_pcm_lib_preallocate_pages_for_all(pcm_playback_ana,
+					      SNDRV_DMA_TYPE_DEV,
+					      snd_dma_pci_data(chip->pci),
+					      64 * 1024, 64 * 1024);
 
 	err = snd_pcm_new(chip->card, "Audiowerk2 digital playback", 1, 1, 0,
 			  &pcm_playback_num);
@@ -661,15 +656,10 @@ static int snd_aw2_new_pcm(struct aw2 *chip)
 
 	/* pre-allocation of buffers */
 	/* Preallocate continuous pages. */
-	err = snd_pcm_lib_preallocate_pages_for_all(pcm_playback_num,
-						    SNDRV_DMA_TYPE_DEV,
-						    snd_dma_pci_data
-						    (chip->pci),
-						    64 * 1024, 64 * 1024);
-	if (err)
-		dev_err(chip->card->dev,
-			"snd_pcm_lib_preallocate_pages_for_all error (0x%X)\n",
-			err);
+	snd_pcm_lib_preallocate_pages_for_all(pcm_playback_num,
+					      SNDRV_DMA_TYPE_DEV,
+					      snd_dma_pci_data(chip->pci),
+					      64 * 1024, 64 * 1024);
 
 	err = snd_pcm_new(chip->card, "Audiowerk2 capture", 2, 0, 1,
 			  &pcm_capture);
@@ -699,16 +689,10 @@ static int snd_aw2_new_pcm(struct aw2 *chip)
 
 	/* pre-allocation of buffers */
 	/* Preallocate continuous pages. */
-	err = snd_pcm_lib_preallocate_pages_for_all(pcm_capture,
-						    SNDRV_DMA_TYPE_DEV,
-						    snd_dma_pci_data
-						    (chip->pci),
-						    64 * 1024, 64 * 1024);
-	if (err)
-		dev_err(chip->card->dev,
-			"snd_pcm_lib_preallocate_pages_for_all error (0x%X)\n",
-			err);
-
+	snd_pcm_lib_preallocate_pages_for_all(pcm_capture,
+					      SNDRV_DMA_TYPE_DEV,
+					      snd_dma_pci_data(chip->pci),
+					      64 * 1024, 64 * 1024);
 
 	/* Create control */
 	err = snd_ctl_add(chip->card, snd_ctl_new1(&aw2_control, chip));
diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index ba971042f871..0adcba10c067 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -714,11 +714,11 @@ static int snd_bt87x_pcm(struct snd_bt87x *chip, int device, char *name)
 	pcm->private_data = chip;
 	strcpy(pcm->name, name);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_bt87x_pcm_ops);
-	return snd_pcm_lib_preallocate_pages_for_all(pcm,
-						     SNDRV_DMA_TYPE_DEV_SG,
-						     snd_dma_pci_data(chip->pci),
-							128 * 1024,
-							ALIGN(255 * 4092, 1024));
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
+					      snd_dma_pci_data(chip->pci),
+					      128 * 1024,
+					      ALIGN(255 * 4092, 1024));
+	return 0;
 }
 
 static int snd_bt87x_create(struct snd_card *card,
diff --git a/sound/pci/ca0106/ca0106_main.c b/sound/pci/ca0106/ca0106_main.c
index 3d1b0bbff33b..11ef0d636405 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -1402,21 +1402,17 @@ static int snd_ca0106_pcm(struct snd_ca0106 *emu, int device)
 	for(substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream; 
 	    substream; 
 	    substream = substream->next) {
-		if ((err = snd_pcm_lib_preallocate_pages(substream, 
-							 SNDRV_DMA_TYPE_DEV, 
-							 snd_dma_pci_data(emu->pci), 
-							 64*1024, 64*1024)) < 0) /* FIXME: 32*1024 for sound buffer, between 32and64 for Periods table. */
-			return err;
+		snd_pcm_lib_preallocate_pages(substream, SNDRV_DMA_TYPE_DEV,
+					      snd_dma_pci_data(emu->pci),
+					      64*1024, 64*1024);
 	}
 
 	for (substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream; 
 	      substream; 
 	      substream = substream->next) {
- 		if ((err = snd_pcm_lib_preallocate_pages(substream, 
-	                                           SNDRV_DMA_TYPE_DEV, 
-	                                           snd_dma_pci_data(emu->pci), 
-	                                           64*1024, 64*1024)) < 0)
-			return err;
+		snd_pcm_lib_preallocate_pages(substream, SNDRV_DMA_TYPE_DEV,
+					      snd_dma_pci_data(emu->pci),
+					      64*1024, 64*1024);
 	}
   
 	err = snd_pcm_add_chmap_ctls(pcm, SNDRV_PCM_STREAM_PLAYBACK, map, 2,
diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 18d30d479b6b..ea876b0b02b9 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -884,17 +884,15 @@ static const struct snd_pcm_ops digital_capture_ops = {
 static int snd_echo_preallocate_pages(struct snd_pcm *pcm, struct device *dev)
 {
 	struct snd_pcm_substream *ss;
-	int stream, err;
+	int stream;
 
 	for (stream = 0; stream < 2; stream++)
-		for (ss = pcm->streams[stream].substream; ss; ss = ss->next) {
-			err = snd_pcm_lib_preallocate_pages(ss, SNDRV_DMA_TYPE_DEV_SG,
-							    dev,
-							    ss->number ? 0 : 128<<10,
-							    256<<10);
-			if (err < 0)
-				return err;
-		}
+		for (ss = pcm->streams[stream].substream; ss; ss = ss->next)
+			snd_pcm_lib_preallocate_pages(ss, SNDRV_DMA_TYPE_DEV_SG,
+						      dev,
+						      ss->number ? 0 : 128<<10,
+						      256<<10);
+
 	return 0;
 }
 
diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index 30b3472d0b75..f6b4cb9ac75c 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -1427,11 +1427,14 @@ int snd_emu10k1_pcm(struct snd_emu10k1 *emu, int device)
 	emu->pcm = pcm;
 
 	for (substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream; substream; substream = substream->next)
-		if ((err = snd_pcm_lib_preallocate_pages(substream, SNDRV_DMA_TYPE_DEV_SG, snd_dma_pci_data(emu->pci), 64*1024, 64*1024)) < 0)
-			return err;
+		snd_pcm_lib_preallocate_pages(substream, SNDRV_DMA_TYPE_DEV_SG,
+					      snd_dma_pci_data(emu->pci),
+					      64*1024, 64*1024);
 
 	for (substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream; substream; substream = substream->next)
-		snd_pcm_lib_preallocate_pages(substream, SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(emu->pci), 64*1024, 64*1024);
+		snd_pcm_lib_preallocate_pages(substream, SNDRV_DMA_TYPE_DEV,
+					      snd_dma_pci_data(emu->pci),
+					      64*1024, 64*1024);
 
 	return 0;
 }
@@ -1455,8 +1458,9 @@ int snd_emu10k1_pcm_multi(struct snd_emu10k1 *emu, int device)
 	emu->pcm_multi = pcm;
 
 	for (substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream; substream; substream = substream->next)
-		if ((err = snd_pcm_lib_preallocate_pages(substream, SNDRV_DMA_TYPE_DEV_SG, snd_dma_pci_data(emu->pci), 64*1024, 64*1024)) < 0)
-			return err;
+		snd_pcm_lib_preallocate_pages(substream, SNDRV_DMA_TYPE_DEV_SG,
+					      snd_dma_pci_data(emu->pci),
+					      64*1024, 64*1024);
 
 	return 0;
 }
@@ -1489,7 +1493,9 @@ int snd_emu10k1_pcm_mic(struct snd_emu10k1 *emu, int device)
 	strcpy(pcm->name, "Mic Capture");
 	emu->pcm_mic = pcm;
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(emu->pci), 64*1024, 64*1024);
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+					      snd_dma_pci_data(emu->pci),
+					      64*1024, 64*1024);
 
 	return 0;
 }
@@ -1862,7 +1868,9 @@ int snd_emu10k1_pcm_efx(struct snd_emu10k1 *emu, int device)
 	if (err < 0)
 		return err;
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(emu->pci), 64*1024, 64*1024);
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+					      snd_dma_pci_data(emu->pci),
+					      64*1024, 64*1024);
 
 	return 0;
 }
diff --git a/sound/pci/emu10k1/p16v.c b/sound/pci/emu10k1/p16v.c
index 4948b95f6665..672017cac4c7 100644
--- a/sound/pci/emu10k1/p16v.c
+++ b/sound/pci/emu10k1/p16v.c
@@ -656,11 +656,10 @@ int snd_p16v_pcm(struct snd_emu10k1 *emu, int device)
 	for(substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream; 
 	    substream; 
 	    substream = substream->next) {
-		if ((err = snd_pcm_lib_preallocate_pages(substream, 
-							 SNDRV_DMA_TYPE_DEV, 
-							 snd_dma_pci_data(emu->pci), 
-							 ((65536 - 64) * 8), ((65536 - 64) * 8))) < 0) 
-			return err;
+		snd_pcm_lib_preallocate_pages(substream, SNDRV_DMA_TYPE_DEV,
+					      snd_dma_pci_data(emu->pci),
+					      (65536 - 64) * 8,
+					      (65536 - 64) * 8);
 		/*
 		dev_dbg(emu->card->dev,
 			   "preallocate playback substream: err=%d\n", err);
@@ -670,11 +669,9 @@ int snd_p16v_pcm(struct snd_emu10k1 *emu, int device)
 	for (substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream; 
 	      substream; 
 	      substream = substream->next) {
- 		if ((err = snd_pcm_lib_preallocate_pages(substream, 
-	                                           SNDRV_DMA_TYPE_DEV, 
-	                                           snd_dma_pci_data(emu->pci), 
-	                                           65536 - 64, 65536 - 64)) < 0)
-			return err;
+		snd_pcm_lib_preallocate_pages(substream, SNDRV_DMA_TYPE_DEV,
+					      snd_dma_pci_data(emu->pci),
+					      65536 - 64, 65536 - 64);
 		/*
 		dev_dbg(emu->card->dev,
 			   "preallocate capture substream: err=%d\n", err);
diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 54f6252faca6..52ea0da1fe73 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -854,11 +854,9 @@ static int lx_pcm_create(struct lx6464es *chip)
 	pcm->nonatomic = true;
 	strcpy(pcm->name, card_name);
 
-	err = snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-						    snd_dma_pci_data(chip->pci),
-						    size, size);
-	if (err < 0)
-		return err;
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+					      snd_dma_pci_data(chip->pci),
+					      size, size);
 
 	chip->pcm = pcm;
 	chip->capture_stream.is_capture = 1;
diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 679ad0415e3b..3e66df7b5d1f 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6411,7 +6411,6 @@ static int snd_hdspm_create_hwdep(struct snd_card *card,
  ------------------------------------------------------------*/
 static int snd_hdspm_preallocate_memory(struct hdspm *hdspm)
 {
-	int err;
 	struct snd_pcm *pcm;
 	size_t wanted;
 
@@ -6419,21 +6418,10 @@ static int snd_hdspm_preallocate_memory(struct hdspm *hdspm)
 
 	wanted = HDSPM_DMA_AREA_BYTES;
 
-	err =
-	     snd_pcm_lib_preallocate_pages_for_all(pcm,
-						   SNDRV_DMA_TYPE_DEV_SG,
-						   snd_dma_pci_data(hdspm->pci),
-						   wanted,
-						   wanted);
-	if (err < 0) {
-		dev_dbg(hdspm->card->dev,
-			"Could not preallocate %zd Bytes\n", wanted);
-
-		return err;
-	} else
-		dev_dbg(hdspm->card->dev,
-			" Preallocated %zd Bytes\n", wanted);
-
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
+					      snd_dma_pci_data(hdspm->pci),
+					      wanted, wanted);
+	dev_dbg(hdspm->card->dev, " Preallocated %zd Bytes\n", wanted);
 	return 0;
 }
 
diff --git a/sound/pci/via82xx_modem.c b/sound/pci/via82xx_modem.c
index 3f59e0279058..3b3768acf7e1 100644
--- a/sound/pci/via82xx_modem.c
+++ b/sound/pci/via82xx_modem.c
@@ -865,11 +865,9 @@ static int snd_via686_pcm_new(struct via82xx_modem *chip)
 	init_viadev(chip, 0, VIA_REG_MO_STATUS, 0);
 	init_viadev(chip, 1, VIA_REG_MI_STATUS, 1);
 
-	if ((err = snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
-							 snd_dma_pci_data(chip->pci),
-							 64*1024, 128*1024)) < 0)
-		return err;
-
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
+					      snd_dma_pci_data(chip->pci),
+					      64*1024, 128*1024);
 	return 0;
 }
 
-- 
2.16.4
