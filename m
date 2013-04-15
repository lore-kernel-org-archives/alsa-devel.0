From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 14/17] ASoC: omap: Use generic dmaengine PCM
Date: Mon, 15 Apr 2013 19:20:01 +0200
Message-ID: <1366046404-8759-15-git-send-email-lars@metafoo.de>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-031.synserver.de (smtp-out-037.synserver.de
 [212.40.185.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 62CA8265262
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 19:21:32 +0200 (CEST)
In-Reply-To: <1366046404-8759-1-git-send-email-lars@metafoo.de>
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Use the generic dmaengine PCM driver instead of a custom implementation.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/omap/Kconfig    |   2 +-
 sound/soc/omap/omap-pcm.c | 187 ++++------------------------------------------
 2 files changed, 17 insertions(+), 172 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 60259f2..fbb006b 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -1,7 +1,7 @@
 config SND_OMAP_SOC
 	tristate "SoC Audio for the Texas Instruments OMAP chips"
 	depends on ARCH_OMAP && DMA_OMAP
-	select SND_SOC_DMAENGINE_PCM
+	select SND_SOC_GENERIC_DMAENGINE_PCM
 
 config SND_OMAP_SOC_DMIC
 	tristate
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index c28e042..87dbc7b 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -22,13 +22,10 @@
  *
  */
 
-#include <linux/dma-mapping.h>
-#include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/omap-dma.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
-#include <sound/pcm_params.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/soc.h>
 
@@ -54,187 +51,35 @@ static const struct snd_pcm_hardware omap_pcm_hardware = {
 	.buffer_bytes_max	= 128 * 1024,
 };
 
-/* this may get called several times by oss emulation */
-static int omap_pcm_hw_params(struct snd_pcm_substream *substream,
-			      struct snd_pcm_hw_params *params)
+static bool omap_pcm_filter_fn(struct dma_chan *chan, void *params)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct omap_pcm_dma_data *dma_data;
-	struct dma_slave_config config;
-	struct dma_chan *chan;
-	int err = 0;
+	struct snd_dmaengine_dai_dma_data *dma_data = params;
 
-	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-
-	/* return if this is a bufferless transfer e.g.
-	 * codec <--> BT codec or GSM modem -- lg FIXME */
-	if (!dma_data)
-		return 0;
-
-	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
-	runtime->dma_bytes = params_buffer_bytes(params);
-
-	chan = snd_dmaengine_pcm_get_chan(substream);
-	if (!chan)
-		return -EINVAL;
-
-	/* fills in addr_width and direction */
-	err = snd_hwparams_to_dma_slave_config(substream, params, &config);
-	if (err)
-		return err;
-
-	snd_dmaengine_pcm_set_config_from_dai_data(substream,
-			snd_soc_dai_get_dma_data(rtd->cpu_dai, substream),
-			&config);
-
-	return dmaengine_slave_config(chan, &config);
-}
-
-static int omap_pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	snd_pcm_set_runtime_buffer(substream, NULL);
-	return 0;
-}
-
-static snd_pcm_uframes_t omap_pcm_pointer(struct snd_pcm_substream *substream)
-{
-	snd_pcm_uframes_t offset;
-
-	if (pcm_omap1510())
-		offset = snd_dmaengine_pcm_pointer_no_residue(substream);
-	else
-		offset = snd_dmaengine_pcm_pointer(substream);
-
-	return offset;
-}
-
-static int omap_pcm_open(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_dmaengine_dai_dma_data *dma_data;
-
-	snd_soc_set_runtime_hwparams(substream, &omap_pcm_hardware);
-
-	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-
-	return snd_dmaengine_pcm_open_request_chan(substream,
-						   omap_dma_filter_fn,
-						   dma_data->filter_data);
-}
-
-static int omap_pcm_mmap(struct snd_pcm_substream *substream,
-	struct vm_area_struct *vma)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-
-	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
-				     runtime->dma_area,
-				     runtime->dma_addr,
-				     runtime->dma_bytes);
+	return omap_dma_filter_fn(chan, dma_data->filter_data);
 }
 
-static struct snd_pcm_ops omap_pcm_ops = {
-	.open		= omap_pcm_open,
-	.close		= snd_dmaengine_pcm_close_release_chan,
-	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= omap_pcm_hw_params,
-	.hw_free	= omap_pcm_hw_free,
-	.trigger	= snd_dmaengine_pcm_trigger,
-	.pointer	= omap_pcm_pointer,
-	.mmap		= omap_pcm_mmap,
+static const struct snd_dmaengine_pcm_config omap_dmaengine_pcm_config = {
+	.pcm_hardware = &omap_pcm_hardware,
+	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
+	.compat_filter_fn = omap_pcm_filter_fn,
+	.prealloc_buffer_size = 128 * 1024,
 };
 
-static u64 omap_pcm_dmamask = DMA_BIT_MASK(64);
-
-static int omap_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
-	int stream)
-{
-	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
-	struct snd_dma_buffer *buf = &substream->dma_buffer;
-	size_t size = omap_pcm_hardware.buffer_bytes_max;
-
-	buf->dev.type = SNDRV_DMA_TYPE_DEV;
-	buf->dev.dev = pcm->card->dev;
-	buf->private_data = NULL;
-	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
-					   &buf->addr, GFP_KERNEL);
-	if (!buf->area)
-		return -ENOMEM;
-
-	buf->bytes = size;
-	return 0;
-}
-
-static void omap_pcm_free_dma_buffers(struct snd_pcm *pcm)
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
-		if (!buf->area)
-			continue;
-
-		dma_free_writecombine(pcm->card->dev, buf->bytes,
-				      buf->area, buf->addr);
-		buf->area = NULL;
-	}
-}
-
-static int omap_pcm_new(struct snd_soc_pcm_runtime *rtd)
+static int omap_pcm_probe(struct platform_device *pdev)
 {
-	struct snd_card *card = rtd->card->snd_card;
-	struct snd_pcm *pcm = rtd->pcm;
-	int ret = 0;
-
-	if (!card->dev->dma_mask)
-		card->dev->dma_mask = &omap_pcm_dmamask;
-	if (!card->dev->coherent_dma_mask)
-		card->dev->coherent_dma_mask = DMA_BIT_MASK(64);
-
-	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
-		ret = omap_pcm_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_PLAYBACK);
-		if (ret)
-			goto out;
-	}
-
-	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
-		ret = omap_pcm_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_CAPTURE);
-		if (ret)
-			goto out;
-	}
-
-out:
-	/* free preallocated buffers in case of error */
-	if (ret)
-		omap_pcm_free_dma_buffers(pcm);
+	unsigned int flags = SND_DMAENGINE_PCM_FLAG_NO_DT |
+		SND_DMAENGINE_PCM_FLAG_COMPAT;
 
-	return ret;
-}
-
-static struct snd_soc_platform_driver omap_soc_platform = {
-	.ops		= &omap_pcm_ops,
-	.pcm_new	= omap_pcm_new,
-	.pcm_free	= omap_pcm_free_dma_buffers,
-};
+	if (pcm_omap1510())
+		flags |= SND_DMAENGINE_PCM_FLAG_NO_RESIDUE;
 
-static int omap_pcm_probe(struct platform_device *pdev)
-{
-	return snd_soc_register_platform(&pdev->dev,
-			&omap_soc_platform);
+	return snd_dmaengine_pcm_register(&pdev->dev,
+		&omap_dmaengine_pcm_config, flags);
 }
 
 static int omap_pcm_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&pdev->dev);
+	snd_dmaengine_pcm_unregister(&pdev->dev);
 	return 0;
 }
 
-- 
1.8.0
