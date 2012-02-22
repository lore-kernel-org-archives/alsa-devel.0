From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [RFC 5/7] ASoC: imx-pcm-dma: Use dmaengine PCM helper
	functions
Date: Wed, 22 Feb 2012 10:49:09 +0100
Message-ID: <1329904151-5927-6-git-send-email-lars@metafoo.de>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-093.synserver.de
	[212.40.185.93]) by alsa0.perex.cz (Postfix) with ESMTP id 1C75424577
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 10:47:49 +0100 (CET)
In-Reply-To: <1329904151-5927-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Mika Westerberg <mika.westerberg@iki.fi>, Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/imx/Kconfig           |    1 +
 sound/soc/imx/imx-pcm-dma-mx2.c |  176 ++++++---------------------------------
 2 files changed, 28 insertions(+), 149 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index 91b66ef..08c4b9b 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -14,6 +14,7 @@ config SND_MXC_SOC_FIQ
 	tristate
 
 config SND_MXC_SOC_MX2
+	select SND_SOC_DMAENGINE_PCM
 	tristate
 
 config SND_MXC_SOC_WM1133_EV1
diff --git a/sound/soc/imx/imx-pcm-dma-mx2.c b/sound/soc/imx/imx-pcm-dma-mx2.c
index f974e61..4cd5462 100644
--- a/sound/soc/imx/imx-pcm-dma-mx2.c
+++ b/sound/soc/imx/imx-pcm-dma-mx2.c
@@ -27,104 +27,42 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
 
 #include <mach/dma.h>
 
 #include "imx-ssi.h"
 
-struct imx_pcm_runtime_data {
-	int period_bytes;
-	int periods;
-	unsigned long offset;
-	struct dma_async_tx_descriptor *desc;
-	struct dma_chan *dma_chan;
-	struct imx_dma_data dma_data;
-};
-
-static void audio_dma_irq(void *data)
-{
-	struct snd_pcm_substream *substream = (struct snd_pcm_substream *)data;
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
-
-	iprtd->offset += iprtd->period_bytes;
-	iprtd->offset %= iprtd->period_bytes * iprtd->periods;
-
-	snd_pcm_period_elapsed(substream);
-}
-
 static bool filter(struct dma_chan *chan, void *param)
 {
-	struct imx_pcm_runtime_data *iprtd = param;
-
 	if (!imx_dma_is_general_purpose(chan))
 		return false;
 
-        chan->private = &iprtd->dma_data;
+	chan->private = param;
 
-        return true;
-}
-
-static int imx_ssi_dma_alloc(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct imx_pcm_dma_params *dma_params;
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
-	dma_cap_mask_t mask;
-
-	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-
-	iprtd->dma_data.peripheral_type = IMX_DMATYPE_SSI;
-	iprtd->dma_data.priority = DMA_PRIO_HIGH;
-	iprtd->dma_data.dma_request = dma_params->dma;
-
-	/* Try to grab a DMA channel */
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	iprtd->dma_chan = dma_request_channel(mask, filter, iprtd);
-	if (!iprtd->dma_chan)
-		return -EINVAL;
-
-	return 0;
+	return true;
 }
 
 static int snd_imx_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
-	struct dma_chan *chan = iprtd->dma_chan;
+	struct dma_chan *chan = snd_dmaengine_pcm_get_chan(substream);
 	struct imx_pcm_dma_params *dma_params;
 	struct dma_slave_config slave_config;
-	enum dma_slave_buswidth buswidth;
-	unsigned long dma_addr;
 	int ret;
 
 	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
-		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
-		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
-	case SNDRV_PCM_FORMAT_S24_LE:
-		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		break;
-	default:
-		return 0;
-	}
+	ret = snd_hwparams_to_dma_slave_config(substream, params, &slave_config);
+	if (ret)
+		return ret;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		slave_config.direction = DMA_MEM_TO_DEV;
 		slave_config.dst_addr = dma_params->dma_addr;
-		slave_config.dst_addr_width = buswidth;
 		slave_config.dst_maxburst = dma_params->burstsize;
 	} else {
-		slave_config.direction = DMA_DEV_TO_MEM;
 		slave_config.src_addr = dma_params->dma_addr;
-		slave_config.src_addr_width = buswidth;
 		slave_config.src_maxburst = dma_params->burstsize;
 	}
 
@@ -132,68 +70,11 @@ static int snd_imx_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (ret)
 		return ret;
 
-
-	iprtd->periods = params_periods(params);
-	iprtd->period_bytes = params_period_bytes(params);
-	iprtd->offset = 0;
-
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 
-	dma_addr = runtime->dma_addr;
-
-	iprtd->desc = chan->device->device_prep_dma_cyclic(chan, dma_addr,
-			iprtd->period_bytes * iprtd->periods,
-			iprtd->period_bytes,
-			substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
-			DMA_MEM_TO_DEV : DMA_DEV_TO_MEM);
-	if (!iprtd->desc) {
-		dev_err(&chan->dev->device, "cannot prepare slave dma\n");
-		return -EINVAL;
-	}
-
-	iprtd->desc->callback = audio_dma_irq;
-	iprtd->desc->callback_param = substream;
-
-	return 0;
-}
-
-static int snd_imx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		dmaengine_submit(iprtd->desc);
-
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		dmaengine_terminate_all(iprtd->dma_chan);
-
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
-static snd_pcm_uframes_t snd_imx_pcm_pointer(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
-
-	pr_debug("%s: %ld %ld\n", __func__, iprtd->offset,
-			bytes_to_frames(substream->runtime, iprtd->offset));
-
-	return bytes_to_frames(substream->runtime, iprtd->offset);
-}
-
 static struct snd_pcm_hardware snd_imx_hardware = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -215,40 +96,37 @@ static struct snd_pcm_hardware snd_imx_hardware = {
 
 static int snd_imx_open(struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct imx_pcm_runtime_data *iprtd;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct imx_pcm_dma_params *dma_params;
+	struct imx_dma_data *dma_data;
 	int ret;
 
-	iprtd = kzalloc(sizeof(*iprtd), GFP_KERNEL);
-	if (iprtd == NULL)
-		return -ENOMEM;
-	runtime->private_data = iprtd;
+	snd_soc_set_runtime_hwparams(substream, &snd_imx_hardware);
 
-	ret = snd_pcm_hw_constraint_integer(substream->runtime,
-			SNDRV_PCM_HW_PARAM_PERIODS);
-	if (ret < 0) {
-		kfree(iprtd);
-		return ret;
-	}
+	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
-	ret = imx_ssi_dma_alloc(substream);
-	if (ret < 0) {
-		kfree(iprtd);
-		return ret;
+	dma_data = kzalloc(sizeof(*dma_data), GFP_KERNEL);
+	dma_data->peripheral_type = IMX_DMATYPE_SSI;
+	dma_data->priority = DMA_PRIO_HIGH;
+	dma_data->dma_request = dma_params->dma;
+
+	ret = snd_dmaengine_pcm_open(substream, filter, dma_data);
+	if (ret) {
+		kfree(dma_data);
+		return 0;
 	}
 
-	snd_soc_set_runtime_hwparams(substream, &snd_imx_hardware);
+	snd_dmaengine_pcm_set_data(substream, dma_data);
 
 	return 0;
 }
 
 static int snd_imx_close(struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
+	struct imx_dma_data *dma_data = snd_dmaengine_pcm_get_data(substream);
 
-	dma_release_channel(iprtd->dma_chan);
-	kfree(iprtd);
+	snd_dmaengine_pcm_close(substream);
+	kfree(dma_data);
 
 	return 0;
 }
@@ -258,8 +136,8 @@ static struct snd_pcm_ops imx_pcm_ops = {
 	.close		= snd_imx_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= snd_imx_pcm_hw_params,
-	.trigger	= snd_imx_pcm_trigger,
-	.pointer	= snd_imx_pcm_pointer,
+	.trigger	= snd_dmaengine_pcm_trigger,
+	.pointer	= snd_dmaengine_pcm_pointer,
 	.mmap		= snd_imx_pcm_mmap,
 };
 
-- 
1.7.9
