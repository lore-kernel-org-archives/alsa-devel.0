From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 5/7] ASoC i.MX: switch to new DMA api
Date: Thu,  4 Nov 2010 17:05:43 +0100
Message-ID: <1288886745-25977-6-git-send-email-s.hauer@pengutronix.de>
References: <1288886745-25977-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id B330210387B
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 17:05:48 +0100 (CET)
In-Reply-To: <1288886745-25977-1-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/imx/imx-pcm-dma-mx2.c |  221 +++++++++++++++++----------------------
 sound/soc/imx/imx-ssi.h         |    3 +
 2 files changed, 101 insertions(+), 123 deletions(-)

diff --git a/sound/soc/imx/imx-pcm-dma-mx2.c b/sound/soc/imx/imx-pcm-dma-mx2.c
index fd493ee..671ef8d 100644
--- a/sound/soc/imx/imx-pcm-dma-mx2.c
+++ b/sound/soc/imx/imx-pcm-dma-mx2.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/dmaengine.h>
 
 #include <sound/core.h>
 #include <sound/initval.h>
@@ -27,165 +28,146 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-#include <mach/dma-mx1-mx2.h>
+#include <mach/dma.h>
 
 #include "imx-ssi.h"
 
 struct imx_pcm_runtime_data {
-	int sg_count;
-	struct scatterlist *sg_list;
-	int period;
+	int period_bytes;
 	int periods;
-	unsigned long dma_addr;
 	int dma;
-	struct snd_pcm_substream *substream;
 	unsigned long offset;
 	unsigned long size;
-	unsigned long period_cnt;
 	void *buf;
 	int period_time;
+	struct dma_async_tx_descriptor *desc;
+	struct dma_chan *dma_chan;
+	struct imx_dma_data dma_data;
 };
 
-/* Called by the DMA framework when a period has elapsed */
-static void imx_ssi_dma_progression(int channel, void *data,
-					struct scatterlist *sg)
+static void audio_dma_irq(void *data)
 {
-	struct snd_pcm_substream *substream = data;
+	struct snd_pcm_substream *substream = (struct snd_pcm_substream *)data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
 
-	if (!sg)
-		return;
-
-	runtime = iprtd->substream->runtime;
+	iprtd->offset += iprtd->period_bytes;
+	iprtd->offset %= iprtd->period_bytes * iprtd->periods;
 
-	iprtd->offset = sg->dma_address - runtime->dma_addr;
-
-	snd_pcm_period_elapsed(iprtd->substream);
+	snd_pcm_period_elapsed(substream);
 }
 
-static void imx_ssi_dma_callback(int channel, void *data)
+static bool filter(struct dma_chan *chan, void *param)
 {
-	pr_err("%s shouldn't be called\n", __func__);
-}
+	struct imx_pcm_runtime_data *iprtd = param;
 
-static void snd_imx_dma_err_callback(int channel, void *data, int err)
-{
-	struct snd_pcm_substream *substream = data;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct imx_pcm_dma_params *dma_params = 
-		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
-	int ret;
+	if (!imx_dma_is_general_purpose(chan))
+		return false;
 
-	pr_err("DMA timeout on channel %d -%s%s%s%s\n",
-		 channel,
-		 err & IMX_DMA_ERR_BURST ?    " burst" : "",
-		 err & IMX_DMA_ERR_REQUEST ?  " request" : "",
-		 err & IMX_DMA_ERR_TRANSFER ? " transfer" : "",
-		 err & IMX_DMA_ERR_BUFFER ?   " buffer" : "");
+        chan->private = &iprtd->dma_data;
 
-	imx_dma_disable(iprtd->dma);
-	ret = imx_dma_setup_sg(iprtd->dma, iprtd->sg_list, iprtd->sg_count,
-			IMX_DMA_LENGTH_LOOP, dma_params->dma_addr,
-			substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
-			DMA_MODE_WRITE : DMA_MODE_READ);
-	if (!ret)
-		imx_dma_enable(iprtd->dma);
+        return true;
 }
 
-static int imx_ssi_dma_alloc(struct snd_pcm_substream *substream)
+static int imx_ssi_dma_alloc(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct imx_pcm_dma_params *dma_params;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
+	struct dma_slave_config slave_config;
+	dma_cap_mask_t mask;
+	enum dma_slave_buswidth buswidth;
 	int ret;
 
 	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
-	iprtd->dma = imx_dma_request_by_prio(DRV_NAME, DMA_PRIO_HIGH);
-	if (iprtd->dma < 0) {
-		pr_err("Failed to claim the audio DMA\n");
-		return -ENODEV;
-	}
+	iprtd->dma_data.peripheral_type = IMX_DMATYPE_SSI;
+	iprtd->dma_data.priority = DMA_PRIO_HIGH;
+	iprtd->dma_data.dma_request = dma_params->dma;
 
-	ret = imx_dma_setup_handlers(iprtd->dma,
-				imx_ssi_dma_callback,
-				snd_imx_dma_err_callback, substream);
-	if (ret)
-		goto out;
+	/* Try to grab a DMA channel */
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	iprtd->dma_chan = dma_request_channel(mask, filter, iprtd);
+	if (!iprtd->dma_chan)
+		return -EINVAL;
 
-	ret = imx_dma_setup_progression_handler(iprtd->dma,
-			imx_ssi_dma_progression);
-	if (ret) {
-		pr_err("Failed to setup the DMA handler\n");
-		goto out;
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+	case SNDRV_PCM_FORMAT_S24_LE:
+		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
+	default:
+		return 0;
 	}
 
-	ret = imx_dma_config_channel(iprtd->dma,
-			IMX_DMA_MEMSIZE_16 | IMX_DMA_TYPE_FIFO,
-			IMX_DMA_MEMSIZE_32 | IMX_DMA_TYPE_LINEAR,
-			dma_params->dma, 1);
-	if (ret < 0) {
-		pr_err("Cannot configure DMA channel: %d\n", ret);
-		goto out;
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		slave_config.direction = DMA_TO_DEVICE;
+		slave_config.dst_addr = dma_params->dma_addr;
+		slave_config.dst_addr_width = buswidth;
+		slave_config.dst_maxburst = dma_params->burstsize;
+	} else {
+		slave_config.direction = DMA_FROM_DEVICE;
+		slave_config.src_addr = dma_params->dma_addr;
+		slave_config.src_addr_width = buswidth;
+		slave_config.src_maxburst = dma_params->burstsize;
 	}
 
-	imx_dma_config_burstlen(iprtd->dma, dma_params->burstsize * 2);
+	ret = dmaengine_slave_config(iprtd->dma_chan, &slave_config);
+	if (ret)
+		return ret;
 
 	return 0;
-out:
-	imx_dma_free(iprtd->dma);
-	return ret;
 }
 
 static int snd_imx_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
-	int i;
 	unsigned long dma_addr;
+	struct dma_chan *chan;
+	struct imx_pcm_dma_params *dma_params;
+	int ret;
 
-	imx_ssi_dma_alloc(substream);
+	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+	ret = imx_ssi_dma_alloc(substream, params);
+	if (ret)
+		return ret;
+	chan = iprtd->dma_chan;
 
 	iprtd->size = params_buffer_bytes(params);
 	iprtd->periods = params_periods(params);
-	iprtd->period = params_period_bytes(params);
+	iprtd->period_bytes = params_period_bytes(params);
 	iprtd->offset = 0;
 	iprtd->period_time = HZ / (params_rate(params) /
 			params_period_size(params));
 
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 
-	if (iprtd->sg_count != iprtd->periods) {
-		kfree(iprtd->sg_list);
-
-		iprtd->sg_list = kcalloc(iprtd->periods + 1,
-				sizeof(struct scatterlist), GFP_KERNEL);
-		if (!iprtd->sg_list)
-			return -ENOMEM;
-		iprtd->sg_count = iprtd->periods + 1;
-	}
-
-	sg_init_table(iprtd->sg_list, iprtd->sg_count);
 	dma_addr = runtime->dma_addr;
 
-	for (i = 0; i < iprtd->periods; i++) {
-		iprtd->sg_list[i].page_link = 0;
-		iprtd->sg_list[i].offset = 0;
-		iprtd->sg_list[i].dma_address = dma_addr;
-		iprtd->sg_list[i].length = iprtd->period;
-		dma_addr += iprtd->period;
+	iprtd->buf = (unsigned int *)substream->dma_buffer.area;
+
+	iprtd->desc = chan->device->device_prep_dma_cyclic(chan, dma_addr,
+			iprtd->period_bytes * iprtd->periods,
+			iprtd->period_bytes,
+			substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+			DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	if (!iprtd->desc) {
+		dev_err(&chan->dev->device, "cannot prepare slave dma\n");
+		return -EINVAL;
 	}
 
-	/* close the loop */
-	iprtd->sg_list[iprtd->sg_count - 1].offset = 0;
-	iprtd->sg_list[iprtd->sg_count - 1].length = 0;
-	iprtd->sg_list[iprtd->sg_count - 1].page_link =
-			((unsigned long) iprtd->sg_list | 0x01) & ~0x02;
+	iprtd->desc->callback = audio_dma_irq;
+	iprtd->desc->callback_param = substream;
+
 	return 0;
 }
 
@@ -194,41 +176,21 @@ static int snd_imx_pcm_hw_free(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
 
-	if (iprtd->dma >= 0) {
-		imx_dma_free(iprtd->dma);
-		iprtd->dma = -EINVAL;
+	if (iprtd->dma_chan) {
+		dma_release_channel(iprtd->dma_chan);
+		iprtd->dma_chan = NULL;
 	}
 
-	kfree(iprtd->sg_list);
-	iprtd->sg_list = NULL;
-
 	return 0;
 }
 
 static int snd_imx_pcm_prepare(struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct imx_pcm_dma_params *dma_params;
-	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
-	int err;
 
 	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
-	iprtd->substream = substream;
-	iprtd->buf = (unsigned int *)substream->dma_buffer.area;
-	iprtd->period_cnt = 0;
-
-	pr_debug("%s: buf: %p period: %d periods: %d\n",
-			__func__, iprtd->buf, iprtd->period, iprtd->periods);
-
-	err = imx_dma_setup_sg(iprtd->dma, iprtd->sg_list, iprtd->sg_count,
-			IMX_DMA_LENGTH_LOOP, dma_params->dma_addr,
-			substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
-			DMA_MODE_WRITE : DMA_MODE_READ);
-	if (err)
-		return err;
-
 	return 0;
 }
 
@@ -241,14 +203,14 @@ static int snd_imx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		imx_dma_enable(iprtd->dma);
+		dmaengine_submit(iprtd->desc);
 
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		imx_dma_disable(iprtd->dma);
+		dmaengine_terminate_all(iprtd->dma_chan);
 
 		break;
 	default:
@@ -263,6 +225,9 @@ static snd_pcm_uframes_t snd_imx_pcm_pointer(struct snd_pcm_substream *substream
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
 
+	pr_debug("%s: %ld %ld\n", __func__, iprtd->offset,
+			bytes_to_frames(substream->runtime, iprtd->offset));
+
 	return bytes_to_frames(substream->runtime, iprtd->offset);
 }
 
@@ -279,7 +244,7 @@ static struct snd_pcm_hardware snd_imx_hardware = {
 	.channels_max = 2,
 	.buffer_bytes_max = IMX_SSI_DMABUF_SIZE,
 	.period_bytes_min = 128,
-	.period_bytes_max = 16 * 1024,
+	.period_bytes_max = 65535, /* Limited by SDMA engine */
 	.periods_min = 2,
 	.periods_max = 255,
 	.fifo_size = 0,
@@ -304,11 +269,23 @@ static int snd_imx_open(struct snd_pcm_substream *substream)
 	}
 
 	snd_soc_set_runtime_hwparams(substream, &snd_imx_hardware);
+
+	return 0;
+}
+
+static int snd_imx_close(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
+
+	kfree(iprtd);
+
 	return 0;
 }
 
 static struct snd_pcm_ops imx_pcm_ops = {
 	.open		= snd_imx_open,
+	.close		= snd_imx_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= snd_imx_pcm_hw_params,
 	.hw_free	= snd_imx_pcm_hw_free,
@@ -340,7 +317,6 @@ static struct platform_driver imx_pcm_driver = {
 			.name = "imx-pcm-audio",
 			.owner = THIS_MODULE,
 	},
-
 	.probe = imx_soc_platform_probe,
 	.remove = __devexit_p(imx_soc_platform_remove),
 };
@@ -356,4 +332,3 @@ static void __exit snd_imx_pcm_exit(void)
 	platform_driver_unregister(&imx_pcm_driver);
 }
 module_exit(snd_imx_pcm_exit);
-
diff --git a/sound/soc/imx/imx-ssi.h b/sound/soc/imx/imx-ssi.h
index 4fc17da..a4406a1 100644
--- a/sound/soc/imx/imx-ssi.h
+++ b/sound/soc/imx/imx-ssi.h
@@ -185,6 +185,9 @@
 
 #define DRV_NAME "imx-ssi"
 
+#include <linux/dmaengine.h>
+#include <mach/dma.h>
+
 struct imx_pcm_dma_params {
 	int dma;
 	unsigned long dma_addr;
-- 
1.7.2.3
