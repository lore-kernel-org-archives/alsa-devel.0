From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 04/14] ASoC: qcom: remove hardcoded i2s port number
Date: Thu, 30 Apr 2015 18:17:02 +0100
Message-ID: <1430414222-11039-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
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
 sound/soc/qcom/lpass-cpu.c     | 17 ++++++-----------
 sound/soc/qcom/lpass-ipq806x.c |  1 +
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 74b2245..7aca253 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -138,8 +138,7 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	ret = regmap_write(drvdata->lpaif_map,
-			   LPAIF_I2SCTL_REG(drvdata->variant,
-			   LPAIF_I2S_PORT_MI2S),
+			   LPAIF_I2SCTL_REG(drvdata->variant, dai->id),
 			   regval);
 	if (ret) {
 		dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
@@ -164,8 +163,7 @@ static int lpass_cpu_daiops_hw_free(struct snd_pcm_substream *substream,
 	int ret;
 
 	ret = regmap_write(drvdata->lpaif_map,
-			   LPAIF_I2SCTL_REG(drvdata->variant,
-			   LPAIF_I2S_PORT_MI2S), 0);
+			   LPAIF_I2SCTL_REG(drvdata->variant, dai->id), 0);
 	if (ret)
 		dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
 				__func__, ret);
@@ -180,7 +178,7 @@ static int lpass_cpu_daiops_prepare(struct snd_pcm_substream *substream,
 	int ret;
 
 	ret = regmap_update_bits(drvdata->lpaif_map,
-			LPAIF_I2SCTL_REG(drvdata->variant, LPAIF_I2S_PORT_MI2S),
+			LPAIF_I2SCTL_REG(drvdata->variant, dai->id),
 			LPAIF_I2SCTL_SPKEN_MASK, LPAIF_I2SCTL_SPKEN_ENABLE);
 	if (ret)
 		dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
@@ -200,8 +198,7 @@ static int lpass_cpu_daiops_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		ret = regmap_update_bits(drvdata->lpaif_map,
-				LPAIF_I2SCTL_REG(drvdata->variant,
-				LPAIF_I2S_PORT_MI2S),
+				LPAIF_I2SCTL_REG(drvdata->variant, dai->id),
 				LPAIF_I2SCTL_SPKEN_MASK,
 				LPAIF_I2SCTL_SPKEN_ENABLE);
 		if (ret)
@@ -212,8 +209,7 @@ static int lpass_cpu_daiops_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		ret = regmap_update_bits(drvdata->lpaif_map,
-				LPAIF_I2SCTL_REG(drvdata->variant,
-				LPAIF_I2S_PORT_MI2S),
+				LPAIF_I2SCTL_REG(drvdata->variant, dai->id),
 				LPAIF_I2SCTL_SPKEN_MASK,
 				LPAIF_I2SCTL_SPKEN_DISABLE);
 		if (ret)
@@ -243,8 +239,7 @@ int lpass_cpu_dai_probe(struct snd_soc_dai *dai)
 
 	/* ensure audio hardware is disabled */
 	ret = regmap_write(drvdata->lpaif_map,
-			   LPAIF_I2SCTL_REG(drvdata->variant,
-			   LPAIF_I2S_PORT_MI2S), 0);
+			LPAIF_I2SCTL_REG(drvdata->variant, dai->id), 0);
 	if (ret)
 		dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
 				__func__, ret);
diff --git a/sound/soc/qcom/lpass-ipq806x.c b/sound/soc/qcom/lpass-ipq806x.c
index 8e9a427..0466483 100644
--- a/sound/soc/qcom/lpass-ipq806x.c
+++ b/sound/soc/qcom/lpass-ipq806x.c
@@ -29,6 +29,7 @@
 #include "lpass.h"
 
 static struct snd_soc_dai_driver lpass_cpu_dai_driver = {
+	.id	= LPAIF_I2S_PORT_MI2S,
 	.playback = {
 		.stream_name	= "lpass-cpu-playback",
 		.formats	= SNDRV_PCM_FMTBIT_S16 |
-- 
1.9.1
