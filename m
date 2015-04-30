From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 06/14] ASoC: qcom: support bitclk and osrclk per i2s port
Date: Thu, 30 Apr 2015 18:17:17 +0100
Message-ID: <1430414237-11126-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds support to allow bitclk and osrclk per i2s dai port.
on APQ8016 there are 4 i2s ports each one has its own bit clks.

Without this patch its not possible to support multiple i2s ports in the
lpass driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-cpu.c | 53 ++++++++++++++++++++++++++++++----------------
 sound/soc/qcom/lpass.h     |  5 +++--
 2 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 7aca253..66d068b 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -33,7 +33,7 @@ static int lpass_cpu_daiops_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
-	ret = clk_set_rate(drvdata->mi2s_osr_clk, freq);
+	ret = clk_set_rate(drvdata->mi2s_osr_clk[dai->id], freq);
 	if (ret)
 		dev_err(dai->dev, "%s() error setting mi2s osrclk to %u: %d\n",
 				__func__, freq, ret);
@@ -47,18 +47,18 @@ static int lpass_cpu_daiops_startup(struct snd_pcm_substream *substream,
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
-	ret = clk_prepare_enable(drvdata->mi2s_osr_clk);
+	ret = clk_prepare_enable(drvdata->mi2s_osr_clk[dai->id]);
 	if (ret) {
 		dev_err(dai->dev, "%s() error in enabling mi2s osr clk: %d\n",
 				__func__, ret);
 		return ret;
 	}
 
-	ret = clk_prepare_enable(drvdata->mi2s_bit_clk);
+	ret = clk_prepare_enable(drvdata->mi2s_bit_clk[dai->id]);
 	if (ret) {
 		dev_err(dai->dev, "%s() error in enabling mi2s bit clk: %d\n",
 				__func__, ret);
-		clk_disable_unprepare(drvdata->mi2s_osr_clk);
+		clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->id]);
 		return ret;
 	}
 
@@ -70,8 +70,8 @@ static void lpass_cpu_daiops_shutdown(struct snd_pcm_substream *substream,
 {
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
 
-	clk_disable_unprepare(drvdata->mi2s_bit_clk);
-	clk_disable_unprepare(drvdata->mi2s_osr_clk);
+	clk_disable_unprepare(drvdata->mi2s_bit_clk[dai->id]);
+	clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->id]);
 }
 
 static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
@@ -146,7 +146,7 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	ret = clk_set_rate(drvdata->mi2s_bit_clk, rate * bitwidth * 2);
+	ret = clk_set_rate(drvdata->mi2s_bit_clk[dai->id], rate * bitwidth * 2);
 	if (ret) {
 		dev_err(dai->dev, "%s() error setting mi2s bitclk to %u: %d\n",
 				__func__, rate * bitwidth * 2, ret);
@@ -351,7 +351,8 @@ int lpass_cpu_platform_probe(struct platform_device *pdev)
 	struct lpass_variant *variant;
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *match;
-	int ret;
+	char clk_name[16];
+	int ret, i;
 
 	dsp_of_node = of_parse_phandle(pdev->dev.of_node, "qcom,adsp", 0);
 	if (dsp_of_node) {
@@ -397,18 +398,34 @@ int lpass_cpu_platform_probe(struct platform_device *pdev)
 	if (variant->init)
 		variant->init(pdev);
 
-	drvdata->mi2s_osr_clk = devm_clk_get(&pdev->dev, "mi2s-osr-clk");
-	if (IS_ERR(drvdata->mi2s_osr_clk)) {
-		dev_err(&pdev->dev, "%s() error getting mi2s-osr-clk: %ld\n",
-				__func__, PTR_ERR(drvdata->mi2s_osr_clk));
-		return PTR_ERR(drvdata->mi2s_osr_clk);
+	for (i = 0; i < variant->num_dai; i++) {
+		if (variant->num_dai > 1)
+			sprintf(clk_name, "mi2s-osr-clk%d", i);
+		else
+			sprintf(clk_name, "mi2s-osr-clk");
+
+		drvdata->mi2s_osr_clk[i] = devm_clk_get(&pdev->dev, clk_name);
+		if (IS_ERR(drvdata->mi2s_osr_clk[i])) {
+			dev_err(&pdev->dev, "%s() error getting mi2s-osr-clk: %ld\n",
+				__func__, PTR_ERR(drvdata->mi2s_osr_clk[i]));
+			return PTR_ERR(drvdata->mi2s_osr_clk[i]);
+		}
 	}
 
-	drvdata->mi2s_bit_clk = devm_clk_get(&pdev->dev, "mi2s-bit-clk");
-	if (IS_ERR(drvdata->mi2s_bit_clk)) {
-		dev_err(&pdev->dev, "%s() error getting mi2s-bit-clk: %ld\n",
-				__func__, PTR_ERR(drvdata->mi2s_bit_clk));
-		return PTR_ERR(drvdata->mi2s_bit_clk);
+	for (i = 0; i < variant->num_dai; i++) {
+
+		if (variant->num_dai > 1)
+			sprintf(clk_name, "mi2s-bit-clk%d", i);
+		else
+			sprintf(clk_name, "mi2s-bit-clk");
+
+		drvdata->mi2s_bit_clk[i] = devm_clk_get(&pdev->dev, clk_name);
+		if (IS_ERR(drvdata->mi2s_bit_clk[i])) {
+			dev_err(&pdev->dev,
+				"%s() error getting mi2s-bit-clk: %ld\n",
+				__func__, PTR_ERR(drvdata->mi2s_bit_clk[i]));
+			return PTR_ERR(drvdata->mi2s_bit_clk[i]);
+		}
 	}
 
 	drvdata->ahbix_clk = devm_clk_get(&pdev->dev, "ahbix-clk");
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 80f4b1c..6ce2a51 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -22,6 +22,7 @@
 #include <linux/regmap.h>
 
 #define LPASS_AHBIX_CLOCK_FREQUENCY		131072000
+#define LPASS_MAX_MI2S_PORTS				(4)
 
 /* Both the CPU DAI and platform drivers will access this data */
 struct lpass_data {
@@ -30,10 +31,10 @@ struct lpass_data {
 	struct clk *ahbix_clk;
 
 	/* MI2S system clock */
-	struct clk *mi2s_osr_clk;
+	struct clk *mi2s_osr_clk[LPASS_MAX_MI2S_PORTS];
 
 	/* MI2S bit clock (derived from system clock by a divider */
-	struct clk *mi2s_bit_clk;
+	struct clk *mi2s_bit_clk[LPASS_MAX_MI2S_PORTS];
 
 	/* low-power audio interface (LPAIF) registers */
 	void __iomem *lpaif;
-- 
1.9.1
