From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 06/13] ASoC: qcom: make osr clock optional
Date: Sat, 16 May 2015 13:32:49 +0100
Message-ID: <1431779569-2091-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1431779462-1732-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431779462-1732-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Some LPASS integrations like on APQ8016 do not have OSR clk, so making
osr clk optional would allow such integrations to use lpass driver.

Tested-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-cpu.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 86c9d1a..95369d8 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -33,6 +33,9 @@ static int lpass_cpu_daiops_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
+	if (IS_ERR(drvdata->mi2s_osr_clk[dai->driver->id]))
+		return 0;
+
 	ret = clk_set_rate(drvdata->mi2s_osr_clk[dai->driver->id], freq);
 	if (ret)
 		dev_err(dai->dev, "%s() error setting mi2s osrclk to %u: %d\n",
@@ -47,18 +50,22 @@ static int lpass_cpu_daiops_startup(struct snd_pcm_substream *substream,
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
-	ret = clk_prepare_enable(drvdata->mi2s_osr_clk[dai->diver->id]);
-	if (ret) {
-		dev_err(dai->dev, "%s() error in enabling mi2s osr clk: %d\n",
-				__func__, ret);
-		return ret;
+	if (!IS_ERR(drvdata->mi2s_osr_clk[dai->driver->id])) {
+		ret = clk_prepare_enable(
+				drvdata->mi2s_osr_clk[dai->driver->id]);
+		if (ret) {
+			dev_err(dai->dev, "%s() error in enabling mi2s osr clk: %d\n",
+					__func__, ret);
+			return ret;
+		}
 	}
 
 	ret = clk_prepare_enable(drvdata->mi2s_bit_clk[dai->driver->id]);
 	if (ret) {
 		dev_err(dai->dev, "%s() error in enabling mi2s bit clk: %d\n",
 				__func__, ret);
-		clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->driver->id]);
+		if (!IS_ERR(drvdata->mi2s_osr_clk[dai->driver->id]))
+			clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->driver->id]);
 		return ret;
 	}
 
@@ -71,7 +78,9 @@ static void lpass_cpu_daiops_shutdown(struct snd_pcm_substream *substream,
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
 
 	clk_disable_unprepare(drvdata->mi2s_bit_clk[dai->driver->id]);
-	clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->driver->id]);
+
+	if (!IS_ERR(drvdata->mi2s_osr_clk[dai->driver->id]))
+		clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->driver->id]);
 }
 
 static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
@@ -415,7 +424,7 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"%s() error getting mi2s-osr-clk: %ld\n",
 				__func__,
-			return PTR_ERR(drvdata->mi2s_osr_clk[dai_id]));
+			PTR_ERR(drvdata->mi2s_osr_clk[dai_id]));
 		}
 
 		if (variant->num_dai > 1)
-- 
1.9.1
