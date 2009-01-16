From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: Driver for the WM9705 AC97 codec.
Date: Fri, 16 Jan 2009 17:15:13 +0000
Message-ID: <1232126115-1966-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090116171347.GA1912@rakim.wolfsonmicro.main>
	<1232126115-1966-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9082224395
	for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2009 18:15:16 +0100 (CET)
In-Reply-To: <1232126115-1966-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ian Molton <ian@mnementh.co.uk>
List-Id: alsa-devel@alsa-project.org

From: Ian Molton <ian@mnementh.co.uk>

This driver adds support for the wm9705 ac97 codec. The driver supports
audio input and output.

Signed-off-by: Ian Molton <ian@mnementh.co.uk>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig  |    4 +
 sound/soc/codecs/Makefile |    3 +
 sound/soc/codecs/wm9705.c |  410 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm9705.h |   14 ++
 4 files changed, 431 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/wm9705.c
 create mode 100644 sound/soc/codecs/wm9705.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index d0e0d69..cb5fcd6 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -34,6 +34,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM8903 if I2C
 	select SND_SOC_WM8971 if I2C
 	select SND_SOC_WM8990 if I2C
+	select SND_SOC_WM9705 if SND_SOC_AC97_BUS
 	select SND_SOC_WM9712 if SND_SOC_AC97_BUS
 	select SND_SOC_WM9713 if SND_SOC_AC97_BUS
         help
@@ -144,6 +145,9 @@ config SND_SOC_WM8971
 config SND_SOC_WM8990
 	tristate
 
+config SND_SOC_WM9705
+	tristate
+
 config SND_SOC_WM9712
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index c4ddc9a..3664cdc 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -23,6 +23,7 @@ snd-soc-wm8900-objs := wm8900.o
 snd-soc-wm8903-objs := wm8903.o
 snd-soc-wm8971-objs := wm8971.o
 snd-soc-wm8990-objs := wm8990.o
+snd-soc-wm9705-objs := wm9705.o
 snd-soc-wm9712-objs := wm9712.o
 snd-soc-wm9713-objs := wm9713.o
 
@@ -51,5 +52,7 @@ obj-$(CONFIG_SND_SOC_WM8900)	+= snd-soc-wm8900.o
 obj-$(CONFIG_SND_SOC_WM8903)	+= snd-soc-wm8903.o
 obj-$(CONFIG_SND_SOC_WM8971)	+= snd-soc-wm8971.o
 obj-$(CONFIG_SND_SOC_WM8990)	+= snd-soc-wm8990.o
+obj-$(CONFIG_SND_SOC_WM8991)	+= snd-soc-wm8991.o
+obj-$(CONFIG_SND_SOC_WM9705)	+= snd-soc-wm9705.o
 obj-$(CONFIG_SND_SOC_WM9712)	+= snd-soc-wm9712.o
 obj-$(CONFIG_SND_SOC_WM9713)	+= snd-soc-wm9713.o
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
new file mode 100644
index 0000000..cb26b6a
--- /dev/null
+++ b/sound/soc/codecs/wm9705.c
@@ -0,0 +1,410 @@
+/*
+ * wm9705.c  --  ALSA Soc WM9705 codec support
+ *
+ * Copyright 2008 Ian Molton <spyro@f2s.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation; Version 2 of the  License only.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/ac97_codec.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+/*
+ * WM9705 register cache
+ */
+static const u16 wm9705_reg[] = {
+	0x6150, 0x8000, 0x8000, 0x8000, /* 0x0  */
+	0x0000, 0x8000, 0x8008, 0x8008, /* 0x8  */
+	0x8808, 0x8808, 0x8808, 0x8808, /* 0x10 */
+	0x8808, 0x0000, 0x8000, 0x0000, /* 0x18 */
+	0x0000, 0x0000, 0x0000, 0x000f, /* 0x20 */
+	0x0605, 0x0000, 0xbb80, 0x0000, /* 0x28 */
+	0x0000, 0xbb80, 0x0000, 0x0000, /* 0x30 */
+	0x0000, 0x2000, 0x0000, 0x0000, /* 0x38 */
+	0x0000, 0x0000, 0x0000, 0x0000, /* 0x40 */
+	0x0000, 0x0000, 0x0000, 0x0000, /* 0x48 */
+	0x0000, 0x0000, 0x0000, 0x0000, /* 0x50 */
+	0x0000, 0x0000, 0x0000, 0x0000, /* 0x58 */
+	0x0000, 0x0000, 0x0000, 0x0000, /* 0x60 */
+	0x0000, 0x0000, 0x0000, 0x0000, /* 0x68 */
+	0x0000, 0x0808, 0x0000, 0x0006, /* 0x70 */
+	0x0000, 0x0000, 0x574d, 0x4c05, /* 0x78 */
+};
+
+static const struct snd_kcontrol_new wm9705_snd_ac97_controls[] = {
+	SOC_DOUBLE("Master Playback Volume", AC97_MASTER, 8, 0, 31, 1),
+	SOC_SINGLE("Master Playback Switch", AC97_MASTER, 15, 1, 1),
+	SOC_DOUBLE("Headphone Playback Volume", AC97_HEADPHONE, 8, 0, 31, 1),
+	SOC_SINGLE("Headphone Playback Switch", AC97_HEADPHONE, 15, 1, 1),
+	SOC_DOUBLE("PCM Playback Volume", AC97_PCM, 8, 0, 31, 1),
+	SOC_SINGLE("PCM Playback Switch", AC97_PCM, 15, 1, 1),
+	SOC_SINGLE("Mono Playback Volume", AC97_MASTER_MONO, 0, 31, 1),
+	SOC_SINGLE("Mono Playback Switch", AC97_MASTER_MONO, 15, 1, 1),
+	SOC_SINGLE("PCBeep Playback Volume", AC97_PC_BEEP, 1, 15, 1),
+	SOC_SINGLE("Phone Playback Volume", AC97_PHONE, 0, 31, 1),
+	SOC_DOUBLE("Line Playback Volume", AC97_LINE, 8, 0, 31, 1),
+	SOC_DOUBLE("CD Playback Volume", AC97_CD, 8, 0, 31, 1),
+	SOC_SINGLE("Mic Playback Volume", AC97_MIC, 0, 31, 1),
+	SOC_SINGLE("Mic 20dB Boost Switch", AC97_MIC, 6, 1, 0),
+	SOC_DOUBLE("PCM Capture Volume", AC97_REC_GAIN, 8, 0, 15, 0),
+	SOC_SINGLE("PCM Capture Switch", AC97_REC_GAIN, 15, 1, 1),
+};
+
+static const char *wm9705_mic[] = {"Mic 1", "Mic 2"};
+static const char *wm9705_rec_sel[] = {"Mic", "CD", "NC", "NC",
+	"Line", "Stereo Mix", "Mono Mix", "Phone"};
+
+static const struct soc_enum wm9705_enum_mic =
+	SOC_ENUM_SINGLE(AC97_GENERAL_PURPOSE, 8, 2, wm9705_mic);
+static const struct soc_enum wm9705_enum_rec_l =
+	SOC_ENUM_SINGLE(AC97_REC_SEL, 8, 8, wm9705_rec_sel);
+static const struct soc_enum wm9705_enum_rec_r =
+	SOC_ENUM_SINGLE(AC97_REC_SEL, 0, 8, wm9705_rec_sel);
+
+/* Headphone Mixer */
+static const struct snd_kcontrol_new wm9705_hp_mixer_controls[] = {
+	SOC_DAPM_SINGLE("PCBeep Playback Switch", AC97_PC_BEEP, 15, 1, 1),
+	SOC_DAPM_SINGLE("CD Playback Switch", AC97_CD, 15, 1, 1),
+	SOC_DAPM_SINGLE("Mic Playback Switch", AC97_MIC, 15, 1, 1),
+	SOC_DAPM_SINGLE("Phone Playback Switch", AC97_PHONE, 15, 1, 1),
+	SOC_DAPM_SINGLE("Line Playback Switch", AC97_LINE, 15, 1, 1),
+};
+
+/* Mic source */
+static const struct snd_kcontrol_new wm9705_mic_src_controls =
+	SOC_DAPM_ENUM("Route", wm9705_enum_mic);
+
+/* Capture source */
+static const struct snd_kcontrol_new wm9705_capture_selectl_controls =
+	SOC_DAPM_ENUM("Route", wm9705_enum_rec_l);
+static const struct snd_kcontrol_new wm9705_capture_selectr_controls =
+	SOC_DAPM_ENUM("Route", wm9705_enum_rec_r);
+
+/* DAPM widgets */
+static const struct snd_soc_dapm_widget wm9705_dapm_widgets[] = {
+	SND_SOC_DAPM_MUX("Mic Source", SND_SOC_NOPM, 0, 0,
+		&wm9705_mic_src_controls),
+	SND_SOC_DAPM_MUX("Left Capture Source", SND_SOC_NOPM, 0, 0,
+		&wm9705_capture_selectl_controls),
+	SND_SOC_DAPM_MUX("Right Capture Source", SND_SOC_NOPM, 0, 0,
+		&wm9705_capture_selectr_controls),
+	SND_SOC_DAPM_DAC("Left DAC", "Left HiFi Playback",
+		SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("Right DAC", "Right HiFi Playback",
+		SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_MIXER_NAMED_CTL("HP Mixer", SND_SOC_NOPM, 0, 0,
+		&wm9705_hp_mixer_controls[0],
+		ARRAY_SIZE(wm9705_hp_mixer_controls)),
+	SND_SOC_DAPM_MIXER("Mono Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_ADC("Left ADC", "Left HiFi Capture", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_ADC("Right ADC", "Right HiFi Capture", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_PGA("Headphone PGA", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Speaker PGA", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Line PGA", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Line out PGA", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Mono PGA", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Phone PGA", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Mic PGA", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("PCBEEP PGA", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("CD PGA", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("ADC PGA", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("HPOUTL"),
+	SND_SOC_DAPM_OUTPUT("HPOUTR"),
+	SND_SOC_DAPM_OUTPUT("LOUT"),
+	SND_SOC_DAPM_OUTPUT("ROUT"),
+	SND_SOC_DAPM_OUTPUT("MONOOUT"),
+	SND_SOC_DAPM_INPUT("PHONE"),
+	SND_SOC_DAPM_INPUT("LINEINL"),
+	SND_SOC_DAPM_INPUT("LINEINR"),
+	SND_SOC_DAPM_INPUT("CDINL"),
+	SND_SOC_DAPM_INPUT("CDINR"),
+	SND_SOC_DAPM_INPUT("PCBEEP"),
+	SND_SOC_DAPM_INPUT("MIC1"),
+	SND_SOC_DAPM_INPUT("MIC2"),
+};
+
+/* Audio map
+ * WM9705 has no switches to disable the route from the inputs to the HP mixer
+ * so in order to prevent active inputs from forcing the audio outputs to be
+ * constantly enabled, we use the mutes on those inputs to simulate such
+ * controls.
+ */
+static const struct snd_soc_dapm_route audio_map[] = {
+	/* HP mixer */
+	{"HP Mixer", "PCBeep Playback Switch", "PCBEEP PGA"},
+	{"HP Mixer", "CD Playback Switch", "CD PGA"},
+	{"HP Mixer", "Mic Playback Switch", "Mic PGA"},
+	{"HP Mixer", "Phone Playback Switch", "Phone PGA"},
+	{"HP Mixer", "Line Playback Switch", "Line PGA"},
+	{"HP Mixer", NULL, "Left DAC"},
+	{"HP Mixer", NULL, "Right DAC"},
+
+	/* mono mixer */
+	{"Mono Mixer", NULL, "HP Mixer"},
+
+	/* outputs */
+	{"Headphone PGA", NULL, "HP Mixer"},
+	{"HPOUTL", NULL, "Headphone PGA"},
+	{"HPOUTR", NULL, "Headphone PGA"},
+	{"Line out PGA", NULL, "HP Mixer"},
+	{"LOUT", NULL, "Line out PGA"},
+	{"ROUT", NULL, "Line out PGA"},
+	{"Mono PGA", NULL, "Mono Mixer"},
+	{"MONOOUT", NULL, "Mono PGA"},
+
+	/* inputs */
+	{"CD PGA", NULL, "CDINL"},
+	{"CD PGA", NULL, "CDINR"},
+	{"Line PGA", NULL, "LINEINL"},
+	{"Line PGA", NULL, "LINEINR"},
+	{"Phone PGA", NULL, "PHONE"},
+	{"Mic Source", "Mic 1", "MIC1"},
+	{"Mic Source", "Mic 2", "MIC2"},
+	{"Mic PGA", NULL, "Mic Source"},
+	{"PCBEEP PGA", NULL, "PCBEEP"},
+
+	/* Left capture selector */
+	{"Left Capture Source", "Mic", "Mic Source"},
+	{"Left Capture Source", "CD", "CDINL"},
+	{"Left Capture Source", "Line", "LINEINL"},
+	{"Left Capture Source", "Stereo Mix", "HP Mixer"},
+	{"Left Capture Source", "Mono Mix", "HP Mixer"},
+	{"Left Capture Source", "Phone", "PHONE"},
+
+	/* Right capture source */
+	{"Right Capture Source", "Mic", "Mic Source"},
+	{"Right Capture Source", "CD", "CDINR"},
+	{"Right Capture Source", "Line", "LINEINR"},
+	{"Right Capture Source", "Stereo Mix", "HP Mixer"},
+	{"Right Capture Source", "Mono Mix", "HP Mixer"},
+	{"Right Capture Source", "Phone", "PHONE"},
+
+	{"ADC PGA", NULL, "Left Capture Source"},
+	{"ADC PGA", NULL, "Right Capture Source"},
+
+	/* ADC's */
+	{"Left ADC",  NULL, "ADC PGA"},
+	{"Right ADC", NULL, "ADC PGA"},
+};
+
+static int wm9705_add_widgets(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_new_controls(codec, wm9705_dapm_widgets,
+					ARRAY_SIZE(wm9705_dapm_widgets));
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_new_widgets(codec);
+
+	return 0;
+}
+
+/* We use a register cache to enhance read performance. */
+static unsigned int ac97_read(struct snd_soc_codec *codec, unsigned int reg)
+{
+	u16 *cache = codec->reg_cache;
+
+	switch (reg) {
+	case AC97_RESET:
+	case AC97_VENDOR_ID1:
+	case AC97_VENDOR_ID2:
+		return soc_ac97_ops.read(codec->ac97, reg);
+	default:
+		reg = reg >> 1;
+
+		if (reg >= (ARRAY_SIZE(wm9705_reg)))
+			return -EIO;
+
+		return cache[reg];
+	}
+}
+
+static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
+	unsigned int val)
+{
+	u16 *cache = codec->reg_cache;
+
+	soc_ac97_ops.write(codec->ac97, reg, val);
+	reg = reg >> 1;
+	if (reg < (ARRAY_SIZE(wm9705_reg)))
+		cache[reg] = val;
+
+	return 0;
+}
+
+static int ac97_prepare(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+	int reg;
+	u16 vra;
+
+	vra = ac97_read(codec, AC97_EXTENDED_STATUS);
+	ac97_write(codec, AC97_EXTENDED_STATUS, vra | 0x1);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		reg = AC97_PCM_FRONT_DAC_RATE;
+	else
+		reg = AC97_PCM_LR_ADC_RATE;
+
+	return ac97_write(codec, reg, runtime->rate);
+}
+
+#define WM9705_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | \
+			SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | \
+			SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
+			SNDRV_PCM_RATE_48000)
+
+struct snd_soc_dai wm9705_dai[] = {
+	{
+		.name = "AC97 HiFi",
+		.ac97_control = 1,
+		.playback = {
+			.stream_name = "HiFi Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = WM9705_AC97_RATES,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.capture = {
+			.stream_name = "HiFi Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = WM9705_AC97_RATES,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.ops = {
+			.prepare = ac97_prepare,
+		},
+	},
+	{
+		.name = "AC97 Aux",
+		.playback = {
+			.stream_name = "Aux Playback",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = WM9705_AC97_RATES,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+	}
+};
+EXPORT_SYMBOL_GPL(wm9705_dai);
+
+static int wm9705_reset(struct snd_soc_codec *codec)
+{
+	if (soc_ac97_ops.reset) {
+		soc_ac97_ops.reset(codec->ac97);
+		if (ac97_read(codec, 0) == wm9705_reg[0])
+			return 0; /* Success */
+	}
+
+	return -EIO;
+}
+
+static int wm9705_soc_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	int ret = 0;
+
+	printk(KERN_INFO "WM9705 SoC Audio Codec\n");
+
+	socdev->codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (socdev->codec == NULL)
+		return -ENOMEM;
+	codec = socdev->codec;
+	mutex_init(&codec->mutex);
+
+	codec->reg_cache = kmemdup(wm9705_reg, sizeof(wm9705_reg), GFP_KERNEL);
+	if (codec->reg_cache == NULL) {
+		ret = -ENOMEM;
+		goto cache_err;
+	}
+	codec->reg_cache_size = sizeof(wm9705_reg);
+	codec->reg_cache_step = 2;
+
+	codec->name = "WM9705";
+	codec->owner = THIS_MODULE;
+	codec->dai = wm9705_dai;
+	codec->num_dai = ARRAY_SIZE(wm9705_dai);
+	codec->write = ac97_write;
+	codec->read = ac97_read;
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
+	if (ret < 0) {
+		printk(KERN_ERR "wm9705: failed to register AC97 codec\n");
+		goto codec_err;
+	}
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0)
+		goto pcm_err;
+
+	ret = wm9705_reset(codec);
+	if (ret)
+		goto reset_err;
+
+	snd_soc_add_controls(codec, wm9705_snd_ac97_controls,
+				ARRAY_SIZE(wm9705_snd_ac97_controls));
+	wm9705_add_widgets(codec);
+
+	ret = snd_soc_init_card(socdev);
+	if (ret < 0) {
+		printk(KERN_ERR "wm9705: failed to register card\n");
+		goto pcm_err;
+	}
+
+	return 0;
+
+reset_err:
+	snd_soc_free_pcms(socdev);
+pcm_err:
+	snd_soc_free_ac97_codec(codec);
+codec_err:
+	kfree(codec->reg_cache);
+cache_err:
+	kfree(socdev->codec);
+	socdev->codec = NULL;
+	return ret;
+}
+
+static int wm9705_soc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+
+	if (codec == NULL)
+		return 0;
+
+	snd_soc_dapm_free(socdev);
+	snd_soc_free_pcms(socdev);
+	snd_soc_free_ac97_codec(codec);
+	kfree(codec->reg_cache);
+	kfree(codec);
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_wm9705 = {
+	.probe = 	wm9705_soc_probe,
+	.remove = 	wm9705_soc_remove,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_wm9705);
+
+MODULE_DESCRIPTION("ASoC WM9705 driver");
+MODULE_AUTHOR("Ian Molton");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/wm9705.h b/sound/soc/codecs/wm9705.h
new file mode 100644
index 0000000..d380f11
--- /dev/null
+++ b/sound/soc/codecs/wm9705.h
@@ -0,0 +1,14 @@
+/*
+ * wm9705.h  --  WM9705 Soc Audio driver
+ */
+
+#ifndef _WM9705_H
+#define _WM9705_H
+
+#define WM9705_DAI_AC97_HIFI	0
+#define WM9705_DAI_AC97_AUX	1
+
+extern struct snd_soc_dai wm9705_dai[2];
+extern struct snd_soc_codec_device soc_codec_dev_wm9705;
+
+#endif
-- 
1.5.6.5
