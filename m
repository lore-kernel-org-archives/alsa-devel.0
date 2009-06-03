From: Eric Miao <eric.y.miao@gmail.com>
Subject: [PATCH 2/4] ASoC: add dialog da9034 (aka micco) audio
	codec support
Date: Wed, 3 Jun 2009 20:34:36 +0800
Message-ID: <f17812d70906030534r4a0fe811n71cba5a13334c504@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 9EBC424380
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 14:34:37 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so4901442qwk.56
	for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2009 05:34:36 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, alsa-devel@alsa-project.org
Cc: Paul Shen <bshen9@marvell.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Paul Shen <bshen9@marvell.com>
Signed-off-by: Bin Yang <bin.yang@marvell.com>
Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 sound/soc/codecs/Kconfig        |    4 +
 sound/soc/codecs/Makefile       |    2 +
 sound/soc/codecs/da9034-audio.c |  696 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 702 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/da9034-audio.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 121d63f..d779f40 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -42,6 +42,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM9705 if SND_SOC_AC97_BUS
 	select SND_SOC_WM9712 if SND_SOC_AC97_BUS
 	select SND_SOC_WM9713 if SND_SOC_AC97_BUS
+	select SND_SOC_DA9034 if PMIC_DA903X
         help
           Normally ASoC codec drivers are only built if a machine driver which
           uses them is also built since they are only usable with a machine
@@ -160,3 +161,6 @@ config SND_SOC_WM9712

 config SND_SOC_WM9713
 	tristate
+
+config SND_SOC_DA9034
+	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index d8e15a4..53bb3d5 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -30,6 +30,7 @@ snd-soc-wm8990-objs := wm8990.o
 snd-soc-wm9705-objs := wm9705.o
 snd-soc-wm9712-objs := wm9712.o
 snd-soc-wm9713-objs := wm9713.o
+snd-soc-da9034-objs := da9034-audio.o

 obj-$(CONFIG_SND_SOC_AC97_CODEC)	+= snd-soc-ac97.o
 obj-$(CONFIG_SND_SOC_AD1980)	+= snd-soc-ad1980.o
@@ -64,3 +65,4 @@ obj-$(CONFIG_SND_SOC_WM8991)	+= snd-soc-wm8991.o
 obj-$(CONFIG_SND_SOC_WM9705)	+= snd-soc-wm9705.o
 obj-$(CONFIG_SND_SOC_WM9712)	+= snd-soc-wm9712.o
 obj-$(CONFIG_SND_SOC_WM9713)	+= snd-soc-wm9713.o
+obj-$(CONFIG_SND_SOC_DA9034)	+= snd-soc-da9034.o
diff --git a/sound/soc/codecs/da9034-audio.c b/sound/soc/codecs/da9034-audio.c
new file mode 100644
index 0000000..159a883
--- /dev/null
+++ b/sound/soc/codecs/da9034-audio.c
@@ -0,0 +1,696 @@
+/*
+ * linux/sound/soc/codecs/micco.c
+ *
+ * Copyright (C) 2007-2009 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/da903x.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/mach-types.h>
+
+#define DA9034_MUX_MONO		0x70
+#define DA9034_MUX_BEAR		0x71
+#define DA9034_MUX_LINE		0x72
+#define DA9034_MUX_STEREO_CH1	0x73
+#define DA9034_MUX_STEREO_CH2	0x74
+#define DA9034_AUDIO_LINE_AMP	0x75
+#define DA9034_STEREO_AMP_CH1	0x76
+#define DA9034_STEREO_AMP_CH2	0x77
+#define DA9034_STEREO_DAC	0x78
+#define DA9034_MONO_VOL		0x79
+#define DA9034_BEAR_VOL		0x7a
+#define DA9034_I2S_CONTROL	0x7b
+#define DA9034_TX_PGA		0x7c
+#define DA9034_MIC_PGA		0x7d
+#define DA9034_TX_PGA_MUX	0x7e
+#define DA9034_VOICE_ADC	0x7f
+#define DA9034_VOICE_DAC	0x80
+#define DA9034_SIDE_TONE	0x81
+#define DA9034_PGA_AUX12	0x82
+#define DA9034_PGA_AUX3		0x83
+#define DA9034_PGA_DACS		0x84
+
+/* NOTE: the ES1 revision of the chip has the following two issues
+ * regarding audio:
+ * 1. The MONO and BEAR are incorrectly exchanged
+ * 2. The Stereo DAC has to be enabled for Voice Codec
+ */
+#define DA9034_ERRATA_ES1	1
+
+#define ARRAY_AND_SIZE(x)	x, ARRAY_SIZE(x)
+
+/* initial values for the audio registers */
+static const uint8_t da9034_initregs[] = {
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x82, 0x00, 0x40, /* 0x70 ~ 0x77 */
+	0xe0, 0x80, 0x80, 0x40, 0x00, 0x40, 0x00, 0x02, /* 0x78 ~ 0x7f */
+	0x00, 0x00, 0x00, 0x00, 0x00, /* 0x80 ~ 0x84 */
+};
+
+/* Mono Out Mixer */
+static const struct snd_kcontrol_new da9034_mixer_mono_out_controls[] = {
+	SOC_DAPM_SINGLE("AUX1", DA9034_MUX_MONO, 0, 1, 0),
+	SOC_DAPM_SINGLE("AUX2", DA9034_MUX_MONO, 1, 1, 0),
+	SOC_DAPM_SINGLE("AUX3", DA9034_MUX_MONO, 2, 1, 0),
+	SOC_DAPM_SINGLE("DAC1", DA9034_MUX_MONO, 3, 1, 0),
+	SOC_DAPM_SINGLE("DAC2", DA9034_MUX_MONO, 4, 1, 0),
+	SOC_DAPM_SINGLE("DAC3", DA9034_MUX_MONO, 5, 1, 0),
+	SOC_DAPM_SINGLE("AUX2inv", DA9034_MUX_MONO, 6, 1, 0),
+};
+
+static const struct snd_kcontrol_new da9034_mixer_bear_out_controls[] = {
+	SOC_DAPM_SINGLE("AUX1", DA9034_MUX_MONO, 0, 1, 0),
+	SOC_DAPM_SINGLE("AUX2", DA9034_MUX_MONO, 1, 1, 0),
+	SOC_DAPM_SINGLE("AUX3", DA9034_MUX_MONO, 2, 1, 0),
+	SOC_DAPM_SINGLE("DAC1", DA9034_MUX_MONO, 3, 1, 0),
+	SOC_DAPM_SINGLE("DAC2", DA9034_MUX_MONO, 4, 1, 0),
+	SOC_DAPM_SINGLE("DAC3", DA9034_MUX_MONO, 5, 1, 0),
+	SOC_DAPM_SINGLE("AUX2inv", DA9034_MUX_MONO, 6, 1, 0),
+};
+
+/* Line Out Mixer */
+static const struct snd_kcontrol_new da9034_mixer_line_out_controls[] = {
+	SOC_DAPM_SINGLE("AUX1", DA9034_MUX_LINE, 0, 1, 0),
+	SOC_DAPM_SINGLE("AUX2", DA9034_MUX_LINE, 1, 1, 0),
+	SOC_DAPM_SINGLE("AUX3", DA9034_MUX_LINE, 2, 1, 0),
+	SOC_DAPM_SINGLE("DAC1", DA9034_MUX_LINE, 3, 1, 0),
+	SOC_DAPM_SINGLE("DAC2", DA9034_MUX_LINE, 4, 1, 0),
+	SOC_DAPM_SINGLE("DAC3", DA9034_MUX_LINE, 5, 1, 0),
+	SOC_DAPM_SINGLE("AUX2inv", DA9034_MUX_LINE, 6, 1, 0),
+	SOC_DAPM_SINGLE("MIC", DA9034_MUX_LINE, 7, 1, 0),
+};
+
+/* Stereo Out Mixer */
+static const struct snd_kcontrol_new da9034_mixer_stereo_ch1_controls[] = {
+	SOC_DAPM_SINGLE("AUX1", DA9034_MUX_STEREO_CH1, 0, 1, 0),
+	SOC_DAPM_SINGLE("AUX2", DA9034_MUX_STEREO_CH1, 1, 1, 0),
+	SOC_DAPM_SINGLE("AUX3", DA9034_MUX_STEREO_CH1, 2, 1, 0),
+	SOC_DAPM_SINGLE("DAC1", DA9034_MUX_STEREO_CH1, 3, 1, 0),
+	SOC_DAPM_SINGLE("DAC2", DA9034_MUX_STEREO_CH1, 4, 1, 0),
+	SOC_DAPM_SINGLE("DAC3", DA9034_MUX_STEREO_CH1, 5, 1, 0),
+	SOC_DAPM_SINGLE("AUX2inv", DA9034_MUX_STEREO_CH1, 6, 1, 0),
+};
+
+static const struct snd_kcontrol_new da9034_mixer_stereo_ch2_controls[] = {
+	SOC_DAPM_SINGLE("AUX1", DA9034_MUX_STEREO_CH2, 0, 1, 0),
+	SOC_DAPM_SINGLE("AUX2", DA9034_MUX_STEREO_CH2, 1, 1, 0),
+	SOC_DAPM_SINGLE("AUX3", DA9034_MUX_STEREO_CH2, 2, 1, 0),
+	SOC_DAPM_SINGLE("DAC1", DA9034_MUX_STEREO_CH2, 3, 1, 0),
+	SOC_DAPM_SINGLE("DAC2", DA9034_MUX_STEREO_CH2, 4, 1, 0),
+	SOC_DAPM_SINGLE("DAC3", DA9034_MUX_STEREO_CH2, 5, 1, 0),
+	SOC_DAPM_SINGLE("AUX2inv", DA9034_MUX_STEREO_CH2, 6, 1, 0),
+};
+
+
+/* default to differential mode for MIC and AUX2 */
+static const char *mux_tx_pga_texts[] = {
+	"NONE", "MIC", "AUX1", "AUX2", "AUX3", "DAC1", "DAC2",
+};
+
+static const unsigned int mux_tx_pga_values[] = {
+	0x00, 0x0c, 0x02, 0x11, 0x20, 0x40, 0x80,
+};
+
+static const char *mux_mic_texts[] = { "MIC1", "MIC2" };
+
+static const struct soc_enum da9034_mux_enum[] = {
+	SOC_VALUE_ENUM_SINGLE(DA9034_TX_PGA_MUX, 0, 0xff, 7,
+		mux_tx_pga_texts, mux_tx_pga_values),
+	SOC_ENUM_SINGLE(DA9034_MIC_PGA, 4, 2, mux_mic_texts),
+};
+
+static const struct snd_kcontrol_new mux_ctrls[] = {
+	SOC_DAPM_VALUE_ENUM("Route", da9034_mux_enum[0]),
+	SOC_DAPM_ENUM("Route", da9034_mux_enum[1]),
+};
+
+static const struct snd_kcontrol_new pga_ctrls[] = {
+	/* PGAs for input */
+	SOC_DAPM_SINGLE("MIC Volume",  DA9034_MIC_PGA, 0, 0x07, 0),
+	SOC_DAPM_SINGLE("AUX1 Volume", DA9034_PGA_AUX12, 0, 0x03, 0),
+	SOC_DAPM_SINGLE("AUX2 Volume", DA9034_PGA_AUX12, 4, 0x03, 0),
+	SOC_DAPM_SINGLE("AUX3 Volume", DA9034_PGA_AUX3,  0, 0x03, 0),
+	SOC_DAPM_SINGLE("TX Volume",   DA9034_TX_PGA, 1, 0x0f, 0),
+
+	/* PGAs for output */
+	SOC_DAPM_SINGLE("MONO Volume", DA9034_MONO_VOL, 0, 0x3f, 0),
+	SOC_DAPM_SINGLE("BEAR Volume", DA9034_BEAR_VOL, 0, 0x3f, 0),
+	SOC_DAPM_SINGLE("LINE_OUT Volume", DA9034_AUDIO_LINE_AMP, 0, 0xf, 0),
+	SOC_DAPM_SINGLE("STEREO_CH1 Volume", DA9034_STEREO_AMP_CH1, 0, 0x3f, 0),
+	SOC_DAPM_SINGLE("STEREO_CH2 Volume", DA9034_STEREO_AMP_CH2, 0, 0x3f, 0),
+};
+
+static const struct snd_soc_dapm_widget da9034_dapm_widgets[] = {
+	/* Inputs */
+	SND_SOC_DAPM_INPUT("AUX1"),
+	SND_SOC_DAPM_INPUT("AUX2"),
+	SND_SOC_DAPM_INPUT("AUX3"),
+	SND_SOC_DAPM_INPUT("MIC1"),
+	SND_SOC_DAPM_INPUT("MIC2"),
+	SND_SOC_DAPM_INPUT("AUX2inv"),
+
+	/* Outputs */
+	SND_SOC_DAPM_OUTPUT("BEAR"),
+	SND_SOC_DAPM_OUTPUT("MONO"),
+	SND_SOC_DAPM_OUTPUT("LINE_OUT"),
+	SND_SOC_DAPM_OUTPUT("STEREO_CH1"),
+	SND_SOC_DAPM_OUTPUT("STEREO_CH2"),
+
+	/* muxers */
+	SND_SOC_DAPM_VALUE_MUX("TX-PGA Mux", SND_SOC_NOPM, 0, 0, &mux_ctrls[0]),
+	SND_SOC_DAPM_MUX("MIC Mux", SND_SOC_NOPM, 0, 0, &mux_ctrls[1]),
+
+	/* mixers */
+	SND_SOC_DAPM_MIXER("LINE_OUT Mixer", SND_SOC_NOPM, 0, 0,
+			da9034_mixer_line_out_controls, 8),
+	SND_SOC_DAPM_MIXER("MONO Mixer", SND_SOC_NOPM, 0, 0,
+			da9034_mixer_mono_out_controls, 7),
+	SND_SOC_DAPM_MIXER("BEAR Mixer", SND_SOC_NOPM, 0, 0,
+			da9034_mixer_bear_out_controls, 7),
+	SND_SOC_DAPM_MIXER("STEREO_CH1 Mixer", SND_SOC_NOPM, 0, 0,
+			da9034_mixer_stereo_ch1_controls, 7),
+	SND_SOC_DAPM_MIXER("STEREO_CH2 Mixer", SND_SOC_NOPM, 0, 0,
+			da9034_mixer_stereo_ch2_controls, 7),
+
+	/* DACs and ADCs */
+#ifdef DA9034_ERRATA_ES1
+	SND_SOC_DAPM_DAC("DAC1", "HiFi Playback CH1", -1, 0, 0),
+	SND_SOC_DAPM_DAC("DAC2", "HiFi Playback CH2", -1, 0, 0),
+#else
+	SND_SOC_DAPM_DAC("DAC1", "HiFi Playback CH1", DA9034_STEREO_DAC, 7, 0),
+	SND_SOC_DAPM_DAC("DAC2", "HiFi Playback CH2", DA9034_STEREO_DAC, 7, 0),
+#endif
+	SND_SOC_DAPM_DAC("DAC3", "Voice Playback", DA9034_VOICE_DAC, 3, 0),
+	SND_SOC_DAPM_ADC("VADC", "Voice Capture",  DA9034_VOICE_ADC, 0, 0),
+
+	/* PGAs */
+	SND_SOC_DAPM_PGA("MIC PGA",  DA9034_MIC_PGA,   3, 0, &pga_ctrls[0], 1),
+	SND_SOC_DAPM_PGA("AUX1 PGA", DA9034_PGA_AUX12, 3, 0, &pga_ctrls[1], 1),
+	SND_SOC_DAPM_PGA("AUX2 PGA", DA9034_PGA_AUX12, 7, 0, &pga_ctrls[2], 1),
+	SND_SOC_DAPM_PGA("AUX3 PGA", DA9034_PGA_AUX3,  3, 0, &pga_ctrls[3], 1),
+	SND_SOC_DAPM_PGA("TX PGA", SND_SOC_NOPM, 0, 0, &pga_ctrls[4], 1),
+
+	SND_SOC_DAPM_PGA("MONO PGA", DA9034_MONO_VOL, 6, 0, &pga_ctrls[5], 1),
+	SND_SOC_DAPM_PGA("BEAR PGA", DA9034_BEAR_VOL, 6, 0, &pga_ctrls[6], 1),
+	SND_SOC_DAPM_PGA("LINE_OUT PGA", DA9034_AUDIO_LINE_AMP, 4, 0,
+			&pga_ctrls[7], 1),
+	SND_SOC_DAPM_PGA("STEREO_CH1 PGA", DA9034_STEREO_AMP_CH1, 7, 0,
+			&pga_ctrls[8], 1),
+	SND_SOC_DAPM_PGA("STEREO_CH2 PGA", DA9034_STEREO_AMP_CH2, 7, 0,
+			&pga_ctrls[9], 1),
+
+	/* Mic Bias */
+	SND_SOC_DAPM_MICBIAS("MIC Int Bias", DA9034_MIC_PGA, 6, 0),
+	SND_SOC_DAPM_MICBIAS("MIC Ext Bias", DA9034_MIC_PGA, 7, 0),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	/* MIC PGA */
+	{ "MIC PGA", NULL, "MIC1" },
+	{ "MIC PGA", NULL, "MIC2" },
+
+	/* MONO Mixer */
+	{ "MONO Mixer", "AUX1", "AUX1" },
+	{ "MONO Mixer", "AUX2", "AUX2" },
+	{ "MONO Mixer", "AUX3", "AUX3" },
+	{ "MONO Mixer", "DAC1", "DAC1" },
+	{ "MONO Mixer", "DAC2", "DAC2" },
+	{ "MONO Mixer", "DAC3", "DAC3" },
+	{ "MONO Mixer", "AUX2inv", "AUX2inv" },
+
+	{ "MONO PGA", NULL, "MONO Mixer" },
+#ifdef DA9034_ERRATA_ES1
+	{ "BEAR PGA", NULL, "MONO Mixer" },
+#endif
+	{ "MONO", NULL, "MONO PGA" },
+
+	/* BEAR Mixer */
+	{ "BEAR Mixer", "AUX1", "AUX1" },
+	{ "BEAR Mixer", "AUX2", "AUX2" },
+	{ "BEAR Mixer", "AUX3", "AUX3" },
+	{ "BEAR Mixer", "DAC1", "DAC1" },
+	{ "BEAR Mixer", "DAC2", "DAC2" },
+	{ "BEAR Mixer", "DAC3", "DAC3" },
+	{ "BEAR Mixer", "AUX2inv", "AUX2inv" },
+
+#ifdef DA9034_ERRATA_ES1
+	{ "MONO PGA", NULL, "BEAR Mixer" },
+#endif
+	{ "BEAR PGA", NULL, "BEAR Mixer" },
+	{ "BEAR", NULL, "BEAR PGA" },
+
+	/* LINE_OUT Mixer */
+	{ "LINE_OUT Mixer", "AUX1", "AUX1" },
+	{ "LINE_OUT Mixer", "AUX2", "AUX2" },
+	{ "LINE_OUT Mixer", "AUX3", "AUX3" },
+	{ "LINE_OUT Mixer", "DAC1", "DAC1" },
+	{ "LINE_OUT Mixer", "DAC2", "DAC2" },
+	{ "LINE_OUT Mixer", "DAC3", "DAC3" },
+	{ "LINE_OUT Mixer", NULL, "MIC PGA" },
+	{ "LINE_OUT Mixer", "AUX2inv", "AUX2inv" },
+
+	{ "LINE_OUT PGA", NULL, "LINE_OUT Mixer" },
+	{ "LINE_OUT", NULL, "LINE_OUT PGA" },
+
+	/* STEREO_CH1 Mixer */
+	{ "STEREO_CH1 Mixer", "AUX1", "AUX1" },
+	{ "STEREO_CH1 Mixer", "AUX2", "AUX2" },
+	{ "STEREO_CH1 Mixer", "AUX3", "AUX3" },
+	{ "STEREO_CH1 Mixer", "DAC1", "DAC1" },
+	{ "STEREO_CH1 Mixer", "DAC2", "DAC2" },
+	{ "STEREO_CH1 Mixer", "DAC3", "DAC3" },
+	{ "STEREO_CH1 Mixer", "AUX2inv", "AUX2inv" },
+
+	{ "STEREO_CH1 PGA", NULL, "STEREO_CH1 Mixer" },
+	{ "STEREO_CH1", NULL, "STEREO_CH1 PGA" },
+
+	/* STEREO_CH2 Mixer */
+	{ "STEREO_CH2 Mixer", "AUX1", "AUX1" },
+	{ "STEREO_CH2 Mixer", "AUX2", "AUX2" },
+	{ "STEREO_CH2 Mixer", "AUX3", "AUX3" },
+	{ "STEREO_CH2 Mixer", "DAC1", "DAC1" },
+	{ "STEREO_CH2 Mixer", "DAC2", "DAC2" },
+	{ "STEREO_CH2 Mixer", "DAC3", "DAC3" },
+	{ "STEREO_CH2 Mixer", "AUX2inv", "AUX2inv" },
+
+	{ "STEREO_CH2 PGA", NULL, "STEREO_CH2 Mixer" },
+	{ "STEREO_CH2", NULL, "STEREO_CH2 PGA" },
+
+	/* TX-PGA P Mux */
+	{ "TX-PGA Mux", "MIC", "MIC PGA" },
+	{ "TX-PGA Mux", "AUX1", "AUX1 PGA" },
+	{ "TX-PGA Mux", "AUX2", "AUX2 PGA" },
+	{ "TX-PGA Mux", "AUX3", "AUX3 PGA" },
+	{ "TX-PGA Mux", "DAC1", "DAC1" },
+	{ "TX-PGA Mux", "DAC2", "DAC2" },
+
+	{ "VADC", NULL, "TX-PGA Mux" },
+};
+
+static int da9034_add_widgets(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_new_controls(codec, ARRAY_AND_SIZE(da9034_dapm_widgets));
+	snd_soc_dapm_add_routes(codec, ARRAY_AND_SIZE(audio_map));
+	snd_soc_dapm_new_widgets(codec);
+	return 0;
+}
+
+static unsigned int da9034_audio_read(struct snd_soc_codec *codec,
+				      unsigned int reg)
+{
+	uint8_t val;
+
+	da903x_read(codec->dev, reg, &val);
+	return val;
+}
+
+static int da9034_audio_write(struct snd_soc_codec *codec,
+			      unsigned int reg, unsigned int val)
+{
+	return da903x_write(codec->dev, reg, val);
+}
+
+static int da9034_reset(struct snd_soc_codec *codec, int try_warm)
+{
+	int reg;
+
+	for (reg = 0; reg < ARRAY_SIZE(da9034_initregs); reg++)
+		da903x_write(codec->dev, 0x70 + reg, da9034_initregs[reg]);
+
+#ifdef DA9034_ERRATA_ES1
+	da903x_set_bits(codec->dev, DA9034_STEREO_DAC, 1 << 7);
+#endif
+	return 0;
+}
+
+static int da9034_hifi_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	uint8_t i2s_control;
+
+	da903x_read(codec->dev, DA9034_I2S_CONTROL, &i2s_control);
+
+	i2s_control &= 0x0f;
+
+	/* set master/slave audio interface */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS: break;
+	case SND_SOC_DAIFMT_CBM_CFM: i2s_control |= 0xa0; break;
+	case SND_SOC_DAIFMT_CBM_CFS: i2s_control |= 0x20; break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		i2s_control |= 0x10;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return da903x_write(codec->dev, DA9034_I2S_CONTROL, i2s_control);
+}
+
+static int da9034_hifi_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	uint8_t i2s_control;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	da903x_read(codec->dev, DA9034_I2S_CONTROL, &i2s_control);
+
+	i2s_control &= 0xf0;
+
+	switch (params_rate(params)) {
+	case 8000:  break;
+	case 11025: i2s_control |= 0x01; break;
+	case 12000: i2s_control |= 0x02; break;
+	case 16000: i2s_control |= 0x03; break;
+	case 22050: i2s_control |= 0x04; break;
+	case 24000: i2s_control |= 0x05; break;
+	case 32000: i2s_control |= 0x06; break;
+	case 44100: i2s_control |= 0x07; break;
+	case 48000: i2s_control |= 0x0f; break;
+	default:
+		return -EINVAL;
+	}
+
+	return da903x_write(codec->dev, DA9034_I2S_CONTROL, i2s_control);
+}
+
+static int da9034_voice_set_fmt(struct snd_soc_dai *codec_dai,
unsigned int fmt)
+{
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int da9034_voice_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	uint8_t val;
+
+	da903x_read(codec->dev, DA9034_VOICE_ADC, &val);
+
+	val |= 0x18;
+
+	switch ((params_rate(params))) {
+	case 8000:  break;
+	case 16000: val |= 0x01 << 3; break;
+	case 32000: val |= 0x02 << 3; break;
+	default:
+		return -EINVAL;
+	}
+
+	return da903x_write(codec->dev, DA9034_VOICE_ADC, val);
+}
+
+#define DA9034_HIFI_RATES	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
+				SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
+				SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
+				SNDRV_PCM_RATE_48000)
+
+#define DA9034_VOICE_RATES	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
+				SNDRV_PCM_RATE_32000)
+
+#define DA9034_PCM_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE)
+
+static struct snd_soc_dai_ops da9034_dai_ops_hifi = {
+	.hw_params	= da9034_hifi_hw_params,
+	.set_fmt	= da9034_hifi_set_fmt,
+};
+
+static struct snd_soc_dai_ops da9034_dai_ops_voice = {
+	.hw_params	= da9034_voice_hw_params,
+	.set_fmt	= da9034_voice_set_fmt,
+};
+
+struct snd_soc_dai da9034_dais[] = {
+	[0] = {
+		.name		= "I2S HiFi",
+		.playback	= {
+			.stream_name	= "HiFi Playback",
+			.channels_min	= 2,
+			.channels_max	= 2,
+			.rates		= DA9034_HIFI_RATES,
+			.formats	= DA9034_PCM_FORMATS,
+		},
+		.ops = &da9034_dai_ops_hifi,
+	},
+	[1] = {
+		.name		= "PCM Voice",
+		.playback	= {
+			.stream_name	= "Voice Playback",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = DA9034_VOICE_RATES,
+			.formats = DA9034_PCM_FORMATS,
+		},
+		.capture = {
+			.stream_name = "Voice Capture",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = DA9034_VOICE_RATES,
+			.formats = DA9034_PCM_FORMATS,
+		},
+		.ops = &da9034_dai_ops_voice,
+	},
+};
+EXPORT_SYMBOL_GPL(da9034_dais);
+
+#ifdef CONFIG_DEBUG_FS
+static struct {
+	const char *reg_name;
+	int reg_addr;
+} da9034_regs[] = {
+	{ "MUX_MONO", 0x70 },
+	{ "MUX_BEAR", 0x71 },
+	{ "MUX_LINE", 0x72 },
+	{ "MUX_STEREO_CH1", 0x73 },
+	{ "MUX_STEREO_CH2", 0x74 },
+	{ "AUDIO_LINE_AMP", 0x75 },
+	{ "STEREO_AMP_CH1", 0x76 },
+	{ "STEREO_AMP_CH2", 0x77 },
+	{ "STEREO_DAC", 0x78 },
+	{ "MONO_VOL", 0x79 },
+	{ "BEAR_VOL", 0x7a },
+	{ "I2S_CONTROL", 0x7b },
+	{ "TX_PGA", 0x7c },
+	{ "MIC_AMP", 0x7d },
+	{ "TX_PGA_MUX", 0x7e },
+	{ "VOICE_ADC", 0x7f },
+	{ "VOICE_DAC", 0x80 },
+	{ "SIDE_TONE", 0x81 },
+	{ "PGA_AUXI12", 0x82 },
+	{ "PGA_AUXI3", 0x83 },
+	{ "PGA_DACS", 0x84 },
+};
+
+static int da9034_debugfs_show(struct seq_file *s, void *data)
+{
+	struct snd_soc_codec *codec = data;
+	struct device *dev = codec->dev;
+	uint8_t v;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(da9034_regs); i++) {
+		da903x_read(codec->dev, da9034_regs[i].reg_addr, &v);
+		seq_printf(s, "%20s: 0x%02x\n", da9034_regs[i].reg_name, v);
+	}
+	return 0;
+}
+
+static int da9034_debugfs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, da9034_debugfs_show, inode->i_private);
+}
+
+static const struct file_operations da9034_debugfs_ops = {
+	.owner		= THIS_MODULE,
+	.open		= da9034_debugfs_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static void __init da9034_init_debugfs(struct snd_soc_codec *codec)
+{
+	debugfs_create_file("da9034", S_IFREG | S_IRUGO, NULL,
+			codec, da9034_debugfs_ops);
+}
+#else
+static inline void da9034_init_debugfs(struct snd_soc_codec *codec) {}
+#endif /* CONFIG_DEBUG_FS */
+
+static struct snd_soc_codec *da9034_codec;
+
+static int da9034_soc_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	int ret = 0;
+
+	BUG_ON(!da9034_codec);
+
+	socdev->card->codec = da9034_codec;
+	socdev->dev = &pdev->dev;
+
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to create pcms\n");
+		return ret;
+	}
+
+	da9034_add_widgets(da9034_codec);
+
+	ret = snd_soc_init_card(socdev);
+	if (ret < 0)
+		goto reset_err;
+
+	return 0;
+
+reset_err:
+	snd_soc_free_pcms(socdev);
+	socdev->card->codec = NULL;
+	return ret;
+}
+
+static int da9034_soc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	if (codec == NULL)
+		return 0;
+
+	snd_soc_dapm_free(socdev);
+	snd_soc_free_pcms(socdev);
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_da9034 = {
+	.probe		= da9034_soc_probe,
+	.remove		= da9034_soc_remove,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_da9034);
+
+static int __devinit da9034_audio_probe(struct platform_device *pdev)
+{
+	struct snd_soc_codec *codec;
+	int ret;
+
+	codec = kzalloc(sizeof(*codec), GFP_KERNEL);
+	if (codec == NULL) {
+		dev_err(&pdev->dev, "failed to allocate codec\n");
+		return -ENOMEM;
+	}
+
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	codec->dev	= pdev->dev.parent;
+	codec->name	= "DA9034";
+	codec->owner	= THIS_MODULE;
+	codec->read	= da9034_audio_read;
+	codec->write	= da9034_audio_write;
+	codec->dai	= da9034_dais;
+	codec->num_dai	= ARRAY_SIZE(da9034_dais);
+
+	ret = da9034_reset(codec, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "codec reset error\n");
+		goto err_free_codec;
+	}
+
+	ret = snd_soc_register_codec(codec);
+	if (ret)
+		goto err_free_codec;
+
+	ret = snd_soc_register_dais(ARRAY_AND_SIZE(da9034_dais));
+	if (ret)
+		goto err_unregister;
+
+	da9034_init_debugfs(codec);
+	da9034_codec = codec;
+	platform_set_drvdata(pdev, codec);
+
+	dev_info(&pdev->dev, "da9034 (aka micco) audio codec registered\n");
+	return 0;
+
+err_unregister:
+	snd_soc_unregister_codec(codec);
+err_free_codec:
+	kfree(codec);
+	return ret;
+}
+
+static int __devexit da9034_audio_remove(struct platform_device *pdev)
+{
+	struct snd_soc_codec *codec = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_dais(ARRAY_AND_SIZE(da9034_dais));
+	snd_soc_unregister_codec(codec);
+	kfree(codec);
+	return 0;
+}
+
+static struct platform_driver da9034_audio_driver = {
+	.driver		= {
+		.name	= "da9034-audio",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= da9034_audio_probe,
+	.remove		= da9034_audio_remove,
+};
+
+static int da9034_audio_init(void)
+{
+	return platform_driver_register(&da9034_audio_driver);
+}
+module_init(da9034_audio_init);
+
+static void da9034_audio_exit(void)
+{
+	platform_driver_unregister(&da9034_audio_driver);
+}
+module_exit(da9034_audio_exit);
+
+MODULE_DESCRIPTION("ASoC DA9034 Audio Codec Driver");
+MODULE_AUTHOR("Bin Yang <bin.yang@marvell.com>"
+	      "Paul Shen <bshen9@marvell.com>");
+MODULE_LICENSE("GPL");
-- 
1.6.0.4
