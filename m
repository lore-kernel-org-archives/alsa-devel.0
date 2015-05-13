From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v1 05/13] ASoC: qcom: support bitclk and osrclk per i2s port
Date: Wed, 13 May 2015 13:00:52 +0100
Message-ID: <1431518452-7434-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1431518302-7139-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431518302-7139-1-git-send-email-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch adds support to allow bitclk and osrclk per i2s dai port.
on APQ8016 there are 4 i2s ports each one has its own bit clks.

Without this patch its not possible to support multiple i2s ports in the
lpass driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 sound/soc/qcom/lpass-cpu.c | 54 ++++++++++++++++++++++++++++++----------------
 sound/soc/qcom/lpass.h     |  5 +++--
 2 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 5965667..0d28ea7 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -33,7 +33,7 @@ static int lpass_cpu_daiops_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
-	ret = clk_set_rate(drvdata->mi2s_osr_clk, freq);
+	ret = clk_set_rate(drvdata->mi2s_osr_clk[dai->driver->id], freq);
 	if (ret)
 		dev_err(dai->dev, "%s() error setting mi2s osrclk to %u: %d\n",
 				__func__, freq, ret);
@@ -47,18 +47,18 @@ static int lpass_cpu_daiops_startup(struct snd_pcm_substream *substream,
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
-	ret = clk_prepare_enable(drvdata->mi2s_osr_clk);
+	ret = clk_prepare_enable(drvdata->mi2s_osr_clk[dai->diver->id]);
 	if (ret) {
 		dev_err(dai->dev, "%s() error in enabling mi2s osr clk: %d\n",
 				__func__, ret);
 		return ret;
 	}
 
-	ret = clk_prepare_enable(drvdata->mi2s_bit_clk);
+	ret = clk_prepare_enable(drvdata->mi2s_bit_clk[dai->driver->id]);
 	if (ret) {
 		dev_err(dai->dev, "%s() error in enabling mi2s bit clk: %d\n",
 				__func__, ret);
-		clk_disable_unprepare(drvdata->mi2s_osr_clk);
+		clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->driver->id]);
 		return ret;
 	}
 
@@ -70,8 +70,8 @@ static void lpass_cpu_daiops_shutdown(struct snd_pcm_substream *substream,
 {
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
 
-	clk_disable_unprepare(drvdata->mi2s_bit_clk);
-	clk_disable_unprepare(drvdata->mi2s_osr_clk);
+	clk_disable_unprepare(drvdata->mi2s_bit_clk[dai->driver->id]);
+	clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->driver->id]);
 }
 
 static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
@@ -146,7 +146,8 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	ret = clk_set_rate(drvdata->mi2s_bit_clk, rate * bitwidth * 2);
+	ret = clk_set_rate(drvdata->mi2s_bit_clk[dai->driver->id],
+			   rate * bitwidth * 2);
 	if (ret) {
 		dev_err(dai->dev, "%s() error setting mi2s bitclk to %u: %d\n",
 				__func__, rate * bitwidth * 2, ret);
@@ -354,7 +355,8 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 	struct lpass_variant *variant;
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *match;
-	int ret;
+	char clk_name[16];
+	int ret, i;
 
 	dsp_of_node = of_parse_phandle(pdev->dev.of_node, "qcom,adsp", 0);
 	if (dsp_of_node) {
@@ -400,18 +402,34 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
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
index caaf17f..75e9370 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -22,6 +22,7 @@
 #include <linux/regmap.h>
 
 #define LPASS_AHBIX_CLOCK_FREQUENCY		131072000
+#define LPASS_MAX_MI2S_PORTS			(8)
 
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
