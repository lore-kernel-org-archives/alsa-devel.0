From: Xavier Hsu <xavier.hsu@linaro.org>
Subject: [PATCHv2] ASOC add wm8973 support to wm8971
Date: Fri,  1 Aug 2014 14:10:31 +0800
Message-ID: <1406873431-4946-1-git-send-email-xavier.hsu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Kraken (unknown [124.219.7.128])
 by alsa0.perex.cz (Postfix) with ESMTP id E22CE265158
 for <alsa-devel@alsa-project.org>; Fri,  1 Aug 2014 08:11:02 +0200 (CEST)
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
Cc: Xavier Hsu <xavier.hsu@linaro.org>, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, andy.green@linaro.org
List-Id: alsa-devel@alsa-project.org

This patch adds support for the wm8973 codec.
After the initial comments, we merged wm8973 driver
into wm8971 driver.

Any comments about improving the patch are welcome.
Thanks.

Signed-off-by: Xavier Hsu <xavier.hsu@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---
 Documentation/devicetree/bindings/sound/wm8971.txt |   26 +
 sound/soc/codecs/wm8971.c                          |  777 +++++++++++++++++---
 sound/soc/codecs/wm8971.h                          |   21 +-
 3 files changed, 696 insertions(+), 128 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8971.txt

diff --git a/Documentation/devicetree/bindings/sound/wm8971.txt b/Documentation/devicetree/bindings/sound/wm8971.txt
new file mode 100644
index 0000000..7313dd1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wm8971.txt
@@ -0,0 +1,26 @@
+WM8971 and WM8973 audio CODEC
+
+These devices support both I2C and SPI (configured with pin strapping
+on the board).
+
+Required properties:
+
+  - compatible : "wlf,wm8971".
+		 "wlf,wm8973".
+
+  - reg : the I2C address of the device for I2C, the chip select
+	  number for SPI.
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
+	mclk-div = <1>;
+};
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 09b7b42..6b1838c 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -7,6 +7,10 @@
  *
  * Based on wm8753.c by Liam Girdwood
  *
+ * WM8973 support Copyright (C) 2014 Linaro, Ltd
+ * Author: Xavier Hsu <xavier.hsu@linaro.org>
+ *         Andy Green <andy.green@linaro.org>
+ *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
  *  Free Software Foundation;  either version 2 of the  License, or (at your
@@ -26,16 +30,31 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/initval.h>
+#include <sound/tlv.h>
 
 #include "wm8971.h"
 
-#define	WM8971_REG_COUNT		43
+enum variant {
+	VARIANT_WM8971,
+	VARIANT_WM8973
+};
 
-static struct workqueue_struct *wm8971_workq = NULL;
+#define	WM8971_REG_COUNT		43
 
 /* codec private data */
 struct wm8971_priv {
+	struct regmap *regmap;
+	enum variant variant;
 	unsigned int sysclk;
+	struct snd_pcm_hw_constraint_list *sysclk_constraints;
+	int playback_fs;
+	bool deemph;
+	int mclk_div;
+};
+
+static const u16 charge[][2] = {
+	[VARIANT_WM8971] = { 0xfe3e, 0x01c0 },
+	[VARIANT_WM8973] = { 0x003e, 0x01f0 },
 };
 
 /*
@@ -91,26 +110,53 @@ static const struct reg_default wm8971_reg_defaults[] = {
 
 #define wm8971_reset(c)	snd_soc_write(c, WM8971_RESET, 0)
 
-/* WM8971 Controls */
-static const char *wm8971_bass[] = { "Linear Control", "Adaptive Boost" };
-static const char *wm8971_bass_filter[] = { "130Hz @ 48kHz",
-	"200Hz @ 48kHz" };
-static const char *wm8971_treble[] = { "8kHz", "4kHz" };
-static const char *wm8971_alc_func[] = { "Off", "Right", "Left", "Stereo" };
-static const char *wm8971_ng_type[] = { "Constant PGA Gain",
-	"Mute ADC Output" };
-static const char *wm8971_deemp[] = { "None", "32kHz", "44.1kHz", "48kHz" };
-static const char *wm8971_mono_mux[] = {"Stereo", "Mono (Left)",
-	"Mono (Right)", "Digital Mono"};
-static const char *wm8971_dac_phase[] = { "Non Inverted", "Inverted" };
-static const char *wm8971_lline_mux[] = {"Line", "NC", "NC", "PGA",
-	"Differential"};
-static const char *wm8971_rline_mux[] = {"Line", "Mic", "NC", "PGA",
-	"Differential"};
-static const char *wm8971_lpga_sel[] = {"Line", "NC", "NC", "Differential"};
-static const char *wm8971_rpga_sel[] = {"Line", "Mic", "NC", "Differential"};
-static const char *wm8971_adcpol[] = {"Normal", "L Invert", "R Invert",
-	"L + R Invert"};
+/* WM8971 / 3 Controls */
+static const char *wm8971_bass[]
+= { "Linear Control", "Adaptive Boost" };
+static const char *wm8971_bass_filter[]
+= { "130Hz @ 48kHz", "200Hz @ 48kHz" };
+static const char *wm8971_treble[]
+= { "8kHz", "4kHz" };
+static const char *wm8971_alc_func[]
+= { "Off", "Right", "Left", "Stereo" };
+static const char *wm8971_ng_type[]
+= { "Constant PGA Gain", "Mute ADC Output" };
+static const char *wm8971_deemp[]
+= { "None", "32kHz", "44.1kHz", "48kHz" };
+static const char *wm8971_mono_mux[]
+= {"Stereo", "Mono (Left)", "Mono (Right)", "Digital Mono"};
+
+/* WM8971-only */
+static const char *wm8971_dac_phase[]
+= { "Non Inverted", "Inverted" };
+static const char *wm8971_lline_mux[]
+= {"Line", "NC", "NC", "PGA", "Differential"};
+static const char *wm8971_rline_mux[]
+= {"Line", "Mic", "NC", "PGA", "Differential"};
+static const char *wm8971_lpga_sel[]
+= {"Line", "NC", "NC", "Differential"};
+static const char *wm8971_rpga_sel[]
+= {"Line", "Mic", "NC", "Differential"};
+static const char *wm8971_adcpol[]
+= {"Normal", "L Invert", "R Invert", "L + R Invert"};
+
+/* WM8973-only */
+static const char const *wm8973_line_mux[] = {"Line 1", "Line 2", "Line 3",
+					      "PGA", "Differential"};
+static const char const *wm8973_pga_sel[] = {"Line 1", "Line 2", "Line 3",
+					     "Differential"};
+static const char const *wm8973_out3[] = {"VREF", "ROUT1 + Vol", "MonoOut",
+					  "ROUT1"};
+static const char const *wm8973_diff_sel[] = {"Line 1", "Line 2"};
+static const char const *wm8973_adcpol[] = {"Normal", "L Invert", "R Invert",
+					    "L + R Invert"};
+static const char const *wm8973_3d_lc[] = { "200Hz", "500Hz" };
+static const char const *wm8973_3d_uc[] = { "2.2kHz", "1.5kHz" };
+static const char const *wm8973_3d_func[] = {"Capture", "Playback"};
+
+static const int wm8973_deemph_rates[] = { 0, 32000, 44100, 48000 };
+
+
 
 static const struct soc_enum wm8971_enum[] = {
 	SOC_ENUM_SINGLE(WM8971_BASS, 7, 2, wm8971_bass),	/* 0 */
@@ -136,24 +182,24 @@ static const struct snd_kcontrol_new wm8971_snd_controls[] = {
 	SOC_DOUBLE_R("Capture Switch", WM8971_LINVOL, WM8971_RINVOL, 7, 1, 1),
 
 	SOC_DOUBLE_R("Headphone Playback ZC Switch", WM8971_LOUT1V,
-		WM8971_ROUT1V, 7, 1, 0),
+		     WM8971_ROUT1V, 7, 1, 0),
 	SOC_DOUBLE_R("Speaker Playback ZC Switch", WM8971_LOUT2V,
-		WM8971_ROUT2V, 7, 1, 0),
+		     WM8971_ROUT2V, 7, 1, 0),
 	SOC_SINGLE("Mono Playback ZC Switch", WM8971_MOUTV, 7, 1, 0),
 
 	SOC_DOUBLE_R("PCM Volume", WM8971_LDAC, WM8971_RDAC, 0, 255, 0),
 
 	SOC_DOUBLE_R("Bypass Left Playback Volume", WM8971_LOUTM1,
-		WM8971_LOUTM2, 4, 7, 1),
+		     WM8971_LOUTM2, 4, 7, 1),
 	SOC_DOUBLE_R("Bypass Right Playback Volume", WM8971_ROUTM1,
-		WM8971_ROUTM2, 4, 7, 1),
+		     WM8971_ROUTM2, 4, 7, 1),
 	SOC_DOUBLE_R("Bypass Mono Playback Volume", WM8971_MOUTM1,
-		WM8971_MOUTM2, 4, 7, 1),
+		     WM8971_MOUTM2, 4, 7, 1),
 
 	SOC_DOUBLE_R("Headphone Playback Volume", WM8971_LOUT1V,
-		WM8971_ROUT1V, 0, 127, 0),
+		     WM8971_ROUT1V, 0, 127, 0),
 	SOC_DOUBLE_R("Speaker Playback Volume", WM8971_LOUT2V,
-		WM8971_ROUT2V, 0, 127, 0),
+		     WM8971_ROUT2V, 0, 127, 0),
 
 	SOC_ENUM("Bass Boost", wm8971_enum[0]),
 	SOC_ENUM("Bass Filter", wm8971_enum[1]),
@@ -188,6 +234,224 @@ static const struct snd_kcontrol_new wm8971_snd_controls[] = {
 	SOC_DOUBLE_R("Mic Boost", WM8971_LADCIN, WM8971_RADCIN, 4, 3, 0),
 };
 
+static int wm8973_set_deemph(struct snd_soc_codec *codec)
+{
+	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
+	int val = 0, i, best = 0;
+
+	/* If we're using deemphasis select the nearest available sample
+	 * rate.
+	*/
+	if (wm8971->deemph) {
+		best = 1;
+		for (i = 2; i < ARRAY_SIZE(wm8973_deemph_rates); i++) {
+			if (abs(wm8973_deemph_rates[i] - wm8971->playback_fs) <
+				abs(wm8973_deemph_rates[best] -
+						wm8971->playback_fs))
+				best = i;
+		}
+		val = best << 1;
+	}
+
+	dev_dbg(codec->dev, "Set deemphasis %d (%dHz)\n",
+		best, wm8973_deemph_rates[best]);
+
+	return snd_soc_update_bits(codec, WM8971_ADCDAC, 0x6, val);
+}
+
+static int wm8973_get_deemph(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.enumerated.item[0] = wm8971->deemph;
+
+	return 0;
+}
+
+static int wm8973_put_deemph(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
+	int deemph = ucontrol->value.enumerated.item[0];
+	int ret = 0;
+
+	if (deemph > 1)
+		return -EINVAL;
+
+	mutex_lock(&codec->mutex);
+	if (wm8971->deemph != deemph) {
+		wm8971->deemph = deemph;
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
+static const SOC_ENUM_SINGLE_DECL(bass_boost, WM8971_BASS, 7, wm8971_bass);
+static const SOC_ENUM_SINGLE_DECL(bass_filter, WM8971_BASS,
+				  6, wm8971_bass_filter);
+static const SOC_ENUM_SINGLE_DECL(treble_cutoff, WM8971_TREBLE,
+				  6, wm8971_treble);
+static const SOC_ENUM_SINGLE_DECL(lower_cutoff, WM8973_3D, 5, wm8973_3d_lc);
+static const SOC_ENUM_SINGLE_DECL(upper_cutoff, WM8973_3D, 6, wm8973_3d_uc);
+static const SOC_ENUM_SINGLE_DECL(mode, WM8973_3D, 7, wm8973_3d_func);
+static const SOC_ENUM_SINGLE_DECL(alc_capture_func, WM8971_ALC1,
+				  7, wm8971_alc_func);
+static const SOC_ENUM_SINGLE_DECL(alc_capture_ngtype, WM8971_NGATE,
+				  1, wm8971_ng_type);
+static const SOC_ENUM_SINGLE_DECL(left_line, WM8971_LOUTM1,
+				  0, wm8973_line_mux);
+static const SOC_ENUM_SINGLE_DECL(right_line, WM8971_ROUTM1,
+				  0, wm8973_line_mux);
+static const SOC_ENUM_SINGLE_DECL(left_pga, WM8971_LADCIN, 6, wm8973_pga_sel);
+static const SOC_ENUM_SINGLE_DECL(right_pga, WM8971_RADCIN, 6, wm8973_pga_sel);
+static const SOC_ENUM_SINGLE_DECL(out3, WM8971_ADCTL2, 7, wm8973_out3);
+static const SOC_ENUM_SINGLE_DECL(diffmux, WM8971_ADCIN, 8, wm8973_diff_sel);
+static const SOC_ENUM_SINGLE_DECL(capture_polarity, WM8971_ADCDAC,
+				  5, wm8973_adcpol);
+static const SOC_ENUM_SINGLE_DECL(monomux, WM8971_ADCIN, 6, wm8971_mono_mux);
+
+
+static const struct snd_kcontrol_new wm8973_snd_controls[] = {
+	/* Left & Right Input volume  */
+	SOC_DOUBLE_R_TLV("Capture Volume", WM8971_LINVOL, WM8971_RINVOL,
+			 0, 63, 0, in_vol),
+	SOC_DOUBLE_R("Capture ZC Switch", WM8971_LINVOL, WM8971_RINVOL,
+		     6, 1, 0),
+	SOC_DOUBLE_R("Capture Switch", WM8971_LINVOL, WM8971_RINVOL, 7, 1, 1),
+
+	/* LOUT1 & ROUT1 volume */
+	SOC_DOUBLE_R_TLV("Headphone Playback Volume", WM8971_LOUT1V,
+			 WM8971_ROUT1V, 0, 127, 0, out_vol),
+	SOC_DOUBLE_R("Headphone Playback ZC Switch", WM8971_LOUT1V,
+		     WM8971_ROUT1V, 7, 1, 0),
+
+	/* ADC & DAC control */
+	SOC_SINGLE("Capture Filter Switch", WM8971_ADCDAC, 0, 1, 1),
+	SOC_SINGLE_BOOL_EXT("Playback De-emphasis Switch", 0,
+			    wm8973_get_deemph, wm8973_put_deemph),
+	SOC_ENUM("Capture Polarity", capture_polarity),
+	SOC_SINGLE_TLV("Playback 6dB Attenuate", WM8971_ADCDAC,
+		       7, 1, 0, attenuate_6db),
+	SOC_SINGLE_TLV("Capture 6dB Attenuate", WM8971_ADCDAC,
+		       8, 1, 0, attenuate_6db),
+	/* ADCDAC Bit 4 - HPOR */
+
+	/* Left & Right Channel Digital Volume */
+	SOC_DOUBLE_R_TLV("DAC Volume", WM8971_LDAC, WM8971_RDAC,
+			 0, 255, 0, dac_vol),
+
+	/* Bass Control */
+	SOC_SINGLE_TLV("Bass Volume", WM8971_BASS, 0, 15, 1, tone_vol),
+	SOC_ENUM("Bass Boost", bass_boost),
+	SOC_ENUM("Bass Filter", bass_filter),
+
+	/* Treble Control */
+	SOC_SINGLE_TLV("Treble Volume", WM8971_TREBLE, 0, 15, 0, tone_vol),
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
+	SOC_SINGLE_TLV("ALC Capture Target Volume", WM8971_ALC1,
+		       0, 15, 0, alc_tar_vol),
+	SOC_SINGLE_TLV("ALC Capture Max Volume", WM8971_ALC1,
+		       4, 7, 0, alc_max_vol),
+	SOC_ENUM("ALC Capture Function", alc_capture_func),
+
+	SOC_SINGLE("ALC Capture Hold Time", WM8971_ALC2, 0, 15, 0),
+	SOC_SINGLE("ALC Capture ZC Switch", WM8971_ALC2, 7, 1, 0),
+
+	SOC_SINGLE("ALC Capture Attack Time", WM8971_ALC3, 0, 15, 0),
+	SOC_SINGLE("ALC Capture Decay Time", WM8971_ALC3, 4, 15, 0),
+
+	/* Noise Gate Control */
+	SOC_SINGLE("ALC Capture NG Switch", WM8971_NGATE, 0, 1, 0),
+	SOC_ENUM("ALC Capture NG Type", alc_capture_ngtype),
+	SOC_SINGLE("ALC Capture NG Threshold", WM8971_NGATE, 3, 31, 0),
+
+	/* Left & Right ADC Digital Volume*/
+	SOC_DOUBLE_R_TLV("ADC Volume", WM8971_LADC, WM8971_RADC,
+			 0, 255, 0, adc_vol),
+
+	/* Additional Control 1 */
+	SOC_SINGLE("ZC Timeout Switch", WM8971_ADCTL1, 0, 1, 0),
+	SOC_SINGLE("Playback Invert Switch", WM8971_ADCTL1, 1, 1, 0),
+	SOC_SINGLE("Analogue Bias", WM8971_ADCTL1, 6, 3, 0),
+	/* ADCTL1 Bit 2,3 - DATSEL */
+	/* ADCTL1 Bit 6,7 - VSEL */
+
+	/* Additional Control 2 */
+	SOC_SINGLE("Right Speaker Playback Invert Switch", WM8971_ADCTL2,
+		   4, 1, 0),
+	/* ADCTL2 Bit 2 - LRCM */
+	SOC_SINGLE("LRCLK Switch", WM8971_ADCTL2, 2, 1, 0),
+	/* ADCTL2 Bit 3 - TRI */
+	SOC_SINGLE("Headphone Switch POL", WM8971_ADCTL2, 5, 1, 0),
+	SOC_SINGLE("Headphone Switch EN", WM8971_ADCTL2, 6, 1, 0),
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
+	SOC_DOUBLE_R("Mic Boost", WM8971_LADCIN, WM8971_RADCIN, 4, 3, 0),
+
+	/* Left OUT Mixer Control */
+	SOC_DOUBLE_R_TLV("Bypass Left Playback Volume", WM8971_LOUTM1,
+			 WM8971_LOUTM2, 4, 7, 1, bypass_out_vol),
+
+	/* Right OUT Mixer Control */
+	SOC_DOUBLE_R_TLV("Bypass Right Playback Volume", WM8971_ROUTM1,
+			 WM8971_ROUTM2, 4, 7, 1, bypass_out_vol),
+
+	/*  Mono OUT Mixer Control */
+	SOC_DOUBLE_R_TLV("Bypass Mono Playback Volume", WM8971_MOUTM1,
+			 WM8971_MOUTM2, 4, 7, 1, bypass_out_vol),
+
+	/* LOUT2 & ROUT2 volume */
+	SOC_DOUBLE_R_TLV("Speaker Playback Volume", WM8971_LOUT2V,
+			 WM8971_ROUT2V, 0, 127, 0, out_vol),
+	SOC_DOUBLE_R("Speaker Playback ZC Switch", WM8971_LOUT2V,
+		     WM8971_ROUT2V, 7, 1, 0),
+
+	/* MONOOUT volume */
+	SOC_SINGLE_TLV("Mono Playback Volume", WM8971_MOUTV,
+		       0, 127, 0, out_vol),
+	SOC_SINGLE("Mono Playback ZC Switch", WM8971_MOUTV, 7, 1, 0),
+
+	SOC_SINGLE("Right Out 2", WM8971_PWR2, 3, 1, 0),
+	SOC_SINGLE("Left Out 2", WM8971_PWR2, 4, 1, 0),
+};
+
+
 /*
  * DAPM Controls
  */
@@ -219,18 +483,34 @@ SOC_DAPM_SINGLE("Right Bypass Switch", WM8971_MOUTM2, 7, 1, 0),
 /* Left Line Mux */
 static const struct snd_kcontrol_new wm8971_left_line_controls =
 SOC_DAPM_ENUM("Route", wm8971_enum[8]);
+static const struct snd_kcontrol_new wm8973_left_line_controls =
+SOC_DAPM_ENUM("Route", left_line);
 
 /* Right Line Mux */
 static const struct snd_kcontrol_new wm8971_right_line_controls =
 SOC_DAPM_ENUM("Route", wm8971_enum[9]);
+static const struct snd_kcontrol_new wm8973_right_line_controls =
+SOC_DAPM_ENUM("Route", right_line);
 
 /* Left PGA Mux */
 static const struct snd_kcontrol_new wm8971_left_pga_controls =
 SOC_DAPM_ENUM("Route", wm8971_enum[10]);
+static const struct snd_kcontrol_new wm8973_left_pga_controls =
+SOC_DAPM_ENUM("Route", left_pga);
 
 /* Right PGA Mux */
 static const struct snd_kcontrol_new wm8971_right_pga_controls =
 SOC_DAPM_ENUM("Route", wm8971_enum[11]);
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
 
 /* Mono ADC Mux */
 static const struct snd_kcontrol_new wm8971_monomux_controls =
@@ -238,14 +518,14 @@ SOC_DAPM_ENUM("Route", wm8971_enum[13]);
 
 static const struct snd_soc_dapm_widget wm8971_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
-		&wm8971_left_mixer_controls[0],
-		ARRAY_SIZE(wm8971_left_mixer_controls)),
+			   &wm8971_left_mixer_controls[0],
+			   ARRAY_SIZE(wm8971_left_mixer_controls)),
 	SND_SOC_DAPM_MIXER("Right Mixer", SND_SOC_NOPM, 0, 0,
-		&wm8971_right_mixer_controls[0],
-		ARRAY_SIZE(wm8971_right_mixer_controls)),
+			   &wm8971_right_mixer_controls[0],
+			   ARRAY_SIZE(wm8971_right_mixer_controls)),
 	SND_SOC_DAPM_MIXER("Mono Mixer", WM8971_PWR2, 2, 0,
-		&wm8971_mono_mixer_controls[0],
-		ARRAY_SIZE(wm8971_mono_mixer_controls)),
+			   &wm8971_mono_mixer_controls[0],
+			   ARRAY_SIZE(wm8971_mono_mixer_controls)),
 
 	SND_SOC_DAPM_PGA("Right Out 2", WM8971_PWR2, 3, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("Left Out 2", WM8971_PWR2, 4, 0, NULL, 0),
@@ -260,18 +540,18 @@ static const struct snd_soc_dapm_widget wm8971_dapm_widgets[] = {
 	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", WM8971_PWR1, 3, 0),
 
 	SND_SOC_DAPM_MUX("Left PGA Mux", WM8971_PWR1, 5, 0,
-		&wm8971_left_pga_controls),
+			 &wm8971_left_pga_controls),
 	SND_SOC_DAPM_MUX("Right PGA Mux", WM8971_PWR1, 4, 0,
-		&wm8971_right_pga_controls),
+			 &wm8971_right_pga_controls),
 	SND_SOC_DAPM_MUX("Left Line Mux", SND_SOC_NOPM, 0, 0,
-		&wm8971_left_line_controls),
+			 &wm8971_left_line_controls),
 	SND_SOC_DAPM_MUX("Right Line Mux", SND_SOC_NOPM, 0, 0,
-		&wm8971_right_line_controls),
+			 &wm8971_right_line_controls),
 
 	SND_SOC_DAPM_MUX("Left ADC Mux", SND_SOC_NOPM, 0, 0,
-		&wm8971_monomux_controls),
+			 &wm8971_monomux_controls),
 	SND_SOC_DAPM_MUX("Right ADC Mux", SND_SOC_NOPM, 0, 0,
-		&wm8971_monomux_controls),
+			 &wm8971_monomux_controls),
 
 	SND_SOC_DAPM_OUTPUT("LOUT1"),
 	SND_SOC_DAPM_OUTPUT("ROUT1"),
@@ -284,6 +564,69 @@ static const struct snd_soc_dapm_widget wm8971_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("MIC"),
 };
 
+static const struct snd_soc_dapm_widget wm8973_dapm_widgets[] = {
+	SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
+			   &wm8971_left_mixer_controls[0],
+			   ARRAY_SIZE(wm8971_left_mixer_controls)),
+
+	SND_SOC_DAPM_MIXER("Right Mixer", SND_SOC_NOPM, 0, 0,
+			   &wm8971_right_mixer_controls[0],
+			   ARRAY_SIZE(wm8971_right_mixer_controls)),
+
+	SND_SOC_DAPM_MIXER("Mono Mixer", WM8971_PWR2, 2, 0,
+			   &wm8971_mono_mixer_controls[0],
+			   ARRAY_SIZE(wm8971_mono_mixer_controls)),
+
+	SND_SOC_DAPM_PGA("Right Out 2", WM8971_PWR2, 3, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Left Out 2", WM8971_PWR2, 4, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Right Out 1", WM8971_PWR2, 5, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Left Out 1", WM8971_PWR2, 6, 0, NULL, 0),
+	SND_SOC_DAPM_DAC("Right DAC", "Right Playback", WM8971_PWR2, 7, 0),
+	SND_SOC_DAPM_DAC("Left DAC", "Left Playback", WM8971_PWR2, 8, 0),
+
+	SND_SOC_DAPM_MICBIAS("Mic Bias", WM8971_PWR1, 1, 0),
+	SND_SOC_DAPM_ADC("Right ADC", "Right Capture", WM8971_PWR1, 2, 0),
+	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", WM8971_PWR1, 3, 0),
+	SND_SOC_DAPM_MUX("Right PGA Mux", WM8971_PWR1, 4, 0,
+			 &wm8973_right_pga_controls),
+	SND_SOC_DAPM_MUX("Left PGA Mux", WM8971_PWR1, 5, 0,
+			 &wm8973_left_pga_controls),
+
+	SND_SOC_DAPM_MUX("Left Line Mux", SND_SOC_NOPM, 0, 0,
+			 &wm8973_left_line_controls),
+	SND_SOC_DAPM_MUX("Right Line Mux", SND_SOC_NOPM, 0, 0,
+			 &wm8973_right_line_controls),
+
+	SND_SOC_DAPM_MUX("Out3 Mux", SND_SOC_NOPM, 0, 0,
+			 &wm8973_out3_controls),
+	SND_SOC_DAPM_PGA("Out 3", WM8971_PWR2, 1, 0, NULL, 0),
+
+	SND_SOC_DAPM_PGA("Mono Out 1", WM8971_PWR2, 2, 0, NULL, 0),
+
+	SND_SOC_DAPM_MUX("Differential Mux", SND_SOC_NOPM, 0, 0,
+			 &wm8973_diffmux_controls),
+
+	SND_SOC_DAPM_MUX("Left ADC Mux", SND_SOC_NOPM, 0, 0,
+			 &wm8971_monomux_controls),
+	SND_SOC_DAPM_MUX("Right ADC Mux", SND_SOC_NOPM, 0, 0,
+			 &wm8971_monomux_controls),
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
 static const struct snd_soc_dapm_route wm8971_dapm_routes[] = {
 	/* left mixer */
 	{"Left Mixer", "Playback Switch", "Left DAC"},
@@ -361,6 +704,85 @@ static const struct snd_soc_dapm_route wm8971_dapm_routes[] = {
 	{"Right ADC", NULL, "Right ADC Mux"},
 };
 
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
+
 struct _coeff_div {
 	u32 mclk;
 	u32 rate;
@@ -430,26 +852,90 @@ static int get_coeff(int mclk, int rate)
 	return -EINVAL;
 }
 
+/* The set of rates we can generate from the above for each SYSCLK */
+static const unsigned int rates_12288[] = {
+	8000, 12000, 16000, 24000, 32000, 48000, 96000
+};
+
+static struct snd_pcm_hw_constraint_list constraints_12288 = {
+	.count	= ARRAY_SIZE(rates_12288),
+	.list	= rates_12288,
+};
+
+static const unsigned int rates_112896[] = {
+	8000, 11025, 22050, 44100, 88200
+};
+
+static struct snd_pcm_hw_constraint_list constraints_112896 = {
+	.count	= ARRAY_SIZE(rates_112896),
+	.list	= rates_112896,
+};
+
+static const unsigned int rates_18432[] = {
+	8000, 12000, 16000, 24000, 32000, 48000, 96000
+};
+
+static struct snd_pcm_hw_constraint_list constraints_18432 = {
+	.count  = ARRAY_SIZE(rates_18432),
+	.list   = rates_18432,
+};
+
+static const unsigned int rates_169344[] = {
+	8000, 11025, 22050, 44100, 88200
+};
+
+static struct snd_pcm_hw_constraint_list constraints_169344 = {
+	.count  = ARRAY_SIZE(rates_169344),
+	.list   = rates_169344,
+};
+
+static const unsigned int rates_12[] = {
+	8000, 11025, 12000, 16000, 22050, 2400, 32000, 41100, 48000,
+	48000, 88235, 96000,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_12 = {
+	.count	= ARRAY_SIZE(rates_12),
+	.list	= rates_12,
+};
+
 static int wm8971_set_dai_sysclk(struct snd_soc_dai *codec_dai,
-		int clk_id, unsigned int freq, int dir)
+				 int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
 
 	switch (freq) {
-	case 11289600:
-	case 12000000:
 	case 12288000:
-	case 16934400:
+	case 24576000:
+		wm8971->sysclk_constraints = &constraints_12288;
+		break;
+	case 11289600:
+	case 22579200:
+		wm8971->sysclk_constraints = &constraints_112896;
+		break;
 	case 18432000:
-		wm8971->sysclk = freq;
-		return 0;
+		wm8971->sysclk_constraints = &constraints_18432;
+		break;
+	case 16934400:
+	case 33868800:
+		wm8971->sysclk_constraints = &constraints_169344;
+		break;
+	case 12000000:
+	case 24000000:
+		wm8971->sysclk_constraints = &constraints_12;
+		break;
+	default:
+		return -EINVAL;
 	}
-	return -EINVAL;
+
+	wm8971->sysclk = freq;
+
+	return 0;
 }
 
 static int wm8971_set_dai_fmt(struct snd_soc_dai *codec_dai,
-		unsigned int fmt)
+			      unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	u16 iface = 0;
@@ -507,8 +993,8 @@ static int wm8971_set_dai_fmt(struct snd_soc_dai *codec_dai,
 }
 
 static int wm8971_pcm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params,
-	struct snd_soc_dai *dai)
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
@@ -516,6 +1002,8 @@ static int wm8971_pcm_hw_params(struct snd_pcm_substream *substream,
 	u16 srate = snd_soc_read(codec, WM8971_SRATE) & 0x1c0;
 	int coeff = get_coeff(wm8971->sysclk, params_rate(params));
 
+	wm8971->playback_fs = params_rate(params);
+
 	/* bit size */
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
@@ -531,6 +1019,8 @@ static int wm8971_pcm_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
+	wm8973_set_deemph(codec);
+
 	/* set iface & srate */
 	snd_soc_write(codec, WM8971_IFACE, iface);
 	if (coeff >= 0)
@@ -553,23 +1043,31 @@ static int wm8971_mute(struct snd_soc_dai *dai, int mute)
 }
 
 static int wm8971_set_bias_level(struct snd_soc_codec *codec,
-	enum snd_soc_bias_level level)
+				 enum snd_soc_bias_level level)
 {
-	u16 pwr_reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
+	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
+	static const u16 mask[][2] = {
+		[VARIANT_WM8971] = { 0x00c1, 0x0140 },
+		[VARIANT_WM8973] = { 0x00c2, 0x0141 },
+	};
+	u16 pwr_reg = snd_soc_read(codec, WM8971_PWR1) &
+						charge[wm8971->variant][0];
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		/* set vmid to 50k and unmute dac */
-		snd_soc_write(codec, WM8971_PWR1, pwr_reg | 0x00c1);
+		snd_soc_write(codec, WM8971_PWR1, pwr_reg |
+						  mask[wm8971->variant][0]);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
-			snd_soc_cache_sync(codec);
+			regcache_sync(wm8971->regmap);
 
 		/* mute dac and set vmid to 500k, enable VREF */
-		snd_soc_write(codec, WM8971_PWR1, pwr_reg | 0x0140);
+		snd_soc_write(codec, WM8971_PWR1, pwr_reg |
+						  mask[wm8971->variant][1]);
 		break;
 	case SND_SOC_BIAS_OFF:
 		snd_soc_write(codec, WM8971_PWR1, 0x0001);
@@ -580,8 +1078,9 @@ static int wm8971_set_bias_level(struct snd_soc_codec *codec,
 }
 
 #define WM8971_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
-		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 | \
-		SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
+		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | \
+		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 | \
+		SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
 
 #define WM8971_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 	SNDRV_PCM_FMTBIT_S24_LE)
@@ -593,74 +1092,81 @@ static const struct snd_soc_dai_ops wm8971_dai_ops = {
 	.set_sysclk	= wm8971_set_dai_sysclk,
 };
 
-static struct snd_soc_dai_driver wm8971_dai = {
-	.name = "wm8971-hifi",
-	.playback = {
-		.stream_name = "Playback",
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = WM8971_RATES,
-		.formats = WM8971_FORMATS,},
-	.capture = {
-		.stream_name = "Capture",
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = WM8971_RATES,
-		.formats = WM8971_FORMATS,},
-	.ops = &wm8971_dai_ops,
-};
-
-static void wm8971_work(struct work_struct *work)
-{
-	struct snd_soc_dapm_context *dapm =
-		container_of(work, struct snd_soc_dapm_context,
-			     delayed_work.work);
-	struct snd_soc_codec *codec = dapm->codec;
-	wm8971_set_bias_level(codec, codec->dapm.bias_level);
-}
+static struct snd_soc_dai_driver wm8971_dai[] = {
+	{
+		.name = "wm8971-hifi-playback",
+		.playback = {
+			.stream_name = "Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = WM8971_RATES,
+			.formats = WM8971_FORMATS,
+		},
+		.ops = &wm8971_dai_ops,
+	}, {
+		.name = "wm8971-hifi-capture",
+		.capture = {
+			.stream_name = "Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = WM8971_RATES,
+			.formats = WM8971_FORMATS,
+		},
+		.ops = &wm8971_dai_ops,
+	},
+};
 
 static int wm8971_suspend(struct snd_soc_codec *codec)
 {
+	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
+
 	wm8971_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	regcache_mark_dirty(wm8971->regmap);
+
 	return 0;
 }
 
 static int wm8971_resume(struct snd_soc_codec *codec)
 {
+	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
 	u16 reg;
 
 	wm8971_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* charge wm8971 caps */
-	if (codec->dapm.suspend_bias_level == SND_SOC_BIAS_ON) {
-		reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
-		snd_soc_write(codec, WM8971_PWR1, reg | 0x01c0);
-		codec->dapm.bias_level = SND_SOC_BIAS_ON;
-		queue_delayed_work(wm8971_workq, &codec->dapm.delayed_work,
-			msecs_to_jiffies(1000));
-	}
+	if (codec->dapm.suspend_bias_level != SND_SOC_BIAS_ON)
+		return 0;
+
+	reg = snd_soc_read(codec, WM8971_PWR1) & charge[wm8971->variant][0];
+	snd_soc_write(codec, WM8971_PWR1, reg | charge[wm8971->variant][1]);
+	codec->dapm.bias_level = SND_SOC_BIAS_ON;
 
 	return 0;
 }
 
 static int wm8971_probe(struct snd_soc_codec *codec)
 {
+	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
+	const u32 *p;
 	int ret = 0;
 	u16 reg;
 
-	INIT_DELAYED_WORK(&codec->dapm.delayed_work, wm8971_work);
-	wm8971_workq = create_workqueue("wm8971");
-	if (wm8971_workq == NULL)
-		return -ENOMEM;
+	codec->control_data = wm8971->regmap;
 
 	wm8971_reset(codec);
+	if (codec->dev->of_node) {
+		p = of_get_property(codec->dev->of_node, "mclk-div", NULL);
+		if (p)
+			wm8971->mclk_div = be32_to_cpu(*p);
+	}
+	/* Master Clock Divide by 2 (0 = not div, 1 = div by 2) */
+	if (wm8971->mclk_div)
+		snd_soc_update_bits(codec, WM8971_SRATE, 0x0040, 0x0040);
 
 	/* charge output caps - set vmid to 5k for quick power up */
-	reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
-	snd_soc_write(codec, WM8971_PWR1, reg | 0x01c0);
+	reg = snd_soc_read(codec, WM8971_PWR1) & charge[wm8971->variant][0];
+	snd_soc_write(codec, WM8971_PWR1, reg | charge[wm8971->variant][1]);
 	codec->dapm.bias_level = SND_SOC_BIAS_STANDBY;
-	queue_delayed_work(wm8971_workq, &codec->dapm.delayed_work,
-		msecs_to_jiffies(1000));
 
 	/* set the update bits */
 	snd_soc_update_bits(codec, WM8971_LDAC, 0x0100, 0x0100);
@@ -681,24 +1187,47 @@ static int wm8971_remove(struct snd_soc_codec *codec)
 {
 	wm8971_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
-	if (wm8971_workq)
-		destroy_workqueue(wm8971_workq);
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8971 = {
-	.probe =	wm8971_probe,
-	.remove =	wm8971_remove,
-	.suspend =	wm8971_suspend,
-	.resume =	wm8971_resume,
-	.set_bias_level = wm8971_set_bias_level,
+struct regmap *wm8973_get_regmap(struct device *dev)
+{
+	struct wm8971_priv *priv = dev_get_drvdata(dev);
+
+	return priv->regmap;
+}
 
-	.controls = wm8971_snd_controls,
-	.num_controls = ARRAY_SIZE(wm8971_snd_controls),
-	.dapm_widgets = wm8971_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(wm8971_dapm_widgets),
-	.dapm_routes = wm8971_dapm_routes,
-	.num_dapm_routes = ARRAY_SIZE(wm8971_dapm_routes),
+static struct snd_soc_codec_driver soc_codec_dev_wm8971[] = {
+	[VARIANT_WM8971] = {
+		.probe =	wm8971_probe,
+		.remove =	wm8971_remove,
+		.suspend =	wm8971_suspend,
+		.resume =	wm8971_resume,
+		.set_bias_level = wm8971_set_bias_level,
+		.get_regmap =   wm8973_get_regmap,
+
+		.controls = wm8971_snd_controls,
+		.num_controls = ARRAY_SIZE(wm8971_snd_controls),
+		.dapm_widgets = wm8971_dapm_widgets,
+		.num_dapm_widgets = ARRAY_SIZE(wm8971_dapm_widgets),
+		.dapm_routes = wm8971_dapm_routes,
+		.num_dapm_routes = ARRAY_SIZE(wm8971_dapm_routes),
+	},
+	[VARIANT_WM8973] = {
+		.probe =	wm8971_probe,
+		.remove =	wm8971_remove,
+		.suspend =	wm8971_suspend,
+		.resume =	wm8971_resume,
+		.set_bias_level = wm8971_set_bias_level,
+		.get_regmap =   wm8973_get_regmap,
+
+		.controls = wm8973_snd_controls,
+		.num_controls = ARRAY_SIZE(wm8973_snd_controls),
+		.dapm_widgets = wm8973_dapm_widgets,
+		.num_dapm_widgets = ARRAY_SIZE(wm8973_dapm_widgets),
+		.dapm_routes = wm8973_dapm_routes,
+		.num_dapm_routes = ARRAY_SIZE(wm8973_dapm_routes),
+	}
 };
 
 static const struct regmap_config wm8971_regmap = {
@@ -715,7 +1244,6 @@ static int wm8971_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct wm8971_priv *wm8971;
-	struct regmap *regmap;
 	int ret;
 
 	wm8971 = devm_kzalloc(&i2c->dev, sizeof(struct wm8971_priv),
@@ -723,14 +1251,17 @@ static int wm8971_i2c_probe(struct i2c_client *i2c,
 	if (wm8971 == NULL)
 		return -ENOMEM;
 
-	regmap = devm_regmap_init_i2c(i2c, &wm8971_regmap);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	wm8971->variant = (int)id->driver_data;
+
+	wm8971->regmap = devm_regmap_init_i2c(i2c, &wm8971_regmap);
+	if (IS_ERR(wm8971->regmap))
+		return PTR_ERR(wm8971->regmap);
 
 	i2c_set_clientdata(i2c, wm8971);
 
 	ret = snd_soc_register_codec(&i2c->dev,
-			&soc_codec_dev_wm8971, &wm8971_dai, 1);
+				     &soc_codec_dev_wm8971[wm8971->variant],
+				     wm8971_dai, ARRAY_SIZE(wm8971_dai));
 
 	return ret;
 }
@@ -742,15 +1273,23 @@ static int wm8971_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id wm8971_i2c_id[] = {
-	{ "wm8971", 0 },
+	{ "wm8971", VARIANT_WM8971 },
+	{ "wm8973", VARIANT_WM8973 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, wm8971_i2c_id);
 
+static const struct of_device_id wm897x_dt_ids[] = {
+	{ .compatible = "wlf,wm8971" },
+	{ .compatible = "wlf,wm8973" },
+	{ /* sentinel */ }
+};
+
 static struct i2c_driver wm8971_i2c_driver = {
 	.driver = {
 		.name = "wm8971",
 		.owner = THIS_MODULE,
+		.of_match_table = wm897x_dt_ids,
 	},
 	.probe =    wm8971_i2c_probe,
 	.remove =   wm8971_i2c_remove,
@@ -762,3 +1301,5 @@ module_i2c_driver(wm8971_i2c_driver);
 MODULE_DESCRIPTION("ASoC WM8971 driver");
 MODULE_AUTHOR("Lab126");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("*wm8971*");
+MODULE_ALIAS("*wm8973*");
diff --git a/sound/soc/codecs/wm8971.h b/sound/soc/codecs/wm8971.h
index f31c38f..aeab04a 100644
--- a/sound/soc/codecs/wm8971.h
+++ b/sound/soc/codecs/wm8971.h
@@ -22,21 +22,22 @@
 #define WM8971_ADCDAC	0x05
 #define WM8971_IFACE	0x07
 #define WM8971_SRATE	0x08
-#define WM8971_LDAC		0x0a
-#define WM8971_RDAC		0x0b
-#define WM8971_BASS		0x0c
+#define WM8971_LDAC	0x0a
+#define WM8971_RDAC	0x0b
+#define WM8971_BASS	0x0c
 #define WM8971_TREBLE	0x0d
 #define WM8971_RESET	0x0f
-#define WM8971_ALC1		0x11
-#define	WM8971_ALC2		0x12
-#define	WM8971_ALC3		0x13
+#define WM8973_3D       0x10
+#define WM8971_ALC1	0x11
+#define	WM8971_ALC2	0x12
+#define	WM8971_ALC3	0x13
 #define WM8971_NGATE	0x14
-#define WM8971_LADC		0x15
-#define WM8971_RADC		0x16
+#define WM8971_LADC	0x15
+#define WM8971_RADC	0x16
 #define	WM8971_ADCTL1	0x17
 #define	WM8971_ADCTL2	0x18
-#define WM8971_PWR1		0x19
-#define WM8971_PWR2		0x1a
+#define WM8971_PWR1	0x19
+#define WM8971_PWR2	0x1a
 #define	WM8971_ADCTL3	0x1b
 #define WM8971_ADCIN	0x1f
 #define	WM8971_LADCIN	0x20
-- 
1.7.9.5
