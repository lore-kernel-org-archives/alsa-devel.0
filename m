From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 1/2] ASoC: qcom: lpass-cpu: Remove unnecessary clock checks
Date: Mon, 30 Jan 2017 13:03:36 -0800
Message-ID: <20170130210337.28417-1-bjorn.andersson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Clean up the clock calling code by removing numerous IS_ERR() checks by
just assigning the clock NULL; as this turn all used functions in the
clk API to nops.

Also include the word "optional" in the error message when failing to acquire
the optional osr clocks.

Cc: Banajit Goswami <bgoswami@codeaurora.org>
Cc: Patrick Lai <plai@codeaurora.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 sound/soc/qcom/lpass-cpu.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index eff3f9a8b685..1b912a9bb791 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -33,9 +33,6 @@ static int lpass_cpu_daiops_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
-	if (IS_ERR(drvdata->mi2s_osr_clk[dai->driver->id]))
-		return 0;
-
 	ret = clk_set_rate(drvdata->mi2s_osr_clk[dai->driver->id], freq);
 	if (ret)
 		dev_err(dai->dev, "%s() error setting mi2s osrclk to %u: %d\n",
@@ -50,23 +47,18 @@ static int lpass_cpu_daiops_startup(struct snd_pcm_substream *substream,
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
-	if (!IS_ERR(drvdata->mi2s_osr_clk[dai->driver->id])) {
-		ret = clk_prepare_enable(
-				drvdata->mi2s_osr_clk[dai->driver->id]);
-		if (ret) {
-			dev_err(dai->dev, "%s() error in enabling mi2s osr clk: %d\n",
-					__func__, ret);
-			return ret;
-		}
+	ret = clk_prepare_enable(drvdata->mi2s_osr_clk[dai->driver->id]);
+	if (ret) {
+		dev_err(dai->dev, "%s() error in enabling mi2s osr clk: %d\n",
+				__func__, ret);
+		return ret;
 	}
 
 	ret = clk_prepare_enable(drvdata->mi2s_bit_clk[dai->driver->id]);
 	if (ret) {
 		dev_err(dai->dev, "%s() error in enabling mi2s bit clk: %d\n",
 				__func__, ret);
-		if (!IS_ERR(drvdata->mi2s_osr_clk[dai->driver->id]))
-			clk_disable_unprepare(
-				drvdata->mi2s_osr_clk[dai->driver->id]);
+		clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->driver->id]);
 		return ret;
 	}
 
@@ -80,8 +72,7 @@ static void lpass_cpu_daiops_shutdown(struct snd_pcm_substream *substream,
 
 	clk_disable_unprepare(drvdata->mi2s_bit_clk[dai->driver->id]);
 
-	if (!IS_ERR(drvdata->mi2s_osr_clk[dai->driver->id]))
-		clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->driver->id]);
+	clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->driver->id]);
 }
 
 static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
@@ -505,9 +496,11 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 								clk_name);
 		if (IS_ERR(drvdata->mi2s_osr_clk[dai_id])) {
 			dev_warn(&pdev->dev,
-				"%s() error getting mi2s-osr-clk: %ld\n",
+				"%s() error getting optional mi2s-osr-clk: %ld\n",
 				__func__,
 				PTR_ERR(drvdata->mi2s_osr_clk[dai_id]));
+
+			drvdata->mi2s_osr_clk[dai_id] = NULL;
 		}
 
 		if (variant->num_dai > 1)
-- 
2.11.0
