From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v1 01/14] ASoC: qcom: use snd_dma_alloc/free* apis
Date: Wed, 10 Feb 2016 10:18:13 +0000
Message-ID: <1455099493-359-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1455099418-311-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1455099418-311-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

There is no point in having local allocation functions when the driver
can use snd_dma_alloc/free() apis. This patch replaces the local versions
of the dma allocation apis with the snd_dma_alloc/free() apis.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-platform.c | 42 ++++++-----------------------------------
 1 file changed, 6 insertions(+), 36 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 4aeb8e1..ec2414d 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -439,39 +439,6 @@ static irqreturn_t lpass_platform_lpaif_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int lpass_platform_alloc_buffer(struct snd_pcm_substream *substream,
-		struct snd_soc_pcm_runtime *rt)
-{
-	struct snd_dma_buffer *buf = &substream->dma_buffer;
-	size_t size = lpass_platform_pcm_hardware.buffer_bytes_max;
-
-	buf->dev.type = SNDRV_DMA_TYPE_DEV;
-	buf->dev.dev = rt->platform->dev;
-	buf->private_data = NULL;
-	buf->area = dma_alloc_coherent(rt->platform->dev, size, &buf->addr,
-			GFP_KERNEL);
-	if (!buf->area) {
-		dev_err(rt->platform->dev, "%s: Could not allocate DMA buffer\n",
-				__func__);
-		return -ENOMEM;
-	}
-	buf->bytes = size;
-
-	return 0;
-}
-
-static void lpass_platform_free_buffer(struct snd_pcm_substream *substream,
-		struct snd_soc_pcm_runtime *rt)
-{
-	struct snd_dma_buffer *buf = &substream->dma_buffer;
-
-	if (buf->area) {
-		dma_free_coherent(rt->dev, buf->bytes, buf->area,
-				buf->addr);
-	}
-	buf->area = NULL;
-}
-
 static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 {
 	struct snd_pcm *pcm = soc_runtime->pcm;
@@ -483,6 +450,7 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 	struct lpass_variant *v = drvdata->variant;
 	int ret;
 	struct lpass_pcm_data *data;
+	size_t size = lpass_platform_pcm_hardware.buffer_bytes_max;
 
 	data = devm_kzalloc(soc_runtime->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -499,7 +467,9 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 
 	snd_soc_pcm_set_drvdata(soc_runtime, data);
 
-	ret = lpass_platform_alloc_buffer(substream, soc_runtime);
+	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
+				soc_runtime->platform->dev,
+				size, &substream->dma_buffer);
 	if (ret)
 		return ret;
 
@@ -514,7 +484,7 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 	return 0;
 
 err_buf:
-	lpass_platform_free_buffer(substream, soc_runtime);
+	snd_dma_free_pages(&substream->dma_buffer);
 	return ret;
 }
 
@@ -533,7 +503,7 @@ static void lpass_platform_pcm_free(struct snd_pcm *pcm)
 	if (v->free_dma_channel)
 		v->free_dma_channel(drvdata, data->rdma_ch);
 
-	lpass_platform_free_buffer(substream, soc_runtime);
+	snd_dma_free_pages(&substream->dma_buffer);
 }
 
 static struct snd_soc_platform_driver lpass_platform_driver = {
-- 
1.9.1
