From: Dylan Reid <dgreid@chromium.org>
Subject: [RFCv2 09/22] ALSA: hda - Move snd page allocation to
	ops
Date: Fri, 28 Feb 2014 15:41:20 -0800
Message-ID: <1393630893-29010-10-git-send-email-dgreid@chromium.org>
References: <1393630893-29010-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f201.google.com (mail-qc0-f201.google.com
 [209.85.216.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A2922659B2
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 00:42:52 +0100 (CET)
Received: by mail-qc0-f201.google.com with SMTP id i17so173137qcy.2
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

Break out the allocation of pages for DMA and PCM buffers to ops in
the chip structure.  This is done to allow for architecture specific
work-arounds to be added.  Currently mark_pages_wc is used by
hda_intel.  This avoids needing to move that x86-specific code to a
common area shared with hda platform drivers.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_intel.c | 141 ++++++++++++++++++++++++++++------------------
 sound/pci/hda/hda_priv.h  |  11 ++++
 2 files changed, 98 insertions(+), 54 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index ebbeefe..fa3a04c 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -297,7 +297,10 @@ static char *driver_short_names[] = {
 };
 
 /* for pcm support */
-#define get_azx_dev(substream) (substream->runtime->private_data)
+static inline struct azx_dev *get_azx_dev(struct snd_pcm_substream *substream)
+{
+	return substream->runtime->private_data;
+}
 
 #ifdef CONFIG_X86
 static void __mark_pages_wc(struct azx *chip, struct snd_dma_buffer *dmab, bool on)
@@ -366,15 +369,11 @@ static int azx_alloc_cmd_io(struct azx *chip)
 	int err;
 
 	/* single page (at least 4096 bytes) must suffice for both ringbuffes */
-	err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
-				  chip->card->dev,
-				  PAGE_SIZE, &chip->rb);
-	if (err < 0) {
+	err = chip->ops->dma_alloc_pages(chip, SNDRV_DMA_TYPE_DEV,
+					 PAGE_SIZE, &chip->rb);
+	if (err < 0)
 		dev_err(chip->card->dev, "cannot allocate CORB/RIRB\n");
-		return err;
-	}
-	mark_pages_wc(chip, &chip->rb, true);
-	return 0;
+	return err;
 }
 
 static void azx_init_cmd_io(struct azx *chip)
@@ -1716,26 +1715,18 @@ static int azx_pcm_hw_params(struct snd_pcm_substream *substream,
 {
 	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
 	struct azx *chip = apcm->chip;
-	struct azx_dev *azx_dev = get_azx_dev(substream);
 	int ret;
 
-	dsp_lock(azx_dev);
-	if (dsp_is_locked(azx_dev)) {
+	dsp_lock(get_azx_dev(substream));
+	if (dsp_is_locked(get_azx_dev(substream))) {
 		ret = -EBUSY;
 		goto unlock;
 	}
 
-	mark_runtime_wc(chip, azx_dev, substream, false);
-	azx_dev->bufsize = 0;
-	azx_dev->period_bytes = 0;
-	azx_dev->format_val = 0;
-	ret = snd_pcm_lib_malloc_pages(substream,
-					params_buffer_bytes(hw_params));
-	if (ret < 0)
-		goto unlock;
-	mark_runtime_wc(chip, azx_dev, substream, true);
- unlock:
-	dsp_unlock(azx_dev);
+	ret = chip->ops->substream_alloc_pages(chip, substream,
+					       params_buffer_bytes(hw_params));
+unlock:
+	dsp_unlock(get_azx_dev(substream));
 	return ret;
 }
 
@@ -1745,6 +1736,7 @@ static int azx_pcm_hw_free(struct snd_pcm_substream *substream)
 	struct azx_dev *azx_dev = get_azx_dev(substream);
 	struct azx *chip = apcm->chip;
 	struct hda_pcm_stream *hinfo = apcm->hinfo[substream->stream];
+	int err;
 
 	/* reset BDL address */
 	dsp_lock(azx_dev);
@@ -1759,10 +1751,10 @@ static int azx_pcm_hw_free(struct snd_pcm_substream *substream)
 
 	snd_hda_codec_cleanup(apcm->codec, hinfo, substream);
 
-	mark_runtime_wc(chip, azx_dev, substream, false);
+	err = chip->ops->substream_free_pages(chip, substream);
 	azx_dev->prepared = 0;
 	dsp_unlock(azx_dev);
-	return snd_pcm_lib_free_pages(substream);
+	return err;
 }
 
 static int azx_pcm_prepare(struct snd_pcm_substream *substream)
@@ -2398,13 +2390,11 @@ static int azx_load_dsp_prepare(struct hda_bus *bus, unsigned int format,
 	azx_dev->locked = 1;
 	spin_unlock_irq(&chip->reg_lock);
 
-	err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV_SG,
-				  chip->card->dev,
-				  byte_size, bufp);
+	err = chip->ops->dma_alloc_pages(chip, SNDRV_DMA_TYPE_DEV_SG,
+					 byte_size, bufp);
 	if (err < 0)
 		goto err_alloc;
 
-	mark_pages_wc(chip, bufp, true);
 	azx_dev->bufsize = byte_size;
 	azx_dev->period_bytes = byte_size;
 	azx_dev->format_val = format;
@@ -2426,8 +2416,7 @@ static int azx_load_dsp_prepare(struct hda_bus *bus, unsigned int format,
 	return azx_dev->stream_tag;
 
  error:
-	mark_pages_wc(chip, bufp, false);
-	snd_dma_free_pages(bufp);
+	chip->ops->dma_free_pages(chip, bufp);
  err_alloc:
 	spin_lock_irq(&chip->reg_lock);
 	if (azx_dev->opened)
@@ -2469,8 +2458,7 @@ static void azx_load_dsp_cleanup(struct hda_bus *bus,
 	azx_dev->period_bytes = 0;
 	azx_dev->format_val = 0;
 
-	mark_pages_wc(chip, dmab, false);
-	snd_dma_free_pages(dmab);
+	chip->ops->dma_free_pages(chip, dmab);
 	dmab->area = NULL;
 
 	spin_lock_irq(&chip->reg_lock);
@@ -2879,19 +2867,14 @@ static int azx_free(struct azx *chip)
 
 	if (chip->azx_dev) {
 		for (i = 0; i < chip->num_streams; i++)
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
+			if (chip->azx_dev[i].bdl.area)
+				chip->ops->dma_free_pages(
+					chip, &chip->azx_dev[i].bdl);
+	}
+	if (chip->rb.area)
+		chip->ops->dma_free_pages(chip, &chip->rb);
+	if (chip->posbuf.area)
+		chip->ops->dma_free_pages(chip, &chip->posbuf);
 	if (chip->region_requested)
 		pci_release_regions(chip->pci);
 	pci_disable_device(chip->pci);
@@ -3343,24 +3326,21 @@ static int azx_first_init(struct azx *chip)
 	for (i = 0; i < chip->num_streams; i++) {
 		dsp_lock_init(&chip->azx_dev[i]);
 		/* allocate memory for the BDL for each stream */
-		err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
-					  chip->card->dev,
-					  BDL_SIZE, &chip->azx_dev[i].bdl);
+		err = chip->ops->dma_alloc_pages(chip, SNDRV_DMA_TYPE_DEV,
+						 BDL_SIZE,
+						 &chip->azx_dev[i].bdl);
 		if (err < 0) {
 			dev_err(card->dev, "cannot allocate BDL\n");
 			return -ENOMEM;
 		}
-		mark_pages_wc(chip, &chip->azx_dev[i].bdl, true);
 	}
 	/* allocate memory for the position buffer */
-	err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
-				  chip->card->dev,
-				  chip->num_streams * 8, &chip->posbuf);
+	err = chip->ops->dma_alloc_pages(chip, SNDRV_DMA_TYPE_DEV,
+					 chip->num_streams * 8, &chip->posbuf);
 	if (err < 0) {
 		dev_err(card->dev, "cannot allocate posbuf\n");
 		return -ENOMEM;
 	}
-	mark_pages_wc(chip, &chip->posbuf, true);
 	/* allocate CORB/RIRB */
 	err = azx_alloc_cmd_io(chip);
 	if (err < 0)
@@ -3479,6 +3459,55 @@ static int disable_msi_reset_irq(struct azx *chip)
 	return 0;
 }
 
+/* DMA page allocation helpers.  */
+static int dma_alloc_pages(struct azx *chip,
+			   int type,
+			   size_t size,
+			   struct snd_dma_buffer *buf)
+{
+	int err;
+
+	err = snd_dma_alloc_pages(type,
+				  chip->card->dev,
+				  size, buf);
+	if (err < 0)
+		return err;
+	mark_pages_wc(chip, buf, true);
+	return 0;
+}
+
+static void dma_free_pages(struct azx *chip, struct snd_dma_buffer *buf)
+{
+	mark_pages_wc(chip, buf, false);
+	snd_dma_free_pages(buf);
+}
+
+static int substream_alloc_pages(struct azx *chip,
+				 struct snd_pcm_substream *substream,
+				 size_t size)
+{
+	struct azx_dev *azx_dev = get_azx_dev(substream);
+	int ret;
+
+	mark_runtime_wc(chip, azx_dev, substream, false);
+	azx_dev->bufsize = 0;
+	azx_dev->period_bytes = 0;
+	azx_dev->format_val = 0;
+	ret = snd_pcm_lib_malloc_pages(substream, size);
+	if (ret < 0)
+		return ret;
+	mark_runtime_wc(chip, azx_dev, substream, true);
+	return 0;
+}
+
+static int substream_free_pages(struct azx *chip,
+				struct snd_pcm_substream *substream)
+{
+	struct azx_dev *azx_dev = get_azx_dev(substream);
+	mark_runtime_wc(chip, azx_dev, substream, false);
+	return snd_pcm_lib_free_pages(substream);
+}
+
 static const struct hda_controller_ops pci_hda_ops = {
 	.writel = pci_azx_writel,
 	.readl = pci_azx_readl,
@@ -3487,6 +3516,10 @@ static const struct hda_controller_ops pci_hda_ops = {
 	.writeb = pci_azx_writeb,
 	.readb = pci_azx_readb,
 	.disable_msi_reset_irq = disable_msi_reset_irq,
+	.dma_alloc_pages = dma_alloc_pages,
+	.dma_free_pages = dma_free_pages,
+	.substream_alloc_pages = substream_alloc_pages,
+	.substream_free_pages = substream_free_pages,
 };
 
 static int azx_probe(struct pci_dev *pci,
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index 0a56e8e..10bcec1 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -298,6 +298,17 @@ struct hda_controller_ops {
 	u8 (*readb)(u8 *addr);
 	/* Disable msi if supported, PCI only */
 	int (*disable_msi_reset_irq)(struct azx *);
+	/* Allocation ops */
+	int (*dma_alloc_pages)(struct azx *chip,
+			       int type,
+			       size_t size,
+			       struct snd_dma_buffer *buf);
+	void (*dma_free_pages)(struct azx *chip, struct snd_dma_buffer *buf);
+	int (*substream_alloc_pages)(struct azx *chip,
+				     struct snd_pcm_substream *substream,
+				     size_t size);
+	int (*substream_free_pages)(struct azx *chip,
+				    struct snd_pcm_substream *substream);
 };
 
 struct azx_pcm {
-- 
1.8.1.3.605.g02339dd
