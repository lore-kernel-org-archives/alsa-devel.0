From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH RFC 15/15] ASoC: qcom: add mic support
Date: Mon,  1 Feb 2016 17:29:52 +0000
Message-ID: <1454347792-11093-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds mic support to the lpass driver, most of the driver is
reused as it is, only the register level access is changed depending on
te direction of the stream.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-cpu.c      | 113 +++++++++++++++++++--------
 sound/soc/qcom/lpass-platform.c | 166 +++++++++++++++++++++++++++++-----------
 2 files changed, 204 insertions(+), 75 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 82c21b2..d8a6a53 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -120,31 +120,60 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	switch (channels) {
-	case 1:
-		regval |= LPAIF_I2SCTL_SPKMODE_SD0;
-		regval |= LPAIF_I2SCTL_SPKMONO_MONO;
-		break;
-	case 2:
-		regval |= LPAIF_I2SCTL_SPKMODE_SD0;
-		regval |= LPAIF_I2SCTL_SPKMONO_STEREO;
-		break;
-	case 4:
-		regval |= LPAIF_I2SCTL_SPKMODE_QUAD01;
-		regval |= LPAIF_I2SCTL_SPKMONO_STEREO;
-		break;
-	case 6:
-		regval |= LPAIF_I2SCTL_SPKMODE_6CH;
-		regval |= LPAIF_I2SCTL_SPKMONO_STEREO;
-		break;
-	case 8:
-		regval |= LPAIF_I2SCTL_SPKMODE_8CH;
-		regval |= LPAIF_I2SCTL_SPKMONO_STEREO;
-		break;
-	default:
-		dev_err(dai->dev, "%s() invalid channels given: %u\n",
-				__func__, channels);
-		return -EINVAL;
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		switch (channels) {
+		case 1:
+			regval |= LPAIF_I2SCTL_SPKMODE_SD0;
+			regval |= LPAIF_I2SCTL_SPKMONO_MONO;
+			break;
+		case 2:
+			regval |= LPAIF_I2SCTL_SPKMODE_SD0;
+			regval |= LPAIF_I2SCTL_SPKMONO_STEREO;
+			break;
+		case 4:
+			regval |= LPAIF_I2SCTL_SPKMODE_QUAD01;
+			regval |= LPAIF_I2SCTL_SPKMONO_STEREO;
+			break;
+		case 6:
+			regval |= LPAIF_I2SCTL_SPKMODE_6CH;
+			regval |= LPAIF_I2SCTL_SPKMONO_STEREO;
+			break;
+		case 8:
+			regval |= LPAIF_I2SCTL_SPKMODE_8CH;
+			regval |= LPAIF_I2SCTL_SPKMONO_STEREO;
+			break;
+		default:
+			dev_err(dai->dev, "%s() invalid channels given: %u\n",
+					__func__, channels);
+			return -EINVAL;
+		}
+	} else {
+		switch (channels) {
+		case 1:
+			regval |= LPAIF_I2SCTL_MICMODE_SD0;
+			regval |= LPAIF_I2SCTL_MICMONO_MONO;
+			break;
+		case 2:
+			regval |= LPAIF_I2SCTL_MICMODE_SD0;
+			regval |= LPAIF_I2SCTL_MICMONO_STEREO;
+			break;
+		case 4:
+			regval |= LPAIF_I2SCTL_MICMODE_QUAD01;
+			regval |= LPAIF_I2SCTL_MICMONO_STEREO;
+			break;
+		case 6:
+			regval |= LPAIF_I2SCTL_MICMODE_6CH;
+			regval |= LPAIF_I2SCTL_MICMONO_STEREO;
+			break;
+		case 8:
+			regval |= LPAIF_I2SCTL_MICMODE_8CH;
+			regval |= LPAIF_I2SCTL_MICMONO_STEREO;
+			break;
+		default:
+			dev_err(dai->dev, "%s() invalid channels given: %u\n",
+					__func__, channels);
+			return -EINVAL;
+		}
 	}
 
 	ret = regmap_write(drvdata->lpaif_map,
@@ -188,10 +217,19 @@ static int lpass_cpu_daiops_prepare(struct snd_pcm_substream *substream,
 {
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
 	int ret;
+	unsigned int val, mask;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		val = LPAIF_I2SCTL_SPKEN_ENABLE;
+		mask = LPAIF_I2SCTL_SPKEN_MASK;
+	} else  {
+		val = LPAIF_I2SCTL_MICEN_ENABLE;
+		mask = LPAIF_I2SCTL_MICEN_MASK;
+	}
 
 	ret = regmap_update_bits(drvdata->lpaif_map,
 			LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
-			LPAIF_I2SCTL_SPKEN_MASK, LPAIF_I2SCTL_SPKEN_ENABLE);
+			mask, val);
 	if (ret)
 		dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
 				__func__, ret);
@@ -204,16 +242,24 @@ static int lpass_cpu_daiops_trigger(struct snd_pcm_substream *substream,
 {
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
 	int ret = -EINVAL;
+	unsigned int val, mask;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			val = LPAIF_I2SCTL_SPKEN_ENABLE;
+			mask = LPAIF_I2SCTL_SPKEN_MASK;
+		} else  {
+			val = LPAIF_I2SCTL_MICEN_ENABLE;
+			mask = LPAIF_I2SCTL_MICEN_MASK;
+		}
+
 		ret = regmap_update_bits(drvdata->lpaif_map,
 				LPAIF_I2SCTL_REG(drvdata->variant,
 						dai->driver->id),
-				LPAIF_I2SCTL_SPKEN_MASK,
-				LPAIF_I2SCTL_SPKEN_ENABLE);
+				mask, val);
 		if (ret)
 			dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
 					__func__, ret);
@@ -221,11 +267,18 @@ static int lpass_cpu_daiops_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			val = LPAIF_I2SCTL_SPKEN_DISABLE;
+			mask = LPAIF_I2SCTL_SPKEN_MASK;
+		} else  {
+			val = LPAIF_I2SCTL_MICEN_DISABLE;
+			mask = LPAIF_I2SCTL_MICEN_MASK;
+		}
+
 		ret = regmap_update_bits(drvdata->lpaif_map,
 				LPAIF_I2SCTL_REG(drvdata->variant,
 						dai->driver->id),
-				LPAIF_I2SCTL_SPKEN_MASK,
-				LPAIF_I2SCTL_SPKEN_DISABLE);
+				mask, val);
 		if (ret)
 			dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
 					__func__, ret);
diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index e611d78..574aa33 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -26,6 +26,7 @@
 
 struct lpass_pcm_data {
 	int rdma_ch;
+	int wrdma_ch;
 	int i2s_port;
 };
 
@@ -92,7 +93,13 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 	unsigned int regval;
 	int dir = substream->stream;
 	int bitwidth;
-	int ret, rdma_port = pcm_data->i2s_port + v->dmactl_audif_start;
+	int ch, ret, dma_port = pcm_data->i2s_port + v->dmactl_audif_start;
+
+	if (dir ==  SNDRV_PCM_STREAM_PLAYBACK)
+		ch = pcm_data->rdma_ch;
+	else
+		ch = pcm_data->wrdma_ch;
+
 
 	bitwidth = snd_pcm_format_width(format);
 	if (bitwidth < 0) {
@@ -102,7 +109,7 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	regval = LPAIF_DMACTL_BURSTEN_INCR4 |
-			LPAIF_DMACTL_AUDINTF(rdma_port) |
+			LPAIF_DMACTL_AUDINTF(dma_port) |
 			LPAIF_DMACTL_FIFOWM_8;
 
 	switch (bitwidth) {
@@ -158,7 +165,7 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_DMACTL_REG(v, pcm_data->rdma_ch, dir), regval);
+			LPAIF_DMACTL_REG(v, ch, dir), regval);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
 				__func__, ret);
@@ -175,10 +182,15 @@ static int lpass_platform_pcmops_hw_free(struct snd_pcm_substream *substream)
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
 	struct lpass_variant *v = drvdata->variant;
+	unsigned int reg;
 	int ret;
 
-	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_RDMACTL_REG(v, pcm_data->rdma_ch), 0);
+	if (substream->stream ==  SNDRV_PCM_STREAM_PLAYBACK)
+		reg = LPAIF_RDMACTL_REG(v, pcm_data->rdma_ch);
+	else
+		reg = LPAIF_WRDMACTL_REG(v, pcm_data->wrdma_ch);
+
+	ret = regmap_write(drvdata->lpaif_map, reg, 0);
 	if (ret)
 		dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
 				__func__, ret);
@@ -194,11 +206,15 @@ static int lpass_platform_pcmops_prepare(struct snd_pcm_substream *substream)
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
 	struct lpass_variant *v = drvdata->variant;
-	int ret, ch = pcm_data->rdma_ch;
-	int dir = substream->stream;
+	int ret, ch, dir = substream->stream;
+
+	if (dir ==  SNDRV_PCM_STREAM_PLAYBACK)
+		ch = pcm_data->rdma_ch;
+	else
+		ch = pcm_data->wrdma_ch;
 
 	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_RDMABASE_REG(v, ch),
+			LPAIF_DMABASE_REG(v, ch, dir),
 			runtime->dma_addr);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error writing to rdmabase reg: %d\n",
@@ -244,8 +260,12 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
 	struct lpass_variant *v = drvdata->variant;
-	int ret, ch = pcm_data->rdma_ch;
-	int dir = substream->stream;
+	int ret, ch, dir = substream->stream;
+
+	if (dir == SNDRV_PCM_STREAM_PLAYBACK)
+		ch = pcm_data->rdma_ch;
+	else
+		ch = pcm_data->wrdma_ch;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -317,8 +337,12 @@ static snd_pcm_uframes_t lpass_platform_pcmops_pointer(
 			snd_soc_platform_get_drvdata(soc_runtime->platform);
 	struct lpass_variant *v = drvdata->variant;
 	unsigned int base_addr, curr_addr;
-	int ret, ch = pcm_data->rdma_ch;
-	int dir = substream->stream;
+	int ret, ch, dir = substream->stream;
+
+	if (dir == SNDRV_PCM_STREAM_PLAYBACK)
+		ch = pcm_data->rdma_ch;
+	else
+		ch = pcm_data->wrdma_ch;
 
 	ret = regmap_read(drvdata->lpaif_map,
 			LPAIF_DMABASE_REG(v, ch, dir), &base_addr);
@@ -446,8 +470,7 @@ static irqreturn_t lpass_platform_lpaif_irq(int irq, void *data)
 static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 {
 	struct snd_pcm *pcm = soc_runtime->pcm;
-	struct snd_pcm_substream *substream =
-		pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
+	struct snd_pcm_substream *psubstream, *csubstream;
 	struct snd_soc_dai *cpu_dai = soc_runtime->cpu_dai;
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
@@ -460,53 +483,106 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 	if (!data)
 		return -ENOMEM;
 
-	if (v->alloc_dma_channel)
-		data->rdma_ch = v->alloc_dma_channel(drvdata);
+	data->i2s_port = cpu_dai->driver->id;
+	snd_soc_pcm_set_drvdata(soc_runtime, data);
 
-	if (IS_ERR_VALUE(data->rdma_ch))
-		return data->rdma_ch;
+	psubstream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
+	if (psubstream) {
+		if (v->alloc_dma_channel)
+			data->rdma_ch = v->alloc_dma_channel(drvdata,
+						SNDRV_PCM_STREAM_PLAYBACK);
 
-	drvdata->substream[data->rdma_ch] = substream;
-	data->i2s_port = cpu_dai->driver->id;
+		if (IS_ERR_VALUE(data->rdma_ch))
+			return data->rdma_ch;
 
-	snd_soc_pcm_set_drvdata(soc_runtime, data);
+		drvdata->substream[data->rdma_ch] = psubstream;
 
-	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, pcm->card->dev,
-				size, &substream->dma_buffer);
-	if (ret)
-		return ret;
+		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, pcm->card->dev,
+					size, &psubstream->dma_buffer);
+		if (ret)
+			goto playback_alloc_err;
 
-	ret = regmap_write(drvdata->lpaif_map,
+		ret = regmap_write(drvdata->lpaif_map,
 			LPAIF_RDMACTL_REG(v, data->rdma_ch), 0);
-	if (ret) {
-		dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
+		if (ret) {
+			dev_err(soc_runtime->dev,
+				"%s() error writing to rdmactl reg: %d\n",
 				__func__, ret);
-		goto err_buf;
+			goto capture_alloc_err;
+		}
+	}
+
+	csubstream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
+	if (csubstream) {
+		if (v->alloc_dma_channel)
+			data->wrdma_ch = v->alloc_dma_channel(drvdata,
+						SNDRV_PCM_STREAM_CAPTURE);
+
+		if (IS_ERR_VALUE(data->wrdma_ch))
+			goto capture_alloc_err;
+
+		drvdata->substream[data->wrdma_ch] = csubstream;
+
+		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, pcm->card->dev,
+					size, &csubstream->dma_buffer);
+		if (ret)
+			goto capture_alloc_err;
+
+		ret = regmap_write(drvdata->lpaif_map,
+			LPAIF_WRDMACTL_REG(v, data->wrdma_ch), 0);
+		if (ret) {
+			dev_err(soc_runtime->dev,
+				"%s() error writing to wrdmactl reg: %d\n",
+				__func__, ret);
+			goto capture_reg_err;
+		}
 	}
 
 	return 0;
 
-err_buf:
-	snd_dma_free_pages(&substream->dma_buffer);
+capture_reg_err:
+	if (csubstream)
+		snd_dma_free_pages(&csubstream->dma_buffer);
+
+capture_alloc_err:
+	if (psubstream)
+		snd_dma_free_pages(&psubstream->dma_buffer);
+
+ playback_alloc_err:
+	dev_err(soc_runtime->dev, "Cannot allocate buffer(s)\n");
+
 	return ret;
 }
 
 static void lpass_platform_pcm_free(struct snd_pcm *pcm)
 {
-	struct snd_pcm_substream *substream =
-		pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
-	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct lpass_data *drvdata =
-		snd_soc_platform_get_drvdata(soc_runtime->platform);
-	struct lpass_pcm_data *data = snd_soc_pcm_get_drvdata(soc_runtime);
-	struct lpass_variant *v = drvdata->variant;
-
-	drvdata->substream[data->rdma_ch] = NULL;
-
-	if (v->free_dma_channel)
-		v->free_dma_channel(drvdata, data->rdma_ch);
-
-	snd_dma_free_pages(&substream->dma_buffer);
+	struct snd_soc_pcm_runtime *rt;
+	struct lpass_data *drvdata;
+	struct lpass_pcm_data *data;
+	struct lpass_variant *v;
+	struct snd_pcm_substream *substream;
+	int ch, i;
+
+	for (i = 0; i < ARRAY_SIZE(pcm->streams); i++) {
+		substream = pcm->streams[i].substream;
+		if (substream) {
+			rt = substream->private_data;
+			data = snd_soc_pcm_get_drvdata(rt);
+			drvdata = snd_soc_platform_get_drvdata(rt->platform);
+
+			ch = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+				? data->rdma_ch
+				: data->wrdma_ch;
+			v = drvdata->variant;
+			drvdata->substream[ch] = NULL;
+			if (v->free_dma_channel)
+				v->free_dma_channel(drvdata, ch);
+
+			snd_dma_free_pages(&substream->dma_buffer);
+			substream->dma_buffer.area = NULL;
+			substream->dma_buffer.addr = 0;
+		}
+	}
 }
 
 static struct snd_soc_platform_driver lpass_platform_driver = {
-- 
1.9.1
