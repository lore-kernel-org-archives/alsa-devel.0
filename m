From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] SoC WM8940 Driver
Date: Mon, 27 Apr 2009 13:49:44 +0000
Message-ID: <49F5B7F8.1010103@cam.ac.uk>
References: <49F21310.4060009@cam.ac.uk>
	<20090425102100.GA4394@sirena.org.uk>	<49F345A8.1030901@cam.ac.uk>
	<20090425180346.GA4072@sirena.org.uk>	<49F599BB.9050805@cam.ac.uk>
	<20090427122550.GF1760@sirena.org.uk> <49F5A69C.40406@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ppsw-5.csi.cam.ac.uk (ppsw-5.csi.cam.ac.uk [131.111.8.135])
	by alsa0.perex.cz (Postfix) with ESMTP id CCE11103819
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 15:49:18 +0200 (CEST)
In-Reply-To: <49F5A69C.40406@cam.ac.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

From: Jonathan Cameron <jic23@cam.ac.uk>

aSoC: Initial support for the Wolfson Micro WM8940 codec

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

---
This is based on the sound-2.6 git tree merged with Linus'
current (needed to fix some non sound related regressions).

Thanks to Mark Brown for all his help.

Changes since first version:

Moved over to new registration methods.
Numerous name changes.
Lots of minor cleanups and more thorough error handling.
Notch filtering and Digital Sidetone support removed for now.

As ever, all comments welcome!

Board patches will follow to here and arm-linux-devel if
people are happy with this.

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 121d63f..1c19ad5 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -35,6 +35,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM8753 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8900 if I2C
 	select SND_SOC_WM8903 if I2C
+	select SND_SOC_WM8940 if I2C
 	select SND_SOC_WM8960 if I2C
 	select SND_SOC_WM8971 if I2C
 	select SND_SOC_WM8988 if SND_SOC_I2C_AND_SPI
@@ -140,6 +141,9 @@ config SND_SOC_WM8900
 config SND_SOC_WM8903
 	tristate
 
+config SND_SOC_WM8940
+        tristate
+
 config SND_SOC_WM8960
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 8116968..3d31b6b 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -23,6 +23,7 @@ snd-soc-wm8750-objs := wm8750.o
 snd-soc-wm8753-objs := wm8753.o
 snd-soc-wm8900-objs := wm8900.o
 snd-soc-wm8903-objs := wm8903.o
+snd-soc-wm8940-objs := wm8940.o
 snd-soc-wm8960-objs := wm8960.o
 snd-soc-wm8971-objs := wm8971.o
 snd-soc-wm8988-objs := wm8988.o
@@ -57,6 +58,7 @@ obj-$(CONFIG_SND_SOC_WM8753)	+= snd-soc-wm8753.o
 obj-$(CONFIG_SND_SOC_WM8900)	+= snd-soc-wm8900.o
 obj-$(CONFIG_SND_SOC_WM8903)	+= snd-soc-wm8903.o
 obj-$(CONFIG_SND_SOC_WM8971)	+= snd-soc-wm8971.o
+obj-$(CONFIG_SND_SOC_WM8940)	+= snd-soc-wm8940.o
 obj-$(CONFIG_SND_SOC_WM8960)	+= snd-soc-wm8960.o
 obj-$(CONFIG_SND_SOC_WM8988)	+= snd-soc-wm8988.o
 obj-$(CONFIG_SND_SOC_WM8990)	+= snd-soc-wm8990.o
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
new file mode 100644
index 0000000..26987dc
--- /dev/null
+++ b/sound/soc/codecs/wm8940.c
@@ -0,0 +1,955 @@
+/*
+ * wm8940.c  --  WM8940 ALSA Soc Audio driver
+ *
+ * Author: Jonathan Cameron <jic23@cam.ac.uk>
+ *
+ * Based on wm8510.c
+ *    Copyright  2006 Wolfson Microelectronics PLC.
+ *    Author:  Liam Girdwood <lrg@slimlogic.co.uk>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Not currently handled:
+ * Notch filter control
+ * AUXMode (inverting vs mixer)
+ * No means to obtain current gain if alc enabled.
+ * No use made of gpio
+ * Fast VMID discharge for power down
+ * Soft Start
+ * DLR and ALR Swaps not enabled
+ * Digital Sidetone not supported
+ */
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+
+#include "wm8940.h"
+
+struct wm8940_priv {
+	unsigned int sysclk;
+	u16 reg_cache[WM8940_CACHEREGNUM];
+	struct snd_soc_codec codec;
+};
+
+static u16 wm8940_reg_defaults[] = {
+	0x8940, /* Soft Reset */
+	0x0000, /* Power 1 */
+	0x0000, /* Power 2 */
+	0x0000, /* Power 3 */
+	0x0010, /* Interface Control */
+	0x0000, /* Companding Control */
+	0x0140, /* Clock Control */
+	0x0000, /* Additional Controls */
+	0x0000, /* GPIO Control */
+	0x0002, /* Auto Increment Control */
+	0x0000, /* DAC Control */
+	0x00FF, /* DAC Volume */
+	0,
+	0,
+	0x0100, /* ADC Control */
+	0x00FF, /* ADC Volume */
+	0x0000, /* Notch Filter 1 Control 1 */
+	0x0000, /* Notch Filter 1 Control 2 */
+	0x0000, /* Notch Filter 2 Control 1 */
+	0x0000, /* Notch Filter 2 Control 2 */
+	0x0000, /* Notch Filter 3 Control 1 */
+	0x0000, /* Notch Filter 3 Control 2 */
+	0x0000, /* Notch Filter 4 Control 1 */
+	0x0000, /* Notch Filter 4 Control 2 */
+	0x0032, /* DAC Limit Control 1 */
+	0x0000, /* DAC Limit Control 2 */
+	0,
+	0,
+	0,
+	0,
+	0,
+	0,
+	0x0038, /* ALC Control 1 */
+	0x000B, /* ALC Control 2 */
+	0x0032, /* ALC Control 3 */
+	0x0000, /* Noise Gate */
+	0x0041, /* PLLN */
+	0x000C, /* PLLK1 */
+	0x0093, /* PLLK2 */
+	0x00E9, /* PLLK3 */
+	0,
+	0,
+	0x0030, /* ALC Control 4 */
+	0,
+	0x0002, /* Input Control */
+	0x0050, /* PGA Gain */
+	0,
+	0x0002, /* ADC Boost Control */
+	0,
+	0x0002, /* Output Control */
+	0x0000, /* Speaker Mixer Control */
+	0,
+	0,
+	0,
+	0x0079, /* Speaker Volume */
+	0,
+	0x0000, /* Mono Mixer Control */
+};
+
+static inline unsigned int wm8940_read_reg_cache(struct snd_soc_codec *codec,
+						 unsigned int reg)
+{
+	u16 *cache = codec->reg_cache;
+
+	if (reg >= ARRAY_SIZE(wm8940_reg_defaults))
+		return -1;
+
+	return cache[reg];
+}
+
+static inline int wm8940_write_reg_cache(struct snd_soc_codec *codec,
+					  u16 reg, unsigned int value)
+{
+	u16 *cache = codec->reg_cache;
+
+	if (reg >= ARRAY_SIZE(wm8940_reg_defaults))
+		return -1;
+
+	cache[reg] = value;
+
+	return 0;
+}
+
+static int wm8940_write(struct snd_soc_codec *codec, unsigned int reg,
+			unsigned int value)
+{
+	int ret;
+	u8 data[3] = { reg,
+		       (value & 0xff00) >> 8,
+		       (value & 0x00ff)
+	};
+
+	wm8940_write_reg_cache(codec, reg, value);
+
+	ret = codec->hw_write(codec->control_data, data, 3);
+
+	if (ret < 0)
+		return ret;
+	else if (ret != 3)
+		return -EIO;
+	return 0;
+}
+
+static const char *wm8940_companding[] = { "Off", "NC", "u-law", "A-law" };
+static const struct soc_enum wm8940_adc_companding_enum
+= SOC_ENUM_SINGLE(WM8940_COMPANDINGCTL, 1, 4, wm8940_companding);
+static const struct soc_enum wm8940_dac_companding_enum
+= SOC_ENUM_SINGLE(WM8940_COMPANDINGCTL, 3, 4, wm8940_companding);
+
+static const char *wm8940_alc_mode_text[] = {"ALC", "Limiter"};
+static const struct soc_enum wm8940_alc_mode_enum
+= SOC_ENUM_SINGLE(WM8940_ALC3, 8, 2, wm8940_alc_mode_text);
+
+static const char *wm8940_mic_bias_level_text[] = {"0.9", "0.65"};
+static const struct soc_enum wm8940_mic_bias_level_enum
+= SOC_ENUM_SINGLE(WM8940_INPUTCTL, 8, 2, wm8940_mic_bias_level_text);
+
+static const char *wm8940_filter_mode_text[] = {"Audio", "Application"};
+static const struct soc_enum wm8940_filter_mode_enum
+= SOC_ENUM_SINGLE(WM8940_ADC, 7, 2, wm8940_filter_mode_text);
+
+DECLARE_TLV_DB_SCALE(wm8940_spk_vol_tlv, -5700, 100, 1);
+DECLARE_TLV_DB_SCALE(wm8940_att_tlv, -1000, 1000, 0);
+DECLARE_TLV_DB_SCALE(wm8940_pga_vol_tlv, -1200, 75, 0);
+DECLARE_TLV_DB_SCALE(wm8940_alc_min_tlv, -1200, 600, 0);
+DECLARE_TLV_DB_SCALE(wm8940_alc_max_tlv, 675, 600, 0);
+DECLARE_TLV_DB_SCALE(wm8940_alc_tar_tlv, -2250, 50, 0);
+DECLARE_TLV_DB_SCALE(wm8940_lim_boost_tlv, 0, 100, 0);
+DECLARE_TLV_DB_SCALE(wm8940_lim_thresh_tlv, -600, 100, 0);
+DECLARE_TLV_DB_SCALE(wm8940_adc_tlv, -12750, 50, 1);
+DECLARE_TLV_DB_SCALE(wm8940_capture_boost_vol_tlv, 0, 2000, 0);
+
+static const struct snd_kcontrol_new wm8940_snd_controls[] = {
+	SOC_SINGLE("Digital Loopback Switch", WM8940_COMPANDINGCTL,
+		   6, 1, 0),
+	SOC_ENUM("DAC Companding", wm8940_dac_companding_enum),
+	SOC_ENUM("ADC Companding", wm8940_adc_companding_enum),
+
+	SOC_ENUM("ALC Mode", wm8940_alc_mode_enum),
+	SOC_SINGLE("ALC Switch", WM8940_ALC1, 8, 1, 0),
+	SOC_SINGLE_TLV("ALC Capture Max Gain", WM8940_ALC1,
+		       3, 7, 1, wm8940_alc_max_tlv),
+	SOC_SINGLE_TLV("ALC Capture Min Gain", WM8940_ALC1,
+		       0, 7, 0, wm8940_alc_min_tlv),
+	SOC_SINGLE_TLV("ALC Capture Target", WM8940_ALC2,
+		       0, 14, 0, wm8940_alc_tar_tlv),
+	SOC_SINGLE("ALC Capture Hold", WM8940_ALC2, 4, 10, 0),
+	SOC_SINGLE("ALC Capture Decay", WM8940_ALC3, 4, 10, 0),
+	SOC_SINGLE("ALC Capture Attach", WM8940_ALC3, 0, 10, 0),
+	SOC_SINGLE("ALC ZC Switch", WM8940_ALC4, 1, 1, 0),
+	SOC_SINGLE("ALC Capture Noise Gate Switch", WM8940_NOISEGATE,
+		   3, 1, 0),
+	SOC_SINGLE("ALC Capture Noise Gate Threshold", WM8940_NOISEGATE,
+		   0, 7, 0),
+
+	SOC_SINGLE("DAC Playback Limiter Switch", WM8940_DACLIM1, 8, 1, 0),
+	SOC_SINGLE("DAC Playback Limiter Attack", WM8940_DACLIM1, 0, 9, 0),
+	SOC_SINGLE("DAC Playback Limiter Decay", WM8940_DACLIM1, 4, 11, 0),
+	SOC_SINGLE_TLV("DAC Playback Limiter Threshold", WM8940_DACLIM2,
+		       4, 9, 1, wm8940_lim_thresh_tlv),
+	SOC_SINGLE_TLV("DAC Playback Limiter Boost", WM8940_DACLIM2,
+		       0, 12, 0, wm8940_lim_boost_tlv),
+
+	SOC_SINGLE("Capture PGA ZC Switch", WM8940_PGAGAIN, 7, 1, 0),
+	SOC_SINGLE_TLV("Capture PGA Volume", WM8940_PGAGAIN,
+		       0, 63, 0, wm8940_pga_vol_tlv),
+	SOC_SINGLE_TLV("Digital Playback Volume", WM8940_DACVOL,
+		       0, 255, 0, wm8940_adc_tlv),
+	SOC_SINGLE_TLV("Digital Capture Volume", WM8940_ADCVOL,
+		       0, 255, 0, wm8940_adc_tlv),
+	SOC_ENUM("Mic Bias Level", wm8940_mic_bias_level_enum),
+	SOC_SINGLE_TLV("Capture Boost Volue", WM8940_ADCBOOST,
+		       8, 1, 0, wm8940_capture_boost_vol_tlv),
+	SOC_SINGLE_TLV("Speaker Playback Volume", WM8940_SPKVOL,
+		       0, 63, 0, wm8940_spk_vol_tlv),
+	SOC_SINGLE("Speaker Playback Switch", WM8940_SPKVOL,  6, 1, 1),
+
+	SOC_SINGLE_TLV("Speaker Mixer Line Bypass Volume", WM8940_SPKVOL,
+		       8, 1, 1, wm8940_att_tlv),
+	SOC_SINGLE("Speaker Playback ZC Switch", WM8940_SPKVOL, 7, 1, 0),
+
+	SOC_SINGLE("Mono Out Switch", WM8940_MONOMIX, 6, 1, 1),
+	SOC_SINGLE_TLV("Mono Mixer Line Bypass Volume", WM8940_MONOMIX,
+		       7, 1, 1, wm8940_att_tlv),
+
+	SOC_SINGLE("High Pass Filter Switch", WM8940_ADC, 8, 1, 0),
+	SOC_ENUM("High Pass Filter Mode", wm8940_filter_mode_enum),
+	SOC_SINGLE("High Pass Filter Cut Off", WM8940_ADC, 4, 7, 0),
+	SOC_SINGLE("ADC Inversion Switch", WM8940_ADC, 0, 1, 0),
+	SOC_SINGLE("DAC Inversion Switch", WM8940_DAC, 0, 1, 0),
+	SOC_SINGLE("DAC Auto Mute Switch", WM8940_DAC, 2, 1, 0),
+	SOC_SINGLE("ZC Timeout Clock Switch", WM8940_ADDCNTRL, 0, 1, 0),
+};
+
+static const struct snd_kcontrol_new wm8940_speaker_mixer_controls[] = {
+	SOC_DAPM_SINGLE("Line Bypass Switch", WM8940_SPKMIX, 1, 1, 0),
+	SOC_DAPM_SINGLE("Aux Playback Switch", WM8940_SPKMIX, 5, 1, 0),
+	SOC_DAPM_SINGLE("PCM Playback Switch", WM8940_SPKMIX, 0, 1, 0),
+};
+
+static const struct snd_kcontrol_new wm8940_mono_mixer_controls[] = {
+	SOC_DAPM_SINGLE("Line Bypass Switch", WM8940_MONOMIX, 1, 1, 0),
+	SOC_DAPM_SINGLE("Aux Playback Switch", WM8940_MONOMIX, 2, 1, 0),
+	SOC_DAPM_SINGLE("PCM Playback Switch", WM8940_MONOMIX, 0, 1, 0),
+};
+
+DECLARE_TLV_DB_SCALE(wm8940_boost_vol_tlv, -1500, 300, 1);
+static const struct snd_kcontrol_new wm8940_input_boost_controls[] = {
+	SOC_DAPM_SINGLE("Mic PGA Switch", WM8940_PGAGAIN, 6, 1, 1),
+	SOC_DAPM_SINGLE_TLV("Aux Volume", WM8940_ADCBOOST,
+			    0, 7, 0, wm8940_boost_vol_tlv),
+	SOC_DAPM_SINGLE_TLV("Mic Volume", WM8940_ADCBOOST,
+			    4, 7, 0, wm8940_boost_vol_tlv),
+};
+
+static const struct snd_kcontrol_new wm8940_micpga_controls[] = {
+	SOC_DAPM_SINGLE("AUX Switch", WM8940_INPUTCTL, 2, 1, 0),
+	SOC_DAPM_SINGLE("MICP Switch", WM8940_INPUTCTL, 0, 1, 0),
+	SOC_DAPM_SINGLE("MICN Switch", WM8940_INPUTCTL, 1, 1, 0),
+};
+
+static const struct snd_soc_dapm_widget wm8940_dapm_widgets[] = {
+	SND_SOC_DAPM_MIXER("Speaker Mixer", WM8940_POWER3, 2, 0,
+			   &wm8940_speaker_mixer_controls[0],
+			   ARRAY_SIZE(wm8940_speaker_mixer_controls)),
+	SND_SOC_DAPM_MIXER("Mono Mixer", WM8940_POWER3, 3, 0,
+			   &wm8940_mono_mixer_controls[0],
+			   ARRAY_SIZE(wm8940_mono_mixer_controls)),
+	SND_SOC_DAPM_DAC("DAC", "HiFi Playback", WM8940_POWER3, 0, 0),
+
+	SND_SOC_DAPM_PGA("SpkN Out", WM8940_POWER3, 5, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("SpkP Out", WM8940_POWER3, 6, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Mono Out", WM8940_POWER3, 7, 0, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("MONOOUT"),
+	SND_SOC_DAPM_OUTPUT("SPKOUTP"),
+	SND_SOC_DAPM_OUTPUT("SPKOUTN"),
+
+	SND_SOC_DAPM_PGA("Aux Input", WM8940_POWER1, 6, 0, NULL, 0),
+	SND_SOC_DAPM_ADC("ADC", "HiFi Capture", WM8940_POWER2, 0, 0),
+	SND_SOC_DAPM_MIXER("Mic PGA", WM8940_POWER2, 2, 0,
+			   &wm8940_micpga_controls[0],
+			   ARRAY_SIZE(wm8940_micpga_controls)),
+	SND_SOC_DAPM_MIXER("Boost Mixer", WM8940_POWER2, 4, 0,
+			   &wm8940_input_boost_controls[0],
+			   ARRAY_SIZE(wm8940_input_boost_controls)),
+	SND_SOC_DAPM_MICBIAS("Mic Bias", WM8940_POWER1, 4, 0),
+
+	SND_SOC_DAPM_INPUT("MICN"),
+	SND_SOC_DAPM_INPUT("MICP"),
+	SND_SOC_DAPM_INPUT("AUX"),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	/* Mono output mixer */
+	{"Mono Mixer", "PCM Playback Switch", "DAC"},
+	{"Mono Mixer", "Aux Playback Switch", "Aux Input"},
+	{"Mono Mixer", "Line Bypass Switch", "Boost Mixer"},
+
+	/* Speaker output mixer */
+	{"Speaker Mixer", "PCM Playback Switch", "DAC"},
+	{"Speaker Mixer", "Aux Playback Switch", "Aux Input"},
+	{"Speaker Mixer", "Line Bypass Switch", "Boost Mixer"},
+
+	/* Outputs */
+	{"Mono Out", NULL, "Mono Mixer"},
+	{"MONOOUT", NULL, "Mono Out"},
+	{"SpkN Out", NULL, "Speaker Mixer"},
+	{"SpkP Out", NULL, "Speaker Mixer"},
+	{"SPKOUTN", NULL, "SpkN Out"},
+	{"SPKOUTP", NULL, "SpkP Out"},
+
+	/*  Microphone PGA */
+	{"Mic PGA", "MICN Switch", "MICN"},
+	{"Mic PGA", "MICP Switch", "MICP"},
+	{"Mic PGA", "AUX Switch", "AUX"},
+
+	/* Boost Mixer */
+	{"Boost Mixer", "Mic PGA Switch", "Mic PGA"},
+	{"Boost Mixer", "Mic Volume",  "MICP"},
+	{"Boost Mixer", "Aux Volume", "Aux Input"},
+
+	{"ADC", NULL, "Boost Mixer"},
+};
+
+static int wm8940_add_widgets(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	ret = snd_soc_dapm_new_controls(codec, wm8940_dapm_widgets,
+					ARRAY_SIZE(wm8940_dapm_widgets));
+	if (ret)
+		goto error_ret;
+	ret = snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	if (ret)
+		goto error_ret;
+	ret = snd_soc_dapm_new_widgets(codec);
+
+error_ret:
+	return ret;
+}
+
+#define wm8940_reset(c) wm8940_write(c, WM8940_SOFTRESET, 0);
+
+static int wm8940_set_dai_fmt(struct snd_soc_dai *codec_dai,
+			      unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	u16 iface = wm8940_read_reg_cache(codec, WM8940_IFACE) & 0xFE67;
+	u16 clk = wm8940_read_reg_cache(codec, WM8940_CLOCK) & 0x1fe;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		clk |= 1;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
+	wm8940_write(codec, WM8940_CLOCK, clk);
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		iface |= (2 << 3);
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		iface |= (1 << 3);
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		iface |= (3 << 3);
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		iface |= (3 << 3) | (1 << 7);
+		break;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		iface |= (1 << 7);
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		iface |= (1 << 8);
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		iface |= (1 << 8) | (1 << 7);
+		break;
+	}
+
+	wm8940_write(codec, WM8940_IFACE, iface);
+
+	return 0;
+}
+
+static int wm8940_i2s_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	u16 iface = wm8940_read_reg_cache(codec, WM8940_IFACE) & 0xFD9F;
+	u16 addcntrl = wm8940_read_reg_cache(codec, WM8940_ADDCNTRL) & 0xFFF1;
+	u16 companding =  wm8940_read_reg_cache(codec,
+						WM8940_COMPANDINGCTL) & 0xFFDF;
+	int ret;
+
+	/* LoutR control */
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE
+	    && params_channels(params) == 2)
+		iface |= (1 << 9);
+
+	switch (params_rate(params)) {
+	case SNDRV_PCM_RATE_8000:
+		addcntrl |= (0x5 << 1);
+		break;
+	case SNDRV_PCM_RATE_11025:
+		addcntrl |= (0x4 << 1);
+		break;
+	case SNDRV_PCM_RATE_16000:
+		addcntrl |= (0x3 << 1);
+		break;
+	case SNDRV_PCM_RATE_22050:
+		addcntrl |= (0x2 << 1);
+		break;
+	case SNDRV_PCM_RATE_32000:
+		addcntrl |= (0x1 << 1);
+		break;
+	case SNDRV_PCM_RATE_44100:
+	case SNDRV_PCM_RATE_48000:
+		break;
+	}
+	ret = wm8940_write(codec, WM8940_ADDCNTRL, addcntrl);
+	if (ret)
+		goto error_ret;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		companding = companding | (1 << 5);
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		iface |= (1 << 5);
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		iface |= (2 << 5);
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		iface |= (3 << 5);
+		break;
+	}
+	ret = wm8940_write(codec, WM8940_COMPANDINGCTL, companding);
+	if (ret)
+		goto error_ret;
+	ret = wm8940_write(codec, WM8940_IFACE, iface);
+
+error_ret:
+	return ret;
+}
+
+static int wm8940_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u16 mute_reg = wm8940_read_reg_cache(codec, WM8940_DAC) & 0xffbf;
+
+	if (mute)
+		mute_reg |= 0x40;
+
+	return wm8940_write(codec, WM8940_DAC, mute_reg);
+}
+
+static int wm8940_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
+{
+	u16 val;
+	u16 pwr_reg = wm8940_read_reg_cache(codec, WM8940_POWER1) & 0x1F0;
+	int ret = 0;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		/* ensure bufioen and biasen */
+		pwr_reg |= (1 << 2) | (1 << 3);
+		/* Enable thermal shutdown */
+		val = wm8940_read_reg_cache(codec, WM8940_OUTPUTCTL);
+		ret = wm8940_write(codec, WM8940_OUTPUTCTL, val | 0x2);
+		if (ret)
+			break;
+		/* set vmid to 75k */
+		ret = wm8940_write(codec, WM8940_POWER1, pwr_reg | 0x1);
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		/* ensure bufioen and biasen */
+		pwr_reg |= (1 << 2) | (1 << 3);
+		ret = wm8940_write(codec, WM8940_POWER1, pwr_reg | 0x1);
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		/* ensure bufioen and biasen */
+		pwr_reg |= (1 << 2) | (1 << 3);
+		/* set vmid to 300k for standby */
+		ret = wm8940_write(codec, WM8940_POWER1, pwr_reg | 0x2);
+		break;
+	case SND_SOC_BIAS_OFF:
+		ret = wm8940_write(codec, WM8940_POWER1, pwr_reg);
+		break;
+	}
+
+	return ret;
+}
+
+struct pll_ {
+	unsigned int pre_scale:2;
+	unsigned int n:4;
+	unsigned int k;
+};
+
+static struct pll_ pll_div;
+
+/* The size in bits of the pll divide multiplied by 10
+ * to allow rounding later */
+#define FIXED_PLL_SIZE ((1 << 24) * 10)
+static void pll_factors(unsigned int target, unsigned int source)
+{
+	unsigned long long Kpart;
+	unsigned int K, Ndiv, Nmod;
+	/* The left shift ist to avoid accuracy loss when right shifting */
+	Ndiv = target / source;
+
+	if (Ndiv > 12) {
+		source <<= 1;
+		/* Multiply by 2 */
+		pll_div.pre_scale = 0;
+		Ndiv = target / source;
+	} else if (Ndiv < 3) {
+		source >>= 2;
+		/* Divide by 4 */
+		pll_div.pre_scale = 3;
+		Ndiv = target / source;
+	} else if (Ndiv < 6) {
+		source >>= 1;
+		/* divide by 2 */
+		pll_div.pre_scale = 2;
+		Ndiv = target / source;
+	} else
+		pll_div.pre_scale = 1;
+
+	if ((Ndiv < 6) || (Ndiv > 12))
+		printk(KERN_WARNING
+			"WM8940 N value %d outwith recommended range!d\n",
+			Ndiv);
+
+	pll_div.n = Ndiv;
+	Nmod = target % source;
+	Kpart = FIXED_PLL_SIZE * (long long)Nmod;
+
+	do_div(Kpart, source);
+
+	K = Kpart & 0xFFFFFFFF;
+
+	/* Check if we need to round */
+	if ((K % 10) >= 5)
+		K += 5;
+
+	/* Move down to proper range now rounding is done */
+	K /= 10;
+
+	pll_div.k = K;
+}
+
+/* Untested at the moment */
+static int wm8940_set_dai_pll(struct snd_soc_dai *codec_dai,
+		int pll_id, unsigned int freq_in, unsigned int freq_out)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	u16 reg;
+
+	/* Turn off PLL */
+	reg = wm8940_read_reg_cache(codec, WM8940_POWER1);
+	wm8940_write(codec, WM8940_POWER1, reg & 0x1df);
+
+	if (freq_in == 0 || freq_out == 0) {
+		/* Clock CODEC directly from MCLK */
+		reg = wm8940_read_reg_cache(codec, WM8940_CLOCK);
+		wm8940_write(codec, WM8940_CLOCK, reg & 0x0ff);
+		/* Pll power down */
+		wm8940_write(codec, WM8940_PLLN, (1 << 7));
+		return 0;
+	}
+
+	/* Pll is followed by a frequency divide by 4 */
+	pll_factors(freq_out*4, freq_in);
+	if (pll_div.k)
+		wm8940_write(codec, WM8940_PLLN,
+			     (pll_div.pre_scale << 4) | pll_div.n | (1 << 6));
+	else /* No factional component */
+		wm8940_write(codec, WM8940_PLLN,
+			     (pll_div.pre_scale << 4) | pll_div.n);
+	wm8940_write(codec, WM8940_PLLK1, pll_div.k >> 18);
+	wm8940_write(codec, WM8940_PLLK2, (pll_div.k >> 9) & 0x1ff);
+	wm8940_write(codec, WM8940_PLLK3, pll_div.k & 0x1ff);
+	/* Enable the PLL */
+	reg = wm8940_read_reg_cache(codec, WM8940_POWER1);
+	wm8940_write(codec, WM8940_POWER1, reg | 0x020);
+
+	/* Run CODEC from PLL instead of MCLK */
+	reg = wm8940_read_reg_cache(codec, WM8940_CLOCK);
+	wm8940_write(codec, WM8940_CLOCK, reg | 0x100);
+
+	return 0;
+}
+
+static int wm8940_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+				 int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct wm8940_priv *wm8940 = codec->private_data;
+
+	switch (freq) {
+	case 11289600:
+	case 12000000:
+	case 12288000:
+	case 16934400:
+	case 18432000:
+		wm8940->sysclk = freq;
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static int wm8940_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
+				 int div_id, int div)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	u16 reg;
+	int ret = 0;
+
+	switch (div_id) {
+	case WM8940_BCLKDIV:
+		reg = wm8940_read_reg_cache(codec, WM8940_CLOCK) & 0xFFEF3;
+		ret = wm8940_write(codec, WM8940_CLOCK, reg | (div << 2));
+		break;
+	case WM8940_MCLKDIV:
+		reg = wm8940_read_reg_cache(codec, WM8940_CLOCK) & 0xFF1F;
+		ret = wm8940_write(codec, WM8940_CLOCK, reg | (div << 5));
+		break;
+	case WM8940_OPCLKDIV:
+		reg = wm8940_read_reg_cache(codec, WM8940_ADDCNTRL) & 0xFFCF;
+		ret = wm8940_write(codec, WM8940_ADDCNTRL, reg | (div << 4));
+		break;
+	}
+	return ret;
+}
+
+#define WM8940_RATES SNDRV_PCM_RATE_8000_48000
+
+#define WM8940_FORMATS (SNDRV_PCM_FMTBIT_S8 |				\
+			SNDRV_PCM_FMTBIT_S16_LE |			\
+			SNDRV_PCM_FMTBIT_S20_3LE |			\
+			SNDRV_PCM_FMTBIT_S24_LE |			\
+			SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_ops wm8940_dai_ops = {
+	.hw_params = wm8940_i2s_hw_params,
+	.set_sysclk = wm8940_set_dai_sysclk,
+	.digital_mute = wm8940_mute,
+	.set_fmt = wm8940_set_dai_fmt,
+	.set_clkdiv = wm8940_set_dai_clkdiv,
+	.set_pll = wm8940_set_dai_pll,
+};
+
+struct snd_soc_dai wm8940_dai = {
+	.name = "WM8940",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = WM8940_RATES,
+		.formats = WM8940_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = WM8940_RATES,
+		.formats = WM8940_FORMATS,
+	},
+	.ops = &wm8940_dai_ops,
+	.symmetric_rates = 1,
+};
+EXPORT_SYMBOL_GPL(wm8940_dai);
+
+static int wm8940_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	return wm8940_set_bias_level(codec, SND_SOC_BIAS_OFF);
+}
+
+static int wm8940_resume(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+	int i;
+	int ret;
+	u8 data[3];
+	u16 *cache = codec->reg_cache;
+
+	/* Sync reg_cache with the hardware
+	 * Could use auto incremented writes to speed this up
+	 */
+	for (i = 0; i < ARRAY_SIZE(wm8940_reg_defaults); i++) {
+		data[0] = i;
+		data[1] = (cache[i] & 0xFF00) >> 8;
+		data[2] = cache[i] & 0x00FF;
+		ret = codec->hw_write(codec->control_data, data, 3);
+		if (ret < 0)
+			goto error_ret;
+		else if (ret != 3) {
+			ret = -EIO;
+			goto error_ret;
+		}
+	}
+	ret = wm8940_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	if (ret)
+		goto error_ret;
+	ret = wm8940_set_bias_level(codec, codec->suspend_bias_level);
+
+error_ret:
+	return ret;
+}
+
+static struct snd_soc_codec *wm8940_codec;
+
+static int wm8940_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+
+	int ret = 0;
+
+	if (wm8940_codec == NULL) {
+		dev_err(&pdev->dev, "Codec device not registered\n");
+		return -ENODEV;
+	}
+
+	socdev->card->codec = wm8940_codec;
+	codec = wm8940_codec;
+
+	mutex_init(&codec->mutex);
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
+		goto pcm_err;
+	}
+
+	ret = snd_soc_add_controls(codec, wm8940_snd_controls,
+			     ARRAY_SIZE(wm8940_snd_controls));
+	if (ret)
+		goto error_free_pcms;
+	ret = wm8940_add_widgets(codec);
+	if (ret)
+		goto error_free_pcms;
+
+	ret = snd_soc_init_card(socdev);
+	if (ret < 0) {
+		dev_err(codec->dev, "failed to register card: %d\n", ret);
+		goto error_free_pcms;
+	}
+
+	return ret;
+
+error_free_pcms:
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+pcm_err:
+	return ret;
+}
+
+static int wm8940_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_wm8940 = {
+	.probe = wm8940_probe,
+	.remove = wm8940_remove,
+	.suspend = wm8940_suspend,
+	.resume = wm8940_resume,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_wm8940);
+
+static int wm8940_register(struct wm8940_priv *wm8940)
+{
+	struct wm8940_setup_data *pdata = wm8940->codec.dev->platform_data;
+	struct snd_soc_codec *codec = &wm8940->codec;
+	int ret;
+	u16 reg;
+	if (wm8940_codec) {
+		dev_err(codec->dev, "Another WM8940 is registered\n");
+		return -EINVAL;
+	}
+
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	codec->private_data = wm8940;
+	codec->name = "WM8940";
+	codec->owner = THIS_MODULE;
+	codec->read = wm8940_read_reg_cache;
+	codec->write = wm8940_write;
+	codec->bias_level = SND_SOC_BIAS_OFF;
+	codec->set_bias_level = wm8940_set_bias_level;
+	codec->dai = &wm8940_dai;
+	codec->num_dai = 1;
+	codec->reg_cache_size = ARRAY_SIZE(wm8940_reg_defaults);
+	codec->reg_cache = &wm8940->reg_cache;
+
+	memcpy(codec->reg_cache, wm8940_reg_defaults,
+	       sizeof(wm8940_reg_defaults));
+
+	ret = wm8940_reset(codec);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to issue reset\n");
+		return ret;
+	}
+
+	wm8940_dai.dev = codec->dev;
+
+	wm8940_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	ret = wm8940_write(codec, WM8940_POWER1, 0x180);
+	if (ret < 0)
+		return ret;
+
+	if (!pdata)
+		dev_warn(codec->dev, "No platform data supplied\n");
+	else {
+		reg = wm8940_read_reg_cache(codec, WM8940_OUTPUTCTL);
+		ret = wm8940_write(codec, WM8940_OUTPUTCTL, reg | pdata->vroi);
+		if (ret < 0)
+			return ret;
+	}
+
+
+	wm8940_codec = codec;
+
+	ret = snd_soc_register_codec(codec);
+	if (ret) {
+		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_register_dai(&wm8940_dai);
+	if (ret) {
+		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
+		snd_soc_unregister_codec(codec);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void wm8940_unregister(struct wm8940_priv *wm8940)
+{
+	wm8940_set_bias_level(&wm8940->codec, SND_SOC_BIAS_OFF);
+	snd_soc_unregister_dai(&wm8940_dai);
+	snd_soc_unregister_codec(&wm8940->codec);
+	kfree(wm8940);
+	wm8940_codec = NULL;
+}
+
+static int wm8940_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	struct wm8940_priv *wm8940;
+	struct snd_soc_codec *codec;
+
+	wm8940 = kzalloc(sizeof *wm8940, GFP_KERNEL);
+	if (wm8940 == NULL)
+		return -ENOMEM;
+
+	codec = &wm8940->codec;
+	codec->hw_write = (hw_write_t)i2c_master_send;
+	i2c_set_clientdata(i2c, wm8940);
+	codec->control_data = i2c;
+	codec->dev = &i2c->dev;
+
+	return wm8940_register(wm8940);
+}
+
+static int wm8940_i2c_remove(struct i2c_client *client)
+{
+	struct wm8940_priv *wm8940 = i2c_get_clientdata(client);
+
+	wm8940_unregister(wm8940);
+
+	return 0;
+}
+
+static const struct i2c_device_id wm8940_i2c_id[] = {
+	{ "wm8940", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, wm8940_i2c_id);
+
+static struct i2c_driver wm8940_i2c_driver = {
+	.driver = {
+		.name = "WM8940 I2C Codec",
+		.owner = THIS_MODULE,
+	},
+	.probe = wm8940_i2c_probe,
+	.remove = __devexit_p(wm8940_i2c_remove),
+	.id_table = wm8940_i2c_id,
+};
+
+static int __init wm8940_modinit(void)
+{
+	int ret;
+
+	ret = i2c_add_driver(&wm8940_i2c_driver);
+	if (ret)
+		printk(KERN_ERR "Failed to register WM8940 I2C driver: %d\n",
+		       ret);
+	return ret;
+}
+module_init(wm8940_modinit);
+
+static void __exit wm8940_exit(void)
+{
+	i2c_del_driver(&wm8940_i2c_driver);
+}
+module_exit(wm8940_exit);
+
+MODULE_DESCRIPTION("ASoC WM8940 driver");
+MODULE_AUTHOR("Jonathan Cameron");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm8940.h b/sound/soc/codecs/wm8940.h
new file mode 100644
index 0000000..8410eed
--- /dev/null
+++ b/sound/soc/codecs/wm8940.h
@@ -0,0 +1,104 @@
+/*
+ * wm8940.h -- WM8940 Soc Audio driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _WM8940_H
+#define _WM8940_H
+
+struct wm8940_setup_data {
+	/* Vref to analogue output resistance */
+#define WM8940_VROI_1K 0
+#define WM8940_VROI_30K 1
+	unsigned int vroi:1;
+};
+extern struct snd_soc_dai wm8940_dai;
+extern struct snd_soc_codec_device soc_codec_dev_wm8940;
+
+/* WM8940 register space */
+#define WM8940_SOFTRESET	0x00
+#define WM8940_POWER1		0x01
+#define WM8940_POWER2		0x02
+#define WM8940_POWER3		0x03
+#define WM8940_IFACE		0x04
+#define WM8940_COMPANDINGCTL	0x05
+#define WM8940_CLOCK		0x06
+#define WM8940_ADDCNTRL		0x07
+#define WM8940_GPIO		0x08
+#define WM8940_CTLINT		0x09
+#define WM8940_DAC		0x0A
+#define WM8940_DACVOL		0x0B
+
+#define WM8940_ADC		0x0E
+#define WM8940_ADCVOL		0x0F
+#define WM8940_NOTCH1		0x10
+#define WM8940_NOTCH2		0x11
+#define WM8940_NOTCH3		0x12
+#define WM8940_NOTCH4		0x13
+#define WM8940_NOTCH5		0x14
+#define WM8940_NOTCH6		0x15
+#define WM8940_NOTCH7		0x16
+#define WM8940_NOTCH8		0x17
+#define WM8940_DACLIM1		0x18
+#define WM8940_DACLIM2		0x19
+
+#define WM8940_ALC1		0x20
+#define WM8940_ALC2		0x21
+#define WM8940_ALC3		0x22
+#define WM8940_NOISEGATE	0x23
+#define WM8940_PLLN		0x24
+#define WM8940_PLLK1		0x25
+#define WM8940_PLLK2		0x26
+#define WM8940_PLLK3		0x27
+
+#define WM8940_ALC4		0x2A
+
+#define WM8940_INPUTCTL		0x2C
+#define WM8940_PGAGAIN		0x2D
+
+#define WM8940_ADCBOOST		0x2F
+
+#define WM8940_OUTPUTCTL	0x31
+#define WM8940_SPKMIX		0x32
+
+#define WM8940_SPKVOL		0x36
+
+#define WM8940_MONOMIX		0x38
+
+#define WM8940_CACHEREGNUM  0x57
+
+
+/* Clock divider Id's */
+#define WM8940_BCLKDIV 0
+#define WM8940_MCLKDIV 1
+#define WM8940_OPCLKDIV 2
+
+/* MCLK clock dividers */
+#define WM8940_MCLKDIV_1	0
+#define WM8940_MCLKDIV_1_5	1
+#define WM8940_MCLKDIV_2	2
+#define WM8940_MCLKDIV_3	3
+#define WM8940_MCLKDIV_4	4
+#define WM8940_MCLKDIV_6	5
+#define WM8940_MCLKDIV_8	6
+#define WM8940_MCLKDIV_12	7
+
+/* BCLK clock dividers */
+#define WM8940_BCLKDIV_1 0
+#define WM8940_BCLKDIV_2 1
+#define WM8940_BCLKDIV_4 2
+#define WM8940_BCLKDIV_8 3
+#define WM8940_BCLKDIV_16 4
+#define WM8940_BCLKDIV_32 5
+
+/* PLL Out Dividers */
+#define WM8940_OPCLKDIV_1 0
+#define WM8940_OPCLKDIV_2 1
+#define WM8940_OPCLKDIV_3 2
+#define WM8940_OPCLKDIV_4 3
+
+#endif /* _WM8940_H */
+
