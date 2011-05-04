From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 01/19] ASoC: upd9976: Add Renesas uPD9976 codec
	driver
Date: Wed, 04 May 2011 21:44:58 +0800
Message-ID: <20110504134458.32443.45825.stgit@localhost>
References: <20110504133756.32443.6282.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id DA8E4103806
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 15:43:36 +0200 (CEST)
In-Reply-To: <20110504133756.32443.6282.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Koul Vinod <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

uPD9976 is a complex codec, however this patch only provides basic playback
functionality for headphone. More functionality will be added bit by bit in the
following patches.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
---
 sound/soc/codecs/Kconfig   |    4 
 sound/soc/codecs/Makefile  |    2 
 sound/soc/codecs/upd9976.c |  407 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/upd9976.h |   83 +++++++++
 4 files changed, 496 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/upd9976.c
 create mode 100644 sound/soc/codecs/upd9976.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 2a69718..b914bc6 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -52,6 +52,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TWL6040 if TWL4030_CORE
 	select SND_SOC_UDA134X
 	select SND_SOC_UDA1380 if I2C
+	select SND_SOC_UPD9976 if INTEL_SCU_IPC
 	select SND_SOC_WL1273 if MFD_WL1273_CORE
 	select SND_SOC_WM1250_EV1 if I2C
 	select SND_SOC_WM2000 if I2C
@@ -244,6 +245,9 @@ config SND_SOC_UDA134X
 config SND_SOC_UDA1380
         tristate
 
+config SND_SOC_UPD9976
+	tristate
+
 config SND_SOC_WL1273
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 4cb2f42..163c623 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -37,6 +37,7 @@ snd-soc-twl4030-objs := twl4030.o
 snd-soc-twl6040-objs := twl6040.o
 snd-soc-uda134x-objs := uda134x.o
 snd-soc-uda1380-objs := uda1380.o
+snd-soc-upd9976-objs := upd9976.o
 snd-soc-wl1273-objs := wl1273.o
 snd-soc-wm1250-ev1-objs := wm1250-ev1.o
 snd-soc-wm8350-objs := wm8350.o
@@ -128,6 +129,7 @@ obj-$(CONFIG_SND_SOC_TWL4030)	+= snd-soc-twl4030.o
 obj-$(CONFIG_SND_SOC_TWL6040)	+= snd-soc-twl6040.o
 obj-$(CONFIG_SND_SOC_UDA134X)	+= snd-soc-uda134x.o
 obj-$(CONFIG_SND_SOC_UDA1380)	+= snd-soc-uda1380.o
+obj-$(CONFIG_SND_SOC_UPD9976)	+= snd-soc-upd9976.o
 obj-$(CONFIG_SND_SOC_WL1273)	+= snd-soc-wl1273.o
 obj-$(CONFIG_SND_SOC_WM1250_EV1) += snd-soc-wm1250-ev1.o
 obj-$(CONFIG_SND_SOC_WM8350)	+= snd-soc-wm8350.o
diff --git a/sound/soc/codecs/upd9976.c b/sound/soc/codecs/upd9976.c
new file mode 100644
index 0000000..cd68633
--- /dev/null
+++ b/sound/soc/codecs/upd9976.c
@@ -0,0 +1,407 @@
+/*
+ *  upd9976.c -  Renesas uPD9976 codec driver
+ *
+ *  Copyright (C) 2011 Intel Corporation
+ *
+ *  Maintainer:
+ *              Lu Guanqun <guanqun.lu@intel.com>
+ *              Wang Xingchao <xingchao.wang@intel.com>
+ *
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ */
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <asm/intel_scu_ipc.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+#include <sound/jack.h>
+#include "upd9976.h"
+
+static inline unsigned int upd9976_read(struct snd_soc_codec *codec,
+					unsigned int reg)
+{
+	u8 value = 0;
+	int ret;
+
+	ret = intel_scu_ipc_ioread8(reg, &value);
+	if (ret)
+		pr_err("upd9976 read of 0x%x failed, error: %d\n", reg, ret);
+	return value;
+}
+
+static inline int upd9976_write(struct snd_soc_codec *codec,
+				unsigned int reg, unsigned int value)
+{
+	int ret;
+
+	ret = intel_scu_ipc_iowrite8(reg, value);
+	if (ret)
+		pr_err("upd9976 write of 0x%x failed, error: %d\n", reg, ret);
+	return ret;
+}
+
+/*
+ * Mixing Volume: from -25 dB to 6 dB in 1 dB steps.
+ */
+static DECLARE_TLV_DB_SCALE(mixer_tlv, -2500, 100, 0);
+
+static const struct snd_kcontrol_new upd9976_snd_controls[] = {
+	SOC_DOUBLE_R_TLV("Headphone & Speaker Volume",
+			 UPD9976_HPSPRLVOL, UPD9976_HPSPRRVOL,
+			 0, 0x1f, 1, mixer_tlv),
+};
+
+static const struct snd_kcontrol_new upd9976_hp_spkr_mixer_left_controls[] = {
+	SOC_DAPM_SINGLE("Audio DAC Left", UPD9976_HPLMIXSEL, 4, 1, 1),
+	SOC_DAPM_SINGLE("Audio DAC Right", UPD9976_HPLMIXSEL, 3, 1, 1),
+};
+
+static const struct snd_kcontrol_new upd9976_hp_spkr_mixer_right_controls[] = {
+	SOC_DAPM_SINGLE("Audio DAC Left", UPD9976_HPRMIXSEL, 4, 1, 1),
+	SOC_DAPM_SINGLE("Audio DAC Right", UPD9976_HPRMIXSEL, 3, 1, 1),
+};
+
+static const struct snd_soc_dapm_widget upd9976_dapm_widgets[] = {
+	/* Input */
+	SND_SOC_DAPM_INPUT("LINEINL"),
+	SND_SOC_DAPM_INPUT("LINEINR"),
+	SND_SOC_DAPM_INPUT("MIC1"),
+	SND_SOC_DAPM_INPUT("MIC2"),
+	SND_SOC_DAPM_INPUT("DMICDAT"),
+	SND_SOC_DAPM_INPUT("HPINL"),
+	SND_SOC_DAPM_INPUT("HPINR"),
+
+	/* Output */
+	SND_SOC_DAPM_OUTPUT("PREOUTL"),
+	SND_SOC_DAPM_OUTPUT("PREOUTR"),
+	SND_SOC_DAPM_OUTPUT("EPOUTP"),
+	SND_SOC_DAPM_OUTPUT("EPOUTN"),
+	SND_SOC_DAPM_OUTPUT("LINEOUTL"),
+	SND_SOC_DAPM_OUTPUT("LINEOUTR"),
+	SND_SOC_DAPM_OUTPUT("HPOUTL"),
+	SND_SOC_DAPM_OUTPUT("HPOUTR"),
+
+	/* DAC */
+	SND_SOC_DAPM_DAC("ADAC", "Audio Playback", UPD9976_POWERCTRL1, 0, 0),
+	SND_SOC_DAPM_DAC("VDAC", "Voice Playback", UPD9976_POWERCTRL1, 6, 0),
+
+	/* ADC */
+	SND_SOC_DAPM_ADC("AADC", "Audio Capture", UPD9976_POWERCTRL1, 1, 0),
+	SND_SOC_DAPM_ADC("VADC", "Voice Capture", UPD9976_POWERCTRL1, 7, 0),
+
+	/* Mixer */
+	SND_SOC_DAPM_MIXER("HP Spkr Mixer Left", UPD9976_POWERCTRL2, 3, 0,
+			   upd9976_hp_spkr_mixer_left_controls,
+			   ARRAY_SIZE(upd9976_hp_spkr_mixer_left_controls)),
+	SND_SOC_DAPM_MIXER("HP Spkr Mixer Right", UPD9976_POWERCTRL2, 2, 0,
+			   upd9976_hp_spkr_mixer_right_controls,
+			   ARRAY_SIZE(upd9976_hp_spkr_mixer_right_controls)),
+
+	/* PGA */
+	SND_SOC_DAPM_PGA("HP Playback Left", UPD9976_DRVPOWERCTRL,
+			 2, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("HP Playback Right", UPD9976_DRVPOWERCTRL,
+			 1, 0, NULL, 0),
+
+};
+
+static const struct snd_soc_dapm_route upd9976_dapm_routes[] = {
+	{"HP Spkr Mixer Left", "Audio DAC Left", "ADAC"},
+	{"HP Spkr Mixer Left", "Audio DAC Right", "ADAC"},
+
+	{"HP Spkr Mixer Right", "Audio DAC Left", "ADAC"},
+	{"HP Spkr Mixer Right", "Audio DAC Right", "ADAC"},
+
+	{"PREOUTL", NULL, "HP Spkr Mixer Left"},
+	{"PREOUTR", NULL, "HP Spkr Mixer Right"},
+
+	{"HP Playback Left", NULL, "HPINL"},
+	{"HP Playback Right", NULL, "HPINR"},
+
+	{"HPOUTL", NULL, "HP Playback Left"},
+	{"HPOUTR", NULL, "HP Playback Right"},
+
+};
+
+static int upd9976_audio_digital_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	unsigned int value, mask;
+
+	/* soft mute on, fast 0.75dB/6fs */
+	value = 0;
+	if (mute)
+		value = 1;
+	mask = BIT(1) | BIT(0);
+	snd_soc_update_bits(codec, UPD9976_SOFTMUTE, mask, value);
+
+	/* mute headphone, internals speaker, internal earpiece mono */
+	value = 0;
+	if (mute)
+		value = BIT(2) | BIT(1) | BIT(0);
+	mask = BIT(2) | BIT(1) | BIT(0);
+	snd_soc_update_bits(codec, UPD9976_LMUTE, mask, value);
+
+	/* mute headphone, internal speaker */
+	value = 0;
+	if (mute)
+		value = BIT(2) | BIT(1);
+	mask = BIT(2) | BIT(1);
+	snd_soc_update_bits(codec, UPD9976_RMUTE, mask, value);
+
+	/* mute audio DAC */
+	value = 0;
+	if (mute)
+		value = BIT(7);
+	mask = BIT(7);
+	snd_soc_update_bits(codec, UPD9976_AUDIOLVOL, mask, value);
+	snd_soc_update_bits(codec, UPD9976_AUDIORVOL, mask, value);
+
+	return 0;
+}
+
+static int upd9976_audio_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	unsigned int mode, mask;
+
+	mask = BIT(5) | BIT(4);
+	mode = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		mode |= BIT(4);
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		mode |= BIT(5);
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		mode |= BIT(5) | BIT(4);
+		break;
+	}
+
+	mask |= BIT(7) | BIT(3);
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+	case SND_SOC_DAIFMT_CBM_CFS:
+		mode |= BIT(7) | BIT(3);
+		break;
+	}
+
+	return snd_soc_update_bits(codec, UPD9976_AUDIOPORT1, mask, mode);
+}
+
+static int upd9976_audio_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params,
+				   struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	unsigned int tmp;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		tmp = 0x00;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		tmp = 0x03;
+		break;
+	case SNDRV_PCM_FORMAT_S18_3LE:
+		tmp = 0x01;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		tmp = 0x02;
+		break;
+	default:
+		return -EINVAL;
+	}
+	snd_soc_update_bits(codec, UPD9976_AUDIOPORT1,
+			    BIT(2)|BIT(1)|BIT(0), tmp);
+
+	switch (params_rate(params)) {
+	case 8000:
+		tmp = 0x00;
+		break;
+	case 11025:
+		tmp = 0x01;
+		break;
+	case 12000:
+		tmp = 0x02;
+		break;
+	case 16000:
+		tmp = 0x03;
+		break;
+	case 22050:
+		tmp = 0x04;
+		break;
+	case 24000:
+		tmp = 0x05;
+		break;
+	case 32000:
+		tmp = 0x07;
+		break;
+	case 44100:
+		tmp = 0x08;
+		break;
+	case 48000:
+		tmp = 0x09;
+		break;
+	default:
+		return -EINVAL;
+	}
+	snd_soc_update_bits(codec, UPD9976_AUDIOPORT2,
+			    BIT(3)|BIT(2)|BIT(1)|BIT(0), tmp);
+
+	return 0;
+}
+
+static int upd9976_audio_set_tristate(struct snd_soc_dai *dai, int tristate)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	if (tristate)
+		snd_soc_update_bits(codec, UPD9976_AUDIOPORT1,
+				    BIT(4)|BIT(5), 0);
+	return 0;
+}
+
+static struct snd_soc_dai_ops upd9976_audio_dai_ops = {
+	.digital_mute	= upd9976_audio_digital_mute,
+	.set_fmt	= upd9976_audio_set_dai_fmt,
+	.set_tristate	= upd9976_audio_set_tristate,
+	.hw_params	= upd9976_audio_hw_params,
+};
+
+static struct snd_soc_dai_driver upd9976_dais[] = {
+{
+	.name = "upd9976-audio",
+	.playback = {
+		.stream_name = "Audio Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = (SNDRV_PCM_RATE_48000 |
+			  SNDRV_PCM_RATE_44100 |
+			  SNDRV_PCM_RATE_8000),
+		.formats = (SNDRV_PCM_FMTBIT_S16 | SNDRV_PCM_FMTBIT_U16 |
+			    SNDRV_PCM_FMTBIT_S24 | SNDRV_PCM_FMTBIT_U24 |
+			    SNDRV_PCM_FMTBIT_S32 | SNDRV_PCM_FMTBIT_U32),
+	},
+	.ops = &upd9976_audio_dai_ops,
+},
+};
+
+static int upd9976_set_bias_level(struct snd_soc_codec *codec,
+				  enum snd_soc_bias_level level)
+{
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		break;
+
+	case SND_SOC_BIAS_PREPARE:
+		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY) {
+			snd_soc_update_bits(codec, UPD9976_VAUDIOCNT,
+					    0x27, 0x27);
+			snd_soc_update_bits(codec, UPD9976_VREFPLL,
+					    0x35, 0x35);
+		}
+		break;
+
+	case SND_SOC_BIAS_STANDBY:
+		snd_soc_write(codec, UPD9976_VAUDIOCNT, 0x25);
+		snd_soc_write(codec, UPD9976_VREFPLL, 0x10);
+		break;
+
+	case SND_SOC_BIAS_OFF:
+		snd_soc_write(codec, UPD9976_VREFPLL, 0);
+		snd_soc_write(codec, UPD9976_VAUDIOCNT, 0x24);
+		break;
+	}
+
+	codec->dapm.bias_level = level;
+	return 0;
+}
+
+static int upd9976_codec_probe(struct snd_soc_codec *codec)
+{
+	upd9976_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	return 0;
+}
+
+static int upd9976_codec_remove(struct snd_soc_codec *codec)
+{
+	return 0;
+}
+
+static struct snd_soc_codec_driver upd9976_codec = {
+	.probe			= upd9976_codec_probe,
+	.remove			= upd9976_codec_remove,
+	.read			= upd9976_read,
+	.write			= upd9976_write,
+	.set_bias_level		= upd9976_set_bias_level,
+
+	.controls		= upd9976_snd_controls,
+	.num_controls		= ARRAY_SIZE(upd9976_snd_controls),
+	.dapm_widgets		= upd9976_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(upd9976_dapm_widgets),
+	.dapm_routes		= upd9976_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(upd9976_dapm_routes),
+};
+
+static int __devinit upd9976_device_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev, &upd9976_codec,
+				      upd9976_dais, ARRAY_SIZE(upd9976_dais));
+}
+
+static int __devexit upd9976_device_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver upd9976_codec_driver = {
+	.driver	= {
+		.name	= "upd9976",
+		.owner	= THIS_MODULE,
+	},
+	.probe	= upd9976_device_probe,
+	.remove	= __devexit_p(upd9976_device_remove),
+};
+
+static int __init upd9976_init(void)
+{
+	return platform_driver_register(&upd9976_codec_driver);
+}
+module_init(upd9976_init);
+
+static void __exit upd9976_exit(void)
+{
+	platform_driver_unregister(&upd9976_codec_driver);
+}
+module_exit(upd9976_exit);
+
+MODULE_DESCRIPTION("ASoC Renesas uPD9976 codec driver");
+MODULE_AUTHOR("Lu Guanqun <guanqun.lu@intel.com>");
+MODULE_AUTHOR("Wang Xingchao <xingchao.wang@intel.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:upd9976");
diff --git a/sound/soc/codecs/upd9976.h b/sound/soc/codecs/upd9976.h
new file mode 100644
index 0000000..ab2ea15
--- /dev/null
+++ b/sound/soc/codecs/upd9976.h
@@ -0,0 +1,83 @@
+/*
+ *  upd9976.h -  Renesas uPD9976 codec driver
+ *
+ *  Copyright (C) 2011 Intel Corporation
+ *
+ *  Maintainer:
+ *              Lu Guanqun <guanqun.lu@intel.com>
+ *              Wang Xingchao <xingchao.wang@intel.com>
+ *
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ */
+#ifndef _UPD9976_H
+#define _UPD9976_H
+
+#define UPD9976_VAUDIOCNT       0x51
+
+#define UPD9976_VOICEPORT1	0x100
+#define UPD9976_VOICEPORT2	0x101
+#define UPD9976_AUDIOPORT1	0x102
+#define UPD9976_AUDIOPORT2	0x103
+#define UPD9976_ADCSAMPLERATE	0x104
+#define UPD9976_DMICCTRL1	0x105
+#define UPD9976_DMICCTRL2	0x106
+#define UPD9976_MICCTRL		0x107
+#define UPD9976_MICSELVOL	0x108
+#define UPD9976_LILSEL		0x109
+#define UPD9976_LIRSEL		0x10a
+#define UPD9976_VOICEVOL	0x10b
+#define UPD9976_AUDIOLVOL	0x10c
+#define UPD9976_AUDIORVOL	0x10d
+#define UPD9976_LMUTE		0x10e
+#define UPD9976_RMUTE		0x10f
+#define UPD9976_POWERCTRL1	0x110
+#define UPD9976_POWERCTRL2	0x111
+#define UPD9976_DRVPOWERCTRL	0x112
+#define UPD9976_VREFPLL		0x113
+#define UPD9976_PCMBUFCTRL	0x114
+#define UPD9976_SOFTMUTE	0x115
+#define UPD9976_DTMFPATH	0x116
+#define UPD9976_DTMFVOL		0x117
+#define UPD9976_DTMFFREQ	0x118
+#define UPD9976_DTMFHFREQ	0x119
+#define UPD9976_DTMFLFREQ	0x11a
+#define UPD9976_DTMFCTRL	0x11b
+#define UPD9976_DTMFASON	0x11c
+#define UPD9976_DTMFASOFF	0x11d
+#define UPD9976_DTMFASINUM	0x11e
+#define UPD9976_CLASSDVOL	0x11f
+#define UPD9976_VOICEDACAVOL	0x120
+#define UPD9976_AUDDACAVOL	0x121
+#define UPD9976_LOMUTEVOL	0x122
+#define UPD9976_HPSPRLVOL	0x123
+#define UPD9976_HPSPRRVOL	0x124
+#define UPD9976_MONOVOL		0x125
+#define UPD9976_LINEOUTMIXVOL	0x126
+#define UPD9976_EPMIXVOL	0x127
+#define UPD9976_LINEOUTLSEL	0x128
+#define UPD9976_LINEOUTRSEL	0x129
+#define UPD9976_EPMIXOUTSEL	0x12a
+#define UPD9976_HPLMIXSEL	0x12b
+#define UPD9976_HPRMIXSEL	0x12c
+#define UPD9976_LOANTIPOP	0x12d
+#define UPD9976_AUXDBNC		0x12f
+
+#define UPD9976_SAUXINT		0x132
+
+#endif
