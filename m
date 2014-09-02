From: Xavier Hsu <xavier.hsu@linaro.org>
Subject: [PATCHv3 2/9] WM8971 uses SOC_ENUM_SINGLE_DECL to
	replace SOC_ENUM_SINGLE
Date: Tue,  2 Sep 2014 11:30:41 +0800
Message-ID: <1409628648-13732-2-git-send-email-xavier.hsu@linaro.org>
References: <1409628648-13732-1-git-send-email-xavier.hsu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Kraken (unknown [124.219.7.128])
 by alsa0.perex.cz (Postfix) with ESMTP id 8913C2654C7
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 05:30:52 +0200 (CEST)
In-Reply-To: <1409628648-13732-1-git-send-email-xavier.hsu@linaro.org>
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
Cc: Xavier Hsu <xavier.hsu@linaro.org>, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, Andy Green <andy.green@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch improves WM8971.
We uses SOC_ENUM_SINGLE_DECL macro to
replace SOC_ENUM_SINGLE macro.

Any comments about improving the patch are welcome.
Thanks.

Signed-off-by: Xavier Hsu <xavier.hsu@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---
 sound/soc/codecs/wm8971.c |  136 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 106 insertions(+), 30 deletions(-)
 mode change 100644 => 100755 sound/soc/codecs/wm8971.c

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
old mode 100644
new mode 100755
index 064278f..59c4828
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -7,6 +7,10 @@
  *
  * Based on wm8753.c by Liam Girdwood
  *
+ * WM8971 Improve Copyright (C) 2014 Linaro, Ltd
+ * Author: Xavier Hsu <xavier.hsu@linaro.org>
+ *         Andy Green <andy.green@linaro.org>
+ *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
  *  Free Software Foundation;  either version 2 of the  License, or (at your
@@ -36,6 +40,8 @@ static struct workqueue_struct *wm8971_workq;
 /* codec private data */
 struct wm8971_priv {
 	unsigned int sysclk;
+	int playback_fs;
+	bool deemph;
 };
 
 /*
@@ -100,7 +106,6 @@ static const char const *wm8971_alc_func[] = {"Off", "Right",
 					      "Left", "Stereo"};
 static const char const *wm8971_ng_type[] = {"Constant PGA Gain",
 					     "Mute ADC Output"};
-static const char const *wm8971_deemp[] = {"None", "32kHz", "44.1kHz", "48kHz"};
 static const char const *wm8971_mono_mux[] = {"Stereo", "Mono (Left)",
 					      "Mono (Right)", "Digital Mono"};
 static const char const *wm8971_dac_phase[] = {"Non Inverted", "Inverted"};
@@ -114,23 +119,91 @@ static const char const *wm8971_rpga_sel[] = {"Line", "Mic", "NC",
 					      "Differential"};
 static const char const *wm8971_adcpol[] = {"Normal", "L Invert",
 					    "R Invert", "L + R Invert"};
+static const char const *wm8971_deemp[] = {"None", "32kHz",
+					   "44.1kHz", "48kHz"};
 
-static const struct soc_enum wm8971_enum[] = {
-	SOC_ENUM_SINGLE(WM8971_BASS, 7, 2, wm8971_bass),	/* 0 */
-	SOC_ENUM_SINGLE(WM8971_BASS, 6, 2, wm8971_bass_filter),
-	SOC_ENUM_SINGLE(WM8971_TREBLE, 6, 2, wm8971_treble),
-	SOC_ENUM_SINGLE(WM8971_ALC1, 7, 4, wm8971_alc_func),
-	SOC_ENUM_SINGLE(WM8971_NGATE, 1, 2, wm8971_ng_type),    /* 4 */
-	SOC_ENUM_SINGLE(WM8971_ADCDAC, 1, 4, wm8971_deemp),
-	SOC_ENUM_SINGLE(WM8971_ADCTL1, 4, 4, wm8971_mono_mux),
-	SOC_ENUM_SINGLE(WM8971_ADCTL1, 1, 2, wm8971_dac_phase),
-	SOC_ENUM_SINGLE(WM8971_LOUTM1, 0, 5, wm8971_lline_mux), /* 8 */
-	SOC_ENUM_SINGLE(WM8971_ROUTM1, 0, 5, wm8971_rline_mux),
-	SOC_ENUM_SINGLE(WM8971_LADCIN, 6, 4, wm8971_lpga_sel),
-	SOC_ENUM_SINGLE(WM8971_RADCIN, 6, 4, wm8971_rpga_sel),
-	SOC_ENUM_SINGLE(WM8971_ADCDAC, 5, 4, wm8971_adcpol),    /* 12 */
-	SOC_ENUM_SINGLE(WM8971_ADCIN, 6, 4, wm8971_mono_mux),
-};
+static int wm8971_set_deemph(struct snd_soc_codec *codec)
+{
+	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
+	int val = 0, i, best = 0;
+
+	/* If we're using deemphasis select the nearest available sample
+	 * rate.
+	*/
+	if (wm8971->deemph) {
+		best = 1;
+		for (i = 2; i < ARRAY_SIZE(wm8971_deemp); i++) {
+			if (abs(wm8971_deemp[i] - wm8971->playback_fs) <
+				abs(wm8971_deemp[best] -
+					wm8971->playback_fs))
+				best = i;
+		}
+		val = best << 1;
+	}
+
+	dev_dbg(codec->dev, "Set deemphasis %d (%dHz)\n",
+		best, wm8971_deemp[best]);
+
+	return snd_soc_update_bits(codec, WM8971_ADCDAC, 0x6, val);
+}
+
+static int wm8971_get_deemph(struct snd_kcontrol *kcontrol,
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
+static int wm8971_put_deemph(struct snd_kcontrol *kcontrol,
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
+		wm8971_set_deemph(codec);
+
+		ret = 1;
+	}
+	mutex_unlock(&codec->mutex);
+
+	return ret;
+}
+
+static const SOC_ENUM_SINGLE_DECL(bass_boost, WM8971_BASS, 7, wm8971_bass);
+static const SOC_ENUM_SINGLE_DECL(bass_filter, WM8971_BASS,
+				  6, wm8971_bass_filter);
+static const SOC_ENUM_SINGLE_DECL(treble_cutoff, WM8971_TREBLE,
+				  6, wm8971_treble);
+static const SOC_ENUM_SINGLE_DECL(alc_capture_func, WM8971_ALC1,
+				  7, wm8971_alc_func);
+static const SOC_ENUM_SINGLE_DECL(alc_capture_ngtype, WM8971_NGATE,
+				  1, wm8971_ng_type);
+static const SOC_ENUM_SINGLE_DECL(dac_mono_mix, WM8971_ADCTL1,
+				  4, wm8971_mono_mux);
+static const SOC_ENUM_SINGLE_DECL(dac_phase_inv, WM8971_ADCTL1,
+				  1, wm8971_dac_phase);
+static const SOC_ENUM_SINGLE_DECL(left_line, WM8971_LOUTM1,
+				  0, wm8971_lline_mux);
+static const SOC_ENUM_SINGLE_DECL(right_line, WM8971_ROUTM1,
+				  0, wm8971_rline_mux);
+static const SOC_ENUM_SINGLE_DECL(left_pga, WM8971_LADCIN, 6, wm8971_lpga_sel);
+static const SOC_ENUM_SINGLE_DECL(right_pga, WM8971_RADCIN,
+				  6, wm8971_rpga_sel);
+static const SOC_ENUM_SINGLE_DECL(capture_polarity, WM8971_ADCDAC,
+				  5, wm8971_adcpol);
+static const SOC_ENUM_SINGLE_DECL(monomux, WM8971_ADCIN, 6, wm8971_mono_mux);
 
 static const struct snd_kcontrol_new wm8971_snd_controls[] = {
 	SOC_DOUBLE_R("Capture Volume", WM8971_LINVOL, WM8971_RINVOL, 0, 63, 0),
@@ -158,12 +231,12 @@ static const struct snd_kcontrol_new wm8971_snd_controls[] = {
 	SOC_DOUBLE_R("Speaker Playback Volume", WM8971_LOUT2V,
 		     WM8971_ROUT2V, 0, 127, 0),
 
-	SOC_ENUM("Bass Boost", wm8971_enum[0]),
-	SOC_ENUM("Bass Filter", wm8971_enum[1]),
+	SOC_ENUM("Bass Boost", bass_boost),
+	SOC_ENUM("Bass Filter", bass_filter),
 	SOC_SINGLE("Bass Volume", WM8971_BASS, 0, 7, 1),
 
 	SOC_SINGLE("Treble Volume", WM8971_TREBLE, 0, 7, 0),
-	SOC_ENUM("Treble Cut-off", wm8971_enum[2]),
+	SOC_ENUM("Treble Cut-off", treble_cutoff),
 
 	SOC_SINGLE("Capture Filter Switch", WM8971_ADCDAC, 0, 1, 1),
 
@@ -172,21 +245,22 @@ static const struct snd_kcontrol_new wm8971_snd_controls[] = {
 
 	SOC_SINGLE("ALC Capture Target Volume", WM8971_ALC1, 0, 7, 0),
 	SOC_SINGLE("ALC Capture Max Volume", WM8971_ALC1, 4, 7, 0),
-	SOC_ENUM("ALC Capture Function", wm8971_enum[3]),
+	SOC_ENUM("ALC Capture Function", alc_capture_func),
 	SOC_SINGLE("ALC Capture ZC Switch", WM8971_ALC2, 7, 1, 0),
 	SOC_SINGLE("ALC Capture Hold Time", WM8971_ALC2, 0, 15, 0),
 	SOC_SINGLE("ALC Capture Decay Time", WM8971_ALC3, 4, 15, 0),
 	SOC_SINGLE("ALC Capture Attack Time", WM8971_ALC3, 0, 15, 0),
 	SOC_SINGLE("ALC Capture NG Threshold", WM8971_NGATE, 3, 31, 0),
-	SOC_ENUM("ALC Capture NG Type", wm8971_enum[4]),
+	SOC_ENUM("ALC Capture NG Type", alc_capture_ngtype),
 	SOC_SINGLE("ALC Capture NG Switch", WM8971_NGATE, 0, 1, 0),
 
 	SOC_SINGLE("Capture 6dB Attenuate", WM8971_ADCDAC, 8, 1, 0),
 	SOC_SINGLE("Playback 6dB Attenuate", WM8971_ADCDAC, 7, 1, 0),
 
-	SOC_ENUM("Playback De-emphasis", wm8971_enum[5]),
-	SOC_ENUM("Playback Function", wm8971_enum[6]),
-	SOC_ENUM("Playback Phase", wm8971_enum[7]),
+	SOC_SINGLE_BOOL_EXT("Playback De-emphasis Switch", 0,
+			    wm8971_get_deemph, wm8971_put_deemph),
+	SOC_ENUM("Playback Function", dac_mono_mix),
+	SOC_ENUM("Playback Phase", dac_phase_inv),
 
 	SOC_DOUBLE_R("Mic Boost", WM8971_LADCIN, WM8971_RADCIN, 4, 3, 0),
 };
@@ -221,23 +295,23 @@ SOC_DAPM_SINGLE("Right Bypass Switch", WM8971_MOUTM2, 7, 1, 0),
 
 /* Left Line Mux */
 static const struct snd_kcontrol_new wm8971_left_line_controls =
-SOC_DAPM_ENUM("Route", wm8971_enum[8]);
+SOC_DAPM_ENUM("Route", left_line);
 
 /* Right Line Mux */
 static const struct snd_kcontrol_new wm8971_right_line_controls =
-SOC_DAPM_ENUM("Route", wm8971_enum[9]);
+SOC_DAPM_ENUM("Route", right_line);
 
 /* Left PGA Mux */
 static const struct snd_kcontrol_new wm8971_left_pga_controls =
-SOC_DAPM_ENUM("Route", wm8971_enum[10]);
+SOC_DAPM_ENUM("Route", left_pga);
 
 /* Right PGA Mux */
 static const struct snd_kcontrol_new wm8971_right_pga_controls =
-SOC_DAPM_ENUM("Route", wm8971_enum[11]);
+SOC_DAPM_ENUM("Route", right_pga);
 
 /* Mono ADC Mux */
 static const struct snd_kcontrol_new wm8971_monomux_controls =
-SOC_DAPM_ENUM("Route", wm8971_enum[13]);
+SOC_DAPM_ENUM("Route", monomux);
 
 static const struct snd_soc_dapm_widget wm8971_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
@@ -534,6 +608,8 @@ static int wm8971_pcm_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
+	wm8971_set_deemph(codec);
+
 	/* set iface & srate */
 	snd_soc_write(codec, WM8971_IFACE, iface);
 	if (coeff >= 0)
-- 
1.7.9.5
