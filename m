From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs47l24: Add voice control compressed
	stream" to the asoc tree
Date: Fri, 29 Jan 2016 12:40:25 +0100
Message-ID: <E1aP7Pd-0006wB-Iz@finisterre>
References: <1453470599-19916-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5202B260694
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2016 12:40:42 +0100 (CET)
In-Reply-To: <1453470599-19916-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs47l24: Add voice control compressed stream

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

>From 7eec55d7a2f2932b3b4a799bc5d0d6718e1ee9e2 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Fri, 22 Jan 2016 13:49:59 +0000
Subject: [PATCH] ASoC: cs47l24: Add voice control compressed stream

This patch adds firmware compressed stream capture support
and DAI hookups for voice control firmware (based on the wm5110
implementation.)

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs47l24.c | 98 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 9dc77a4..b8d3cd0 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -798,6 +798,9 @@ static const struct snd_soc_dapm_route cs47l24_dapm_routes[] = {
 	{ "AIF2 Capture", NULL, "SYSCLK" },
 	{ "AIF3 Capture", NULL, "SYSCLK" },
 
+	{ "Voice Control DSP", NULL, "DSP3" },
+	{ "Voice Control DSP", NULL, "SYSCLK" },
+
 	{ "IN1L PGA", NULL, "IN1L" },
 	{ "IN1R PGA", NULL, "IN1R" },
 
@@ -992,12 +995,68 @@ static struct snd_soc_dai_driver cs47l24_dai[] = {
 		.symmetric_rates = 1,
 		.symmetric_samplebits = 1,
 	},
+	{
+		.name = "cs47l24-cpu-voicectrl",
+		.capture = {
+			.stream_name = "Voice Control CPU",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = CS47L24_RATES,
+			.formats = CS47L24_FORMATS,
+		},
+		.compress_new = snd_soc_new_compress,
+	},
+	{
+		.name = "cs47l24-dsp-voicectrl",
+		.capture = {
+			.stream_name = "Voice Control DSP",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = CS47L24_RATES,
+			.formats = CS47L24_FORMATS,
+		},
+	},
 };
 
+static int cs47l24_open(struct snd_compr_stream *stream)
+{
+	struct snd_soc_pcm_runtime *rtd = stream->private_data;
+	struct cs47l24_priv *priv = snd_soc_codec_get_drvdata(rtd->codec);
+	struct arizona *arizona = priv->core.arizona;
+	int n_adsp;
+
+	if (strcmp(rtd->codec_dai->name, "cs47l24-dsp-voicectrl") == 0) {
+		n_adsp = 2;
+	} else {
+		dev_err(arizona->dev,
+			"No suitable compressed stream for DAI '%s'\n",
+			rtd->codec_dai->name);
+		return -EINVAL;
+	}
+
+	return wm_adsp_compr_open(&priv->core.adsp[n_adsp], stream);
+}
+
+static irqreturn_t cs47l24_adsp2_irq(int irq, void *data)
+{
+	struct cs47l24_priv *priv = data;
+	struct arizona *arizona = priv->core.arizona;
+	int ret;
+
+	ret = wm_adsp_compr_handle_irq(&priv->core.adsp[2]);
+	if (ret == -ENODEV) {
+		dev_err(arizona->dev, "Spurious compressed data IRQ\n");
+		return IRQ_NONE;
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int cs47l24_codec_probe(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct cs47l24_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->core.arizona;
 	int ret;
 
 	priv->core.arizona->dapm = dapm;
@@ -1006,6 +1065,14 @@ static int cs47l24_codec_probe(struct snd_soc_codec *codec)
 	arizona_init_gpio(codec);
 	arizona_init_mono(codec);
 
+	ret = arizona_request_irq(arizona, ARIZONA_IRQ_DSP_IRQ1,
+				  "ADSP2 Compressed IRQ", cs47l24_adsp2_irq,
+				  priv);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to request DSP IRQ: %d\n", ret);
+		return ret;
+	}
+
 	ret = wm_adsp2_codec_probe(&priv->core.adsp[1], codec);
 	if (ret)
 		goto err_adsp2_codec_probe;
@@ -1033,13 +1100,14 @@ err_adsp2_codec_probe:
 static int cs47l24_codec_remove(struct snd_soc_codec *codec)
 {
 	struct cs47l24_priv *priv = snd_soc_codec_get_drvdata(codec);
-
+	struct arizona *arizona = priv->core.arizona;
 
 	wm_adsp2_codec_remove(&priv->core.adsp[1], codec);
 	wm_adsp2_codec_remove(&priv->core.adsp[2], codec);
 
 	priv->core.arizona->dapm = NULL;
 
+	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, priv);
 	return 0;
 }
 
@@ -1076,6 +1144,19 @@ static struct snd_soc_codec_driver soc_codec_dev_cs47l24 = {
 	.num_dapm_routes = ARRAY_SIZE(cs47l24_dapm_routes),
 };
 
+static struct snd_compr_ops cs47l24_compr_ops = {
+	.open = cs47l24_open,
+	.free = wm_adsp_compr_free,
+	.set_params = wm_adsp_compr_set_params,
+	.get_caps = wm_adsp_compr_get_caps,
+	.trigger = wm_adsp_compr_trigger,
+	.pointer = wm_adsp_compr_pointer,
+	.copy = wm_adsp_compr_copy,
+};
+
+static struct snd_soc_platform_driver cs47l24_compr_platform = {
+	.compr_ops = &cs47l24_compr_ops,
+};
 static int cs47l24_probe(struct platform_device *pdev)
 {
 	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
@@ -1139,12 +1220,25 @@ static int cs47l24_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
-	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_cs47l24,
+	ret = snd_soc_register_platform(&pdev->dev, &cs47l24_compr_platform);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register platform: %d\n", ret);
+		return ret;
+	}
+	ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_cs47l24,
 				      cs47l24_dai, ARRAY_SIZE(cs47l24_dai));
+
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register codec: %d\n", ret);
+		snd_soc_unregister_platform(&pdev->dev);
+	}
+
+	return ret;
 }
 
 static int cs47l24_remove(struct platform_device *pdev)
 {
+	snd_soc_unregister_platform(&pdev->dev);
 	snd_soc_unregister_codec(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.6.4
