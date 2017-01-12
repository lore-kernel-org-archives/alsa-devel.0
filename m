From: Shrirang Bagul <shrirang.bagul@canonical.com>
Subject: [PATCH v2 4/4] ASoC: Intel: bytcr_rt5640: Support line-out mute gpio
Date: Thu, 12 Jan 2017 20:01:01 +0800
Message-ID: <20170112120101.16933-5-shrirang.bagul@canonical.com>
References: <20170112120101.16933-1-shrirang.bagul@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170112120101.16933-1-shrirang.bagul@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Shrirang Bagul <shrirang.bagul@canonical.com>, Irina Tirdea <irina.tirdea@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch adds support to toggle mute on 'line-out' pin on Dell Edge
IoT Gateways. A dedicated GPIO on the SoC is used to control the amplifier.
This GPIO is described in the BIOS DSD table.

Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index e8c9a01..ae53a29 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/gpio/consumer.h>
 #include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
@@ -74,6 +75,7 @@ struct byt_acpi_card {
 
 struct byt_rt5640_private {
 	struct byt_acpi_card *acpi_card;
+	struct gpio_desc *gpio_lo_mute;
 	struct clk *mclk;
 	char codec_name[16];
 	int *clks;
@@ -198,6 +200,19 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int byt_rt5660_event_lineout(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_soc_card *card = dapm->card;
+	struct byt_rt5640_private *priv = snd_soc_card_get_drvdata(card);
+
+	gpiod_set_value_cansleep(priv->gpio_lo_mute,
+			!(SND_SOC_DAPM_EVENT_ON(event)));
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget byt_rt5640_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
@@ -296,7 +311,7 @@ static const struct snd_kcontrol_new byt_rt5640_controls[] = {
 
 static const struct snd_soc_dapm_widget byt_rt5660_widgets[] = {
 	SND_SOC_DAPM_MIC("Line In", NULL),
-	SND_SOC_DAPM_LINE("Line Out", NULL),
+	SND_SOC_DAPM_LINE("Line Out", byt_rt5660_event_lineout),
 	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
 			platform_clock_control, SND_SOC_DAPM_PRE_PMU |
 			SND_SOC_DAPM_POST_PMD),
@@ -562,7 +577,18 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 static int byt_rt5660_init(struct snd_soc_pcm_runtime *runtime)
 {
 	int ret;
+	struct snd_soc_codec *codec = runtime->codec;
 	struct snd_soc_card *card = runtime->card;
+	struct byt_rt5640_private *priv = snd_soc_card_get_drvdata(card);
+
+	/* Request rt5660 GPIO for lineout mute control */
+	priv->gpio_lo_mute = devm_gpiod_get_index(codec->dev,
+			"lineout-mute", 0, 0);
+	if (IS_ERR(priv->gpio_lo_mute)) {
+		dev_err(card->dev, "Can't find GPIO_MUTE# gpio\n");
+		return PTR_ERR(priv->gpio_lo_mute);
+	}
+	gpiod_direction_output(priv->gpio_lo_mute, 1);
 
 	ret = snd_soc_dapm_add_routes(&card->dapm,
 			byt_rt5640_ssp2_aif1_map,
-- 
2.9.3
