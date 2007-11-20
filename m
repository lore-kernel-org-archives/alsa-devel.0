From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Add TLV support for UDA1380
Date: Tue, 20 Nov 2007 09:25:44 +0000
Message-ID: <1195550746-6892-22-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1195550746-6892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-13-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-14-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-15-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-16-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-17-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-18-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-19-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-20-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-21-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A9F72249E2
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 10:43:26 +0100 (CET)
In-Reply-To: <1195550746-6892-21-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: liam.girdwood@opensource.wolfsonmicro.com, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Philipp Zabel <philipp.zabel@gmail.com>

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/codecs/uda1380.c |  255 ++++++++++++++++++++++++++++++++++++++------
 1 files changed, 222 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 0fa9832..71960f0 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -5,6 +5,10 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
+ * Copyright (c) 2007 Philipp Zabel <philipp.zabel@gmail.com>
+ * Improved support for DAPM and audio routing/mixing capabilities,
+ * added TLV support.
+ *
  * Modified by Richard Purdie <richard@openedhand.com> to fit into SoC
  * codec model.
  *
@@ -28,6 +32,7 @@
 #include <sound/info.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include <sound/tlv.h>
 
 #include "uda1380.h"
 
@@ -111,14 +116,14 @@ static int uda1380_write(struct snd_soc_codec *codec, unsigned int reg,
 	 */
 	if (!codec->active && (reg >= UDA1380_MVOL))
 		return 0;
-	dbg("uda hw write %x val %x\n", reg, value);
+	dbg("uda hw write %x val %x", reg, value);
 	if (codec->hw_write(codec->control_data, data, 3) == 3) {
 		unsigned int val;
 		i2c_master_send(codec->control_data, data, 1);
 		i2c_master_recv(codec->control_data, data, 2);
 		val = (data[0]<<8) | data[1];
 		if (val != value) {
-			dbg("READ BACK VAL %x\n", (data[0]<<8) | data[1]);
+			dbg("READ BACK VAL %x", (data[0]<<8) | data[1]);
 			return -EIO;
 		}
 		return 0;
@@ -131,37 +136,202 @@ static int uda1380_write(struct snd_soc_codec *codec, unsigned int reg,
 /* declarations of ALSA reg_elem_REAL controls */
 static const char *uda1380_deemp[] = {"None", "32kHz", "44.1kHz", "48kHz",
 				      "96kHz"};
-static const char *uda1380_input_sel[] = {"Line", "Mic"};
-static const char *uda1380_output_sel[] = {"Direct", "Mixer"};
+static const char *uda1380_input_sel[] = { "Line", "Mic + Line R", "Line L", "Mic" };
+static const char *uda1380_output_sel[] = {"DAC", "Analog Mixer"};
 static const char *uda1380_spf_mode[] = {"Flat", "Minimum1", "Minimum2",
 					 "Maximum"};
+static const char *uda1380_capture_sel[] = {"ADC", "Digital Mixer"};
+static const char *uda1380_sel_ns[] = { "3rd-order", "5th-order" };
+static const char *uda1380_mix_control[] = { "off", "PCM only", "before sound processing", "after sound processing" };
+static const char *uda1380_sdet_setting[] = { "3200", "4800", "9600", "19200" };
+static const char *uda1380_os_setting[] = { "single-speed", "double-speed (no mixing)", "quad-speed (no mixing)" };
+
+static const struct soc_enum uda1380_deemp_enum[] = {
+	SOC_ENUM_SINGLE(UDA1380_DEEMP, 8, 5, uda1380_deemp),
+	SOC_ENUM_SINGLE(UDA1380_DEEMP, 0, 5, uda1380_deemp),
+};
+static const struct soc_enum uda1380_input_sel_enum =
+	SOC_ENUM_SINGLE(UDA1380_ADC, 2, 4, uda1380_input_sel);		/* SEL_MIC, SEL_LNA */
+static const struct soc_enum uda1380_output_sel_enum =
+	SOC_ENUM_SINGLE(UDA1380_PM, 7, 2, uda1380_output_sel);		/* R02_EN_AVC */
+static const struct soc_enum uda1380_spf_enum =
+	SOC_ENUM_SINGLE(UDA1380_MODE, 14, 4, uda1380_spf_mode);		/* M */
+static const struct soc_enum uda1380_capture_sel_enum =
+	SOC_ENUM_SINGLE(UDA1380_IFACE, 6, 2, uda1380_capture_sel);	/* SEL_SOURCE */
+static const struct soc_enum uda1380_sel_ns_enum =
+	SOC_ENUM_SINGLE(UDA1380_MIXER, 14, 2, uda1380_sel_ns);		/* SEL_NS */
+static const struct soc_enum uda1380_mix_enum =
+	SOC_ENUM_SINGLE(UDA1380_MIXER, 12, 4, uda1380_mix_control);	/* MIX, MIX_POS */
+static const struct soc_enum uda1380_sdet_enum =
+	SOC_ENUM_SINGLE(UDA1380_MIXER, 4, 4, uda1380_sdet_setting);	/* SD_VALUE */
+static const struct soc_enum uda1380_os_enum =
+	SOC_ENUM_SINGLE(UDA1380_MIXER, 0, 3, uda1380_os_setting);	/* OS */
+
+/**
+ * snd_soc_info_volsw - single mixer info callback
+ * @kcontrol: mixer control
+ * @uinfo: control element information
+ *
+ * Callback to provide information about a single mixer control.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_info_volsw_s8(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	int max = (kcontrol->private_value >> 16) & 0xff;
+	int min = (kcontrol->private_value >> 24) & 0xff;
+
+	/* 00000000 (0) ...(-0.25 dB)... 11111000 (-78 dB), 11111100 -INF */
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2;
+	uinfo->value.integer.min = min;
+	uinfo->value.integer.max = max;
+	return 0;
+}
+
+/**
+ * snd_soc_get_volsw_sgn - single mixer get callback
+ * @kcontrol: mixer control
+ * @uinfo: control element information
+ *
+ * Callback to get the value of a single mixer control.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_get_volsw_s8(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	int reg = kcontrol->private_value & 0xff;
+	int max = (kcontrol->private_value >> 16) & 0xff;
+	int min = (kcontrol->private_value >> 24) & 0xff;
+
+	ucontrol->value.integer.value[0] =
+		(signed char)(snd_soc_read(codec, reg) & 0xff);
+	ucontrol->value.integer.value[1] =
+		(signed char)((snd_soc_read(codec, reg) >> 8) & 0xff);
+
+	return 0;
+}
+
+/**
+ * snd_soc_put_volsw_sgn - single mixer put callback
+ * @kcontrol: mixer control
+ * @uinfo: control element information
+ *
+ * Callback to set the value of a single mixer control.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_put_volsw_s8(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	int reg = kcontrol->private_value & 0xff;
+	int max = (kcontrol->private_value >> 16) & 0xff;
+	int min = (kcontrol->private_value >> 24) & 0xff;
+	int err;
+	unsigned short val, val2, val_mask;
+
+	val = (signed char)ucontrol->value.integer.value[0] & 0xff;
+	val2 = (signed char)ucontrol->value.integer.value[1] & 0xff;
+	val |= val2<<8;
+	err = snd_soc_update_bits(codec, reg, val_mask, val);
+	return err;
+}
+
+DECLARE_TLV_DB_SCALE(amix_tlv, -4950, 150, 1);	/* from -48 dB in 1.5 dB steps (mute instead of -49.5 dB) */
+
+static const unsigned int mvol_tlv[] = {
+	TLV_DB_RANGE_HEAD(3),
+	0,15, TLV_DB_SCALE_ITEM(-8200, 100, 1),	/* from -78 dB in 1 dB steps (3 dB steps, really) */
+	16,43, TLV_DB_SCALE_ITEM(-6600, 50, 0),	/* from -66 dB in 0.5 dB steps (2 dB steps, really) */
+	44,252, TLV_DB_SCALE_ITEM(-5200, 25, 0),	/* from -52 dB in 0.25 dB steps */
+};
 
-static const struct soc_enum uda1380_enum[] = {
-	SOC_ENUM_DOUBLE(UDA1380_DEEMP, 0, 8, 5, uda1380_deemp),
-	SOC_ENUM_SINGLE(UDA1380_ADC, 3, 2, uda1380_input_sel),
-	SOC_ENUM_SINGLE(UDA1380_MODE, 14, 4, uda1380_spf_mode),
-	SOC_ENUM_SINGLE(UDA1380_PM, 7, 2, uda1380_output_sel), /* R02_EN_AVC */
+static const unsigned int vc_tlv[] = {
+	TLV_DB_RANGE_HEAD(4),
+	0,7, TLV_DB_SCALE_ITEM(-7800, 150, 1),	/* from -72 dB in 1.5 dB steps (6 dB steps really) */
+	8,15, TLV_DB_SCALE_ITEM(-6600, 75, 0),	/* from -66 dB in 0.75 dB steps (3 dB steps really) */
+	16,43, TLV_DB_SCALE_ITEM(-6000, 50, 0),	/* from -60 dB in 0.5 dB steps (2 dB steps really) */
+	44,228, TLV_DB_SCALE_ITEM(-4600, 25, 0),/* from -46 dB in 0.25 dB steps */
 };
 
+DECLARE_TLV_DB_SCALE(tr_tlv, 0, 200, 0);	/* from 0 dB to 6 dB in 2 dB steps, if SPF mode != flat */
+DECLARE_TLV_DB_SCALE(bb_tlv, 0, 200, 0);	/* from 0 dB to 24 dB in 2 dB steps, if SPF mode == maximum */
+						/* (SPF mode == flat cuts off at 18 dB max */
+
+static const unsigned int dec_tlv[] = {
+	TLV_DB_RANGE_HEAD(1),
+	-128,48, TLV_DB_SCALE_ITEM(-6350, 50, 1),
+	/* 0011000 (48 dB) ...(0.5 dB)... 10000001 (-63 dB) 10000000 -INF */
+};
+
+DECLARE_TLV_DB_SCALE(pga_tlv, 0, 300, 0);	/* from 0 dB to 24 dB in 3 dB steps */
+DECLARE_TLV_DB_SCALE(vga_tlv, 0, 200, 0);	/* from 0 dB to 30 dB in 2 dB steps */
+
+
+#define SOC_DOUBLE_S8_TLV(xname, reg, min, max, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ|SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw_s8, .get = snd_soc_get_volsw_s8, \
+	.put = snd_soc_put_volsw_s8, \
+	.private_value = (reg) | (((signed char)max) << 16) | (((signed char)min) << 24) }
+
 static const struct snd_kcontrol_new uda1380_snd_controls[] = {
-	SOC_DOUBLE("Playback Volume", UDA1380_MVOL, 0, 8, 255, 1),
-	SOC_DOUBLE("Mixer Volume", UDA1380_MIXVOL, 0, 8, 255, 1),
-	SOC_ENUM("Sound Processing Filter Mode", uda1380_enum[2]),
-	SOC_DOUBLE("Treble Volume", UDA1380_MODE, 4, 12, 3, 0),
-	SOC_DOUBLE("Bass Volume", UDA1380_MODE, 0, 8, 15, 0),
-	SOC_ENUM("Playback De-emphasis", uda1380_enum[0]),
-	SOC_DOUBLE("Capture Volume", UDA1380_DEC, 0, 8, 127, 0),
-	SOC_DOUBLE("Line Capture Volume", UDA1380_PGA, 0, 8, 15, 0),
-	SOC_SINGLE("Mic Capture Volume", UDA1380_PGA, 8, 11, 0),
-	SOC_DOUBLE("Playback Switch", UDA1380_DEEMP, 3, 11, 1, 1),
-	SOC_SINGLE("Capture Switch", UDA1380_PGA, 15, 1, 0),
-	SOC_SINGLE("AGC Timing", UDA1380_AGC, 8, 7, 0),
-	SOC_SINGLE("AGC Target level", UDA1380_AGC, 2, 3, 1),
+	SOC_DOUBLE_TLV("Analog Mixer Volume", UDA1380_AMIX, 0, 8, 44, 1, amix_tlv),	/* AVCR, AVCL */
+	SOC_DOUBLE_TLV("Master Playback Volume", UDA1380_MVOL, 0, 8, 252, 1, mvol_tlv),	/* MVCL, MVCR */
+	SOC_SINGLE_TLV("ADC Playback Volume", UDA1380_MIXVOL, 8, 228, 1, vc_tlv),	/* VC2 */
+	SOC_SINGLE_TLV("PCM Playback Volume", UDA1380_MIXVOL, 0, 228, 1, vc_tlv),	/* VC1 */
+	SOC_ENUM("Sound Processing Filter", uda1380_spf_enum),				/* M */
+	SOC_DOUBLE_TLV("Tone Control - Treble", UDA1380_MODE, 4, 12, 3, 0, tr_tlv), 	/* TRL, TRR */
+	SOC_DOUBLE_TLV("Tone Control - Bass", UDA1380_MODE, 0, 8, 15, 0, bb_tlv),	/* BBL, BBR */
+/**/	SOC_SINGLE("Master Playback Switch", UDA1380_DEEMP, 14, 1, 1),		/* MTM */
+	SOC_SINGLE("ADC Playback Switch", UDA1380_DEEMP, 11, 1, 1),		/* MT2 from decimation filter */
+	SOC_ENUM("ADC Playback De-emphasis", uda1380_deemp_enum[0]),		/* DE2 */
+	SOC_SINGLE("PCM Playback Switch", UDA1380_DEEMP, 3, 1, 1),		/* MT1, from digital data input */
+	SOC_ENUM("PCM Playback De-emphasis", uda1380_deemp_enum[1]),		/* DE1 */
+	SOC_SINGLE("DAC Polarity inverting Switch", UDA1380_MIXER, 15, 1, 0),	/* DA_POL_INV */
+	SOC_ENUM("Noise Shaper", uda1380_sel_ns_enum),				/* SEL_NS */
+	SOC_ENUM("Digital Mixer Signal Control", uda1380_mix_enum),		/* MIX_POS, MIX */
+	SOC_SINGLE("Silence Switch", UDA1380_MIXER, 7, 1, 0),			/* SILENCE, force DAC output to silence */
+	SOC_SINGLE("Silence Detector Switch", UDA1380_MIXER, 6, 1, 0),		/* SDET_ON */
+	SOC_ENUM("Silence Detector Setting", uda1380_sdet_enum),		/* SD_VALUE */
+	SOC_ENUM("Oversampling Input", uda1380_os_enum),			/* OS */
+	SOC_DOUBLE_S8_TLV("ADC Capture Volume", UDA1380_DEC, -128, 48, dec_tlv),	/* ML_DEC, MR_DEC */
+/**/	SOC_SINGLE("ADC Capture Switch", UDA1380_PGA, 15, 1, 1),		/* MT_ADC */
+	SOC_DOUBLE_TLV("Line Capture Volume", UDA1380_PGA, 0, 8, 8, 0, pga_tlv), /* PGA_GAINCTRLL, PGA_GAINCTRLR */
+	SOC_SINGLE("ADC Polarity inverting Switch", UDA1380_ADC, 12, 1, 0),	/* ADCPOL_INV */
+	SOC_SINGLE_TLV("Mic Capture Volume", UDA1380_ADC, 8, 15, 0, vga_tlv),	/* VGA_CTRL */
+	SOC_SINGLE("DC Filter Bypass Switch", UDA1380_ADC, 1, 1, 0),		/* SKIP_DCFIL (before decimator) */
+	SOC_SINGLE("DC Filter Enable Switch", UDA1380_ADC, 0, 1, 0),		/* EN_DCFIL (at output of decimator) */
+	SOC_SINGLE("AGC Timing", UDA1380_AGC, 8, 7, 0),			/* TODO: enum, see table 62 */
+	SOC_SINGLE("AGC Target level", UDA1380_AGC, 2, 3, 1),			/* AGC_LEVEL */
+	/* -5.5, -8, -11.5, -14 dBFS */
 	SOC_SINGLE("AGC Switch", UDA1380_AGC, 0, 1, 0),
-	SOC_SINGLE("Silence", UDA1380_MIXER, 7, 1, 0),
-	SOC_SINGLE("Silence Detection", UDA1380_MIXER, 6, 1, 0),
 };
 
+/**
+ * uda1380_snd_soc_cnew
+ *
+ * temporary copy of snd_soc_cnew that doesn't overwrite .access
+ */
+struct snd_kcontrol *uda1380_snd_soc_cnew(const struct snd_kcontrol_new *_template,
+	void *data, char *long_name)
+{
+	struct snd_kcontrol_new template;
+
+	memcpy(&template, _template, sizeof(template));
+	if (long_name)
+		template.name = long_name;
+	template.index = 0;
+
+	return snd_ctl_new1(&template, data);
+}
+
 /* add non dapm controls */
 static int uda1380_add_controls(struct snd_soc_codec *codec)
 {
@@ -169,7 +339,7 @@ static int uda1380_add_controls(struct snd_soc_codec *codec)
 
 	for (i = 0; i < ARRAY_SIZE(uda1380_snd_controls); i++) {
 		err = snd_ctl_add(codec->card,
-			snd_soc_cnew(&uda1380_snd_controls[i],codec, NULL));
+			uda1380_snd_soc_cnew(&uda1380_snd_controls[i],codec, NULL));
 		if (err < 0)
 			return err;
 	}
@@ -179,17 +349,24 @@ static int uda1380_add_controls(struct snd_soc_codec *codec)
 
 /* Input mux */
 static const struct snd_kcontrol_new uda1380_input_mux_control =
-	SOC_DAPM_ENUM("Input Select", uda1380_enum[1]);
+	SOC_DAPM_ENUM("Route", uda1380_input_sel_enum);
 
 /* Output mux */
 static const struct snd_kcontrol_new uda1380_output_mux_control =
-	SOC_DAPM_ENUM("Output Select", uda1380_enum[3]);
+	SOC_DAPM_ENUM("Route", uda1380_output_sel_enum);
+
+/* Capture mux */
+static const struct snd_kcontrol_new uda1380_capture_mux_control =
+	SOC_DAPM_ENUM("Route", uda1380_capture_sel_enum);
+
 
 static const struct snd_soc_dapm_widget uda1380_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("Input Mux", SND_SOC_NOPM, 0, 0,
 		&uda1380_input_mux_control),
 	SND_SOC_DAPM_MUX("Output Mux", SND_SOC_NOPM, 0, 0,
 		&uda1380_output_mux_control),
+	SND_SOC_DAPM_MUX("Capture Mux", SND_SOC_NOPM, 0, 0,
+		&uda1380_capture_mux_control),
 	SND_SOC_DAPM_PGA("Left PGA", UDA1380_PM, 3, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("Right PGA", UDA1380_PM, 1, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("Mic LNA", UDA1380_PM, 4, 0, NULL, 0),
@@ -218,8 +395,10 @@ static const char *audio_map[][3] = {
 	{"Analog Mixer", NULL, "VINL"},
 	{"Analog Mixer", NULL, "DAC"},
 
-	{"Output Mux", "Direct", "DAC"},
-	{"Output Mux", "Mixer", "Analog Mixer"},
+	{"Output Mux", "DAC", "DAC"},
+	{"Output Mux", "Analog Mixer", "Analog Mixer"},
+
+	/* {"DAC", "Digital Mixer", "I2S" } */
 
 	/* headphone driver */
 	{"VOUTLHP", NULL, "HeadPhone Driver"},
@@ -228,10 +407,13 @@ static const char *audio_map[][3] = {
 	/* input mux */
 	{"Left ADC", NULL, "Input Mux"},
 	{"Input Mux", "Mic", "Mic LNA"},
+	{"Input Mux", "Mic + Line R", "Mic LNA"},
+	{"Input Mux", "Line L", "Left PGA"},
 	{"Input Mux", "Line", "Left PGA"},
 
 	/* right input */
-	{"Right ADC", NULL, "Right PGA"},
+	{"Right ADC", "Mic + Line R", "Right PGA"},
+	{"Right ADC", "Line", "Right PGA"},
 
 	/* inputs */
 	{"Mic LNA", NULL, "VINM"},
@@ -307,6 +489,13 @@ static int uda1380_pcm_prepare(struct snd_pcm_substream *substream)
 	} else {
 		reg_start = UDA1380_DEC;
 		reg_end = UDA1380_AGC;
+		/* FIXME - wince values */
+//		uda1380_write(codec, UDA1380_PM, uda1380_read_reg_cache (codec, UDA1380_PM) | R02_PON_LNA | R02_PON_DAC);
+		uda1380_write(codec, UDA1380_PM, 0x851f);
+//		uda1380_write_reg_cache(codec, UDA1380_DEC, 0x0000);
+//		uda1380_write_reg_cache(codec, UDA1380_PGA, uda1380_read_reg_cache (codec, UDA1380_PM) & ~R21_MT_ADC); /* unmute */
+//		uda1380_write_reg_cache(codec, UDA1380_ADC, 0x0001/*0x090d*/);
+			// ADC_POL_INV=0 VGA_CTRL=9(1001:18dB) gain SEL_LNA=1 SEL_MIC=1 EN_DCFIL=1
 	}
 
 	/* FIXME disable DAC_CLK */
@@ -314,7 +503,7 @@ static int uda1380_pcm_prepare(struct snd_pcm_substream *substream)
 	uda1380_write(codec, UDA1380_CLK, clk & ~R00_DAC_CLK);
 
 	for (reg = reg_start; reg <= reg_end; reg++ ) {
-		dbg("reg %x val %x\n",reg, uda1380_read_reg_cache (codec, reg));
+		dbg("flush reg %x val %x:",reg, uda1380_read_reg_cache (codec, reg));
 		uda1380_write(codec, reg, uda1380_read_reg_cache (codec, reg));
 	}
 
@@ -387,7 +576,7 @@ static void uda1380_pcm_shutdown(struct snd_pcm_substream *substream)
 static int uda1380_mute(struct snd_soc_codec_dai *codec_dai, int mute)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 mute_reg = uda1380_read_reg_cache(codec, UDA1380_DEEMP) & 0xbfff;
+	u16 mute_reg = uda1380_read_reg_cache(codec, UDA1380_DEEMP) & ~R13_MTM;
 
 	/* FIXME: mute(codec,0) is called when the magician clock is already
 	 * set to WSPLL, but for some unknown reason writing to interpolator
@@ -395,7 +584,7 @@ static int uda1380_mute(struct snd_soc_codec_dai *codec_dai, int mute)
 	u16 clk = uda1380_read_reg_cache(codec, UDA1380_CLK);
 	uda1380_write(codec, UDA1380_CLK, ~R00_DAC_CLK & clk);
 	if (mute)
-		uda1380_write(codec, UDA1380_DEEMP, mute_reg | 0x4000);
+		uda1380_write(codec, UDA1380_DEEMP, mute_reg | R13_MTM);
 	else
 		uda1380_write(codec, UDA1380_DEEMP, mute_reg);
 	uda1380_write(codec, UDA1380_CLK, clk);
-- 
1.5.3.5
