From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [RFC] SoC WM8940 Driver
Date: Fri, 24 Apr 2009 19:29:20 +0000
Message-ID: <49F21310.4060009@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ppsw-0.csi.cam.ac.uk (ppsw-0.csi.cam.ac.uk [131.111.8.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FA792446B
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Apr 2009 21:29:06 +0200 (CEST)
Received: from coriolanus.eng.cam.ac.uk ([129.169.154.144]:60993)
	by ppsw-0.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.150]:25)
	with esmtpsa (PLAIN:jic23) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1LxR57-0001Ho-1k (Exim 4.70) for alsa-devel@alsa-project.org
	(return-path <jic23@cam.ac.uk>); Fri, 24 Apr 2009 20:29:05 +0100
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
List-Id: alsa-devel@alsa-project.org

From: Jonathan Cameron <jic23@cam.ac.uk>

Initial support for the WM8940 Mono Codec with speaker driver

---

This is my first foray into the world of alsa and aSoC, so I thought I'd
make an initial posting of this driver before getting bogged down in
testing every last feature works.

The board I have has it wired up to i2c limiting options for interface
testing and I've currently only tested it as a slave to a pxa271 using
i2s. Board is an xbow Imote 2.

I will hopefully be able to test a few other interface combinations.

All comments welcomed! My apologies if parts of this are complete rubbish!

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
new file mode 100644
index 0000000..3491b9c
--- /dev/null
+++ b/sound/soc/codecs/wm8940.c
@@ -0,0 +1,921 @@
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
+ * VROI (resistance control for unused outputs.
+ * AUXMode (inverting vs mixer)
+ * No means to obtain current gain if alc enabled.
+ * No use made of gpio
+ * Auto increment writes (can't think why you'd want to disable it!
+ * Fast VMID discharge for power down
+ * Soft Start.
+ * LoutR control
+ * DLR and ALR Swaps not enabled
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
+	unsigned int mode;
+	unsigned int clk_inversion;
+};
+
+static u16 wm8940_reg_defaults[] = {
+	[WM8940_SOFTRESET] =		0x8940,
+	[WM8940_POWER1] =		0x0000,
+	[WM8940_POWER2] =		0x0000,
+	[WM8940_POWER3] =		0x0000,
+	[WM8940_IFACE] =		0x0010,
+	[WM8940_COMPANDINGCTL] =	0x0000,
+	[WM8940_CLOCK] =		0x0140,
+	[WM8940_ADDCNTRL] =		0x0000,
+	[WM8940_GPIO] =			0x0000,
+	[WM8940_CTLINT] =		0x0002,
+	[WM8940_DAC] =			0x0000,
+	[WM8940_DACVOL] =		0x00FF,
+
+	[WM8940_ADC] =			0x0100,
+	[WM8940_ADCVOL] =		0x00FF,
+	[WM8940_NOTCH1 ... WM8940_NOTCH8] = 0x0000,
+	[WM8940_DACLIM1] =		0x0032,
+	[WM8940_DACLIM2] =		0x0000,
+
+	[WM8940_ALC1] =			0x0038,
+	[WM8940_ALC2] =			0x000B,
+	[WM8940_ALC3] =			0x0032,
+	[WM8940_NOISEGATE] =		0x0000,
+	[WM8940_PLLN] =			0x0041,
+	[WM8940_PLLK1] =		0x000C,
+	[WM8940_PLLK2] =		0x0093,
+	[WM8940_PLLK3] =		0x00E9,
+
+	[WM8940_ALC4] =			0x0030,
+
+	[WM8940_INPUTCTL] =		0x0002,
+	[WM8940_PGAGAIN] =		0x0050,
+
+	[WM8940_ADCBOOST] =		0x0002,
+
+	[WM8940_OUTPUTCTL] =		0x0002,
+	[WM8940_SPKMIX] =		0x0000,
+
+	[WM8940_SPKVOL] =		0x0079,
+
+	[WM8940_MONOMIX] =		0x0000,
+};
+
+struct snd_soc_codec_device soc_codec_dev_wm8940;
+
+#define WM8940_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |	\
+		      SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |	\
+		      SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
+
+#define WM8940_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |			\
+			SNDRV_PCM_FMTBIT_S20_3LE |			\
+			SNDRV_PCM_FMTBIT_S24_LE |			\
+			SNDRV_PCM_FMTBIT_S32_LE)
+
+
+static inline unsigned int wm8940_read_reg_cache(struct snd_soc_codec *codec,
+						 unsigned int reg)
+{
+	u16 *cache = codec->reg_cache;
+
+	if (reg > ARRAY_SIZE(wm8940_reg_defaults))
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
+	if (reg > ARRAY_SIZE(wm8940_reg_defaults))
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
+	u8 data[3] = { reg,
+		       (value & 0xff00) >> 8,
+		       (value & 0x00ff)
+	};
+
+	wm8940_write_reg_cache(codec, reg, value);
+
+	return (codec->hw_write(codec->control_data, data, 3) == 3) ? 0 : -EIO;
+
+}
+
+static const char *wm8940_companding[] = { "Off", "NC", "u-law", "A-law" };
+static const char *wm8940_alc_mode_text[] = {"ALC", "Limiter"};
+static const char *wm8940_mic_bias_levels_text[] = {"0.9", "0.65"};
+static const char *wm8940_filter_mode_text[] = {"Audio", "Application"};
+
+static const struct soc_enum wm8940_enum[] = {
+	SOC_ENUM_SINGLE(WM8940_COMPANDINGCTL, 1, 4, wm8940_companding),
+	SOC_ENUM_SINGLE(WM8940_COMPANDINGCTL, 3, 4, wm8940_companding),
+	SOC_ENUM_SINGLE(WM8940_ALC3, 8, 2, wm8940_alc_mode_text),
+	SOC_ENUM_SINGLE(WM8940_INPUTCTL, 8, 2, wm8940_mic_bias_levels_text),
+	SOC_ENUM_SINGLE(WM8940_ADC, 7, 2, wm8940_filter_mode_text),
+};
+
+DECLARE_TLV_DB_SCALE(wm8940_spk_vol_tlv, -5700, 100, 1);
+DECLARE_TLV_DB_SCALE(wm8940_att_tlv, -1000, 1000, 0);
+DECLARE_TLV_DB_SCALE(wm8940_pga_vol_tlv, -1200, 75, 0);
+DECLARE_TLV_DB_SCALE(wm8940_alc_min_tlv, -1200, 600, 0);
+DECLARE_TLV_DB_SCALE(wm8940_alc_max_tlv, 675, 600, 0);
+DECLARE_TLV_DB_SCALE(wm8940_alc_tar_tlv, -2250, 50, 0);
+DECLARE_TLV_DB_SCALE(wm8940_lim_boost_tlv, 0, 100, 0);
+DECLARE_TLV_DB_SCALE(wm8940_lim_thresh_tlv, -600, 100, 0);
+DECLARE_TLV_DB_SCALE(wm8940_adc_tlv, -127500, 50, 1);
+
+static const struct snd_kcontrol_new wm8940_snd_controls[] = {
+	SOC_SINGLE("Digital Loopback Switch dac to adc", WM8940_COMPANDINGCTL,
+		   6, 1, 0),
+	SOC_ENUM("DAC Companding", wm8940_enum[1]),
+	SOC_ENUM("ADC Companding", wm8940_enum[0]),
+	SOC_SINGLE("Companding 8 bit", WM8940_COMPANDINGCTL, 5, 1, 0),
+	SOC_SINGLE("Digital Loopback Switch adc to dac", WM8940_COMPANDINGCTL,
+		   0, 1, 0),
+
+	/* Auto level control */
+	SOC_ENUM("ALC Mode", wm8940_enum[2]),
+	SOC_SINGLE("ALC Enable Switch", WM8940_ALC1, 8, 1, 0),
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
+	SOC_ENUM("Mic Bias Level", wm8940_enum[3]),
+	SOC_SINGLE("Capture Boost(+20dB)", WM8940_ADCBOOST, 8, 1, 0),
+
+	SOC_SINGLE_TLV("Speaker Playback Volume", WM8940_SPKVOL,
+		       0, 63, 0, wm8940_spk_vol_tlv),
+	SOC_SINGLE("Speaker Playback Mute", WM8940_SPKVOL,  6, 1, 0),
+	SOC_SINGLE_TLV("Speaker Playback Attenuation", WM8940_SPKVOL,
+		       8, 1, 1, wm8940_att_tlv),
+	SOC_SINGLE("Speaker Playback ZC", WM8940_SPKVOL, 7, 1, 0),
+
+	SOC_SINGLE("Mono Out Mute", WM8940_MONOMIX, 6, 1, 0),
+	SOC_SINGLE_TLV("Mono Out Attenuation", WM8940_MONOMIX,
+		       7, 1, 1, wm8940_att_tlv),
+
+	SOC_SINGLE("High Pass Filter Switch", WM8940_ADC, 8, 1, 0),
+	SOC_ENUM("High Pass Filter Mode", wm8940_enum[4]),
+	SOC_SINGLE("High Pass Filter Cut Off", WM8940_ADC, 4, 7, 0),
+	SOC_SINGLE("ADC Inversion Switch", WM8940_ADC, 0, 1, 0),
+	SOC_SINGLE("DAC Inversion Switch", WM8940_DAC, 0, 1, 0),
+	SOC_SINGLE("DAC Auto Mute Switch", WM8940_DAC, 2, 1, 0),
+	SOC_SINGLE("ZC Timeout Clock Enable Switch", WM8940_ADDCNTRL, 0, 1, 0),
+
+	/* Notch filters */
+	SOC_SINGLE("Notch Filter 1 Switch", WM8940_NOTCH1, 14, 1, 0),
+	SOC_SINGLE("Notch Filter 2 Switch", WM8940_NOTCH3, 14, 1, 0),
+	SOC_SINGLE("Notch Filter 3 Switch", WM8940_NOTCH5, 14, 1, 0),
+	SOC_SINGLE("Notch Filter 4 Switch", WM8940_NOTCH7, 14, 1, 0),
+
+	SOC_SINGLE("Notch Filter 1 Update Switch", WM8940_NOTCH1, 15, 1, 0),
+	SOC_SINGLE("Notch Filter 2 Update Switch", WM8940_NOTCH3, 15, 1, 0),
+	SOC_SINGLE("Notch Filter 3 Update Switch", WM8940_NOTCH5, 15, 1, 0),
+	SOC_SINGLE("Notch Filter 4 Update Switch", WM8940_NOTCH7, 15, 1, 0),
+
+	SOC_SINGLE("Notch Filter 1 Coefficient a0", WM8940_NOTCH1, 0, 16383, 1),
+	SOC_SINGLE("Notch Filter 2 Coefficient a0", WM8940_NOTCH3, 0, 16383, 1),
+	SOC_SINGLE("Notch Filter 3 Coefficient a0", WM8940_NOTCH5, 0, 16383, 1),
+	SOC_SINGLE("Notch Filter 4 Coefficient a0", WM8940_NOTCH7, 0, 16383, 1),
+
+	SOC_SINGLE("Notch Filter 1 Coefficient a1", WM8940_NOTCH2, 0, 16383, 1),
+	SOC_SINGLE("Notch Filter 2 Coefficient a1", WM8940_NOTCH4, 0, 16383, 1),
+	SOC_SINGLE("Notch Filter 3 Coefficient a1", WM8940_NOTCH6, 0, 16383, 1),
+	SOC_SINGLE("Notch Filter 4 Coefficient a1", WM8940_NOTCH8, 0, 16383, 1),
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
+
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
+	 {"ADC", NULL, "Boost Mixer"},
+};
+
+static int wm8940_add_widgets(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_new_controls(codec, wm8940_dapm_widgets,
+				  ARRAY_SIZE(wm8940_dapm_widgets));
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_new_widgets(codec);
+}
+static int wm8940_add_controls(struct snd_soc_codec *codec)
+{
+	int err, i;
+
+	for (i = 0; i < ARRAY_SIZE(wm8940_snd_controls); i++) {
+		err = snd_ctl_add(codec->card,
+				snd_soc_cnew(&wm8940_snd_controls[i], codec,
+					NULL));
+		if (err < 0)
+			return err;
+	}
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
+	struct snd_soc_codec *codec = socdev->codec;
+	struct wm8940_priv *wm8940 = codec->private_data;
+
+	/* clear fmt and wl */
+	u16 iface = wm8940_read_reg_cache(codec, WM8940_IFACE) & 0xFF07;
+	u16 addcntrl = wm8940_read_reg_cache(codec, WM8940_ADDCNTRL) & 0xFFF1;
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
+	wm8940_write(codec, WM8940_ADDCNTRL, addcntrl);
+
+	switch (params_format(params)) {
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
+
+	switch (wm8940->mode) {
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
+	switch (wm8940->clk_inversion) {
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
+	wm8940_write(codec, WM8940_IFACE, iface);
+
+	return 0;
+}
+
+static int wm8940_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u16 mute_reg = wm8940_read_reg_cache(codec, WM8940_DAC) & 0xffbf;
+
+	return wm8940_write(codec,
+			    WM8940_DAC,
+			    mute ? mute_reg | 0x40 : mute_reg);
+
+}
+
+static int wm8940_set_dai_fmt(struct snd_soc_dai *codec_dai,
+			      unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct wm8940_priv *wm8940 = codec->private_data;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_RIGHT_J:
+	case SND_SOC_DAIFMT_DSP_A:
+	case SND_SOC_DAIFMT_DSP_B:
+		wm8940->mode = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
+		break;
+	}
+	wm8940->clk_inversion = fmt & SND_SOC_DAIFMT_INV_MASK;
+
+	return 0;
+}
+
+static int wm8940_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
+				 int div_id, int div)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	u16 reg;
+
+	switch (div_id) {
+	case WM8940_BCLKDIV:
+		reg = wm8940_read_reg_cache(codec, WM8940_CLOCK) & 0xFFEF3;
+		wm8940_write(codec, WM8940_CLOCK, reg | (div << 2));
+		break;
+	case WM8940_MCLKDIV:
+		reg = wm8940_read_reg_cache(codec, WM8940_CLOCK) & 0xFF1F;
+		wm8940_write(codec, WM8940_CLOCK, reg | (div << 5));
+		break;
+	case WM8940_OPCLKDIV:
+		reg = wm8940_read_reg_cache(codec, WM8940_ADDCNTRL) & 0xFFCF;
+		wm8940_write(codec, WM8940_ADDCNTRL, reg | (div << 4));
+		break;
+	}
+	return 0;
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
+/* This unfortunately is rather different from the wm8510 */
+static void pll_factors(unsigned int target, unsigned int source)
+{
+	unsigned long long Kpart;
+	unsigned int K, Ndiv, Nmod;
+
+	Ndiv = target / source;
+	/* Ndiv would be greater than 12, so add a pre multiply by 2*/
+	if (Ndiv > 12) {
+		/* FIXME: This will loose accuracy, how to deal? */
+		printk(KERN_WARNING "Incorrectly handled case\n");
+		source <<= 1;
+		pll_div.pre_scale = 0;
+		Ndiv = target / source;
+	} else if (Ndiv < 3) {
+		source >>= 2;
+		pll_div.pre_scale = 3;
+		Ndiv = target / source;
+	} else if (Ndiv < 6) {
+		source >>= 1;
+		pll_div.pre_scale = 2;
+	} else
+		pll_div.pre_scale = 1;
+
+	if ((Ndiv < 6) || (Ndiv > 12))
+		printk(KERN_WARNING
+			"WM8510 N value %d outwith recommended range!d\n",
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
+	if (freq_in == 0 || freq_out == 0) {
+		/* Clock CODEC directly from MCLK */
+		reg = wm8940_read_reg_cache(codec, WM8940_CLOCK);
+		wm8940_write(codec, WM8940_CLOCK, reg & 0x0ff);
+
+		/* Turn off PLL */
+		reg = wm8940_read_reg_cache(codec, WM8940_POWER1);
+		wm8940_write(codec, WM8940_POWER1, reg & 0x1df);
+
+		/* It is also possible to turn it off completely  - TODO */
+		return 0;
+	}
+
+	pll_factors(freq_out*8, freq_in);
+
+	wm8940_write(codec, WM8940_PLLN, (pll_div.pre_scale << 4) | pll_div.n);
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
+static int wm8940_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
+{
+	u16 val;
+	u16 pwr_reg = wm8940_read_reg_cache(codec, WM8940_POWER1) & 0x1F0;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		/* ensure bufioen and biasen */
+		pwr_reg |= (1 << 2) | (1 << 3);
+		/* Enable thermal shutdown */
+		val = wm8940_read_reg_cache(codec, WM8940_OUTPUTCTL);
+		wm8940_write(codec, WM8940_OUTPUTCTL, val | 0x2);
+		/* set vmid to 75k and unmute dac */
+		wm8940_write(codec, WM8940_POWER1, pwr_reg | 0x1);
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		/* ensure bufioen and biasen */
+		pwr_reg |= (1 << 2) | (1 << 3);
+		/* set vmid to 2.5k for fast start */
+		wm8940_write(codec, WM8940_POWER1, pwr_reg | 0x3);
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		/* ensure bufioen and biasen */
+		pwr_reg |= (1 << 2) | (1 << 3);
+		/* set vmid to 300k for standby */
+		wm8940_write(codec, WM8940_POWER1, pwr_reg | 0x2);
+		break;
+	case SND_SOC_BIAS_OFF:
+		wm8940_write(codec, WM8940_POWER1, pwr_reg);
+		break;
+	}
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
+	wm8940_write(codec, WM8940_CLOCK,  0);
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
+struct snd_soc_dai wm8940_dai = {
+	.name = "WM8940",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2, /* lie - pxa-i2s has min of 2*/
+		.rates = WM8940_RATES,
+		.formats = WM8940_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2, /* lie */
+		.rates = WM8940_RATES,
+		.formats = WM8940_FORMATS,
+	},
+	.ops = {
+		.hw_params = wm8940_i2s_hw_params,
+		.set_sysclk = wm8940_set_dai_sysclk,
+		.digital_mute = wm8940_mute,
+		.set_fmt = wm8940_set_dai_fmt,
+		.set_clkdiv = wm8940_set_dai_clkdiv,
+		.set_pll = wm8940_set_dai_pll,
+	},
+};
+EXPORT_SYMBOL_GPL(wm8940_dai);
+
+static int wm8940_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+
+	wm8940_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
+}
+
+static int wm8940_resume(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+	int i;
+	u16 *cache = codec->reg_cache;
+
+	/* Sync reg_cache with the hardware
+	 * Could use auto incremented writes to speed this up
+	 */
+	for (i = 0; i < ARRAY_SIZE(wm8940_reg_defaults); i++)
+		wm8940_write(codec, i, cache[i]);
+	wm8940_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	wm8940_set_bias_level(codec, codec->suspend_bias_level);
+
+	return 0;
+}
+
+#define wm8940_reset(c) wm8940_write(c, WM8940_SOFTRESET, 0);
+
+static int wm8940_init(struct snd_soc_device *socdev)
+{
+	struct snd_soc_codec *codec = socdev->codec;
+	int ret = 0;
+
+	codec->name = "WM8940";
+	codec->owner = THIS_MODULE;
+	codec->read = wm8940_read_reg_cache;
+	codec->write = wm8940_write;
+	codec->set_bias_level = wm8940_set_bias_level;
+	codec->dai = &wm8940_dai;
+	codec->num_dai = 1;
+	codec->reg_cache_size = ARRAY_SIZE(wm8940_reg_defaults);
+	codec->reg_cache = kmemdup(wm8940_reg_defaults,
+				   sizeof wm8940_reg_defaults,
+				   GFP_KERNEL);
+
+	if (codec->reg_cache == NULL) {
+		ret = -ENOMEM;
+		goto error_free_cache;
+	}
+	ret = wm8940_reset(codec);
+	if (ret)
+		goto error_free_cache;
+
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0)
+		goto error_free_cache;
+
+	codec->bias_level = SND_SOC_BIAS_OFF;
+	wm8940_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	wm8940_add_controls(codec);
+	wm8940_add_widgets(codec);
+
+	/* Enables the level shifters and non-vmid derived bias
+	 * current generator
+	 */
+	ret = wm8940_write(codec, WM8940_POWER1, 0x180);
+	if (ret < 0)
+		goto card_err;
+
+	ret = snd_soc_init_card(socdev);
+	if (ret < 0) {
+		printk(KERN_ERR "wm8940: failed to register card\n");
+		goto card_err;
+	}
+
+	return ret;
+
+card_err:
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+error_free_cache:
+	kfree(codec->reg_cache);
+	return ret;
+}
+
+static struct snd_soc_device *wm8940_socdev;
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+static int wm8940_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	struct snd_soc_device *socdev = wm8940_socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+	int ret;
+
+	i2c_set_clientdata(i2c, codec);
+	codec->control_data = i2c;
+	ret = wm8940_init(socdev);
+	if (ret < 0)
+		pr_err("Failed to initialise WM8940\n");
+
+	return ret;
+}
+static int wm8940_i2c_remove(struct i2c_client *client)
+{
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
+	.remove = wm8940_i2c_remove,
+	.id_table = wm8940_i2c_id,
+};
+
+static int wm8940_add_i2c_device(struct platform_device *pdev,
+				 const struct wm8940_setup_data *setup)
+{
+	struct i2c_board_info info = {
+		.type = "wm8940",
+		.addr = setup->i2c_address,
+	};
+	struct i2c_adapter *adapter;
+	struct i2c_client *client;
+	int ret;
+
+	ret = i2c_add_driver(&wm8940_i2c_driver);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "can't add i2c driver\n");
+		return ret;
+	}
+
+	adapter = i2c_get_adapter(setup->i2c_bus);
+	if (!adapter) {
+		dev_err(&pdev->dev, "can't get i2c adapter %d\n",
+			setup->i2c_bus);
+		goto err_driver;
+	}
+
+	client = i2c_new_device(adapter, &info);
+	i2c_put_adapter(adapter);
+	if (!client) {
+		dev_err(&pdev->dev, "can't add i2c device at 0x%x\n",
+			(unsigned int)info.addr);
+		goto err_driver;
+	}
+
+	return 0;
+
+err_driver:
+	i2c_del_driver(&wm8940_i2c_driver);
+	return -ENODEV;
+}
+
+#endif
+
+static int wm8940_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct wm8940_setup_data *setup;
+	struct snd_soc_codec *codec;
+	struct wm8940_priv *wm8940;
+	int ret = 0;
+
+	setup = socdev->codec_data;
+	codec = kzalloc(sizeof *codec, GFP_KERNEL);
+	if (codec == NULL)
+		return -ENOMEM;
+
+	wm8940 = kzalloc(sizeof(*wm8940), GFP_KERNEL);
+	if (wm8940 == NULL)
+		return -ENOMEM;
+	codec->private_data = wm8940;
+	socdev->codec = codec;
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+	wm8940_socdev = socdev;
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	if (setup->i2c_address) {
+		codec->hw_write = (hw_write_t)i2c_master_send;
+		ret = wm8940_add_i2c_device(pdev, setup);
+	}
+#endif
+	if (ret != 0)
+		kfree(codec);
+	return ret;
+}
+
+static int wm8940_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+
+	if (codec->control_data)
+		wm8940_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_unregister_device(codec->control_data);
+	i2c_del_driver(&wm8940_i2c_driver);
+#endif
+	kfree(codec);
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
+static int __init wm8940_modinit(void)
+{
+	return snd_soc_register_dai(&wm8940_dai);
+}
+module_init(wm8940_modinit);
+
+static void __exit wm8940_exit(void)
+{
+	snd_soc_unregister_dai(&wm8940_dai);
+}
+module_exit(wm8940_exit);
+
+MODULE_DESCRIPTION("ASoC WM8940 driver");
+MODULE_AUTHOR("Jonathan Cameron");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm8940.h b/sound/soc/codecs/wm8940.h
new file mode 100644
index 0000000..ab1221c
--- /dev/null
+++ b/sound/soc/codecs/wm8940.h
@@ -0,0 +1,102 @@
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
+	/* The one I have isn't spi wired, so can't test */
+	int i2c_bus;
+	unsigned short i2c_address;
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
