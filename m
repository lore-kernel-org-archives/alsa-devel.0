From: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 2/3] ASoC: add es8328 codec driver
Date: Wed, 18 Jun 2014 11:47:20 +0800
Message-ID: <1403063242-20840-3-git-send-email-xobs@kosagi.com>
References: <1403063242-20840-1-git-send-email-xobs@kosagi.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1403063242-20840-1-git-send-email-xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org, Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add a codec driver for the Everest ES8328.  It supports two separate audio
outputs and two separate audio inputs.

Signed-off-by: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/es8328.txt |  18 +
 sound/soc/codecs/Kconfig                           |  13 +
 sound/soc/codecs/Makefile                          |   6 +
 sound/soc/codecs/es8328-i2c.c                      |  62 ++
 sound/soc/codecs/es8328-spi.c                      |  51 ++
 sound/soc/codecs/es8328.c                          | 625 +++++++++++++++++++++
 sound/soc/codecs/es8328.h                          | 313 +++++++++++
 7 files changed, 1088 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/es8328.txt
 create mode 100644 sound/soc/codecs/es8328-i2c.c
 create mode 100644 sound/soc/codecs/es8328-spi.c
 create mode 100644 sound/soc/codecs/es8328.c
 create mode 100644 sound/soc/codecs/es8328.h

diff --git a/Documentation/devicetree/bindings/sound/es8328.txt b/Documentation/devicetree/bindings/sound/es8328.txt
new file mode 100644
index 0000000..488bc32
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/es8328.txt
@@ -0,0 +1,18 @@
+Everest ES8328 audio CODEC
+
+This device supports both I2C and SPI (configured with pin strapping
+on the board).
+
+Required properties:
+
+  - compatible : "es8328"
+
+  - reg : the I2C address of the device for I2C, the chip select
+          number for SPI.
+
+Example:
+
+codec: es8328@11 {
+	compatible = "es8328";
+	reg = <0x11>;
+};
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index cbfa1e1..6a509e3 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -56,6 +56,8 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_DA732X if I2C
 	select SND_SOC_DA9055 if I2C
 	select SND_SOC_BT_SCO
+	select SND_SOC_ES8328_SPI if SPI_MASTER
+	select SND_SOC_ES8328_I2C if I2C
 	select SND_SOC_ISABELLE if I2C
 	select SND_SOC_JZ4740_CODEC
 	select SND_SOC_LM4857 if I2C
@@ -396,6 +398,17 @@ config SND_SOC_DMIC
 config SND_SOC_HDMI_CODEC
        tristate "HDMI stub CODEC"
 
+config SND_SOC_ES8328
+	tristate "Everest Semi ES8328 CODEC"
+
+config SND_SOC_ES8328_I2C
+	tristate
+	select SND_SOC_ES8328
+
+config SND_SOC_ES8328_SPI
+	tristate
+	select SND_SOC_ES8328
+
 config SND_SOC_ISABELLE
         tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index be3377b..66e7859 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -48,6 +48,9 @@ snd-soc-da732x-objs := da732x.o
 snd-soc-da9055-objs := da9055.o
 snd-soc-bt-sco-objs := bt-sco.o
 snd-soc-dmic-objs := dmic.o
+snd-soc-es8328-objs := es8328.o
+snd-soc-es8328-i2c-objs := es8328-i2c.o
+snd-soc-es8328-spi-objs := es8328-spi.o
 snd-soc-isabelle-objs := isabelle.o
 snd-soc-jz4740-codec-objs := jz4740.o
 snd-soc-l3-objs := l3.o
@@ -213,6 +216,9 @@ obj-$(CONFIG_SND_SOC_DA732X)	+= snd-soc-da732x.o
 obj-$(CONFIG_SND_SOC_DA9055)	+= snd-soc-da9055.o
 obj-$(CONFIG_SND_SOC_BT_SCO)	+= snd-soc-bt-sco.o
 obj-$(CONFIG_SND_SOC_DMIC)	+= snd-soc-dmic.o
+obj-$(CONFIG_SND_SOC_ES8328)	+= snd-soc-es8328.o
+obj-$(CONFIG_SND_SOC_ES8328_I2C)+= snd-soc-es8328-i2c.o
+obj-$(CONFIG_SND_SOC_ES8328_SPI)+= snd-soc-es8328-spi.o
 obj-$(CONFIG_SND_SOC_ISABELLE)	+= snd-soc-isabelle.o
 obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
diff --git a/sound/soc/codecs/es8328-i2c.c b/sound/soc/codecs/es8328-i2c.c
new file mode 100644
index 0000000..16f670f
--- /dev/null
+++ b/sound/soc/codecs/es8328-i2c.c
@@ -0,0 +1,62 @@
+/*
+ * es8328-i2c.c  --  ES8328 ALSA SoC I2C Audio driver
+ *
+ * Copyright 2014 Sutajio Ko-Usagi PTE LTD
+ *
+ * Author: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+
+#include <sound/soc.h>
+
+#include "es8328.h"
+
+static const struct i2c_device_id es8328_id[] = {
+	{ "everest,es8328", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, es8328_id);
+
+static const struct of_device_id es8328_of_match[] = {
+	{ .compatible = "everest,es8328", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, es8328_of_match);
+
+static int es8328_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	struct regmap_config config;
+
+	config = es8328_regmap_config;
+	return es8328_probe(&i2c->dev, devm_regmap_init_i2c(i2c, &config));
+}
+
+static int es8328_i2c_remove(struct i2c_client *i2c)
+{
+	snd_soc_unregister_codec(&i2c->dev);
+	return 0;
+}
+
+static struct i2c_driver es8328_i2c_driver = {
+	.driver = {
+		.name		= "es8328",
+		.of_match_table = es8328_of_match,
+	},
+	.probe    = es8328_i2c_probe,
+	.remove   = es8328_i2c_remove,
+	.id_table = es8328_id,
+};
+
+module_i2c_driver(es8328_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC ES8328 audio CODEC I2C driver");
+MODULE_AUTHOR("Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/es8328-spi.c b/sound/soc/codecs/es8328-spi.c
new file mode 100644
index 0000000..b31efa4
--- /dev/null
+++ b/sound/soc/codecs/es8328-spi.c
@@ -0,0 +1,51 @@
+/*
+ * es8328.c  --  ES8328 ALSA SoC SPI Audio driver
+ *
+ * Copyright 2014 Sutajio Ko-Usagi PTE LTD
+ *
+ * Author: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <sound/soc.h>
+#include "es8328.h"
+
+static const struct of_device_id es8328_of_match[] = {
+	{ .compatible = "everest,es8328", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, es8328_of_match);
+
+static int es8328_spi_probe(struct spi_device *spi)
+{
+	struct regmap_config config;
+
+	config = es8328_regmap_config;
+	return es8328_probe(&spi->dev, devm_regmap_init_spi(spi, &config));
+}
+
+static int es8328_spi_remove(struct spi_device *spi)
+{
+	snd_soc_unregister_codec(&spi->dev);
+	return 0;
+}
+
+static struct spi_driver es8328_spi_driver = {
+	.driver = {
+		.name		= "es8328",
+		.of_match_table	= es8328_of_match,
+	},
+	.probe	= es8328_spi_probe,
+	.remove	= es8328_spi_remove,
+};
+
+module_spi_driver(es8328_spi_driver);
+MODULE_DESCRIPTION("ASoC ES8328 audio CODEC SPI driver");
+MODULE_AUTHOR("Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
new file mode 100644
index 0000000..4cadb4f
--- /dev/null
+++ b/sound/soc/codecs/es8328.c
@@ -0,0 +1,625 @@
+/*
+ * es8328.c  --  ES8328 ALSA SoC Audio driver
+ *
+ * Copyright 2014 Sutajio Ko-Usagi PTE LTD
+ *
+ * Author: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/of_device.h>
+#include <linux/regulator/consumer.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+#include "es8328.h"
+
+/* Run the codec at 22.5792 MHz to support these rates */
+enum es8328_rate {
+	ES8328_RATE_8019,
+	ES8328_RATE_11025,
+	ES8328_RATE_22050,
+	ES8328_RATE_44100,
+};
+
+uint8_t es8328_sample_ratios[] = {
+	[ES8328_RATE_8019]  = 0x9,
+	[ES8328_RATE_11025] = 0x7,
+	[ES8328_RATE_22050] = 0x4,
+	[ES8328_RATE_44100] = 0x2,
+};
+
+#define ES8328_RATES (SNDRV_PCM_RATE_44100 | \
+		SNDRV_PCM_RATE_22050 | \
+		SNDRV_PCM_RATE_11025)
+#define ES8328_FORMATS (SNDRV_PCM_FMTBIT_S16_LE)
+
+/* codec private data */
+struct es8328_priv {
+	struct regmap *regmap;
+	int sysclk;
+	int playback_fs;
+	bool deemph;
+};
+
+/*
+ * ES8328 Controls
+ */
+
+static const char * const adcpol_txt[] = {"Normal", "L Invert", "R Invert",
+					  "L + R Invert"};
+static SOC_ENUM_SINGLE_DECL(adcpol,
+			    ES8328_ADCCONTROL6, 6, adcpol_txt);
+
+static const DECLARE_TLV_DB_SCALE(play_tlv, -3000, 100, 0);
+static const DECLARE_TLV_DB_SCALE(dac_adc_tlv, -9600, 50, 0);
+static const DECLARE_TLV_DB_SCALE(pga_tlv, 0, 300, 0);
+static const DECLARE_TLV_DB_SCALE(bypass_tlv, -1500, 300, 0);
+static const DECLARE_TLV_DB_SCALE(mic_tlv, 0, 300, 0);
+
+static const int deemph_settings[] = { 0, 32000, 44100, 48000 };
+
+static int es8328_set_deemph(struct snd_soc_codec *codec)
+{
+	struct es8328_priv *es8328 = snd_soc_codec_get_drvdata(codec);
+	int val, i, best;
+
+	/*
+	 * If we're using deemphasis select the nearest available sample
+	 * rate.
+	 */
+	if (es8328->deemph) {
+		best = 1;
+		for (i = 2; i < ARRAY_SIZE(deemph_settings); i++) {
+			if (abs(deemph_settings[i] - es8328->playback_fs) <
+			    abs(deemph_settings[best] - es8328->playback_fs))
+				best = i;
+		}
+
+		val = best << 1;
+	} else {
+		val = 0;
+	}
+
+	dev_dbg(codec->dev, "Set deemphasis %d\n", val);
+
+	return snd_soc_update_bits(codec, ES8328_DACCONTROL6, 0x6, val);
+}
+
+static int es8328_get_deemph(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct es8328_priv *es8328 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.enumerated.item[0] = es8328->deemph;
+	return 0;
+}
+
+static int es8328_put_deemph(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct es8328_priv *es8328 = snd_soc_codec_get_drvdata(codec);
+	int deemph = ucontrol->value.enumerated.item[0];
+
+	if (deemph > 1)
+		return -EINVAL;
+
+	es8328->deemph = deemph;
+
+	return es8328_set_deemph(codec);
+}
+
+
+
+static const struct snd_kcontrol_new es8328_snd_controls[] = {
+	SOC_DOUBLE_R_TLV("Capture Digital Volume",
+		ES8328_ADCCONTROL8, ES8328_ADCCONTROL9,
+		 0, 0xc0, 0, dac_adc_tlv),
+	SOC_SINGLE("Capture ZC Switch", ES8328_ADCCONTROL7, 6, 1, 0),
+
+	SOC_SINGLE_BOOL_EXT("DAC Deemphasis Switch", 0,
+		    es8328_get_deemph, es8328_put_deemph),
+
+	SOC_ENUM("Capture Polarity", adcpol),
+
+	SOC_SINGLE_TLV("Left Mixer Left Bypass Volume",
+			ES8328_DACCONTROL17, 3, 7, 1, bypass_tlv),
+	SOC_SINGLE_TLV("Left Mixer Right Bypass Volume",
+			ES8328_DACCONTROL19, 3, 7, 1, bypass_tlv),
+	SOC_SINGLE_TLV("Right Mixer Left Bypass Volume",
+			ES8328_DACCONTROL18, 3, 7, 1, bypass_tlv),
+	SOC_SINGLE_TLV("Right Mixer Right Bypass Volume",
+			ES8328_DACCONTROL20, 3, 7, 1, bypass_tlv),
+
+	SOC_DOUBLE_R_TLV("PCM Volume",
+			ES8328_LDACVOL, ES8328_RDACVOL,
+			0, ES8328_DACVOL_MAX, 1, dac_adc_tlv),
+
+	SOC_DOUBLE_R_TLV("Output 1 Playback Volume",
+			ES8328_LOUT1VOL, ES8328_ROUT1VOL,
+			0, ES8328_OUT1VOL_MAX, 0, play_tlv),
+
+	SOC_DOUBLE_R_TLV("Output 2 Playback Volume",
+			ES8328_LOUT2VOL, ES8328_ROUT2VOL,
+			0, ES8328_OUT2VOL_MAX, 0, play_tlv),
+
+	SOC_DOUBLE_TLV("Mic PGA Gain", ES8328_ADCCONTROL1, 4, 0, 8, 0, mic_tlv),
+};
+
+/*
+ * DAPM Controls
+ */
+
+static const char * const es8328_line_texts[] = {
+	"Line 1", "Line 2", "PGA", "Differential"};
+
+static const struct soc_enum es8328_lline_enum =
+	SOC_ENUM_SINGLE(ES8328_DACCONTROL16, 3,
+			      ARRAY_SIZE(es8328_line_texts),
+			      es8328_line_texts);
+static const struct snd_kcontrol_new es8328_left_line_controls =
+	SOC_DAPM_ENUM("Route", es8328_lline_enum);
+
+static const struct soc_enum es8328_rline_enum =
+	SOC_ENUM_SINGLE(ES8328_DACCONTROL16, 0,
+			      ARRAY_SIZE(es8328_line_texts),
+			      es8328_line_texts);
+static const struct snd_kcontrol_new es8328_right_line_controls =
+	SOC_DAPM_ENUM("Route", es8328_lline_enum);
+
+/* Left Mixer */
+static const struct snd_kcontrol_new es8328_left_mixer_controls[] = {
+	SOC_DAPM_SINGLE("Playback Switch", ES8328_DACCONTROL17, 8, 1, 0),
+	SOC_DAPM_SINGLE("Left Bypass Switch", ES8328_DACCONTROL17, 7, 1, 0),
+	SOC_DAPM_SINGLE("Right Playback Switch", ES8328_DACCONTROL18, 8, 1, 0),
+	SOC_DAPM_SINGLE("Right Bypass Switch", ES8328_DACCONTROL18, 7, 1, 0),
+};
+
+/* Right Mixer */
+static const struct snd_kcontrol_new es8328_right_mixer_controls[] = {
+	SOC_DAPM_SINGLE("Left Playback Switch", ES8328_DACCONTROL19, 8, 1, 0),
+	SOC_DAPM_SINGLE("Left Bypass Switch", ES8328_DACCONTROL19, 7, 1, 0),
+	SOC_DAPM_SINGLE("Playback Switch", ES8328_DACCONTROL20, 8, 1, 0),
+	SOC_DAPM_SINGLE("Right Bypass Switch", ES8328_DACCONTROL20, 7, 1, 0),
+};
+
+static const char * const es8328_pga_sel[] = {
+	"Line 1", "Line 2", "Line 3", "Differential"};
+
+/* Left PGA Mux */
+static const struct soc_enum es8328_lpga_enum =
+	SOC_ENUM_SINGLE(ES8328_ADCCONTROL2, 6,
+			      ARRAY_SIZE(es8328_pga_sel),
+			      es8328_pga_sel);
+static const struct snd_kcontrol_new es8328_left_pga_controls =
+	SOC_DAPM_ENUM("Route", es8328_lpga_enum);
+
+/* Right PGA Mux */
+static const struct soc_enum es8328_rpga_enum =
+	SOC_ENUM_SINGLE(ES8328_ADCCONTROL2, 4,
+			      ARRAY_SIZE(es8328_pga_sel),
+			      es8328_pga_sel);
+static const struct snd_kcontrol_new es8328_right_pga_controls =
+	SOC_DAPM_ENUM("Route", es8328_rpga_enum);
+
+/* Differential Mux */
+static const char * const es8328_diff_sel[] = {"Line 1", "Line 2"};
+static SOC_ENUM_SINGLE_DECL(diffmux,
+			    ES8328_ADCCONTROL3, 7, es8328_diff_sel);
+static const struct snd_kcontrol_new es8328_diffmux_controls =
+	SOC_DAPM_ENUM("Route", diffmux);
+
+/* Mono ADC Mux */
+static const char * const es8328_mono_mux[] = {"Stereo", "Mono (Left)",
+	"Mono (Right)", "Digital Mono"};
+static SOC_ENUM_SINGLE_DECL(monomux,
+			    ES8328_ADCCONTROL3, 3, es8328_mono_mux);
+static const struct snd_kcontrol_new es8328_monomux_controls =
+	SOC_DAPM_ENUM("Route", monomux);
+
+static const struct snd_soc_dapm_widget es8328_dapm_widgets[] = {
+	SND_SOC_DAPM_MUX("Differential Mux", SND_SOC_NOPM, 0, 0,
+		&es8328_diffmux_controls),
+	SND_SOC_DAPM_MUX("Left ADC Mux", SND_SOC_NOPM, 0, 0,
+		&es8328_monomux_controls),
+	SND_SOC_DAPM_MUX("Right ADC Mux", SND_SOC_NOPM, 0, 0,
+		&es8328_monomux_controls),
+
+	SND_SOC_DAPM_MUX("Left PGA Mux", ES8328_ADCPOWER,
+			ES8328_ADCPOWER_AINL_OFF, 1,
+			&es8328_left_pga_controls),
+	SND_SOC_DAPM_MUX("Right PGA Mux", ES8328_ADCPOWER,
+			ES8328_ADCPOWER_AINR_OFF, 1,
+			&es8328_right_pga_controls),
+
+	SND_SOC_DAPM_MUX("Left Line Mux", SND_SOC_NOPM, 0, 0,
+		&es8328_left_line_controls),
+	SND_SOC_DAPM_MUX("Right Line Mux", SND_SOC_NOPM, 0, 0,
+		&es8328_right_line_controls),
+
+	SND_SOC_DAPM_ADC("Right ADC", "Right Capture", ES8328_ADCPOWER,
+			ES8328_ADCPOWER_ADCR_OFF, 1),
+	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", ES8328_ADCPOWER,
+			ES8328_ADCPOWER_ADCL_OFF, 1),
+
+	SND_SOC_DAPM_MICBIAS("Mic Bias", ES8328_ADCPOWER,
+			ES8328_ADCPOWER_MIC_BIAS_OFF, 1),
+	SND_SOC_DAPM_SUPPLY("Mic Bias Gen", ES8328_ADCPOWER,
+			ES8328_ADCPOWER_ADC_BIAS_GEN_OFF, 1, NULL, 0),
+
+	SND_SOC_DAPM_DAC("Right DAC", "Right Playback", ES8328_DACPOWER,
+			ES8328_DACPOWER_RDAC_OFF, 1),
+	SND_SOC_DAPM_DAC("Left DAC", "Left Playback", ES8328_DACPOWER,
+			ES8328_DACPOWER_LDAC_OFF, 1),
+
+	SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
+		&es8328_left_mixer_controls[0],
+		ARRAY_SIZE(es8328_left_mixer_controls)),
+	SND_SOC_DAPM_MIXER("Right Mixer", SND_SOC_NOPM, 0, 0,
+		&es8328_right_mixer_controls[0],
+		ARRAY_SIZE(es8328_right_mixer_controls)),
+
+	SND_SOC_DAPM_PGA("Right Out 2", ES8328_DACPOWER,
+			ES8328_DACPOWER_ROUT2_ON, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Left Out 2", ES8328_DACPOWER,
+			ES8328_DACPOWER_LOUT2_ON, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Right Out 1", ES8328_DACPOWER,
+			ES8328_DACPOWER_ROUT1_ON, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Left Out 1", ES8328_DACPOWER,
+			ES8328_DACPOWER_LOUT1_ON, 0, NULL, 0),
+
+	SND_SOC_DAPM_OUTPUT("LOUT1"),
+	SND_SOC_DAPM_OUTPUT("ROUT1"),
+	SND_SOC_DAPM_OUTPUT("LOUT2"),
+	SND_SOC_DAPM_OUTPUT("ROUT2"),
+	SND_SOC_DAPM_OUTPUT("VREF"),
+
+	SND_SOC_DAPM_INPUT("LINPUT1"),
+	SND_SOC_DAPM_INPUT("LINPUT2"),
+	SND_SOC_DAPM_INPUT("RINPUT1"),
+	SND_SOC_DAPM_INPUT("RINPUT2"),
+};
+
+static const struct snd_soc_dapm_route es8328_dapm_routes[] = {
+
+	{ "Left Line Mux", "Line 1", "LINPUT1" },
+	{ "Left Line Mux", "Line 2", "LINPUT2" },
+	{ "Left Line Mux", "PGA", "Left PGA Mux" },
+	{ "Left Line Mux", "Differential", "Differential Mux" },
+
+	{ "Right Line Mux", "Line 1", "RINPUT1" },
+	{ "Right Line Mux", "Line 2", "RINPUT2" },
+	{ "Right Line Mux", "PGA", "Right PGA Mux" },
+	{ "Right Line Mux", "Differential", "Differential Mux" },
+
+	{ "Left PGA Mux", "Line 1", "LINPUT1" },
+	{ "Left PGA Mux", "Line 2", "LINPUT2" },
+	{ "Left PGA Mux", "Differential", "Differential Mux" },
+
+	{ "Right PGA Mux", "Line 1", "RINPUT1" },
+	{ "Right PGA Mux", "Line 2", "RINPUT2" },
+	{ "Right PGA Mux", "Differential", "Differential Mux" },
+
+	{ "Differential Mux", "Line 1", "LINPUT1" },
+	{ "Differential Mux", "Line 1", "RINPUT1" },
+	{ "Differential Mux", "Line 2", "LINPUT2" },
+	{ "Differential Mux", "Line 2", "RINPUT2" },
+
+	{ "Left ADC Mux", "Stereo", "Left PGA Mux" },
+	{ "Left ADC Mux", "Mono (Left)", "Left PGA Mux" },
+	{ "Left ADC Mux", "Digital Mono", "Left PGA Mux" },
+
+	{ "Right ADC Mux", "Stereo", "Right PGA Mux" },
+	{ "Right ADC Mux", "Mono (Right)", "Right PGA Mux" },
+	{ "Right ADC Mux", "Digital Mono", "Right PGA Mux" },
+
+	{ "Left ADC", NULL, "Left ADC Mux" },
+	{ "Right ADC", NULL, "Right ADC Mux" },
+
+	{ "Left Line Mux", "Line 1", "LINPUT1" },
+	{ "Left Line Mux", "Line 2", "LINPUT2" },
+	{ "Left Line Mux", "PGA", "Left PGA Mux" },
+	{ "Left Line Mux", "Differential", "Differential Mux" },
+
+	{ "Right Line Mux", "Line 1", "RINPUT1" },
+	{ "Right Line Mux", "Line 2", "RINPUT2" },
+	{ "Right Line Mux", "PGA", "Right PGA Mux" },
+	{ "Right Line Mux", "Differential", "Differential Mux" },
+
+	{ "Left Out 1", NULL, "Left DAC" },
+	{ "Right Out 1", NULL, "Right DAC" },
+	{ "Left Out 2", NULL, "Left DAC" },
+	{ "Right Out 2", NULL, "Right DAC" },
+
+	{ "Left Mixer", "Playback Switch", "Left DAC" },
+	{ "Left Mixer", "Left Bypass Switch", "Left Line Mux" },
+	{ "Left Mixer", "Right Playback Switch", "Right DAC" },
+	{ "Left Mixer", "Right Bypass Switch", "Right Line Mux" },
+
+	{ "Right Mixer", "Left Playback Switch", "Left DAC" },
+	{ "Right Mixer", "Left Bypass Switch", "Left Line Mux" },
+	{ "Right Mixer", "Playback Switch", "Right DAC" },
+	{ "Right Mixer", "Right Bypass Switch", "Right Line Mux" },
+
+	{ "Left Out 1", NULL, "Left Mixer" },
+	{ "LOUT1", NULL, "Left Out 1" },
+	{ "Right Out 1", NULL, "Right Mixer" },
+	{ "ROUT1", NULL, "Right Out 1" },
+
+	{ "Left Out 2", NULL, "Left Mixer" },
+	{ "LOUT2", NULL, "Left Out 2" },
+	{ "Right Out 2", NULL, "Right Mixer" },
+	{ "ROUT2", NULL, "Right Out 2" },
+};
+
+static int es8328_mute(struct snd_soc_dai *dai, int mute)
+{
+	return snd_soc_update_bits(dai->codec, ES8328_DACCONTROL3,
+			ES8328_DACCONTROL3_DACMUTE,
+			mute ? ES8328_DACCONTROL3_DACMUTE : 0);
+}
+
+static int es8328_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params,
+	struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct es8328_priv *es8328 = snd_soc_codec_get_drvdata(codec);
+	int reg;
+	u8 val;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		reg = ES8328_DACCONTROL2;
+
+	else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		reg = ES8328_ADCCONTROL5;
+	else
+		return -EINVAL;
+
+	switch (params_rate(params)) {
+	case 8000:
+		val = es8328_sample_ratios[ES8328_RATE_8019];
+		break;
+	case 11025:
+		val = es8328_sample_ratios[ES8328_RATE_11025];
+		break;
+	case 22050:
+		val = es8328_sample_ratios[ES8328_RATE_22050];
+		break;
+	case 44100:
+		val = es8328_sample_ratios[ES8328_RATE_44100];
+		break;
+	default:
+		dev_err(codec->dev, "%s: unknown rate %d\n",
+			 __func__, params_rate(params));
+		return -EINVAL;
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		es8328->playback_fs = params_rate(params);
+		es8328_set_deemph(codec);
+	}
+
+	return snd_soc_update_bits(codec, reg, ES8328_RATEMASK, val);
+}
+
+static int es8328_set_dai_fmt(struct snd_soc_dai *codec_dai,
+		unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	u8 mode = ES8328_DACCONTROL1_DACWL_16;
+
+	/* set master/slave audio interface */
+	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBM_CFM)
+		return -EINVAL;
+
+	/* interface format */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		mode |= ES8328_DACCONTROL1_DACFORMAT_I2S;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		mode |= ES8328_DACCONTROL1_DACFORMAT_RJUST;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		mode |= ES8328_DACCONTROL1_DACFORMAT_LJUST;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* clock inversion */
+	if ((fmt & SND_SOC_DAIFMT_INV_MASK) != SND_SOC_DAIFMT_NB_NF)
+		return -EINVAL;
+
+	snd_soc_write(codec, ES8328_DACCONTROL1, mode);
+	snd_soc_write(codec, ES8328_ADCCONTROL4, mode);
+
+	/* Master serial port mode */
+	snd_soc_write(codec, ES8328_MASTERMODE,
+			ES8328_MASTERMODE_MCLKDIV2 |
+			ES8328_MASTERMODE_MSC);
+	return 0;
+}
+
+static int es8328_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+				 int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct es8328_priv *es8328 = snd_soc_codec_get_drvdata(codec);
+
+	switch (clk_id) {
+	case 0:
+		es8328->sysclk = freq;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int es8328_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
+{
+	u8 cc1_reg = snd_soc_read(codec, ES8328_CONTROL1) & ~0x07;
+	u8 pwr_reg = 0;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		break;
+
+	case SND_SOC_BIAS_PREPARE:
+		/* VREF, VMID=2x50k, digital enabled */
+		snd_soc_write(codec, ES8328_CHIPPOWER, pwr_reg);
+		snd_soc_write(codec, ES8328_CONTROL1,
+				cc1_reg |
+				ES8328_CONTROL1_VMIDSEL_50k |
+				ES8328_CONTROL1_ENREF);
+		break;
+
+	case SND_SOC_BIAS_STANDBY:
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
+			snd_soc_write(codec, ES8328_CONTROL1,
+					cc1_reg |
+					ES8328_CONTROL1_VMIDSEL_5k |
+					ES8328_CONTROL1_ENREF);
+
+			/* Charge caps */
+			msleep(100);
+		}
+
+		snd_soc_write(codec, ES8328_CONTROL2,
+				ES8328_CONTROL2_OVERCURRENT_ON |
+				ES8328_CONTROL2_THERMAL_SHUTDOWN_ON);
+
+		/* VREF, VMID=2*500k, digital stopped */
+		snd_soc_write(codec, ES8328_CONTROL1,
+				cc1_reg |
+				ES8328_CONTROL1_VMIDSEL_500k |
+				ES8328_CONTROL1_ENREF);
+		snd_soc_write(codec, ES8328_CHIPPOWER,
+				pwr_reg |
+				ES8328_CHIPPOWER_DACDIG_OFF |
+				ES8328_CHIPPOWER_ADCDIG_OFF |
+				ES8328_CHIPPOWER_ADCVREF_OFF |
+				ES8328_CHIPPOWER_DACVREF_OFF);
+		break;
+
+	case SND_SOC_BIAS_OFF:
+		snd_soc_write(codec, ES8328_CONTROL1, cc1_reg);
+		snd_soc_write(codec, ES8328_CHIPPOWER,
+				ES8328_CHIPPOWER_ADCDIG_OFF |
+				ES8328_CHIPPOWER_DACDIG_OFF |
+				ES8328_CHIPPOWER_ADCSTM_RESET |
+				ES8328_CHIPPOWER_DACSTM_RESET |
+				ES8328_CHIPPOWER_ADCPLL_OFF |
+				ES8328_CHIPPOWER_DACPLL_OFF |
+				ES8328_CHIPPOWER_ADCVREF_OFF |
+				ES8328_CHIPPOWER_DACVREF_OFF);
+		break;
+	}
+	codec->dapm.bias_level = level;
+	return 0;
+}
+
+static const struct snd_soc_dai_ops es8328_dai_ops = {
+	.hw_params	= es8328_hw_params,
+	.digital_mute	= es8328_mute,
+	.set_fmt	= es8328_set_dai_fmt,
+	.set_sysclk	= es8328_set_dai_sysclk,
+};
+
+static struct snd_soc_dai_driver es8328_dai = {
+	.name = "es8328-hifi-analog",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = ES8328_RATES,
+		.formats = ES8328_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = ES8328_RATES,
+		.formats = ES8328_FORMATS,
+	},
+	.ops = &es8328_dai_ops,
+};
+
+static int es8328_suspend(struct snd_soc_codec *codec)
+{
+	es8328_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
+}
+
+static int es8328_resume(struct snd_soc_codec *codec)
+{
+	es8328_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	return 0;
+}
+
+static int es8328_codec_probe(struct snd_soc_codec *codec)
+{
+	return 0;
+}
+
+const struct regmap_config es8328_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = ES8328_REG_MAX,
+	.cache_type = REGCACHE_NONE,
+};
+EXPORT_SYMBOL_GPL(es8328_regmap_config);
+
+static struct snd_soc_codec_driver es8328_codec_driver = {
+	.probe =		es8328_codec_probe,
+	.suspend =		es8328_suspend,
+	.resume =		es8328_resume,
+	.set_bias_level =	es8328_set_bias_level,
+	.controls =		es8328_snd_controls,
+	.num_controls =		ARRAY_SIZE(es8328_snd_controls),
+	.dapm_widgets =		es8328_dapm_widgets,
+	.num_dapm_widgets =	ARRAY_SIZE(es8328_dapm_widgets),
+	.dapm_routes =		es8328_dapm_routes,
+	.num_dapm_routes =	ARRAY_SIZE(es8328_dapm_routes),
+};
+
+int es8328_probe(struct device *dev, struct regmap *regmap)
+{
+	struct es8328_priv *es8328;
+
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	es8328 = devm_kzalloc(dev, sizeof(*es8328), GFP_KERNEL);
+	if (es8328 == NULL)
+		return -ENOMEM;
+
+	es8328->regmap = regmap;
+
+	dev_set_drvdata(dev, es8328);
+
+	return snd_soc_register_codec(dev,
+			&es8328_codec_driver, &es8328_dai, 1);
+}
+EXPORT_SYMBOL_GPL(es8328_probe);
+
+MODULE_DESCRIPTION("ASoC ES8328 driver");
+MODULE_AUTHOR("Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/es8328.h b/sound/soc/codecs/es8328.h
new file mode 100644
index 0000000..f944912
--- /dev/null
+++ b/sound/soc/codecs/es8328.h
@@ -0,0 +1,313 @@
+/*
+ * es8328.h  --  ES8328 ALSA SoC Audio driver
+ */
+
+#ifndef _ES8328_H
+#define _ES8328_H
+
+#include <linux/regmap.h>
+
+struct device;
+
+extern const struct regmap_config es8328_regmap_config;
+int es8328_probe(struct device *dev, struct regmap *regmap);
+
+#define ES8328_DACLVOL 46
+#define ES8328_DACRVOL 47
+#define ES8328_DACCTL 28
+#define ES8328_RATEMASK (0x1f << 0)
+
+#define ES8328_CONTROL1		0x00
+#define ES8328_CONTROL1_VMIDSEL_OFF (0 << 0)
+#define ES8328_CONTROL1_VMIDSEL_50k (1 << 0)
+#define ES8328_CONTROL1_VMIDSEL_500k (2 << 0)
+#define ES8328_CONTROL1_VMIDSEL_5k (3 << 0)
+#define ES8328_CONTROL1_ENREF (1 << 2)
+#define ES8328_CONTROL1_SEQEN (1 << 3)
+#define ES8328_CONTROL1_SAMEFS (1 << 4)
+#define ES8328_CONTROL1_DACMCLK_ADC (0 << 5)
+#define ES8328_CONTROL1_DACMCLK_DAC (1 << 5)
+#define ES8328_CONTROL1_LRCM (1 << 6)
+#define ES8328_CONTROL1_SCP_RESET (1 << 7)
+
+#define ES8328_CONTROL2		0x01
+#define ES8328_CONTROL2_VREF_BUF_OFF (1 << 0)
+#define ES8328_CONTROL2_VREF_LOWPOWER (1 << 1)
+#define ES8328_CONTROL2_IBIASGEN_OFF (1 << 2)
+#define ES8328_CONTROL2_ANALOG_OFF (1 << 3)
+#define ES8328_CONTROL2_VREF_BUF_LOWPOWER (1 << 4)
+#define ES8328_CONTROL2_VCM_MOD_LOWPOWER (1 << 5)
+#define ES8328_CONTROL2_OVERCURRENT_ON (1 << 6)
+#define ES8328_CONTROL2_THERMAL_SHUTDOWN_ON (1 << 7)
+
+#define ES8328_CHIPPOWER	0x02
+#define ES8328_CHIPPOWER_DACVREF_OFF (1 << 0)
+#define ES8328_CHIPPOWER_ADCVREF_OFF (1 << 1)
+#define ES8328_CHIPPOWER_DACPLL_OFF (1 << 2)
+#define ES8328_CHIPPOWER_ADCPLL_OFF (1 << 3)
+#define ES8328_CHIPPOWER_DACSTM_RESET (1 << 4)
+#define ES8328_CHIPPOWER_ADCSTM_RESET (1 << 5)
+#define ES8328_CHIPPOWER_DACDIG_OFF (1 << 6)
+#define ES8328_CHIPPOWER_ADCDIG_OFF (1 << 7)
+
+#define ES8328_ADCPOWER		0x03
+#define ES8328_ADCPOWER_INT1_LOWPOWER 0
+#define ES8328_ADCPOWER_FLASH_ADC_LOWPOWER 1
+#define ES8328_ADCPOWER_ADC_BIAS_GEN_OFF 2
+#define ES8328_ADCPOWER_MIC_BIAS_OFF 3
+#define ES8328_ADCPOWER_ADCR_OFF 4
+#define ES8328_ADCPOWER_ADCL_OFF 5
+#define ES8328_ADCPOWER_AINR_OFF 6
+#define ES8328_ADCPOWER_AINL_OFF 7
+
+#define ES8328_DACPOWER		0x04
+#define ES8328_DACPOWER_OUT3_ON 0
+#define ES8328_DACPOWER_MONO_ON 1
+#define ES8328_DACPOWER_ROUT2_ON 2
+#define ES8328_DACPOWER_LOUT2_ON 3
+#define ES8328_DACPOWER_ROUT1_ON 4
+#define ES8328_DACPOWER_LOUT1_ON 5
+#define ES8328_DACPOWER_RDAC_OFF 6
+#define ES8328_DACPOWER_LDAC_OFF 7
+
+#define ES8328_CHIPLOPOW1	0x05
+#define ES8328_CHIPLOPOW2	0x06
+#define ES8328_ANAVOLMANAG	0x07
+
+#define ES8328_MASTERMODE	0x08
+#define ES8328_MASTERMODE_BCLKDIV (0 << 0)
+#define ES8328_MASTERMODE_BCLK_INV (1 << 5)
+#define ES8328_MASTERMODE_MCLKDIV2 (1 << 6)
+#define ES8328_MASTERMODE_MSC (1 << 7)
+
+#define ES8328_ADCCONTROL1	0x09
+#define ES8328_ADCCONTROL2	0x0a
+#define ES8328_ADCCONTROL3	0x0b
+#define ES8328_ADCCONTROL4	0x0c
+#define ES8328_ADCCONTROL5	0x0d
+#define ES8328_ADCCONTROL5_RATEMASK (0x1f << 0)
+
+#define ES8328_ADCCONTROL6	0x0e
+
+#define ES8328_ADCCONTROL7	0x0f
+#define ES8328_ADCCONTROL7_ADC_MUTE (1 << 2)
+#define ES8328_ADCCONTROL7_ADC_LER (1 << 3)
+#define ES8328_ADCCONTROL7_ADC_ZERO_CROSS (1 << 4)
+#define ES8328_ADCCONTROL7_ADC_SOFT_RAMP (1 << 5)
+#define ES8328_ADCCONTROL7_ADC_RAMP_RATE_4 (0 << 6)
+#define ES8328_ADCCONTROL7_ADC_RAMP_RATE_8 (1 << 6)
+#define ES8328_ADCCONTROL7_ADC_RAMP_RATE_16 (2 << 6)
+#define ES8328_ADCCONTROL7_ADC_RAMP_RATE_32 (3 << 6)
+
+#define ES8328_ADCCONTROL8	0x10
+#define ES8328_ADCCONTROL9	0x11
+#define ES8328_ADCCONTROL10	0x12
+#define ES8328_ADCCONTROL11	0x13
+#define ES8328_ADCCONTROL12	0x14
+#define ES8328_ADCCONTROL13	0x15
+#define ES8328_ADCCONTROL14	0x16
+
+#define ES8328_DACCONTROL1	0x17
+#define ES8328_DACCONTROL1_DACFORMAT_I2S (0 << 1)
+#define ES8328_DACCONTROL1_DACFORMAT_LJUST (1 << 1)
+#define ES8328_DACCONTROL1_DACFORMAT_RJUST (2 << 1)
+#define ES8328_DACCONTROL1_DACFORMAT_PCM (3 << 1)
+#define ES8328_DACCONTROL1_DACWL_24 (0 << 3)
+#define ES8328_DACCONTROL1_DACWL_20 (1 << 3)
+#define ES8328_DACCONTROL1_DACWL_18 (2 << 3)
+#define ES8328_DACCONTROL1_DACWL_16 (3 << 3)
+#define ES8328_DACCONTROL1_DACWL_32 (4 << 3)
+#define ES8328_DACCONTROL1_DACLRP_I2S_POL_NORMAL (0 << 6)
+#define ES8328_DACCONTROL1_DACLRP_I2S_POL_INV (1 << 6)
+#define ES8328_DACCONTROL1_DACLRP_PCM_MSB_CLK2 (0 << 6)
+#define ES8328_DACCONTROL1_DACLRP_PCM_MSB_CLK1 (1 << 6)
+#define ES8328_DACCONTROL1_LRSWAP (1 << 7)
+
+#define ES8328_DACCONTROL2	0x18
+#define ES8328_DACCONTROL2_RATEMASK (0x1f << 0)
+#define ES8328_DACCONTROL2_DOUBLESPEED (1 << 5)
+
+#define ES8328_DACCONTROL3	0x19
+#define ES8328_DACCONTROL3_AUTOMUTE (1 << 2)
+#define ES8328_DACCONTROL3_DACMUTE (1 << 2)
+#define ES8328_DACCONTROL3_LEFTGAINVOL (1 << 3)
+#define ES8328_DACCONTROL3_DACZEROCROSS (1 << 4)
+#define ES8328_DACCONTROL3_DACSOFTRAMP (1 << 5)
+#define ES8328_DACCONTROL3_DACRAMPRATE (3 << 6)
+
+#define ES8328_LDACVOL 0x1a
+#define ES8328_LDACVOL_MASK (0 << 0)
+#define ES8328_LDACVOL_MAX (0xc0)
+
+#define ES8328_RDACVOL 0x1b
+#define ES8328_RDACVOL_MASK (0 << 0)
+#define ES8328_RDACVOL_MAX (0xc0)
+
+#define ES8328_DACVOL_MAX (0xc0)
+
+#define ES8328_DACCONTROL4	0x1a
+#define ES8328_DACCONTROL5	0x1b
+
+#define ES8328_DACCONTROL6	0x1c
+#define ES8328_DACCONTROL6_CLICKFREE (1 << 3)
+#define ES8328_DACCONTROL6_DAC_INVR (1 << 4)
+#define ES8328_DACCONTROL6_DAC_INVL (1 << 5)
+#define ES8328_DACCONTROL6_DEEMPH_OFF (0 << 6)
+#define ES8328_DACCONTROL6_DEEMPH_32k (1 << 6)
+#define ES8328_DACCONTROL6_DEEMPH_44_1k (2 << 6)
+#define ES8328_DACCONTROL6_DEEMPH_48k (3 << 6)
+
+#define ES8328_DACCONTROL7	0x1d
+#define ES8328_DACCONTROL7_VPP_SCALE_3p5	(0 << 0)
+#define ES8328_DACCONTROL7_VPP_SCALE_4p0	(1 << 0)
+#define ES8328_DACCONTROL7_VPP_SCALE_3p0	(2 << 0)
+#define ES8328_DACCONTROL7_VPP_SCALE_2p5	(3 << 0)
+#define ES8328_DACCONTROL7_SHELVING_STRENGTH (1 << 2) /* In eights */
+#define ES8328_DACCONTROL7_MONO		(1 << 5)
+#define ES8328_DACCONTROL7_ZEROR	(1 << 6)
+#define ES8328_DACCONTROL7_ZEROL	(1 << 7)
+
+/* Shelving filter */
+#define ES8328_DACCONTROL8	0x1e
+#define ES8328_DACCONTROL9	0x1f
+#define ES8328_DACCONTROL10	0x20
+#define ES8328_DACCONTROL11	0x21
+#define ES8328_DACCONTROL12	0x22
+#define ES8328_DACCONTROL13	0x23
+#define ES8328_DACCONTROL14	0x24
+#define ES8328_DACCONTROL15	0x25
+
+#define ES8328_DACCONTROL16	0x26
+#define ES8328_DACCONTROL16_RMIXSEL_RIN1 (0 << 0)
+#define ES8328_DACCONTROL16_RMIXSEL_RIN2 (1 << 0)
+#define ES8328_DACCONTROL16_RMIXSEL_RIN3 (2 << 0)
+#define ES8328_DACCONTROL16_RMIXSEL_RADC (3 << 0)
+#define ES8328_DACCONTROL16_LMIXSEL_LIN1 (0 << 3)
+#define ES8328_DACCONTROL16_LMIXSEL_LIN2 (1 << 3)
+#define ES8328_DACCONTROL16_LMIXSEL_LIN3 (2 << 3)
+#define ES8328_DACCONTROL16_LMIXSEL_LADC (3 << 3)
+
+#define ES8328_DACCONTROL17	0x27
+#define ES8328_DACCONTROL17_LI2LOVOL (7 << 3)
+#define ES8328_DACCONTROL17_LI2LO (1 << 6)
+#define ES8328_DACCONTROL17_LD2LO (1 << 7)
+
+#define ES8328_DACCONTROL18	0x28
+#define ES8328_DACCONTROL18_RI2LOVOL (7 << 3)
+#define ES8328_DACCONTROL18_RI2LO (1 << 6)
+#define ES8328_DACCONTROL18_RD2LO (1 << 7)
+
+#define ES8328_DACCONTROL19	0x29
+#define ES8328_DACCONTROL19_LI2ROVOL (7 << 3)
+#define ES8328_DACCONTROL19_LI2RO (1 << 6)
+#define ES8328_DACCONTROL19_LD2RO (1 << 7)
+
+#define ES8328_DACCONTROL20	0x2a
+#define ES8328_DACCONTROL20_RI2ROVOL (7 << 3)
+#define ES8328_DACCONTROL20_RI2RO (1 << 6)
+#define ES8328_DACCONTROL20_RD2RO (1 << 7)
+
+#define ES8328_DACCONTROL21	0x2b
+#define ES8328_DACCONTROL21_LI2MOVOL (7 << 3)
+#define ES8328_DACCONTROL21_LI2MO (1 << 6)
+#define ES8328_DACCONTROL21_LD2MO (1 << 7)
+
+#define ES8328_DACCONTROL22	0x2c
+#define ES8328_DACCONTROL22_RI2MOVOL (7 << 3)
+#define ES8328_DACCONTROL22_RI2MO (1 << 6)
+#define ES8328_DACCONTROL22_RD2MO (1 << 7)
+
+#define ES8328_DACCONTROL23	0x2d
+#define ES8328_DACCONTROL23_MOUTINV		(1 << 1)
+#define ES8328_DACCONTROL23_HPSWPOL		(1 << 2)
+#define ES8328_DACCONTROL23_HPSWEN		(1 << 3)
+#define ES8328_DACCONTROL23_VROI_1p5k		(0 << 4)
+#define ES8328_DACCONTROL23_VROI_40k		(1 << 4)
+#define ES8328_DACCONTROL23_OUT3_VREF		(0 << 5)
+#define ES8328_DACCONTROL23_OUT3_ROUT1		(1 << 5)
+#define ES8328_DACCONTROL23_OUT3_MONOOUT	(2 << 5)
+#define ES8328_DACCONTROL23_OUT3_RIGHT_MIXER	(3 << 5)
+#define ES8328_DACCONTROL23_ROUT2INV		(1 << 7)
+
+/* LOUT1 Amplifier */
+#define ES8328_LOUT1VOL 0x2e
+#define ES8328_LOUT1VOL_MASK (0 << 5)
+#define ES8328_LOUT1VOL_MAX (0x24)
+
+/* ROUT1 Amplifier */
+#define ES8328_ROUT1VOL 0x2f
+#define ES8328_ROUT1VOL_MASK (0 << 5)
+#define ES8328_ROUT1VOL_MAX (0x24)
+
+#define ES8328_OUT1VOL_MAX (0x24)
+
+/* LOUT2 Amplifier */
+#define ES8328_LOUT2VOL 0x30
+#define ES8328_LOUT2VOL_MASK (0 << 5)
+#define ES8328_LOUT2VOL_MAX (0x24)
+
+/* ROUT2 Amplifier */
+#define ES8328_ROUT2VOL 0x31
+#define ES8328_ROUT2VOL_MASK (0 << 5)
+#define ES8328_ROUT2VOL_MAX (0x24)
+
+#define ES8328_OUT2VOL_MAX (0x24)
+
+/* Mono Out Amplifier */
+#define ES8328_MONOOUTVOL 0x32
+#define ES8328_MONOOUTVOL_MASK (0 << 5)
+#define ES8328_MONOOUTVOL_MAX (0x24)
+
+#define ES8328_DACCONTROL29	0x33
+#define ES8328_DACCONTROL30	0x34
+
+#define ES8328_SYSCLK		0
+
+#define ES8328_REG_MAX		0x35
+
+#define ES8328_PLL1		0
+#define ES8328_PLL2		1
+
+/* clock inputs */
+#define ES8328_MCLK		0
+#define ES8328_PCMCLK		1
+
+/* clock divider id's */
+#define ES8328_PCMDIV		0
+#define ES8328_BCLKDIV		1
+#define ES8328_VXCLKDIV		2
+
+/* PCM clock dividers */
+#define ES8328_PCM_DIV_1	(0 << 6)
+#define ES8328_PCM_DIV_3	(2 << 6)
+#define ES8328_PCM_DIV_5_5	(3 << 6)
+#define ES8328_PCM_DIV_2	(4 << 6)
+#define ES8328_PCM_DIV_4	(5 << 6)
+#define ES8328_PCM_DIV_6	(6 << 6)
+#define ES8328_PCM_DIV_8	(7 << 6)
+
+/* BCLK clock dividers */
+#define ES8328_BCLK_DIV_1	(0 << 7)
+#define ES8328_BCLK_DIV_2	(1 << 7)
+#define ES8328_BCLK_DIV_4	(2 << 7)
+#define ES8328_BCLK_DIV_8	(3 << 7)
+
+/* VXCLK clock dividers */
+#define ES8328_VXCLK_DIV_1	(0 << 6)
+#define ES8328_VXCLK_DIV_2	(1 << 6)
+#define ES8328_VXCLK_DIV_4	(2 << 6)
+#define ES8328_VXCLK_DIV_8	(3 << 6)
+#define ES8328_VXCLK_DIV_16	(4 << 6)
+
+#define ES8328_DAI_HIFI		0
+#define ES8328_DAI_VOICE	1
+
+#define ES8328_1536FS		1536
+#define ES8328_1024FS		1024
+#define ES8328_768FS		768
+#define ES8328_512FS		512
+#define ES8328_384FS		384
+#define ES8328_256FS		256
+#define ES8328_128FS		128
+
+#endif
-- 
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
