From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/4] ASoC sst: Add msic codec driver
Date: Thu, 30 Dec 2010 16:42:31 +0530
Message-ID: <1293707551-8308-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 744ED243FE
	for <alsa-devel@alsa-project.org>; Thu, 30 Dec 2010 12:10:54 +0100 (CET)
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
Cc: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, Vinod Koul <vinod.koul@intel.com>, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

This patch adds the msic asoc codec driver. This driver currently supports only playback.
Capture and jack detection to be added later

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/codecs/Kconfig  |    4 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/msic.c   |  490 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/msic.h   |   99 +++++++++
 4 files changed, 595 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/msic.c
 create mode 100644 sound/soc/codecs/msic.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 054191e..5f800da 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -31,6 +31,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_JZ4740_CODEC if SOC_JZ4740
 	select SND_SOC_MAX98088 if I2C
 	select SND_SOC_MAX9877 if I2C
+	select SND_SOC_MSIC if INTEL_SCU_IPC
 	select SND_SOC_PCM3008
 	select SND_SOC_SPDIF
 	select SND_SOC_SSM2602 if I2C
@@ -170,6 +171,9 @@ config SND_SOC_DA7210
 config SND_SOC_MAX98088
        tristate
 
+config SND_SOC_MSIC
+	tristate
+
 config SND_SOC_PCM3008
        tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 6a1e17b..5e57586 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -16,6 +16,7 @@ snd-soc-cx20442-objs := cx20442.o
 snd-soc-da7210-objs := da7210.o
 snd-soc-l3-objs := l3.o
 snd-soc-max98088-objs := max98088.o
+snd-soc-msic-objs := msic.o
 snd-soc-pcm3008-objs := pcm3008.o
 snd-soc-alc5623-objs := alc5623.o
 snd-soc-spdif-objs := spdif_transciever.o
@@ -95,6 +96,7 @@ obj-$(CONFIG_SND_SOC_DA7210)	+= snd-soc-da7210.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
 obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
 obj-$(CONFIG_SND_SOC_MAX98088)	+= snd-soc-max98088.o
+obj-$(CONFIG_SND_SOC_MSIC)	+=snd-soc-msic.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
 obj-$(CONFIG_SND_SOC_ALC5623)    += snd-soc-alc5623.o
 obj-$(CONFIG_SND_SOC_SPDIF)	+= snd-soc-spdif.o
diff --git a/sound/soc/codecs/msic.c b/sound/soc/codecs/msic.c
new file mode 100644
index 0000000..66d9bda
--- /dev/null
+++ b/sound/soc/codecs/msic.c
@@ -0,0 +1,490 @@
+/*
+ *  msic.c - Intel MSIC Codec driver
+ *
+ *  Copyright (C) 2010 Intel Corp
+ *  Author: Vinod Koul <vinod.koul@intel.com>
+ *  Author: Harsha Priya <priya.harsha@intel.com>
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
+ *
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <asm/intel_scu_ipc.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include "msic.h"
+
+#define MSIC_RATES (SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_44100)
+#define MSIC_FORMATS (SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE)
+
+/*
+ * todo:
+ * capture paths
+ * jack detection
+ * PM functions
+ */
+
+static inline unsigned int msic_read(struct snd_soc_codec *codec,
+			unsigned int reg)
+{
+	u8 value = 0;
+	int ret;
+
+	ret = intel_scu_ipc_ioread8(reg, &value);
+	if (ret)
+		pr_err("read of %x failed, err %d\n", reg, ret);
+	pr_debug("read for %x ret %x\n", reg, value);
+	return value;
+
+}
+
+static inline int msic_write(struct snd_soc_codec *codec,
+			unsigned int reg, unsigned int value)
+{
+	int ret;
+
+	pr_debug("write for %x with %x\n", reg, value);
+	ret = intel_scu_ipc_iowrite8(reg, value);
+	if (ret)
+		pr_err("write of %x failed, err %d\n", reg, ret);
+	return ret;
+}
+
+static int msic_set_vaud_bias(struct snd_soc_codec *codec,
+		enum snd_soc_bias_level level)
+{
+	pr_debug("msic_set_vaud_bias %d\n", level);
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		break;
+
+	case SND_SOC_BIAS_PREPARE:
+		pr_debug("vaud_bias _PREPARE\n");
+		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY) {
+			pr_debug("vaud_bias powering up pll\n");
+			/*power up the pll*/
+			msic_write(codec, MSIC_AUDPLLCTRL, BIT(5));
+			/*enable pcm 2*/
+			snd_soc_update_bits(codec, MSIC_PCM2C2, BIT(0), BIT(0));
+		}
+		break;
+
+	case SND_SOC_BIAS_STANDBY:
+		pr_debug("vaud_bias _STANDBY\n");
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
+			pr_debug("vaud_bias power up rail\n");
+			/*power up the rail*/
+			msic_write(codec, MSIC_VAUD, BIT(2)|BIT(1)|BIT(0));
+			msleep(1);
+		} else if (codec->dapm.bias_level == SND_SOC_BIAS_PREPARE) {
+			/*turn off pcm*/
+			pr_debug("vaud_bias power dn pcm\n");
+			snd_soc_update_bits(codec, MSIC_PCM2C2, BIT(0), 0);
+			msic_write(codec, MSIC_AUDPLLCTRL, 0);
+		}
+		break;
+
+
+	case SND_SOC_BIAS_OFF:
+		pr_debug("vaud_bias _OFF doing rail shutdown\n");
+		msic_write(codec, MSIC_VAUD, BIT(3));
+		break;
+	}
+
+	codec->dapm.bias_level = level;
+	return 0;
+}
+
+static int msic_vhs_event(struct snd_soc_dapm_widget *w,
+		    struct snd_kcontrol *kcontrol, int event)
+{
+	pr_debug("msic_vhs_event %d\n", event);
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		pr_debug("VHS SND_SOC_DAPM_EVENT_ON doing rail startup now\n");
+		/*power up the rail*/
+		msic_write(w->codec, MSIC_VHSP, 0x3D);
+		msic_write(w->codec, MSIC_VHSN, 0x3F);
+		msleep(1);
+	} else if (SND_SOC_DAPM_EVENT_OFF(event)) {
+		pr_debug("VHS SND_SOC_DAPM_EVENT_OFF doing rail shutdown\n");
+		msic_write(w->codec, MSIC_VHSP, 0xC4);
+		msic_write(w->codec, MSIC_VHSN, 0x04);
+	}
+	return 0;
+}
+
+static int msic_vihf_event(struct snd_soc_dapm_widget *w,
+		    struct snd_kcontrol *kcontrol, int event)
+{
+	pr_debug("msic_vihf_event %d\n", event);
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		pr_debug("VIHF SND_SOC_DAPM_EVENT_ON doing rail startup now\n");
+		/*power up the rail*/
+		msic_write(w->codec, MSIC_VIHF, 0x27);
+		msleep(1);
+	} else if (SND_SOC_DAPM_EVENT_OFF(event)) {
+		pr_debug("VIHF SND_SOC_DAPM_EVENT_OFF doing rail shutdown\n");
+		msic_write(w->codec, MSIC_VIHF, 0x24);
+	}
+	return 0;
+}
+
+/*DAPM widgets*/
+static const struct snd_soc_dapm_widget intel_msic_dapm_widgets[] = {
+
+	/*all end points mic, hs etc*/
+	SND_SOC_DAPM_OUTPUT("HPOUTL"),
+	SND_SOC_DAPM_OUTPUT("HPOUTR"),
+	SND_SOC_DAPM_OUTPUT("EPOUT"),
+	SND_SOC_DAPM_OUTPUT("IHFOUTL"),
+	SND_SOC_DAPM_OUTPUT("IHFOUTR"),
+	SND_SOC_DAPM_OUTPUT("LINEOUTL"),
+	SND_SOC_DAPM_OUTPUT("LINEOUTR"),
+	SND_SOC_DAPM_OUTPUT("VIB1OUT"),
+	SND_SOC_DAPM_OUTPUT("VIB2OUT"),
+
+	SND_SOC_DAPM_SUPPLY("Headset Rail", SND_SOC_NOPM, 0, 0,
+		msic_vhs_event, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("Speaker Rail", SND_SOC_NOPM, 0, 0,
+		msic_vihf_event, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	/*playback path driver enables*/
+	SND_SOC_DAPM_PGA("Headset Left Playback",
+			MSIC_DRIVEREN, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Headset Right Playback",
+			MSIC_DRIVEREN, 1, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Speaker Left Playback",
+			MSIC_DRIVEREN, 2, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Speaker Right Playback",
+			MSIC_DRIVEREN, 3, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Vibra1 Playback",
+			MSIC_DRIVEREN, 4, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Vibra2 Playback",
+			MSIC_DRIVEREN, 5, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Earpiece Playback",
+			MSIC_DRIVEREN, 6, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Lineout Left Playback",
+			MSIC_LOCTL, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Lineout Right Playback",
+			MSIC_LOCTL, 4, 0, NULL, 0),
+
+	/*playback path filter enable*/
+	SND_SOC_DAPM_PGA("Headset Left Filter",
+			MSIC_HSEPRXCTRL, 4, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Headset Right Filter",
+			MSIC_HSEPRXCTRL, 5, 0,  NULL, 0),
+	SND_SOC_DAPM_PGA("Speaker Left Filter",
+			MSIC_IHFRXCTRL, 0, 0,  NULL, 0),
+	SND_SOC_DAPM_PGA("Speaker Right Filter",
+			MSIC_IHFRXCTRL, 1, 0,  NULL, 0),
+
+	/* DACs */
+	SND_SOC_DAPM_DAC("HSDAC Left", "Headset",
+			MSIC_DACCONFIG, 0, 0),
+	SND_SOC_DAPM_DAC("HSDAC Right", "Headset",
+			MSIC_DACCONFIG, 1, 0),
+	SND_SOC_DAPM_DAC("IHFDAC Left", "Speaker",
+			MSIC_DACCONFIG, 2, 0),
+	SND_SOC_DAPM_DAC("IHFDAC Right", "Speaker",
+			MSIC_DACCONFIG, 3, 0),
+	SND_SOC_DAPM_DAC("Vibra1 DAC", "Vibra1",
+			MSIC_VIB1C5, 1, 0),
+	SND_SOC_DAPM_DAC("Vibra2 DAC", "Vibra2",
+			MSIC_VIB2C5, 1, 0),
+};
+
+static const struct snd_soc_dapm_route msic_audio_map[] = {
+	/*headset and earpiece map*/
+	{ "HPOUTL", NULL, "Headset Left Playback" },
+	{ "HPOUTR", NULL, "Headset Right Playback" },
+	{ "EPOUT", NULL, "Earpiece Playback" },
+	{ "Headset Left Playback", NULL, "Headset Left Filter"},
+	{ "Headset Right Playback", NULL, "Headset Right Filter"},
+	{ "Earpiece Playback", NULL, "Headset Left Filter"},
+	{ "Headset Left Filter", NULL, "HSDAC Left"},
+	{ "Headset Right Filter", NULL, "HSDAC Right"},
+	{ "HSDAC Left", NULL, "Headset Rail"},
+	{ "HSDAC Right", NULL, "Headset Rail"},
+
+	/*speaker map*/
+	{ "IHFOUTL", "NULL", "Speaker Left Playback"},
+	{ "IHFOUTR", "NULL", "Speaker Right Playback"},
+	{ "Speaker Left Playback", NULL, "Speaker Left Filter"},
+	{ "Speaker Right Playback", NULL, "Speaker Right Filter"},
+	{ "Speaker Left Filter", NULL, "IHFDAC Left"},
+	{ "Speaker Right Filter", NULL, "IHFDAC Right"},
+	{ "IHFDAC Left", NULL, "Speaker Rail"},
+	{ "IHFDAC Right", NULL, "Speaker Rail"},
+
+	/*vibra map*/
+	{"VIB1OUT", NULL, "Vibra1 Playback"},
+	{"Vibra1 Playback", NULL, "Vibra1 DAC"},
+
+	{"VIB2OUT", NULL, "Vibra2 Playback"},
+	{"Vibra2 Playback", NULL, "Vibra2 DAC"},
+
+	/*lineout*/
+	{"LINEOUTL", NULL, "Lineout Left Playback"},
+	{"LINEOUTR", NULL, "Lineout Right Playback"},
+	{"Lineout Left Playback", NULL, "Headset Left Filter"},
+	{"Lineout Left Playback", NULL, "Speaker Left Filter"},
+	{"Lineout Left Playback", NULL, "Vibra1 DAC"},
+	{"Lineout Right Playback", NULL, "Headset Right Filter"},
+	{"Lineout Right Playback", NULL, "Speaker Right Filter"},
+	{"Lineout Right Playback", NULL, "Vibra2 DAC"},
+};
+
+/*speaker and headset mutes, for audio pops and clicks*/
+static int msic_pcm_hs_mute(struct snd_soc_dai *dai, int mute)
+{
+	snd_soc_update_bits(dai->codec, MSIC_HSLVOLCTRL, BIT(7), (!mute << 7));
+	snd_soc_update_bits(dai->codec, MSIC_HSRVOLCTRL, BIT(7), (!mute << 7));
+	return 0;
+}
+
+static int msic_pcm_spkr_mute(struct snd_soc_dai *dai, int mute)
+{
+	snd_soc_update_bits(dai->codec, MSIC_IHFLVOLCTRL, BIT(7), (!mute << 7));
+	snd_soc_update_bits(dai->codec, MSIC_IHFRVOLCTRL, BIT(7), (!mute << 7));
+	return 0;
+}
+
+int msic_pcm_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	unsigned int format, rate;
+
+	pr_debug("pcm hw params\n");
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		format = 3;
+		break;
+
+	case SNDRV_PCM_FORMAT_S24_LE:
+		format = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+	snd_soc_update_bits(dai->codec, MSIC_PCM2C2, BIT(4)|BIT(5), format);
+
+	switch (params_rate(params)) {
+	case 48000:
+		pr_debug("RATE_48000\n");
+		rate = 0;
+		break;
+
+	case 44100:
+		pr_debug("RATE_44100\n");
+		rate = 1;
+		break;
+
+	default:
+		pr_err("ERR rate %d\n", params_rate(params));
+		return -EINVAL;
+	}
+	snd_soc_update_bits(dai->codec, MSIC_PCM1C1, BIT(7), rate);
+
+	return 0;
+}
+
+/** Codec DAI section **/
+static struct snd_soc_dai_ops intel_msic_headset_dai_ops = {
+	.digital_mute	= msic_pcm_hs_mute,
+	.hw_params	= msic_pcm_hw_params,
+};
+
+static struct snd_soc_dai_ops intel_msic_speaker_dai_ops = {
+	.digital_mute	= msic_pcm_spkr_mute,
+	.hw_params	= msic_pcm_hw_params,
+};
+
+static struct snd_soc_dai_ops intel_msic_vib1_dai_ops = {
+	.hw_params	= msic_pcm_hw_params,
+};
+
+static struct snd_soc_dai_ops intel_msic_vib2_dai_ops = {
+	.hw_params	= msic_pcm_hw_params,
+};
+
+struct snd_soc_dai_driver intel_msic_dais[] = {
+{
+	.name = "Intel MSIC Headset",
+	.playback = {
+		.stream_name = "Headset",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = MSIC_RATES,
+		.formats = MSIC_FORMATS,
+	},
+	.ops = &intel_msic_headset_dai_ops,
+},
+{	.name = "Intel MSIC Speaker",
+	.playback = {
+		.stream_name = "Speaker",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = MSIC_RATES,
+		.formats = MSIC_FORMATS,
+	},
+	.ops = &intel_msic_speaker_dai_ops,
+},
+{	.name = "Intel MSIC Vibra",
+	.playback = {
+		.stream_name = "Vibra1",
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = MSIC_RATES,
+		.formats = MSIC_FORMATS,
+	},
+	.ops = &intel_msic_vib1_dai_ops,
+},
+{	.name = "Intel MSIC Haptic",
+	.playback = {
+		.stream_name = "Vibra2",
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = MSIC_RATES,
+		.formats = MSIC_FORMATS,
+	},
+	.ops = &intel_msic_vib2_dai_ops,
+},
+};
+
+/** codec registration **/
+static int msic_codec_probe(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	pr_debug("codec_probe called\n");
+
+	codec->name = "msic";
+	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
+	codec->dapm.idle_bias_off = 1;
+
+	/*PCM interface */
+	msic_write(codec, MSIC_PCM2RXSLOT01, 0x10);
+	msic_write(codec, MSIC_PCM2RXSLOT23, 0x32);
+	msic_write(codec, MSIC_PCM2RXSLOT45, 0x54);
+	/* pcm port setting */
+	msic_write(codec, MSIC_PCM1C1, 0x00);
+	msic_write(codec, MSIC_PCM2C1, 0x01);
+	msic_write(codec, MSIC_PCM2C2, 0x0A);
+	msic_write(codec, MSIC_HSMIXER, BIT(0)|BIT(4));
+	/*vendor vibra workround, the vibras are muted by
+	*custom register so unmute them*/
+	msic_write(codec, MSIC_SSR5, 0x80);
+	msic_write(codec, MSIC_SSR6, 0x80);
+	msic_write(codec, MSIC_VIB1C5, 0x00);
+	msic_write(codec, MSIC_VIB2C5, 0x00);
+	/*configure vibras for pcm port*/
+	msic_write(codec, MSIC_VIB1C3, 0x00);
+	msic_write(codec, MSIC_VIB2C3, 0x00);
+
+	/*soft mute ramp time*/
+	msic_write(codec, MSIC_SOFTMUTE, 0x3);
+	/*
+	* fix the initial volume at 1dB,
+	* default in +9dB,
+	* 1dB give optimal swing on DAC, amps
+	**/
+	msic_write(codec, MSIC_HSLVOLCTRL, 0x08);
+	msic_write(codec, MSIC_HSRVOLCTRL, 0x08);
+	msic_write(codec, MSIC_IHFLVOLCTRL, 0x08);
+	msic_write(codec, MSIC_IHFRVOLCTRL, 0x08);
+	/*dac mode and lineout workaround*/
+	msic_write(codec, MSIC_SSR2, 0x10);
+	msic_write(codec, MSIC_SSR3, 0x40);
+
+	ret = snd_soc_dapm_new_controls(&codec->dapm, intel_msic_dapm_widgets,
+				ARRAY_SIZE(intel_msic_dapm_widgets));
+	if (ret)
+		pr_err("soc_dapm_new_control failed %d", ret);
+	ret = snd_soc_dapm_add_routes(&codec->dapm, msic_audio_map,
+				ARRAY_SIZE(msic_audio_map));
+	if (ret)
+		pr_err("soc_dapm_add_routes failed %d", ret);
+
+	return ret;
+}
+
+static int msic_codec_remove(struct snd_soc_codec *codec)
+{
+	pr_debug("codec_remove called\n");
+	msic_set_vaud_bias(codec, SND_SOC_BIAS_OFF);
+
+	return 0;
+}
+
+struct snd_soc_codec_driver intel_msic_codec = {
+	.probe =	msic_codec_probe,
+	.remove =	msic_codec_remove,
+	.read		= msic_read,
+	.write		= msic_write,
+	.set_bias_level	= msic_set_vaud_bias,
+};
+
+static int intelmid_codec_probe(struct platform_device *pdev)
+{
+	pr_debug("codec device probe called for %s\n", dev_name(&pdev->dev));
+	return snd_soc_register_codec(&pdev->dev, &intel_msic_codec,
+			intel_msic_dais, ARRAY_SIZE(intel_msic_dais));
+}
+
+static int intelmid_codec_remove(struct platform_device *pdev)
+{
+	pr_debug("codec device remove called\n");
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver intelmid_codec_driver = {
+	.driver		= {
+		.name		= "mid-msic-codec",
+		.owner		= THIS_MODULE,
+	},
+	.probe		= intelmid_codec_probe,
+	.remove		= intelmid_codec_remove,
+};
+
+static int __init intel_mid_msic_init(void)
+{
+	pr_debug("driver init called\n");
+	return platform_driver_register(&intelmid_codec_driver);
+}
+module_init(intel_mid_msic_init);
+
+static void __exit intel_mid_msic_exit(void)
+{
+	pr_debug("driver exit called\n");
+	platform_driver_unregister(&intelmid_codec_driver);
+}
+module_exit(intel_mid_msic_exit);
+
+MODULE_DESCRIPTION("ASoC Intel(R) MSIC codec driver");
+MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
+MODULE_AUTHOR("Harsha Priya <priya.harsha@intel.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("msic-codec");
diff --git a/sound/soc/codecs/msic.h b/sound/soc/codecs/msic.h
new file mode 100644
index 0000000..6cec236
--- /dev/null
+++ b/sound/soc/codecs/msic.h
@@ -0,0 +1,99 @@
+/*
+ *  msic.h - Intel MSIC Codec driver
+ *
+ *  Copyright (C) 2010 Intel Corp
+ *  Author: Vinod Koul <vinod.koul@intel.com>
+ *  Author: Harsha Priya <priya.harsha@intel.com>
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
+ *
+ */
+#ifndef _INTEL_MSIC_CODEC_H
+#define _INTEL_MSIC_CODEC_H
+
+/*register map*/
+#define MSIC_VAUD		0xDB
+#define MSIC_VHSP		0xDC
+#define MSIC_VHSN		0xDD
+#define MSIC_VIHF		0xC9
+
+#define MSIC_AUDPLLCTRL		0x240
+#define MSIC_MSIC_DMICBUF0123	0x241
+#define MSIC_MSIC_DMICBUF45	0x242
+#define MSIC_MSIC_DMICGPO	0x244
+#define MSIC_DMICMUX		0x245
+#define MSIC_DMICLK		0x246
+#define MSIC_MICBIAS		0x247
+#define MSIC_ADCCONFIG		0x248
+#define MSIC_MICAMP1		0x249
+#define MSIC_MICAMP2		0x24A
+#define MSIC_NOISEMUX		0x24B
+#define MSIC_AUDIOMUX12		0x24C
+#define MSIC_AUDIOMUX34		0x24D
+#define MSIC_AUDIOSINC		0x24E
+#define MSIC_AUDIOTXEN		0x24F
+#define MSIC_HSEPRXCTRL		0x250
+#define MSIC_IHFRXCTRL		0x251
+#define MSIC_HSMIXER		0x256
+#define MSIC_DACCONFIG		0x257
+#define MSIC_SOFTMUTE		0x258
+#define MSIC_HSLVOLCTRL		0x259
+#define MSIC_HSRVOLCTRL		0x25A
+#define MSIC_IHFLVOLCTRL	0x25B
+#define MSIC_IHFRVOLCTRL	0x25C
+#define MSIC_DRIVEREN		0x25D
+#define MSIC_LOCTL		0x25E
+#define MSIC_VIB1C1		0x25F
+#define MSIC_VIB1C2		0x260
+#define MSIC_VIB1C3		0x261
+#define MSIC_VIB1SPIPCM1	0x262
+#define MSIC_VIB1SPIPCM2	0x263
+#define MSIC_VIB1C5		0x264
+#define MSIC_VIB2C1		0x265
+#define MSIC_VIB2C2		0x266
+#define MSIC_VIB2C3		0x267
+#define MSIC_VIB2SPIPCM1	0x268
+#define MSIC_VIB2SPIPCM2	0x269
+#define MSIC_VIB2C5		0x26A
+#define MSIC_BTNCTRL1		0x26B
+#define MSIC_BTNCTRL2		0x26C
+#define MSIC_PCM1TXSLOT01	0x26D
+#define MSIC_PCM1TXSLOT23	0x26E
+#define MSIC_PCM1TXSLOT45	0x26F
+#define MSIC_PCM1RXSLOT0_3	0x270
+#define MSIC_PCM1RXSLOT45	0x271
+#define MSIC_PCM2TXSLOT01	0x272
+#define MSIC_PCM2TXSLOT23	0x273
+#define MSIC_PCM2TXSLOT45	0x274
+#define MSIC_PCM2RXSLOT01	0x275
+#define MSIC_PCM2RXSLOT23	0x276
+#define MSIC_PCM2RXSLOT45	0x277
+#define MSIC_PCM1C1		0x278
+#define MSIC_PCM1C2		0x279
+#define MSIC_PCM1C3		0x27A
+#define MSIC_PCM2C1		0x27B
+#define MSIC_PCM2C2		0x27C
+/*end codec register defn*/
+
+/*vendor defn these are not part of avp*/
+#define MSIC_SSR2		0x381
+#define MSIC_SSR3		0x382
+#define MSIC_SSR5		0x384
+#define MSIC_SSR6		0x385
+
+#endif
-- 
1.7.2.3
