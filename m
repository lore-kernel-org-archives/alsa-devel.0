From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Add ASoC UDA1380 codec driver.
Date: Tue, 20 Nov 2007 09:25:40 +0000
Message-ID: <1195550746-6892-18-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 306D3249E3
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 10:43:38 +0100 (CET)
In-Reply-To: <1195550746-6892-17-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Giorgio Padrin <giorgio@mandarinlogiq.org>, Liam Girdwood <liam@localhost.localdomain>, Richard Purdie <richard@openedhand.com>, i2c@lm-sensors.org, Philipp Zabel <philipp.zabel@gmail.com>, liam.girdwood@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam@localhost.localdomain>

Signed-off-by: Giorgio Padrin <giorgio@mandarinlogiq.org>
Signed-off-by: Richard Purdie <richard@openedhand.com>
Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: i2c@lm-sensors.org
---
 include/linux/i2c-id.h     |    1 +
 sound/soc/codecs/Kconfig   |    4 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/uda1380.c |  740 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/uda1380.h |   89 ++++++
 5 files changed, 836 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/uda1380.c
 create mode 100644 sound/soc/codecs/uda1380.h

diff --git a/include/linux/i2c-id.h b/include/linux/i2c-id.h
index f6a1ddf..85472a1 100644
--- a/include/linux/i2c-id.h
+++ b/include/linux/i2c-id.h
@@ -123,6 +123,7 @@
 #define I2C_DRIVERID_CS4270	94	/* Cirrus Logic 4270 audio codec */
 #define I2C_DRIVERID_AK4535	95	/* AK4525 audio codec */
 #define I2C_DRIVERID_TLV320	97	/* TLV 320 audio codec */
+#define I2C_DRIVERID_UDA1380	98	/* Philips UDA1380 audio codec */
 
 #define I2C_DRIVERID_I2CDEV	900
 #define I2C_DRIVERID_ARP        902    /* SMBus ARP Client              */
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 2608499..4c05f60 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -10,6 +10,10 @@ config SND_SOC_TLV320
 	tristate
 	depends on SND_SOC
 
+config SND_SOC_UDA1380
+	tristate
+	depends on SND_SOC
+
 config SND_SOC_WM8731
 	tristate
 	depends on SND_SOC
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 3cce68b..bce9fe0 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -1,6 +1,7 @@
 snd-soc-ac97-objs := ac97.o
 snd-soc-ak4535-objs := ak4535.o
 snd-soc-tlv320-objs := tlv320.o
+snd-soc-uda1380-objs := uda1380.o
 snd-soc-wm8731-objs := wm8731.o
 snd-soc-wm8750-objs := wm8750.o
 snd-soc-wm8753-objs := wm8753.o
@@ -11,6 +12,7 @@ snd-soc-cs4270-objs := cs4270.o
 obj-$(CONFIG_SND_SOC_AC97_CODEC)	+= snd-soc-ac97.o
 obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
 obj-$(CONFIG_SND_SOC_TLV320)	+= snd-soc-tlv320.o
+obj-$(CONFIG_SND_SOC_UDA1380)	+= snd-soc-uda1380.o
 obj-$(CONFIG_SND_SOC_WM8731)	+= snd-soc-wm8731.o
 obj-$(CONFIG_SND_SOC_WM8750)	+= snd-soc-wm8750.o
 obj-$(CONFIG_SND_SOC_WM8753)	+= snd-soc-wm8753.o
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
new file mode 100644
index 0000000..0fa9832
--- /dev/null
+++ b/sound/soc/codecs/uda1380.c
@@ -0,0 +1,740 @@
+/*
+ * uda1380.c - Philips UDA1380 ALSA SoC audio driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Modified by Richard Purdie <richard@openedhand.com> to fit into SoC
+ * codec model.
+ *
+ * Copyright (c) 2005 Giorgio Padrin <giorgio@mandarinlogiq.org>
+ * Copyright 2005 Openedhand Ltd.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/ioctl.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/control.h>
+#include <sound/initval.h>
+#include <sound/info.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include "uda1380.h"
+
+#define UDA1380_VERSION "0.5"
+#define AUDIO_NAME "uda1380"
+/*
+ * Debug
+ */
+
+#define UDA1380_DEBUG 0
+
+#ifdef UDA1380_DEBUG
+#define dbg(format, arg...) \
+	printk(KERN_DEBUG AUDIO_NAME ": " format "\n" , ## arg)
+#else
+#define dbg(format, arg...) do {} while (0)
+#endif
+
+/*
+ * uda1380 register cache
+ */
+static const u16 uda1380_reg[UDA1380_CACHEREGNUM] = {
+	0x0502, 0x0000, 0x0000, 0x3f3f,
+	0x0202, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0xff00, 0x0000, 0x4800,
+	0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x0000, 0x0000, 0x0000,
+	0x0000, 0x8000, 0x0002, 0x0000,
+};
+
+/*
+ * read uda1380 register cache
+ */
+static inline unsigned int uda1380_read_reg_cache(struct snd_soc_codec *codec,
+	unsigned int reg)
+{
+	u16 *cache = codec->reg_cache;
+	if (reg == UDA1380_RESET)
+		return 0;
+	if (reg >= UDA1380_CACHEREGNUM)
+		return -1;
+	return cache[reg];
+}
+
+/*
+ * write uda1380 register cache
+ */
+static inline void uda1380_write_reg_cache(struct snd_soc_codec *codec,
+	u16 reg, unsigned int value)
+{
+	u16 *cache = codec->reg_cache;
+	if (reg >= UDA1380_CACHEREGNUM)
+		return;
+	cache[reg] = value;
+}
+
+/*
+ * write to the UDA1380 register space
+ */
+static int uda1380_write(struct snd_soc_codec *codec, unsigned int reg,
+	unsigned int value)
+{
+	u8 data[3];
+
+	/* data is
+	 *   data[0] is register offset
+	 *   data[1] is MS byte
+	 *   data[2] is LS byte
+	 */
+	data[0] = reg;
+	data[1] = (value & 0xff00) >> 8;
+	data[2] = value & 0x00ff;
+
+	uda1380_write_reg_cache (codec, reg, value);
+
+	/* the interpolator & decimator regs must only be written when the
+	 * codec DAI is active.
+	 */
+	if (!codec->active && (reg >= UDA1380_MVOL))
+		return 0;
+	dbg("uda hw write %x val %x\n", reg, value);
+	if (codec->hw_write(codec->control_data, data, 3) == 3) {
+		unsigned int val;
+		i2c_master_send(codec->control_data, data, 1);
+		i2c_master_recv(codec->control_data, data, 2);
+		val = (data[0]<<8) | data[1];
+		if (val != value) {
+			dbg("READ BACK VAL %x\n", (data[0]<<8) | data[1]);
+			return -EIO;
+		}
+		return 0;
+	} else
+		return -EIO;
+}
+
+#define uda1380_reset(c)	uda1380_write(c, UDA1380_RESET, 0)
+
+/* declarations of ALSA reg_elem_REAL controls */
+static const char *uda1380_deemp[] = {"None", "32kHz", "44.1kHz", "48kHz",
+				      "96kHz"};
+static const char *uda1380_input_sel[] = {"Line", "Mic"};
+static const char *uda1380_output_sel[] = {"Direct", "Mixer"};
+static const char *uda1380_spf_mode[] = {"Flat", "Minimum1", "Minimum2",
+					 "Maximum"};
+
+static const struct soc_enum uda1380_enum[] = {
+	SOC_ENUM_DOUBLE(UDA1380_DEEMP, 0, 8, 5, uda1380_deemp),
+	SOC_ENUM_SINGLE(UDA1380_ADC, 3, 2, uda1380_input_sel),
+	SOC_ENUM_SINGLE(UDA1380_MODE, 14, 4, uda1380_spf_mode),
+	SOC_ENUM_SINGLE(UDA1380_PM, 7, 2, uda1380_output_sel), /* R02_EN_AVC */
+};
+
+static const struct snd_kcontrol_new uda1380_snd_controls[] = {
+	SOC_DOUBLE("Playback Volume", UDA1380_MVOL, 0, 8, 255, 1),
+	SOC_DOUBLE("Mixer Volume", UDA1380_MIXVOL, 0, 8, 255, 1),
+	SOC_ENUM("Sound Processing Filter Mode", uda1380_enum[2]),
+	SOC_DOUBLE("Treble Volume", UDA1380_MODE, 4, 12, 3, 0),
+	SOC_DOUBLE("Bass Volume", UDA1380_MODE, 0, 8, 15, 0),
+	SOC_ENUM("Playback De-emphasis", uda1380_enum[0]),
+	SOC_DOUBLE("Capture Volume", UDA1380_DEC, 0, 8, 127, 0),
+	SOC_DOUBLE("Line Capture Volume", UDA1380_PGA, 0, 8, 15, 0),
+	SOC_SINGLE("Mic Capture Volume", UDA1380_PGA, 8, 11, 0),
+	SOC_DOUBLE("Playback Switch", UDA1380_DEEMP, 3, 11, 1, 1),
+	SOC_SINGLE("Capture Switch", UDA1380_PGA, 15, 1, 0),
+	SOC_SINGLE("AGC Timing", UDA1380_AGC, 8, 7, 0),
+	SOC_SINGLE("AGC Target level", UDA1380_AGC, 2, 3, 1),
+	SOC_SINGLE("AGC Switch", UDA1380_AGC, 0, 1, 0),
+	SOC_SINGLE("Silence", UDA1380_MIXER, 7, 1, 0),
+	SOC_SINGLE("Silence Detection", UDA1380_MIXER, 6, 1, 0),
+};
+
+/* add non dapm controls */
+static int uda1380_add_controls(struct snd_soc_codec *codec)
+{
+	int err, i;
+
+	for (i = 0; i < ARRAY_SIZE(uda1380_snd_controls); i++) {
+		err = snd_ctl_add(codec->card,
+			snd_soc_cnew(&uda1380_snd_controls[i],codec, NULL));
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+/* Input mux */
+static const struct snd_kcontrol_new uda1380_input_mux_control =
+	SOC_DAPM_ENUM("Input Select", uda1380_enum[1]);
+
+/* Output mux */
+static const struct snd_kcontrol_new uda1380_output_mux_control =
+	SOC_DAPM_ENUM("Output Select", uda1380_enum[3]);
+
+static const struct snd_soc_dapm_widget uda1380_dapm_widgets[] = {
+	SND_SOC_DAPM_MUX("Input Mux", SND_SOC_NOPM, 0, 0,
+		&uda1380_input_mux_control),
+	SND_SOC_DAPM_MUX("Output Mux", SND_SOC_NOPM, 0, 0,
+		&uda1380_output_mux_control),
+	SND_SOC_DAPM_PGA("Left PGA", UDA1380_PM, 3, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Right PGA", UDA1380_PM, 1, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Mic LNA", UDA1380_PM, 4, 0, NULL, 0),
+	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", UDA1380_PM, 2, 0),
+	SND_SOC_DAPM_ADC("Right ADC", "Right Capture", UDA1380_PM, 0, 0),
+	SND_SOC_DAPM_INPUT("VINM"),
+	SND_SOC_DAPM_INPUT("VINL"),
+	SND_SOC_DAPM_INPUT("VINR"),
+	SND_SOC_DAPM_MIXER("Analog Mixer", UDA1380_PM, 6, 0, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("VOUTLHP"),
+	SND_SOC_DAPM_OUTPUT("VOUTRHP"),
+	SND_SOC_DAPM_OUTPUT("VOUTL"),
+	SND_SOC_DAPM_OUTPUT("VOUTR"),
+	SND_SOC_DAPM_DAC("DAC", "Playback", UDA1380_PM, 10, 0),
+	SND_SOC_DAPM_PGA("HeadPhone Driver", UDA1380_PM, 13, 0, NULL, 0),
+};
+
+static const char *audio_map[][3] = {
+
+	/* output mux */
+	{"HeadPhone Driver", NULL, "Output Mux"},
+	{"VOUTR", NULL, "Output Mux"},
+	{"VOUTL", NULL, "Output Mux"},
+
+	{"Analog Mixer", NULL, "VINR"},
+	{"Analog Mixer", NULL, "VINL"},
+	{"Analog Mixer", NULL, "DAC"},
+
+	{"Output Mux", "Direct", "DAC"},
+	{"Output Mux", "Mixer", "Analog Mixer"},
+
+	/* headphone driver */
+	{"VOUTLHP", NULL, "HeadPhone Driver"},
+	{"VOUTRHP", NULL, "HeadPhone Driver"},
+
+	/* input mux */
+	{"Left ADC", NULL, "Input Mux"},
+	{"Input Mux", "Mic", "Mic LNA"},
+	{"Input Mux", "Line", "Left PGA"},
+
+	/* right input */
+	{"Right ADC", NULL, "Right PGA"},
+
+	/* inputs */
+	{"Mic LNA", NULL, "VINM"},
+	{"Left PGA", NULL, "VINL"},
+	{"Right PGA", NULL, "VINR"},
+
+	/* terminator */
+	{NULL, NULL, NULL},
+};
+
+static int uda1380_add_widgets(struct snd_soc_codec *codec)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(uda1380_dapm_widgets); i++)
+		snd_soc_dapm_new_control(codec, &uda1380_dapm_widgets[i]);
+
+	/* set up audio path interconnects */
+	for (i = 0; audio_map[i][0] != NULL; i++)
+		snd_soc_dapm_connect_input(codec, audio_map[i][0],
+			audio_map[i][1], audio_map[i][2]);
+
+	snd_soc_dapm_new_widgets(codec);
+	return 0;
+}
+
+static int uda1380_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
+		unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	int iface;
+	/* set up DAI based upon fmt */
+
+	iface = uda1380_read_reg_cache (codec, UDA1380_IFACE);
+	iface &= ~(R01_SFORI_MASK | R01_SIM | R01_SFORO_MASK);
+
+	/* FIXME: how to select I2S for DATAO and MSB for DATAI correctly? */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		iface |= R01_SFORI_I2S | R01_SFORO_I2S;
+		break;
+	case SND_SOC_DAIFMT_LSB:
+		iface |= R01_SFORI_LSB16 | R01_SFORO_I2S;
+		break;
+	case SND_SOC_DAIFMT_MSB:
+		iface |= R01_SFORI_MSB | R01_SFORO_I2S;
+	}
+
+	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) == SND_SOC_DAIFMT_CBM_CFM)
+		iface |= R01_SIM;
+
+	uda1380_write(codec, UDA1380_IFACE, iface);
+
+	return 0;
+}
+
+/*
+ * Flush reg cache
+ * We can only write the interpolator and decimator registers
+ * when the DAI is being clocked by the CPU DAI. It's up to the
+ * machine and cpu DAI driver to do this before we are called.
+ */
+static int uda1380_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+	int reg, reg_start, reg_end, clk;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		reg_start = UDA1380_MVOL;
+		reg_end = UDA1380_MIXER;
+	} else {
+		reg_start = UDA1380_DEC;
+		reg_end = UDA1380_AGC;
+	}
+
+	/* FIXME disable DAC_CLK */
+	clk = uda1380_read_reg_cache (codec, 00);
+	uda1380_write(codec, UDA1380_CLK, clk & ~R00_DAC_CLK);
+
+	for (reg = reg_start; reg <= reg_end; reg++ ) {
+		dbg("reg %x val %x\n",reg, uda1380_read_reg_cache (codec, reg));
+		uda1380_write(codec, reg, uda1380_read_reg_cache (codec, reg));
+	}
+
+	/* FIXME enable DAC_CLK */
+	uda1380_write(codec, UDA1380_CLK, clk | R00_DAC_CLK);
+
+	return 0;
+}
+
+static int uda1380_pcm_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+	u16 clk = uda1380_read_reg_cache(codec, UDA1380_CLK);
+
+	/* set WSPLL power and divider if running from this clock */
+	if (clk & R00_DAC_CLK) {
+		int rate = params_rate(params);
+		u16 pm = uda1380_read_reg_cache(codec, UDA1380_PM);
+		clk &= ~0x3; /* clear SEL_LOOP_DIV */
+		switch (rate) {
+		case 6250 ... 12500:
+			clk |= 0x0;
+			break;
+		case 12501 ... 25000:
+			clk |= 0x1;
+			break;
+		case 25001 ... 50000:
+			clk |= 0x2;
+			break;
+		case 50001 ... 100000:
+			clk |= 0x3;
+			break;
+		}
+		uda1380_write(codec, UDA1380_PM, R02_PON_PLL | pm);
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		clk |= R00_EN_DAC | R00_EN_INT;
+	else
+		clk |= R00_EN_ADC | R00_EN_DEC;
+
+	uda1380_write(codec, UDA1380_CLK, clk);
+	return 0;
+}
+
+static void uda1380_pcm_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+	u16 clk = uda1380_read_reg_cache(codec, UDA1380_CLK);
+
+	/* shut down WSPLL power if running from this clock */
+	if (clk & R00_DAC_CLK) {
+		u16 pm = uda1380_read_reg_cache(codec, UDA1380_PM);
+		uda1380_write(codec, UDA1380_PM, ~R02_PON_PLL & pm);
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		clk &= ~(R00_EN_DAC | R00_EN_INT);
+	else
+		clk &= ~(R00_EN_ADC | R00_EN_DEC);
+
+	uda1380_write(codec, UDA1380_CLK, clk);
+}
+
+static int uda1380_mute(struct snd_soc_codec_dai *codec_dai, int mute)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	u16 mute_reg = uda1380_read_reg_cache(codec, UDA1380_DEEMP) & 0xbfff;
+
+	/* FIXME: mute(codec,0) is called when the magician clock is already
+	 * set to WSPLL, but for some unknown reason writing to interpolator
+	 * registers works only when clocked by SYSCLK */
+	u16 clk = uda1380_read_reg_cache(codec, UDA1380_CLK);
+	uda1380_write(codec, UDA1380_CLK, ~R00_DAC_CLK & clk);
+	if (mute)
+		uda1380_write(codec, UDA1380_DEEMP, mute_reg | 0x4000);
+	else
+		uda1380_write(codec, UDA1380_DEEMP, mute_reg);
+	uda1380_write(codec, UDA1380_CLK, clk);
+	return 0;
+}
+
+static int uda1380_dapm_event(struct snd_soc_codec *codec, int event)
+{
+	int pm = uda1380_read_reg_cache(codec, UDA1380_PM);
+
+	switch (event) {
+	case SNDRV_CTL_POWER_D0: /* full On */
+	case SNDRV_CTL_POWER_D1: /* partial On */
+	case SNDRV_CTL_POWER_D2: /* partial On */
+		/* enable internal bias */
+		uda1380_write(codec, UDA1380_PM, R02_PON_BIAS | pm);
+		break;
+	case SNDRV_CTL_POWER_D3hot: /* Off, with power */
+		/* everything off except internal bias */
+		uda1380_write(codec, UDA1380_PM, R02_PON_BIAS);
+		break;
+	case SNDRV_CTL_POWER_D3cold: /* Off, without power */
+		/* everything off, inactive */
+		uda1380_write(codec, UDA1380_PM, 0x0);
+		break;
+	}
+	codec->dapm_state = event;
+	return 0;
+}
+
+#define UDA1380_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
+		       SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
+		       SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
+
+struct snd_soc_codec_dai uda1380_dai[] = {
+{
+	.name = "UDA1380",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = UDA1380_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = UDA1380_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+	.ops = {
+		.hw_params = uda1380_pcm_hw_params,
+		.shutdown = uda1380_pcm_shutdown,
+		.prepare = uda1380_pcm_prepare,
+	},
+	.dai_ops = {
+		.digital_mute = uda1380_mute,
+		.set_fmt = uda1380_set_dai_fmt,
+	},
+},
+{/* playback only  - dual interface */
+	.name = "UDA1380",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = UDA1380_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.ops = {
+		.hw_params = uda1380_pcm_hw_params,
+		.shutdown = uda1380_pcm_shutdown,
+		.prepare = uda1380_pcm_prepare,
+	},
+	.dai_ops = {
+		.digital_mute = uda1380_mute,
+		.set_fmt = uda1380_set_dai_fmt,
+	},
+},
+{ /* capture only - dual interface*/
+	.name = "UDA1380",
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = UDA1380_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.ops = {
+		.hw_params = uda1380_pcm_hw_params,
+		.shutdown = uda1380_pcm_shutdown,
+		.prepare = uda1380_pcm_prepare,
+	},
+	.dai_ops = {
+		.set_fmt = uda1380_set_dai_fmt,
+	},
+},
+};
+EXPORT_SYMBOL_GPL(uda1380_dai);
+
+static int uda1380_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+
+	uda1380_dapm_event(codec, SNDRV_CTL_POWER_D3cold);
+	return 0;
+}
+
+static int uda1380_resume(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+	int i;
+	u8 data[2];
+	u16 *cache = codec->reg_cache;
+
+	/* Sync reg_cache with the hardware */
+	for (i = 0; i < ARRAY_SIZE(uda1380_reg); i++) {
+		data[0] = (i << 1) | ((cache[i] >> 8) & 0x0001);
+		data[1] = cache[i] & 0x00ff;
+		codec->hw_write(codec->control_data, data, 2);
+	}
+	uda1380_dapm_event(codec, SNDRV_CTL_POWER_D3hot);
+	uda1380_dapm_event(codec, codec->suspend_dapm_state);
+	return 0;
+}
+
+/*
+ * initialise the UDA1380 driver
+ * register the mixer and dsp interfaces with the kernel
+ */
+static int uda1380_init(struct snd_soc_device *socdev, int dac_clk)
+{
+	struct snd_soc_codec *codec = socdev->codec;
+	int ret = 0;
+
+	codec->name = "UDA1380";
+	codec->owner = THIS_MODULE;
+	codec->read = uda1380_read_reg_cache;
+	codec->write = uda1380_write;
+	codec->dapm_event = uda1380_dapm_event;
+	codec->dai = uda1380_dai;
+	codec->num_dai = ARRAY_SIZE(uda1380_dai);
+	codec->reg_cache_size = sizeof(uda1380_reg);
+	codec->reg_cache = kmemdup(uda1380_reg, sizeof(uda1380_reg), GFP_KERNEL);
+
+	if (codec->reg_cache == NULL)
+		return -ENOMEM;
+
+	uda1380_reset(codec);
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if(ret < 0) {
+		printk(KERN_ERR "uda1380: failed to create pcms\n");
+		goto pcm_err;
+	}
+
+	/* power on device */
+	uda1380_dapm_event(codec, SNDRV_CTL_POWER_D3hot);
+	/* set clock input */
+	switch (dac_clk) {
+	case UDA1380_DAC_CLK_SYSCLK:
+		uda1380_write(codec, UDA1380_CLK, 0);
+		break;
+	case UDA1380_DAC_CLK_WSPLL:
+		uda1380_write(codec, UDA1380_CLK, R00_DAC_CLK);
+		break;
+	}
+
+	/* uda1380 init */
+	uda1380_add_controls(codec);
+	uda1380_add_widgets(codec);
+	ret = snd_soc_register_card(socdev);
+	if (ret < 0) {
+		printk(KERN_ERR "uda1380: failed to register card\n");
+		goto card_err;
+	}
+
+	return ret;
+
+card_err:
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+pcm_err:
+	kfree(codec->reg_cache);
+	return ret;
+}
+
+static struct snd_soc_device *uda1380_socdev;
+
+#if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)
+
+static unsigned short normal_i2c[] = { 0, I2C_CLIENT_END };
+
+/* Magic definition of all other variables and things */
+I2C_CLIENT_INSMOD;
+
+static struct i2c_driver uda1380_i2c_driver;
+static struct i2c_client client_template;
+
+/* If the i2c layer weren't so broken, we could pass this kind of data
+   around */
+
+static int uda1380_codec_probe(struct i2c_adapter *adap, int addr, int kind)
+{
+	struct snd_soc_device *socdev = uda1380_socdev;
+	struct uda1380_setup_data *setup = socdev->codec_data;
+	struct snd_soc_codec *codec = socdev->codec;
+	struct i2c_client *i2c;
+	int ret;
+
+	if (addr != setup->i2c_address)
+		return -ENODEV;
+
+	client_template.adapter = adap;
+	client_template.addr = addr;
+
+	i2c = kmemdup(&client_template, sizeof(client_template), GFP_KERNEL);
+	if (i2c == NULL){
+		kfree(codec);
+		return -ENOMEM;
+	}
+	i2c_set_clientdata(i2c, codec);
+	codec->control_data = i2c;
+
+	ret = i2c_attach_client(i2c);
+	if (ret < 0) {
+		printk(KERN_ERR "failed to attach codec at addr %x\n", addr);
+		goto err;
+	}
+
+	ret = uda1380_init(socdev, setup->dac_clk);
+	if (ret < 0) {
+		printk(KERN_ERR "failed to initialise UDA1380\n");
+		goto err;
+	}
+	return ret;
+
+err:
+	kfree(codec);
+	kfree(i2c);
+	return ret;
+}
+
+static int uda1380_i2c_detach(struct i2c_client *client)
+{
+	struct snd_soc_codec* codec = i2c_get_clientdata(client);
+	i2c_detach_client(client);
+	kfree(codec->reg_cache);
+	kfree(client);
+	return 0;
+}
+
+static int uda1380_i2c_attach(struct i2c_adapter *adap)
+{
+	return i2c_probe(adap, &addr_data, uda1380_codec_probe);
+}
+
+/* corgi i2c codec control layer */
+static struct i2c_driver uda1380_i2c_driver = {
+	.driver = {
+		.name =  "UDA1380 I2C Codec",
+		.owner = THIS_MODULE,
+	},
+	.id =             I2C_DRIVERID_UDA1380,
+	.attach_adapter = uda1380_i2c_attach,
+	.detach_client =  uda1380_i2c_detach,
+	.command =        NULL,
+};
+
+static struct i2c_client client_template = {
+	.name =   "UDA1380",
+	.driver = &uda1380_i2c_driver,
+};
+#endif
+
+static int uda1380_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct uda1380_setup_data *setup;
+	struct snd_soc_codec* codec;
+	int ret = 0;
+
+	printk(KERN_INFO "UDA1380 Audio Codec %s", UDA1380_VERSION);
+
+	setup = socdev->codec_data;
+	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (codec == NULL)
+		return -ENOMEM;
+
+	socdev->codec = codec;
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	uda1380_socdev = socdev;
+#if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)
+	if (setup->i2c_address) {
+		normal_i2c[0] = setup->i2c_address;
+		codec->hw_write = (hw_write_t)i2c_master_send;
+		ret = i2c_add_driver(&uda1380_i2c_driver);
+		if (ret != 0)
+			printk(KERN_ERR "can't add i2c driver");
+	}
+#else
+	/* Add other interfaces here */
+#endif
+	return ret;
+}
+
+/* power down chip */
+static int uda1380_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec* codec = socdev->codec;
+
+	if (codec->control_data)
+		uda1380_dapm_event(codec, SNDRV_CTL_POWER_D3cold);
+
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+#if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)
+	i2c_del_driver(&uda1380_i2c_driver);
+#endif
+	kfree(codec);
+
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_uda1380 = {
+	.probe = 	uda1380_probe,
+	.remove = 	uda1380_remove,
+	.suspend = 	uda1380_suspend,
+	.resume =	uda1380_resume,
+};
+
+EXPORT_SYMBOL_GPL(soc_codec_dev_uda1380);
+
+MODULE_AUTHOR("Giorgio Padrin");
+MODULE_DESCRIPTION("Audio support for codec Philips UDA1380");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/uda1380.h b/sound/soc/codecs/uda1380.h
new file mode 100644
index 0000000..f9d885c
--- /dev/null
+++ b/sound/soc/codecs/uda1380.h
@@ -0,0 +1,89 @@
+/*
+ * Audio support for Philips UDA1380
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Copyright (c) 2005 Giorgio Padrin <giorgio@mandarinlogiq.org>
+ */
+
+#ifndef _UDA1380_H
+#define _UDA1380_H
+
+#define UDA1380_CLK	0x00
+#define UDA1380_IFACE	0x01
+#define UDA1380_PM	0x02
+#define UDA1380_AMIX	0x03
+#define UDA1380_HP	0x04
+#define UDA1380_MVOL	0x10
+#define UDA1380_MIXVOL	0x11
+#define UDA1380_MODE	0x12
+#define UDA1380_DEEMP	0x13
+#define UDA1380_MIXER	0x14
+#define UDA1380_INTSTAT	0x18
+#define UDA1380_DEC	0x20
+#define UDA1380_PGA	0x21
+#define UDA1380_ADC	0x22
+#define UDA1380_AGC	0x23
+#define UDA1380_DECSTAT	0x28
+#define UDA1380_RESET	0x7f
+
+#define UDA1380_CACHEREGNUM 0x24
+
+/* Register flags */
+#define R00_EN_ADC	0x0800
+#define R00_EN_DEC	0x0400
+#define R00_EN_DAC	0x0200
+#define R00_EN_INT	0x0100
+#define R00_DAC_CLK	0x0010
+#define R01_SFORI_I2S   0x0000
+#define R01_SFORI_LSB16 0x0100
+#define R01_SFORI_LSB18 0x0200
+#define R01_SFORI_LSB20 0x0300
+#define R01_SFORI_MSB   0x0500
+#define R01_SFORI_MASK  0x0700
+#define R01_SFORO_I2S   0x0000
+#define R01_SFORO_LSB16 0x0001
+#define R01_SFORO_LSB18 0x0002
+#define R01_SFORO_LSB20 0x0003
+#define R01_SFORO_LSB24 0x0004
+#define R01_SFORO_MSB   0x0005
+#define R01_SFORO_MASK  0x0007
+#define R01_SEL_SOURCE  0x0040
+#define R01_SIM		0x0010
+#define R02_PON_PLL	0x8000
+#define R02_PON_HP	0x2000
+#define R02_PON_DAC	0x0400
+#define R02_PON_BIAS	0x0100
+#define R02_EN_AVC	0x0080
+#define R02_PON_AVC	0x0040
+#define R02_PON_LNA	0x0010
+#define R02_PON_PGAL	0x0008
+#define R02_PON_ADCL	0x0004
+#define R02_PON_PGAR	0x0002
+#define R02_PON_ADCR	0x0001
+#define R13_MTM		0x4000
+#define R14_SILENCE	0x0080
+#define R14_SDET_ON	0x0040
+#define R21_MT_ADC	0x8000
+#define R22_SEL_LNA	0x0008
+#define R22_SEL_MIC	0x0004
+#define R22_SKIP_DCFIL	0x0002
+#define R23_AGC_EN	0x0001
+
+struct uda1380_setup_data {
+	unsigned short i2c_address;
+	int            dac_clk;
+#define UDA1380_DAC_CLK_SYSCLK 0
+#define UDA1380_DAC_CLK_WSPLL  1
+};
+
+#define UDA1380_DAI_DUPLEX	0 /* playback and capture on single DAI */
+#define UDA1380_DAI_PLAYBACK	1 /* playback DAI */
+#define UDA1380_DAI_CAPTURE	2 /* capture DAI */
+
+extern struct snd_soc_codec_dai uda1380_dai[3];
+extern struct snd_soc_codec_device soc_codec_dev_uda1380;
+
+#endif /* _UDA1380_H */
-- 
1.5.3.5
