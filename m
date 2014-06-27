From: Xavier Hsu <xavier.hsu@linaro.org>
Subject: [PATCH] ASoC: add Wolfson WM8973 codec driver
Date: Fri, 27 Jun 2014 15:09:15 +0800
Message-ID: <1403852955-18974-1-git-send-email-xavier.hsu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Kraken (unknown [124.219.7.128])
 by alsa0.perex.cz (Postfix) with ESMTP id 18EF3265062
 for <alsa-devel@alsa-project.org>; Fri, 27 Jun 2014 09:09:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, patches@linaro.org
Cc: Xavier Hsu <xavier.hsu@linaro.org>, andy.green@linaro.org
List-Id: alsa-devel@alsa-project.org

This patch adds support for the wm8973 codec, based on the
existing wm8971 codec driver.

Any comments about improving the patch are welcome. 
Thanks.

Signed-off-by: Xavier Hsu <xavier.hsu@linaro.org>
---
 Documentation/devicetree/bindings/sound/wm8973.txt |   26 +
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/wm8973.c                          | 1028 ++++++++++++++++++++
 sound/soc/codecs/wm8973.h                          |   57 ++
 5 files changed, 1117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8973.txt
 create mode 100644 sound/soc/codecs/wm8973.c
 create mode 100644 sound/soc/codecs/wm8973.h

diff --git a/Documentation/devicetree/bindings/sound/wm8973.txt b/Documentation/devicetree/bindings/sound/wm8973.txt
new file mode 100644
index 0000000..2374873
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wm8973.txt
@@ -0,0 +1,26 @@
+WM8973 audio CODEC
+
+These devices support both I2C and SPI (configured with pin strapping
+on the board).
+
+Required properties:
+
+  - compatible : "wlf,wm8973".
+
+  - reg : the I2C address of the device for I2C, the chip select
+          number for SPI.
+
+Optional properties:
+
+  - mclk-div : Setting the CLKDIV2 bit for dividing MCLK.
+    mclk-div = <0> (Default & not divide).
+    mclk-div = <1> (Divide by 2).
+
+Example:
+
+codec: wm8973@1a {
+	compatible = "wlf,wm8973";
+	reg = <0x1a>;
+
+	mclk-div = <1>;
+};
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 350878e..acf83bd 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -139,6 +139,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM8961 if I2C
 	select SND_SOC_WM8962 if I2C && INPUT
 	select SND_SOC_WM8971 if I2C
+	select SND_SOC_WM8973 if I2C
 	select SND_SOC_WM8974 if I2C
 	select SND_SOC_WM8978 if I2C
 	select SND_SOC_WM8983 if SND_SOC_I2C_AND_SPI
@@ -692,6 +693,9 @@ config SND_SOC_WM8962
 config SND_SOC_WM8971
 	tristate
 
+config SND_SOC_WM8973
+	tristate
+
 config SND_SOC_WM8974
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 1bd6e1c..aad29a3 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -141,6 +141,7 @@ snd-soc-wm8960-objs := wm8960.o
 snd-soc-wm8961-objs := wm8961.o
 snd-soc-wm8962-objs := wm8962.o
 snd-soc-wm8971-objs := wm8971.o
+snd-soc-wm8973-objs := wm8973.o
 snd-soc-wm8974-objs := wm8974.o
 snd-soc-wm8978-objs := wm8978.o
 snd-soc-wm8983-objs := wm8983.o
@@ -303,6 +304,7 @@ obj-$(CONFIG_SND_SOC_WM8960)	+= snd-soc-wm8960.o
 obj-$(CONFIG_SND_SOC_WM8961)	+= snd-soc-wm8961.o
 obj-$(CONFIG_SND_SOC_WM8962)	+= snd-soc-wm8962.o
 obj-$(CONFIG_SND_SOC_WM8971)	+= snd-soc-wm8971.o
+obj-$(CONFIG_SND_SOC_WM8973)	+= snd-soc-wm8973.o
 obj-$(CONFIG_SND_SOC_WM8974)	+= snd-soc-wm8974.o
 obj-$(CONFIG_SND_SOC_WM8978)	+= snd-soc-wm8978.o
 obj-$(CONFIG_SND_SOC_WM8983)	+= snd-soc-wm8983.o
diff --git a/sound/soc/codecs/wm8973.c b/sound/soc/codecs/wm8973.c
new file mode 100644
index 0000000..fc03de3
--- /dev/null
+++ b/sound/soc/codecs/wm8973.c
@@ -0,0 +1,1028 @@
+/*
+ * wm8973.c  --  WM8973 ALSA SoC Audio driver
+ *
+ * Copyright (C) 2013 -2014 Fujitsu Semiconductor, Ltd
+ * Copyright (C) 2014 Linaro, Ltd  Xavier Hsu <xavier.hsu@linaro.org>
+ *
+ * Based on wm8971 driver Copyright 2005 Lab126, Inc.
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+
+#include "wm8973.h"
+
+static int mclk_div;
+
+struct wm8973_priv {
+	struct regmap *regmap;
+	unsigned int sysclk;
+	struct snd_pcm_hw_constraint_list *sysclk_constraints;
+	int playback_fs;
+	bool deemph;
+};
+
+/*
+ * wm8973 register cache
+ * We can't read the WM8973 register space when we
+ * are using 2 wire for device control, so we cache them instead.
+ */
+static const struct reg_default wm8973_reg_defaults[] = {
+	{  0, 0x0097 },
+	{  1, 0x0097 },
+	{  2, 0x0079 },
+	{  3, 0x0079 },
+	{  4, 0x0000 },
+	{  5, 0x0008 },
+	{  6, 0x0000 },
+	{  7, 0x000a },
+	{  8, 0x0000 },
+	{  9, 0x0000 },
+	{ 10, 0x00ff },
+	{ 11, 0x00ff },
+	{ 12, 0x000f },
+	{ 13, 0x000f },
+	{ 14, 0x0000 },
+	{ 15, 0x0000 },
+	{ 16, 0x0000 },
+	{ 17, 0x007b },
+	{ 18, 0x0000 },
+	{ 19, 0x0032 },
+	{ 20, 0x0000 },
+	{ 21, 0x01c3 },
+	{ 22, 0x01c3 },
+	{ 23, 0x0040 },
+	{ 24, 0x0014 },
+	{ 25, 0x01c2 },
+	{ 26, 0x0060 },
+	{ 27, 0x0000 },
+	{ 28, 0x0000 },
+	{ 29, 0x0000 },
+	{ 30, 0x0000 },
+	{ 31, 0x0000 },
+	{ 32, 0x0000 },
+	{ 33, 0x0000 },
+	{ 34, 0x0050 },
+	{ 35, 0x0050 },
+	{ 36, 0x0050 },
+	{ 37, 0x0050 },
+	{ 38, 0x0050 },
+	{ 39, 0x0050 },
+	{ 40, 0x0079 },
+	{ 41, 0x0079 },
+	{ 42, 0x0079 },
+};
+
+static const char const *wm8973_bass[] = {"Linear Control", "Adaptive Boost"};
+static const char const *wm8973_bass_filter[] = { "130Hz @ 48kHz",
+						  "200Hz @ 48kHz" };
+static const char const *wm8973_treble[] = {"8kHz", "4kHz"};
+static const char const *wm8973_3d_lc[] = {"200Hz", "500Hz"};
+static const char const *wm8973_3d_uc[] = {"2.2kHz", "1.5kHz"};
+static const char const *wm8973_3d_func[] = {"Capture", "Playback"};
+static const char const *wm8973_alc_func[] = {"Off", "Right", "Left",
+					      "Stereo"};
+static const char const *wm8973_ng_type[] = {"Constant PGA Gain",
+					     "Mute ADC Output"};
+static const char const *wm8973_line_mux[] = {"Line 1", "Line 2", "Line 3",
+					      "PGA", "Differential"};
+static const char const *wm8973_pga_sel[] = {"Line 1", "Line 2", "Line 3",
+					     "Differential"};
+static const char const *wm8973_out3[] = {"VREF", "ROUT1 + Vol", "MonoOut",
+					  "ROUT1"};
+static const char const *wm8973_diff_sel[] = {"Line 1", "Line 2"};
+static const char const *wm8973_adcpol[] = {"Normal", "L Invert", "R Invert",
+					    "L + R Invert"};
+static const char const *wm8973_mono_mux[] = {"Stereo", "Mono (Left)",
+					      "Mono (Right)", "Digital Mono"};
+
+static const SOC_ENUM_SINGLE_DECL(bass_boost, WM8973_BASS, 7, wm8973_bass);
+static const SOC_ENUM_SINGLE_DECL(bass_filter, WM8973_BASS,
+				  6, wm8973_bass_filter);
+static const SOC_ENUM_SINGLE_DECL(treble_cutoff, WM8973_TREBLE,
+				  6, wm8973_treble);
+static const SOC_ENUM_SINGLE_DECL(lower_cutoff, WM8973_3D, 5, wm8973_3d_lc);
+static const SOC_ENUM_SINGLE_DECL(upper_cutoff, WM8973_3D, 6, wm8973_3d_uc);
+static const SOC_ENUM_SINGLE_DECL(mode, WM8973_3D, 7, wm8973_3d_func);
+static const SOC_ENUM_SINGLE_DECL(alc_capture_func, WM8973_ALC1,
+				  7, wm8973_alc_func);
+static const SOC_ENUM_SINGLE_DECL(alc_capture_ngtype, WM8973_NGATE,
+				  1, wm8973_ng_type);
+static const SOC_ENUM_SINGLE_DECL(left_line, WM8973_LOUTM1,
+				  0, wm8973_line_mux);
+static const SOC_ENUM_SINGLE_DECL(right_line, WM8973_ROUTM1,
+				  0, wm8973_line_mux);
+static const SOC_ENUM_SINGLE_DECL(left_pga, WM8973_LADCIN, 6, wm8973_pga_sel);
+static const SOC_ENUM_SINGLE_DECL(right_pga, WM8973_RADCIN, 6, wm8973_pga_sel);
+static const SOC_ENUM_SINGLE_DECL(out3, WM8973_ADCTL2, 7, wm8973_out3);
+static const SOC_ENUM_SINGLE_DECL(diffmux, WM8973_ADCIN, 8, wm8973_diff_sel);
+static const SOC_ENUM_SINGLE_DECL(capture_polarity, WM8973_ADCDAC,
+				  5, wm8973_adcpol);
+static const SOC_ENUM_SINGLE_DECL(monomux, WM8973_ADCIN, 6, wm8973_mono_mux);
+
+static int wm8973_deemph[] = { 0, 32000, 44100, 48000 };
+
+static int wm8973_set_deemph(struct snd_soc_codec *codec)
+{
+	struct wm8973_priv *wm8973 = snd_soc_codec_get_drvdata(codec);
+	int val = 0, i, best = 0;
+
+	/* If we're using deemphasis select the nearest available sample
+	 * rate.
+	*/
+	if (wm8973->deemph) {
+		best = 1;
+		for (i = 2; i < ARRAY_SIZE(wm8973_deemph); i++) {
+			if (abs(wm8973_deemph[i] - wm8973->playback_fs) <
+				abs(wm8973_deemph[best] - wm8973->playback_fs))
+				best = i;
+		}
+		val = best << 1;
+	}
+
+	dev_dbg(codec->dev, "Set deemphasis %d (%dHz)\n",
+		best, wm8973_deemph[best]);
+
+	return snd_soc_update_bits(codec, WM8973_ADCDAC, 0x6, val);
+}
+
+static int wm8973_get_deemph(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct wm8973_priv *wm8973 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.enumerated.item[0] = wm8973->deemph;
+
+	return 0;
+}
+
+static int wm8973_put_deemph(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct wm8973_priv *wm8973 = snd_soc_codec_get_drvdata(codec);
+	int deemph = ucontrol->value.enumerated.item[0];
+	int ret = 0;
+
+	if (deemph > 1)
+		return -EINVAL;
+
+	mutex_lock(&codec->mutex);
+	if (wm8973->deemph != deemph) {
+		wm8973->deemph = deemph;
+		wm8973_set_deemph(codec);
+
+		ret = 1;
+	}
+	mutex_unlock(&codec->mutex);
+
+	return ret;
+}
+
+static const DECLARE_TLV_DB_SCALE(in_vol, -1725, 75, 0);
+static const DECLARE_TLV_DB_SCALE(out_vol, -6700, 91, 0);
+static const DECLARE_TLV_DB_SCALE(attenuate_6db, -600, 600, 0);
+static const DECLARE_TLV_DB_SCALE(dac_vol, -12700, 50, 0);
+static const DECLARE_TLV_DB_SCALE(tone_vol, -600, 150, 0);
+static const DECLARE_TLV_DB_SCALE(alc_tar_vol, -2850, 150, 0);
+static const DECLARE_TLV_DB_SCALE(alc_max_vol, -1200, 600, 0);
+static const DECLARE_TLV_DB_SCALE(adc_vol, -9700, 50, 0);
+static const DECLARE_TLV_DB_SCALE(bypass_out_vol, -1500, 300, 0);
+
+static const struct snd_kcontrol_new wm8973_snd_controls[] = {
+	/* Left & Right Input volume  */
+	SOC_DOUBLE_R_TLV("Capture Volume", WM8973_LINVOL, WM8973_RINVOL,
+			 0, 63, 0, in_vol),
+	SOC_DOUBLE_R("Capture ZC Switch", WM8973_LINVOL, WM8973_RINVOL,
+		     6, 1, 0),
+	SOC_DOUBLE_R("Capture Switch", WM8973_LINVOL, WM8973_RINVOL, 7, 1, 1),
+
+	/* LOUT1 & ROUT1 volume */
+	SOC_DOUBLE_R_TLV("Headphone Playback Volume", WM8973_LOUT1V,
+			 WM8973_ROUT1V, 0, 127, 0, out_vol),
+	SOC_DOUBLE_R("Headphone Playback ZC Switch", WM8973_LOUT1V,
+		     WM8973_ROUT1V, 7, 1, 0),
+
+	/* ADC & DAC control */
+	SOC_SINGLE("Capture Filter Switch", WM8973_ADCDAC, 0, 1, 1),
+	SOC_SINGLE_BOOL_EXT("Playback De-emphasis Switch", 0,
+			    wm8973_get_deemph, wm8973_put_deemph),
+	SOC_ENUM("Capture Polarity", capture_polarity),
+	SOC_SINGLE_TLV("Playback 6dB Attenuate", WM8973_ADCDAC,
+		       7, 1, 0, attenuate_6db),
+	SOC_SINGLE_TLV("Capture 6dB Attenuate", WM8973_ADCDAC,
+		       8, 1, 0, attenuate_6db),
+	/* ADCDAC Bit 4 - HPOR */
+
+	/* Left & Right Channel Digital Volume */
+	SOC_DOUBLE_R_TLV("DAC Volume", WM8973_LDAC, WM8973_RDAC,
+			 0, 255, 0, dac_vol),
+
+	/* Bass Control */
+	SOC_SINGLE_TLV("Bass Volume", WM8973_BASS, 0, 15, 1, tone_vol),
+	SOC_ENUM("Bass Boost", bass_boost),
+	SOC_ENUM("Bass Filter", bass_filter),
+
+	/* Treble Control */
+	SOC_SINGLE_TLV("Treble Volume", WM8973_TREBLE, 0, 15, 0, tone_vol),
+	SOC_ENUM("Treble Cut-off", treble_cutoff),
+
+	/* 3D Control */
+	SOC_SINGLE("3D Switch", WM8973_3D, 0, 1, 0),
+	SOC_SINGLE("3D Volume", WM8973_3D, 1, 15, 0),
+	SOC_ENUM("3D Lower Cut-off", lower_cutoff),
+	SOC_ENUM("3D Upper Cut-off", upper_cutoff),
+	SOC_ENUM("3D Mode", mode),
+
+	/* ALC1 & ALC2 & ALC3 Control */
+	SOC_SINGLE_TLV("ALC Capture Target Volume", WM8973_ALC1,
+		       0, 15, 0, alc_tar_vol),
+	SOC_SINGLE_TLV("ALC Capture Max Volume", WM8973_ALC1,
+		       4, 7, 0, alc_max_vol),
+	SOC_ENUM("ALC Capture Function", alc_capture_func),
+
+	SOC_SINGLE("ALC Capture Hold Time", WM8973_ALC2, 0, 15, 0),
+	SOC_SINGLE("ALC Capture ZC Switch", WM8973_ALC2, 7, 1, 0),
+
+	SOC_SINGLE("ALC Capture Attack Time", WM8973_ALC3, 0, 15, 0),
+	SOC_SINGLE("ALC Capture Decay Time", WM8973_ALC3, 4, 15, 0),
+
+	/* Noise Gate Control */
+	SOC_SINGLE("ALC Capture NG Switch", WM8973_NGATE, 0, 1, 0),
+	SOC_ENUM("ALC Capture NG Type", alc_capture_ngtype),
+	SOC_SINGLE("ALC Capture NG Threshold", WM8973_NGATE, 3, 31, 0),
+
+	/* Left & Right ADC Digital Volume*/
+	SOC_DOUBLE_R_TLV("ADC Volume", WM8973_LADC, WM8973_RADC,
+			 0, 255, 0, adc_vol),
+
+	/* Additional Control 1 */
+	SOC_SINGLE("ZC Timeout Switch", WM8973_ADCTL1, 0, 1, 0),
+	SOC_SINGLE("Playback Invert Switch", WM8973_ADCTL1, 1, 1, 0),
+	SOC_SINGLE("Analogue Bias", WM8973_ADCTL1, 6, 3, 0),
+	/* ADCTL1 Bit 2,3 - DATSEL */
+	/* ADCTL1 Bit 6,7 - VSEL */
+
+	/* Additional Control 2 */
+	SOC_SINGLE("Right Speaker Playback Invert Switch", WM8973_ADCTL2,
+		   4, 1, 0),
+	/* ADCTL2 Bit 2 - LRCM */
+	SOC_SINGLE("LRCLK Switch", WM8973_ADCTL2, 2, 1, 0),
+	/* ADCTL2 Bit 3 - TRI */
+	SOC_SINGLE("Headphone Switch POL", WM8973_ADCTL2, 5, 1, 0),
+	SOC_SINGLE("Headphone Switch EN", WM8973_ADCTL2, 6, 1, 0),
+
+	/* Additional Control 3 */
+	/* ADCTL3 Bit 5 - HPFLREN */
+	/* ADCTL3 Bit 6 - VROI */
+	/* ADCTL3 Bit 7,8 - ADCLRM */
+
+	/* ADC input Mode */
+	/* ADCIN Bit 4 - LDCM */
+	/* ADCIN Bit 5 - RDCM */
+	/* ADCIN Bit 6,7 - MONOMIX */
+
+	/* Left & Right ADC Signal Path Control*/
+	SOC_DOUBLE_R("Mic Boost", WM8973_LADCIN, WM8973_RADCIN, 4, 3, 0),
+
+	/* Left OUT Mixer Control */
+	SOC_DOUBLE_R_TLV("Bypass Left Playback Volume", WM8973_LOUTM1,
+			 WM8973_LOUTM2, 4, 7, 1, bypass_out_vol),
+
+	/* Right OUT Mixer Control */
+	SOC_DOUBLE_R_TLV("Bypass Right Playback Volume", WM8973_ROUTM1,
+			 WM8973_ROUTM2, 4, 7, 1, bypass_out_vol),
+
+	/*  Mono OUT Mixer Control */
+	SOC_DOUBLE_R_TLV("Bypass Mono Playback Volume", WM8973_MOUTM1,
+			 WM8973_MOUTM2, 4, 7, 1, bypass_out_vol),
+
+	/* LOUT2 & ROUT2 volume */
+	SOC_DOUBLE_R_TLV("Speaker Playback Volume", WM8973_LOUT2V,
+			 WM8973_ROUT2V, 0, 127, 0, out_vol),
+	SOC_DOUBLE_R("Speaker Playback ZC Switch", WM8973_LOUT2V,
+		     WM8973_ROUT2V, 7, 1, 0),
+
+	/* MONOOUT volume */
+	SOC_SINGLE_TLV("Mono Playback Volume", WM8973_MOUTV,
+		       0, 127, 0, out_vol),
+	SOC_SINGLE("Mono Playback ZC Switch", WM8973_MOUTV, 7, 1, 0),
+
+	SOC_SINGLE("Right Out 2", WM8973_PWR2, 3, 1, 0),
+	SOC_SINGLE("Left Out 2", WM8973_PWR2, 4, 1, 0),
+};
+
+/*
+ * DAPM Controls
+ */
+
+/* Left Mixer */
+static const struct snd_kcontrol_new wm8973_left_mixer_controls[] = {
+SOC_DAPM_SINGLE("Playback Switch", WM8973_LOUTM1, 8, 1, 0),
+SOC_DAPM_SINGLE("Left Bypass Switch", WM8973_LOUTM1, 7, 1, 0),
+SOC_DAPM_SINGLE("Right Playback Switch", WM8973_LOUTM2, 8, 1, 0),
+SOC_DAPM_SINGLE("Right Bypass Switch", WM8973_LOUTM2, 7, 1, 0),
+};
+
+/* Right Mixer */
+static const struct snd_kcontrol_new wm8973_right_mixer_controls[] = {
+SOC_DAPM_SINGLE("Left Playback Switch", WM8973_ROUTM1, 8, 1, 0),
+SOC_DAPM_SINGLE("Left Bypass Switch", WM8973_ROUTM1, 7, 1, 0),
+SOC_DAPM_SINGLE("Playback Switch", WM8973_ROUTM2, 8, 1, 0),
+SOC_DAPM_SINGLE("Right Bypass Switch", WM8973_ROUTM2, 7, 1, 0),
+};
+
+/* Mono Mixer */
+static const struct snd_kcontrol_new wm8973_mono_mixer_controls[] = {
+SOC_DAPM_SINGLE("Left Playback Switch", WM8973_MOUTM1, 8, 1, 0),
+SOC_DAPM_SINGLE("Left Bypass Switch", WM8973_MOUTM1, 7, 1, 0),
+SOC_DAPM_SINGLE("Right Playback Switch", WM8973_MOUTM2, 8, 1, 0),
+SOC_DAPM_SINGLE("Right Bypass Switch", WM8973_MOUTM2, 7, 1, 0),
+};
+
+/* Left Line Mux */
+static const struct snd_kcontrol_new wm8973_left_line_controls =
+SOC_DAPM_ENUM("Route", left_line);
+
+/* Right Line Mux */
+static const struct snd_kcontrol_new wm8973_right_line_controls =
+SOC_DAPM_ENUM("Route", right_line);
+
+/* Left PGA Mux */
+static const struct snd_kcontrol_new wm8973_left_pga_controls =
+SOC_DAPM_ENUM("Route", left_pga);
+
+/* Right PGA Mux */
+static const struct snd_kcontrol_new wm8973_right_pga_controls =
+SOC_DAPM_ENUM("Route", right_pga);
+
+/* Out 3 Mux */
+static const struct snd_kcontrol_new wm8973_out3_controls =
+SOC_DAPM_ENUM("Route", out3);
+
+/* Differential Mux */
+static const struct snd_kcontrol_new wm8973_diffmux_controls =
+SOC_DAPM_ENUM("Route", diffmux);
+
+/* Mono ADC Mux */
+static const struct snd_kcontrol_new wm8973_monomux_controls =
+SOC_DAPM_ENUM("Route", monomux);
+
+static const struct snd_soc_dapm_widget wm8973_dapm_widgets[] = {
+	SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
+			   &wm8973_left_mixer_controls[0],
+			   ARRAY_SIZE(wm8973_left_mixer_controls)),
+
+	SND_SOC_DAPM_MIXER("Right Mixer", SND_SOC_NOPM, 0, 0,
+			   &wm8973_right_mixer_controls[0],
+			   ARRAY_SIZE(wm8973_right_mixer_controls)),
+
+	SND_SOC_DAPM_MIXER("Mono Mixer", WM8973_PWR2, 2, 0,
+			   &wm8973_mono_mixer_controls[0],
+			   ARRAY_SIZE(wm8973_mono_mixer_controls)),
+
+	SND_SOC_DAPM_PGA("Right Out 2", WM8973_PWR2, 3, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Left Out 2", WM8973_PWR2, 4, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Right Out 1", WM8973_PWR2, 5, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Left Out 1", WM8973_PWR2, 6, 0, NULL, 0),
+	SND_SOC_DAPM_DAC("Right DAC", "Right Playback", WM8973_PWR2, 7, 0),
+	SND_SOC_DAPM_DAC("Left DAC", "Left Playback", WM8973_PWR2, 8, 0),
+
+	SND_SOC_DAPM_MICBIAS("Mic Bias", WM8973_PWR1, 1, 0),
+	SND_SOC_DAPM_ADC("Right ADC", "Right Capture", WM8973_PWR1, 2, 0),
+	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", WM8973_PWR1, 3, 0),
+	SND_SOC_DAPM_MUX("Right PGA Mux", WM8973_PWR1, 4, 0,
+			 &wm8973_right_pga_controls),
+	SND_SOC_DAPM_MUX("Left PGA Mux", WM8973_PWR1, 5, 0,
+			 &wm8973_left_pga_controls),
+
+	SND_SOC_DAPM_MUX("Left Line Mux", SND_SOC_NOPM, 0, 0,
+			 &wm8973_left_line_controls),
+	SND_SOC_DAPM_MUX("Right Line Mux", SND_SOC_NOPM, 0, 0,
+			 &wm8973_right_line_controls),
+
+	SND_SOC_DAPM_MUX("Out3 Mux", SND_SOC_NOPM, 0, 0,
+			 &wm8973_out3_controls),
+	SND_SOC_DAPM_PGA("Out 3", WM8973_PWR2, 1, 0, NULL, 0),
+
+	SND_SOC_DAPM_PGA("Mono Out 1", WM8973_PWR2, 2, 0, NULL, 0),
+
+	SND_SOC_DAPM_MUX("Differential Mux", SND_SOC_NOPM, 0, 0,
+			 &wm8973_diffmux_controls),
+
+	SND_SOC_DAPM_MUX("Left ADC Mux", SND_SOC_NOPM, 0, 0,
+			 &wm8973_monomux_controls),
+	SND_SOC_DAPM_MUX("Right ADC Mux", SND_SOC_NOPM, 0, 0,
+			 &wm8973_monomux_controls),
+
+	SND_SOC_DAPM_OUTPUT("LOUT1"),
+	SND_SOC_DAPM_OUTPUT("ROUT1"),
+	SND_SOC_DAPM_OUTPUT("LOUT2"),
+	SND_SOC_DAPM_OUTPUT("ROUT2"),
+	SND_SOC_DAPM_OUTPUT("MONO1"),
+	SND_SOC_DAPM_OUTPUT("OUT3"),
+	SND_SOC_DAPM_OUTPUT("VREF"),
+
+	SND_SOC_DAPM_INPUT("LINPUT1"),
+	SND_SOC_DAPM_INPUT("LINPUT2"),
+	SND_SOC_DAPM_INPUT("LINPUT3"),
+	SND_SOC_DAPM_INPUT("RINPUT1"),
+	SND_SOC_DAPM_INPUT("RINPUT2"),
+	SND_SOC_DAPM_INPUT("RINPUT3"),
+};
+
+static const struct snd_soc_dapm_route wm8973_dapm_routes[] = {
+	{"Left Mixer", "Playback Switch", "Left DAC"},
+	{"Left Mixer", "Left Bypass Switch", "Left Line Mux"},
+	{"Left Mixer", "Right Playback Switch", "Right DAC"},
+	{"Left Mixer", "Right Bypass Switch", "Right Line Mux"},
+
+	{"Right Mixer", "Left Playback Switch", "Left DAC"},
+	{"Right Mixer", "Left Bypass Switch", "Left Line Mux"},
+	{"Right Mixer", "Playback Switch", "Right DAC"},
+	{"Right Mixer", "Right Bypass Switch", "Right Line Mux"},
+
+	{"Left Out 1", NULL, "Left Mixer"},
+	{"LOUT1", NULL, "Left Out 1"},
+
+	{"Left Out 2", NULL, "Left Mixer"},
+	{"LOUT2", NULL, "Left Out 2"},
+
+	{"Right Out 1", NULL, "Right Mixer"},
+	{"ROUT1", NULL, "Right Out 1"},
+
+	{"Right Out 2", NULL, "Right Mixer"},
+	{"ROUT2", NULL, "Right Out 2"},
+
+	{"Mono Mixer", "Left Playback Switch", "Left DAC"},
+	{"Mono Mixer", "Left Bypass Switch", "Left Line Mux"},
+	{"Mono Mixer", "Right Playback Switch", "Right DAC"},
+	{"Mono Mixer", "Right Bypass Switch", "Right Line Mux"},
+
+	{"Mono Out 1", NULL, "Mono Mixer"},
+	{"MONO1", NULL, "Mono Out 1"},
+
+	{"Out3 Mux", "VREF", "VREF"},
+	{"Out3 Mux", "ROUT1 + Vol", "ROUT1"},
+	{"Out3 Mux", "ROUT1", "Right Mixer"},
+	{"Out3 Mux", "MonoOut", "MONO1"},
+	{"Out 3", NULL, "Out3 Mux"},
+	{"OUT3", NULL, "Out 3"},
+
+	{"Left Line Mux", "Line 1", "LINPUT1"},
+	{"Left Line Mux", "Line 2", "LINPUT2"},
+	{"Left Line Mux", "Line 3", "LINPUT3"},
+	{"Left Line Mux", "PGA", "Left PGA Mux"},
+	{"Left Line Mux", "Differential", "Differential Mux"},
+
+	{"Right Line Mux", "Line 1", "RINPUT1"},
+	{"Right Line Mux", "Line 2", "RINPUT2"},
+	{"Right Line Mux", "Line 3", "RINPUT3"},
+	/* {"Right Line Mux", "Mic", "MIC"}, */
+	{"Right Line Mux", "PGA", "Right PGA Mux"},
+	{"Right Line Mux", "Differential", "Differential Mux"},
+
+	{"Left PGA Mux", "Line 1", "LINPUT1"},
+	{"Left PGA Mux", "Line 2", "LINPUT2"},
+	{"Left PGA Mux", "Line 3", "LINPUT3"},
+	{"Left PGA Mux", "Differential", "Differential Mux"},
+
+	{"Right PGA Mux", "Line 1", "RINPUT1"},
+	{"Right PGA Mux", "Line 2", "RINPUT2"},
+	{"Right PGA Mux", "Line 3", "RINPUT3"},
+	{"Right PGA Mux", "Differential", "Differential Mux"},
+
+	{"Differential Mux", "Line 1", "LINPUT1"},
+	{"Differential Mux", "Line 1", "RINPUT1"},
+	{"Differential Mux", "Line 2", "LINPUT2"},
+	{"Differential Mux", "Line 2", "RINPUT2"},
+
+	{"Left ADC Mux", "Stereo", "Left PGA Mux"},
+	{"Left ADC Mux", "Mono (Left)", "Left PGA Mux"},
+	{"Left ADC Mux", "Digital Mono", "Left PGA Mux"},
+
+	{"Right ADC Mux", "Stereo", "Right PGA Mux"},
+	{"Right ADC Mux", "Mono (Right)", "Right PGA Mux"},
+	{"Right ADC Mux", "Digital Mono", "Right PGA Mux"},
+
+	{"Left ADC", NULL, "Left ADC Mux"},
+	{"Right ADC", NULL, "Right ADC Mux"},
+};
+
+struct _coeff_div {
+	u32 mclk;
+	u32 rate;
+	u16 fs;
+	u8 sr:5;
+	u8 usb:1;
+};
+
+/* codec hifi mclk clock divider coefficients */
+static const struct _coeff_div coeff_div[] = {
+	/* 8k */
+	{12288000, 8000, 1536, 0x6, 0x0},
+	{11289600, 8000, 1408, 0x16, 0x0},
+	{18432000, 8000, 2304, 0x7, 0x0},
+	{16934400, 8000, 2112, 0x17, 0x0},
+	{12000000, 8000, 1500, 0x6, 0x1},
+
+	/* 11.025k */
+	{11289600, 11025, 1024, 0x18, 0x0},
+	{16934400, 11025, 1536, 0x19, 0x0},
+	{12000000, 11025, 1088, 0x19, 0x1},
+
+	/* 16k */
+	{12288000, 16000, 768, 0xa, 0x0},
+	{18432000, 16000, 1152, 0xb, 0x0},
+	{12000000, 16000, 750, 0xa, 0x1},
+
+	/* 22.05k */
+	{11289600, 22050, 512, 0x1a, 0x0},
+	{16934400, 22050, 768, 0x1b, 0x0},
+	{12000000, 22050, 544, 0x1b, 0x1},
+
+	/* 32k */
+	{12288000, 32000, 384, 0xc, 0x0},
+	{18432000, 32000, 576, 0xd, 0x0},
+	{12000000, 32000, 375, 0xa, 0x1},
+
+	/* 44.1k */
+	{11289600, 44100, 256, 0x10, 0x0},
+	{16934400, 44100, 384, 0x11, 0x0},
+	{12000000, 44100, 272, 0x11, 0x1},
+
+	/* 48k */
+	{12288000, 48000, 256, 0x0, 0x0},
+	{18432000, 48000, 384, 0x1, 0x0},
+	{12000000, 48000, 250, 0x0, 0x1},
+
+	/* 88.2k */
+	{11289600, 88200, 128, 0x1e, 0x0},
+	{16934400, 88200, 192, 0x1f, 0x0},
+	{12000000, 88200, 136, 0x1f, 0x1},
+
+	/* 96k */
+	{12288000, 96000, 128, 0xe, 0x0},
+	{18432000, 96000, 192, 0xf, 0x0},
+	{12000000, 96000, 125, 0xe, 0x1},
+};
+
+static int get_coeff(int mclk, int rate)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(coeff_div); i++) {
+		if (coeff_div[i].rate == rate && coeff_div[i].mclk == mclk)
+			return i;
+	}
+	return -EINVAL;
+}
+
+/* The set of rates we can generate from the above for each SYSCLK */
+static unsigned int rates_12288[] = {
+	8000, 12000, 16000, 24000, 32000, 48000, 96000
+};
+
+static struct snd_pcm_hw_constraint_list constraints_12288 = {
+	.count	= ARRAY_SIZE(rates_12288),
+	.list	= rates_12288,
+};
+
+static unsigned int rates_112896[] = {
+	8000, 11025, 22050, 44100, 88200
+};
+
+static struct snd_pcm_hw_constraint_list constraints_112896 = {
+	.count	= ARRAY_SIZE(rates_112896),
+	.list	= rates_112896,
+};
+
+static unsigned int rates_18432[] = {
+	8000, 12000, 16000, 24000, 32000, 48000, 96000
+};
+
+static struct snd_pcm_hw_constraint_list constraints_18432 = {
+	.count  = ARRAY_SIZE(rates_18432),
+	.list   = rates_18432,
+};
+
+static unsigned int rates_169344[] = {
+	8000, 11025, 22050, 44100, 88200
+};
+
+static struct snd_pcm_hw_constraint_list constraints_169344 = {
+	.count  = ARRAY_SIZE(rates_169344),
+	.list   = rates_169344,
+};
+
+static unsigned int rates_12[] = {
+	8000, 11025, 12000, 16000, 22050, 2400, 32000, 41100, 48000,
+	48000, 88235, 96000,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_12 = {
+	.count	= ARRAY_SIZE(rates_12),
+	.list	= rates_12,
+};
+
+static int wm8973_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+				 int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct wm8973_priv *wm8973 = snd_soc_codec_get_drvdata(codec);
+
+	switch (freq) {
+	case 12288000:
+	case 24576000:
+		wm8973->sysclk_constraints = &constraints_12288;
+		wm8973->sysclk = freq;
+		return 0;
+
+	case 11289600:
+	case 22579200:
+		wm8973->sysclk_constraints = &constraints_112896;
+		wm8973->sysclk = freq;
+		return 0;
+
+	case 18432000:
+	case 36864000:
+		wm8973->sysclk_constraints = &constraints_18432;
+		wm8973->sysclk = freq;
+		return 0;
+
+	case 16934400:
+	case 33868800:
+		wm8973->sysclk_constraints = &constraints_169344;
+		wm8973->sysclk = freq;
+		return 0;
+
+	case 12000000:
+	case 24000000:
+		wm8973->sysclk_constraints = &constraints_12;
+		wm8973->sysclk = freq;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int wm8973_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+
+	/* set master/slave audio interface */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		snd_soc_update_bits(codec, WM8973_IFACE, 0x0040, 0x0040);
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* interface format */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		snd_soc_update_bits(codec, WM8973_IFACE, 0x0002, 0x0002);
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		snd_soc_update_bits(codec, WM8973_IFACE, 0x0001, 0x0001);
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		snd_soc_update_bits(codec, WM8973_IFACE, 0x0003, 0x0003);
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		snd_soc_update_bits(codec, WM8973_IFACE, 0x0013, 0x0013);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* clock inversion */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		snd_soc_update_bits(codec, WM8973_IFACE, 0x0090, 0x0090);
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		snd_soc_update_bits(codec, WM8973_IFACE, 0x0080, 0x0080);
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		snd_soc_update_bits(codec, WM8973_IFACE, 0x0010, 0x0010);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int wm8973_pcm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct wm8973_priv *wm8973 = snd_soc_codec_get_drvdata(codec);
+	u16 iface = snd_soc_read(codec, WM8973_IFACE) & 0x1f3;
+	u16 srate = snd_soc_read(codec, WM8973_SRATE) & 0x1c0;
+	int coeff = get_coeff(wm8973->sysclk, params_rate(params));
+
+	wm8973->playback_fs = params_rate(params);
+
+	/* bit size */
+	switch (params_width(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		iface |= 0x0004;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		iface |= 0x0008;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		iface |= 0x000c;
+		break;
+	}
+
+	wm8973_set_deemph(codec);
+
+	/* set iface & srate */
+	snd_soc_write(codec, WM8973_IFACE, iface);
+	if (coeff >= 0) {
+		snd_soc_write(codec, WM8973_SRATE, srate |
+			(coeff_div[coeff].sr << 1) | coeff_div[coeff].usb);
+	}
+
+	return 0;
+}
+
+static int wm8973_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u16 mute_reg = snd_soc_read(codec, WM8973_ADCDAC) & 0xfff7;
+
+	if (mute)
+		snd_soc_write(codec, WM8973_ADCDAC, mute_reg | 0x8);
+	else
+		snd_soc_write(codec, WM8973_ADCDAC, mute_reg);
+	return 0;
+}
+
+static int wm8973_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
+{
+	struct wm8973_priv *wm8973 = snd_soc_codec_get_drvdata(codec);
+	u16 pwr_reg = snd_soc_read(codec, WM8973_PWR1) & 0x03e;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		/* set vmid to 50k and unmute dac */
+		snd_soc_write(codec, WM8973_PWR1, pwr_reg | 0x00c2);
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
+			regcache_sync(wm8973->regmap);
+
+		/* mute dac and set vmid to 500k, enable VREF */
+		snd_soc_write(codec, WM8973_PWR1, pwr_reg | 0x0141);
+		break;
+	case SND_SOC_BIAS_OFF:
+		snd_soc_write(codec, WM8973_PWR1, 0x0001);
+		break;
+	}
+	codec->dapm.bias_level = level;
+
+	return 0;
+}
+
+#define WM8973_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
+		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | \
+		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 | \
+		SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
+
+#define WM8973_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
+	SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+static const struct snd_soc_dai_ops wm8973_dai_ops = {
+	.hw_params	= wm8973_pcm_hw_params,
+	.digital_mute	= wm8973_mute,
+	.set_fmt	= wm8973_set_dai_fmt,
+	.set_sysclk	= wm8973_set_dai_sysclk,
+};
+
+static struct snd_soc_dai_driver wm8973_dai[] = {
+	{
+		.name = "wm8973-hifi-playback",
+		.playback = {
+			.stream_name = "Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = WM8973_RATES,
+			.formats = WM8973_FORMATS,
+		},
+		.ops = &wm8973_dai_ops,
+	},
+	{
+		.name = "wm8973-hifi-capture",
+		.capture = {
+			.stream_name = "Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = WM8973_RATES,
+			.formats = WM8973_FORMATS,
+		},
+		.ops = &wm8973_dai_ops,
+	},
+};
+
+static int wm8973_suspend(struct snd_soc_codec *codec)
+{
+	struct wm8973_priv *wm8973 = snd_soc_codec_get_drvdata(codec);
+
+	wm8973_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	regcache_mark_dirty(wm8973->regmap);
+	return 0;
+}
+
+static int wm8973_resume(struct snd_soc_codec *codec)
+{
+	u16 reg;
+
+	wm8973_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	/* charge wm8973 caps */
+	if (codec->dapm.suspend_bias_level == SND_SOC_BIAS_ON) {
+		reg = snd_soc_read(codec, WM8973_PWR1) & 0xfe3e;
+		snd_soc_write(codec, WM8973_PWR1, reg | 0x01c0);
+		codec->dapm.bias_level = SND_SOC_BIAS_ON;
+		msleep(100);
+	}
+
+	return 0;
+}
+
+static int wm8973_probe(struct snd_soc_codec *codec)
+{
+	struct wm8973_priv *wm8973 = snd_soc_codec_get_drvdata(codec);
+	int ret = 0;
+	u16 reg;
+	const int *p;
+
+	mclk_div = 0;
+
+	codec->control_data = wm8973->regmap;
+
+	snd_soc_write(codec, WM8973_RESET, 0);
+
+	if (codec->dev->of_node) {
+		p = of_get_property(codec->dev->of_node, "mclk-div", NULL);
+		if (p)
+			mclk_div = be32_to_cpu(*p);
+	}
+	/* Master Clock Divide by 2 (0 = not div, 1 = div by 2) */
+	if (mclk_div)
+		snd_soc_update_bits(codec, WM8973_SRATE, 0x0040, 0x0040);
+
+	/* charge output caps - set vmid to 5k for quick power up */
+	reg = snd_soc_read(codec, WM8973_PWR1) & 0x03e;
+	snd_soc_write(codec, WM8973_PWR1, reg |  0x1f0);
+
+	codec->dapm.bias_level = SND_SOC_BIAS_STANDBY;
+
+	/* set the update bits */
+	snd_soc_update_bits(codec, WM8973_LDAC, 0x0100, 0x0100);
+	snd_soc_update_bits(codec, WM8973_RDAC, 0x0100, 0x0100);
+	snd_soc_update_bits(codec, WM8973_LOUT1V, 0x0100, 0x0100);
+	snd_soc_update_bits(codec, WM8973_ROUT1V, 0x0100, 0x0100);
+	snd_soc_update_bits(codec, WM8973_LOUT2V, 0x0100, 0x0100);
+	snd_soc_update_bits(codec, WM8973_ROUT2V, 0x0100, 0x0100);
+	snd_soc_update_bits(codec, WM8973_LINVOL, 0x0100, 0x0100);
+	snd_soc_update_bits(codec, WM8973_RINVOL, 0x0100, 0x0100);
+
+	return ret;
+}
+
+
+/* power down chip */
+static int wm8973_remove(struct snd_soc_codec *codec)
+{
+	wm8973_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	return 0;
+}
+
+struct regmap *wm8973_get_regmap(struct device *dev)
+{
+	struct wm8973_priv *priv = dev_get_drvdata(dev);
+
+	return priv->regmap;
+}
+
+static struct snd_soc_codec_driver soc_codec_dev_wm8973 = {
+	.probe = wm8973_probe,
+	.remove = wm8973_remove,
+	.suspend = wm8973_suspend,
+	.resume = wm8973_resume,
+	.set_bias_level = wm8973_set_bias_level,
+	.get_regmap =   wm8973_get_regmap,
+	.controls = wm8973_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8973_snd_controls),
+	.dapm_widgets = wm8973_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8973_dapm_widgets),
+	.dapm_routes = wm8973_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(wm8973_dapm_routes),
+};
+
+static const struct regmap_config wm8973_regmap = {
+	.reg_bits = 7,
+	.val_bits = 9,
+	.max_register = WM8973_MOUTV,
+	.reg_defaults = wm8973_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8973_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static int wm8973_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	struct wm8973_priv *wm8973;
+	int ret;
+
+	wm8973 = devm_kzalloc(&i2c->dev, sizeof(struct wm8973_priv),
+			      GFP_KERNEL);
+	if (wm8973 == NULL)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, wm8973);
+
+	wm8973->regmap = devm_regmap_init_i2c(i2c, &wm8973_regmap);
+	if (IS_ERR(wm8973->regmap)) {
+		ret = PTR_ERR(wm8973->regmap);
+		dev_err(&i2c->dev, "Failed to init regmap: %d\n", ret);
+
+		return ret;
+	}
+
+	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_wm8973,
+				     wm8973_dai, ARRAY_SIZE(wm8973_dai));
+
+	return ret;
+}
+
+static int wm8973_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	return 0;
+}
+
+static const struct i2c_device_id wm8973_i2c_id[] = {
+	{ "wm8973", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, wm8973_i2c_id);
+
+static const struct of_device_id wm8973_dt_ids[] = {
+	{ .compatible = "wlf,wm8973" },
+	{ /* sentinel */ }
+};
+
+static struct i2c_driver wm8973_i2c_driver = {
+	.driver = {
+		.name = "wm8973",
+		.owner = THIS_MODULE,
+		.of_match_table = wm8973_dt_ids,
+	},
+	.probe =    wm8973_i2c_probe,
+	.remove =   wm8973_i2c_remove,
+	.id_table = wm8973_i2c_id,
+};
+
+module_i2c_driver(wm8973_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC WM8973 driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("*wm8973*");
diff --git a/sound/soc/codecs/wm8973.h b/sound/soc/codecs/wm8973.h
new file mode 100644
index 0000000..5e6a026
--- /dev/null
+++ b/sound/soc/codecs/wm8973.h
@@ -0,0 +1,57 @@
+/*
+ * sound/soc/codecs/wm8973.h  --  audio driver for WM8973
+ *
+ * Copyright (C) 2013 - 2014  Fujitsu Semiconductor, Ltd
+ *
+ * Author: Xavier Hsu <xavier.hsu@linaro.org>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifndef _WM8973_H
+#define _WM8973_H
+
+#define WM8973_LINVOL	0x00
+#define WM8973_RINVOL	0x01
+#define WM8973_LOUT1V	0x02
+#define WM8973_ROUT1V	0x03
+#define WM8973_ADCDAC	0x05
+#define WM8973_IFACE	0x07
+#define WM8973_SRATE	0x08
+#define WM8973_LDAC	0x0a
+#define WM8973_RDAC	0x0b
+#define WM8973_BASS	0x0c
+#define WM8973_TREBLE	0x0d
+#define WM8973_RESET	0x0f
+#define WM8973_3D	0x10
+#define WM8973_ALC1	0x11
+#define WM8973_ALC2	0x12
+#define WM8973_ALC3	0x13
+#define WM8973_NGATE	0x14
+#define WM8973_LADC	0x15
+#define WM8973_RADC	0x16
+#define WM8973_ADCTL1	0x17
+#define WM8973_ADCTL2	0x18
+#define WM8973_PWR1	0x19
+#define WM8973_PWR2	0x1a
+#define WM8973_ADCTL3	0x1b
+#define WM8973_ADCIN	0x1f
+#define WM8973_LADCIN	0x20
+#define WM8973_RADCIN	0x21
+#define WM8973_LOUTM1	0x22
+#define WM8973_LOUTM2	0x23
+#define WM8973_ROUTM1	0x24
+#define WM8973_ROUTM2	0x25
+#define WM8973_MOUTM1	0x26
+#define WM8973_MOUTM2	0x27
+#define WM8973_LOUT2V	0x28
+#define WM8973_ROUT2V	0x29
+#define WM8973_MOUTV	0x2A
+
+#define WM8973_SYSCLK	0
+
+#endif
-- 
1.7.9.5
