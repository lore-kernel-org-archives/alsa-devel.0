From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] dma: add support for reporting pause and resume separately
Date: Mon,  2 Jul 2018 15:08:10 +0200
Message-ID: <20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65~9jzNWZMqQ1216712167eucas1p27@eucas1p2.samsung.com>
References: <CGME20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Vinod Koul <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: alsa-devel@alsa-project.org

'cmd_pause' DMA channel capability means that respective DMA engine
supports both pausing and resuming given DMA channel. However, in some
cases it is important to know if DMA channel can be paused without the
need to resume it. This is a typical requirement for proper residue
reading on transfer timeout in UART drivers. There are also some DMA
engines with limited hardware, which doesn't really support resuming.

Reporting pause and resume capabilities separately allows UART drivers to
properly check for the really required capabilities and operate in DMA
mode also in systems with limited DMA hardware. On the other hand drivers,
which rely on full channel suspend/resume support, should now check for
both 'pause' and 'resume' features.

Existing clients of dma_get_slave_caps() have been checked and the only
driver which rely on proper channel resuming is soc-generic-dmaengine-pcm
driver, which has been updated to check the newly added capability.
Existing 'cmd_pause' now only indicates that DMA engine support pausing
given DMA channel.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This patch is a follow-up of the Vinod's advise from the following
discussion:
https://www.spinics.net/lists/linux-samsung-soc/msg63166.html
---
 drivers/dma/dmaengine.c               | 8 ++------
 include/linux/dmaengine.h             | 5 ++++-
 sound/soc/soc-generic-dmaengine-pcm.c | 2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 08ba8473a284..84ac38dbdb65 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -500,12 +500,8 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	caps->max_burst = device->max_burst;
 	caps->residue_granularity = device->residue_granularity;
 	caps->descriptor_reuse = device->descriptor_reuse;
-
-	/*
-	 * Some devices implement only pause (e.g. to get residuum) but no
-	 * resume. However cmd_pause is advertised as pause AND resume.
-	 */
-	caps->cmd_pause = !!(device->device_pause && device->device_resume);
+	caps->cmd_pause = !!device->device_pause;
+	caps->cmd_resume = !!device->device_resume;
 	caps->cmd_terminate = !!device->device_terminate_all;
 
 	return 0;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 861be5cab1df..c8c3a7a93802 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -415,7 +415,9 @@ enum dma_residue_granularity {
  *	each type, the dma controller should set BIT(<TYPE>) and same
  *	should be checked by controller as well
  * @max_burst: max burst capability per-transfer
- * @cmd_pause: true, if pause and thereby resume is supported
+ * @cmd_pause: true, if pause is supported (i.e. for reading residue or
+ *	       for resume later)
+ * @cmd_resume: true, if resume is supported
  * @cmd_terminate: true, if terminate cmd is supported
  * @residue_granularity: granularity of the reported transfer residue
  * @descriptor_reuse: if a descriptor can be reused by client and
@@ -427,6 +429,7 @@ struct dma_slave_caps {
 	u32 directions;
 	u32 max_burst;
 	bool cmd_pause;
+	bool cmd_resume;
 	bool cmd_terminate;
 	enum dma_residue_granularity residue_granularity;
 	bool descriptor_reuse;
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 56a541b9ff9e..76c46d793843 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -156,7 +156,7 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
 
 	ret = dma_get_slave_caps(chan, &dma_caps);
 	if (ret == 0) {
-		if (dma_caps.cmd_pause)
+		if (dma_caps.cmd_pause && dma_caps.cmd_resume)
 			hw.info |= SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME;
 		if (dma_caps.residue_granularity <= DMA_RESIDUE_GRANULARITY_SEGMENT)
 			hw.info |= SNDRV_PCM_INFO_BATCH;
-- 
2.17.1
