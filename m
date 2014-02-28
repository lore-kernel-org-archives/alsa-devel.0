From: Dylan Reid <dgreid@chromium.org>
Subject: [RFCv2 12/22] ALSA: hda - Pull pages allocation to
	hda_controller
Date: Fri, 28 Feb 2014 15:41:23 -0800
Message-ID: <1393630893-29010-13-git-send-email-dgreid@chromium.org>
References: <1393630893-29010-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f73.google.com (mail-oa0-f73.google.com
 [209.85.219.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CD9326598D
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 00:42:52 +0100 (CET)
Received: by mail-oa0-f73.google.com with SMTP id n16so60863oag.0
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 15:42:51 -0800 (PST)
In-Reply-To: <1393630893-29010-1-git-send-email-dgreid@chromium.org>
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, swarren@wwwdotorg.org
List-Id: alsa-devel@alsa-project.org

Pull allocation from first_init to a new function in hda_controller.c.
Short term this will allow the dsp loader to be moved as well.  In
later commits it will allow the same allocation to be used by the
platform hda driver.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_controller.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_controller.h |  4 ++++
 sound/pci/hda/hda_intel.c      | 34 +++++----------------------------
 3 files changed, 52 insertions(+), 29 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index fcc5c30..bf5e890 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1014,5 +1014,48 @@ int azx_attach_pcm_stream(struct hda_bus *bus, struct hda_codec *codec,
 }
 EXPORT_SYMBOL_GPL(azx_attach_pcm_stream);
 
+int azx_alloc_stream_pages(struct azx *chip)
+{
+	int i, err;
+	struct snd_card *card = chip->card;
+
+	for (i = 0; i < chip->num_streams; i++) {
+		dsp_lock_init(&chip->azx_dev[i]);
+		/* allocate memory for the BDL for each stream */
+		err = chip->ops->dma_alloc_pages(chip, SNDRV_DMA_TYPE_DEV,
+						 BDL_SIZE,
+						 &chip->azx_dev[i].bdl);
+		if (err < 0) {
+			dev_err(card->dev, "cannot allocate BDL\n");
+			return -ENOMEM;
+		}
+	}
+	/* allocate memory for the position buffer */
+	err = chip->ops->dma_alloc_pages(chip, SNDRV_DMA_TYPE_DEV,
+					 chip->num_streams * 8, &chip->posbuf);
+	if (err < 0) {
+		dev_err(card->dev, "cannot allocate posbuf\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(azx_alloc_stream_pages);
+
+void azx_free_stream_pages(struct azx *chip)
+{
+	int i;
+	if (chip->azx_dev) {
+		for (i = 0; i < chip->num_streams; i++)
+			if (chip->azx_dev[i].bdl.area)
+				chip->ops->dma_free_pages(
+					chip, &chip->azx_dev[i].bdl);
+	}
+	if (chip->rb.area)
+		chip->ops->dma_free_pages(chip, &chip->rb);
+	if (chip->posbuf.area)
+		chip->ops->dma_free_pages(chip, &chip->posbuf);
+}
+EXPORT_SYMBOL_GPL(azx_free_stream_pages);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Common HDA driver funcitons");
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index a62cdde..9ea6b44 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -54,4 +54,8 @@ int setup_bdle(struct azx *chip,
 #define dsp_is_locked(dev)	0
 #endif
 
+/* Allocation functions. */
+int azx_alloc_stream_pages(struct azx *chip);
+void azx_free_stream_pages(struct azx *chip);
+
 #endif /* __SOUND_HDA_CONTROLLER_H */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index f86ee2b..4a0b228 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1864,16 +1864,7 @@ static int azx_free(struct azx *chip)
 	if (chip->remap_addr)
 		iounmap(chip->remap_addr);
 
-	if (chip->azx_dev) {
-		for (i = 0; i < chip->num_streams; i++)
-			if (chip->azx_dev[i].bdl.area)
-				chip->ops->dma_free_pages(
-					chip, &chip->azx_dev[i].bdl);
-	}
-	if (chip->rb.area)
-		chip->ops->dma_free_pages(chip, &chip->rb);
-	if (chip->posbuf.area)
-		chip->ops->dma_free_pages(chip, &chip->posbuf);
+	azx_free_stream_pages(chip);
 	if (chip->region_requested)
 		pci_release_regions(chip->pci);
 	pci_disable_device(chip->pci);
@@ -2210,7 +2201,7 @@ static int azx_first_init(struct azx *chip)
 	int dev = chip->dev_index;
 	struct pci_dev *pci = chip->pci;
 	struct snd_card *card = chip->card;
-	int i, err;
+	int err;
 	unsigned short gcap;
 
 #if BITS_PER_LONG != 64
@@ -2322,24 +2313,9 @@ static int azx_first_init(struct azx *chip)
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < chip->num_streams; i++) {
-		dsp_lock_init(&chip->azx_dev[i]);
-		/* allocate memory for the BDL for each stream */
-		err = chip->ops->dma_alloc_pages(chip, SNDRV_DMA_TYPE_DEV,
-						 BDL_SIZE,
-						 &chip->azx_dev[i].bdl);
-		if (err < 0) {
-			dev_err(card->dev, "cannot allocate BDL\n");
-			return -ENOMEM;
-		}
-	}
-	/* allocate memory for the position buffer */
-	err = chip->ops->dma_alloc_pages(chip, SNDRV_DMA_TYPE_DEV,
-					 chip->num_streams * 8, &chip->posbuf);
-	if (err < 0) {
-		dev_err(card->dev, "cannot allocate posbuf\n");
-		return -ENOMEM;
-	}
+	err = azx_alloc_stream_pages(chip);
+	if (err < 0)
+		return err;
 	/* allocate CORB/RIRB */
 	err = azx_alloc_cmd_io(chip);
 	if (err < 0)
-- 
1.8.1.3.605.g02339dd
