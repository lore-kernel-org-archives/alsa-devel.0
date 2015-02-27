From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/9] ALSA: hda - Remove superfluous memory
	allocation error messages
Date: Fri, 27 Feb 2015 23:55:38 +0100
Message-ID: <1425077744-4553-4-git-send-email-tiwai@suse.de>
References: <1425077744-4553-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BDF8C26516E
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 23:55:46 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 645C5ABEE
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 22:55:46 +0000 (UTC)
In-Reply-To: <1425077744-4553-1-git-send-email-tiwai@suse.de>
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

The memory allocators should have already given the kernel warning
messages, thus we don't have to annoy again.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c      | 16 ++++------------
 sound/pci/hda/hda_controller.c | 18 ++++--------------
 sound/pci/hda/hda_intel.c      |  5 +----
 3 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 9f7d22f4f9f9..42bd7f5e1185 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -794,10 +794,8 @@ int snd_hda_bus_new(struct snd_card *card,
 		*busp = NULL;
 
 	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
-	if (bus == NULL) {
-		dev_err(card->dev, "can't allocate struct hda_bus\n");
+	if (!bus)
 		return -ENOMEM;
-	}
 
 	bus->card = card;
 	mutex_init(&bus->cmd_mutex);
@@ -1235,10 +1233,8 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 	}
 
 	codec = kzalloc(sizeof(*codec), GFP_KERNEL);
-	if (codec == NULL) {
-		dev_err(card->dev, "can't allocate struct hda_codec\n");
+	if (!codec)
 		return -ENOMEM;
-	}
 
 	dev = hda_codec_dev(codec);
 	device_initialize(dev);
@@ -1316,10 +1312,8 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 
 	fg = codec->afg ? codec->afg : codec->mfg;
 	err = read_widget_caps(codec, fg);
-	if (err < 0) {
-		dev_err(card->dev, "cannot malloc\n");
+	if (err < 0)
 		goto error;
-	}
 	err = read_pin_defaults(codec);
 	if (err < 0)
 		goto error;
@@ -1380,10 +1374,8 @@ int snd_hda_codec_update_widgets(struct hda_codec *codec)
 	kfree(codec->wcaps);
 	fg = codec->afg ? codec->afg : codec->mfg;
 	err = read_widget_caps(codec, fg);
-	if (err < 0) {
-		codec_err(codec, "cannot malloc\n");
+	if (err < 0)
 		return err;
-	}
 
 	snd_array_free(&codec->init_pins);
 	err = read_pin_defaults(codec);
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index f50863a5159d..be02bca6f7e6 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -974,14 +974,9 @@ static int azx_attach_pcm_stream(struct hda_bus *bus, struct hda_codec *codec,
  */
 static int azx_alloc_cmd_io(struct azx *chip)
 {
-	int err;
-
 	/* single page (at least 4096 bytes) must suffice for both ringbuffes */
-	err = chip->ops->dma_alloc_pages(chip, SNDRV_DMA_TYPE_DEV,
-					 PAGE_SIZE, &chip->rb);
-	if (err < 0)
-		dev_err(chip->card->dev, "cannot allocate CORB/RIRB\n");
-	return err;
+	return chip->ops->dma_alloc_pages(chip, SNDRV_DMA_TYPE_DEV,
+					  PAGE_SIZE, &chip->rb);
 }
 EXPORT_SYMBOL_GPL(azx_alloc_cmd_io);
 
@@ -1472,7 +1467,6 @@ static void azx_load_dsp_cleanup(struct hda_bus *bus,
 int azx_alloc_stream_pages(struct azx *chip)
 {
 	int i, err;
-	struct snd_card *card = chip->card;
 
 	for (i = 0; i < chip->num_streams; i++) {
 		dsp_lock_init(&chip->azx_dev[i]);
@@ -1480,18 +1474,14 @@ int azx_alloc_stream_pages(struct azx *chip)
 		err = chip->ops->dma_alloc_pages(chip, SNDRV_DMA_TYPE_DEV,
 						 BDL_SIZE,
 						 &chip->azx_dev[i].bdl);
-		if (err < 0) {
-			dev_err(card->dev, "cannot allocate BDL\n");
+		if (err < 0)
 			return -ENOMEM;
-		}
 	}
 	/* allocate memory for the position buffer */
 	err = chip->ops->dma_alloc_pages(chip, SNDRV_DMA_TYPE_DEV,
 					 chip->num_streams * 8, &chip->posbuf);
-	if (err < 0) {
-		dev_err(card->dev, "cannot allocate posbuf\n");
+	if (err < 0)
 		return -ENOMEM;
-	}
 
 	/* allocate CORB/RIRB */
 	err = azx_alloc_cmd_io(chip);
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index e75e8137e296..f7fb1b51d446 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1383,7 +1383,6 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 
 	hda = kzalloc(sizeof(*hda), GFP_KERNEL);
 	if (!hda) {
-		dev_err(card->dev, "Cannot allocate hda\n");
 		pci_disable_device(pci);
 		return -ENOMEM;
 	}
@@ -1564,10 +1563,8 @@ static int azx_first_init(struct azx *chip)
 	chip->num_streams = chip->playback_streams + chip->capture_streams;
 	chip->azx_dev = kcalloc(chip->num_streams, sizeof(*chip->azx_dev),
 				GFP_KERNEL);
-	if (!chip->azx_dev) {
-		dev_err(card->dev, "cannot malloc azx_dev\n");
+	if (!chip->azx_dev)
 		return -ENOMEM;
-	}
 
 	err = azx_alloc_stream_pages(chip);
 	if (err < 0)
-- 
2.3.0
