From: Bo Shen <voice.shen@atmel.com>
Subject: [v2 5/5] ASoC: atmel-pcm: use generic dmaengine framework
Date: Wed,  3 Jul 2013 16:38:00 +0800
Message-ID: <1372840680-2253-6-git-send-email-voice.shen@atmel.com>
References: <1372840680-2253-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <1372840680-2253-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, lars@metafoo.de, richard.genoud@gmail.com, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

Align atmel pcm to use ASoC generic dmaengine framework

DMA is fully device tree based

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Change in v2:
  - slipt the prepare function as a seperate patch
  - remove phybase convert as the type change to dma_addr_t
---
 sound/soc/atmel/Kconfig         |    1 +
 sound/soc/atmel/atmel-pcm-dma.c |  104 ++++++---------------------------------
 2 files changed, 17 insertions(+), 88 deletions(-)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 022853f..0cdb097 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -13,6 +13,7 @@ config SND_ATMEL_SOC_PDC
 config SND_ATMEL_SOC_DMA
 	tristate
 	depends on SND_ATMEL_SOC
+	select SND_SOC_GENERIC_DMAENGINE_PCM
 
 config SND_ATMEL_SOC_SSC
 	tristate
diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
index 5a57803..3ff5601 100644
--- a/sound/soc/atmel/atmel-pcm-dma.c
+++ b/sound/soc/atmel/atmel-pcm-dma.c
@@ -89,124 +89,52 @@ static void atmel_pcm_dma_irq(u32 ssc_sr,
 	}
 }
 
-/*--------------------------------------------------------------------------*\
- * DMAENGINE operations
-\*--------------------------------------------------------------------------*/
-static bool filter(struct dma_chan *chan, void *slave)
-{
-	struct at_dma_slave *sl = slave;
-
-	if (sl->dma_dev == chan->device->dev) {
-		chan->private = sl;
-		return true;
-	} else {
-		return false;
-	}
-}
-
 static int atmel_pcm_configure_dma(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params, struct atmel_pcm_dma_params *prtd)
+	struct snd_pcm_hw_params *params, struct dma_slave_config *slave_config)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct atmel_pcm_dma_params *prtd;
 	struct ssc_device *ssc;
-	struct dma_chan *dma_chan;
-	struct dma_slave_config slave_config;
 	int ret;
 
+	prtd = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 	ssc = prtd->ssc;
 
-	ret = snd_hwparams_to_dma_slave_config(substream, params,
-			&slave_config);
+	ret = snd_hwparams_to_dma_slave_config(substream, params, slave_config);
 	if (ret) {
 		pr_err("atmel-pcm: hwparams to dma slave configure failed\n");
 		return ret;
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		slave_config.dst_addr = (dma_addr_t)ssc->phybase + SSC_THR;
-		slave_config.dst_maxburst = 1;
+		slave_config->dst_addr = ssc->phybase + SSC_THR;
+		slave_config->dst_maxburst = 1;
 	} else {
-		slave_config.src_addr = (dma_addr_t)ssc->phybase + SSC_RHR;
-		slave_config.src_maxburst = 1;
-	}
-
-	dma_chan = snd_dmaengine_pcm_get_chan(substream);
-	if (dmaengine_slave_config(dma_chan, &slave_config)) {
-		pr_err("atmel-pcm: failed to configure dma channel\n");
-		ret = -EBUSY;
-		return ret;
-	}
-
-	return 0;
-}
-
-static int atmel_pcm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct atmel_pcm_dma_params *prtd;
-	struct ssc_device *ssc;
-	struct at_dma_slave *sdata = NULL;
-	int ret;
-
-	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
-
-	prtd = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-	ssc = prtd->ssc;
-	if (ssc->pdev)
-		sdata = ssc->pdev->dev.platform_data;
-
-	ret = snd_dmaengine_pcm_open_request_chan(substream, filter, sdata);
-	if (ret) {
-		pr_err("atmel-pcm: dmaengine pcm open failed\n");
-		return -EINVAL;
-	}
-
-	ret = atmel_pcm_configure_dma(substream, params, prtd);
-	if (ret) {
-		pr_err("atmel-pcm: failed to configure dmai\n");
-		goto err;
+		slave_config->src_addr = ssc->phybase + SSC_RHR;
+		slave_config->src_maxburst = 1;
 	}
 
 	prtd->dma_intr_handler = atmel_pcm_dma_irq;
 
 	return 0;
-err:
-	snd_dmaengine_pcm_close_release_chan(substream);
-	return ret;
-}
-
-static int atmel_pcm_open(struct snd_pcm_substream *substream)
-{
-	snd_soc_set_runtime_hwparams(substream, &atmel_pcm_dma_hardware);
-
-	return 0;
 }
 
-static struct snd_pcm_ops atmel_pcm_ops = {
-	.open		= atmel_pcm_open,
-	.close		= snd_dmaengine_pcm_close_release_chan,
-	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= atmel_pcm_hw_params,
-	.trigger	= snd_dmaengine_pcm_trigger,
-	.pointer	= snd_dmaengine_pcm_pointer_no_residue,
-	.mmap		= atmel_pcm_mmap,
-};
-
-static struct snd_soc_platform_driver atmel_soc_platform = {
-	.ops		= &atmel_pcm_ops,
-	.pcm_new	= atmel_pcm_new,
-	.pcm_free	= atmel_pcm_free,
+static const struct snd_dmaengine_pcm_config atmel_dmaengine_pcm_config = {
+	.prepare_slave_config = atmel_pcm_configure_dma,
+	.pcm_hardware = &atmel_pcm_dma_hardware,
+	.prealloc_buffer_size = ATMEL_SSC_DMABUF_SIZE,
 };
 
 int atmel_pcm_dma_platform_register(struct device *dev)
 {
-	return snd_soc_register_platform(dev, &atmel_soc_platform);
+	return snd_dmaengine_pcm_register(dev, &atmel_dmaengine_pcm_config,
+			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
 }
 EXPORT_SYMBOL(atmel_pcm_dma_platform_register);
 
 void atmel_pcm_dma_platform_unregister(struct device *dev)
 {
-	snd_soc_unregister_platform(dev);
+	snd_dmaengine_pcm_unregister(dev);
 }
 EXPORT_SYMBOL(atmel_pcm_dma_platform_unregister);
 
-- 
1.7.9.5

