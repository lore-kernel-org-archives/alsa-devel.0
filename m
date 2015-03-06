From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH][ASoC]Add DT bindings for generic ASoC AC97 CODEC driver
Date: Fri, 06 Mar 2015 19:55:26 +0100
Message-ID: <54F9F81E.8080105@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add and document DT bindings for generic ASoC AC97 CODEC driver,
make it selectable in config.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>

diff --git a/Documentation/devicetree/bindings/sound/ac97-generic-codec.txt b/Documentation/devicetree/bindings/sound/ac97-generic-codec.txt
new file mode 100644
index 0000000..ce98698
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ac97-generic-codec.txt
@@ -0,0 +1,24 @@
+Generic ASoC AC97 CODEC driver
+
+Allows using codecs supported by generic ALSA AC97 code as codecs in ASoC.
+
+Required properties:
+
+  - compatible : "linux,ac97-codec"
+
+Optional properties:
+
+  - playback-rates : A list of supported playback rates.
+
+  - capture-rates : A list of supported capture rates.
+
+In case one or both of above properties are missing the relevant rate(s) are assumed
+to be 8000, 11025, 22050, 44100, 48000.
+
+Example:
+
+ac97codec: ac97-hifi {
+	compatible = "linux,ac97-codec";
+	playback-rates = <48000 44100 32000 24000 22050 16000 12000 11025 8000>;
+	capture-rates = <48000>;
+};
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0bddd92..92d6d39 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -16,7 +16,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_88PM860X if MFD_88PM860X
 	select SND_SOC_L3
 	select SND_SOC_AB8500_CODEC if ABX500_CORE
-	select SND_SOC_AC97_CODEC if SND_SOC_AC97_BUS
+	select SND_SOC_AC97_CODEC
 	select SND_SOC_AD1836 if SPI_MASTER
 	select SND_SOC_AD193X_SPI if SPI_MASTER
 	select SND_SOC_AD193X_I2C if I2C
@@ -210,8 +210,9 @@ config SND_SOC_AB8500_CODEC
 	tristate
 
 config SND_SOC_AC97_CODEC
-	tristate
+	tristate "Build generic ASoC AC97 CODEC driver"
 	select SND_AC97_CODEC
+	select SND_SOC_AC97_BUS
 
 config SND_SOC_AD1836
 	tristate
diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index d0ac723..25125bf 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -23,6 +23,12 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
+struct ac97_private {
+	struct snd_ac97 *ac97;
+	struct snd_pcm_hw_constraint_list playback_rate_constraints;
+	struct snd_pcm_hw_constraint_list capture_rate_constraints;
+};
+
 static const struct snd_soc_dapm_widget ac97_widgets[] = {
 	SND_SOC_DAPM_INPUT("RX"),
 	SND_SOC_DAPM_OUTPUT("TX"),
@@ -33,22 +39,41 @@ static const struct snd_soc_dapm_route ac97_routes[] = {
 	{ "TX", NULL, "AC97 Playback" },
 };
 
+static const unsigned int default_rates[] = {
+	8000, 11025, 22050, 44100, 48000
+};
+
+static int ac97_startup(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct ac97_private *ac97 = snd_soc_codec_get_drvdata(codec);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE,
+			&ac97->playback_rate_constraints);
+	else
+		snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE,
+			&ac97->capture_rate_constraints);
+
+	return 0;
+}
+
 static int ac97_prepare(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
+	struct ac97_private *ac97 = snd_soc_codec_get_drvdata(codec);
 
 	int reg = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
 		  AC97_PCM_FRONT_DAC_RATE : AC97_PCM_LR_ADC_RATE;
-	return snd_ac97_set_rate(ac97, reg, substream->runtime->rate);
+	return snd_ac97_set_rate(ac97->ac97, reg, substream->runtime->rate);
 }
 
-#define STD_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
-		SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 |\
-		SNDRV_PCM_RATE_48000)
-
 static const struct snd_soc_dai_ops ac97_dai_ops = {
+	.startup	= ac97_startup,
 	.prepare	= ac97_prepare,
 };
 
@@ -58,20 +83,21 @@ static struct snd_soc_dai_driver ac97_dai = {
 		.stream_name = "AC97 Playback",
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = STD_AC97_RATES,
+		.rates = SNDRV_PCM_RATE_KNOT,
 		.formats = SND_SOC_STD_AC97_FMTS,},
 	.capture = {
 		.stream_name = "AC97 Capture",
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = STD_AC97_RATES,
+		.rates = SNDRV_PCM_RATE_KNOT,
 		.formats = SND_SOC_STD_AC97_FMTS,},
 	.ops = &ac97_dai_ops,
 };
 
 static int ac97_soc_probe(struct snd_soc_codec *codec)
 {
-	struct snd_ac97 *ac97;
+	struct ac97_private *ac97 = snd_soc_codec_get_drvdata(codec);
+
 	struct snd_ac97_bus *ac97_bus;
 	struct snd_ac97_template ac97_template;
 	int ret;
@@ -83,31 +109,28 @@ static int ac97_soc_probe(struct snd_soc_codec *codec)
 		return ret;
 
 	memset(&ac97_template, 0, sizeof(struct snd_ac97_template));
-	ret = snd_ac97_mixer(ac97_bus, &ac97_template, &ac97);
+	ret = snd_ac97_mixer(ac97_bus, &ac97_template, &ac97->ac97);
 	if (ret < 0)
 		return ret;
 
-	snd_soc_codec_set_drvdata(codec, ac97);
-
 	return 0;
 }
 
 #ifdef CONFIG_PM
 static int ac97_soc_suspend(struct snd_soc_codec *codec)
 {
-	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
+	struct ac97_private *ac97 = snd_soc_codec_get_drvdata(codec);
 
-	snd_ac97_suspend(ac97);
+	snd_ac97_suspend(ac97->ac97);
 
 	return 0;
 }
 
 static int ac97_soc_resume(struct snd_soc_codec *codec)
 {
+	struct ac97_private *ac97 = snd_soc_codec_get_drvdata(codec);
 
-	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
-
-	snd_ac97_resume(ac97);
+	snd_ac97_resume(ac97->ac97);
 
 	return 0;
 }
@@ -127,8 +150,89 @@ static struct snd_soc_codec_driver soc_codec_dev_ac97 = {
 	.num_dapm_routes = ARRAY_SIZE(ac97_routes),
 };
 
+#ifdef CONFIG_OF
+static int ac97_of_read_rates(struct platform_device *pdev,
+			const char *name,
+			struct snd_pcm_hw_constraint_list *cons)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct property *prop;
+	int len, count, ctr;
+	unsigned int *clist;
+
+	prop = of_find_property(np, name, &len);
+	if (!prop)
+		return 0;
+
+	count = len / sizeof(u32);
+	if (count <= 0)
+		return 0;
+
+	clist = devm_kzalloc(&pdev->dev, count * sizeof(unsigned int),
+				GFP_KERNEL);
+	if (!clist)
+		return -ENOMEM;
+
+	for (ctr = 0; ctr < count; ctr++) {
+		int ret;
+		u32 val;
+
+		ret = of_property_read_u32_index(np, name, ctr, &val);
+		if (ret)
+			return ret;
+
+		clist[ctr] = val;
+	}
+
+	cons->list = clist;
+	cons->count = ctr;
+
+	return 0;
+}
+#endif
+
 static int ac97_probe(struct platform_device *pdev)
 {
+	struct ac97_private *ac97 =
+		devm_kzalloc(&pdev->dev, sizeof(struct ac97_private),
+				GFP_KERNEL);
+#ifdef CONFIG_OF
+	struct device_node *np = pdev->dev.of_node;
+#endif
+
+	if (!ac97)
+		return -ENOMEM;
+
+#ifdef CONFIG_OF
+	if (np) {
+		int ret;
+
+		ret = ac97_of_read_rates(pdev, "playback-rates",
+			&ac97->playback_rate_constraints);
+		if (ret)
+			return ret;
+
+		ret = ac97_of_read_rates(pdev, "capture-rates",
+			&ac97->capture_rate_constraints);
+		if (ret)
+			return ret;
+	}
+#endif
+
+	if (!ac97->playback_rate_constraints.list) {
+		ac97->playback_rate_constraints.list = default_rates;
+		ac97->playback_rate_constraints.count =
+			ARRAY_SIZE(default_rates);
+	}
+
+	if (!ac97->capture_rate_constraints.list) {
+		ac97->capture_rate_constraints.list = default_rates;
+		ac97->capture_rate_constraints.count =
+			ARRAY_SIZE(default_rates);
+	}
+
+	platform_set_drvdata(pdev, ac97);
+
 	return snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_ac97, &ac97_dai, 1);
 }
@@ -139,9 +243,16 @@ static int ac97_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ac97_codec_dt_ids[] = {
+	{ .compatible = "linux,ac97-codec", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ac97_codec_dt_ids);
+
 static struct platform_driver ac97_codec_driver = {
 	.driver = {
 		.name = "ac97-codec",
+		.of_match_table = of_match_ptr(ac97_codec_dt_ids),
 	},
 
 	.probe = ac97_probe,
