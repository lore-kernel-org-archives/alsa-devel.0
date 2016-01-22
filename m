From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: cs47l24: Add voice control compressed
	stream
Date: Fri, 22 Jan 2016 13:49:59 +0000
Message-ID: <1453470599-19916-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id EA0C4260544
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 14:50:03 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds firmware compressed stream capture support
and DAI hookups for voice control firmware (based on the wm5110
implementation.)

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs47l24.c | 98 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index dc5ae7f..1992077 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -779,6 +779,9 @@ static const struct snd_soc_dapm_route cs47l24_dapm_routes[] = {
 	{ "AIF2 Capture", NULL, "SYSCLK" },
 	{ "AIF3 Capture", NULL, "SYSCLK" },
 
+	{ "Voice Control DSP", NULL, "DSP3" },
+	{ "Voice Control DSP", NULL, "SYSCLK" },
+
 	{ "IN1L PGA", NULL, "IN1L" },
 	{ "IN1R PGA", NULL, "IN1R" },
 
@@ -973,12 +976,68 @@ static struct snd_soc_dai_driver cs47l24_dai[] = {
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
@@ -987,6 +1046,14 @@ static int cs47l24_codec_probe(struct snd_soc_codec *codec)
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
@@ -1014,13 +1081,14 @@ err_adsp2_codec_probe:
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
 
@@ -1057,6 +1125,19 @@ static struct snd_soc_codec_driver soc_codec_dev_cs47l24 = {
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
@@ -1120,12 +1201,25 @@ static int cs47l24_probe(struct platform_device *pdev)
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
1.9.1
