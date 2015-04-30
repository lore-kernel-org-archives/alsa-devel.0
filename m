From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 07/14] ASoC: qcom: add no osr clk flag to lpass variant
Date: Thu, 30 Apr 2015 18:17:24 +0100
Message-ID: <1430414244-11168-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Some LPASS integrations like on APQ8016 do not have OSR clk, so adding
no osr clk bit would allow such integrations to use lpass driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-cpu.c | 49 +++++++++++++++++++++++++++++-----------------
 sound/soc/qcom/lpass.h     |  2 ++
 2 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 66d068b..17ad20d 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -33,6 +33,9 @@ static int lpass_cpu_daiops_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
+	if (drvdata->variant->no_osr_clk)
+		return 0;
+
 	ret = clk_set_rate(drvdata->mi2s_osr_clk[dai->id], freq);
 	if (ret)
 		dev_err(dai->dev, "%s() error setting mi2s osrclk to %u: %d\n",
@@ -47,18 +50,21 @@ static int lpass_cpu_daiops_startup(struct snd_pcm_substream *substream,
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
-	ret = clk_prepare_enable(drvdata->mi2s_osr_clk[dai->id]);
-	if (ret) {
-		dev_err(dai->dev, "%s() error in enabling mi2s osr clk: %d\n",
-				__func__, ret);
-		return ret;
+	if (!drvdata->variant->no_osr_clk) {
+		ret = clk_prepare_enable(drvdata->mi2s_osr_clk[dai->id]);
+		if (ret) {
+			dev_err(dai->dev, "%s() error in enabling mi2s osr clk: %d\n",
+					__func__, ret);
+			return ret;
+		}
 	}
 
 	ret = clk_prepare_enable(drvdata->mi2s_bit_clk[dai->id]);
 	if (ret) {
 		dev_err(dai->dev, "%s() error in enabling mi2s bit clk: %d\n",
 				__func__, ret);
-		clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->id]);
+		if (!drvdata->variant->no_osr_clk)
+			clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->id]);
 		return ret;
 	}
 
@@ -71,7 +77,9 @@ static void lpass_cpu_daiops_shutdown(struct snd_pcm_substream *substream,
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
 
 	clk_disable_unprepare(drvdata->mi2s_bit_clk[dai->id]);
-	clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->id]);
+
+	if (!drvdata->variant->no_osr_clk)
+		clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->id]);
 }
 
 static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
@@ -398,17 +406,22 @@ int lpass_cpu_platform_probe(struct platform_device *pdev)
 	if (variant->init)
 		variant->init(pdev);
 
-	for (i = 0; i < variant->num_dai; i++) {
-		if (variant->num_dai > 1)
-			sprintf(clk_name, "mi2s-osr-clk%d", i);
-		else
-			sprintf(clk_name, "mi2s-osr-clk");
-
-		drvdata->mi2s_osr_clk[i] = devm_clk_get(&pdev->dev, clk_name);
-		if (IS_ERR(drvdata->mi2s_osr_clk[i])) {
-			dev_err(&pdev->dev, "%s() error getting mi2s-osr-clk: %ld\n",
-				__func__, PTR_ERR(drvdata->mi2s_osr_clk[i]));
-			return PTR_ERR(drvdata->mi2s_osr_clk[i]);
+	if (!variant->no_osr_clk) {
+		for (i = 0; i < variant->num_dai; i++) {
+			if (variant->num_dai > 1)
+				sprintf(clk_name, "mi2s-osr-clk%d", i);
+			else
+				sprintf(clk_name, "mi2s-osr-clk");
+
+			drvdata->mi2s_osr_clk[i] = devm_clk_get(&pdev->dev,
+								clk_name);
+			if (IS_ERR(drvdata->mi2s_osr_clk[i])) {
+				dev_err(&pdev->dev,
+					"%s() error getting mi2s-osr-clk: %ld\n",
+					__func__,
+					PTR_ERR(drvdata->mi2s_osr_clk[i]));
+				return PTR_ERR(drvdata->mi2s_osr_clk[i]);
+			}
 		}
 	}
 
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 6ce2a51..301f784 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -61,6 +61,8 @@ struct lpass_variant {
 	u32	rdma_reg_stride;
 	u32	rdma_channels;
 
+	/* OCR clock is not present in SOCs like APQ8016 */
+	bool	no_osr_clk;
 	/* SOC specific intialization like clocks */
 	int (*init)(struct platform_device *pdev);
 	int (*exit)(struct platform_device *pdev);
-- 
1.9.1
