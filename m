From: Matt Flax <flatmax@flatmax.org>
Subject: [PATCH] ASoc: wm8580: Add the wm8581 codec to the
	driver
Date: Wed, 19 Oct 2016 05:24:35 +1100
Message-ID: <1476815075-12976-1-git-send-email-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nskntmtas03p.mx.bigpond.com (nskntmtas03p.mx.bigpond.com
 [61.9.168.143]) by alsa0.perex.cz (Postfix) with ESMTP id D9470266F03
 for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2016 20:25:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, ckeepax@opensource.wolfsonmicro.com
Cc: Matt Flax <flatmax@flatmax.org>
List-Id: alsa-devel@alsa-project.org

This patch adds support for the wm8581 codec to the wm8580 driver.
The wm8581 codec hardware adds a fourth DAC and otherwise is
compatible with the wm8580 codec.

of_device_id data is used to allow the driver to select the
suitable DAC count specified in the device tree codec selection.
The wm8580_driver_data struct is used to store the number of DACs.

The snd_soc_dai_driver no longer lists the channels_max for the
playback substream. This variable is set during the i2c probe
from the of_device_id supplied wm8580_driver_data struct.

With knowledge of the number of DACs in use, the DAC4 controls,
widgets and routes are added as required for DAC4.

The device tree documentation for the wm8580 is altered to list
the wm8581 codec support, as is the Kconfig file.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
---
 Documentation/devicetree/bindings/sound/wm8580.txt |  4 +-
 sound/soc/codecs/Kconfig                           |  2 +-
 sound/soc/codecs/wm8580.c                          | 98 ++++++++++++++++++++--
 3 files changed, 92 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/wm8580.txt b/Documentation/devicetree/bindings/sound/wm8580.txt
index 7d9821f..78fce9b 100644
--- a/Documentation/devicetree/bindings/sound/wm8580.txt
+++ b/Documentation/devicetree/bindings/sound/wm8580.txt
@@ -1,10 +1,10 @@
-WM8580 audio CODEC
+WM8580 and WM8581 audio CODEC
 
 This device supports I2C only.
 
 Required properties:
 
-  - compatible : "wlf,wm8580"
+  - compatible : "wlf,wm8580", "wlf,wm8581"
 
   - reg : the I2C address of the device.
 
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c67667b..199bec8 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -914,7 +914,7 @@ config SND_SOC_WM8523
 	depends on I2C
 
 config SND_SOC_WM8580
-	tristate "Wolfson Microelectronics WM8523 CODEC"
+	tristate "Wolfson Microelectronics WM8580 and WM8581 CODECs"
 	depends on I2C
 
 config SND_SOC_WM8711
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index faa7287..d57dceb 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -1,5 +1,5 @@
 /*
- * wm8580.c  --  WM8580 ALSA Soc Audio driver
+ * wm8580.c  --  WM8580 and WM8581 ALSA Soc Audio driver
  *
  * Copyright 2008-12 Wolfson Microelectronics PLC.
  *
@@ -12,6 +12,9 @@
  *  The WM8580 is a multichannel codec with S/PDIF support, featuring six
  *  DAC channels and two ADC channels.
  *
+ *  The WM8581 is a multichannel codec with S/PDIF support, featuring eight
+ *  DAC channels and two ADC channels.
+ *
  *  Currently only the primary audio interface is supported - S/PDIF and
  *  the secondary audio interfaces are not.
  */
@@ -65,6 +68,8 @@
 #define WM8580_DIGITAL_ATTENUATION_DACR2     0x17
 #define WM8580_DIGITAL_ATTENUATION_DACL3     0x18
 #define WM8580_DIGITAL_ATTENUATION_DACR3     0x19
+#define WM8580_DIGITAL_ATTENUATION_DACL4     0x1A
+#define WM8580_DIGITAL_ATTENUATION_DACR4     0x1B
 #define WM8580_MASTER_DIGITAL_ATTENUATION    0x1C
 #define WM8580_ADC_CONTROL1                  0x1D
 #define WM8580_SPDTXCHAN0                    0x1E
@@ -236,12 +241,17 @@ static const char *wm8580_supply_names[WM8580_NUM_SUPPLIES] = {
 	"PVDD",
 };
 
+struct wm8580_driver_data {
+	int num_dacs;
+};
+
 /* codec private data */
 struct wm8580_priv {
 	struct regmap *regmap;
 	struct regulator_bulk_data supplies[WM8580_NUM_SUPPLIES];
 	struct pll_state a;
 	struct pll_state b;
+	const struct wm8580_driver_data *drvdata;
 	int sysclk[2];
 };
 
@@ -306,6 +316,19 @@ SOC_DOUBLE("Capture Switch", WM8580_ADC_CONTROL1, 0, 1, 1, 1),
 SOC_SINGLE("Capture High-Pass Filter Switch", WM8580_ADC_CONTROL1, 4, 1, 0),
 };
 
+static const struct snd_kcontrol_new wm8581_snd_controls[] = {
+SOC_DOUBLE_R_EXT_TLV("DAC4 Playback Volume",
+		     WM8580_DIGITAL_ATTENUATION_DACL4,
+		     WM8580_DIGITAL_ATTENUATION_DACR4,
+		     0, 0xff, 0, snd_soc_get_volsw, wm8580_out_vu, dac_tlv),
+
+SOC_SINGLE("DAC4 Deemphasis Switch", WM8580_DAC_CONTROL3, 3, 1, 0),
+
+SOC_DOUBLE("DAC4 Invert Switch", WM8580_DAC_CONTROL4,  8, 7, 1, 0),
+
+SOC_SINGLE("DAC4 Switch", WM8580_DAC_CONTROL5, 3, 1, 1),
+};
+
 static const struct snd_soc_dapm_widget wm8580_dapm_widgets[] = {
 SND_SOC_DAPM_DAC("DAC1", "Playback", WM8580_PWRDN1, 2, 1),
 SND_SOC_DAPM_DAC("DAC2", "Playback", WM8580_PWRDN1, 3, 1),
@@ -324,6 +347,13 @@ SND_SOC_DAPM_INPUT("AINL"),
 SND_SOC_DAPM_INPUT("AINR"),
 };
 
+static const struct snd_soc_dapm_widget wm8581_dapm_widgets[] = {
+SND_SOC_DAPM_DAC("DAC4", "Playback", WM8580_PWRDN1, 5, 1),
+
+SND_SOC_DAPM_OUTPUT("VOUT4L"),
+SND_SOC_DAPM_OUTPUT("VOUT4R"),
+};
+
 static const struct snd_soc_dapm_route wm8580_dapm_routes[] = {
 	{ "VOUT1L", NULL, "DAC1" },
 	{ "VOUT1R", NULL, "DAC1" },
@@ -338,6 +368,11 @@ static const struct snd_soc_dapm_route wm8580_dapm_routes[] = {
 	{ "ADC", NULL, "AINR" },
 };
 
+static const struct snd_soc_dapm_route wm8581_dapm_routes[] = {
+	{ "VOUT4L", NULL, "DAC4" },
+	{ "VOUT4R", NULL, "DAC4" },
+};
+
 /* PLL divisors */
 struct _pll_div {
 	u32 prescale:1;
@@ -815,10 +850,21 @@ static int wm8580_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
+static int wm8580_playback_startup(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct wm8580_priv *wm8580 = snd_soc_codec_get_drvdata(codec);
+
+	return snd_pcm_hw_constraint_single(substream->runtime,
+		SNDRV_PCM_HW_PARAM_CHANNELS, wm8580->drvdata->num_dacs * 2);
+}
+
 #define WM8580_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
 static const struct snd_soc_dai_ops wm8580_dai_ops_playback = {
+	.startup	= wm8580_playback_startup,
 	.set_sysclk	= wm8580_set_sysclk,
 	.hw_params	= wm8580_paif_hw_params,
 	.set_fmt	= wm8580_set_paif_dai_fmt,
@@ -842,7 +888,6 @@ static struct snd_soc_dai_driver wm8580_dai[] = {
 		.playback = {
 			.stream_name = "Playback",
 			.channels_min = 1,
-			.channels_max = 6,
 			.rates = SNDRV_PCM_RATE_8000_192000,
 			.formats = WM8580_FORMATS,
 		},
@@ -865,8 +910,22 @@ static struct snd_soc_dai_driver wm8580_dai[] = {
 static int wm8580_probe(struct snd_soc_codec *codec)
 {
 	struct wm8580_priv *wm8580 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	int ret = 0;
 
+	switch (wm8580->drvdata->num_dacs) {
+	case 4:
+		snd_soc_add_codec_controls(codec, wm8581_snd_controls,
+					ARRAY_SIZE(wm8581_snd_controls));
+		snd_soc_dapm_new_controls(dapm, wm8581_dapm_widgets,
+					ARRAY_SIZE(wm8581_dapm_widgets));
+		snd_soc_dapm_add_routes(dapm, wm8581_dapm_routes,
+					ARRAY_SIZE(wm8581_dapm_routes));
+		break;
+	default:
+		break;
+	}
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm8580->supplies),
 				    wm8580->supplies);
 	if (ret != 0) {
@@ -914,12 +973,6 @@ static const struct snd_soc_codec_driver soc_codec_dev_wm8580 = {
 	},
 };
 
-static const struct of_device_id wm8580_of_match[] = {
-	{ .compatible = "wlf,wm8580" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, wm8580_of_match);
-
 static const struct regmap_config wm8580_regmap = {
 	.reg_bits = 7,
 	.val_bits = 9,
@@ -932,10 +985,26 @@ static const struct regmap_config wm8580_regmap = {
 	.volatile_reg = wm8580_volatile,
 };
 
+const struct wm8580_driver_data wm8580_data = {
+	.num_dacs = 3,
+};
+
+const struct wm8580_driver_data wm8581_data = {
+	.num_dacs = 4,
+};
+
+static const struct of_device_id wm8580_of_match[] = {
+	{ .compatible = "wlf,wm8580", .data = &wm8580_data },
+	{ .compatible = "wlf,wm8581", .data = &wm8581_data },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, wm8580_of_match);
+
 #if IS_ENABLED(CONFIG_I2C)
 static int wm8580_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
+	const struct of_device_id *of_id;
 	struct wm8580_priv *wm8580;
 	int ret, i;
 
@@ -960,6 +1029,15 @@ static int wm8580_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8580);
 
+	of_id = of_match_device(wm8580_of_match, &i2c->dev);
+	if (of_id)
+		wm8580->drvdata = of_id->data;
+
+	if (!wm8580->drvdata) {
+		dev_err(&i2c->dev, "failed to find driver data\n");
+		return -EINVAL;
+	}
+
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8580, wm8580_dai, ARRAY_SIZE(wm8580_dai));
 
@@ -973,7 +1051,8 @@ static int wm8580_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id wm8580_i2c_id[] = {
-	{ "wm8580", 0 },
+	{ "wm8580", (kernel_ulong_t)&wm8580_data },
+	{ "wm8581", (kernel_ulong_t)&wm8581_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, wm8580_i2c_id);
@@ -1014,4 +1093,5 @@ module_exit(wm8580_exit);
 
 MODULE_DESCRIPTION("ASoC WM8580 driver");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
+MODULE_AUTHOR("Matt Flax <flatmax@flatmax.org>");
 MODULE_LICENSE("GPL");
-- 
2.7.4
