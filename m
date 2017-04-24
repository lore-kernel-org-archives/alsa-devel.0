From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: imx-wm8962: Remove global variables" to
	the asoc tree
Date: Mon, 24 Apr 2017 19:20:59 +0100
Message-ID: <E1d2ibb-0000kM-4f@debutante>
References: <1492989633-19909-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D58C22674CA
 for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2017 20:21:12 +0200 (CEST)
In-Reply-To: <1492989633-19909-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, broonie@kernel.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: imx-wm8962: Remove global variables

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8f7206d69ab8c8fb8620566338d54c4b9b80477a Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Sun, 23 Apr 2017 20:20:33 -0300
Subject: [PATCH] ASoC: imx-wm8962: Remove global variables

Currently the following variables are global:
- card_priv, sample_rate and sample_format

,which is not a good idea as it prevents the usage of multiple
instances.

Make sample_rate and sample_format part of the imx_priv structure
and allocate imx_priv via the standard devm_kzalloc() mechanism
inside the probe function.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-wm8962.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
index 52659faa2eb9..206b898e554c 100644
--- a/sound/soc/fsl/imx-wm8962.c
+++ b/sound/soc/fsl/imx-wm8962.c
@@ -38,8 +38,9 @@ struct imx_wm8962_data {
 
 struct imx_priv {
 	struct platform_device *pdev;
+	int sample_rate;
+	snd_pcm_format_t sample_format;
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
2.11.0
