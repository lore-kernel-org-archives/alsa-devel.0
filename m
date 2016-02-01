From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH RFC 04/15] ASoC: qcom: pass direction to dma allocation
Date: Mon,  1 Feb 2016 17:28:34 +0000
Message-ID: <1454347714-10508-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch updates the internal dma allocation callbacks to take the
stream direction so that it can allocate channels suitable for that
stream direction. Before the capture support this was not necessary.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-apq8016.c | 3 ++-
 sound/soc/qcom/lpass-ipq806x.c | 2 +-
 sound/soc/qcom/lpass.h         | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
index 94efc01..2d43842 100644
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
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 7c3367f..30449f3 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -83,7 +83,7 @@ struct lpass_variant {
 	/* SOC specific intialization like clocks */
 	int (*init)(struct platform_device *pdev);
 	int (*exit)(struct platform_device *pdev);
-	int (*alloc_dma_channel)(struct lpass_data *data);
+	int (*alloc_dma_channel)(struct lpass_data *data, int direction);
 	int (*free_dma_channel)(struct lpass_data *data, int ch);
 
 	/* SOC specific dais */
-- 
1.9.1
