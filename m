From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH] ASoC: fsl: imx-wm8962: Do FLL configuration in
	hw_params() and hw_free()
Date: Thu, 5 Dec 2013 00:54:08 +0800
Message-ID: <1386176048-6960-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CD08261701
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 17:54:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Previously, we couldn't use hw_params() and hw_free() to open and close FLL
becuase there might be race between two simmultaneous substreams and cause
FLL configuration being changed and accordingly mulfunction. So we adopted
DAPM to control it since there won't be any race in DAPM. However, if we
want to playback a different sample rate file, we need to wait for DAPM to
change its bias_level to reconfigure FLL.

But after we introduced full symmetry protection in the soc-pcm, we don't
need to worry about the race any more. And the instance by using hw_params()
and hw_free() to control FLL would allow us to support flexible use cases,
'aplay -Dhw:0 44k16bit.wav 48k24bit.wav 32k32bit.wav' for example.

Thus this patch mainly moves FLL configuration from set_bias_level() to
hw_params() and hw_free() so as to enchance the sound card's capability.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/fsl/imx-wm8962.c | 147 +++++++++++++++++++++------------------------
 1 file changed, 70 insertions(+), 77 deletions(-)

diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
index 61e4885..df67a27 100644
--- a/sound/soc/fsl/imx-wm8962.c
+++ b/sound/soc/fsl/imx-wm8962.c
@@ -28,6 +28,9 @@
 
 #define DAI_NAME_SIZE	32
 
+#define IMX_WM8962_DAI_FMT \
+	(SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM)
+
 struct imx_wm8962_data {
 	struct snd_soc_dai_link dai;
 	struct snd_soc_card card;
@@ -49,92 +52,84 @@ static const struct snd_soc_dapm_widget imx_wm8962_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("DMIC", NULL),
 };
 
-static int sample_rate = 44100;
-static snd_pcm_format_t sample_format = SNDRV_PCM_FORMAT_S16_LE;
 
 static int imx_hifi_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params)
 {
-	sample_rate = params_rate(params);
-	sample_format = params_format(params);
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct imx_priv *priv = &card_priv;
+	struct device *dev = &priv->pdev->dev;
+	struct imx_wm8962_data *data = platform_get_drvdata(priv->pdev);
+	snd_pcm_format_t sample_format = params_format(params);
+	u32 pll_out, sample_rate = params_rate(params);
+	int ret = 0;
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, IMX_WM8962_DAI_FMT);
+	if (ret) {
+		dev_err(dev, "failed to set codec dai fmt: %d\n", ret);
+		return ret;
+	}
+
+	if (sample_format == SNDRV_PCM_FORMAT_S24_LE)
+		pll_out = sample_rate * 384;
+	else
+		pll_out = sample_rate * 256;
+
+	ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL, WM8962_FLL_MCLK,
+			data->clk_frequency, pll_out);
+	if (ret) {
+		dev_err(dev, "failed to start FLL: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8962_SYSCLK_FLL,
+			pll_out, SND_SOC_CLOCK_IN);
+	if (ret) {
+		dev_err(dev, "failed to set SYSCLK: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int imx_hifi_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct imx_priv *priv = &card_priv;
+	struct device *dev = &priv->pdev->dev;
+	int ret;
+
+	/* Don't diable FLL if still having multiple substreams running */
+	if (codec_dai->active != 1)
+		return 0;
+
+	/* Switch to MCLK as sysclk once so as to disable FLL */
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8962_SYSCLK_MCLK,
+			0, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(dev, "failed to switch away from FLL: %d\n", ret);
+		return ret;
+	}
+
+	/* Disable FLL so that we can reset its output freq later */
+	ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL,
+			WM8962_FLL_MCLK, 0, 0);
+	if (ret < 0) {
+		dev_err(dev, "failed to stop FLL: %d\n", ret);
+		return ret;
+	}
 
 	return 0;
 }
 
 static struct snd_soc_ops imx_hifi_ops = {
 	.hw_params = imx_hifi_hw_params,
+	.hw_free = imx_hifi_hw_free,
 };
 
-static int imx_wm8962_set_bias_level(struct snd_soc_card *card,
-					struct snd_soc_dapm_context *dapm,
-					enum snd_soc_bias_level level)
-{
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
-	struct imx_priv *priv = &card_priv;
-	struct imx_wm8962_data *data = platform_get_drvdata(priv->pdev);
-	struct device *dev = &priv->pdev->dev;
-	unsigned int pll_out;
-	int ret;
-
-	if (dapm->dev != codec_dai->dev)
-		return 0;
-
-	switch (level) {
-	case SND_SOC_BIAS_PREPARE:
-		if (dapm->bias_level == SND_SOC_BIAS_STANDBY) {
-			if (sample_format == SNDRV_PCM_FORMAT_S24_LE)
-				pll_out = sample_rate * 384;
-			else
-				pll_out = sample_rate * 256;
-
-			ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL,
-					WM8962_FLL_MCLK, data->clk_frequency,
-					pll_out);
-			if (ret < 0) {
-				dev_err(dev, "failed to start FLL: %d\n", ret);
-				return ret;
-			}
-
-			ret = snd_soc_dai_set_sysclk(codec_dai,
-					WM8962_SYSCLK_FLL, pll_out,
-					SND_SOC_CLOCK_IN);
-			if (ret < 0) {
-				dev_err(dev, "failed to set SYSCLK: %d\n", ret);
-				return ret;
-			}
-		}
-		break;
-
-	case SND_SOC_BIAS_STANDBY:
-		if (dapm->bias_level == SND_SOC_BIAS_PREPARE) {
-			ret = snd_soc_dai_set_sysclk(codec_dai,
-					WM8962_SYSCLK_MCLK, data->clk_frequency,
-					SND_SOC_CLOCK_IN);
-			if (ret < 0) {
-				dev_err(dev,
-					"failed to switch away from FLL: %d\n",
-					ret);
-				return ret;
-			}
-
-			ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL,
-					0, 0, 0);
-			if (ret < 0) {
-				dev_err(dev, "failed to stop FLL: %d\n", ret);
-				return ret;
-			}
-		}
-		break;
-
-	default:
-		break;
-	}
-
-	dapm->bias_level = level;
-
-	return 0;
-}
-
 static int imx_wm8962_late_probe(struct snd_soc_card *card)
 {
 	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
@@ -248,8 +243,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 	data->dai.cpu_dai_name = dev_name(&ssi_pdev->dev);
 	data->dai.platform_of_node = ssi_np;
 	data->dai.ops = &imx_hifi_ops;
-	data->dai.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-			    SND_SOC_DAIFMT_CBM_CFM;
+	data->dai.dai_fmt = IMX_WM8962_DAI_FMT;
 
 	data->card.dev = &pdev->dev;
 	ret = snd_soc_of_parse_card_name(&data->card, "model");
@@ -264,7 +258,6 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 	data->card.num_dapm_widgets = ARRAY_SIZE(imx_wm8962_dapm_widgets);
 
 	data->card.late_probe = imx_wm8962_late_probe;
-	data->card.set_bias_level = imx_wm8962_set_bias_level;
 
 	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
 	if (ret) {
-- 
1.8.4
