From: Xavier Hsu <xavier.hsu@linaro.org>
Subject: [PATCHv3 9/9] ASOC add WM8973 support to WM8971
Date: Tue,  2 Sep 2014 11:27:50 +0800
Message-ID: <1409628470-13059-9-git-send-email-xavier.hsu@linaro.org>
References: <1409628470-13059-1-git-send-email-xavier.hsu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Kraken (unknown [124.219.7.128])
 by alsa0.perex.cz (Postfix) with ESMTP id A9FC526520A
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 05:28:01 +0200 (CEST)
In-Reply-To: <1409628470-13059-1-git-send-email-xavier.hsu@linaro.org>
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
Cc: Xavier Hsu <xavier.hsu@linaro.org>, Andy Green <andy.green@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds support for the wm8973 codec.

Any comments about improving the patch are welcome.
Thanks.

Signed-off-by: Xavier Hsu <xavier.hsu@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---
 Documentation/devicetree/bindings/sound/wm8971.txt |   26 ++
 sound/soc/codecs/wm8971.c                          |  326 +++++++++++++++-----
 sound/soc/codecs/wm8971.h                          |   21 +-
 3 files changed, 294 insertions(+), 79 deletions(-)
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
index 6d34565..2893fc6 100755
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -7,7 +7,7 @@
  *
  * Based on wm8753.c by Liam Girdwood
  *
- * WM8971 Improve Copyright (C) 2014 Linaro, Ltd
+ * WM8971 Improve & Wm8973 Support Copyright (C) 2014 Linaro, Ltd
  * Author: Xavier Hsu <xavier.hsu@linaro.org>
  *         Andy Green <andy.green@linaro.org>
  *
@@ -34,15 +34,27 @@
 
 #include "wm8971.h"
 
+enum variant {
+	VARIANT_WM8971,
+	VARIANT_WM8973
+};
+
 #define	WM8971_REG_COUNT	43
 
 /* codec private data */
 struct wm8971_priv {
 	struct regmap *regmap;
+	enum variant variant;
 	unsigned int sysclk;
 	struct snd_pcm_hw_constraint_list *sysclk_constraints;
 	int playback_fs;
 	bool deemph;
+	int mclk_div;
+};
+
+static const u16 charge[][2] = {
+	[VARIANT_WM8971] = { 0xfe3e, 0x01c0 },
+	[VARIANT_WM8973] = { 0x003e, 0x01f0 },
 };
 
 /*
@@ -98,7 +110,7 @@ static const struct reg_default wm8971_reg_defaults[] = {
 
 #define wm8971_reset(c)	snd_soc_write(c, WM8971_RESET, 0)
 
-/* WM8971 Controls */
+/* WM8971 / 3 Controls */
 static const char const *wm8971_bass[] = {"Linear Control", "Adaptive Boost"};
 static const char const *wm8971_bass_filter[] = {"130Hz @ 48kHz",
 						 "200Hz @ 48kHz"};
@@ -110,19 +122,33 @@ static const char const *wm8971_ng_type[] = {"Constant PGA Gain",
 static const char const *wm8971_mono_mux[] = {"Stereo", "Mono (Left)",
 					      "Mono (Right)", "Digital Mono"};
 static const char const *wm8971_dac_phase[] = {"Non Inverted", "Inverted"};
-static const char const *wm8971_lline_mux[] = {"Line", "NC", "NC",
-					       "PGA", "Differential"};
-static const char const *wm8971_rline_mux[] = {"Line", "Mic", "NC",
-					       "PGA", "Differential"};
-static const char const *wm8971_lpga_sel[] = {"Line", "NC", "NC",
-					      "Differential"};
-static const char const *wm8971_rpga_sel[] = {"Line", "Mic", "NC",
-					      "Differential"};
 static const char const *wm8971_adcpol[] = {"Normal", "L Invert",
 					    "R Invert", "L + R Invert"};
 static const char const *wm8971_deemp[] = {"None", "32kHz",
 					   "44.1kHz", "48kHz"};
 
+/* WM8971-only*/
+static const char const *wm8971_lline_mux[] = {"Line 1", "NC", "NC",
+					       "PGA", "Differential"};
+static const char const *wm8971_rline_mux[] = {"Line 1", "Mic", "NC",
+					       "PGA", "Differential"};
+static const char const *wm8971_lpga_sel[] = {"Line 1", "NC", "NC",
+					      "Differential"};
+static const char const *wm8971_rpga_sel[] = {"Line 1", "Mic", "NC",
+					      "Differential"};
+
+/* WM8973-only*/
+static const char const *wm8973_line_mux[] = {"Line 1", "Line 2", "Line 3",
+					      "PGA", "Differential"};
+static const char const *wm8973_pga_sel[] = {"Line 1", "Line 2", "Line 3",
+					     "Differential"};
+static const char const *wm8973_out3[] = {"VREF", "ROUT1 + Vol", "MonoOut",
+					  "ROUT1"};
+static const char const *wm8973_diff_sel[] = {"Line 1", "Line 2"};
+static const char const *wm8973_3d_lc[] = { "200Hz", "500Hz" };
+static const char const *wm8973_3d_uc[] = { "2.2kHz", "1.5kHz" };
+static const char const *wm8973_3d_func[] = {"Capture", "Playback"};
+
 static int wm8971_set_deemph(struct snd_soc_codec *codec)
 {
 	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
@@ -182,6 +208,7 @@ static int wm8971_put_deemph(struct snd_kcontrol *kcontrol,
 	return ret;
 }
 
+/* WM8971 / 3 Controls */
 static const SOC_ENUM_SINGLE_DECL(bass_boost, WM8971_BASS, 7, wm8971_bass);
 static const SOC_ENUM_SINGLE_DECL(bass_filter, WM8971_BASS,
 				  6, wm8971_bass_filter);
@@ -195,17 +222,39 @@ static const SOC_ENUM_SINGLE_DECL(dac_mono_mix, WM8971_ADCTL1,
 				  4, wm8971_mono_mux);
 static const SOC_ENUM_SINGLE_DECL(dac_phase_inv, WM8971_ADCTL1,
 				  1, wm8971_dac_phase);
-static const SOC_ENUM_SINGLE_DECL(left_line, WM8971_LOUTM1,
-				  0, wm8971_lline_mux);
-static const SOC_ENUM_SINGLE_DECL(right_line, WM8971_ROUTM1,
-				  0, wm8971_rline_mux);
-static const SOC_ENUM_SINGLE_DECL(left_pga, WM8971_LADCIN, 6, wm8971_lpga_sel);
-static const SOC_ENUM_SINGLE_DECL(right_pga, WM8971_RADCIN,
-				  6, wm8971_rpga_sel);
 static const SOC_ENUM_SINGLE_DECL(capture_polarity, WM8971_ADCDAC,
 				  5, wm8971_adcpol);
 static const SOC_ENUM_SINGLE_DECL(monomux, WM8971_ADCIN, 6, wm8971_mono_mux);
 
+/* WM8971-only */
+static const SOC_ENUM_SINGLE_DECL(wm8971_left_line, WM8971_LOUTM1,
+				  0, wm8971_lline_mux);
+static const SOC_ENUM_SINGLE_DECL(wm8971_right_line, WM8971_ROUTM1,
+				  0, wm8971_rline_mux);
+static const SOC_ENUM_SINGLE_DECL(wm8971_left_pga, WM8971_LADCIN,
+				  6, wm8971_lpga_sel);
+static const SOC_ENUM_SINGLE_DECL(wm8971_right_pga, WM8971_RADCIN,
+				  6, wm8971_rpga_sel);
+
+/* WM8973-only */
+static const SOC_ENUM_SINGLE_DECL(wm8973_left_line, WM8971_LOUTM1,
+				  0, wm8973_line_mux);
+static const SOC_ENUM_SINGLE_DECL(wm8973_right_line, WM8971_ROUTM1,
+				  0, wm8973_line_mux);
+static const SOC_ENUM_SINGLE_DECL(wm8973_left_pga, WM8971_LADCIN,
+				  6, wm8973_pga_sel);
+static const SOC_ENUM_SINGLE_DECL(wm8973_right_pga, WM8971_RADCIN,
+				  6, wm8973_pga_sel);
+static const SOC_ENUM_SINGLE_DECL(wm8973_out3_control, WM8971_ADCTL2,
+				  7, wm8973_out3);
+static const SOC_ENUM_SINGLE_DECL(wm8973_diffmux, WM8971_ADCIN,
+				  8, wm8973_diff_sel);
+static const SOC_ENUM_SINGLE_DECL(wm8973_lower_cutoff, WM8973_3D,
+				  5, wm8973_3d_lc);
+static const SOC_ENUM_SINGLE_DECL(wm8973_upper_cutoff, WM8973_3D,
+				  6, wm8973_3d_uc);
+static const SOC_ENUM_SINGLE_DECL(wm8973_mode, WM8973_3D, 7, wm8973_3d_func);
+
 static const DECLARE_TLV_DB_SCALE(in_vol, -1725, 75, 0);
 static const DECLARE_TLV_DB_SCALE(out_vol, -6700, 91, 0);
 static const DECLARE_TLV_DB_SCALE(attenuate_6db, -600, 600, 0);
@@ -292,6 +341,15 @@ static const struct snd_kcontrol_new wm8971_snd_controls[] = {
 	SOC_SINGLE("Headphone Switch EN", WM8971_ADCTL2, 6, 1, 0),
 };
 
+static const struct snd_kcontrol_new wm8973_snd_controls[] = {
+	/* 3D Control */
+	SOC_SINGLE("3D Switch", WM8973_3D, 0, 1, 0),
+	SOC_SINGLE("3D Volume", WM8973_3D, 1, 15, 0),
+	SOC_ENUM("3D Lower Cut-off", wm8973_lower_cutoff),
+	SOC_ENUM("3D Upper Cut-off", wm8973_upper_cutoff),
+	SOC_ENUM("3D Mode", wm8973_mode),
+};
+
 /*
  * DAPM Controls
  */
@@ -322,25 +380,41 @@ SOC_DAPM_SINGLE("Right Bypass Switch", WM8971_MOUTM2, 7, 1, 0),
 
 /* Left Line Mux */
 static const struct snd_kcontrol_new wm8971_left_line_controls =
-SOC_DAPM_ENUM("Route", left_line);
+SOC_DAPM_ENUM("Route", wm8971_left_line);
+static const struct snd_kcontrol_new wm8973_left_line_controls =
+SOC_DAPM_ENUM("Route", wm8973_left_line);
 
 /* Right Line Mux */
 static const struct snd_kcontrol_new wm8971_right_line_controls =
-SOC_DAPM_ENUM("Route", right_line);
+SOC_DAPM_ENUM("Route", wm8971_right_line);
+static const struct snd_kcontrol_new wm8973_right_line_controls =
+SOC_DAPM_ENUM("Route", wm8973_right_line);
 
 /* Left PGA Mux */
 static const struct snd_kcontrol_new wm8971_left_pga_controls =
-SOC_DAPM_ENUM("Route", left_pga);
+SOC_DAPM_ENUM("Route", wm8971_left_pga);
+static const struct snd_kcontrol_new wm8973_left_pga_controls =
+SOC_DAPM_ENUM("Route", wm8973_left_pga);
 
 /* Right PGA Mux */
 static const struct snd_kcontrol_new wm8971_right_pga_controls =
-SOC_DAPM_ENUM("Route", right_pga);
+SOC_DAPM_ENUM("Route", wm8971_right_pga);
+static const struct snd_kcontrol_new wm8973_right_pga_controls =
+SOC_DAPM_ENUM("Route", wm8973_right_pga);
+
+/* Out 3 Mux */
+static const struct snd_kcontrol_new wm8973_out3_controls =
+SOC_DAPM_ENUM("Route", wm8973_out3_control);
+
+/* Differential Mux */
+static const struct snd_kcontrol_new wm8973_diffmux_controls =
+SOC_DAPM_ENUM("Route", wm8973_diffmux);
 
 /* Mono ADC Mux */
 static const struct snd_kcontrol_new wm8971_monomux_controls =
 SOC_DAPM_ENUM("Route", monomux);
 
-static const struct snd_soc_dapm_widget wm8971_dapm_widgets[] = {
+static const struct snd_soc_dapm_widget wm897x_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
 			   &wm8971_left_mixer_controls[0],
 			   ARRAY_SIZE(wm8971_left_mixer_controls)),
@@ -363,15 +437,6 @@ static const struct snd_soc_dapm_widget wm8971_dapm_widgets[] = {
 	SND_SOC_DAPM_ADC("Right ADC", "Right Capture", WM8971_PWR1, 2, 0),
 	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", WM8971_PWR1, 3, 0),
 
-	SND_SOC_DAPM_MUX("Left PGA Mux", WM8971_PWR1, 5, 0,
-			 &wm8971_left_pga_controls),
-	SND_SOC_DAPM_MUX("Right PGA Mux", WM8971_PWR1, 4, 0,
-			 &wm8971_right_pga_controls),
-	SND_SOC_DAPM_MUX("Left Line Mux", SND_SOC_NOPM, 0, 0,
-			 &wm8971_left_line_controls),
-	SND_SOC_DAPM_MUX("Right Line Mux", SND_SOC_NOPM, 0, 0,
-			 &wm8971_right_line_controls),
-
 	SND_SOC_DAPM_MUX("Left ADC Mux", SND_SOC_NOPM, 0, 0,
 			 &wm8971_monomux_controls),
 	SND_SOC_DAPM_MUX("Right ADC Mux", SND_SOC_NOPM, 0, 0,
@@ -388,6 +453,41 @@ static const struct snd_soc_dapm_widget wm8971_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("MIC"),
 };
 
+static const struct snd_soc_dapm_widget wm8971_dapm_widgets[] = {
+	SND_SOC_DAPM_MUX("Left Line Mux", SND_SOC_NOPM, 0, 0,
+			 &wm8971_left_line_controls),
+	SND_SOC_DAPM_MUX("Right Line Mux", SND_SOC_NOPM, 0, 0,
+			 &wm8971_right_line_controls),
+	SND_SOC_DAPM_MUX("Left PGA Mux", WM8971_PWR1, 5, 0,
+			 &wm8971_left_pga_controls),
+	SND_SOC_DAPM_MUX("Right PGA Mux", WM8971_PWR1, 4, 0,
+			 &wm8971_right_pga_controls),
+};
+
+static const struct snd_soc_dapm_widget wm8973_dapm_widgets[] = {
+	SND_SOC_DAPM_MUX("Left Line Mux", SND_SOC_NOPM, 0, 0,
+			 &wm8973_left_line_controls),
+	SND_SOC_DAPM_MUX("Right Line Mux", SND_SOC_NOPM, 0, 0,
+			 &wm8973_right_line_controls),
+	SND_SOC_DAPM_MUX("Right PGA Mux", WM8971_PWR1, 4, 0,
+			 &wm8973_right_pga_controls),
+	SND_SOC_DAPM_MUX("Left PGA Mux", WM8971_PWR1, 5, 0,
+			 &wm8973_left_pga_controls),
+	SND_SOC_DAPM_MUX("Out3 Mux", SND_SOC_NOPM, 0, 0,
+			 &wm8973_out3_controls),
+	SND_SOC_DAPM_PGA("Out 3", WM8971_PWR2, 1, 0, NULL, 0),
+	SND_SOC_DAPM_MUX("Differential Mux", SND_SOC_NOPM, 0, 0,
+			 &wm8973_diffmux_controls),
+
+	SND_SOC_DAPM_OUTPUT("OUT3"),
+	SND_SOC_DAPM_OUTPUT("VREF"),
+
+	SND_SOC_DAPM_INPUT("LINPUT2"),
+	SND_SOC_DAPM_INPUT("LINPUT3"),
+	SND_SOC_DAPM_INPUT("RINPUT2"),
+	SND_SOC_DAPM_INPUT("RINPUT3"),
+};
+
 static const struct snd_soc_dapm_route wm8971_dapm_routes[] = {
 	/* left mixer */
 	{"Left Mixer", "Playback Switch", "Left DAC"},
@@ -428,27 +528,27 @@ static const struct snd_soc_dapm_route wm8971_dapm_routes[] = {
 	{"MONO1", NULL, "Mono Out"},
 
 	/* Left Line Mux */
-	{"Left Line Mux", "Line", "LINPUT1"},
+	{"Left Line Mux", "Line 1", "LINPUT1"},
 	{"Left Line Mux", "PGA", "Left PGA Mux"},
 	{"Left Line Mux", "Differential", "Differential Mux"},
 
 	/* Right Line Mux */
-	{"Right Line Mux", "Line", "RINPUT1"},
+	{"Right Line Mux", "Line 1", "RINPUT1"},
 	{"Right Line Mux", "Mic", "MIC"},
 	{"Right Line Mux", "PGA", "Right PGA Mux"},
 	{"Right Line Mux", "Differential", "Differential Mux"},
 
 	/* Left PGA Mux */
-	{"Left PGA Mux", "Line", "LINPUT1"},
+	{"Left PGA Mux", "Line 1", "LINPUT1"},
 	{"Left PGA Mux", "Differential", "Differential Mux"},
 
 	/* Right PGA Mux */
-	{"Right PGA Mux", "Line", "RINPUT1"},
+	{"Right PGA Mux", "Line 1", "RINPUT1"},
 	{"Right PGA Mux", "Differential", "Differential Mux"},
 
 	/* Differential Mux */
-	{"Differential Mux", "Line", "LINPUT1"},
-	{"Differential Mux", "Line", "RINPUT1"},
+	{"Differential Mux", "Line 1", "LINPUT1"},
+	{"Differential Mux", "Line 1", "RINPUT1"},
 
 	/* Left ADC Mux */
 	{"Left ADC Mux", "Stereo", "Left PGA Mux"},
@@ -465,6 +565,62 @@ static const struct snd_soc_dapm_route wm8971_dapm_routes[] = {
 	{"Right ADC", NULL, "Right ADC Mux"},
 };
 
+static const struct snd_soc_dapm_route wm8973_dapm_routes[] = {
+	{"Out3 Mux", "VREF", "VREF"},
+	{"Out3 Mux", "ROUT1 + Vol", "ROUT1"},
+	{"Out3 Mux", "ROUT1", "Right Mixer"},
+	{"Out3 Mux", "MonoOut", "MONO1"},
+	{"Out 3", NULL, "Out3 Mux"},
+	{"OUT3", NULL, "Out 3"},
+
+	{"Left Line Mux", "Line 2", "LINPUT2"},
+	{"Left Line Mux", "Line 3", "LINPUT3"},
+
+	{"Right Line Mux", "Line 2", "RINPUT2"},
+	{"Right Line Mux", "Line 3", "RINPUT3"},
+
+	{"Left PGA Mux", "Line 2", "LINPUT2"},
+	{"Left PGA Mux", "Line 3", "LINPUT3"},
+
+	{"Right PGA Mux", "Line 2", "RINPUT2"},
+	{"Right PGA Mux", "Line 3", "RINPUT3"},
+
+	{"Differential Mux", "Line 2", "LINPUT2"},
+	{"Differential Mux", "Line 2", "RINPUT2"},
+};
+
+static int wm897x_add_controls(struct snd_soc_codec *codec)
+{
+	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
+	snd_soc_add_codec_controls(codec, wm8971_snd_controls,
+				   ARRAY_SIZE(wm8971_snd_controls));
+
+	if (wm8971->variant)
+		snd_soc_add_codec_controls(codec, wm8973_snd_controls,
+					   ARRAY_SIZE(wm8973_snd_controls));
+
+	snd_soc_dapm_new_controls(dapm, wm897x_dapm_widgets,
+				  ARRAY_SIZE(wm897x_dapm_widgets));
+
+	if (wm8971->variant)
+		snd_soc_dapm_new_controls(dapm, wm8973_dapm_widgets,
+					  ARRAY_SIZE(wm8973_dapm_widgets));
+	else
+		snd_soc_dapm_new_controls(dapm, wm8971_dapm_widgets,
+					  ARRAY_SIZE(wm8971_dapm_widgets));
+
+	snd_soc_dapm_add_routes(dapm, wm8971_dapm_routes,
+				ARRAY_SIZE(wm8971_dapm_routes));
+
+	if (wm8971->variant)
+		snd_soc_dapm_add_routes(dapm, wm8973_dapm_routes,
+					ARRAY_SIZE(wm8973_dapm_routes));
+
+	return 0;
+}
+
 struct _coeff_div {
 	u32 mclk;
 	u32 rate;
@@ -724,12 +880,18 @@ static int wm8971_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
 	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
-	u16 pwr_reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
+	static const u16 mask[][2] = {
+		[VARIANT_WM8971] = { 0x00c1, 0x0140 },
+		[VARIANT_WM8973] = { 0x00c2, 0x0141 },
+	};
+	u16 pwr_reg = snd_soc_read(codec, WM8971_PWR1)
+				   & charge[wm8971->variant][0];
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		/* set vmid to 50k and unmute dac */
-		snd_soc_write(codec, WM8971_PWR1, pwr_reg | 0x00c1);
+		snd_soc_write(codec, WM8971_PWR1,
+			      pwr_reg | mask[wm8971->variant][0]);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
@@ -738,7 +900,8 @@ static int wm8971_set_bias_level(struct snd_soc_codec *codec,
 			regcache_sync(wm8971->regmap);
 
 		/* mute dac and set vmid to 500k, enable VREF */
-		snd_soc_write(codec, WM8971_PWR1, pwr_reg | 0x0140);
+		snd_soc_write(codec, WM8971_PWR1,
+			      pwr_reg | mask[wm8971->variant][1]);
 		break;
 	case SND_SOC_BIAS_OFF:
 		snd_soc_write(codec, WM8971_PWR1, 0x0001);
@@ -763,21 +926,28 @@ static const struct snd_soc_dai_ops wm8971_dai_ops = {
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
 };
 
 static int wm8971_suspend(struct snd_soc_codec *codec)
@@ -792,14 +962,17 @@ static int wm8971_suspend(struct snd_soc_codec *codec)
 
 static int wm8971_resume(struct snd_soc_codec *codec)
 {
+	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
 	u16 reg;
 
 	wm8971_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* charge wm8971 caps */
 	if (codec->dapm.suspend_bias_level == SND_SOC_BIAS_ON) {
-		reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
-		snd_soc_write(codec, WM8971_PWR1, reg | 0x01c0);
+		reg = snd_soc_read(codec, WM8971_PWR1)
+				   & charge[wm8971->variant][0];
+		snd_soc_write(codec, WM8971_PWR1,
+			      reg | charge[wm8971->variant][1]);
 		codec->dapm.bias_level = SND_SOC_BIAS_ON;
 		msleep(100);
 	}
@@ -810,16 +983,25 @@ static int wm8971_resume(struct snd_soc_codec *codec)
 static int wm8971_probe(struct snd_soc_codec *codec)
 {
 	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
+	const u32 *p;
 	int ret = 0;
 	u16 reg;
 
 	codec->control_data = wm8971->regmap;
 
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
 	msleep(100);
 
@@ -833,6 +1015,8 @@ static int wm8971_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, WM8971_LINVOL, 0x0100, 0x0100);
 	snd_soc_update_bits(codec, WM8971_RINVOL, 0x0100, 0x0100);
 
+	wm897x_add_controls(codec);
+
 	return ret;
 }
 
@@ -841,7 +1025,6 @@ static int wm8971_probe(struct snd_soc_codec *codec)
 static int wm8971_remove(struct snd_soc_codec *codec)
 {
 	wm8971_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
 	return 0;
 }
 
@@ -859,13 +1042,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8971 = {
 	.resume =	wm8971_resume,
 	.set_bias_level = wm8971_set_bias_level,
 	.get_regmap =	wm8971_get_regmap,
-
-	.controls = wm8971_snd_controls,
-	.num_controls = ARRAY_SIZE(wm8971_snd_controls),
-	.dapm_widgets = wm8971_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(wm8971_dapm_widgets),
-	.dapm_routes = wm8971_dapm_routes,
-	.num_dapm_routes = ARRAY_SIZE(wm8971_dapm_routes),
 };
 
 static const struct regmap_config wm8971_regmap = {
@@ -889,6 +1065,8 @@ static int wm8971_i2c_probe(struct i2c_client *i2c,
 	if (wm8971 == NULL)
 		return -ENOMEM;
 
+	wm8971->variant = (int)id->driver_data;
+
 	wm8971->regmap = devm_regmap_init_i2c(i2c, &wm8971_regmap);
 	if (IS_ERR(wm8971->regmap))
 		return PTR_ERR(wm8971->regmap);
@@ -896,7 +1074,7 @@ static int wm8971_i2c_probe(struct i2c_client *i2c,
 	i2c_set_clientdata(i2c, wm8971);
 
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_wm8971,
-				     &wm8971_dai, 1);
+				     wm8971_dai, ARRAY_SIZE(wm8971_dai));
 
 	return ret;
 }
@@ -908,15 +1086,23 @@ static int wm8971_i2c_remove(struct i2c_client *client)
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
@@ -928,3 +1114,5 @@ module_i2c_driver(wm8971_i2c_driver);
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
