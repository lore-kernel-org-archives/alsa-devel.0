From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: imx-wm8962: Remove global variables
Date: Sun, 23 Apr 2017 19:12:57 -0300
Message-ID: <1492985577-14731-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f194.google.com (mail-qt0-f194.google.com
 [209.85.216.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 89111266AF7
 for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2017 00:13:31 +0200 (CEST)
Received: by mail-qt0-f194.google.com with SMTP id y33so18201180qta.1
 for <alsa-devel@alsa-project.org>; Sun, 23 Apr 2017 15:13:31 -0700 (PDT)
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Currently the following variables are global:
- card_priv, sample_rate and sample_format

,which is not a good idea as it prevents the usage of multiple
instances.

Make sample_rate and sample_format part of the imx_priv structure
and allocate imx_priv via the standard devm_kzalloc() mechanism
inside the probe function.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/fsl/imx-wm8962.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
index 52659fa..fbeada7 100644
--- a/sound/soc/fsl/imx-wm8962.c
+++ b/sound/soc/fsl/imx-wm8962.c
@@ -38,8 +38,9 @@ struct imx_wm8962_data {
 
 struct imx_priv {
 	struct platform_device *pdev;
+	u32 sample_rate;
+	u32 sample_format;
 };
-static struct imx_priv card_priv;
 
 static const struct snd_soc_dapm_widget imx_wm8962_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
@@ -48,14 +49,14 @@ static const struct snd_soc_dapm_widget imx_wm8962_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("DMIC", NULL),
 };
 
-static int sample_rate = 44100;
-static snd_pcm_format_t sample_format = SNDRV_PCM_FORMAT_S16_LE;
-
 static int imx_hifi_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params)
 {
-	sample_rate = params_rate(params);
-	sample_format = params_format(params);
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct imx_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+
+	priv->sample_rate = params_rate(params);
+	priv->sample_format = params_format(params);
 
 	return 0;
 }
@@ -70,7 +71,7 @@ static int imx_wm8962_set_bias_level(struct snd_soc_card *card,
 {
 	struct snd_soc_pcm_runtime *rtd;
 	struct snd_soc_dai *codec_dai;
-	struct imx_priv *priv = &card_priv;
+	struct imx_priv *priv = snd_soc_card_get_drvdata(card);
 	struct imx_wm8962_data *data = snd_soc_card_get_drvdata(card);
 	struct device *dev = &priv->pdev->dev;
 	unsigned int pll_out;
@@ -84,10 +85,10 @@ static int imx_wm8962_set_bias_level(struct snd_soc_card *card,
 	switch (level) {
 	case SND_SOC_BIAS_PREPARE:
 		if (dapm->bias_level == SND_SOC_BIAS_STANDBY) {
-			if (sample_format == SNDRV_PCM_FORMAT_S24_LE)
-				pll_out = sample_rate * 384;
+			if (priv->sample_format == SNDRV_PCM_FORMAT_S24_LE)
+				pll_out = priv->sample_rate * 384;
 			else
-				pll_out = sample_rate * 256;
+				pll_out = priv->sample_rate * 256;
 
 			ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL,
 					WM8962_FLL_MCLK, data->clk_frequency,
@@ -139,7 +140,7 @@ static int imx_wm8962_late_probe(struct snd_soc_card *card)
 {
 	struct snd_soc_pcm_runtime *rtd;
 	struct snd_soc_dai *codec_dai;
-	struct imx_priv *priv = &card_priv;
+	struct imx_priv *priv = snd_soc_card_get_drvdata(card);
 	struct imx_wm8962_data *data = snd_soc_card_get_drvdata(card);
 	struct device *dev = &priv->pdev->dev;
 	int ret;
@@ -159,14 +160,20 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *ssi_np, *codec_np;
 	struct platform_device *ssi_pdev;
-	struct imx_priv *priv = &card_priv;
 	struct i2c_client *codec_dev;
 	struct imx_wm8962_data *data;
+	struct imx_priv *priv;
 	struct clk *codec_clk;
 	int int_port, ext_port;
 	int ret;
 
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
 	priv->pdev = pdev;
+	priv->sample_rate = 44100;
+	priv->sample_format = SNDRV_PCM_FORMAT_S16_LE;
 
 	ret = of_property_read_u32(np, "mux-int-port", &int_port);
 	if (ret) {
-- 
2.7.4
