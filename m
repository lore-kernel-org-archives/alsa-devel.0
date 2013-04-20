From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 8/8] ASoC: spear: Use generic dmaengine PCM
Date: Sat, 20 Apr 2013 19:29:07 +0200
Message-ID: <1366478947-9377-8-git-send-email-lars@metafoo.de>
References: <1366478947-9377-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-081.synserver.de (smtp-out-086.synserver.de
 [212.40.185.86])
 by alsa0.perex.cz (Postfix) with ESMTP id 456742651B7
 for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2013 19:30:05 +0200 (CEST)
In-Reply-To: <1366478947-9377-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Use the generic dmaengine PCM driver instead of a custom implementation.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/spear/spear_pcm.c | 152 +++++---------------------------------------
 1 file changed, 15 insertions(+), 137 deletions(-)

diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
index d653763..4707f2b 100644
--- a/sound/soc/spear/spear_pcm.c
+++ b/sound/soc/spear/spear_pcm.c
@@ -13,19 +13,13 @@
 
 #include <linux/module.h>
 #include <linux/dmaengine.h>
-#include <linux/dma-mapping.h>
-#include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/scatterlist.h>
-#include <linux/slab.h>
-#include <sound/core.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/pcm.h>
-#include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/spear_dma.h>
 
-struct snd_pcm_hardware spear_pcm_hardware = {
+static const struct snd_pcm_hardware spear_pcm_hardware = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
 		 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),
@@ -37,149 +31,33 @@ struct snd_pcm_hardware spear_pcm_hardware = {
 	.fifo_size = 0, /* fifo size in bytes */
 };
 
-static int spear_pcm_hw_params(struct snd_pcm_substream *substream,
-		struct snd_pcm_hw_params *params)
+static struct dma_chan *spear_pcm_request_chan(struct snd_soc_pcm_runtime *rtd,
+	struct snd_pcm_substream *substream)
 {
-	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+	struct spear_dma_data *dma_data;
 
-	return 0;
-}
-
-static int spear_pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	snd_pcm_set_runtime_buffer(substream, NULL);
-
-	return 0;
-}
-
-static int spear_pcm_open(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-
-	struct spear_dma_data *dma_data = (struct spear_dma_data *)
-		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-	int ret;
-
-	ret = snd_soc_set_runtime_hwparams(substream, &spear_pcm_hardware);
-	if (ret)
-		return ret;
+	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
-	return snd_dmaengine_pcm_open_request_chan(substream, dma_data->filter,
-				dma_data);
+	return snd_dmaengine_pcm_request_channel(dma_data->filter, dma_data);
 }
 
-static int spear_pcm_mmap(struct snd_pcm_substream *substream,
-		struct vm_area_struct *vma)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-
-	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
-			runtime->dma_area, runtime->dma_addr,
-			runtime->dma_bytes);
-}
-
-static struct snd_pcm_ops spear_pcm_ops = {
-	.open		= spear_pcm_open,
-	.close		= snd_dmaengine_pcm_close_release_chan,
-	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= spear_pcm_hw_params,
-	.hw_free	= spear_pcm_hw_free,
-	.trigger	= snd_dmaengine_pcm_trigger,
-	.pointer	= snd_dmaengine_pcm_pointer,
-	.mmap		= spear_pcm_mmap,
-};
-
-static int
-spear_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream,
-		size_t size)
-{
-	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
-	struct snd_dma_buffer *buf = &substream->dma_buffer;
-
-	buf->dev.type = SNDRV_DMA_TYPE_DEV;
-	buf->dev.dev = pcm->card->dev;
-	buf->private_data = NULL;
-
-	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
-			&buf->addr, GFP_KERNEL);
-	if (!buf->area)
-		return -ENOMEM;
-
-	dev_info(buf->dev.dev,
-			" preallocate_dma_buffer: area=%p, addr=%p, size=%d\n",
-			(void *)buf->area, (void *)buf->addr, size);
-
-	buf->bytes = size;
-	return 0;
-}
-
-static void spear_pcm_free(struct snd_pcm *pcm)
-{
-	struct snd_pcm_substream *substream;
-	struct snd_dma_buffer *buf;
-	int stream;
-
-	for (stream = 0; stream < 2; stream++) {
-		substream = pcm->streams[stream].substream;
-		if (!substream)
-			continue;
-
-		buf = &substream->dma_buffer;
-		if (!buf || !buf->area)
-			continue;
-
-		dma_free_writecombine(pcm->card->dev, buf->bytes,
-				buf->area, buf->addr);
-		buf->area = NULL;
-	}
-}
-
-static u64 spear_pcm_dmamask = DMA_BIT_MASK(32);
-
-static int spear_pcm_new(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_card *card = rtd->card->snd_card;
-	int ret;
-
-	if (!card->dev->dma_mask)
-		card->dev->dma_mask = &spear_pcm_dmamask;
-	if (!card->dev->coherent_dma_mask)
-		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
-
-	if (rtd->cpu_dai->driver->playback.channels_min) {
-		ret = spear_pcm_preallocate_dma_buffer(rtd->pcm,
-				SNDRV_PCM_STREAM_PLAYBACK,
-				spear_pcm_hardware.buffer_bytes_max);
-		if (ret)
-			return ret;
-	}
-
-	if (rtd->cpu_dai->driver->capture.channels_min) {
-		ret = spear_pcm_preallocate_dma_buffer(rtd->pcm,
-				SNDRV_PCM_STREAM_CAPTURE,
-				spear_pcm_hardware.buffer_bytes_max);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-struct snd_soc_platform_driver spear_soc_platform = {
-	.ops		=	&spear_pcm_ops,
-	.pcm_new	=	spear_pcm_new,
-	.pcm_free	=	spear_pcm_free,
+static const struct snd_dmaengine_pcm_config spear_dmaengine_pcm_config = {
+	.pcm_hardware = &spear_pcm_hardware,
+	.compat_request_channel = spear_pcm_request_chan,
+	.prealloc_buffer_size = 16 * 1024,
 };
 
 static int spear_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&pdev->dev, &spear_soc_platform);
+	return snd_dmaengine_pcm_register(&pdev->dev,
+		&spear_dmaengine_pcm_config,
+		SND_DMAENGINE_PCM_FLAG_NO_DT |
+		SND_DMAENGINE_PCM_FLAG_COMPAT);
 }
 
 static int spear_soc_platform_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&pdev->dev);
-
+	snd_dmaengine_pcm_unregister(&pdev->dev);
 	return 0;
 }
 
-- 
1.8.0
