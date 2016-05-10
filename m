From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] ASoC: MAX9860: new driver
Date: Tue, 10 May 2016 17:06:37 +0200
Message-ID: <1462892797-1147-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0117.outbound.protection.outlook.com [104.47.1.117])
 by alsa0.perex.cz (Postfix) with ESMTP id 8164C261600
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 17:06:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

This is a driver for the MAX9860 Mono Audio Voice Codec.

https://datasheets.maximintegrated.com/en/ds/MAX9860.pdf

This driver does not support sidetone since the DVST register field is
backwards with the mute near the maximum level instead of the minimum.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/sound/max9860.txt          |  27 +
 MAINTAINERS                                        |   7 +
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/max9860.c                         | 722 +++++++++++++++++++++
 sound/soc/codecs/max9860.h                         | 162 +++++
 6 files changed, 926 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/max9860.txt
 create mode 100644 sound/soc/codecs/max9860.c
 create mode 100644 sound/soc/codecs/max9860.h

diff --git a/Documentation/devicetree/bindings/sound/max9860.txt b/Documentation/devicetree/bindings/sound/max9860.txt
new file mode 100644
index 000000000000..e98b59a0b5aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/max9860.txt
@@ -0,0 +1,27 @@
+MAX9860 Mono Audio Voice Codec
+
+Required properties:
+
+  - compatible : "maxim,max9860"
+
+  - reg : the I2C address of the device
+
+  - AVDD-supply and DVDD-supply : power supplies for the
+    device, as covered in bindings/regulator/regulator.txt
+
+  - clock-names : Required element: "mclk".
+
+  - clocks : A clock specifier for the clock connected as MCLK.
+
+Examples:
+
+	max9860: max9860@10 {
+		compatible = "maxim,max9860";
+		reg = <0x10>;
+
+		AVDD-supply = <&reg_1v8>;
+		DVDD-supply = <&reg_1v8>;
+
+		clock-names = "mclk";
+		clocks = <&pck2>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index a727d9959ecd..0803396b10f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7000,6 +7000,13 @@ F:	Documentation/devicetree/bindings/i2c/max6697.txt
 F:	drivers/hwmon/max6697.c
 F:	include/linux/platform_data/max6697.h
 
+MAX9860 MONO AUDIO VOICE CODEC DRIVER
+M:	Peter Rosin <peda@axentia.se>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/max9860.txt
+F:	sound/soc/codecs/max9860*
+
 MAXIM MUIC CHARGER DRIVERS FOR EXYNOS BASED BOARDS
 M:	Krzysztof Kozlowski <k.kozlowski@samsung.com>
 L:	linux-pm@vger.kernel.org
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 7ef3a0c16478..241a23c9aa9f 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -83,6 +83,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_MAX98925 if I2C
 	select SND_SOC_MAX98926 if I2C
 	select SND_SOC_MAX9850 if I2C
+	select SND_SOC_MAX9860 if I2C
 	select SND_SOC_MAX9768 if I2C
 	select SND_SOC_MAX9877 if I2C
 	select SND_SOC_MC13783 if MFD_MC13XXX
@@ -534,6 +535,11 @@ config SND_SOC_MAX98926
 config SND_SOC_MAX9850
 	tristate
 
+config SND_SOC_MAX9860
+	tristate "Maxim MAX9860 Mono Audio Voice Codec"
+	depends on I2C
+	select REGMAP_I2C
+
 config SND_SOC_PCM1681
 	tristate "Texas Instruments PCM1681 CODEC"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 185a712a7fe7..e435f4df1787 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -78,6 +78,7 @@ snd-soc-max9867-objs := max9867.o
 snd-soc-max98925-objs := max98925.o
 snd-soc-max98926-objs := max98926.o
 snd-soc-max9850-objs := max9850.o
+snd-soc-max9860-objs := max9860.o
 snd-soc-mc13783-objs := mc13783.o
 snd-soc-ml26124-objs := ml26124.o
 snd-soc-nau8825-objs := nau8825.o
@@ -287,6 +288,7 @@ obj-$(CONFIG_SND_SOC_MAX9867)	+= snd-soc-max9867.o
 obj-$(CONFIG_SND_SOC_MAX98925)	+= snd-soc-max98925.o
 obj-$(CONFIG_SND_SOC_MAX98926)	+= snd-soc-max98926.o
 obj-$(CONFIG_SND_SOC_MAX9850)	+= snd-soc-max9850.o
+obj-$(CONFIG_SND_SOC_MAX9860)	+= snd-soc-max9860.o
 obj-$(CONFIG_SND_SOC_MC13783)	+= snd-soc-mc13783.o
 obj-$(CONFIG_SND_SOC_ML26124)	+= snd-soc-ml26124.o
 obj-$(CONFIG_SND_SOC_NAU8825)   += snd-soc-nau8825.o
diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
new file mode 100644
index 000000000000..d04630042de7
--- /dev/null
+++ b/sound/soc/codecs/max9860.c
@@ -0,0 +1,722 @@
+/*
+ * Driver for the MAX9860 Mono Audio Voice Codec
+ *
+ * https://datasheets.maximintegrated.com/en/ds/MAX9860.pdf
+ *
+ * The driver does not support sidetone since the DVST register field is
+ * backwards with the mute near the maximum level instead of the minimum.
+ *
+ * Author: Peter Rosin <peda@axentia.s>
+ *         Copyright 2016 Axentia Technologies
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/kernel.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/i2c.h>
+#include <linux/regulator/consumer.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm_params.h>
+#include <sound/tlv.h>
+
+#include "max9860.h"
+
+struct max9860_priv {
+	struct regmap *regmap;
+	u8 psclk;
+	unsigned long pclk_rate;
+	int fmt;
+};
+
+static const struct reg_default max9860_reg_defaults[] = {
+	{ MAX9860_PWRMAN,       0x00 },
+	{ MAX9860_INTEN,        0x00 },
+	{ MAX9860_SYSCLK,       0x00 },
+	{ MAX9860_AUDIOCLKHIGH, 0x00 },
+	{ MAX9860_AUDIOCLKLOW,  0x00 },
+	{ MAX9860_IFC1A,        0x00 },
+	{ MAX9860_IFC1B,        0x00 },
+	{ MAX9860_VOICEFLTR,    0x00 },
+	{ MAX9860_DACATTN,      0x00 },
+	{ MAX9860_ADCLEVEL,     0x00 },
+	{ MAX9860_DACGAIN,      0x00 },
+	{ MAX9860_MICGAIN,      0x00 },
+	{ MAX9860_MICADC,       0x00 },
+	{ MAX9860_NOISEGATE,    0x00 },
+};
+
+static bool max9860_readable(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX9860_INTRSTATUS ... MAX9860_MICGAIN:
+	case MAX9860_MICADC ... MAX9860_PWRMAN:
+	case MAX9860_REVISION:
+		return true;
+	}
+
+	return false;
+}
+
+static bool max9860_writeable(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX9860_INTEN ... MAX9860_MICGAIN:
+	case MAX9860_MICADC ... MAX9860_PWRMAN:
+		return true;
+	}
+
+	return false;
+}
+
+static bool max9860_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX9860_INTRSTATUS:
+	case MAX9860_MICREADBACK:
+		return true;
+	}
+
+	return false;
+}
+
+static bool max9860_precious(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX9860_INTRSTATUS:
+		return true;
+	}
+
+	return false;
+}
+
+const struct regmap_config max9860_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.readable_reg = max9860_readable,
+	.writeable_reg = max9860_writeable,
+	.volatile_reg = max9860_volatile,
+	.precious_reg = max9860_precious,
+
+	.max_register = MAX9860_MAX_REGISTER,
+	.reg_defaults = max9860_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(max9860_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static const DECLARE_TLV_DB_SCALE(dva_tlv, -9100, 100, 1);
+static const DECLARE_TLV_DB_SCALE(dvg_tlv, 0, 600, 0);
+static const DECLARE_TLV_DB_SCALE(adc_tlv, -1200, 100, 0);
+static const DECLARE_TLV_DB_RANGE(pam_tlv,
+	0, MAX9860_PAM_MAX - 1,             TLV_DB_SCALE_ITEM(-2000, 2000, 1),
+	MAX9860_PAM_MAX, MAX9860_PAM_MAX,   TLV_DB_SCALE_ITEM(3000, 0, 0));
+static const DECLARE_TLV_DB_SCALE(pgam_tlv, 0, 100, 0);
+static const DECLARE_TLV_DB_SCALE(anth_tlv, -7600, 400, 1);
+static const DECLARE_TLV_DB_SCALE(agcth_tlv, -1800, 100, 0);
+
+static const char * const agchld_text[] = {
+	"AGC Disabled", "50ms", "100ms", "400ms"
+};
+
+static SOC_ENUM_SINGLE_DECL(agchld_enum, MAX9860_MICADC,
+			    MAX9860_AGCHLD_SHIFT, agchld_text);
+
+static const char * const agcsrc_text[] = {
+	"Left ADC", "Left/Right ADC"
+};
+
+static SOC_ENUM_SINGLE_DECL(agcsrc_enum, MAX9860_MICADC,
+			    MAX9860_AGCSRC_SHIFT, agcsrc_text);
+
+static const char * const agcatk_text[] = {
+	"3ms", "12ms", "50ms", "200ms"
+};
+
+static SOC_ENUM_SINGLE_DECL(agcatk_enum, MAX9860_MICADC,
+			    MAX9860_AGCATK_SHIFT, agcatk_text);
+
+static const char * const agcrls_text[] = {
+	"78ms", "156ms", "312ms", "625ms",
+	"1.25s", "2.5s", "5s", "10s"
+};
+
+static SOC_ENUM_SINGLE_DECL(agcrls_enum, MAX9860_MICADC,
+			    MAX9860_AGCRLS_SHIFT, agcrls_text);
+
+static const char * const filter_text[] = {
+	"Disabled",
+	"Elliptical HP 217Hz notch (16kHz)",
+	"Butterworth HP 500Hz (16kHz)",
+	"Elliptical HP 217Hz notch (8kHz)",
+	"Butterworth HP 500Hz (8kHz)",
+	"Butterworth HP 200Hz (48kHz)"
+};
+
+static SOC_ENUM_SINGLE_DECL(avflt_enum, MAX9860_VOICEFLTR,
+			    MAX9860_AVFLT_SHIFT, filter_text);
+
+static SOC_ENUM_SINGLE_DECL(dvflt_enum, MAX9860_VOICEFLTR,
+			    MAX9860_DVFLT_SHIFT, filter_text);
+
+static const struct snd_kcontrol_new max9860_controls[] = {
+SOC_SINGLE_TLV("Master Playback Volume", MAX9860_DACATTN,
+	       MAX9860_DVA_SHIFT, MAX9860_DVA_MUTE, 1, dva_tlv),
+SOC_SINGLE_TLV("DAC Gain Volume", MAX9860_DACGAIN,
+	       MAX9860_DVG_SHIFT, MAX9860_DVG_MAX, 0, dvg_tlv),
+SOC_DOUBLE_TLV("Line Capture Volume", MAX9860_ADCLEVEL,
+	       MAX9860_ADCLL_SHIFT, MAX9860_ADCRL_SHIFT, MAX9860_ADCxL_MIN, 1,
+	       adc_tlv),
+
+SOC_ENUM("AGC Hold Time", agchld_enum),
+SOC_ENUM("AGC/Noise Gate Source", agcsrc_enum),
+SOC_ENUM("AGC Attack Time", agcatk_enum),
+SOC_ENUM("AGC Release Time", agcrls_enum),
+
+SOC_SINGLE_TLV("Noise Gate Threshold Volume", MAX9860_NOISEGATE,
+	       MAX9860_ANTH_SHIFT, MAX9860_ANTH_MAX, 0, anth_tlv),
+SOC_SINGLE_TLV("AGC Signal Threshold Volume", MAX9860_NOISEGATE,
+	       MAX9860_AGCTH_SHIFT, MAX9860_AGCTH_MIN, 1, agcth_tlv),
+
+SOC_SINGLE_TLV("Mic PGA Volume", MAX9860_MICGAIN,
+	       MAX9860_PGAM_SHIFT, MAX9860_PGAM_MIN, 1, pgam_tlv),
+SOC_SINGLE_TLV("Mic Preamp Volume", MAX9860_MICGAIN,
+	       MAX9860_PAM_SHIFT, MAX9860_PAM_MAX, 0, pam_tlv),
+
+SOC_ENUM("ADC Filter", avflt_enum),
+SOC_ENUM("DAC Filter", dvflt_enum),
+};
+
+static const struct snd_soc_dapm_widget max9860_dapm_widgets[] = {
+SND_SOC_DAPM_INPUT("MICL"),
+SND_SOC_DAPM_INPUT("MICR"),
+
+SND_SOC_DAPM_ADC("ADCL", NULL, MAX9860_PWRMAN, MAX9860_ADCLEN_SHIFT, 0),
+SND_SOC_DAPM_ADC("ADCR", NULL, MAX9860_PWRMAN, MAX9860_ADCREN_SHIFT, 0),
+
+SND_SOC_DAPM_AIF_OUT("AIFOUTL", "Capture", 0, SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_AIF_OUT("AIFOUTR", "Capture", 1, SND_SOC_NOPM, 0, 0),
+
+SND_SOC_DAPM_AIF_IN("AIFINL", "Playback", 0, SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_AIF_IN("AIFINR", "Playback", 1, SND_SOC_NOPM, 0, 0),
+
+SND_SOC_DAPM_DAC("DAC", NULL, MAX9860_PWRMAN, MAX9860_DACEN_SHIFT, 0),
+
+SND_SOC_DAPM_OUTPUT("OUT"),
+
+SND_SOC_DAPM_SUPPLY("Supply", SND_SOC_NOPM, 0, 0,
+		    NULL, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_REGULATOR_SUPPLY("AVDD", 0, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("DVDD", 0, 0),
+SND_SOC_DAPM_CLOCK_SUPPLY("mclk"),
+};
+
+static const struct snd_soc_dapm_route max9860_dapm_routes[] = {
+	{ "ADCL", NULL, "MICL" },
+	{ "ADCR", NULL, "MICR" },
+	{ "AIFOUTL", NULL, "ADCL" },
+	{ "AIFOUTR", NULL, "ADCR" },
+
+	{ "DAC", NULL, "AIFINL" },
+	{ "DAC", NULL, "AIFINR" },
+	{ "OUT", NULL, "DAC" },
+
+	{ "Supply", NULL, "AVDD" },
+	{ "Supply", NULL, "DVDD" },
+	{ "Supply", NULL, "mclk" },
+
+	{ "DAC", NULL, "Supply" },
+	{ "ADCL", NULL, "Supply" },
+	{ "ADCR", NULL, "Supply" },
+};
+
+static int max9860_dai_startup(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct max9860_priv *max9860 = snd_soc_codec_get_drvdata(codec);
+
+	switch (max9860->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+	case SND_SOC_DAIFMT_CBS_CFS:
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int max9860_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct max9860_priv *max9860 = snd_soc_codec_get_drvdata(codec);
+	u8 master;
+	u8 ifc1a = 0;
+	u8 ifc1b = 0;
+	u8 sysclk = 0;
+	unsigned long n;
+	int ret;
+
+	dev_dbg(codec->dev, "hw_params %u Hz, %u channels\n",
+		params_rate(params),
+		params_channels(params));
+
+	if (params_channels(params) == 2)
+		ifc1b |= MAX9860_ST;
+
+	switch (max9860->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		master = 0;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		master = MAX9860_MASTER;
+		break;
+	default:
+		return -EINVAL;
+	}
+	ifc1a |= master;
+
+	if (master) {
+		if (params_width(params) * params_channels(params) > 48)
+			ifc1b |= MAX9860_BSEL_64X;
+		else
+			ifc1b |= MAX9860_BSEL_48X;
+	}
+
+	switch (max9860->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		ifc1a |= MAX9860_DDLY;
+		ifc1b |= MAX9860_ADLY;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		ifc1a |= MAX9860_WCI;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		if (params_width(params) != 16) {
+			dev_err(codec->dev,
+				"DSP_A works for 16 bits per sample only.\n");
+			return -EINVAL;
+		}
+		ifc1a |= MAX9860_DDLY | MAX9860_WCI | MAX9860_HIZ | MAX9860_TDM;
+		ifc1b |= MAX9860_ADLY;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		if (params_width(params) != 16) {
+			dev_err(codec->dev,
+				"DSP_B works for 16 bits per sample only.\n");
+			return -EINVAL;
+		}
+		ifc1a |= MAX9860_WCI | MAX9860_HIZ | MAX9860_TDM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (max9860->fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		switch (max9860->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+		case SND_SOC_DAIFMT_DSP_A:
+		case SND_SOC_DAIFMT_DSP_B:
+			return -EINVAL;
+		}
+		ifc1a ^= MAX9860_WCI;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		switch (max9860->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+		case SND_SOC_DAIFMT_DSP_A:
+		case SND_SOC_DAIFMT_DSP_B:
+			return -EINVAL;
+		}
+		ifc1a ^= MAX9860_WCI;
+		/* fall through */
+	case SND_SOC_DAIFMT_IB_NF:
+		ifc1a ^= MAX9860_DBCI;
+		ifc1b ^= MAX9860_ABCI;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dev_dbg(codec->dev, "IFC1A  %02x\n", ifc1a);
+	ret = regmap_write(max9860->regmap, MAX9860_IFC1A, ifc1a);
+	if (ret) {
+		dev_err(codec->dev, "Failed to set IFC1A: %d\n", ret);
+		return ret;
+	}
+	dev_dbg(codec->dev, "IFC1B  %02x\n", ifc1b);
+	ret = regmap_write(max9860->regmap, MAX9860_IFC1B, ifc1b);
+	if (ret) {
+		dev_err(codec->dev, "Failed to set IFC1B: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Check if Integer Clock Mode is possible, but avoid it in slave mode
+	 * since we then do not know if lrclk is derived from pclk and the
+	 * datasheet mentions that the frequencies have to match exactly in
+	 * order for this to work.
+	 */
+	if (params_rate(params) == 8000 || params_rate(params) == 16000) {
+		if (master) {
+			switch (max9860->pclk_rate) {
+			case 12000000:
+				sysclk = MAX9860_FREQ_12MHZ;
+				break;
+			case 13000000:
+				sysclk = MAX9860_FREQ_13MHZ;
+				break;
+			case 19200000:
+				sysclk = MAX9860_FREQ_19_2MHZ;
+				break;
+			}
+
+			if (sysclk && params_rate(params) == 16000)
+				sysclk |= MAX9860_16KHZ;
+		}
+	}
+
+	/*
+	 * Largest possible n:
+	 *    65536 * 96 * 48kHz / 10MHz -> 30199
+	 * Smallest possible n:
+	 *    65536 * 96 *  8kHz / 20MHz -> 2517
+	 * Both fit nicely in the available 15 bits, no need to apply any mask.
+	 */
+	n = DIV_ROUND_CLOSEST_ULL(65536ULL * 96 * params_rate(params),
+				  max9860->pclk_rate);
+
+	if (!sysclk) {
+		if (params_rate(params) > 24000)
+			sysclk |= MAX9860_16KHZ;
+
+		if (!master)
+			n |= 1; /* trigger rapid pll lock mode */
+	}
+
+	sysclk |= max9860->psclk;
+	dev_dbg(codec->dev, "SYSCLK %02x\n", sysclk);
+	ret = regmap_write(max9860->regmap,
+			   MAX9860_SYSCLK, sysclk);
+	if (ret) {
+		dev_err(codec->dev, "Failed to set SYSCLK: %d\n", ret);
+		return ret;
+	}
+	dev_dbg(codec->dev, "N %lu\n", n);
+	ret = regmap_write(max9860->regmap,
+			   MAX9860_AUDIOCLKHIGH, n >> 8);
+	if (ret) {
+		dev_err(codec->dev, "Failed to set NHI: %d\n", ret);
+		return ret;
+	}
+	ret = regmap_write(max9860->regmap,
+			   MAX9860_AUDIOCLKLOW, n & 0xff);
+	if (ret) {
+		dev_err(codec->dev, "Failed to set NLO: %d\n", ret);
+		return ret;
+	}
+
+	if (!master) {
+		dev_dbg(codec->dev, "Enable PLL\n");
+		ret = regmap_update_bits(max9860->regmap, MAX9860_AUDIOCLKHIGH,
+					 MAX9860_PLL, MAX9860_PLL);
+		if (ret) {
+			dev_err(codec->dev, "Failed to enable PLL: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int max9860_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct max9860_priv *max9860 = snd_soc_codec_get_drvdata(codec);
+
+	max9860->fmt = fmt;
+	return 0;
+}
+
+static const struct snd_soc_dai_ops max9860_dai_ops = {
+	.startup = max9860_dai_startup,
+	.hw_params = max9860_hw_params,
+	.set_fmt = max9860_set_fmt,
+};
+
+static struct snd_soc_dai_driver max9860_dai = {
+	.name = "max9860-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min = 8000,
+		.rate_max = 48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE |
+			   SNDRV_PCM_FMTBIT_S24_LE |
+			   SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min = 8000,
+		.rate_max = 48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE |
+			   SNDRV_PCM_FMTBIT_S24_LE |
+			   SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.ops = &max9860_dai_ops,
+	.symmetric_rates = 1,
+};
+
+static int max9860_set_bias_level(struct snd_soc_codec *codec,
+				  enum snd_soc_bias_level level)
+{
+	struct max9860_priv *max9860 = dev_get_drvdata(codec->dev);
+	int ret;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+	case SND_SOC_BIAS_PREPARE:
+		break;
+
+	case SND_SOC_BIAS_STANDBY:
+		ret = regmap_update_bits(max9860->regmap, MAX9860_PWRMAN,
+					 MAX9860_SHDN, MAX9860_SHDN);
+		if (ret) {
+			dev_err(codec->dev, "Failed to remove SHDN: %d\n", ret);
+			return ret;
+		}
+		break;
+
+	case SND_SOC_BIAS_OFF:
+		ret = regmap_update_bits(max9860->regmap, MAX9860_PWRMAN,
+					 MAX9860_SHDN, 0);
+		if (ret) {
+			dev_err(codec->dev, "Failed to request SHDN: %d\n",
+				ret);
+			return ret;
+		}
+		break;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_codec_driver max9860_codec_driver = {
+	.set_bias_level = max9860_set_bias_level,
+	.idle_bias_off = true,
+
+	.controls = max9860_controls,
+	.num_controls = ARRAY_SIZE(max9860_controls),
+	.dapm_widgets = max9860_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(max9860_dapm_widgets),
+	.dapm_routes = max9860_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(max9860_dapm_routes),
+};
+
+#ifdef CONFIG_PM
+static int max9860_suspend(struct device *dev)
+{
+	struct max9860_priv *max9860 = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regmap_update_bits(max9860->regmap, MAX9860_SYSCLK,
+				 MAX9860_PSCLK, MAX9860_PSCLK_OFF);
+	if (ret) {
+		dev_err(dev, "Failed to disable clock: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int max9860_resume(struct device *dev)
+{
+	struct max9860_priv *max9860 = dev_get_drvdata(dev);
+	int ret;
+
+	regcache_cache_only(max9860->regmap, false);
+	ret = regcache_sync(max9860->regmap);
+	if (ret) {
+		dev_err(dev, "Failed to sync cache: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(max9860->regmap, MAX9860_SYSCLK,
+				 MAX9860_PSCLK, max9860->psclk);
+	if (ret) {
+		dev_err(dev, "Failed to enable clock: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+#endif
+
+const struct dev_pm_ops max9860_pm_ops = {
+	SET_RUNTIME_PM_OPS(max9860_suspend, max9860_resume, NULL)
+};
+
+static int max9860_mclk_rate(struct device *dev, unsigned long *mclk_rate)
+{
+	struct clk *mclk = clk_get(dev, "mclk");
+	int ret;
+
+	if (IS_ERR(mclk)) {
+		ret = PTR_ERR(mclk);
+		dev_err(dev, "Failed to get MCLK: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(mclk);
+	if (ret) {
+		dev_err(dev, "Failed to enable MCLK: %d\n", ret);
+		clk_put(mclk);
+		return ret;
+	}
+
+	*mclk_rate = clk_get_rate(mclk);
+
+	clk_disable_unprepare(mclk);
+	clk_put(mclk);
+	return 0;
+}
+
+static int max9860_probe(struct i2c_client *i2c,
+			 const struct i2c_device_id *id)
+{
+	struct device *dev = &i2c->dev;
+	struct max9860_priv *max9860;
+	int ret;
+	unsigned long mclk_rate;
+	int i;
+	int intr;
+
+	max9860 = devm_kzalloc(dev, sizeof(struct max9860_priv), GFP_KERNEL);
+	if (!max9860)
+		return -ENOMEM;
+
+	max9860->regmap = devm_regmap_init_i2c(i2c, &max9860_regmap);
+	if (IS_ERR(max9860->regmap))
+		return PTR_ERR(max9860->regmap);
+
+	dev_set_drvdata(dev, max9860);
+
+	/*
+	 * mclk has to be in the 10MHz to 60MHz range.
+	 * psclk is used to scale mclk into pclk so that
+	 * pclk is in the 10MHz to 20MHz range.
+	 */
+	ret = max9860_mclk_rate(dev, &mclk_rate);
+	if (ret)
+		return ret;
+
+	if (mclk_rate > 60000000 || mclk_rate < 10000000) {
+		dev_err(dev, "Bad mclk %luHz (needs 10MHz - 60MHz)\n",
+			mclk_rate);
+		return -EINVAL;
+	}
+	if (mclk_rate >= 40000000)
+		max9860->psclk = 3;
+	else if (mclk_rate >= 20000000)
+		max9860->psclk = 2;
+	else
+		max9860->psclk = 1;
+	max9860->pclk_rate = mclk_rate >> (max9860->psclk - 1);
+	max9860->psclk <<= MAX9860_PSCLK_SHIFT;
+	dev_dbg(dev, "mclk %lu pclk %lu\n", mclk_rate, max9860->pclk_rate);
+
+	regcache_cache_bypass(max9860->regmap, true);
+	for (i = 0; i < max9860_regmap.num_reg_defaults; ++i) {
+		ret = regmap_write(max9860->regmap,
+				   max9860_regmap.reg_defaults[i].reg,
+				   max9860_regmap.reg_defaults[i].def);
+		if (ret) {
+			dev_err(dev, "Failed to initialize register %u: %d\n",
+				max9860_regmap.reg_defaults[i].reg, ret);
+			return ret;
+		}
+	}
+	regcache_cache_bypass(max9860->regmap, false);
+
+	ret = regmap_read(max9860->regmap, MAX9860_INTRSTATUS, &intr);
+	if (ret) {
+		dev_err(dev, "Failed to clear INTRSTATUS: %d\n", ret);
+		return ret;
+	}
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_idle(dev);
+
+	ret = snd_soc_register_codec(dev, &max9860_codec_driver,
+				     &max9860_dai, 1);
+	if (ret) {
+		dev_err(dev, "Failed to register CODEC: %d\n", ret);
+		goto err_pm;
+	}
+
+	return 0;
+
+err_pm:
+	pm_runtime_disable(dev);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(max9860_probe);
+
+static int max9860_remove(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+
+	snd_soc_unregister_codec(dev);
+	pm_runtime_disable(dev);
+	return 0;
+}
+
+static const struct i2c_device_id max9860_i2c_id[] = {
+	{ "max9860", },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max9860_i2c_id);
+
+static const struct of_device_id max9860_of_match[] = {
+	{ .compatible = "maxim,max9860", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max9860_of_match);
+
+static struct i2c_driver max9860_i2c_driver = {
+	.probe	        = max9860_probe,
+	.remove         = max9860_remove,
+	.id_table       = max9860_i2c_id,
+	.driver         = {
+		.name           = "max9860",
+		.of_match_table = max9860_of_match,
+		.pm             = &max9860_pm_ops,
+	},
+};
+
+module_i2c_driver(max9860_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC MAX9860 Mono Audio Voice Codec driver");
+MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/max9860.h b/sound/soc/codecs/max9860.h
new file mode 100644
index 000000000000..22041bd67a7d
--- /dev/null
+++ b/sound/soc/codecs/max9860.h
@@ -0,0 +1,162 @@
+/*
+ * Driver for the MAX9860 Mono Audio Voice Codec
+ *
+ * Author: Peter Rosin <peda@axentia.s>
+ *         Copyright 2016 Axentia Technologies
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#ifndef _SND_SOC_MAX9860
+#define _SND_SOC_MAX9860
+
+#define MAX9860_INTRSTATUS   0x00
+#define MAX9860_MICREADBACK  0x01
+#define MAX9860_INTEN        0x02
+#define MAX9860_SYSCLK       0x03
+#define MAX9860_AUDIOCLKHIGH 0x04
+#define MAX9860_AUDIOCLKLOW  0x05
+#define MAX9860_IFC1A        0x06
+#define MAX9860_IFC1B        0x07
+#define MAX9860_VOICEFLTR    0x08
+#define MAX9860_DACATTN      0x09
+#define MAX9860_ADCLEVEL     0x0a
+#define MAX9860_DACGAIN      0x0b
+#define MAX9860_MICGAIN      0x0c
+#define MAX9860_RESERVED     0x0d
+#define MAX9860_MICADC       0x0e
+#define MAX9860_NOISEGATE    0x0f
+#define MAX9860_PWRMAN       0x10
+#define MAX9860_REVISION     0xff
+
+#define MAX9860_MAX_REGISTER 0xff
+
+/* INTRSTATUS */
+#define MAX9860_CLD          0x80
+#define MAX9860_SLD          0x40
+#define MAX9860_ULK          0x20
+
+/* MICREADBACK */
+#define MAX9860_NG           0xe0
+#define MAX9860_AGC          0x1f
+
+/* INTEN */
+#define MAX9860_ICLD         0x80
+#define MAX9860_ISLD         0x40
+#define MAX9860_IULK         0x20
+
+/* SYSCLK */
+#define MAX9860_PSCLK        0x30
+#define MAX9860_PSCLK_OFF    0x00
+#define MAX9860_PSCLK_SHIFT  4
+#define MAX9860_FREQ         0x06
+#define MAX9860_FREQ_NORMAL  0x00
+#define MAX9860_FREQ_12MHZ   0x02
+#define MAX9860_FREQ_13MHZ   0x04
+#define MAX9860_FREQ_19_2MHZ 0x06
+#define MAX9860_16KHZ        0x01
+
+/* AUDIOCLKHIGH */
+#define MAX9860_PLL          0x80
+#define MAX9860_NHI          0x7f
+
+/* AUDIOCLKLOW */
+#define MAX9860_NLO          0xff
+
+/* IFC1A */
+#define MAX9860_MASTER       0x80
+#define MAX9860_WCI          0x40
+#define MAX9860_DBCI         0x20
+#define MAX9860_DDLY         0x10
+#define MAX9860_HIZ          0x08
+#define MAX9860_TDM          0x04
+
+/* IFC1B */
+#define MAX9860_ABCI         0x20
+#define MAX9860_ADLY         0x10
+#define MAX9860_ST           0x08
+#define MAX9860_BSEL         0x07
+#define MAX9860_BSEL_OFF     0x00
+#define MAX9860_BSEL_64X     0x01
+#define MAX9860_BSEL_48X     0x02
+#define MAX9860_BSEL_PCLK_2  0x04
+#define MAX9860_BSEL_PCLK_4  0x05
+#define MAX9860_BSEL_PCLK_8  0x06
+#define MAX9860_BSEL_PCLK_16 0x07
+
+/* VOICEFLTR */
+#define MAX9860_AVFLT        0xf0
+#define MAX9860_AVFLT_SHIFT  4
+#define MAX9860_AVFLT_COUNT  6
+#define MAX9860_DVFLT        0x0f
+#define MAX9860_DVFLT_SHIFT  0
+#define MAX9860_DVFLT_COUNT  6
+
+/* DACATTN */
+#define MAX9860_DVA          0xfe
+#define MAX9860_DVA_SHIFT    1
+#define MAX9860_DVA_MUTE     0x5e
+
+/* ADCLEVEL */
+#define MAX9860_ADCRL        0xf0
+#define MAX9860_ADCRL_SHIFT  4
+#define MAX9860_ADCLL        0x0f
+#define MAX9860_ADCLL_SHIFT  0
+#define MAX9860_ADCxL_MIN    15
+
+/* DACGAIN */
+#define MAX9860_DVG          0x60
+#define MAX9860_DVG_SHIFT    5
+#define MAX9860_DVG_MAX      3
+#define MAX9860_DVST         0x1f
+#define MAX9860_DVST_SHIFT   0
+#define MAX9860_DVST_MIN     31
+
+/* MICGAIN */
+#define MAX9860_PAM          0x60
+#define MAX9860_PAM_SHIFT    5
+#define MAX9860_PAM_MAX      3
+#define MAX9860_PGAM         0x1f
+#define MAX9860_PGAM_SHIFT   0
+#define MAX9860_PGAM_MIN     20
+
+/* MICADC */
+#define MAX9860_AGCSRC       0x80
+#define MAX9860_AGCSRC_SHIFT 7
+#define MAX9860_AGCSRC_COUNT 2
+#define MAX9860_AGCRLS       0x70
+#define MAX9860_AGCRLS_SHIFT 4
+#define MAX9860_AGCRLS_COUNT 8
+#define MAX9860_AGCATK       0x0c
+#define MAX9860_AGCATK_SHIFT 2
+#define MAX9860_AGCATK_COUNT 4
+#define MAX9860_AGCHLD       0x03
+#define MAX9860_AGCHLD_OFF   0x00
+#define MAX9860_AGCHLD_SHIFT 0
+#define MAX9860_AGCHLD_COUNT 4
+
+/* NOISEGATE */
+#define MAX9860_ANTH         0xf0
+#define MAX9860_ANTH_SHIFT   4
+#define MAX9860_ANTH_MAX     15
+#define MAX9860_AGCTH        0x0f
+#define MAX9860_AGCTH_SHIFT  0
+#define MAX9860_AGCTH_MIN    15
+
+/* PWRMAN */
+#define MAX9860_SHDN         0x80
+#define MAX9860_DACEN        0x08
+#define MAX9860_DACEN_SHIFT  3
+#define MAX9860_ADCLEN       0x02
+#define MAX9860_ADCLEN_SHIFT 1
+#define MAX9860_ADCREN       0x01
+#define MAX9860_ADCREN_SHIFT 0
+
+#endif /* _SND_SOC_MAX9860 */
-- 
2.1.4
