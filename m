From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [RFC 6/7] ASoC: mxs-pcm: Use dmaengine PCM helper
	functions
Date: Wed, 22 Feb 2012 10:49:10 +0100
Message-ID: <1329904151-5927-7-git-send-email-lars@metafoo.de>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-093.synserver.de
	[212.40.185.93]) by alsa0.perex.cz (Postfix) with ESMTP id 8E95B2457C
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 10:47:51 +0100 (CET)
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
 sound/soc/mxs/Kconfig   |    1 +
 sound/soc/mxs/mxs-pcm.c |  136 ++++++++--------------------------------------
 sound/soc/mxs/mxs-pcm.h |   12 ----
 3 files changed, 25 insertions(+), 124 deletions(-)

diff --git a/sound/soc/mxs/Kconfig b/sound/soc/mxs/Kconfig
index 21d20f3..99a997f 100644
--- a/sound/soc/mxs/Kconfig
+++ b/sound/soc/mxs/Kconfig
@@ -1,6 +1,7 @@
 menuconfig SND_MXS_SOC
 	tristate "SoC Audio for Freescale MXS CPUs"
 	depends on ARCH_MXS
+	select SND_SOC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the MXS SAIF interface.
diff --git a/sound/soc/mxs/mxs-pcm.c b/sound/soc/mxs/mxs-pcm.c
index 5b8c8d3..6ca1f46 100644
--- a/sound/soc/mxs/mxs-pcm.c
+++ b/sound/soc/mxs/mxs-pcm.c
@@ -34,10 +34,16 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
 
 #include <mach/dma.h>
 #include "mxs-pcm.h"
 
+struct mxs_pcm_dma_data {
+	struct mxs_dma_data dma_data;
+	struct mxs_pcm_dma_params *dma_params;
+};
+
 static struct snd_pcm_hardware snd_mxs_hardware = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_MMAP_VALID |
@@ -58,21 +64,10 @@ static struct snd_pcm_hardware snd_mxs_hardware = {
 
 };
 
-static void audio_dma_irq(void *data)
-{
-	struct snd_pcm_substream *substream = (struct snd_pcm_substream *)data;
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct mxs_pcm_runtime_data *iprtd = runtime->private_data;
-
-	iprtd->offset += iprtd->period_bytes;
-	iprtd->offset %= iprtd->period_bytes * iprtd->periods;
-	snd_pcm_period_elapsed(substream);
-}
-
 static bool filter(struct dma_chan *chan, void *param)
 {
-	struct mxs_pcm_runtime_data *iprtd = param;
-	struct mxs_pcm_dma_params *dma_params = iprtd->dma_params;
+	struct mxs_pcm_dma_data *pcm_dma_data = param;
+	struct mxs_pcm_dma_params *dma_params = pcm_dma_data->dma_params;
 
 	if (!mxs_dma_is_apbx(chan))
 		return false;
@@ -80,134 +75,51 @@ static bool filter(struct dma_chan *chan, void *param)
 	if (chan->chan_id != dma_params->chan_num)
 		return false;
 
-	chan->private = &iprtd->dma_data;
+	chan->private = &pcm_dma_data->dma_data;
 
 	return true;
 }
 
-static int mxs_dma_alloc(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct mxs_pcm_runtime_data *iprtd = runtime->private_data;
-	dma_cap_mask_t mask;
-
-	iprtd->dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	iprtd->dma_data.chan_irq = iprtd->dma_params->chan_irq;
-	iprtd->dma_chan = dma_request_channel(mask, filter, iprtd);
-	if (!iprtd->dma_chan)
-		return -EINVAL;
-
-	return 0;
-}
-
 static int snd_mxs_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct mxs_pcm_runtime_data *iprtd = runtime->private_data;
-	unsigned long dma_addr;
-	struct dma_chan *chan;
-
-	chan = iprtd->dma_chan;
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
 	return 0;
 }
 
-static int snd_mxs_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct mxs_pcm_runtime_data *iprtd = runtime->private_data;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		dmaengine_submit(iprtd->desc);
-
-		break;
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
-	return 0;
-}
-
-static snd_pcm_uframes_t snd_mxs_pcm_pointer(
-		struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct mxs_pcm_runtime_data *iprtd = runtime->private_data;
-
-	return bytes_to_frames(substream->runtime, iprtd->offset);
-}
-
 static int snd_mxs_open(struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct mxs_pcm_runtime_data *iprtd;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct mxs_pcm_dma_data *pcm_dma_data;
 	int ret;
 
-	iprtd = kzalloc(sizeof(*iprtd), GFP_KERNEL);
-	if (iprtd == NULL)
+	pcm_dma_data = kzalloc(sizeof(*pcm_dma_data), GFP_KERNEL);
+	if (pcm_dma_data == NULL)
 		return -ENOMEM;
-	runtime->private_data = iprtd;
 
-	ret = snd_pcm_hw_constraint_integer(substream->runtime,
-			SNDRV_PCM_HW_PARAM_PERIODS);
-	if (ret < 0) {
-		kfree(iprtd);
-		return ret;
-	}
+	pcm_dma_data->dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+	pcm_dma_data->dma_data.chan_irq = pcm_dma_data->dma_params->chan_irq;
 
-	ret = mxs_dma_alloc(substream);
+	ret = snd_dmaengine_pcm_open(substream, filter, pcm_dma_data);
 	if (ret) {
-		kfree(iprtd);
+		kfree(pcm_dma_data);
 		return ret;
 	}
 
 	snd_soc_set_runtime_hwparams(substream, &snd_mxs_hardware);
 
+	snd_dmaengine_pcm_set_data(substream, pcm_dma_data);
+
 	return 0;
 }
 
 static int snd_mxs_close(struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct mxs_pcm_runtime_data *iprtd = runtime->private_data;
+	struct mxs_pcm_dma_data *pcm_dma_data = snd_dmaengine_pcm_get_data(substream);
 
-	dma_release_channel(iprtd->dma_chan);
-	kfree(iprtd);
+	snd_dmaengine_pcm_close(substream);
+	kfree(pcm_dma_data);
 
 	return 0;
 }
@@ -228,8 +140,8 @@ static struct snd_pcm_ops mxs_pcm_ops = {
 	.close		= snd_mxs_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= snd_mxs_pcm_hw_params,
-	.trigger	= snd_mxs_pcm_trigger,
-	.pointer	= snd_mxs_pcm_pointer,
+	.trigger	= snd_dmaengine_pcm_trigger,
+	.pointer	= snd_dmaengine_pcm_pointer,
 	.mmap		= snd_mxs_pcm_mmap,
 };
 
diff --git a/sound/soc/mxs/mxs-pcm.h b/sound/soc/mxs/mxs-pcm.h
index ba75e10..5f01a91 100644
--- a/sound/soc/mxs/mxs-pcm.h
+++ b/sound/soc/mxs/mxs-pcm.h
@@ -19,21 +19,9 @@
 #ifndef _MXS_PCM_H
 #define _MXS_PCM_H
 
-#include <mach/dma.h>
-
 struct mxs_pcm_dma_params {
 	int chan_irq;
 	int chan_num;
 };
 
-struct mxs_pcm_runtime_data {
-	int period_bytes;
-	int periods;
-	unsigned long offset;
-	struct dma_async_tx_descriptor *desc;
-	struct dma_chan *dma_chan;
-	struct mxs_dma_data dma_data;
-	struct mxs_pcm_dma_params *dma_params;
-};
-
 #endif
-- 
1.7.9
