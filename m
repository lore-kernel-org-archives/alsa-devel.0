From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 16/17] ASoC: ep93xx: Use generic dmaengine PCM
Date: Mon, 15 Apr 2013 19:20:03 +0200
Message-ID: <1366046404-8759-17-git-send-email-lars@metafoo.de>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-031.synserver.de (smtp-out-037.synserver.de
 [212.40.185.37])
 by alsa0.perex.cz (Postfix) with ESMTP id CD11B26523A
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 19:21:37 +0200 (CEST)
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
 sound/soc/cirrus/Kconfig      |   2 +-
 sound/soc/cirrus/ep93xx-i2s.c |   4 +-
 sound/soc/cirrus/ep93xx-pcm.c | 138 ++++--------------------------------------
 3 files changed, 14 insertions(+), 130 deletions(-)

diff --git a/sound/soc/cirrus/Kconfig b/sound/soc/cirrus/Kconfig
index 88143db..2c20f01 100644
--- a/sound/soc/cirrus/Kconfig
+++ b/sound/soc/cirrus/Kconfig
@@ -1,7 +1,7 @@
 config SND_EP93XX_SOC
 	tristate "SoC Audio support for the Cirrus Logic EP93xx series"
 	depends on ARCH_EP93XX && SND_SOC
-	select SND_SOC_DMAENGINE_PCM
+	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the EP93xx I2S or AC97 interfaces.
diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index 453a89c..ef731e6 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -140,8 +140,8 @@ static void ep93xx_i2s_disable(struct ep93xx_i2s_info *info, int stream)
 
 static int ep93xx_i2s_dai_probe(struct snd_soc_dai *dai)
 {
-	dai->playback_dma_data = ep93xx_i2s_dma_data[SNDRV_PCM_STREAM_PLAYBACK];
-	dai->capute_dma_data = ep93xx_i2s_dma_data[SNDRV_PCM_STREAM_CAPTURE]
+	dai->playback_dma_data = &ep93xx_i2s_dma_data[SNDRV_PCM_STREAM_PLAYBACK];
+	dai->capture_dma_data = &ep93xx_i2s_dma_data[SNDRV_PCM_STREAM_CAPTURE];
 
 	return 0;
 }
diff --git a/sound/soc/cirrus/ep93xx-pcm.c b/sound/soc/cirrus/ep93xx-pcm.c
index 4880326..0e9f56e 100644
--- a/sound/soc/cirrus/ep93xx-pcm.c
+++ b/sound/soc/cirrus/ep93xx-pcm.c
@@ -14,20 +14,14 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/device.h>
-#include <linux/slab.h>
+#include <linux/platform_device.h>
 #include <linux/dmaengine.h>
-#include <linux/dma-mapping.h>
 
-#include <sound/core.h>
 #include <sound/pcm.h>
-#include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
 
 #include <linux/platform_data/dma-ep93xx.h>
-#include <mach/hardware.h>
-#include <mach/ep93xx-regs.h>
 
 static const struct snd_pcm_hardware ep93xx_pcm_hardware = {
 	.info			= (SNDRV_PCM_INFO_MMAP		|
@@ -63,134 +57,24 @@ static bool ep93xx_pcm_dma_filter(struct dma_chan *chan, void *filter_param)
 	return false;
 }
 
-static int ep93xx_pcm_open(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-
-	snd_soc_set_runtime_hwparams(substream, &ep93xx_pcm_hardware);
-
-	return snd_dmaengine_pcm_open_request_chan(substream,
-			ep93xx_pcm_dma_filter,
-			snd_soc_dai_get_dma_data(rtd->cpu_dai, substream));
-}
-
-static int ep93xx_pcm_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
-{
-	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
-
-	return 0;
-}
-
-static int ep93xx_pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	snd_pcm_set_runtime_buffer(substream, NULL);
-	return 0;
-}
-
-static int ep93xx_pcm_mmap(struct snd_pcm_substream *substream,
-			   struct vm_area_struct *vma)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-
-	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
-				     runtime->dma_area,
-				     runtime->dma_addr,
-				     runtime->dma_bytes);
-}
-
-static struct snd_pcm_ops ep93xx_pcm_ops = {
-	.open		= ep93xx_pcm_open,
-	.close		= snd_dmaengine_pcm_close_release_chan,
-	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= ep93xx_pcm_hw_params,
-	.hw_free	= ep93xx_pcm_hw_free,
-	.trigger	= snd_dmaengine_pcm_trigger,
-	.pointer	= snd_dmaengine_pcm_pointer_no_residue,
-	.mmap		= ep93xx_pcm_mmap,
-};
-
-static int ep93xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
-{
-	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
-	struct snd_dma_buffer *buf = &substream->dma_buffer;
-	size_t size = ep93xx_pcm_hardware.buffer_bytes_max;
-
-	buf->dev.type = SNDRV_DMA_TYPE_DEV;
-	buf->dev.dev = pcm->card->dev;
-	buf->private_data = NULL;
-	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
-					   &buf->addr, GFP_KERNEL);
-	buf->bytes = size;
-
-	return (buf->area == NULL) ? -ENOMEM : 0;
-}
-
-static void ep93xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
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
-		dma_free_writecombine(pcm->card->dev, buf->bytes, buf->area,
-				      buf->addr);
-		buf->area = NULL;
-	}
-}
-
-static u64 ep93xx_pcm_dmamask = DMA_BIT_MASK(32);
-
-static int ep93xx_pcm_new(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_card *card = rtd->card->snd_card;
-	struct snd_pcm *pcm = rtd->pcm;
-	int ret = 0;
-
-	if (!card->dev->dma_mask)
-		card->dev->dma_mask = &ep93xx_pcm_dmamask;
-	if (!card->dev->coherent_dma_mask)
-		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
-
-	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
-		ret = ep93xx_pcm_preallocate_dma_buffer(pcm,
-					SNDRV_PCM_STREAM_PLAYBACK);
-		if (ret)
-			return ret;
-	}
-
-	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
-		ret = ep93xx_pcm_preallocate_dma_buffer(pcm,
-					SNDRV_PCM_STREAM_CAPTURE);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static struct snd_soc_platform_driver ep93xx_soc_platform = {
-	.ops		= &ep93xx_pcm_ops,
-	.pcm_new	= &ep93xx_pcm_new,
-	.pcm_free	= &ep93xx_pcm_free_dma_buffers,
+static const struct snd_dmaengine_pcm_config ep93xx_dmaengine_pcm_config = {
+	.pcm_hardware = &ep93xx_pcm_hardware,
+	.compat_filter_fn = ep93xx_pcm_dma_filter,
+	.prealloc_buffer_size = 131072,
 };
 
 static int ep93xx_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&pdev->dev, &ep93xx_soc_platform);
+	return snd_dmaengine_pcm_register(&pdev->dev,
+		&ep93xx_dmaengine_pcm_config,
+		SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
+		SND_DMAENGINE_PCM_FLAG_NO_DT |
+		SND_DMAENGINE_PCM_FLAG_COMPAT);
 }
 
 static int ep93xx_soc_platform_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&pdev->dev);
+	snd_dmaengine_pcm_unregister(&pdev->dev);
 	return 0;
 }
 
-- 
1.8.0
