From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: [Pull request] Support for wm9705 codec and two
 machines that use it.
Date: Thu, 15 Jan 2009 10:06:53 +0000
Message-ID: <496F0ABD.4080207@mnementh.co.uk>
References: <496E8DD0.4090006@mnementh.co.uk> <s5hfxjl3v6s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mnementh.co.uk (mail.mnementh.co.uk [173.45.232.4])
	by alsa0.perex.cz (Postfix) with ESMTP id C7E5024390
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 11:06:32 +0100 (CET)
In-Reply-To: <s5hfxjl3v6s.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> We need reviews.  Could you post patches as well?

Sure - attached below:

I also noticed that I forgot to run it by checkpatch. It wasn't bad, but 
now checkpatch is silent.

Side note: I wish diffstat on these patches would keep lines under 80 
chars...


  sound/soc/codecs/Kconfig  |    4 +
  sound/soc/codecs/Makefile |    2 +
  sound/soc/codecs/wm9705.c |  401 
+++++++++++++++++++++++++++++++++++++++++++++
  sound/soc/codecs/wm9705.h |   14 ++
  4 files changed, 421 insertions(+), 0 deletions(-)
  create mode 100644 sound/soc/codecs/wm9705.c
  create mode 100644 sound/soc/codecs/wm9705.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index b32a2b5..9f33c07 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -46,6 +46,7 @@ config SND_SOC_ALL_CODECS
  	select SND_SOC_WM8980 if I2C
  	select SND_SOC_WM8990 if I2C
  	select SND_SOC_WM8991 if I2C
+	select SND_SOC_WM9705 if SND_SOC_AC97_BUS
  	select SND_SOC_WM9712 if SND_SOC_AC97_BUS
  	select SND_SOC_WM9713 if SND_SOC_AC97_BUS
          help
@@ -190,6 +191,9 @@ config SND_SOC_WM8990
  config SND_SOC_WM8991
  	tristate

+config SND_SOC_WM9705
+	tristate
+
  config SND_SOC_WM9712
  	tristate

diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 0a0c9dd..9c61037 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -37,6 +37,7 @@ snd-soc-wm8978-objs := wm8978.o
  snd-soc-wm8980-objs := wm8980.o
  snd-soc-wm8990-objs := wm8990.o
  snd-soc-wm8991-objs := wm8991.o
+snd-soc-wm9705-objs := wm9705.o
  snd-soc-wm9712-objs := wm9712.o
  snd-soc-wm9713-objs := wm9713.o

@@ -78,5 +79,6 @@ obj-$(CONFIG_SND_SOC_WM8978)	+= snd-soc-wm8978.o
  obj-$(CONFIG_SND_SOC_WM8980)	+= snd-soc-wm8980.o
  obj-$(CONFIG_SND_SOC_WM8990)	+= snd-soc-wm8990.o
  obj-$(CONFIG_SND_SOC_WM8991)	+= snd-soc-wm8991.o
+obj-$(CONFIG_SND_SOC_WM9705)	+= snd-soc-wm9705.o
  obj-$(CONFIG_SND_SOC_WM9712)	+= snd-soc-wm9712.o
  obj-$(CONFIG_SND_SOC_WM9713)	+= snd-soc-wm9713.o
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
new file mode 100644
index 0000000..4ff6a84
--- /dev/null
+++ b/sound/soc/codecs/wm9705.c
@@ -0,0 +1,401 @@
+/*
+ * wm9705.c  --  ALSA Soc WM9705 codec support
+ *
+ * Copyright 2008 Ian Molton <spyro@f2s.com>
+ *
+ *  This program is free software; you can redistribute  it and/or 
modify it
+ *  under  the terms of  the GNU General  Public License as published 
by the
+ *  Free Software Foundation; Version 2 of the  License only.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/version.h>
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
+	0x6174, 0x8000, 0x8000, 0x8000, /* 0x0  */
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
+ * WM9705 has no switches to disable the route from the inputs to the 
HP mixer
+ * so in order to prevent active inputs from forcing the audio outputs 
to be
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
+static unsigned int ac97_read(struct snd_soc_codec *codec, unsigned int 
reg)
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
+		if (reg > (ARRAY_SIZE(wm9705_reg)))
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
+	if (reg <= (ARRAY_SIZE(wm9705_reg)))
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
+	codec->reg_cache =
+		kzalloc(sizeof(u16) * ARRAY_SIZE(wm9705_reg), GFP_KERNEL);
+	if (codec->reg_cache == NULL) {
+		ret = -ENOMEM;
+		goto cache_err;
+	}
+	memcpy(codec->reg_cache, wm9705_reg,
+		sizeof(u16) * ARRAY_SIZE(wm9705_reg));
+	codec->reg_cache_size = sizeof(u16) * ARRAY_SIZE(wm9705_reg);
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
+	soc_ac97_ops.reset(codec->ac97);
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
+pcm_err:
+	snd_soc_free_ac97_codec(codec);
+
+codec_err:
+	kfree(codec->reg_cache);
+
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
index 0000000..0f46e66
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
+#define WM9705_DAI_AC97_AUX		1
+
+extern struct snd_soc_dai wm9705_dai[2];
+extern struct snd_soc_codec_device soc_codec_dev_wm9705;
+
+#endif
-- 
1.5.6.5

 From c1e79376dc51eaae0bd2550029cd0189edfc3722 Mon Sep 17 00:00:00 2001
From: Ian Molton <ian@mnementh.co.uk>
Date: Thu, 8 Jan 2009 21:03:55 +0000
Subject: [PATCH] ASoC: machine driver for Toshiba e750

This patch adds support for the wm9705 ac97 codec as used in the Toshiba 
e750
PDA. It includes support for powering up / down the external headphone and
speaker amplifiers on this machine.

Signed-off-by: Ian Molton <ian@mnementh.co.uk>
---
  arch/arm/mach-pxa/e750.c                      |    5 +
  arch/arm/mach-pxa/include/mach/eseries-gpio.h |    5 +
  sound/soc/pxa/Kconfig                         |    9 ++
  sound/soc/pxa/Makefile                        |    2 +
  sound/soc/pxa/e750_wm9705.c                   |  189 
+++++++++++++++++++++++++
  5 files changed, 210 insertions(+), 0 deletions(-)
  create mode 100644 sound/soc/pxa/e750_wm9705.c

diff --git a/arch/arm/mach-pxa/e750.c b/arch/arm/mach-pxa/e750.c
index be1ab8e..665066f 100644
--- a/arch/arm/mach-pxa/e750.c
+++ b/arch/arm/mach-pxa/e750.c
@@ -133,6 +133,11 @@ static unsigned long e750_pin_config[] __initdata = {
  	/* IrDA */
  	GPIO38_GPIO | MFP_LPM_DRIVE_HIGH,

+	/* Audio power control */
+	GPIO4_GPIO,  /* Headphone amp power */
+	GPIO7_GPIO,  /* Speaker amp power */
+	GPIO37_GPIO, /* Headphone detect */
+
  	/* PC Card */
  	GPIO8_GPIO,   /* CD0 */
  	GPIO44_GPIO,  /* CD1 */
diff --git a/arch/arm/mach-pxa/include/mach/eseries-gpio.h 
b/arch/arm/mach-pxa/include/mach/eseries-gpio.h
index efbd2aa..02b28e0 100644
--- a/arch/arm/mach-pxa/include/mach/eseries-gpio.h
+++ b/arch/arm/mach-pxa/include/mach/eseries-gpio.h
@@ -45,6 +45,11 @@
  /* e7xx IrDA power control */
  #define GPIO_E7XX_IR_OFF         38

+/* e750 audio control GPIOs */
+#define GPIO_E750_HP_AMP_OFF      4
+#define GPIO_E750_SPK_AMP_OFF     7
+#define GPIO_E750_HP_DETECT      37
+
  /* ASIC related GPIOs */
  #define GPIO_ESERIES_TMIO_IRQ        5
  #define GPIO_ESERIES_TMIO_PCLR      19
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index a00066f..5fb9513 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -61,6 +61,15 @@ config SND_PXA2XX_SOC_TOSA
  	  Say Y if you want to add support for SoC audio on Sharp
  	  Zaurus SL-C6000x models (Tosa).

+config SND_PXA2XX_SOC_E750
+	tristate "SoC AC97 Audio support for e750"
+	depends on SND_PXA2XX_SOC && MACH_E750
+	select SND_SOC_WM9705
+	select SND_PXA2XX_SOC_AC97
+	help
+	  Say Y if you want to add support for SoC audio on the
+	  toshiba e750 PDA
+
  config SND_PXA2XX_SOC_E800
  	tristate "SoC AC97 Audio support for e800"
  	depends on SND_PXA2XX_SOC && MACH_E800
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index bf974b1..9c7a2a0 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_SND_PXA_SOC_SSP) += snd-soc-pxa-ssp.o
  snd-soc-corgi-objs := corgi.o
  snd-soc-poodle-objs := poodle.o
  snd-soc-tosa-objs := tosa.o
+snd-soc-e750-objs := e750_wm9705.o
  snd-soc-e800-objs := e800_wm9712.o
  snd-soc-em-x270-objs := em-x270.o
  snd-soc-spitz-objs := spitz.o
@@ -35,6 +36,7 @@ snd-soc-zylonite-objs := zylonite.o
  obj-$(CONFIG_SND_PXA2XX_SOC_CORGI) += snd-soc-corgi.o
  obj-$(CONFIG_SND_PXA2XX_SOC_POODLE) += snd-soc-poodle.o
  obj-$(CONFIG_SND_PXA2XX_SOC_TOSA) += snd-soc-tosa.o
+obj-$(CONFIG_SND_PXA2XX_SOC_E750) += snd-soc-e750.o
  obj-$(CONFIG_SND_PXA2XX_SOC_E800) += snd-soc-e800.o
  obj-$(CONFIG_SND_PXA2XX_SOC_EM_X270) += snd-soc-em-x270.o
  obj-$(CONFIG_SND_PXA2XX_SOC_SPITZ) += snd-soc-spitz.o
diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
new file mode 100644
index 0000000..20fbdcf
--- /dev/null
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -0,0 +1,189 @@
+/*
+ * e750-wm9705.c  --  SoC audio for e750
+ *
+ * Copyright 2007 (c) Ian Molton <spyro@f2s.com>
+ *
+ *  This program is free software; you can redistribute  it and/or 
modify it
+ *  under  the terms of  the GNU General  Public License as published 
by the
+ *  Free Software Foundation; version 2 ONLY.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/gpio.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <mach/pxa-regs.h>
+#include <mach/hardware.h>
+#include <mach/audio.h>
+#include <mach/eseries-gpio.h>
+
+#include <asm/mach-types.h>
+
+#include "../codecs/wm9705.h"
+#include "pxa2xx-pcm.h"
+#include "pxa2xx-ac97.h"
+
+static int e750_spk_amp_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event)
+{
+	if (event & SND_SOC_DAPM_PRE_PMU)
+		gpio_set_value(GPIO_E750_SPK_AMP_OFF, 0);
+	else if (event & SND_SOC_DAPM_POST_PMD)
+		gpio_set_value(GPIO_E750_SPK_AMP_OFF, 1);
+
+	return 0;
+}
+
+static int e750_hp_amp_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event)
+{
+	if (event & SND_SOC_DAPM_PRE_PMU)
+		gpio_set_value(GPIO_E750_HP_AMP_OFF, 0);
+	else if (event & SND_SOC_DAPM_POST_PMD)
+		gpio_set_value(GPIO_E750_HP_AMP_OFF, 1);
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget e750_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+	SND_SOC_DAPM_MIC("Mic (Internal)", NULL),
+	SND_SOC_DAPM_PGA_E("Headphone Amp", SND_SOC_NOPM, 0, 0, NULL, 0,
+			e750_hp_amp_event, SND_SOC_DAPM_PRE_PMU |
+			SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_PGA_E("Speaker Amp", SND_SOC_NOPM, 0, 0, NULL, 0,
+			e750_spk_amp_event, SND_SOC_DAPM_PRE_PMU |
+			SND_SOC_DAPM_POST_PMD),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	{"Headphone Amp", NULL, "HPOUTL"},
+	{"Headphone Amp", NULL, "HPOUTR"},
+	{"Headphone Jack", NULL, "Headphone Amp"},
+
+	{"Speaker Amp", NULL, "MONOOUT"},
+	{"Speaker", NULL, "Speaker Amp"},
+
+	{"MIC1", NULL, "Mic (Internal)"},
+};
+
+static int e750_ac97_init(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_nc_pin(codec, "LOUT");
+	snd_soc_dapm_nc_pin(codec, "ROUT");
+	snd_soc_dapm_nc_pin(codec, "PHONE");
+	snd_soc_dapm_nc_pin(codec, "LINEINL");
+	snd_soc_dapm_nc_pin(codec, "LINEINR");
+	snd_soc_dapm_nc_pin(codec, "CDINL");
+	snd_soc_dapm_nc_pin(codec, "CDINR");
+	snd_soc_dapm_nc_pin(codec, "PCBEEP");
+	snd_soc_dapm_nc_pin(codec, "MIC2");
+
+	snd_soc_dapm_new_controls(codec, e750_dapm_widgets,
+					ARRAY_SIZE(e750_dapm_widgets));
+
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link e750_dai[] = {
+	{
+		.name = "AC97",
+		.stream_name = "AC97 HiFi",
+		.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_HIFI],
+		.codec_dai = &wm9705_dai[WM9705_DAI_AC97_HIFI],
+		.init = e750_ac97_init,
+		/* use ops to check startup state */
+	},
+	{
+		.name = "AC97 Aux",
+		.stream_name = "AC97 Aux",
+		.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_AUX],
+		.codec_dai = &wm9705_dai[WM9705_DAI_AC97_AUX],
+	},
+};
+
+static struct snd_soc_card e750 = {
+	.name = "Toshiba e750",
+	.platform = &pxa2xx_soc_platform,
+	.dai_link = e750_dai,
+	.num_links = ARRAY_SIZE(e750_dai),
+};
+
+static struct snd_soc_device e750_snd_devdata = {
+	.card = &e750,
+	.codec_dev = &soc_codec_dev_wm9705,
+};
+
+static struct platform_device *e750_snd_device;
+
+static int __init e750_init(void)
+{
+	int ret;
+
+	if (!machine_is_e750())
+		return -ENODEV;
+
+	ret = gpio_request(GPIO_E750_HP_AMP_OFF,  "Headphone amp");
+	if (ret)
+		return ret;
+
+	ret = gpio_request(GPIO_E750_SPK_AMP_OFF, "Speaker amp");
+	if (ret)
+		goto free_hp_amp_gpio;
+
+	ret = gpio_direction_output(GPIO_E750_HP_AMP_OFF, 1);
+	if (ret)
+		goto free_spk_amp_gpio;
+
+	ret = gpio_direction_output(GPIO_E750_SPK_AMP_OFF, 1);
+	if (ret)
+		goto free_spk_amp_gpio;
+
+	e750_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!e750_snd_device) {
+		ret = -ENOMEM;
+		goto free_spk_amp_gpio;
+	}
+
+	platform_set_drvdata(e750_snd_device, &e750_snd_devdata);
+	e750_snd_devdata.dev = &e750_snd_device->dev;
+	ret = platform_device_add(e750_snd_device);
+
+	if (!ret)
+		return 0;
+
+/* Fail gracefully */
+	platform_device_put(e750_snd_device);
+free_spk_amp_gpio:
+	gpio_free(GPIO_E750_SPK_AMP_OFF);
+free_hp_amp_gpio:
+	gpio_free(GPIO_E750_HP_AMP_OFF);
+
+	return ret;
+}
+
+static void __exit e750_exit(void)
+{
+	platform_device_unregister(e750_snd_device);
+	gpio_free(GPIO_E750_SPK_AMP_OFF);
+	gpio_free(GPIO_E750_HP_AMP_OFF);
+}
+
+module_init(e750_init);
+module_exit(e750_exit);
+
+/* Module information */
+MODULE_AUTHOR("Ian Molton <spyro@f2s.com>");
+MODULE_DESCRIPTION("ALSA SoC driver for e750");
+MODULE_LICENSE("GPL v2");
-- 
1.5.6.5

 From aa97a30fdc180c73d7af89debb3324f598ec5705 Mon Sep 17 00:00:00 2001
From: Ian Molton <ian@mnementh.co.uk>
Date: Thu, 8 Jan 2009 21:16:05 +0000
Subject: [PATCH] ASoC: machine driver for Toshiba e800

This patch adds support for the wm9712 ac97 codec as used in the Toshiba 
e800
PDA. It includes support for powering up / down the external headphone and
speaker amplifiers on this machine.

Signed-off-by: Ian Molton <ian@mnementh.co.uk>
---
  arch/arm/mach-pxa/include/mach/eseries-gpio.h |    5 +
  sound/soc/pxa/e800_wm9712.c                   |  116 
++++++++++++++++++++++---
  2 files changed, 107 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/eseries-gpio.h 
b/arch/arm/mach-pxa/include/mach/eseries-gpio.h
index 02b28e0..6d6e4d8 100644
--- a/arch/arm/mach-pxa/include/mach/eseries-gpio.h
+++ b/arch/arm/mach-pxa/include/mach/eseries-gpio.h
@@ -50,6 +50,11 @@
  #define GPIO_E750_SPK_AMP_OFF     7
  #define GPIO_E750_HP_DETECT      37

+/* e800 audio control GPIOs */
+#define GPIO_E800_HP_DETECT      81
+#define GPIO_E800_HP_AMP_OFF     82
+#define GPIO_E800_SPK_AMP_ON     83
+
  /* ASIC related GPIOs */
  #define GPIO_ESERIES_TMIO_IRQ        5
  #define GPIO_ESERIES_TMIO_PCLR      19
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index 2e3386d..78a1770 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -1,8 +1,6 @@
  /*
   * e800-wm9712.c  --  SoC audio for e800
   *
- * Based on tosa.c
- *
   * Copyright 2007 (c) Ian Molton <spyro@f2s.com>
   *
   *  This program is free software; you can redistribute  it and/or 
modify it
@@ -13,31 +11,96 @@

  #include <linux/module.h>
  #include <linux/moduleparam.h>
-#include <linux/device.h>
+#include <linux/gpio.h>

  #include <sound/core.h>
  #include <sound/pcm.h>
  #include <sound/soc.h>
  #include <sound/soc-dapm.h>

-#include <asm/mach-types.h>
  #include <mach/pxa-regs.h>
  #include <mach/hardware.h>
  #include <mach/audio.h>
+#include <mach/eseries-gpio.h>
+
+#include <asm/mach-types.h>

  #include "../codecs/wm9712.h"
  #include "pxa2xx-pcm.h"
  #include "pxa2xx-ac97.h"

-static struct snd_soc_card e800;
+static int e800_spk_amp_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event)
+{
+	if (event & SND_SOC_DAPM_PRE_PMU)
+		gpio_set_value(GPIO_E800_SPK_AMP_ON, 1);
+	else if (event & SND_SOC_DAPM_POST_PMD)
+		gpio_set_value(GPIO_E800_SPK_AMP_ON, 0);

-static struct snd_soc_dai_link e800_dai[] = {
+	return 0;
+}
+
+static int e800_hp_amp_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event)
  {
-	.name = "AC97 Aux",
-	.stream_name = "AC97 Aux",
-	.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_AUX],
-	.codec_dai = &wm9712_dai[WM9712_DAI_AC97_AUX],
-},
+	if (event & SND_SOC_DAPM_PRE_PMU)
+		gpio_set_value(GPIO_E800_HP_AMP_OFF, 0);
+	else if (event & SND_SOC_DAPM_POST_PMD)
+		gpio_set_value(GPIO_E800_HP_AMP_OFF, 1);
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget e800_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Mic (Internal1)", NULL),
+	SND_SOC_DAPM_MIC("Mic (Internal2)", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+	SND_SOC_DAPM_PGA_E("Headphone Amp", SND_SOC_NOPM, 0, 0, NULL, 0,
+			e800_hp_amp_event, SND_SOC_DAPM_PRE_PMU |
+			SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_PGA_E("Speaker Amp", SND_SOC_NOPM, 0, 0, NULL, 0,
+			e800_spk_amp_event, SND_SOC_DAPM_PRE_PMU |
+			SND_SOC_DAPM_POST_PMD),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	{"Headphone Jack", NULL, "HPOUTL"},
+	{"Headphone Jack", NULL, "HPOUTR"},
+	{"Headphone Jack", NULL, "Headphone Amp"},
+
+	{"Speaker Amp", NULL, "MONOOUT"},
+	{"Speaker", NULL, "Speaker Amp"},
+
+	{"MIC1", NULL, "Mic (Internal1)"},
+	{"MIC2", NULL, "Mic (Internal2)"},
+};
+
+static int e800_ac97_init(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_new_controls(codec, e800_dapm_widgets,
+					ARRAY_SIZE(e800_dapm_widgets));
+
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link e800_dai[] = {
+	{
+		.name = "AC97",
+		.stream_name = "AC97 HiFi",
+		.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_HIFI],
+		.codec_dai = &wm9712_dai[WM9712_DAI_AC97_HIFI],
+		.init = e800_ac97_init,
+	},
+	{
+		.name = "AC97 Aux",
+		.stream_name = "AC97 Aux",
+		.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_AUX],
+		.codec_dai = &wm9712_dai[WM9712_DAI_AC97_AUX],
+	},
  };

  static struct snd_soc_card e800 = {
@@ -61,6 +124,22 @@ static int __init e800_init(void)
  	if (!machine_is_e800())
  		return -ENODEV;

+	ret = gpio_request(GPIO_E800_HP_AMP_OFF,  "Headphone amp");
+	if (ret)
+		return ret;
+
+	ret = gpio_request(GPIO_E800_SPK_AMP_ON, "Speaker amp");
+	if (ret)
+		goto free_hp_amp_gpio;
+
+	ret = gpio_direction_output(GPIO_E800_HP_AMP_OFF, 1);
+	if (ret)
+		goto free_spk_amp_gpio;
+
+	ret = gpio_direction_output(GPIO_E800_SPK_AMP_ON, 1);
+	if (ret)
+		goto free_spk_amp_gpio;
+
  	e800_snd_device = platform_device_alloc("soc-audio", -1);
  	if (!e800_snd_device)
  		return -ENOMEM;
@@ -69,8 +148,15 @@ static int __init e800_init(void)
  	e800_snd_devdata.dev = &e800_snd_device->dev;
  	ret = platform_device_add(e800_snd_device);

-	if (ret)
-		platform_device_put(e800_snd_device);
+	if (!ret)
+		return 0;
+
+/* Fail gracefully */
+	platform_device_put(e800_snd_device);
+free_spk_amp_gpio:
+	gpio_free(GPIO_E800_SPK_AMP_ON);
+free_hp_amp_gpio:
+	gpio_free(GPIO_E800_HP_AMP_OFF);

  	return ret;
  }
@@ -78,6 +164,8 @@ static int __init e800_init(void)
  static void __exit e800_exit(void)
  {
  	platform_device_unregister(e800_snd_device);
+	gpio_free(GPIO_E800_SPK_AMP_ON);
+	gpio_free(GPIO_E800_HP_AMP_OFF);
  }

  module_init(e800_init);
@@ -86,4 +174,4 @@ module_exit(e800_exit);
  /* Module information */
  MODULE_AUTHOR("Ian Molton <spyro@f2s.com>");
  MODULE_DESCRIPTION("ALSA SoC driver for e800");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
1.5.6.5
