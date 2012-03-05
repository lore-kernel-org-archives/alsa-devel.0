From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: ep93xx-pcm: Use dmaengine PCM helper
	functions
Date: Mon,  5 Mar 2012 14:02:15 +0100
Message-ID: <1330952535-30614-2-git-send-email-lars@metafoo.de>
References: <1330952535-30614-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-211.synserver.de (smtp-out-212.synserver.de
	[212.40.185.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AE3C104188
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 14:00:33 +0100 (CET)
In-Reply-To: <1330952535-30614-1-git-send-email-lars@metafoo.de>
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
Cc: Mika Westerberg <mika.westerberg@iki.fi>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Vinod Koul <vinod.koul@linux.intel.com>
Tested-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 sound/soc/ep93xx/Kconfig      |    1 +
 sound/soc/ep93xx/ep93xx-pcm.c |  148 ++++++-----------------------------------
 2 files changed, 23 insertions(+), 126 deletions(-)

diff --git a/sound/soc/ep93xx/Kconfig b/sound/soc/ep93xx/Kconfig
index 91a28de..88143db 100644
--- a/sound/soc/ep93xx/Kconfig
+++ b/sound/soc/ep93xx/Kconfig
@@ -1,6 +1,7 @@
 config SND_EP93XX_SOC
 	tristate "SoC Audio support for the Cirrus Logic EP93xx series"
 	depends on ARCH_EP93XX && SND_SOC
+	select SND_SOC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the EP93xx I2S or AC97 interfaces.
diff --git a/sound/soc/ep93xx/ep93xx-pcm.c b/sound/soc/ep93xx/ep93xx-pcm.c
index 32adca3..162dbb7 100644
--- a/sound/soc/ep93xx/ep93xx-pcm.c
+++ b/sound/soc/ep93xx/ep93xx-pcm.c
@@ -23,6 +23,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
 
 #include <mach/dma.h>
 #include <mach/hardware.h>
@@ -52,26 +53,6 @@ static const struct snd_pcm_hardware ep93xx_pcm_hardware = {
 	.fifo_size		= 32,
 };
 
-struct ep93xx_runtime_data
-{
-	int				pointer_bytes;
-	int				periods;
-	int				period_bytes;
-	struct dma_chan			*dma_chan;
-	struct ep93xx_dma_data		dma_data;
-};
-
-static void ep93xx_pcm_dma_callback(void *data)
-{
-	struct snd_pcm_substream *substream = data;
-	struct ep93xx_runtime_data *rtd = substream->runtime->private_data;
-
-	rtd->pointer_bytes += rtd->period_bytes;
-	rtd->pointer_bytes %= rtd->period_bytes * rtd->periods;
-
-	snd_pcm_period_elapsed(substream);
-}
-
 static bool ep93xx_pcm_dma_filter(struct dma_chan *chan, void *filter_param)
 {
 	struct ep93xx_dma_data *data = filter_param;
@@ -86,98 +67,48 @@ static bool ep93xx_pcm_dma_filter(struct dma_chan *chan, void *filter_param)
 
 static int ep93xx_pcm_open(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *soc_rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = soc_rtd->cpu_dai;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct ep93xx_pcm_dma_params *dma_params;
-	struct ep93xx_runtime_data *rtd;    
-	dma_cap_mask_t mask;
+	struct ep93xx_dma_data *dma_data;
 	int ret;
 
-	ret = snd_pcm_hw_constraint_integer(substream->runtime,
-					    SNDRV_PCM_HW_PARAM_PERIODS);
-	if (ret < 0)
-		return ret;
-
 	snd_soc_set_runtime_hwparams(substream, &ep93xx_pcm_hardware);
 
-	rtd = kmalloc(sizeof(*rtd), GFP_KERNEL);
-	if (!rtd) 
+	dma_data = kmalloc(sizeof(*dma_data), GFP_KERNEL);
+	if (!dma_data)
 		return -ENOMEM;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	dma_cap_set(DMA_CYCLIC, mask);
-
 	dma_params = snd_soc_dai_get_dma_data(cpu_dai, substream);
-	rtd->dma_data.port = dma_params->dma_port;
-	rtd->dma_data.name = dma_params->name;
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		rtd->dma_data.direction = DMA_MEM_TO_DEV;
-	else
-		rtd->dma_data.direction = DMA_DEV_TO_MEM;
-
-	rtd->dma_chan = dma_request_channel(mask, ep93xx_pcm_dma_filter,
-					    &rtd->dma_data);
-	if (!rtd->dma_chan) {
-		kfree(rtd);
-		return -EINVAL;
-	}
-	
-	substream->runtime->private_data = rtd;
-	return 0;
-}
+	dma_data->port = dma_params->dma_port;
+	dma_data->name = dma_params->name;
+	dma_data->direction = snd_pcm_substream_to_dma_direction(substream);
 
-static int ep93xx_pcm_close(struct snd_pcm_substream *substream)
-{
-	struct ep93xx_runtime_data *rtd = substream->runtime->private_data;
+	ret = snd_dmaengine_pcm_open(substream, ep93xx_pcm_dma_filter, dma_data);
+	if (ret) {
+		kfree(dma_data);
+		return ret;
+	}
 
-	dma_release_channel(rtd->dma_chan);
-	kfree(rtd);
-	return 0;
-}
+	snd_dmaengine_pcm_set_data(substream, dma_data);
 
-static int ep93xx_pcm_dma_submit(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct ep93xx_runtime_data *rtd = runtime->private_data;
-	struct dma_chan *chan = rtd->dma_chan;
-	struct dma_device *dma_dev = chan->device;
-	struct dma_async_tx_descriptor *desc;
-
-	rtd->pointer_bytes = 0;
-	desc = dma_dev->device_prep_dma_cyclic(chan, runtime->dma_addr,
-					       rtd->period_bytes * rtd->periods,
-					       rtd->period_bytes,
-					       rtd->dma_data.direction);
-	if (!desc)
-		return -EINVAL;
-
-	desc->callback = ep93xx_pcm_dma_callback;
-	desc->callback_param = substream;
-
-	dmaengine_submit(desc);
 	return 0;
 }
 
-static void ep93xx_pcm_dma_flush(struct snd_pcm_substream *substream)
+static int ep93xx_pcm_close(struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct ep93xx_runtime_data *rtd = runtime->private_data;
+	struct dma_data *dma_data = snd_dmaengine_pcm_get_data(substream);
 
-	dmaengine_terminate_all(rtd->dma_chan);
+	snd_dmaengine_pcm_close(substream);
+	kfree(dma_data);
+	return 0;
 }
 
 static int ep93xx_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct ep93xx_runtime_data *rtd = runtime->private_data;
-
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 
-	rtd->periods = params_periods(params);
-	rtd->period_bytes = params_period_bytes(params);
 	return 0;
 }
 
@@ -187,41 +118,6 @@ static int ep93xx_pcm_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int ep93xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
-{
-	int ret;
-
-	ret = 0;
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		ret = ep93xx_pcm_dma_submit(substream);
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		ep93xx_pcm_dma_flush(substream);
-		break;
-
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
-static snd_pcm_uframes_t ep93xx_pcm_pointer(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct ep93xx_runtime_data *rtd = substream->runtime->private_data;
-
-	/* FIXME: implement this with sub-period granularity */
-	return bytes_to_frames(runtime, rtd->pointer_bytes);
-}
-
 static int ep93xx_pcm_mmap(struct snd_pcm_substream *substream,
 			   struct vm_area_struct *vma)
 {
@@ -239,8 +135,8 @@ static struct snd_pcm_ops ep93xx_pcm_ops = {
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= ep93xx_pcm_hw_params,
 	.hw_free	= ep93xx_pcm_hw_free,
-	.trigger	= ep93xx_pcm_trigger,
-	.pointer	= ep93xx_pcm_pointer,
+	.trigger	= snd_dmaengine_pcm_trigger,
+	.pointer	= snd_dmaengine_pcm_pointer,
 	.mmap		= ep93xx_pcm_mmap,
 };
 
-- 
1.7.9.1
