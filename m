From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 04/14] ASoC: qcom: pass direction to dma allocation
Date: Thu, 11 Feb 2016 12:17:37 +0000
Message-ID: <1455193057-1662-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1455193007-1481-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455193007-1481-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch updates the internal dma allocation callbacks to take the
stream direction so that it can allocate channels suitable for that
stream direction. Before the capture support this was not necessary.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>
---
 sound/soc/qcom/lpass-apq8016.c  | 3 ++-
 sound/soc/qcom/lpass-ipq806x.c  | 2 +-
 sound/soc/qcom/lpass-platform.c | 3 ++-
 sound/soc/qcom/lpass.h          | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
index 6cc7e72..99061f4 100644
--- a/sound/soc/qcom/lpass-apq8016.c
+++ b/sound/soc/qcom/lpass-apq8016.c
@@ -133,7 +133,8 @@ static struct snd_soc_dai_driver apq8016_lpass_cpu_dai_driver[] = {
 	},
 };
 
-static int apq8016_lpass_alloc_dma_channel(struct lpass_data *drvdata)
+static int apq8016_lpass_alloc_dma_channel(struct lpass_data *drvdata,
+					   int direction)
 {
 	struct lpass_variant *v = drvdata->variant;
 	int chan = find_first_zero_bit(&drvdata->rdma_ch_bit_map,
diff --git a/sound/soc/qcom/lpass-ipq806x.c b/sound/soc/qcom/lpass-ipq806x.c
index 7a41679..119048c 100644
--- a/sound/soc/qcom/lpass-ipq806x.c
+++ b/sound/soc/qcom/lpass-ipq806x.c
@@ -63,7 +63,7 @@ static struct snd_soc_dai_driver ipq806x_lpass_cpu_dai_driver = {
 	.ops    = &asoc_qcom_lpass_cpu_dai_ops,
 };
 
-static int ipq806x_lpass_alloc_dma_channel(struct lpass_data *drvdata)
+static int ipq806x_lpass_alloc_dma_channel(struct lpass_data *drvdata, int dir)
 {
 	return IPQ806X_LPAIF_RDMA_CHAN_MI2S;
 }
diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 7245c2e..69c5ad8 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -457,7 +457,8 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 		return -ENOMEM;
 
 	if (v->alloc_dma_channel)
-		data->rdma_ch = v->alloc_dma_channel(drvdata);
+		data->rdma_ch = v->alloc_dma_channel(drvdata,
+						SNDRV_PCM_STREAM_PLAYBACK);
 
 	if (IS_ERR_VALUE(data->rdma_ch))
 		return data->rdma_ch;
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 412399a..8475b60 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -84,7 +84,7 @@ struct lpass_variant {
 	/* SOC specific intialization like clocks */
 	int (*init)(struct platform_device *pdev);
 	int (*exit)(struct platform_device *pdev);
-	int (*alloc_dma_channel)(struct lpass_data *data);
+	int (*alloc_dma_channel)(struct lpass_data *data, int direction);
 	int (*free_dma_channel)(struct lpass_data *data, int ch);
 
 	/* SOC specific dais */
-- 
1.9.1
