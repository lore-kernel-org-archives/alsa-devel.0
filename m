From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [RFC 2/7] ASoC: imx-pcm: Request DMA channel early
Date: Wed, 22 Feb 2012 10:49:06 +0100
Message-ID: <1329904151-5927-3-git-send-email-lars@metafoo.de>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-093.synserver.de
	[212.40.185.93])
	by alsa0.perex.cz (Postfix) with ESMTP id D1455103B34
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 10:47:43 +0100 (CET)
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

Request the DMA channel in the pcm open callback. This allows us to let open
fail if there is no dma channel available.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/imx/imx-pcm-dma-mx2.c |   78 ++++++++++++++++-----------------------
 1 files changed, 32 insertions(+), 46 deletions(-)

diff --git a/sound/soc/imx/imx-pcm-dma-mx2.c b/sound/soc/imx/imx-pcm-dma-mx2.c
index ec13944..f974e61 100644
--- a/sound/soc/imx/imx-pcm-dma-mx2.c
+++ b/sound/soc/imx/imx-pcm-dma-mx2.c
@@ -65,17 +65,13 @@ static bool filter(struct dma_chan *chan, void *param)
         return true;
 }
 
-static int imx_ssi_dma_alloc(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
+static int imx_ssi_dma_alloc(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct imx_pcm_dma_params *dma_params;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
-	struct dma_slave_config slave_config;
 	dma_cap_mask_t mask;
-	enum dma_slave_buswidth buswidth;
-	int ret;
 
 	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
@@ -84,13 +80,29 @@ static int imx_ssi_dma_alloc(struct snd_pcm_substream *substream,
 	iprtd->dma_data.dma_request = dma_params->dma;
 
 	/* Try to grab a DMA channel */
-	if (!iprtd->dma_chan) {
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
-		iprtd->dma_chan = dma_request_channel(mask, filter, iprtd);
-		if (!iprtd->dma_chan)
-			return -EINVAL;
-	}
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	iprtd->dma_chan = dma_request_channel(mask, filter, iprtd);
+	if (!iprtd->dma_chan)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int snd_imx_pcm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
+	struct dma_chan *chan = iprtd->dma_chan;
+	struct imx_pcm_dma_params *dma_params;
+	struct dma_slave_config slave_config;
+	enum dma_slave_buswidth buswidth;
+	unsigned long dma_addr;
+	int ret;
+
+	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
@@ -116,29 +128,10 @@ static int imx_ssi_dma_alloc(struct snd_pcm_substream *substream,
 		slave_config.src_maxburst = dma_params->burstsize;
 	}
 
-	ret = dmaengine_slave_config(iprtd->dma_chan, &slave_config);
+	ret = dmaengine_slave_config(chan, &slave_config);
 	if (ret)
 		return ret;
 
-	return 0;
-}
-
-static int snd_imx_pcm_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
-	unsigned long dma_addr;
-	struct dma_chan *chan;
-	struct imx_pcm_dma_params *dma_params;
-	int ret;
-
-	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-	ret = imx_ssi_dma_alloc(substream, params);
-	if (ret)
-		return ret;
-	chan = iprtd->dma_chan;
 
 	iprtd->periods = params_periods(params);
 	iprtd->period_bytes = params_period_bytes(params);
@@ -164,19 +157,6 @@ static int snd_imx_pcm_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int snd_imx_pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
-
-	if (iprtd->dma_chan) {
-		dma_release_channel(iprtd->dma_chan);
-		iprtd->dma_chan = NULL;
-	}
-
-	return 0;
-}
-
 static int snd_imx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -251,6 +231,12 @@ static int snd_imx_open(struct snd_pcm_substream *substream)
 		return ret;
 	}
 
+	ret = imx_ssi_dma_alloc(substream);
+	if (ret < 0) {
+		kfree(iprtd);
+		return ret;
+	}
+
 	snd_soc_set_runtime_hwparams(substream, &snd_imx_hardware);
 
 	return 0;
@@ -261,6 +247,7 @@ static int snd_imx_close(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
 
+	dma_release_channel(iprtd->dma_chan);
 	kfree(iprtd);
 
 	return 0;
@@ -271,7 +258,6 @@ static struct snd_pcm_ops imx_pcm_ops = {
 	.close		= snd_imx_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= snd_imx_pcm_hw_params,
-	.hw_free	= snd_imx_pcm_hw_free,
 	.trigger	= snd_imx_pcm_trigger,
 	.pointer	= snd_imx_pcm_pointer,
 	.mmap		= snd_imx_pcm_mmap,
-- 
1.7.9
