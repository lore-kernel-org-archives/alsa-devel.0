From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [RFC 1/4] ASoC SST: Add msic codec driver
Date: Tue, 28 Dec 2010 17:39:36 +0530
Message-ID: <1293538176-31853-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 60EB210388A
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 13:08:12 +0100 (CET)
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

This patch adds the msic asoc codec driver. This driver currently supports only playback.
Capture and jack detection to be added later

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/codecs/msic.c |  721 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/msic.h |  102 +++++++
 2 files changed, 823 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/msic.c
 create mode 100644 sound/soc/codecs/msic.h

diff --git a/sound/soc/codecs/msic.c b/sound/soc/codecs/msic.c
new file mode 100644
index 0000000..f90f698
--- /dev/null
+++ b/sound/soc/codecs/msic.c
@@ -0,0 +1,721 @@
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
+#define pr_fmt(fmt) "sst: msic " fmt
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
+struct intel_msic_pvt {
+	struct snd_soc_codec *codec;
+	unsigned int hs_switch;
+	unsigned int lo_dac;
+};
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
+static inline int msic_modify(struct snd_soc_codec *codec,
+		unsigned int reg, unsigned int value, unsigned int mask)
+{
+	int ret;
+
+	pr_debug("Modify for %x with %x of mask %x\n", reg, value, mask);
+	ret = intel_scu_ipc_update_register(reg, value, mask);
+	if (ret)
+		pr_err("modify of %x failed, err %d\n", reg, ret);
+	return ret;
+}
+
+/*sound controls*/
+static const char *headset_switch_text[] = {"Earpiece", "HeadSet"};
+
+static const char *mic_switch_text[] = {"DMIC", "AMIC"};
+
+static const char *msic_lo_text[] = {"Vibra", "Headset", "IHF", "None"};
+
+static const unsigned int mic_switch_values[] = {0x76, 0x10};
+
+static const struct soc_enum msic_headset_enum =
+	SOC_ENUM_SINGLE_EXT(2, headset_switch_text);
+
+static const struct soc_enum msic_lo_enum =
+	SOC_ENUM_SINGLE_EXT(4, msic_lo_text);
+
+static int headset_get_switch(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	struct intel_msic_pvt *msic = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = msic->hs_switch;
+	return 0;
+}
+
+static int headset_set_switch(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	struct intel_msic_pvt *msic = snd_soc_codec_get_drvdata(codec);
+
+	if (ucontrol->value.integer.value[0] == msic->hs_switch)
+		return 0;
+
+	if (ucontrol->value.integer.value[0]) {
+		pr_debug("hs_set HS path\n");
+		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTL");
+		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTR");
+		snd_soc_dapm_disable_pin(&codec->dapm, "EPOUT");
+	} else {
+		pr_debug("hs_set EP path\n");
+		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTL");
+		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTR");
+		snd_soc_dapm_enable_pin(&codec->dapm, "EPOUT");
+	}
+	snd_soc_dapm_sync(&codec->dapm);
+	msic->hs_switch = ucontrol->value.integer.value[0];
+
+	return 0;
+}
+
+static void msic_lo_enable_out_pins(struct snd_soc_codec *codec)
+{
+	struct intel_msic_pvt *msic = snd_soc_codec_get_drvdata(codec);
+
+	snd_soc_dapm_enable_pin(&codec->dapm, "IHFOUTL");
+	snd_soc_dapm_enable_pin(&codec->dapm, "IHFOUTR");
+	snd_soc_dapm_enable_pin(&codec->dapm, "LINEOUTL");
+	snd_soc_dapm_enable_pin(&codec->dapm, "LINEOUTR");
+	snd_soc_dapm_enable_pin(&codec->dapm, "VIB1OUT");
+	snd_soc_dapm_enable_pin(&codec->dapm, "VIB2OUT");
+	if (msic->hs_switch) {
+		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTL");
+		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTR");
+		snd_soc_dapm_disable_pin(&codec->dapm, "EPOUT");
+	} else {
+		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTL");
+		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTR");
+		snd_soc_dapm_enable_pin(&codec->dapm, "EPOUT");
+	}
+	return;
+}
+
+static int lo_get_switch(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	struct intel_msic_pvt *msic = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = msic->lo_dac;
+	return 0;
+}
+
+static int lo_set_switch(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	struct intel_msic_pvt *msic = snd_soc_codec_get_drvdata(codec);
+
+	if (ucontrol->value.integer.value[0] == msic->lo_dac)
+		return 0;
+
+	/*
+	 * we dont want to work with last state of lineout so just enable all
+	 * pins and then disable pins not required
+	 */
+	msic_lo_enable_out_pins(codec);
+	switch (ucontrol->value.integer.value[0]) {
+	case 0:
+		pr_debug("set vibra path\n");
+		snd_soc_dapm_disable_pin(&codec->dapm, "VIB1OUT");
+		snd_soc_dapm_disable_pin(&codec->dapm, "VIB2OUT");
+		msic_modify(codec, MSIC_LOCTL, 0, 0x66);
+		break;
+
+	case 1:
+		pr_debug("set hs  path\n");
+		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTL");
+		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTR");
+		snd_soc_dapm_disable_pin(&codec->dapm, "EPOUT");
+		msic_modify(codec, MSIC_LOCTL, 0x22, 0x66);
+		break;
+
+	case 2:
+		pr_debug("set spkr path\n");
+		snd_soc_dapm_disable_pin(&codec->dapm, "IHFOUTL");
+		snd_soc_dapm_disable_pin(&codec->dapm, "IHFOUTR");
+		msic_modify(codec, MSIC_LOCTL, 0x44, 0x66);
+		break;
+
+	case 3:
+		pr_debug("set null path\n");
+		snd_soc_dapm_disable_pin(&codec->dapm, "LINEOUTL");
+		snd_soc_dapm_disable_pin(&codec->dapm, "LINEOUTR");
+		msic_modify(codec, MSIC_LOCTL, 0x66, 0x66);
+		break;
+	}
+	snd_soc_dapm_sync(&codec->dapm);
+	msic->lo_dac = ucontrol->value.integer.value[0];
+	return 0;
+}
+
+static const struct soc_enum msic_mic_enum =
+	SOC_VALUE_ENUM_SINGLE(MSIC_AUDIOMUX12, 0, 0x76,
+		ARRAY_SIZE(mic_switch_text),
+		mic_switch_text,
+		mic_switch_values);
+
+
+static const struct snd_kcontrol_new intel_msic_snd_controls[] = {
+	SOC_ENUM_EXT("Playback Switch", msic_headset_enum,
+			headset_get_switch, headset_set_switch),
+	SOC_VALUE_ENUM("Capture Switch", msic_mic_enum),
+	SOC_ENUM_EXT("Lineout Mux", msic_lo_enum,
+			lo_get_switch, lo_set_switch),
+};
+
+static const struct snd_kcontrol_new msic_driver_controls[] = {
+	SOC_DAPM_SINGLE("Headset_L", MSIC_DRIVEREN, 0, 1, 0),
+	SOC_DAPM_SINGLE("Headset_R", MSIC_DRIVEREN, 1, 1, 0),
+	SOC_DAPM_SINGLE("Speaker_L", MSIC_DRIVEREN, 2, 1, 0),
+	SOC_DAPM_SINGLE("Speaker_R", MSIC_DRIVEREN, 3, 1, 0),
+	SOC_DAPM_SINGLE("Vibra1", MSIC_DRIVEREN, 4, 1, 0),
+	SOC_DAPM_SINGLE("Vibra2", MSIC_DRIVEREN, 5, 1, 0),
+	SOC_DAPM_SINGLE("Earpiece", MSIC_DRIVEREN, 6, 1, 0),
+	SOC_DAPM_SINGLE("Lineout_L", MSIC_LOCTL, 0, 1, 0),
+	SOC_DAPM_SINGLE("Lineout_R", MSIC_LOCTL, 4, 1, 0),
+};
+
+static int msic_set_vaud_bias(struct snd_soc_codec *codec,
+		enum snd_soc_bias_level level)
+{
+	pr_debug("msic_set_vaud_bias %d\n", level);
+	switch (level) {
+	case SND_SOC_BIAS_PREPARE:
+	case SND_SOC_BIAS_STANDBY:
+		break;
+
+	case SND_SOC_BIAS_ON:
+		pr_debug("vaud_bias doing rail statup now\n");
+		/*power up the rail*/
+		msic_write(codec, MSIC_VAUD, BIT(2)|BIT(1)|BIT(0));
+		msleep(1);
+		/*power up the pll*/
+		msic_write(codec, MSIC_AUDPLLCTRL, BIT(5));
+		/*adding pcm 2 here for a while*/
+		msic_modify(codec, MSIC_PCM2C2, BIT(0), BIT(0));
+		break;
+
+	case SND_SOC_BIAS_OFF:
+		pr_debug("vaud_bias doing rail shutdown\n");
+		msic_modify(codec, MSIC_PCM2C2, 0, BIT(0));
+		msic_write(codec, MSIC_AUDPLLCTRL, 0);
+		msleep(1);
+		msic_write(codec, MSIC_VAUD, BIT(3));
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
+	if (event == SND_SOC_DAPM_PRE_PMU) {
+		pr_debug("VHS SND_SOC_DAPM_PRE_PMU doing rail statup now\n");
+		/*power up the rail*/
+		msic_write(w->codec, MSIC_VHSP, 0x3D);
+		msic_write(w->codec, MSIC_VHSN, 0x3F);
+		msleep(1);
+		/*power up the pll*/
+	} else if (event == SND_SOC_DAPM_POST_PMD) {
+		pr_debug("VHS SND_SOC_DAPM_POST_PMD doing rail shutdown\n");
+		msic_write(w->codec, MSIC_VHSP, 0xC4);
+		msic_write(w->codec, MSIC_VHSN, 0x04);
+	}
+
+	return 0;
+}
+
+static int msic_vihf_event(struct snd_soc_dapm_widget *w,
+		    struct snd_kcontrol *kcontrol, int event)
+{
+	pr_debug("msic_vihf_event %d\n", event);
+	if (event == SND_SOC_DAPM_PRE_PMU) {
+		pr_debug("VIHF SND_SOC_DAPM_PRE_PMU doing rail statup now\n");
+		/*power up the rail*/
+		msic_write(w->codec, MSIC_VIHF, 0x27);
+		msleep(1);
+		/*power up the pll*/
+	} else if (event == SND_SOC_DAPM_POST_PMD) {
+		pr_debug("VIHF SND_SOC_DAPM_POST_PMD doing rail shutdown\n");
+		msic_write(w->codec, MSIC_VIHF, 0x24);
+	}
+
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
+	SND_SOC_DAPM_INPUT("DMIC"),
+	SND_SOC_DAPM_INPUT("AMIC2"),
+	SND_SOC_DAPM_INPUT("HSMIC"), /*AMIC1 is this case*/
+
+	SND_SOC_DAPM_SUPPLY("Headset Rail", SND_SOC_NOPM, 0, 0,
+		msic_vhs_event, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("Speaker Rail", SND_SOC_NOPM, 0, 0,
+		msic_vihf_event, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	/*playback paths speaker, dac, filter, rx selector*/
+	SND_SOC_DAPM_SWITCH("Headset Left Playback",
+		MSIC_DRIVEREN, 0, 0, &msic_driver_controls[0]),
+	SND_SOC_DAPM_SWITCH("Headset Right Playback",
+		MSIC_DRIVEREN, 1, 0, &msic_driver_controls[1]),
+	SND_SOC_DAPM_SWITCH("Speaker Left Playback",
+		MSIC_DRIVEREN, 2, 0, &msic_driver_controls[2]),
+	SND_SOC_DAPM_SWITCH("Speaker Right Playback",
+		MSIC_DRIVEREN, 3, 0, &msic_driver_controls[3]),
+	SND_SOC_DAPM_SWITCH("Vibra1 Playback",
+		MSIC_DRIVEREN, 4, 0, &msic_driver_controls[4]),
+	SND_SOC_DAPM_SWITCH("Vibra2 Playback",
+		MSIC_DRIVEREN, 5, 0, &msic_driver_controls[5]),
+	SND_SOC_DAPM_SWITCH("Earpiece Playback",
+		MSIC_DRIVEREN, 6, 0, &msic_driver_controls[6]),
+	SND_SOC_DAPM_SWITCH("Lineout Left Playback",
+		MSIC_LOCTL, 0, 0, &msic_driver_controls[7]),
+	SND_SOC_DAPM_SWITCH("Lineout Right Playback",
+		MSIC_LOCTL, 4, 0, &msic_driver_controls[8]),
+
+	/* DACs */
+	SND_SOC_DAPM_DAC("HSDAC Left", "HeadSet",
+		MSIC_DACCONFIG, 0, 0),
+	SND_SOC_DAPM_DAC("HSDAC Right", "HeadSet",
+		MSIC_DACCONFIG, 1, 0),
+	SND_SOC_DAPM_DAC("IHFDAC Left", "Speaker",
+		MSIC_DACCONFIG, 2, 0),
+	SND_SOC_DAPM_DAC("IHFDAC Right", "Speaker",
+		MSIC_DACCONFIG, 3, 0),
+	SND_SOC_DAPM_DAC("Vibra1 DAC", "Vibra1",
+		MSIC_VIB1C5, 1, 0),
+	SND_SOC_DAPM_DAC("Vibra2 DAC", "Vibra2",
+		MSIC_VIB2C5, 1, 0),
+
+	/*SND_SOC_DAPM_MICBIAS("Mic Bias", MICBIAS, 0, 0),*/
+};
+
+static const struct snd_soc_dapm_route msic_audio_map[] = {
+	/*headset and earpiece map*/
+	{ "HPOUTL", NULL, "Headset Left Playback" },
+	{ "HPOUTR", NULL, "Headset Right Playback" },
+	{ "EPOUT", NULL, "Earpiece Playback" },
+	{ "Headset Left Playback", NULL, "HSDAC Left"},
+	{ "Headset Right Playback", NULL, "HSDAC Right"},
+	{ "Earpiece Playback", NULL, "HSDAC Left"},
+	{ "HSDAC Left", NULL, "Headset Rail"},
+	{ "HSDAC Right", NULL, "Headset Rail"},
+
+	/*speaker map*/
+	{ "IHFOUTL", "NULL", "Speaker Left Playback"},
+	{ "IHFOUTR", "NULL", "Speaker Right Playback"},
+	{ "Speaker Left Playback", NULL, "IHFDAC Left"},
+	{ "Speaker Right Playback", NULL, "IHFDAC Right"},
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
+	{"Lineout Left Playback", NULL, "IHFDAC Left"},
+	{"Lineout Left Playback", NULL, "HSDAC Left"},
+	{"Lineout Left Playback", NULL, "Vibra1 DAC"},
+	{"Lineout Right Playback", NULL, "IHFDAC Right"},
+	{"Lineout Right Playback", NULL, "HSDAC Right"},
+	{"Lineout Right Playback", NULL, "Vibra2 DAC"},
+};
+
+static int msic_pcm_hs_startup(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	pr_debug("pcm hs startup for %d\n", substream->pcm->device);
+
+	/*configure digital reciever here, add to DAPM later on*/
+	msic_write(dai->codec, MSIC_HSMIXER, BIT(0)|BIT(4));
+	msic_write(dai->codec, MSIC_HSEPRXCTRL, BIT(5)|BIT(4));
+
+	return 0;
+}
+
+static void msic_pcm_hs_shutdown(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	pr_debug("pcm hs shutdown\n");
+	msic_write(dai->codec, MSIC_HSEPRXCTRL, 0);
+	return ;
+}
+
+static int msic_pcm_hs_mute(struct snd_soc_dai *dai, int mute)
+{
+	msic_modify(dai->codec, MSIC_HSLVOLCTRL, (!mute << 7), BIT(7));
+	msic_modify(dai->codec, MSIC_HSRVOLCTRL, (!mute << 7), BIT(7));
+	return 0;
+}
+
+static int msic_pcm_spkr_startup(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	pr_debug("pcm spkr startup for %d\n", substream->pcm->device);
+	msic_modify(dai->codec, MSIC_IHFRXCTRL, BIT(0)|BIT(1),  BIT(0)|BIT(1));
+	return 0;
+
+}
+
+static void msic_pcm_spkr_shutdown(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	pr_debug("pcm spkr shutdown\n");
+	msic_modify(dai->codec, MSIC_IHFRXCTRL, 0,  BIT(0)|BIT(1));
+	return;
+}
+
+static int msic_pcm_spkr_mute(struct snd_soc_dai *dai, int mute)
+{
+	msic_modify(dai->codec, MSIC_IHFLVOLCTRL, (!mute << 7), BIT(7));
+	msic_modify(dai->codec, MSIC_IHFRVOLCTRL, (!mute << 7), BIT(7));
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
+	msic_modify(dai->codec, MSIC_PCM2C2, format, BIT(4)|BIT(5));
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
+	msic_modify(dai->codec, MSIC_PCM1C1, rate, BIT(7));
+
+	return 0;
+}
+
+/** Codec DAI section **/
+static struct snd_soc_dai_ops intel_msic_headset_dai_ops = {
+	.startup	= msic_pcm_hs_startup,
+	.shutdown	= msic_pcm_hs_shutdown,
+	.digital_mute	= msic_pcm_hs_mute,
+	.hw_params	= msic_pcm_hw_params,
+};
+
+static struct snd_soc_dai_ops intel_msic_speaker_dai_ops = {
+	.startup	= msic_pcm_spkr_startup,
+	.shutdown	= msic_pcm_spkr_shutdown,
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
+		.stream_name = "HeadSet",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = MSIC_RATES,
+		.formats = MSIC_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 5,
+		.rates = MSIC_RATES,
+		.formats = MSIC_FORMATS,
+	},
+	.ops = &intel_msic_headset_dai_ops,
+	.symmetric_rates = 1,
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
+{	.name = "Intel MSIC Vibra1",
+	.playback = {
+		.stream_name = "Vibra1",
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = MSIC_RATES,
+		.formats = MSIC_FORMATS,
+	},
+	.ops = &intel_msic_vib1_dai_ops,
+},
+{	.name = "Intel MSIC Vibra2",
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
+EXPORT_SYMBOL_GPL(intel_msic_dais);
+
+/** codec registration **/
+static int msic_codec_probe(struct snd_soc_codec *codec)
+{
+	struct intel_msic_pvt *msic;
+	int ret;
+
+	pr_debug("codec_probe called\n");
+
+	msic = kzalloc(sizeof(*msic), GFP_KERNEL);
+	if (msic == NULL)
+		return -ENOMEM;
+
+	msic->lo_dac = 3;
+	snd_soc_codec_set_drvdata(codec, msic);
+	msic->codec = codec;
+
+	codec->name = "msic";
+	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
+	codec->dapm.idle_bias_off = 1;
+
+	/*FIXME PCM2 interface this is only fixed interface*/
+	msic_write(codec, MSIC_PCM2RXSLOT01, 0x10);
+	msic_write(codec, MSIC_PCM2RXSLOT23, 0x32);
+	msic_write(codec, MSIC_PCM2RXSLOT45, 0x54);
+
+	/* pcm port setting */
+	msic_write(codec, MSIC_PCM1C1, 0x00);
+	msic_write(codec, MSIC_PCM2C1, 0x01);
+	msic_write(codec, MSIC_PCM2C2, 0x0A);
+
+	/*vendor vibra w/a*/
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
+	/*fix the initial volume at 0dB*/
+	msic_write(codec, MSIC_HSLVOLCTRL, 0x08);
+	msic_write(codec, MSIC_HSRVOLCTRL, 0x08);
+	msic_write(codec, MSIC_IHFLVOLCTRL, 0x08);
+	msic_write(codec, MSIC_IHFRVOLCTRL, 0x08);
+	/*dac mode and lo w/a*/
+	msic_write(codec, MSIC_SSR2, 0x10);
+	msic_write(codec, MSIC_SSR3, 0x40);
+
+	ret = snd_soc_add_controls(codec, intel_msic_snd_controls,
+				ARRAY_SIZE(intel_msic_snd_controls));
+	if (ret)
+		pr_err("soc_add_controls failed %d", ret);
+	ret = snd_soc_dapm_new_controls(&codec->dapm, intel_msic_dapm_widgets,
+				ARRAY_SIZE(intel_msic_dapm_widgets));
+	if (ret)
+		pr_err("soc_dapm_new_control failed %d", ret);
+	ret = snd_soc_dapm_add_routes(&codec->dapm, msic_audio_map,
+				ARRAY_SIZE(msic_audio_map));
+	if (ret)
+		pr_err("soc_dapm_add_routes failed %d", ret);
+
+	/*default is earpiece pin, userspace sets it explcitly*/
+	snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTL");
+	snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTR");
+	/*default is lineout NC, userspace sets it explcitly*/
+	snd_soc_dapm_disable_pin(&codec->dapm, "LINEOUTL");
+	snd_soc_dapm_disable_pin(&codec->dapm, "LINEOUTR");
+	return 0;
+}
+
+static int msic_codec_remove(struct snd_soc_codec *codec)
+{
+	struct intel_msic_pvt *msic = snd_soc_codec_get_drvdata(codec);
+	pr_debug("codec_remove called\n");
+	snd_soc_codec_set_drvdata(codec, NULL);
+	msic_set_vaud_bias(codec, SND_SOC_BIAS_OFF);
+	kfree(msic);
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
+/*	.suspend =	msic_codec_suspend,
+	.resume =	msic_codec_resume,
+*/
+};
+EXPORT_SYMBOL_GPL(intel_msic_codec);
+
+static int intelmid_codec_probe(struct platform_device *pdev)
+{
+	pr_debug("codec device probe called\n");
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
+	/*.suspend	= intelmid_codec_suspend,
+	.resume		= intelmid_codec_resume,*/
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
diff --git a/sound/soc/codecs/msic.h b/sound/soc/codecs/msic.h
new file mode 100644
index 0000000..c17b318
--- /dev/null
+++ b/sound/soc/codecs/msic.h
@@ -0,0 +1,102 @@
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
+extern struct snd_soc_dai_driver intel_msic_dais[4];
+extern struct snd_soc_codec_driver intel_msic_codec;
+
+#endif
-- 
1.7.2.3
