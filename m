From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 15/21] ALSA: emu10k1: Remove always NULL
	parameters
Date: Fri,  2 Jan 2015 12:24:49 +0100
Message-ID: <1420197895-17696-16-git-send-email-lars@metafoo.de>
References: <1420197895-17696-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id F3EF32604CE
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 12:25:18 +0100 (CET)
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

The various PCM and hwdep allocation functions in this driver take a pointer
to a pointer of a PCM/hwdep where if this parameter is provided the newly
allocated object is stored. All callers pass NULL though, so remove the
parameter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/emu10k1.h      | 14 +++++++-------
 sound/pci/emu10k1/emu10k1.c  | 12 ++++++------
 sound/pci/emu10k1/emu10k1x.c | 19 +++++--------------
 sound/pci/emu10k1/emufx.c    |  7 +------
 sound/pci/emu10k1/emupcm.c   | 33 ++++-----------------------------
 sound/pci/emu10k1/p16v.c     |  7 +------
 6 files changed, 24 insertions(+), 68 deletions(-)

diff --git a/include/sound/emu10k1.h b/include/sound/emu10k1.h
index c46908c..7f6ab6c 100644
--- a/include/sound/emu10k1.h
+++ b/include/sound/emu10k1.h
@@ -1809,17 +1809,17 @@ int snd_emu10k1_create(struct snd_card *card,
 		       uint subsystem,
 		       struct snd_emu10k1 ** remu);
 
-int snd_emu10k1_pcm(struct snd_emu10k1 * emu, int device, struct snd_pcm ** rpcm);
-int snd_emu10k1_pcm_mic(struct snd_emu10k1 * emu, int device, struct snd_pcm ** rpcm);
-int snd_emu10k1_pcm_efx(struct snd_emu10k1 * emu, int device, struct snd_pcm ** rpcm);
-int snd_p16v_pcm(struct snd_emu10k1 * emu, int device, struct snd_pcm ** rpcm);
+int snd_emu10k1_pcm(struct snd_emu10k1 *emu, int device);
+int snd_emu10k1_pcm_mic(struct snd_emu10k1 *emu, int device);
+int snd_emu10k1_pcm_efx(struct snd_emu10k1 *emu, int device);
+int snd_p16v_pcm(struct snd_emu10k1 *emu, int device);
 int snd_p16v_free(struct snd_emu10k1 * emu);
 int snd_p16v_mixer(struct snd_emu10k1 * emu);
-int snd_emu10k1_pcm_multi(struct snd_emu10k1 * emu, int device, struct snd_pcm ** rpcm);
-int snd_emu10k1_fx8010_pcm(struct snd_emu10k1 * emu, int device, struct snd_pcm ** rpcm);
+int snd_emu10k1_pcm_multi(struct snd_emu10k1 *emu, int device);
+int snd_emu10k1_fx8010_pcm(struct snd_emu10k1 *emu, int device);
 int snd_emu10k1_mixer(struct snd_emu10k1 * emu, int pcm_device, int multi_device);
 int snd_emu10k1_timer(struct snd_emu10k1 * emu, int device);
-int snd_emu10k1_fx8010_new(struct snd_emu10k1 *emu, int device, struct snd_hwdep ** rhwdep);
+int snd_emu10k1_fx8010_new(struct snd_emu10k1 *emu, int device);
 
 irqreturn_t snd_emu10k1_interrupt(int irq, void *dev_id);
 
diff --git a/sound/pci/emu10k1/emu10k1.c b/sound/pci/emu10k1/emu10k1.c
index 4c17163..a3c00a6 100644
--- a/sound/pci/emu10k1/emu10k1.c
+++ b/sound/pci/emu10k1/emu10k1.c
@@ -132,11 +132,11 @@ static int snd_card_emu10k1_probe(struct pci_dev *pci,
 		goto error;
 	card->private_data = emu;
 	emu->delay_pcm_irq = delay_pcm_irq[dev] & 0x1f;
-	if ((err = snd_emu10k1_pcm(emu, 0, NULL)) < 0)
+	if ((err = snd_emu10k1_pcm(emu, 0)) < 0)
 		goto error;
-	if ((err = snd_emu10k1_pcm_mic(emu, 1, NULL)) < 0)
+	if ((err = snd_emu10k1_pcm_mic(emu, 1)) < 0)
 		goto error;
-	if ((err = snd_emu10k1_pcm_efx(emu, 2, NULL)) < 0)
+	if ((err = snd_emu10k1_pcm_efx(emu, 2)) < 0)
 		goto error;
 	/* This stores the periods table. */
 	if (emu->card_capabilities->ca0151_chip) { /* P16V */	
@@ -151,10 +151,10 @@ static int snd_card_emu10k1_probe(struct pci_dev *pci,
 	if ((err = snd_emu10k1_timer(emu, 0)) < 0)
 		goto error;
 
-	if ((err = snd_emu10k1_pcm_multi(emu, 3, NULL)) < 0)
+	if ((err = snd_emu10k1_pcm_multi(emu, 3)) < 0)
 		goto error;
 	if (emu->card_capabilities->ca0151_chip) { /* P16V */
-		if ((err = snd_p16v_pcm(emu, 4, NULL)) < 0)
+		if ((err = snd_p16v_pcm(emu, 4)) < 0)
 			goto error;
 	}
 	if (emu->audigy) {
@@ -164,7 +164,7 @@ static int snd_card_emu10k1_probe(struct pci_dev *pci,
 		if ((err = snd_emu10k1_midi(emu)) < 0)
 			goto error;
 	}
-	if ((err = snd_emu10k1_fx8010_new(emu, 0, NULL)) < 0)
+	if ((err = snd_emu10k1_fx8010_new(emu, 0)) < 0)
 		goto error;
 #ifdef ENABLE_SYNTH
 	if (snd_seq_device_new(card, 1, SNDRV_SEQ_DEV_ID_EMU10K1_SYNTH,
diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index 15933f9..6d1b98d 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -847,15 +847,13 @@ static const struct snd_pcm_chmap_elem clfe_map[] = {
 	{ }
 };
 
-static int snd_emu10k1x_pcm(struct emu10k1x *emu, int device, struct snd_pcm **rpcm)
+static int snd_emu10k1x_pcm(struct emu10k1x *emu, int device)
 {
 	struct snd_pcm *pcm;
 	const struct snd_pcm_chmap_elem *map = NULL;
 	int err;
 	int capture = 0;
   
-	if (rpcm)
-		*rpcm = NULL;
 	if (device == 0)
 		capture = 1;
 	
@@ -896,15 +894,8 @@ static int snd_emu10k1x_pcm(struct emu10k1x *emu, int device, struct snd_pcm **r
 					      snd_dma_pci_data(emu->pci), 
 					      32*1024, 32*1024);
   
-	err = snd_pcm_add_chmap_ctls(pcm, SNDRV_PCM_STREAM_PLAYBACK, map, 2,
+	return snd_pcm_add_chmap_ctls(pcm, SNDRV_PCM_STREAM_PLAYBACK, map, 2,
 				     1 << 2, NULL);
-	if (err < 0)
-		return err;
-
-	if (rpcm)
-		*rpcm = pcm;
-  
-	return 0;
 }
 
 static int snd_emu10k1x_create(struct snd_card *card,
@@ -1583,15 +1574,15 @@ static int snd_emu10k1x_probe(struct pci_dev *pci,
 		return err;
 	}
 
-	if ((err = snd_emu10k1x_pcm(chip, 0, NULL)) < 0) {
+	if ((err = snd_emu10k1x_pcm(chip, 0)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_emu10k1x_pcm(chip, 1, NULL)) < 0) {
+	if ((err = snd_emu10k1x_pcm(chip, 1)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_emu10k1x_pcm(chip, 2, NULL)) < 0) {
+	if ((err = snd_emu10k1x_pcm(chip, 2)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index eb5c0ab..56fc47b 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -2641,14 +2641,11 @@ static int snd_emu10k1_fx8010_release(struct snd_hwdep * hw, struct file *file)
 	return 0;
 }
 
-int snd_emu10k1_fx8010_new(struct snd_emu10k1 *emu, int device,
-			   struct snd_hwdep **rhwdep)
+int snd_emu10k1_fx8010_new(struct snd_emu10k1 *emu, int device)
 {
 	struct snd_hwdep *hw;
 	int err;
 	
-	if (rhwdep)
-		*rhwdep = NULL;
 	if ((err = snd_hwdep_new(emu->card, "FX8010", device, &hw)) < 0)
 		return err;
 	strcpy(hw->name, "EMU10K1 (FX8010)");
@@ -2657,8 +2654,6 @@ int snd_emu10k1_fx8010_new(struct snd_emu10k1 *emu, int device,
 	hw->ops.ioctl = snd_emu10k1_fx8010_ioctl;
 	hw->ops.release = snd_emu10k1_fx8010_release;
 	hw->private_data = emu;
-	if (rhwdep)
-		*rhwdep = hw;
 	return 0;
 }
 
diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index f82481b..0dc0738 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -1400,15 +1400,12 @@ static struct snd_pcm_ops snd_emu10k1_efx_playback_ops = {
 	.page =			snd_pcm_sgbuf_ops_page,
 };
 
-int snd_emu10k1_pcm(struct snd_emu10k1 *emu, int device, struct snd_pcm **rpcm)
+int snd_emu10k1_pcm(struct snd_emu10k1 *emu, int device)
 {
 	struct snd_pcm *pcm;
 	struct snd_pcm_substream *substream;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
-
 	if ((err = snd_pcm_new(emu->card, "emu10k1", device, 32, 1, &pcm)) < 0)
 		return err;
 
@@ -1429,22 +1426,15 @@ int snd_emu10k1_pcm(struct snd_emu10k1 *emu, int device, struct snd_pcm **rpcm)
 	for (substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream; substream; substream = substream->next)
 		snd_pcm_lib_preallocate_pages(substream, SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(emu->pci), 64*1024, 64*1024);
 
-	if (rpcm)
-		*rpcm = pcm;
-
 	return 0;
 }
 
-int snd_emu10k1_pcm_multi(struct snd_emu10k1 *emu, int device,
-			  struct snd_pcm **rpcm)
+int snd_emu10k1_pcm_multi(struct snd_emu10k1 *emu, int device)
 {
 	struct snd_pcm *pcm;
 	struct snd_pcm_substream *substream;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
-
 	if ((err = snd_pcm_new(emu->card, "emu10k1", device, 1, 0, &pcm)) < 0)
 		return err;
 
@@ -1461,9 +1451,6 @@ int snd_emu10k1_pcm_multi(struct snd_emu10k1 *emu, int device,
 		if ((err = snd_pcm_lib_preallocate_pages(substream, SNDRV_DMA_TYPE_DEV_SG, snd_dma_pci_data(emu->pci), 64*1024, 64*1024)) < 0)
 			return err;
 
-	if (rpcm)
-		*rpcm = pcm;
-
 	return 0;
 }
 
@@ -1479,15 +1466,11 @@ static struct snd_pcm_ops snd_emu10k1_capture_mic_ops = {
 	.pointer =		snd_emu10k1_capture_pointer,
 };
 
-int snd_emu10k1_pcm_mic(struct snd_emu10k1 *emu, int device,
-			struct snd_pcm **rpcm)
+int snd_emu10k1_pcm_mic(struct snd_emu10k1 *emu, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
-
 	if ((err = snd_pcm_new(emu->card, "emu10k1 mic", device, 0, 1, &pcm)) < 0)
 		return err;
 
@@ -1501,8 +1484,6 @@ int snd_emu10k1_pcm_mic(struct snd_emu10k1 *emu, int device,
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(emu->pci), 64*1024, 64*1024);
 
-	if (rpcm)
-		*rpcm = pcm;
 	return 0;
 }
 
@@ -1822,16 +1803,12 @@ static struct snd_pcm_ops snd_emu10k1_fx8010_playback_ops = {
 	.ack =			snd_emu10k1_fx8010_playback_transfer,
 };
 
-int snd_emu10k1_pcm_efx(struct snd_emu10k1 *emu, int device,
-			struct snd_pcm **rpcm)
+int snd_emu10k1_pcm_efx(struct snd_emu10k1 *emu, int device)
 {
 	struct snd_pcm *pcm;
 	struct snd_kcontrol *kctl;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
-
 	if ((err = snd_pcm_new(emu->card, "emu10k1 efx", device, 8, 1, &pcm)) < 0)
 		return err;
 
@@ -1843,8 +1820,6 @@ int snd_emu10k1_pcm_efx(struct snd_emu10k1 *emu, int device,
 	pcm->info_flags = 0;
 	strcpy(pcm->name, "Multichannel Capture/PT Playback");
 	emu->pcm_efx = pcm;
-	if (rpcm)
-		*rpcm = pcm;
 
 	/* EFX capture - record the "FXBUS2" channels, by default we connect the EXTINs 
 	 * to these
diff --git a/sound/pci/emu10k1/p16v.c b/sound/pci/emu10k1/p16v.c
index 7ef3898..b672755 100644
--- a/sound/pci/emu10k1/p16v.c
+++ b/sound/pci/emu10k1/p16v.c
@@ -640,7 +640,7 @@ int snd_p16v_free(struct snd_emu10k1 *chip)
 	return 0;
 }
 
-int snd_p16v_pcm(struct snd_emu10k1 *emu, int device, struct snd_pcm **rpcm)
+int snd_p16v_pcm(struct snd_emu10k1 *emu, int device)
 {
 	struct snd_pcm *pcm;
 	struct snd_pcm_substream *substream;
@@ -649,8 +649,6 @@ int snd_p16v_pcm(struct snd_emu10k1 *emu, int device, struct snd_pcm **rpcm)
   
 	/* dev_dbg(emu->card->dev, "snd_p16v_pcm called. device=%d\n", device); */
 	emu->p16v_device_offset = device;
-	if (rpcm)
-		*rpcm = NULL;
 
 	if ((err = snd_pcm_new(emu->card, "p16v", device, 1, capture, &pcm)) < 0)
 		return err;
@@ -694,9 +692,6 @@ int snd_p16v_pcm(struct snd_emu10k1 *emu, int device, struct snd_pcm **rpcm)
 		*/
 	}
   
-	if (rpcm)
-		*rpcm = pcm;
-  
 	return 0;
 }
 
-- 
1.8.0
