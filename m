From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC 06/19] ALSA: hda - Pull pages allocation to
	shared file
Date: Thu, 27 Feb 2014 22:35:49 -0800
Message-ID: <1393569362-27285-7-git-send-email-dgreid@chromium.org>
References: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f201.google.com (mail-ie0-f201.google.com
 [209.85.223.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C53F26509D
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 07:37:13 +0100 (CET)
Received: by mail-ie0-f201.google.com with SMTP id at1so711766iec.0
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 22:37:12 -0800 (PST)
In-Reply-To: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
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

Pull allocation from first_init to a new function in the shared file.
Short term this will allow the dsp loader to be moved to the shared
file, because it takes the dsp lock.  In later commits it will allow
the same allocation to be used by the platform hda driver.  Moving the
freeing into hda shared will remove references to mark_pages_wc, and
allow it to become static in hda_shared later on.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_intel.c  | 42 +++++--------------------------------
 sound/pci/hda/hda_shared.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_shared.h |  4 ++++
 3 files changed, 61 insertions(+), 37 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 838d64e..c9c541b 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1806,21 +1806,7 @@ static int azx_free(struct azx *chip)
 	if (chip->remap_addr)
 		iounmap(chip->remap_addr);
 
-	if (chip->azx_dev) {
-		for (i = 0; i < chip->num_streams; i++)
-			if (chip->azx_dev[i].bdl.area) {
-				mark_pages_wc(chip, &chip->azx_dev[i].bdl, false);
-				snd_dma_free_pages(&chip->azx_dev[i].bdl);
-			}
-	}
-	if (chip->rb.area) {
-		mark_pages_wc(chip, &chip->rb, false);
-		snd_dma_free_pages(&chip->rb);
-	}
-	if (chip->posbuf.area) {
-		mark_pages_wc(chip, &chip->posbuf, false);
-		snd_dma_free_pages(&chip->posbuf);
-	}
+	azx_free_stream_pages(chip);
 	if (chip->region_requested)
 		pci_release_regions(chip->pci);
 	pci_disable_device(chip->pci);
@@ -2156,7 +2142,7 @@ static int azx_first_init(struct azx *chip)
 	int dev = chip->dev_index;
 	struct pci_dev *pci = chip->pci;
 	struct snd_card *card = chip->card;
-	int i, err;
+	int err;
 	unsigned short gcap;
 
 #if BITS_PER_LONG != 64
@@ -2268,27 +2254,9 @@ static int azx_first_init(struct azx *chip)
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < chip->num_streams; i++) {
-		dsp_lock_init(&chip->azx_dev[i]);
-		/* allocate memory for the BDL for each stream */
-		err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
-					  chip->card->dev,
-					  BDL_SIZE, &chip->azx_dev[i].bdl);
-		if (err < 0) {
-			dev_err(card->dev, "cannot allocate BDL\n");
-			return -ENOMEM;
-		}
-		mark_pages_wc(chip, &chip->azx_dev[i].bdl, true);
-	}
-	/* allocate memory for the position buffer */
-	err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
-				  chip->card->dev,
-				  chip->num_streams * 8, &chip->posbuf);
-	if (err < 0) {
-		dev_err(card->dev, "cannot allocate posbuf\n");
-		return -ENOMEM;
-	}
-	mark_pages_wc(chip, &chip->posbuf, true);
+	err = azx_alloc_stream_pages(chip);
+	if (err < 0)
+		return err;
 	/* allocate CORB/RIRB */
 	err = azx_alloc_cmd_io(chip);
 	if (err < 0)
diff --git a/sound/pci/hda/hda_shared.c b/sound/pci/hda/hda_shared.c
index 55b0538..e921154 100644
--- a/sound/pci/hda/hda_shared.c
+++ b/sound/pci/hda/hda_shared.c
@@ -1101,5 +1101,57 @@ int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev)
 	return 1; /* OK, it's fine */
 }
 
+int azx_alloc_stream_pages(struct azx *chip)
+{
+	int i, err;
+	struct snd_card *card = chip->card;
+
+	for (i = 0; i < chip->num_streams; i++) {
+		dsp_lock_init(&chip->azx_dev[i]);
+		/* allocate memory for the BDL for each stream */
+		err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
+					  chip->card->dev,
+					  BDL_SIZE, &chip->azx_dev[i].bdl);
+		if (err < 0) {
+			dev_err(card->dev, "cannot allocate BDL\n");
+			return -ENOMEM;
+		}
+		mark_pages_wc(chip, &chip->azx_dev[i].bdl, true);
+	}
+	/* allocate memory for the position buffer */
+	err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
+				  chip->card->dev,
+				  chip->num_streams * 8, &chip->posbuf);
+	if (err < 0) {
+		dev_err(card->dev, "cannot allocate posbuf\n");
+		return -ENOMEM;
+	}
+	mark_pages_wc(chip, &chip->posbuf, true);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(azx_alloc_stream_pages);
+
+void azx_free_stream_pages(struct azx *chip)
+{
+	int i;
+	if (chip->azx_dev) {
+		for (i = 0; i < chip->num_streams; i++)
+			if (chip->azx_dev[i].bdl.area) {
+				mark_pages_wc(chip, &chip->azx_dev[i].bdl,
+					      false);
+				snd_dma_free_pages(&chip->azx_dev[i].bdl);
+			}
+	}
+	if (chip->rb.area) {
+		mark_pages_wc(chip, &chip->rb, false);
+		snd_dma_free_pages(&chip->rb);
+	}
+	if (chip->posbuf.area) {
+		mark_pages_wc(chip, &chip->posbuf, false);
+		snd_dma_free_pages(&chip->posbuf);
+	}
+}
+EXPORT_SYMBOL_GPL(azx_free_stream_pages);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Common HDA driver funcitons");
diff --git a/sound/pci/hda/hda_shared.h b/sound/pci/hda/hda_shared.h
index bc06d34..ff1eeae 100644
--- a/sound/pci/hda/hda_shared.h
+++ b/sound/pci/hda/hda_shared.h
@@ -55,4 +55,8 @@ void azx_stream_stop(struct azx *chip, struct azx_dev *azx_dev);
 #define dsp_is_locked(dev)	0
 #endif
 
+/* Allocation functions. */
+int azx_alloc_stream_pages(struct azx *chip);
+void azx_free_stream_pages(struct azx *chip);
+
 #endif /* __SOUND_HDA_SHARED_H */
-- 
1.8.1.3.605.g02339dd
