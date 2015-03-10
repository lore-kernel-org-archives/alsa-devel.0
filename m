From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH][ASoC]Add ability to remove rate constraints from generic
 ASoC AC'97 CODEC driver
Date: Wed, 11 Mar 2015 00:28:19 +0100
Message-ID: <54FF7E13.4060801@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add ability to remove rate constraints from generic ASoC AC'97 CODEC
driver via passed platform data, make it selectable in config.

This way this driver can be used for platforms which don't need
specialized AC'97 CODEC drivers while at the same avoiding
code duplication from implementing equivalent functionality in
a controller driver.

There is no change in behavior when no platform data is passed.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>

diff --git a/include/sound/soc-ac97.h b/include/sound/soc-ac97.h
new file mode 100644
index 0000000..ceb4e2f
--- /dev/null
+++ b/include/sound/soc-ac97.h
@@ -0,0 +1,17 @@
+/*
+ * Platform data for generic ASoC AC97 CODEC driver.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef __LINUX_SND__SOC_AC97_H
+#define __LINUX_SND__SOC_AC97_H
+
+struct snd_soc_ac97_codec_platform_data {
+	bool playback_rate_constrained;
+	bool capture_rate_constrained;
+};
+
+#endif /* __LINUX_SND__SOC_AC97_H */
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
index d0ac723..c3fb845 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -20,9 +20,16 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
+#include <sound/soc-ac97.h>
 #include <sound/initval.h>
 #include <sound/soc.h>
 
+struct ac97_private {
+	struct snd_ac97 *ac97;
+	bool playback_rate_constrained;
+	bool capture_rate_constrained;
+};
+
 static const struct snd_soc_dapm_widget ac97_widgets[] = {
 	SND_SOC_DAPM_INPUT("RX"),
 	SND_SOC_DAPM_OUTPUT("TX"),
@@ -33,22 +40,53 @@ static const struct snd_soc_dapm_route ac97_routes[] = {
 	{ "TX", NULL, "AC97 Playback" },
 };
 
+static const unsigned int default_rates[] = {
+	8000, 11025, 22050, 44100, 48000
+};
+
+static const struct snd_pcm_hw_constraint_list default_rate_constraints = {
+	.count	= ARRAY_SIZE(default_rates),
+	.list	= default_rates,
+};
+
+static int ac97_startup(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct ac97_private *ac97 = snd_soc_codec_get_drvdata(codec);
+	bool constrained;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		constrained = ac97->playback_rate_constrained;
+	else
+		constrained = ac97->capture_rate_constrained;
+
+	if (!constrained)
+		return 0;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE, &default_rate_constraints);
+	else
+		snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE, &default_rate_constraints);
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
 
@@ -58,20 +96,21 @@ static struct snd_soc_dai_driver ac97_dai = {
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
@@ -83,31 +122,28 @@ static int ac97_soc_probe(struct snd_soc_codec *codec)
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
@@ -129,6 +165,27 @@ static struct snd_soc_codec_driver soc_codec_dev_ac97 = {
 
 static int ac97_probe(struct platform_device *pdev)
 {
+	struct ac97_private *ac97 =
+		devm_kzalloc(&pdev->dev, sizeof(struct ac97_private),
+				GFP_KERNEL);
+	struct snd_soc_ac97_codec_platform_data *pdata =
+		pdev->dev.platform_data;
+
+	if (!ac97)
+		return -ENOMEM;
+
+	if (pdata) {
+		ac97->playback_rate_constrained =
+			pdata->playback_rate_constrained;
+		ac97->capture_rate_constrained =
+			pdata->capture_rate_constrained;
+	} else {
+		ac97->playback_rate_constrained = 1;
+		ac97->capture_rate_constrained = 1;
+	}
+
+	platform_set_drvdata(pdev, ac97);
+
 	return snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_ac97, &ac97_dai, 1);
 }
