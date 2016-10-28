From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] ASoC: lpass-platform: Fix broken pcm data usage
Date: Fri, 28 Oct 2016 16:32:19 +0100
Message-ID: <1477668740-30389-3-git-send-email-srinivas.kandagatla@linaro.org>
References: <1477668740-30389-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477668740-30389-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Kenneth Westfield <kwestfie@codeaurora.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch fixes lpass-platform driver which was broken in v4.9-rc1.
lpass_pcm_data data structure holds information specific to stream.
Holding a single private pointer to it in global lpass_data
will not work, because it would be overwritten by for each pcm instance.

This code was breaking playback when we have both playback and capture
pcm streams, as playback settings are over written by capture settings.

Fix this by moving channel allocation logic out of pcm_new to pcm_open
so that we can store the stream specific information private_data of
snd_pcm_runtime.

Fixes: 6adcbdcd4b6e ("ASoC: lpass-platform: don't use snd_soc_pcm_set_drvdata()")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-platform.c | 151 ++++++++++++++++++----------------------
 sound/soc/qcom/lpass.h          |   1 -
 2 files changed, 67 insertions(+), 85 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 2570c96..4554cae 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -60,7 +60,36 @@ static int lpass_platform_pcmops_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	int ret;
+	struct snd_soc_dai *cpu_dai = soc_runtime->cpu_dai;
+	struct lpass_data *drvdata =
+		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct lpass_variant *v = drvdata->variant;
+	int ret, dir = substream->stream;
+	struct lpass_pcm_data *data;
+
+	data = devm_kzalloc(soc_runtime->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->i2s_port = cpu_dai->driver->id;
+	runtime->private_data = data;
+
+	if (v->alloc_dma_channel)
+		data->dma_ch = v->alloc_dma_channel(drvdata, dir);
+	if (data->dma_ch < 0)
+		return data->dma_ch;
+
+	drvdata->substream[data->dma_ch] = substream;
+
+	ret = regmap_write(drvdata->lpaif_map,
+			LPAIF_DMACTL_REG(v, data->dma_ch, dir), 0);
+	if (ret) {
+		dev_err(soc_runtime->dev,
+			"%s() error writing to rdmactl reg: %d\n",
+			__func__, ret);
+			return ret;
+	}
+
 
 	snd_soc_set_runtime_hwparams(substream, &lpass_platform_pcm_hardware);
 
@@ -79,13 +108,32 @@ static int lpass_platform_pcmops_open(struct snd_pcm_substream *substream)
 	return 0;
 }
 
+static int lpass_platform_pcmops_close(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct lpass_data *drvdata =
+		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct lpass_variant *v = drvdata->variant;
+	struct lpass_pcm_data *data;
+
+	data = runtime->private_data;
+	v = drvdata->variant;
+	drvdata->substream[data->dma_ch] = NULL;
+	if (v->free_dma_channel)
+		v->free_dma_channel(drvdata, data->dma_ch);
+
+	return 0;
+}
+
 static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
-	struct lpass_pcm_data *pcm_data = drvdata->private_data;
+	struct snd_pcm_runtime *rt = substream->runtime;
+	struct lpass_pcm_data *pcm_data = rt->private_data;
 	struct lpass_variant *v = drvdata->variant;
 	snd_pcm_format_t format = params_format(params);
 	unsigned int channels = params_channels(params);
@@ -175,7 +223,8 @@ static int lpass_platform_pcmops_hw_free(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
-	struct lpass_pcm_data *pcm_data = drvdata->private_data;
+	struct snd_pcm_runtime *rt = substream->runtime;
+	struct lpass_pcm_data *pcm_data = rt->private_data;
 	struct lpass_variant *v = drvdata->variant;
 	unsigned int reg;
 	int ret;
@@ -195,7 +244,8 @@ static int lpass_platform_pcmops_prepare(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
-	struct lpass_pcm_data *pcm_data = drvdata->private_data;
+	struct snd_pcm_runtime *rt = substream->runtime;
+	struct lpass_pcm_data *pcm_data = rt->private_data;
 	struct lpass_variant *v = drvdata->variant;
 	int ret, ch, dir = substream->stream;
 
@@ -246,7 +296,8 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
-	struct lpass_pcm_data *pcm_data = drvdata->private_data;
+	struct snd_pcm_runtime *rt = substream->runtime;
+	struct lpass_pcm_data *pcm_data = rt->private_data;
 	struct lpass_variant *v = drvdata->variant;
 	int ret, ch, dir = substream->stream;
 
@@ -319,7 +370,8 @@ static snd_pcm_uframes_t lpass_platform_pcmops_pointer(
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
 	struct lpass_data *drvdata =
 			snd_soc_platform_get_drvdata(soc_runtime->platform);
-	struct lpass_pcm_data *pcm_data = drvdata->private_data;
+	struct snd_pcm_runtime *rt = substream->runtime;
+	struct lpass_pcm_data *pcm_data = rt->private_data;
 	struct lpass_variant *v = drvdata->variant;
 	unsigned int base_addr, curr_addr;
 	int ret, ch, dir = substream->stream;
@@ -357,6 +409,7 @@ static int lpass_platform_pcmops_mmap(struct snd_pcm_substream *substream,
 
 static const struct snd_pcm_ops lpass_platform_pcm_ops = {
 	.open		= lpass_platform_pcmops_open,
+	.close		= lpass_platform_pcmops_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= lpass_platform_pcmops_hw_params,
 	.hw_free	= lpass_platform_pcmops_hw_free,
@@ -453,115 +506,45 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 {
 	struct snd_pcm *pcm = soc_runtime->pcm;
 	struct snd_pcm_substream *psubstream, *csubstream;
-	struct snd_soc_dai *cpu_dai = soc_runtime->cpu_dai;
-	struct lpass_data *drvdata =
-		snd_soc_platform_get_drvdata(soc_runtime->platform);
-	struct lpass_variant *v = drvdata->variant;
 	int ret = -EINVAL;
-	struct lpass_pcm_data *data;
 	size_t size = lpass_platform_pcm_hardware.buffer_bytes_max;
 
-	data = devm_kzalloc(soc_runtime->dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	data->i2s_port = cpu_dai->driver->id;
-	drvdata->private_data = data;
-
 	psubstream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
 	if (psubstream) {
-		if (v->alloc_dma_channel)
-			data->dma_ch = v->alloc_dma_channel(drvdata,
-						SNDRV_PCM_STREAM_PLAYBACK);
-
-		if (data->dma_ch < 0)
-			return data->dma_ch;
-
-		drvdata->substream[data->dma_ch] = psubstream;
-
 		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
 					soc_runtime->platform->dev,
 					size, &psubstream->dma_buffer);
-		if (ret)
-			goto playback_alloc_err;
-
-		ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_RDMACTL_REG(v, data->dma_ch), 0);
 		if (ret) {
-			dev_err(soc_runtime->dev,
-				"%s() error writing to rdmactl reg: %d\n",
-				__func__, ret);
-			goto capture_alloc_err;
+			dev_err(soc_runtime->dev, "Cannot allocate buffer(s)\n");
+			return ret;
 		}
 	}
 
 	csubstream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
 	if (csubstream) {
-		if (v->alloc_dma_channel)
-			data->dma_ch = v->alloc_dma_channel(drvdata,
-						SNDRV_PCM_STREAM_CAPTURE);
-
-		if (data->dma_ch < 0) {
-			ret = data->dma_ch;
-			goto capture_alloc_err;
-		}
-
-		drvdata->substream[data->dma_ch] = csubstream;
-
 		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
 					soc_runtime->platform->dev,
 					size, &csubstream->dma_buffer);
-		if (ret)
-			goto capture_alloc_err;
-
-		ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_WRDMACTL_REG(v, data->dma_ch), 0);
 		if (ret) {
-			dev_err(soc_runtime->dev,
-				"%s() error writing to wrdmactl reg: %d\n",
-				__func__, ret);
-			goto capture_reg_err;
+			dev_err(soc_runtime->dev, "Cannot allocate buffer(s)\n");
+			if (psubstream)
+				snd_dma_free_pages(&psubstream->dma_buffer);
+			return ret;
 		}
+
 	}
 
 	return 0;
-
-capture_reg_err:
-	if (csubstream)
-		snd_dma_free_pages(&csubstream->dma_buffer);
-
-capture_alloc_err:
-	if (psubstream)
-		snd_dma_free_pages(&psubstream->dma_buffer);
-
- playback_alloc_err:
-	dev_err(soc_runtime->dev, "Cannot allocate buffer(s)\n");
-
-	return ret;
 }
 
 static void lpass_platform_pcm_free(struct snd_pcm *pcm)
 {
-	struct snd_soc_pcm_runtime *rt;
-	struct lpass_data *drvdata;
-	struct lpass_pcm_data *data;
-	struct lpass_variant *v;
 	struct snd_pcm_substream *substream;
-	int ch, i;
+	int i;
 
 	for (i = 0; i < ARRAY_SIZE(pcm->streams); i++) {
 		substream = pcm->streams[i].substream;
 		if (substream) {
-			rt = substream->private_data;
-			drvdata = snd_soc_platform_get_drvdata(rt->platform);
-			data = drvdata->private_data;
-
-			ch = data->dma_ch;
-			v = drvdata->variant;
-			drvdata->substream[ch] = NULL;
-			if (v->free_dma_channel)
-				v->free_dma_channel(drvdata, ch);
-
 			snd_dma_free_pages(&substream->dma_buffer);
 			substream->dma_buffer.area = NULL;
 			substream->dma_buffer.addr = 0;
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 35b3cea..924971b 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -59,7 +59,6 @@ struct lpass_data {
 	struct clk *pcnoc_mport_clk;
 	struct clk *pcnoc_sway_clk;
 
-	void *private_data;
 };
 
 /* Vairant data per each SOC */
-- 
2.10.1
