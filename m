From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Fix Audio DSP usage when IOMMU is
	enabled.
Date: Fri,  2 May 2014 16:56:31 +0100
Message-ID: <1399046194-5544-5-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1399046194-5544-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B0A96261AE7
 for <alsa-devel@alsa-project.org>; Fri,  2 May 2014 17:56:55 +0200 (CEST)
In-Reply-To: <1399046194-5544-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The Intel IOMMU requires that the ACPI device is used to allocate all
DMA memory buffers. This means we need to pass the DMA device pointer into child
component devices that allocate DMA memory.

We also only set the DMA mask for the ACPI device now instead of for each
component device.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-acpi.c        |  1 +
 sound/soc/intel/sst-dsp-priv.h    |  1 +
 sound/soc/intel/sst-dsp.c         |  1 +
 sound/soc/intel/sst-dsp.h         |  1 +
 sound/soc/intel/sst-firmware.c    | 10 ++--------
 sound/soc/intel/sst-haswell-dsp.c |  4 ++--
 sound/soc/intel/sst-haswell-pcm.c |  9 ++++-----
 7 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/sound/soc/intel/sst-acpi.c b/sound/soc/intel/sst-acpi.c
index 5d06eec..18aee77 100644
--- a/sound/soc/intel/sst-acpi.c
+++ b/sound/soc/intel/sst-acpi.c
@@ -138,6 +138,7 @@ static int sst_acpi_probe(struct platform_device *pdev)
 
 	sst_pdata = &sst_acpi->sst_pdata;
 	sst_pdata->id = desc->sst_id;
+	sst_pdata->dma_dev = dev;
 	sst_acpi->desc = desc;
 	sst_acpi->mach = mach;
 
diff --git a/sound/soc/intel/sst-dsp-priv.h b/sound/soc/intel/sst-dsp-priv.h
index 30ca14a..4012134 100644
--- a/sound/soc/intel/sst-dsp-priv.h
+++ b/sound/soc/intel/sst-dsp-priv.h
@@ -228,6 +228,7 @@ struct sst_dsp {
 	spinlock_t spinlock;	/* IPC locking */
 	struct mutex mutex;	/* DSP FW lock */
 	struct device *dev;
+	struct device *dma_dev;
 	void *thread_context;
 	int irq;
 	u32 id;
diff --git a/sound/soc/intel/sst-dsp.c b/sound/soc/intel/sst-dsp.c
index 0c129fd..0b715b2 100644
--- a/sound/soc/intel/sst-dsp.c
+++ b/sound/soc/intel/sst-dsp.c
@@ -337,6 +337,7 @@ struct sst_dsp *sst_dsp_new(struct device *dev,
 	spin_lock_init(&sst->spinlock);
 	mutex_init(&sst->mutex);
 	sst->dev = dev;
+	sst->dma_dev = pdata->dma_dev;
 	sst->thread_context = sst_dev->thread_context;
 	sst->sst_dev = sst_dev;
 	sst->id = pdata->id;
diff --git a/sound/soc/intel/sst-dsp.h b/sound/soc/intel/sst-dsp.h
index 74052b5..e44423b 100644
--- a/sound/soc/intel/sst-dsp.h
+++ b/sound/soc/intel/sst-dsp.h
@@ -169,6 +169,7 @@ struct sst_pdata {
 	u32 dma_base;
 	u32 dma_size;
 	int dma_engine;
+	struct device *dma_dev;
 
 	/* DSP */
 	u32 id;
diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index 4d50d2f..928f228 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -57,14 +57,8 @@ struct sst_fw *sst_fw_new(struct sst_dsp *dsp,
 	sst_fw->private = private;
 	sst_fw->size = fw->size;
 
-	err = dma_coerce_mask_and_coherent(dsp->dev, DMA_BIT_MASK(32));
-	if (err < 0) {
-		kfree(sst_fw);
-		return NULL;
-	}
-
 	/* allocate DMA buffer to store FW data */
-	sst_fw->dma_buf = dma_alloc_coherent(dsp->dev, sst_fw->size,
+	sst_fw->dma_buf = dma_alloc_coherent(dsp->dma_dev, sst_fw->size,
 				&sst_fw->dmable_fw_paddr, GFP_DMA | GFP_KERNEL);
 	if (!sst_fw->dma_buf) {
 		dev_err(dsp->dev, "error: DMA alloc failed\n");
@@ -106,7 +100,7 @@ void sst_fw_free(struct sst_fw *sst_fw)
 	list_del(&sst_fw->list);
 	mutex_unlock(&dsp->mutex);
 
-	dma_free_coherent(dsp->dev, sst_fw->size, sst_fw->dma_buf,
+	dma_free_coherent(dsp->dma_dev, sst_fw->size, sst_fw->dma_buf,
 			sst_fw->dmable_fw_paddr);
 	kfree(sst_fw);
 }
diff --git a/sound/soc/intel/sst-haswell-dsp.c b/sound/soc/intel/sst-haswell-dsp.c
index f5ebf36..535f517 100644
--- a/sound/soc/intel/sst-haswell-dsp.c
+++ b/sound/soc/intel/sst-haswell-dsp.c
@@ -433,7 +433,7 @@ static int hsw_init(struct sst_dsp *sst, struct sst_pdata *pdata)
 	int ret = -ENODEV, i, j, region_count;
 	u32 offset, size;
 
-	dev = sst->dev;
+	dev = sst->dma_dev;
 
 	switch (sst->id) {
 	case SST_DEV_ID_LYNX_POINT:
@@ -466,7 +466,7 @@ static int hsw_init(struct sst_dsp *sst, struct sst_pdata *pdata)
 		return ret;
 	}
 
-	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(31));
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index dc53f50..ba585a7 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -633,17 +633,16 @@ static void hsw_pcm_free(struct snd_pcm *pcm)
 static int hsw_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_pcm *pcm = rtd->pcm;
+	struct snd_soc_platform *platform = rtd->platform;
+	struct sst_pdata *pdata = dev_get_platdata(platform->dev);
+	struct device *dev = pdata->dma_dev;
 	int ret = 0;
 
-	ret = dma_coerce_mask_and_coherent(rtd->card->dev, DMA_BIT_MASK(32));
-	if (ret)
-		return ret;
-
 	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream ||
 			pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
 		ret = snd_pcm_lib_preallocate_pages_for_all(pcm,
 			SNDRV_DMA_TYPE_DEV_SG,
-			rtd->card->dev,
+			dev,
 			hsw_pcm_hardware.buffer_bytes_max,
 			hsw_pcm_hardware.buffer_bytes_max);
 		if (ret) {
-- 
1.9.1
