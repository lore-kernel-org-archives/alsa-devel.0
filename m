From: Lin Huang <hl@rock-chips.com>
Subject: [PATCH v2 1/2] ASoC: codec: use enable pin to control dmic start and stop
Date: Thu, 17 Aug 2017 10:24:44 +0800
Message-ID: <1502936685-24414-1-git-send-email-hl@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, arnaud.pouliquen@st.com, dgreif@chromium.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, briannorris@chromium.org, linux-kernel@vger.kernel.org, tiwai@suse.com, mka@chromium.org, dianders@chromium.org, huang lin <hl@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

From: huang lin <hl@rock-chips.com>

on some board use enable pin to control dmic start and stop,
so add this feature in dmic driver.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
 sound/soc/codecs/Kconfig |  2 +-
 sound/soc/codecs/dmic.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 010811e..d98233b 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -71,7 +71,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_DA732X if I2C
 	select SND_SOC_DA9055 if I2C
 	select SND_SOC_DIO2125
-	select SND_SOC_DMIC
+	select SND_SOC_DMIC if GPIOLIB
 	select SND_SOC_ES8316 if I2C
 	select SND_SOC_ES8328_SPI if SPI_MASTER
 	select SND_SOC_ES8328_I2C if I2C
diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index 12e07f9..b88a1ee 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -19,6 +19,8 @@
  *
  */
 
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -27,6 +29,34 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 
+static int dmic_daiops_trigger(struct snd_pcm_substream *substream,
+		int cmd, struct snd_soc_dai *dai)
+{
+	struct gpio_desc *dmic_en = snd_soc_dai_get_drvdata(dai);
+
+	if (!dmic_en)
+		return 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		gpiod_set_value(dmic_en, 1);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		gpiod_set_value(dmic_en, 0);
+		break;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops dmic_dai_ops = {
+	.trigger	= dmic_daiops_trigger,
+};
+
 static struct snd_soc_dai_driver dmic_dai = {
 	.name = "dmic-hifi",
 	.capture = {
@@ -38,8 +68,23 @@ static struct snd_soc_dai_driver dmic_dai = {
 			| SNDRV_PCM_FMTBIT_S24_LE
 			| SNDRV_PCM_FMTBIT_S16_LE,
 	},
+	.ops    = &dmic_dai_ops,
 };
 
+static int dmic_codec_probe(struct snd_soc_codec *codec)
+{
+	struct gpio_desc *dmic_en;
+
+	dmic_en = devm_gpiod_get_optional(codec->dev,
+					"dmicen", GPIOD_OUT_LOW);
+	if (IS_ERR(dmic_en))
+		return PTR_ERR(dmic_en);
+
+	snd_soc_codec_set_drvdata(codec, dmic_en);
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget dmic_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_OUT("DMIC AIF", "Capture", 0,
 			     SND_SOC_NOPM, 0, 0),
@@ -51,6 +96,7 @@ static const struct snd_soc_dapm_route intercon[] = {
 };
 
 static const struct snd_soc_codec_driver soc_dmic = {
+	.probe = dmic_codec_probe,
 	.component_driver = {
 		.dapm_widgets		= dmic_dapm_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(dmic_dapm_widgets),
-- 
2.7.4
