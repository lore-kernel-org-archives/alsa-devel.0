From: RongJun Ying <rjying@gmail.com>
Subject: [PATCH v4-resend 1/7] ASoC: sirf: Add SiRF internal
	audio codec driver
Date: Wed, 26 Feb 2014 15:22:16 +0800
Message-ID: <1393399342-31177-2-git-send-email-rongjun.ying@csr.com>
References: <1393399342-31177-1-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f49.google.com (mail-pb0-f49.google.com
 [209.85.160.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 0752D265357
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 08:25:18 +0100 (CET)
Received: by mail-pb0-f49.google.com with SMTP id jt11so597561pbb.36
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 23:25:18 -0800 (PST)
In-Reply-To: <1393399342-31177-1-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, rjying@gmail.com
Cc: Takashi Iwai <tiwai@suse.de>, Rongjun Ying <rongjun.ying@csr.com>, alsa-devel@alsa-project.org, workgroup.linux@csr.com
List-Id: alsa-devel@alsa-project.org

From: Rongjun Ying <rongjun.ying@csr.com>

The SiRF internal audio codec is integrated in SiRF atlas6 and prima2 SoC.
Features include:
1. Stereo DAC and ADC with 16-bit resolution amd 48KHz sample rate
2. Support headphone and/or speaker output
3. Integrate headphone and speaker output amp
4. Support LINE and MIC input
5. Support single ended and differential input mode.

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
---
-v4:
1. Add SiRF internal audio codec driver which split from sirf-soc-inner driver.
2. Add codec binding document.
3. Use MMIO regmap.
4. Add TLV information.

 .../devicetree/bindings/sound/sirf-audio-codec.txt |   17 +
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/sirf-audio-codec.c                |  585 ++++++++++++++++++++
 sound/soc/codecs/sirf-audio-codec.h                |   75 +++
 5 files changed, 683 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-audio-codec.txt
 create mode 100644 sound/soc/codecs/sirf-audio-codec.c
 create mode 100644 sound/soc/codecs/sirf-audio-codec.h

diff --git a/Documentation/devicetree/bindings/sound/sirf-audio-codec.txt b/Documentation/devicetree/bindings/sound/sirf-audio-codec.txt
new file mode 100644
index 0000000..062f5ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sirf-audio-codec.txt
@@ -0,0 +1,17 @@
+SiRF internal audio CODEC
+
+Required properties:
+
+  - compatible : "sirf,atlas6-audio-codec" or "sirf,prima2-audio-codec"
+
+  - reg : the register address of the device.
+
+  - clocks: the clock of SiRF internal audio codec
+
+Example:
+
+audiocodec: audiocodec@b0040000 {
+	compatible = "sirf,atlas6-audio-codec";
+	reg = <0xb0040000 0x10000>;
+	clocks = <&clks 27>;
+};
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f2383eb..b6b0953 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -141,6 +141,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM9705 if SND_SOC_AC97_BUS
 	select SND_SOC_WM9712 if SND_SOC_AC97_BUS
 	select SND_SOC_WM9713 if SND_SOC_AC97_BUS
+	select SND_SOC_SIRF_AUDIO_CODEC if SND_SOC_SIRF
         help
           Normally ASoC codec drivers are only built if a machine driver which
           uses them is also built since they are only usable with a machine
@@ -634,4 +635,7 @@ config SND_SOC_TPA6130A2
 	tristate "Texas Instruments TPA6130A2 headphone amplifier"
 	depends on I2C
 
+config SND_SOC_SIRF_AUDIO_CODEC
+	tristate "SiRF SoC internal audio codec"
+	select REGMAP_MMIO
 endmenu
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 6af7a55..6bea5ba 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -134,6 +134,7 @@ snd-soc-wm9705-objs := wm9705.o
 snd-soc-wm9712-objs := wm9712.o
 snd-soc-wm9713-objs := wm9713.o
 snd-soc-wm-hubs-objs := wm_hubs.o
+snd-soc-sirf-audio-codec-objs := sirf-audio-codec.o
 
 # Amp
 snd-soc-max9877-objs := max9877.o
@@ -274,6 +275,7 @@ obj-$(CONFIG_SND_SOC_WM9712)	+= snd-soc-wm9712.o
 obj-$(CONFIG_SND_SOC_WM9713)	+= snd-soc-wm9713.o
 obj-$(CONFIG_SND_SOC_WM_ADSP)	+= snd-soc-wm-adsp.o
 obj-$(CONFIG_SND_SOC_WM_HUBS)	+= snd-soc-wm-hubs.o
+obj-$(CONFIG_SND_SOC_SIRF_AUDIO_CODEC) += snd-soc-sirf-audio-codec.o
 
 # Amp
 obj-$(CONFIG_SND_SOC_MAX9877)	+= snd-soc-max9877.o
diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
new file mode 100644
index 0000000..6acf84a
--- /dev/null
+++ b/sound/soc/codecs/sirf-audio-codec.c
@@ -0,0 +1,585 @@
+/*
+ * SiRF audio codec driver
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/rtc/sirfsoc_rtciobrg.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/regmap.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+#include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
+
+#include "sirf-audio-codec.h"
+
+struct sirf_audio_codec_reg_bits {
+	u32 dig_mic_en_bits;
+	u32 dig_mic_freq_bits;
+	u32 adc14b_12_bits;
+	u32 firdac_hsl_en_bits;
+	u32 firdac_hsr_en_bits;
+	u32 firdac_lout_en_bits;
+	u32 por_bits;
+	u32 codec_clk_en_bits;
+};
+
+struct sirf_audio_codec {
+	struct clk *clk;
+	struct regmap *regmap;
+	u32 sys_pwrc_reg_base;
+	struct sirf_audio_codec_reg_bits  *reg_bits;
+	u32 reg_ctrl0, reg_ctrl1;
+};
+
+static struct sirf_audio_codec_reg_bits sirf_audio_codec_reg_bits_prima2 = {
+	.dig_mic_en_bits = 20,
+	.dig_mic_freq_bits = 21,
+	.adc14b_12_bits = 22,
+	.firdac_hsl_en_bits = 23,
+	.firdac_hsr_en_bits = 24,
+	.firdac_lout_en_bits = 25,
+	.por_bits = 26,
+	.codec_clk_en_bits = 27,
+};
+
+static struct sirf_audio_codec_reg_bits sirf_audio_codec_reg_bits_atlas6 = {
+	.dig_mic_en_bits = 22,
+	.dig_mic_freq_bits = 23,
+	.adc14b_12_bits = 24,
+	.firdac_hsl_en_bits = 25,
+	.firdac_hsr_en_bits = 26,
+	.firdac_lout_en_bits = 27,
+	.por_bits = 28,
+	.codec_clk_en_bits = 29,
+};
+
+static const char * const input_mode_mux[] = {"Single-ended",
+	"Differential"};
+
+static const struct soc_enum input_mode_mux_enum =
+	SOC_ENUM_SINGLE(AUDIO_IC_CODEC_CTRL1, 4, 2, input_mode_mux);
+
+static const struct snd_kcontrol_new sirf_audio_codec_input_mode_control =
+	SOC_DAPM_ENUM("Route", input_mode_mux_enum);
+
+static const DECLARE_TLV_DB_SCALE(playback_vol_tlv, -12400, 100, 0);
+static const DECLARE_TLV_DB_SCALE(capture_vol_tlv_prima2, 500, 100, 0);
+static const DECLARE_TLV_DB_RANGE(capture_vol_tlv_atlas6,
+	0, 7, TLV_DB_SCALE_ITEM(-100, 100, 0),
+	0x22, 0x3F, TLV_DB_SCALE_ITEM(700, 100, 0),
+);
+
+static struct snd_kcontrol_new volume_controls_atlas6[] = {
+	SOC_DOUBLE_TLV("Playback Volume", AUDIO_IC_CODEC_CTRL0, 21, 14,
+			0x7F, 0, playback_vol_tlv),
+	SOC_DOUBLE_TLV("Capture Volume", AUDIO_IC_CODEC_CTRL1, 16, 10,
+			0x3F, 0, capture_vol_tlv_atlas6),
+};
+
+static struct snd_kcontrol_new volume_controls_prima2[] = {
+	SOC_DOUBLE_TLV("Speaker Volume", AUDIO_IC_CODEC_CTRL0, 21, 14,
+			0x7F, 0, playback_vol_tlv),
+	SOC_DOUBLE_TLV("Capture Volume", AUDIO_IC_CODEC_CTRL1, 15, 10,
+			0x1F, 0, capture_vol_tlv_prima2),
+};
+
+static struct snd_kcontrol_new left_input_path_controls[] = {
+	SOC_DAPM_SINGLE("Line Left Switch", AUDIO_IC_CODEC_CTRL1, 6, 1, 0),
+	SOC_DAPM_SINGLE("Mic Left Switch", AUDIO_IC_CODEC_CTRL1, 3, 1, 0),
+};
+
+static struct snd_kcontrol_new right_input_path_controls[] = {
+	SOC_DAPM_SINGLE("Line Right Switch", AUDIO_IC_CODEC_CTRL1, 5, 1, 0),
+	SOC_DAPM_SINGLE("Mic Right Switch", AUDIO_IC_CODEC_CTRL1, 2, 1, 0),
+};
+
+static struct snd_kcontrol_new left_dac_to_hp_left_amp_switch_control =
+	SOC_DAPM_SINGLE("Switch", AUDIO_IC_CODEC_CTRL0, 9, 1, 0);
+
+static struct snd_kcontrol_new left_dac_to_hp_right_amp_switch_control =
+	SOC_DAPM_SINGLE("Switch", AUDIO_IC_CODEC_CTRL0, 8, 1, 0);
+
+static struct snd_kcontrol_new right_dac_to_hp_left_amp_switch_control =
+	SOC_DAPM_SINGLE("Switch", AUDIO_IC_CODEC_CTRL0, 7, 1, 0);
+
+static struct snd_kcontrol_new right_dac_to_hp_right_amp_switch_control =
+	SOC_DAPM_SINGLE("Switch", AUDIO_IC_CODEC_CTRL0, 6, 1, 0);
+
+static struct snd_kcontrol_new left_dac_to_speaker_lineout_switch_control =
+	SOC_DAPM_SINGLE("Switch", AUDIO_IC_CODEC_CTRL0, 11, 1, 0);
+
+static struct snd_kcontrol_new right_dac_to_speaker_lineout_switch_control =
+	SOC_DAPM_SINGLE("Switch", AUDIO_IC_CODEC_CTRL0, 10, 1, 0);
+
+static int adc_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct sirf_audio_codec *sirf_audio_codec = dev_get_drvdata(codec->dev);
+	u32 val;
+
+	val = sirfsoc_rtc_iobrg_readl(sirf_audio_codec->sys_pwrc_reg_base +
+			PWRC_PDN_CTRL_OFFSET);
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		/* Enable capture power of codec*/
+		val |= (1 << AUDIO_POWER_EN_BIT);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		val &= ~(1 << AUDIO_POWER_EN_BIT);
+		break;
+	default:
+		return 0;
+	}
+
+	sirfsoc_rtc_iobrg_writel(val,
+		sirf_audio_codec->sys_pwrc_reg_base + PWRC_PDN_CTRL_OFFSET);
+
+	/*After enable adc, Delay 200ms to avoid pop noise*/
+	if (event == SND_SOC_DAPM_POST_PMU)
+		msleep(200);
+	return 0;
+}
+
+static int hp_amp_left_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct sirf_audio_codec *sirf_audio_codec = dev_get_drvdata(codec->dev);
+	u32 val;
+	u32 mask = (1 << sirf_audio_codec->reg_bits->firdac_hsl_en_bits);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		val = (1 << sirf_audio_codec->reg_bits->firdac_hsl_en_bits);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		val = ~(1 << sirf_audio_codec->reg_bits->firdac_hsl_en_bits);
+		break;
+	default:
+		return 0;
+	}
+	snd_soc_update_bits(codec, AUDIO_IC_CODEC_CTRL1, mask, val);
+	return 0;
+}
+
+static int hp_amp_right_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct sirf_audio_codec *sirf_audio_codec = dev_get_drvdata(codec->dev);
+	u32 val;
+	u32 mask = (1 << sirf_audio_codec->reg_bits->firdac_hsr_en_bits);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		val = (1 << sirf_audio_codec->reg_bits->firdac_hsr_en_bits);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		val = ~(1 << sirf_audio_codec->reg_bits->firdac_hsr_en_bits);
+		break;
+	default:
+		return 0;
+	}
+	snd_soc_update_bits(codec, AUDIO_IC_CODEC_CTRL1, mask, val);
+	return 0;
+}
+
+static int speaker_output_enable_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct sirf_audio_codec *sirf_audio_codec = dev_get_drvdata(codec->dev);
+	u32 val;
+	u32 mask = (1 << sirf_audio_codec->reg_bits->firdac_lout_en_bits);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		val = (1 << sirf_audio_codec->reg_bits->firdac_lout_en_bits);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		val = ~(1 << sirf_audio_codec->reg_bits->firdac_lout_en_bits);
+	default:
+		return 0;
+	}
+	snd_soc_update_bits(codec, AUDIO_IC_CODEC_CTRL1, mask, val);
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget sirf_audio_codec_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("DAC left", NULL, AUDIO_IC_CODEC_CTRL0, 1, 0),
+	SND_SOC_DAPM_DAC("DAC right", NULL, AUDIO_IC_CODEC_CTRL0, 0, 0),
+	SND_SOC_DAPM_SWITCH("Left dac to hp left amp", SND_SOC_NOPM, 0, 0,
+			&left_dac_to_hp_left_amp_switch_control),
+	SND_SOC_DAPM_SWITCH("Left dac to hp right amp", SND_SOC_NOPM, 0, 0,
+			&left_dac_to_hp_right_amp_switch_control),
+	SND_SOC_DAPM_SWITCH("Right dac to hp left amp", SND_SOC_NOPM, 0, 0,
+			&right_dac_to_hp_left_amp_switch_control),
+	SND_SOC_DAPM_SWITCH("Right dac to hp right amp", SND_SOC_NOPM, 0, 0,
+			&right_dac_to_hp_right_amp_switch_control),
+	SND_SOC_DAPM_OUT_DRV_E("HP amp left driver", AUDIO_IC_CODEC_CTRL0, 3, 0,
+			NULL, 0, hp_amp_left_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_OUT_DRV_E("HP amp right driver", AUDIO_IC_CODEC_CTRL0, 2, 0,
+			NULL, 0, hp_amp_right_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_SWITCH("Left dac to speaker lineout", SND_SOC_NOPM, 0, 0,
+			&left_dac_to_speaker_lineout_switch_control),
+	SND_SOC_DAPM_SWITCH("Right dac to speaker lineout", SND_SOC_NOPM, 0, 0,
+			&right_dac_to_speaker_lineout_switch_control),
+	SND_SOC_DAPM_OUT_DRV_E("Speaker output driver", AUDIO_IC_CODEC_CTRL0, 4, 0,
+			NULL, 0, speaker_output_enable_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_OUTPUT("HPOUTL"),
+	SND_SOC_DAPM_OUTPUT("HPOUTR"),
+	SND_SOC_DAPM_OUTPUT("SPKOUT"),
+
+	SND_SOC_DAPM_ADC_E("ADC left", NULL, AUDIO_IC_CODEC_CTRL1, 8, 0,
+			adc_event,
+			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_ADC_E("ADC right", NULL, AUDIO_IC_CODEC_CTRL1, 7, 0,
+			adc_event, SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_MIXER("Left PGA mixer", AUDIO_IC_CODEC_CTRL1, 1, 0,
+		&left_input_path_controls[0],
+		ARRAY_SIZE(left_input_path_controls)),
+	SND_SOC_DAPM_MIXER("Right PGA mixer", AUDIO_IC_CODEC_CTRL1, 0, 0,
+		&right_input_path_controls[0],
+		ARRAY_SIZE(right_input_path_controls)),
+
+	SND_SOC_DAPM_MUX("Mic input mode mux", SND_SOC_NOPM, 0, 0,
+			&sirf_audio_codec_input_mode_control),
+	SND_SOC_DAPM_MICBIAS("Mic Bias", AUDIO_IC_CODEC_PWR, 3, 0),
+	SND_SOC_DAPM_INPUT("MICIN1"),
+	SND_SOC_DAPM_INPUT("MICIN2"),
+	SND_SOC_DAPM_INPUT("LINEIN1"),
+	SND_SOC_DAPM_INPUT("LINEIN2"),
+
+	SND_SOC_DAPM_SUPPLY("HSL Phase Opposite", AUDIO_IC_CODEC_CTRL0,
+			30, 0, NULL, 0),
+};
+
+static const struct snd_soc_dapm_route sirf_audio_codec_map[] = {
+	{"SPKOUT", NULL, "Speaker output driver"},
+	{"Speaker output driver", NULL, "Left dac to speaker lineout"},
+	{"Speaker output driver", NULL, "Right dac to speaker lineout"},
+	{"Left dac to speaker lineout", "Switch", "DAC left"},
+	{"Right dac to speaker lineout", "Switch", "DAC right"},
+	{"HPOUTL", NULL, "HP amp left driver"},
+	{"HPOUTR", NULL, "HP amp right driver"},
+	{"HP amp left driver", NULL, "Right dac to hp left amp"},
+	{"HP amp right driver", NULL , "Right dac to hp right amp"},
+	{"HP amp left driver", NULL, "Left dac to hp left amp"},
+	{"HP amp right driver", NULL , "Right dac to hp right amp"},
+	{"Right dac to hp left amp", "Switch", "DAC left"},
+	{"Right dac to hp right amp", "Switch", "DAC right"},
+	{"Left dac to hp left amp", "Switch", "DAC left"},
+	{"Left dac to hp right amp", "Switch", "DAC right"},
+	{"DAC left", NULL, "Playback"},
+	{"DAC right", NULL, "Playback"},
+	{"DAC left", NULL, "HSL Phase Opposite"},
+	{"DAC right", NULL, "HSL Phase Opposite"},
+
+	{"Capture", NULL, "ADC left"},
+	{"Capture", NULL, "ADC right"},
+	{"ADC left", NULL, "Left PGA mixer"},
+	{"ADC right", NULL, "Right PGA mixer"},
+	{"Left PGA mixer", "Line Left Switch", "LINEIN2"},
+	{"Right PGA mixer", "Line Right Switch", "LINEIN1"},
+	{"Left PGA mixer", "Mic Left Switch", "MICIN2"},
+	{"Right PGA mixer", "Mic Right Switch", "Mic input mode mux"},
+	{"Mic input mode mux", "Single-ended", "MICIN1"},
+	{"Mic input mode mux", "Differential", "MICIN1"},
+};
+
+static int sirf_audio_codec_trigger(struct snd_pcm_substream *substream,
+		int cmd,
+		struct snd_soc_dai *dai)
+{
+	int playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
+	struct snd_soc_codec *codec = dai->codec;
+	u32 val = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		break;
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (playback)
+			val = IC_HSLEN | IC_HSREN;
+		break;
+	default:
+		return -EINVAL;
+	}
+	snd_soc_update_bits(codec, AUDIO_IC_CODEC_CTRL0,
+			IC_HSLEN | IC_HSREN, val);
+	return 0;
+}
+
+struct snd_soc_dai_ops sirf_audio_codec_dai_ops = {
+	.trigger = sirf_audio_codec_trigger,
+};
+
+struct snd_soc_dai_driver sirf_audio_codec_dai = {
+	.name = "sirf-audio-codec",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.ops = &sirf_audio_codec_dai_ops,
+};
+EXPORT_SYMBOL_GPL(sirf_audio_codec_dai);
+
+static int sirf_audio_codec_probe(struct snd_soc_codec *codec)
+{
+	int ret;
+	struct sirf_audio_codec *sirf_audio_codec = snd_soc_codec_get_drvdata(codec);
+	pm_runtime_enable(codec->dev);
+	codec->control_data = sirf_audio_codec->regmap;
+
+	ret = snd_soc_codec_set_cache_io(codec, 0, 0, SND_SOC_REGMAP);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
+	}
+
+	if (of_device_is_compatible(codec->dev->of_node, "sirf,prima2-audio-codec"))
+		return snd_soc_add_codec_controls(codec,
+			volume_controls_prima2,
+			ARRAY_SIZE(volume_controls_prima2));
+	if (of_device_is_compatible(codec->dev->of_node, "sirf,atlas6-audio-codec"))
+		return snd_soc_add_codec_controls(codec,
+			volume_controls_atlas6,
+			ARRAY_SIZE(volume_controls_atlas6));
+
+	return -EINVAL;
+}
+
+static int sirf_audio_codec_remove(struct snd_soc_codec *codec)
+{
+	pm_runtime_disable(codec->dev);
+	return 0;
+}
+
+static struct snd_soc_codec_driver soc_codec_device_sirf_audio_codec = {
+	.probe = sirf_audio_codec_probe,
+	.remove = sirf_audio_codec_remove,
+	.dapm_widgets = sirf_audio_codec_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(sirf_audio_codec_dapm_widgets),
+	.dapm_routes = sirf_audio_codec_map,
+	.num_dapm_routes = ARRAY_SIZE(sirf_audio_codec_map),
+	.idle_bias_off = true,
+};
+
+static const struct of_device_id sirf_audio_codec_of_match[] = {
+	{ .compatible = "sirf,prima2-audio-codec", .data = &sirf_audio_codec_reg_bits_prima2 },
+	{ .compatible = "sirf,atlas6-audio-codec", .data = &sirf_audio_codec_reg_bits_atlas6 },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sirf_audio_codec_of_match);
+
+static const struct regmap_config sirf_audio_codec_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = AUDIO_IC_CODEC_CTRL3,
+	.cache_type = REGCACHE_NONE,
+};
+
+static int sirf_audio_codec_driver_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct sirf_audio_codec *sirf_audio_codec;
+	void __iomem *base;
+	struct resource *mem_res;
+	struct device_node *dn = NULL;
+	const struct of_device_id *match;
+
+	match = of_match_node(sirf_audio_codec_of_match, pdev->dev.of_node);
+
+	sirf_audio_codec = devm_kzalloc(&pdev->dev,
+		sizeof(struct sirf_audio_codec), GFP_KERNEL);
+	if (!sirf_audio_codec)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, sirf_audio_codec);
+
+	dn = of_find_compatible_node(dn, NULL, "sirf,prima2-pwrc");
+	if (!dn) {
+		dev_err(&pdev->dev, "Failed to get sirf,prima2-pwrc  node!\n");
+		return -ENODEV;
+	}
+
+	ret = of_property_read_u32(dn, "reg", &sirf_audio_codec->sys_pwrc_reg_base);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed tp get pwrc register base address\n");
+		return -EINVAL;
+	}
+
+	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, mem_res);
+	if (base == NULL)
+		return -ENOMEM;
+
+	sirf_audio_codec->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					    &sirf_audio_codec_regmap_config);
+	if (IS_ERR(sirf_audio_codec->regmap))
+		return PTR_ERR(sirf_audio_codec->regmap);
+
+	sirf_audio_codec->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(sirf_audio_codec->clk)) {
+		dev_err(&pdev->dev, "Get clock failed.\n");
+		return PTR_ERR(sirf_audio_codec->clk);
+	}
+
+	ret = clk_prepare_enable(sirf_audio_codec->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Enable clock failed.\n");
+		return ret;
+	}
+
+	ret = snd_soc_register_codec(&(pdev->dev),
+			&soc_codec_device_sirf_audio_codec,
+			&sirf_audio_codec_dai, 1);
+	if (ret) {
+		dev_err(&pdev->dev, "Register Audio Codec dai failed.\n");
+		goto err_clk_put;
+	}
+
+	sirf_audio_codec->reg_bits = (struct sirf_audio_codec_reg_bits *)match->data;
+	/*
+	 * Always open charge pump, if not, when the charge pump closed the
+	 * adc will not stable
+	 */
+	regmap_update_bits(sirf_audio_codec->regmap, AUDIO_IC_CODEC_CTRL0,
+		IC_CPFREQ, IC_CPFREQ);
+
+	if (of_device_is_compatible(pdev->dev.of_node, "sirf,atlas6-audio-codec"))
+		regmap_update_bits(sirf_audio_codec->regmap,
+				AUDIO_IC_CODEC_CTRL0, IC_CPEN, IC_CPEN);
+	return 0;
+
+err_clk_put:
+	clk_disable_unprepare(sirf_audio_codec->clk);
+	return ret;
+}
+
+static int sirf_audio_codec_driver_remove(struct platform_device *pdev)
+{
+	struct sirf_audio_codec *sirf_audio_codec = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(sirf_audio_codec->clk);
+	snd_soc_unregister_codec(&(pdev->dev));
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_RUNTIME
+static int sirf_audio_codec_runtime_suspend(struct device *dev)
+{
+	struct sirf_audio_codec *sirf_audio_codec = dev_get_drvdata(dev);
+	regmap_update_bits(sirf_audio_codec->regmap, AUDIO_IC_CODEC_CTRL1,
+		(1 << sirf_audio_codec->reg_bits->codec_clk_en_bits),
+		0);
+	return 0;
+}
+
+static int sirf_audio_codec_runtime_resume(struct device *dev)
+{
+	struct sirf_audio_codec *sirf_audio_codec = dev_get_drvdata(dev);
+	regmap_update_bits(sirf_audio_codec->regmap, AUDIO_IC_CODEC_CTRL1,
+		(1 << sirf_audio_codec->reg_bits->codec_clk_en_bits) |
+		(1 << sirf_audio_codec->reg_bits->por_bits),
+		(1 << sirf_audio_codec->reg_bits->codec_clk_en_bits));
+	msleep(20);
+	regmap_update_bits(sirf_audio_codec->regmap, AUDIO_IC_CODEC_CTRL1,
+		(1 << sirf_audio_codec->reg_bits->por_bits),
+		(1 << sirf_audio_codec->reg_bits->por_bits));
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+static int sirf_audio_codec_suspend(struct device *dev)
+{
+	struct sirf_audio_codec *sirf_audio_codec = dev_get_drvdata(dev);
+
+	regmap_read(sirf_audio_codec->regmap, AUDIO_IC_CODEC_CTRL0,
+		&sirf_audio_codec->reg_ctrl0);
+	regmap_read(sirf_audio_codec->regmap, AUDIO_IC_CODEC_CTRL1,
+		&sirf_audio_codec->reg_ctrl1);
+	sirf_audio_codec_runtime_suspend(dev);
+	clk_disable_unprepare(sirf_audio_codec->clk);
+
+	return 0;
+}
+
+static int sirf_audio_codec_resume(struct device *dev)
+{
+	struct sirf_audio_codec *sirf_audio_codec = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(sirf_audio_codec->clk);
+	if (ret)
+		return ret;
+
+	regmap_write(sirf_audio_codec->regmap, AUDIO_IC_CODEC_CTRL0,
+		sirf_audio_codec->reg_ctrl0);
+	regmap_write(sirf_audio_codec->regmap, AUDIO_IC_CODEC_CTRL1,
+		sirf_audio_codec->reg_ctrl1);
+	if (!pm_runtime_status_suspended(dev))
+		sirf_audio_codec_runtime_resume(dev);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops sirf_audio_codec_pm_ops = {
+	SET_RUNTIME_PM_OPS(sirf_audio_codec_runtime_suspend, sirf_audio_codec_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(sirf_audio_codec_suspend, sirf_audio_codec_resume)
+};
+
+static struct platform_driver sirf_audio_codec_driver = {
+	.driver = {
+		.name = "sirf-audio-codec",
+		.owner = THIS_MODULE,
+		.of_match_table = sirf_audio_codec_of_match,
+		.pm = &sirf_audio_codec_pm_ops,
+	},
+	.probe = sirf_audio_codec_driver_probe,
+	.remove = sirf_audio_codec_driver_remove,
+};
+
+module_platform_driver(sirf_audio_codec_driver);
+
+MODULE_DESCRIPTION("SiRF audio codec driver");
+MODULE_AUTHOR("RongJun Ying <Rongjun.Ying@csr.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/sirf-audio-codec.h b/sound/soc/codecs/sirf-audio-codec.h
new file mode 100644
index 0000000..d4c187b
--- /dev/null
+++ b/sound/soc/codecs/sirf-audio-codec.h
@@ -0,0 +1,75 @@
+/*
+ * SiRF inner codec controllers define
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef _SIRF_AUDIO_CODEC_H
+#define _SIRF_AUDIO_CODEC_H
+
+
+#define AUDIO_IC_CODEC_PWR			(0x00E0)
+#define AUDIO_IC_CODEC_CTRL0			(0x00E4)
+#define AUDIO_IC_CODEC_CTRL1			(0x00E8)
+#define AUDIO_IC_CODEC_CTRL2			(0x00EC)
+#define AUDIO_IC_CODEC_CTRL3			(0x00F0)
+
+#define MICBIASEN		(1 << 3)
+
+#define IC_RDACEN		(1 << 0)
+#define IC_LDACEN		(1 << 1)
+#define IC_HSREN		(1 << 2)
+#define IC_HSLEN		(1 << 3)
+#define IC_SPEN			(1 << 4)
+#define IC_CPEN			(1 << 5)
+
+#define IC_HPRSELR		(1 << 6)
+#define IC_HPLSELR		(1 << 7)
+#define IC_HPRSELL		(1 << 8)
+#define IC_HPLSELL		(1 << 9)
+#define IC_SPSELR		(1 << 10)
+#define IC_SPSELL		(1 << 11)
+
+#define IC_MONOR		(1 << 12)
+#define IC_MONOL		(1 << 13)
+
+#define IC_RXOSRSEL		(1 << 28)
+#define IC_CPFREQ		(1 << 29)
+#define IC_HSINVEN		(1 << 30)
+
+#define IC_MICINREN		(1 << 0)
+#define IC_MICINLEN		(1 << 1)
+#define IC_MICIN1SEL		(1 << 2)
+#define IC_MICIN2SEL		(1 << 3)
+#define IC_MICDIFSEL		(1 << 4)
+#define	IC_LINEIN1SEL		(1 << 5)
+#define	IC_LINEIN2SEL		(1 << 6)
+#define	IC_RADCEN		(1 << 7)
+#define	IC_LADCEN		(1 << 8)
+#define	IC_ALM			(1 << 9)
+
+#define IC_DIGMICEN             (1 << 22)
+#define IC_DIGMICFREQ           (1 << 23)
+#define IC_ADC14B_12            (1 << 24)
+#define IC_FIRDAC_HSL_EN        (1 << 25)
+#define IC_FIRDAC_HSR_EN        (1 << 26)
+#define IC_FIRDAC_LOUT_EN       (1 << 27)
+#define IC_POR                  (1 << 28)
+#define IC_CODEC_CLK_EN         (1 << 29)
+#define IC_HP_3DB_BOOST         (1 << 30)
+
+#define IC_ADC_LEFT_GAIN_SHIFT	16
+#define IC_ADC_RIGHT_GAIN_SHIFT 10
+#define IC_ADC_GAIN_MASK	0x3F
+#define IC_MIC_MAX_GAIN		0x39
+
+#define IC_RXPGAR_MASK		0x3F
+#define IC_RXPGAR_SHIFT		14
+#define IC_RXPGAL_MASK		0x3F
+#define IC_RXPGAL_SHIFT		21
+#define IC_RXPGAR		0x7B
+#define IC_RXPGAL		0x7B
+
+#endif /*__SIRF_AUDIO_CODEC_H*/
-- 
1.7.5.4
