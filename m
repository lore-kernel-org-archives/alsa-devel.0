From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v1 03/13] ASoC: qcom: remove hardcoded i2s port number
Date: Wed, 13 May 2015 13:00:35 +0100
Message-ID: <1431518435-7349-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1431518302-7139-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431518302-7139-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch attempts to remove the hardcoded i2s port number in lpass
driver. Now the the port number comes from the dai id field.

This will allow other SOCs to use different port numbers on the lpass
driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-cpu.c     | 16 +++++++---------
 sound/soc/qcom/lpass-ipq806x.c |  1 +
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 2c20927..5965667 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -138,8 +138,7 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	ret = regmap_write(drvdata->lpaif_map,
-			   LPAIF_I2SCTL_REG(drvdata->variant,
-			   LPAIF_I2S_PORT_MI2S),
+			   LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
 			   regval);
 	if (ret) {
 		dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
@@ -164,8 +163,8 @@ static int lpass_cpu_daiops_hw_free(struct snd_pcm_substream *substream,
 	int ret;
 
 	ret = regmap_write(drvdata->lpaif_map,
-			   LPAIF_I2SCTL_REG(drvdata->variant,
-			   LPAIF_I2S_PORT_MI2S), 0);
+			   LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
+			   0);
 	if (ret)
 		dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
 				__func__, ret);
@@ -180,7 +179,7 @@ static int lpass_cpu_daiops_prepare(struct snd_pcm_substream *substream,
 	int ret;
 
 	ret = regmap_update_bits(drvdata->lpaif_map,
-			LPAIF_I2SCTL_REG(drvdata->variant, LPAIF_I2S_PORT_MI2S),
+			LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
 			LPAIF_I2SCTL_SPKEN_MASK, LPAIF_I2SCTL_SPKEN_ENABLE);
 	if (ret)
 		dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
@@ -201,7 +200,7 @@ static int lpass_cpu_daiops_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		ret = regmap_update_bits(drvdata->lpaif_map,
 				LPAIF_I2SCTL_REG(drvdata->variant,
-				LPAIF_I2S_PORT_MI2S),
+						dai->driver->id),
 				LPAIF_I2SCTL_SPKEN_MASK,
 				LPAIF_I2SCTL_SPKEN_ENABLE);
 		if (ret)
@@ -213,7 +212,7 @@ static int lpass_cpu_daiops_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		ret = regmap_update_bits(drvdata->lpaif_map,
 				LPAIF_I2SCTL_REG(drvdata->variant,
-				LPAIF_I2S_PORT_MI2S),
+						dai->driver->id),
 				LPAIF_I2SCTL_SPKEN_MASK,
 				LPAIF_I2SCTL_SPKEN_DISABLE);
 		if (ret)
@@ -243,8 +242,7 @@ int asoc_qcom_lpass_cpu_dai_probe(struct snd_soc_dai *dai)
 
 	/* ensure audio hardware is disabled */
 	ret = regmap_write(drvdata->lpaif_map,
-			   LPAIF_I2SCTL_REG(drvdata->variant,
-			   LPAIF_I2S_PORT_MI2S), 0);
+			LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id), 0);
 	if (ret)
 		dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
 				__func__, ret);
diff --git a/sound/soc/qcom/lpass-ipq806x.c b/sound/soc/qcom/lpass-ipq806x.c
index d1f698c..9483273 100644
--- a/sound/soc/qcom/lpass-ipq806x.c
+++ b/sound/soc/qcom/lpass-ipq806x.c
@@ -43,6 +43,7 @@ enum lpaif_dma_channels {
 };
 
 static struct snd_soc_dai_driver ipq806x_lpass_cpu_dai_driver = {
+	.id	= IPQ806X_LPAIF_I2S_PORT_MI2S,
 	.playback = {
 		.stream_name	= "lpass-cpu-playback",
 		.formats	= SNDRV_PCM_FMTBIT_S16 |
-- 
1.9.1
