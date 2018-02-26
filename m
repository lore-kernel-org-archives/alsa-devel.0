From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: imx-wm8962: Use a single private
	structure
Date: Mon, 26 Feb 2018 15:49:57 -0300
Message-ID: <1519670997-15274-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f66.google.com (mail-vk0-f66.google.com
 [209.85.213.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F6692675E9
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 19:49:48 +0100 (CET)
Received: by mail-vk0-f66.google.com with SMTP id t201so10551930vke.8
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 10:49:48 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, shengjiu.wang@nxp.com, nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, leonard.crestez@nxp.com, daniel.baluta@nxp.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Commit 8f7206d69ab8c ("ASoC: imx-wm8962: Remove global variables")
ended up by assigning the same value for two different structs:

struct imx_priv *priv = snd_soc_card_get_drvdata(card);
struct imx_wm8962_data *data = snd_soc_card_get_drvdata(card);

Fix it by consolidating all the private data into a single structure.

Fixes: 8f7206d69ab8c ("ASoC: imx-wm8962: Remove global variables")
Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
Suggested-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/fsl/imx-wm8962.c | 64 +++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 38 deletions(-)

diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
index 206b898..29d7e9b 100644
--- a/sound/soc/fsl/imx-wm8962.c
+++ b/sound/soc/fsl/imx-wm8962.c
@@ -28,15 +28,12 @@
 
 #define DAI_NAME_SIZE	32
 
-struct imx_wm8962_data {
+struct imx_priv {
 	struct snd_soc_dai_link dai;
 	struct snd_soc_card card;
 	char codec_dai_name[DAI_NAME_SIZE];
 	char platform_name[DAI_NAME_SIZE];
 	unsigned int clk_frequency;
-};
-
-struct imx_priv {
 	struct platform_device *pdev;
 	int sample_rate;
 	snd_pcm_format_t sample_format;
@@ -72,7 +69,6 @@ static int imx_wm8962_set_bias_level(struct snd_soc_card *card,
 	struct snd_soc_pcm_runtime *rtd;
 	struct snd_soc_dai *codec_dai;
 	struct imx_priv *priv = snd_soc_card_get_drvdata(card);
-	struct imx_wm8962_data *data = snd_soc_card_get_drvdata(card);
 	struct device *dev = &priv->pdev->dev;
 	unsigned int pll_out;
 	int ret;
@@ -91,7 +87,7 @@ static int imx_wm8962_set_bias_level(struct snd_soc_card *card,
 				pll_out = priv->sample_rate * 256;
 
 			ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL,
-					WM8962_FLL_MCLK, data->clk_frequency,
+					WM8962_FLL_MCLK, priv->clk_frequency,
 					pll_out);
 			if (ret < 0) {
 				dev_err(dev, "failed to start FLL: %d\n", ret);
@@ -111,7 +107,7 @@ static int imx_wm8962_set_bias_level(struct snd_soc_card *card,
 	case SND_SOC_BIAS_STANDBY:
 		if (dapm->bias_level == SND_SOC_BIAS_PREPARE) {
 			ret = snd_soc_dai_set_sysclk(codec_dai,
-					WM8962_SYSCLK_MCLK, data->clk_frequency,
+					WM8962_SYSCLK_MCLK, priv->clk_frequency,
 					SND_SOC_CLOCK_IN);
 			if (ret < 0) {
 				dev_err(dev,
@@ -141,14 +137,13 @@ static int imx_wm8962_late_probe(struct snd_soc_card *card)
 	struct snd_soc_pcm_runtime *rtd;
 	struct snd_soc_dai *codec_dai;
 	struct imx_priv *priv = snd_soc_card_get_drvdata(card);
-	struct imx_wm8962_data *data = snd_soc_card_get_drvdata(card);
 	struct device *dev = &priv->pdev->dev;
 	int ret;
 
 	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
 	codec_dai = rtd->codec_dai;
 	ret = snd_soc_dai_set_sysclk(codec_dai, WM8962_SYSCLK_MCLK,
-			data->clk_frequency, SND_SOC_CLOCK_IN);
+			priv->clk_frequency, SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		dev_err(dev, "failed to set sysclk in %s\n", __func__);
 
@@ -161,7 +156,6 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 	struct device_node *ssi_np, *codec_np;
 	struct platform_device *ssi_pdev;
 	struct i2c_client *codec_dev;
-	struct imx_wm8962_data *data;
 	struct imx_priv *priv;
 	struct clk *codec_clk;
 	int int_port, ext_port;
@@ -232,12 +226,6 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		ret = -ENOMEM;
-		goto fail;
-	}
-
 	codec_clk = clk_get(&codec_dev->dev, NULL);
 	if (IS_ERR(codec_clk)) {
 		ret = PTR_ERR(codec_clk);
@@ -245,39 +233,39 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	data->clk_frequency = clk_get_rate(codec_clk);
+	priv->clk_frequency = clk_get_rate(codec_clk);
 	clk_put(codec_clk);
 
-	data->dai.name = "HiFi";
-	data->dai.stream_name = "HiFi";
-	data->dai.codec_dai_name = "wm8962";
-	data->dai.codec_of_node = codec_np;
-	data->dai.cpu_dai_name = dev_name(&ssi_pdev->dev);
-	data->dai.platform_of_node = ssi_np;
-	data->dai.ops = &imx_hifi_ops;
-	data->dai.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+	priv->dai.name = "HiFi";
+	priv->dai.stream_name = "HiFi";
+	priv->dai.codec_dai_name = "wm8962";
+	priv->dai.codec_of_node = codec_np;
+	priv->dai.cpu_dai_name = dev_name(&ssi_pdev->dev);
+	priv->dai.platform_of_node = ssi_np;
+	priv->dai.ops = &imx_hifi_ops;
+	priv->dai.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			    SND_SOC_DAIFMT_CBM_CFM;
 
-	data->card.dev = &pdev->dev;
-	ret = snd_soc_of_parse_card_name(&data->card, "model");
+	priv->card.dev = &pdev->dev;
+	ret = snd_soc_of_parse_card_name(&priv->card, "model");
 	if (ret)
 		goto fail;
-	ret = snd_soc_of_parse_audio_routing(&data->card, "audio-routing");
+	ret = snd_soc_of_parse_audio_routing(&priv->card, "audio-routing");
 	if (ret)
 		goto fail;
-	data->card.num_links = 1;
-	data->card.owner = THIS_MODULE;
-	data->card.dai_link = &data->dai;
-	data->card.dapm_widgets = imx_wm8962_dapm_widgets;
-	data->card.num_dapm_widgets = ARRAY_SIZE(imx_wm8962_dapm_widgets);
+	priv->card.num_links = 1;
+	priv->card.owner = THIS_MODULE;
+	priv->card.dai_link = &priv->dai;
+	priv->card.dapm_widgets = imx_wm8962_dapm_widgets;
+	priv->card.num_dapm_widgets = ARRAY_SIZE(imx_wm8962_dapm_widgets);
 
-	data->card.late_probe = imx_wm8962_late_probe;
-	data->card.set_bias_level = imx_wm8962_set_bias_level;
+	priv->card.late_probe = imx_wm8962_late_probe;
+	priv->card.set_bias_level = imx_wm8962_set_bias_level;
 
-	platform_set_drvdata(pdev, &data->card);
-	snd_soc_card_set_drvdata(&data->card, data);
+	platform_set_drvdata(pdev, &priv->card);
+	snd_soc_card_set_drvdata(&priv->card, priv);
 
-	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
+	ret = devm_snd_soc_register_card(&pdev->dev, &priv->card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
 		goto fail;
-- 
2.7.4
