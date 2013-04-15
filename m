From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/17] ASoC: tegra: Use generic dmaengine PCM
Date: Mon, 15 Apr 2013 19:19:52 +0200
Message-ID: <1366046404-8759-6-git-send-email-lars@metafoo.de>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-031.synserver.de (smtp-out-037.synserver.de
 [212.40.185.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 71B1E265206
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 19:21:13 +0200 (CEST)
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
 sound/soc/tegra/Kconfig     |   2 +-
 sound/soc/tegra/tegra_pcm.c | 171 +++-----------------------------------------
 2 files changed, 10 insertions(+), 163 deletions(-)

diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
index dbc27ce..b1c9d57 100644
--- a/sound/soc/tegra/Kconfig
+++ b/sound/soc/tegra/Kconfig
@@ -2,7 +2,7 @@ config SND_SOC_TEGRA
 	tristate "SoC Audio for the Tegra System-on-Chip"
 	depends on ARCH_TEGRA && TEGRA20_APB_DMA
 	select REGMAP_MMIO
-	select SND_SOC_DMAENGINE_PCM if TEGRA20_APB_DMA
+	select SND_SOC_GENERIC_DMAENGINE_PCM if TEGRA20_APB_DMA
 	help
 	  Say Y or M here if you want support for SoC audio on Tegra.
 
diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c
index f9f247c..f056f63 100644
--- a/sound/soc/tegra/tegra_pcm.c
+++ b/sound/soc/tegra/tegra_pcm.c
@@ -29,9 +29,7 @@
  *
  */
 
-#include <linux/dma-mapping.h>
 #include <linux/module.h>
-#include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -55,175 +53,24 @@ static const struct snd_pcm_hardware tegra_pcm_hardware = {
 	.fifo_size		= 4,
 };
 
-static int tegra_pcm_open(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct device *dev = rtd->platform->dev;
-	int ret;
-
-	/* Set HW params now that initialization is complete */
-	snd_soc_set_runtime_hwparams(substream, &tegra_pcm_hardware);
-
-	ret = snd_dmaengine_pcm_open_request_chan(substream, NULL, NULL);
-	if (ret) {
-		dev_err(dev, "dmaengine pcm open failed with err %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int tegra_pcm_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct device *dev = rtd->platform->dev;
-	struct dma_chan *chan = snd_dmaengine_pcm_get_chan(substream);
-	struct dma_slave_config slave_config;
-	int ret;
-
-	ret = snd_hwparams_to_dma_slave_config(substream, params,
-						&slave_config);
-	if (ret) {
-		dev_err(dev, "hw params config failed with err %d\n", ret);
-		return ret;
-	}
-
-	snd_dmaengine_pcm_set_config_from_dai_data(substream,
-			snd_soc_dai_get_dma_data(rtd->cpu_dai, substream),
-			&slave_config);
-
-	ret = dmaengine_slave_config(chan, &slave_config);
-	if (ret < 0) {
-		dev_err(dev, "dma slave config failed with err %d\n", ret);
-		return ret;
-	}
-
-	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
-	return 0;
-}
-
-static int tegra_pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	snd_pcm_set_runtime_buffer(substream, NULL);
-	return 0;
-}
-
-static int tegra_pcm_mmap(struct snd_pcm_substream *substream,
-				struct vm_area_struct *vma)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-
-	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
-					runtime->dma_area,
-					runtime->dma_addr,
-					runtime->dma_bytes);
-}
-
-static struct snd_pcm_ops tegra_pcm_ops = {
-	.open		= tegra_pcm_open,
-	.close		= snd_dmaengine_pcm_close_release_chan,
-	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= tegra_pcm_hw_params,
-	.hw_free	= tegra_pcm_hw_free,
-	.trigger	= snd_dmaengine_pcm_trigger,
-	.pointer	= snd_dmaengine_pcm_pointer,
-	.mmap		= tegra_pcm_mmap,
-};
-
-static int tegra_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
-{
-	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
-	struct snd_dma_buffer *buf = &substream->dma_buffer;
-	size_t size = tegra_pcm_hardware.buffer_bytes_max;
-
-	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
-						&buf->addr, GFP_KERNEL);
-	if (!buf->area)
-		return -ENOMEM;
-
-	buf->dev.type = SNDRV_DMA_TYPE_DEV;
-	buf->dev.dev = pcm->card->dev;
-	buf->private_data = NULL;
-	buf->bytes = size;
-
-	return 0;
-}
-
-static void tegra_pcm_deallocate_dma_buffer(struct snd_pcm *pcm, int stream)
-{
-	struct snd_pcm_substream *substream;
-	struct snd_dma_buffer *buf;
-
-	substream = pcm->streams[stream].substream;
-	if (!substream)
-		return;
-
-	buf = &substream->dma_buffer;
-	if (!buf->area)
-		return;
-
-	dma_free_writecombine(pcm->card->dev, buf->bytes,
-				buf->area, buf->addr);
-	buf->area = NULL;
-}
-
-static u64 tegra_dma_mask = DMA_BIT_MASK(32);
-
-static int tegra_pcm_new(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_card *card = rtd->card->snd_card;
-	struct snd_pcm *pcm = rtd->pcm;
-	int ret = 0;
-
-	if (!card->dev->dma_mask)
-		card->dev->dma_mask = &tegra_dma_mask;
-	if (!card->dev->coherent_dma_mask)
-		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
-
-	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
-		ret = tegra_pcm_preallocate_dma_buffer(pcm,
-						SNDRV_PCM_STREAM_PLAYBACK);
-		if (ret)
-			goto err;
-	}
-
-	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
-		ret = tegra_pcm_preallocate_dma_buffer(pcm,
-						SNDRV_PCM_STREAM_CAPTURE);
-		if (ret)
-			goto err_free_play;
-	}
-
-	return 0;
-
-err_free_play:
-	tegra_pcm_deallocate_dma_buffer(pcm, SNDRV_PCM_STREAM_PLAYBACK);
-err:
-	return ret;
-}
-
-static void tegra_pcm_free(struct snd_pcm *pcm)
-{
-	tegra_pcm_deallocate_dma_buffer(pcm, SNDRV_PCM_STREAM_CAPTURE);
-	tegra_pcm_deallocate_dma_buffer(pcm, SNDRV_PCM_STREAM_PLAYBACK);
-}
-
-static struct snd_soc_platform_driver tegra_pcm_platform = {
-	.ops		= &tegra_pcm_ops,
-	.pcm_new	= tegra_pcm_new,
-	.pcm_free	= tegra_pcm_free,
+static const struct snd_dmaengine_pcm_config tegra_dmaengine_pcm_config = {
+	.pcm_hardware = &tegra_pcm_hardware,
+	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
+	.compat_filter_fn = NULL,
+	.prealloc_buffer_size = PAGE_SIZE * 8,
 };
 
 int tegra_pcm_platform_register(struct device *dev)
 {
-	return snd_soc_register_platform(dev, &tegra_pcm_platform);
+	return snd_dmaengine_pcm_register(dev, &tegra_dmaengine_pcm_config,
+			SND_DMAENGINE_PCM_FLAG_NO_DT |
+			SND_DMAENGINE_PCM_FLAG_COMPAT);
 }
 EXPORT_SYMBOL_GPL(tegra_pcm_platform_register);
 
 void tegra_pcm_platform_unregister(struct device *dev)
 {
-	snd_soc_unregister_platform(dev);
+	return snd_dmaengine_pcm_unregister(dev);
 }
 EXPORT_SYMBOL_GPL(tegra_pcm_platform_unregister);
 
-- 
1.8.0
