From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/3] ASoC: lpass-platform: use dma_ch instead of rdma_ch/wrdma_ch
Date: Fri, 28 Oct 2016 16:32:18 +0100
Message-ID: <1477668740-30389-2-git-send-email-srinivas.kandagatla@linaro.org>
References: <1477668740-30389-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477668740-30389-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Kenneth Westfield <kwestfie@codeaurora.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch cleans up usage of wrdma_ch and rdma_ch variables into a
common variable dma_ch, As there is no real use of tracking the dma
channel in two different variables based on stream direction.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-platform.c | 53 +++++++++++++----------------------------
 1 file changed, 17 insertions(+), 36 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index e2ff538..2570c96 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -25,8 +25,7 @@
 #include "lpass.h"
 
 struct lpass_pcm_data {
-	int rdma_ch;
-	int wrdma_ch;
+	int dma_ch;
 	int i2s_port;
 };
 
@@ -95,10 +94,7 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 	int bitwidth;
 	int ret, dma_port = pcm_data->i2s_port + v->dmactl_audif_start;
 
-	if (dir ==  SNDRV_PCM_STREAM_PLAYBACK)
-		ch = pcm_data->rdma_ch;
-	else
-		ch = pcm_data->wrdma_ch;
+	ch = pcm_data->dma_ch;
 
 	bitwidth = snd_pcm_format_width(format);
 	if (bitwidth < 0) {
@@ -184,11 +180,7 @@ static int lpass_platform_pcmops_hw_free(struct snd_pcm_substream *substream)
 	unsigned int reg;
 	int ret;
 
-	if (substream->stream ==  SNDRV_PCM_STREAM_PLAYBACK)
-		reg = LPAIF_RDMACTL_REG(v, pcm_data->rdma_ch);
-	else
-		reg = LPAIF_WRDMACTL_REG(v, pcm_data->wrdma_ch);
-
+	reg = LPAIF_DMACTL_REG(v, pcm_data->dma_ch, substream->stream);
 	ret = regmap_write(drvdata->lpaif_map, reg, 0);
 	if (ret)
 		dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
@@ -207,10 +199,7 @@ static int lpass_platform_pcmops_prepare(struct snd_pcm_substream *substream)
 	struct lpass_variant *v = drvdata->variant;
 	int ret, ch, dir = substream->stream;
 
-	if (dir ==  SNDRV_PCM_STREAM_PLAYBACK)
-		ch = pcm_data->rdma_ch;
-	else
-		ch = pcm_data->wrdma_ch;
+	ch = pcm_data->dma_ch;
 
 	ret = regmap_write(drvdata->lpaif_map,
 			LPAIF_DMABASE_REG(v, ch, dir),
@@ -261,10 +250,7 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 	struct lpass_variant *v = drvdata->variant;
 	int ret, ch, dir = substream->stream;
 
-	if (dir == SNDRV_PCM_STREAM_PLAYBACK)
-		ch = pcm_data->rdma_ch;
-	else
-		ch = pcm_data->wrdma_ch;
+	ch = pcm_data->dma_ch;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -338,10 +324,7 @@ static snd_pcm_uframes_t lpass_platform_pcmops_pointer(
 	unsigned int base_addr, curr_addr;
 	int ret, ch, dir = substream->stream;
 
-	if (dir == SNDRV_PCM_STREAM_PLAYBACK)
-		ch = pcm_data->rdma_ch;
-	else
-		ch = pcm_data->wrdma_ch;
+	ch = pcm_data->dma_ch;
 
 	ret = regmap_read(drvdata->lpaif_map,
 			LPAIF_DMABASE_REG(v, ch, dir), &base_addr);
@@ -488,13 +471,13 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 	psubstream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
 	if (psubstream) {
 		if (v->alloc_dma_channel)
-			data->rdma_ch = v->alloc_dma_channel(drvdata,
+			data->dma_ch = v->alloc_dma_channel(drvdata,
 						SNDRV_PCM_STREAM_PLAYBACK);
 
-		if (data->rdma_ch < 0)
-			return data->rdma_ch;
+		if (data->dma_ch < 0)
+			return data->dma_ch;
 
-		drvdata->substream[data->rdma_ch] = psubstream;
+		drvdata->substream[data->dma_ch] = psubstream;
 
 		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
 					soc_runtime->platform->dev,
@@ -503,7 +486,7 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 			goto playback_alloc_err;
 
 		ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_RDMACTL_REG(v, data->rdma_ch), 0);
+			LPAIF_RDMACTL_REG(v, data->dma_ch), 0);
 		if (ret) {
 			dev_err(soc_runtime->dev,
 				"%s() error writing to rdmactl reg: %d\n",
@@ -515,15 +498,15 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 	csubstream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
 	if (csubstream) {
 		if (v->alloc_dma_channel)
-			data->wrdma_ch = v->alloc_dma_channel(drvdata,
+			data->dma_ch = v->alloc_dma_channel(drvdata,
 						SNDRV_PCM_STREAM_CAPTURE);
 
-		if (data->wrdma_ch < 0) {
-			ret = data->wrdma_ch;
+		if (data->dma_ch < 0) {
+			ret = data->dma_ch;
 			goto capture_alloc_err;
 		}
 
-		drvdata->substream[data->wrdma_ch] = csubstream;
+		drvdata->substream[data->dma_ch] = csubstream;
 
 		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
 					soc_runtime->platform->dev,
@@ -532,7 +515,7 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 			goto capture_alloc_err;
 
 		ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_WRDMACTL_REG(v, data->wrdma_ch), 0);
+			LPAIF_WRDMACTL_REG(v, data->dma_ch), 0);
 		if (ret) {
 			dev_err(soc_runtime->dev,
 				"%s() error writing to wrdmactl reg: %d\n",
@@ -573,9 +556,7 @@ static void lpass_platform_pcm_free(struct snd_pcm *pcm)
 			drvdata = snd_soc_platform_get_drvdata(rt->platform);
 			data = drvdata->private_data;
 
-			ch = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-				? data->rdma_ch
-				: data->wrdma_ch;
+			ch = data->dma_ch;
 			v = drvdata->variant;
 			drvdata->substream[ch] = NULL;
 			if (v->free_dma_channel)
-- 
2.10.1
