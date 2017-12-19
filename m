From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Subject: [alsa-devel][PATCH v7] ASoC: TSCS42xx: Add support for Tempo
 Semiconductor's TSCS42xx audio CODEC
Date: Tue, 19 Dec 2017 14:54:25 -0600
Message-ID: <20171219205415.wlu4atv2mdy7i3gb@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Cc: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Philippe Ombredanne <pombredanne@nexb.com>, Charles Keepax <ckeepax@opensource.cirrus.com>
List-Id: alsa-devel@alsa-project.org

Currently there is no support for TSCS42xx audio CODECs.

Add support for TSCS42xx audio CODECs.

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
---
Thank you to everyone involved in improving this driver.

In the following history I have attempted to address every comment made
during the review process.

History:

 v7:
  - Remove unused D2S mux controls
  - Add coeff_ram_get and coeff_ram_put to COEFF_RAM_CTL
  - Remove get/put arguments from COEFF_RAM_CTL
  - Add Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
 
 v6:
  - Remove leftover TLV stuff
  - Make bytes_ext_info static
  - Make compatible strings for specific devices
  - Change vendor prefix from tscs to tempo
  - Add upper bound to daccrstat reads
  - Reove PLL power up/down from mute callbacks
  - Add PLL DAPM widget
  - Wire up PLL DAPM widget
  - Add comment about why slave is not supported
  - Replace non-standard reg patch with regmap patch
  - Remove empty tscs42xx_remove call back
  - Make I2C ids explicit part numbers
  - Add Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
 
 v5:
  - No change
 
 v4:
  - Add SPDX ids
 
 v3:
  - Remove sysfs interface used to program coefficients
  - Add standard ALSA binary interface for programming coefficients
  - Put Kconfig entry in sorted order
  - Remove dev_info
  - Replace mdelay with msleep
  - Increase granularity of locking
  - Make locking self documenting
  - Remove redundant case in tscs42xx_set_dai_fmt
  - Fix Kernel coding style issue
  - Replace non-standard I2C read/write calls with regmap calls
  - Remove clocking logic
  - Add MCLK1 case
  - Add module_i2c_driver()
 
 v2:
  - Fix email address
 
 v1:
  - Initial patch
 
diffstat:

 .../devicetree/bindings/sound/tscs42xx.txt         |   16 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 MAINTAINERS                                        |    7 +
 sound/soc/codecs/Kconfig                           |    8 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/tscs42xx.c                        | 1456 +++++++++++
 sound/soc/codecs/tscs42xx.h                        | 2693 ++++++++++++++++++++
 7 files changed, 4183 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tscs42xx.txt
 create mode 100644 sound/soc/codecs/tscs42xx.c
 create mode 100644 sound/soc/codecs/tscs42xx.h

diff --git a/Documentation/devicetree/bindings/sound/tscs42xx.txt b/Documentation/devicetree/bindings/sound/tscs42xx.txt
new file mode 100644
index 000000000000..2ac2f0996697
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tscs42xx.txt
@@ -0,0 +1,16 @@
+TSCS42XX Audio CODEC
+
+Required Properties:
+
+	- compatible :	"tempo,tscs42A1" for analog mic
+			"tempo,tscs42A2" for digital mic
+
+	- reg : 	<0x71> for analog mic
+			<0x69> for digital mic
+
+Example:
+
+wookie: codec@69 {
+	compatible = "tempo,tscs42A2";
+	reg = <0x69>;
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 19e1ef73ab0d..4543e688c5d4 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -54,6 +54,7 @@ snps 	Synopsys, Inc.
 st	STMicroelectronics
 ste	ST-Ericsson
 stericsson	ST-Ericsson
+tempo	Tempo Semiconductor
 ti	Texas Instruments
 toshiba	Toshiba Corporation
 via	VIA Technologies, Inc.
diff --git a/MAINTAINERS b/MAINTAINERS
index 8bdd7a7ef2f4..6c9adfcbc7a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8094,6 +8094,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git
 S:	Maintained
 K:	^Subject:.*(?i)trivial
 
+TEMPO SEMICONDUCTOR DRIVERS
+M:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+S:	Maintained
+F:	sound/soc/codecs/tscs*.c
+F:	sound/soc/codecs/tscs*.h
+F:	Documentation/devicetree/bindings/sound/tscs*.txt
+
 TTY LAYER
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Jiri Slaby <jslaby@suse.cz>
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 45b72561c615..dcedfaa2c94d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -69,6 +69,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TLV320AIC3X if I2C
 	select SND_SOC_TPA6130A2 if I2C
 	select SND_SOC_TLV320DAC33 if I2C
+	select SND_SOC_TSCS42XX if I2C
 	select SND_SOC_TWL4030 if TWL4030_CORE
 	select SND_SOC_TWL6040 if TWL6040_CORE
 	select SND_SOC_UDA134X
@@ -336,6 +337,13 @@ config SND_SOC_TLV320AIC3X
 config SND_SOC_TLV320DAC33
 	tristate
 
+config SND_SOC_TSCS42XX
+	tristate "Tempo Semiconductor TSCS42xx CODEC"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Add support for Tempo Semiconductor's TSCS42xx audio CODEC.
+
 config SND_SOC_TWL4030
 	select MFD_TWL4030_AUDIO
 	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 6a3b3c3b8b41..2d42710a6bc2 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -60,6 +60,7 @@ snd-soc-tlv320aic26-objs := tlv320aic26.o
 snd-soc-tlv320aic3x-objs := tlv320aic3x.o
 snd-soc-tlv320aic32x4-objs := tlv320aic32x4.o
 snd-soc-tlv320dac33-objs := tlv320dac33.o
+snd-soc-tscs42xx-objs := tscs42xx.o
 snd-soc-twl4030-objs := twl4030.o
 snd-soc-twl6040-objs := twl6040.o
 snd-soc-uda134x-objs := uda134x.o
@@ -182,6 +183,7 @@ obj-$(CONFIG_SND_SOC_TLV320AIC26)	+= snd-soc-tlv320aic26.o
 obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
 obj-$(CONFIG_SND_SOC_TLV320AIC32X4)     += snd-soc-tlv320aic32x4.o
 obj-$(CONFIG_SND_SOC_TLV320DAC33)	+= snd-soc-tlv320dac33.o
+obj-$(CONFIG_SND_SOC_TSCS42XX)	+= snd-soc-tscs42xx.o
 obj-$(CONFIG_SND_SOC_TWL4030)	+= snd-soc-twl4030.o
 obj-$(CONFIG_SND_SOC_TWL6040)	+= snd-soc-twl6040.o
 obj-$(CONFIG_SND_SOC_UDA134X)	+= snd-soc-uda134x.o
diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
new file mode 100644
index 000000000000..eedd600875e5
--- /dev/null
+++ b/sound/soc/codecs/tscs42xx.c
@@ -0,0 +1,1456 @@
+// SPDX-License-Identifier: GPL-2.0
+// tscs42xx.c -- TSCS42xx ALSA SoC Audio driver
+// Copyright 2017 Tempo Semiconductor, Inc.
+// Author: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/tlv.h>
+
+#include "tscs42xx.h"
+
+#define COEFF_SIZE 3
+#define BIQUAD_COEFF_COUNT 5
+#define BIQUAD_SIZE (COEFF_SIZE * BIQUAD_COEFF_COUNT)
+
+#define COEFF_RAM_MAX_ADDR 0xcd
+#define COEFF_RAM_COEFF_COUNT (COEFF_RAM_MAX_ADDR + 1)
+#define COEFF_RAM_SIZE (COEFF_SIZE * COEFF_RAM_COEFF_COUNT)
+
+struct tscs42xx {
+
+	int bclk_ratio;
+	int samplerate;
+	unsigned int blrcm;
+	struct mutex audio_params_lock;
+
+	u8 coeff_ram[COEFF_RAM_SIZE];
+	bool coeff_ram_synced;
+	struct mutex coeff_ram_lock;
+
+	struct mutex pll_lock;
+
+	struct regmap *regmap;
+
+	struct device *dev;
+};
+
+struct coeff_ram_ctl {
+	unsigned int addr;
+	struct soc_bytes_ext bytes_ext;
+};
+
+static bool tscs42xx_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case R_DACCRWRL:
+	case R_DACCRWRM:
+	case R_DACCRWRH:
+	case R_DACCRRDL:
+	case R_DACCRRDM:
+	case R_DACCRRDH:
+	case R_DACCRSTAT:
+	case R_DACCRADDR:
+	case R_PLLCTL0:
+		return true;
+	default:
+		return false;
+	};
+}
+
+static bool tscs42xx_precious(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case R_DACCRWRL:
+	case R_DACCRWRM:
+	case R_DACCRWRH:
+	case R_DACCRRDL:
+	case R_DACCRRDM:
+	case R_DACCRRDH:
+		return true;
+	default:
+		return false;
+	};
+}
+
+static const struct regmap_config tscs42xx_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.volatile_reg = tscs42xx_volatile,
+	.precious_reg = tscs42xx_precious,
+	.max_register = R_DACMBCREL3H,
+
+	.cache_type = REGCACHE_RBTREE,
+	.can_multi_write = true,
+};
+
+#define MAX_PLL_LOCK_20MS_WAITS 1
+static bool plls_locked(struct snd_soc_codec *codec)
+{
+	int ret;
+	int count = MAX_PLL_LOCK_20MS_WAITS;
+
+	do {
+		ret = snd_soc_read(codec, R_PLLCTL0);
+		if (ret < 0) {
+			dev_err(codec->dev,
+				"Failed to read PLL lock status (%d)\n", ret);
+			return false;
+		} else if (ret > 0) {
+			return true;
+		}
+		msleep(20);
+	} while (count--);
+
+	return false;
+}
+
+static int sample_rate_to_pll_freq_out(int sample_rate)
+{
+	switch (sample_rate) {
+	case 11025:
+	case 22050:
+	case 44100:
+	case 88200:
+		return 112896000;
+	case 8000:
+	case 16000:
+	case 32000:
+	case 48000:
+	case 96000:
+		return 122880000;
+	default:
+		return -EINVAL;
+	}
+}
+
+#define DACCRSTAT_MAX_TRYS 10
+static int write_coeff_ram(struct snd_soc_codec *codec, u8 *coeff_ram,
+	unsigned int addr, unsigned int coeff_cnt)
+{
+	struct tscs42xx *tscs42xx = snd_soc_codec_get_drvdata(codec);
+	int cnt;
+	int trys;
+	int ret;
+
+	for (cnt = 0; cnt < coeff_cnt; cnt++, addr++) {
+
+		for (trys = 0; trys < DACCRSTAT_MAX_TRYS; trys++) {
+			ret = snd_soc_read(codec, R_DACCRSTAT);
+			if (ret < 0) {
+				dev_err(codec->dev,
+					"Failed to read stat (%d)\n", ret);
+				return ret;
+			}
+			if (!ret)
+				break;
+		}
+
+		if (trys == DACCRSTAT_MAX_TRYS) {
+			ret = -EIO;
+			dev_err(codec->dev,
+				"dac coefficient write error (%d)\n", ret);
+			return ret;
+		}
+
+		ret = regmap_write(tscs42xx->regmap, R_DACCRADDR, addr);
+		if (ret < 0) {
+			dev_err(codec->dev,
+				"Failed to write dac ram address (%d)\n", ret);
+			return ret;
+		}
+
+		ret = regmap_bulk_write(tscs42xx->regmap, R_DACCRWRL,
+			&coeff_ram[addr * COEFF_SIZE],
+			COEFF_SIZE);
+		if (ret < 0) {
+			dev_err(codec->dev,
+				"Failed to write dac ram (%d)\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int power_up_audio_plls(struct snd_soc_codec *codec)
+{
+	struct tscs42xx *tscs42xx = snd_soc_codec_get_drvdata(codec);
+	int freq_out;
+	int ret;
+	unsigned int mask;
+	unsigned int val;
+
+	freq_out = sample_rate_to_pll_freq_out(tscs42xx->samplerate);
+	switch (freq_out) {
+	case 122880000: /* 48k */
+		mask = RM_PLLCTL1C_PDB_PLL1;
+		val = RV_PLLCTL1C_PDB_PLL1_ENABLE;
+		break;
+	case 112896000: /* 44.1k */
+		mask = RM_PLLCTL1C_PDB_PLL2;
+		val = RV_PLLCTL1C_PDB_PLL2_ENABLE;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(codec->dev, "Unrecognized PLL output freq (%d)\n", ret);
+		return ret;
+	}
+
+	mutex_lock(&tscs42xx->pll_lock);
+
+	ret = snd_soc_update_bits(codec, R_PLLCTL1C, mask, val);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to turn PLL on (%d)\n", ret);
+		goto exit;
+	}
+
+	if (!plls_locked(codec)) {
+		dev_err(codec->dev, "Failed to lock plls\n");
+		ret = -ENOMSG;
+		goto exit;
+	}
+
+	ret = 0;
+exit:
+	mutex_unlock(&tscs42xx->pll_lock);
+
+	return ret;
+}
+
+static int power_down_audio_plls(struct snd_soc_codec *codec)
+{
+	struct tscs42xx *tscs42xx = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	mutex_lock(&tscs42xx->pll_lock);
+
+	ret = snd_soc_update_bits(codec, R_PLLCTL1C,
+			RM_PLLCTL1C_PDB_PLL1,
+			RV_PLLCTL1C_PDB_PLL1_DISABLE);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to turn PLL off (%d)\n", ret);
+		goto exit;
+	}
+	ret = snd_soc_update_bits(codec, R_PLLCTL1C,
+			RM_PLLCTL1C_PDB_PLL2,
+			RV_PLLCTL1C_PDB_PLL2_DISABLE);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to turn PLL off (%d)\n", ret);
+		goto exit;
+	}
+
+	ret = 0;
+exit:
+	mutex_unlock(&tscs42xx->pll_lock);
+
+	return ret;
+}
+
+static int coeff_ram_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct tscs42xx *tscs42xx = snd_soc_codec_get_drvdata(codec);
+	struct coeff_ram_ctl *ctl =
+		(struct coeff_ram_ctl *)kcontrol->private_value;
+	struct soc_bytes_ext *params = &ctl->bytes_ext;
+
+	mutex_lock(&tscs42xx->coeff_ram_lock);
+
+	memcpy(ucontrol->value.bytes.data,
+		&tscs42xx->coeff_ram[ctl->addr * COEFF_SIZE], params->max);
+
+	mutex_unlock(&tscs42xx->coeff_ram_lock);
+
+	return 0;
+}
+
+static int coeff_ram_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct tscs42xx *tscs42xx = snd_soc_codec_get_drvdata(codec);
+	struct coeff_ram_ctl *ctl =
+		(struct coeff_ram_ctl *)kcontrol->private_value;
+	struct soc_bytes_ext *params = &ctl->bytes_ext;
+	unsigned int coeff_cnt = params->max / COEFF_SIZE;
+	int ret;
+
+	mutex_lock(&tscs42xx->coeff_ram_lock);
+
+	tscs42xx->coeff_ram_synced = false;
+
+	memcpy(&tscs42xx->coeff_ram[ctl->addr * COEFF_SIZE],
+		ucontrol->value.bytes.data, params->max);
+
+	mutex_lock(&tscs42xx->pll_lock);
+
+	if (plls_locked(codec)) {
+		ret = write_coeff_ram(codec, tscs42xx->coeff_ram,
+			ctl->addr, coeff_cnt);
+		if (ret < 0) {
+			dev_err(codec->dev,
+				"Failed to flush coeff ram cache (%d)\n", ret);
+			goto exit;
+		}
+		tscs42xx->coeff_ram_synced = true;
+	}
+
+	ret = 0;
+exit:
+	mutex_unlock(&tscs42xx->pll_lock);
+
+	mutex_unlock(&tscs42xx->coeff_ram_lock);
+
+	return ret;
+}
+
+/* Input L Capture Route */
+static char const * const input_select_text[] = {
+	"Line 1", "Line 2", "Line 3", "D2S"
+};
+
+static const struct soc_enum left_input_select_enum =
+SOC_ENUM_SINGLE(R_INSELL, FB_INSELL, ARRAY_SIZE(input_select_text),
+		input_select_text);
+
+static const struct snd_kcontrol_new left_input_select =
+SOC_DAPM_ENUM("LEFT_INPUT_SELECT_ENUM", left_input_select_enum);
+
+/* Input R Capture Route */
+static const struct soc_enum right_input_select_enum =
+SOC_ENUM_SINGLE(R_INSELR, FB_INSELR, ARRAY_SIZE(input_select_text),
+		input_select_text);
+
+static const struct snd_kcontrol_new right_input_select =
+SOC_DAPM_ENUM("RIGHT_INPUT_SELECT_ENUM", right_input_select_enum);
+
+/* Input Channel Mapping */
+static char const * const ch_map_select_text[] = {
+	"Normal", "Left to Right", "Right to Left", "Swap"
+};
+
+static const struct soc_enum ch_map_select_enum =
+SOC_ENUM_SINGLE(R_AIC2, FB_AIC2_ADCDSEL, ARRAY_SIZE(ch_map_select_text),
+		ch_map_select_text);
+
+static int dapm_vref_event(struct snd_soc_dapm_widget *w,
+			 struct snd_kcontrol *kcontrol, int event)
+{
+	msleep(20);
+	return 0;
+}
+
+static int dapm_micb_event(struct snd_soc_dapm_widget *w,
+			 struct snd_kcontrol *kcontrol, int event)
+{
+	msleep(20);
+	return 0;
+}
+
+int pll_event(struct snd_soc_dapm_widget *w,
+		   struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	int ret;
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		ret = power_up_audio_plls(codec);
+	else
+		ret = power_down_audio_plls(codec);
+
+	return ret;
+}
+
+int dac_event(struct snd_soc_dapm_widget *w,
+		   struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct tscs42xx *tscs42xx = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	mutex_lock(&tscs42xx->coeff_ram_lock);
+
+	if (tscs42xx->coeff_ram_synced == false) {
+		ret = write_coeff_ram(codec, tscs42xx->coeff_ram, 0x00,
+			COEFF_RAM_COEFF_COUNT);
+		if (ret < 0)
+			goto exit;
+		tscs42xx->coeff_ram_synced = true;
+	}
+
+	ret = 0;
+exit:
+	mutex_unlock(&tscs42xx->coeff_ram_lock);
+
+	return ret;
+}
+
+static const struct snd_soc_dapm_widget tscs42xx_dapm_widgets[] = {
+	/* Vref */
+	SND_SOC_DAPM_SUPPLY_S("Vref", 1, R_PWRM2, FB_PWRM2_VREF, 0,
+		dapm_vref_event, SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_PRE_PMD),
+
+	/* PLL */
+	SND_SOC_DAPM_SUPPLY("PLL", SND_SOC_NOPM, 0, 0, pll_event,
+		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	/* Headphone */
+	SND_SOC_DAPM_DAC_E("DAC L", "HiFi Playback", R_PWRM2, FB_PWRM2_HPL, 0,
+			dac_event, SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_DAC_E("DAC R", "HiFi Playback", R_PWRM2, FB_PWRM2_HPR, 0,
+			dac_event, SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_OUTPUT("Headphone L"),
+	SND_SOC_DAPM_OUTPUT("Headphone R"),
+
+	/* Speaker */
+	SND_SOC_DAPM_DAC_E("ClassD L", "HiFi Playback",
+		R_PWRM2, FB_PWRM2_SPKL, 0,
+		dac_event, SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_DAC_E("ClassD R", "HiFi Playback",
+		R_PWRM2, FB_PWRM2_SPKR, 0,
+		dac_event, SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_OUTPUT("Speaker L"),
+	SND_SOC_DAPM_OUTPUT("Speaker R"),
+
+	/* Capture */
+	SND_SOC_DAPM_PGA("Analog In PGA L", R_PWRM1, FB_PWRM1_PGAL, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Analog In PGA R", R_PWRM1, FB_PWRM1_PGAR, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Analog Boost L", R_PWRM1, FB_PWRM1_BSTL, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Analog Boost R", R_PWRM1, FB_PWRM1_BSTR, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("ADC Mute", R_CNVRTR0, FB_CNVRTR0_HPOR, true, NULL, 0),
+	SND_SOC_DAPM_ADC("ADC L", "HiFi Capture", R_PWRM1, FB_PWRM1_ADCL, 0),
+	SND_SOC_DAPM_ADC("ADC R", "HiFi Capture", R_PWRM1, FB_PWRM1_ADCR, 0),
+
+	/* Capture Input */
+	SND_SOC_DAPM_MUX("Input L Capture Route", R_PWRM2,
+			FB_PWRM2_INSELL, 0, &left_input_select),
+	SND_SOC_DAPM_MUX("Input R Capture Route", R_PWRM2,
+			FB_PWRM2_INSELR, 0, &right_input_select),
+
+	/* Digital Mic */
+	SND_SOC_DAPM_SUPPLY_S("Digital Mic Enable", 2, R_DMICCTL,
+		FB_DMICCTL_DMICEN, 0, NULL,
+		SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_PRE_PMD),
+
+	/* Analog Mic */
+	SND_SOC_DAPM_SUPPLY_S("Mic Bias", 2, R_PWRM1, FB_PWRM1_MICB,
+		0, dapm_micb_event, SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_PRE_PMD),
+
+	/* Line In */
+	SND_SOC_DAPM_INPUT("Line In 1 L"),
+	SND_SOC_DAPM_INPUT("Line In 1 R"),
+	SND_SOC_DAPM_INPUT("Line In 2 L"),
+	SND_SOC_DAPM_INPUT("Line In 2 R"),
+	SND_SOC_DAPM_INPUT("Line In 3 L"),
+	SND_SOC_DAPM_INPUT("Line In 3 R"),
+};
+
+static const struct snd_soc_dapm_route tscs42xx_intercon[] = {
+	{"DAC L", NULL, "PLL"},
+	{"DAC R", NULL, "PLL"},
+	{"DAC L", NULL, "Vref"},
+	{"DAC R", NULL, "Vref"},
+	{"Headphone L", NULL, "DAC L"},
+	{"Headphone R", NULL, "DAC R"},
+
+	{"ClassD L", NULL, "PLL"},
+	{"ClassD R", NULL, "PLL"},
+	{"ClassD L", NULL, "Vref"},
+	{"ClassD R", NULL, "Vref"},
+	{"Speaker L", NULL, "ClassD L"},
+	{"Speaker R", NULL, "ClassD R"},
+
+	{"Input L Capture Route", NULL, "Vref"},
+	{"Input R Capture Route", NULL, "Vref"},
+
+	{"Mic Bias", NULL, "Vref"},
+
+	{"Input L Capture Route", "Line 1", "Line In 1 L"},
+	{"Input R Capture Route", "Line 1", "Line In 1 R"},
+	{"Input L Capture Route", "Line 2", "Line In 2 L"},
+	{"Input R Capture Route", "Line 2", "Line In 2 R"},
+	{"Input L Capture Route", "Line 3", "Line In 3 L"},
+	{"Input R Capture Route", "Line 3", "Line In 3 R"},
+
+	{"Analog In PGA L", NULL, "Input L Capture Route"},
+	{"Analog In PGA R", NULL, "Input R Capture Route"},
+	{"Analog Boost L", NULL, "Analog In PGA L"},
+	{"Analog Boost R", NULL, "Analog In PGA R"},
+	{"ADC Mute", NULL, "Analog Boost L"},
+	{"ADC Mute", NULL, "Analog Boost R"},
+	{"ADC L", NULL, "PLL"},
+	{"ADC R", NULL, "PLL"},
+	{"ADC L", NULL, "ADC Mute"},
+	{"ADC R", NULL, "ADC Mute"},
+};
+
+/************
+ * CONTROLS *
+ ************/
+
+static char const * const eq_band_enable_text[] = {
+	"Prescale only",
+	"Band1",
+	"Band1:2",
+	"Band1:3",
+	"Band1:4",
+	"Band1:5",
+	"Band1:6",
+};
+
+static char const * const level_detection_text[] = {
+	"Average",
+	"Peak",
+};
+
+static char const * const level_detection_window_text[] = {
+	"512 Samples",
+	"64 Samples",
+};
+
+static char const * const compressor_ratio_text[] = {
+	"Reserved", "1.5:1", "2:1", "3:1", "4:1", "5:1", "6:1",
+	"7:1", "8:1", "9:1", "10:1", "11:1", "12:1", "13:1", "14:1",
+	"15:1", "16:1", "17:1", "18:1", "19:1", "20:1",
+};
+
+static DECLARE_TLV_DB_SCALE(hpvol_scale, -8850, 75, 0);
+static DECLARE_TLV_DB_SCALE(spkvol_scale, -7725, 75, 0);
+static DECLARE_TLV_DB_SCALE(dacvol_scale, -9563, 38, 0);
+static DECLARE_TLV_DB_SCALE(adcvol_scale, -7125, 38, 0);
+static DECLARE_TLV_DB_SCALE(invol_scale, -1725, 75, 0);
+static DECLARE_TLV_DB_SCALE(mic_boost_scale, 0, 1000, 0);
+static DECLARE_TLV_DB_MINMAX(mugain_scale, 0, 4650);
+static DECLARE_TLV_DB_MINMAX(compth_scale, -9562, 0);
+
+static const struct soc_enum eq1_band_enable_enum =
+	SOC_ENUM_SINGLE(R_CONFIG1, FB_CONFIG1_EQ1_BE,
+		ARRAY_SIZE(eq_band_enable_text), eq_band_enable_text);
+
+static const struct soc_enum eq2_band_enable_enum =
+	SOC_ENUM_SINGLE(R_CONFIG1, FB_CONFIG1_EQ2_BE,
+		ARRAY_SIZE(eq_band_enable_text), eq_band_enable_text);
+
+static const struct soc_enum cle_level_detection_enum =
+	SOC_ENUM_SINGLE(R_CLECTL, FB_CLECTL_LVL_MODE,
+		ARRAY_SIZE(level_detection_text),
+		level_detection_text);
+
+static const struct soc_enum cle_level_detection_window_enum =
+	SOC_ENUM_SINGLE(R_CLECTL, FB_CLECTL_WINDOWSEL,
+		ARRAY_SIZE(level_detection_window_text),
+		level_detection_window_text);
+
+static const struct soc_enum mbc_level_detection_enums[] = {
+	SOC_ENUM_SINGLE(R_DACMBCCTL, FB_DACMBCCTL_LVLMODE1,
+		ARRAY_SIZE(level_detection_text),
+			level_detection_text),
+	SOC_ENUM_SINGLE(R_DACMBCCTL, FB_DACMBCCTL_LVLMODE2,
+		ARRAY_SIZE(level_detection_text),
+			level_detection_text),
+	SOC_ENUM_SINGLE(R_DACMBCCTL, FB_DACMBCCTL_LVLMODE3,
+		ARRAY_SIZE(level_detection_text),
+			level_detection_text),
+};
+
+static const struct soc_enum mbc_level_detection_window_enums[] = {
+	SOC_ENUM_SINGLE(R_DACMBCCTL, FB_DACMBCCTL_WINSEL1,
+		ARRAY_SIZE(level_detection_window_text),
+			level_detection_window_text),
+	SOC_ENUM_SINGLE(R_DACMBCCTL, FB_DACMBCCTL_WINSEL2,
+		ARRAY_SIZE(level_detection_window_text),
+			level_detection_window_text),
+	SOC_ENUM_SINGLE(R_DACMBCCTL, FB_DACMBCCTL_WINSEL3,
+		ARRAY_SIZE(level_detection_window_text),
+			level_detection_window_text),
+};
+
+static const struct soc_enum compressor_ratio_enum =
+	SOC_ENUM_SINGLE(R_CMPRAT, FB_CMPRAT,
+		ARRAY_SIZE(compressor_ratio_text), compressor_ratio_text);
+
+static const struct soc_enum dac_mbc1_compressor_ratio_enum =
+	SOC_ENUM_SINGLE(R_DACMBCRAT1, FB_DACMBCRAT1_RATIO,
+		ARRAY_SIZE(compressor_ratio_text), compressor_ratio_text);
+
+static const struct soc_enum dac_mbc2_compressor_ratio_enum =
+	SOC_ENUM_SINGLE(R_DACMBCRAT2, FB_DACMBCRAT2_RATIO,
+		ARRAY_SIZE(compressor_ratio_text), compressor_ratio_text);
+
+static const struct soc_enum dac_mbc3_compressor_ratio_enum =
+	SOC_ENUM_SINGLE(R_DACMBCRAT3, FB_DACMBCRAT3_RATIO,
+		ARRAY_SIZE(compressor_ratio_text), compressor_ratio_text);
+
+static int bytes_info_ext(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *ucontrol)
+{
+	struct coeff_ram_ctl *ctl =
+		(struct coeff_ram_ctl *)kcontrol->private_value;
+	struct soc_bytes_ext *params = &ctl->bytes_ext;
+
+	ucontrol->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	ucontrol->count = params->max;
+
+	return 0;
+}
+
+#define COEFF_RAM_CTL(xname, xcount, xaddr) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = bytes_info_ext, \
+	.get = coeff_ram_get, .put = coeff_ram_put, \
+	.private_value = (unsigned long)&(struct coeff_ram_ctl) { \
+		.addr = xaddr, \
+		.bytes_ext = {.max = xcount, }, \
+	} \
+}
+
+static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
+	/* Volumes */
+	SOC_DOUBLE_R_TLV("Headphone Playback Volume", R_HPVOLL, R_HPVOLR,
+			FB_HPVOLL, 0x7F, 0, hpvol_scale),
+	SOC_DOUBLE_R_TLV("Speaker Playback Volume", R_SPKVOLL, R_SPKVOLR,
+			FB_SPKVOLL, 0x7F, 0, spkvol_scale),
+	SOC_DOUBLE_R_TLV("Master Playback Volume", R_DACVOLL, R_DACVOLR,
+			FB_DACVOLL, 0xFF, 0, dacvol_scale),
+	SOC_DOUBLE_R_TLV("PCM Capture Volume", R_ADCVOLL, R_ADCVOLR,
+			FB_ADCVOLL, 0xFF, 0, adcvol_scale),
+	SOC_DOUBLE_R_TLV("Master Capture Volume", R_INVOLL, R_INVOLR,
+			FB_INVOLL, 0x3F, 0, invol_scale),
+
+	/* INSEL */
+	SOC_DOUBLE_R_TLV("Mic Boost Capture Volume", R_INSELL, R_INSELR,
+			FB_INSELL_MICBSTL, FV_INSELL_MICBSTL_30DB,
+			0, mic_boost_scale),
+
+	/* Input Channel Map */
+	SOC_ENUM("Input Channel Map Switch", ch_map_select_enum),
+
+	/* Coefficient Ram */
+	COEFF_RAM_CTL("Cascade1L BiQuad1", BIQUAD_SIZE, 0x00),
+	COEFF_RAM_CTL("Cascade1L BiQuad2", BIQUAD_SIZE, 0x05),
+	COEFF_RAM_CTL("Cascade1L BiQuad3", BIQUAD_SIZE, 0x0a),
+	COEFF_RAM_CTL("Cascade1L BiQuad4", BIQUAD_SIZE, 0x0f),
+	COEFF_RAM_CTL("Cascade1L BiQuad5", BIQUAD_SIZE, 0x14),
+	COEFF_RAM_CTL("Cascade1L BiQuad6", BIQUAD_SIZE, 0x19),
+
+	COEFF_RAM_CTL("Cascade1R BiQuad1", BIQUAD_SIZE, 0x20),
+	COEFF_RAM_CTL("Cascade1R BiQuad2", BIQUAD_SIZE, 0x25),
+	COEFF_RAM_CTL("Cascade1R BiQuad3", BIQUAD_SIZE, 0x2a),
+	COEFF_RAM_CTL("Cascade1R BiQuad4", BIQUAD_SIZE, 0x2f),
+	COEFF_RAM_CTL("Cascade1R BiQuad5", BIQUAD_SIZE, 0x34),
+	COEFF_RAM_CTL("Cascade1R BiQuad6", BIQUAD_SIZE, 0x39),
+
+	COEFF_RAM_CTL("Cascade1L Prescale", COEFF_SIZE, 0x1f),
+	COEFF_RAM_CTL("Cascade1R Prescale", COEFF_SIZE, 0x3f),
+
+	COEFF_RAM_CTL("Cascade2L BiQuad1", BIQUAD_SIZE, 0x40),
+	COEFF_RAM_CTL("Cascade2L BiQuad2", BIQUAD_SIZE, 0x45),
+	COEFF_RAM_CTL("Cascade2L BiQuad3", BIQUAD_SIZE, 0x4a),
+	COEFF_RAM_CTL("Cascade2L BiQuad4", BIQUAD_SIZE, 0x4f),
+	COEFF_RAM_CTL("Cascade2L BiQuad5", BIQUAD_SIZE, 0x54),
+	COEFF_RAM_CTL("Cascade2L BiQuad6", BIQUAD_SIZE, 0x59),
+
+	COEFF_RAM_CTL("Cascade2R BiQuad1", BIQUAD_SIZE, 0x60),
+	COEFF_RAM_CTL("Cascade2R BiQuad2", BIQUAD_SIZE, 0x65),
+	COEFF_RAM_CTL("Cascade2R BiQuad3", BIQUAD_SIZE, 0x6a),
+	COEFF_RAM_CTL("Cascade2R BiQuad4", BIQUAD_SIZE, 0x6f),
+	COEFF_RAM_CTL("Cascade2R BiQuad5", BIQUAD_SIZE, 0x74),
+	COEFF_RAM_CTL("Cascade2R BiQuad6", BIQUAD_SIZE, 0x79),
+
+	COEFF_RAM_CTL("Cascade2L Prescale", COEFF_SIZE, 0x5f),
+	COEFF_RAM_CTL("Cascade2R Prescale", COEFF_SIZE, 0x7f),
+
+	COEFF_RAM_CTL("Bass Extraction BiQuad1", BIQUAD_SIZE, 0x80),
+	COEFF_RAM_CTL("Bass Extraction BiQuad2", BIQUAD_SIZE, 0x85),
+
+	COEFF_RAM_CTL("Bass Non Linear Function 1", COEFF_SIZE, 0x8a),
+	COEFF_RAM_CTL("Bass Non Linear Function 2", COEFF_SIZE, 0x8b),
+
+	COEFF_RAM_CTL("Bass Limiter BiQuad", BIQUAD_SIZE, 0x8c),
+
+	COEFF_RAM_CTL("Bass Cut Off BiQuad", BIQUAD_SIZE, 0x91),
+
+	COEFF_RAM_CTL("Bass Mix", COEFF_SIZE, 0x96),
+
+	COEFF_RAM_CTL("Treb Extraction BiQuad1", BIQUAD_SIZE, 0x97),
+	COEFF_RAM_CTL("Treb Extraction BiQuad2", BIQUAD_SIZE, 0x9c),
+
+	COEFF_RAM_CTL("Treb Non Linear Function 1", COEFF_SIZE, 0xa1),
+	COEFF_RAM_CTL("Treb Non Linear Function 2", COEFF_SIZE, 0xa2),
+
+	COEFF_RAM_CTL("Treb Limiter BiQuad", BIQUAD_SIZE, 0xa3),
+
+	COEFF_RAM_CTL("Treb Cut Off BiQuad", BIQUAD_SIZE, 0xa8),
+
+	COEFF_RAM_CTL("Treb Mix", COEFF_SIZE, 0xad),
+
+	COEFF_RAM_CTL("3D", COEFF_SIZE, 0xae),
+
+	COEFF_RAM_CTL("3D Mix", COEFF_SIZE, 0xaf),
+
+	COEFF_RAM_CTL("MBC1 BiQuad1", BIQUAD_SIZE, 0xb0),
+	COEFF_RAM_CTL("MBC1 BiQuad2", BIQUAD_SIZE, 0xb5),
+
+	COEFF_RAM_CTL("MBC2 BiQuad1", BIQUAD_SIZE, 0xba),
+	COEFF_RAM_CTL("MBC2 BiQuad2", BIQUAD_SIZE, 0xbf),
+
+	COEFF_RAM_CTL("MBC3 BiQuad1", BIQUAD_SIZE, 0xc4),
+	COEFF_RAM_CTL("MBC3 BiQuad2", BIQUAD_SIZE, 0xc9),
+
+	/* EQ */
+	SOC_SINGLE("EQ1 Switch", R_CONFIG1, FB_CONFIG1_EQ1_EN, 1, 0),
+	SOC_SINGLE("EQ2 Switch", R_CONFIG1, FB_CONFIG1_EQ2_EN, 1, 0),
+	SOC_ENUM("EQ1 Band Enable Switch", eq1_band_enable_enum),
+	SOC_ENUM("EQ2 Band Enable Switch", eq2_band_enable_enum),
+
+	/* CLE */
+	SOC_ENUM("CLE Level Detect Switch",
+		cle_level_detection_enum),
+	SOC_ENUM("CLE Level Detect Win Switch",
+		cle_level_detection_window_enum),
+	SOC_SINGLE("Expander Switch",
+		R_CLECTL, FB_CLECTL_EXP_EN, 1, 0),
+	SOC_SINGLE("Limiter Switch",
+		R_CLECTL, FB_CLECTL_LIMIT_EN, 1, 0),
+	SOC_SINGLE("Comp Switch",
+		R_CLECTL, FB_CLECTL_COMP_EN, 1, 0),
+	SOC_SINGLE_TLV("CLE Make-Up Gain Playback Volume",
+		R_MUGAIN, FB_MUGAIN_CLEMUG, 0x1f, 0, mugain_scale),
+	SOC_SINGLE_TLV("Comp Thresh Playback Volume",
+		R_COMPTH, FB_COMPTH, 0xff, 0, compth_scale),
+	SOC_ENUM("Comp Ratio Switch", compressor_ratio_enum),
+	SND_SOC_BYTES("Comp Atk Time", R_CATKTCL, 2),
+
+	/* Effects */
+	SOC_SINGLE("3D Switch", R_FXCTL, FB_FXCTL_3DEN, 1, 0),
+	SOC_SINGLE("Treble Switch", R_FXCTL, FB_FXCTL_TEEN, 1, 0),
+	SOC_SINGLE("Treble Bypass Switch", R_FXCTL, FB_FXCTL_TNLFBYPASS, 1, 0),
+	SOC_SINGLE("Bass Switch", R_FXCTL, FB_FXCTL_BEEN, 1, 0),
+	SOC_SINGLE("Bass Bypass Switch", R_FXCTL, FB_FXCTL_BNLFBYPASS, 1, 0),
+
+	/* MBC */
+	SOC_SINGLE("MBC Band1 Switch", R_DACMBCEN, FB_DACMBCEN_MBCEN1, 1, 0),
+	SOC_SINGLE("MBC Band2 Switch", R_DACMBCEN, FB_DACMBCEN_MBCEN2, 1, 0),
+	SOC_SINGLE("MBC Band3 Switch", R_DACMBCEN, FB_DACMBCEN_MBCEN3, 1, 0),
+	SOC_ENUM("MBC Band1 Level Detect Switch",
+		mbc_level_detection_enums[0]),
+	SOC_ENUM("MBC Band2 Level Detect Switch",
+		mbc_level_detection_enums[1]),
+	SOC_ENUM("MBC Band3 Level Detect Switch",
+		mbc_level_detection_enums[2]),
+	SOC_ENUM("MBC Band1 Level Detect Win Switch",
+		mbc_level_detection_window_enums[0]),
+	SOC_ENUM("MBC Band2 Level Detect Win Switch",
+		mbc_level_detection_window_enums[1]),
+	SOC_ENUM("MBC Band3 Level Detect Win Switch",
+		mbc_level_detection_window_enums[2]),
+
+	SOC_SINGLE("MBC1 Phase Invert", R_DACMBCMUG1, FB_DACMBCMUG1_PHASE,
+		1, 0),
+	SOC_SINGLE_TLV("DAC MBC1 Make-Up Gain Playback Volume",
+		R_DACMBCMUG1, FB_DACMBCMUG1_MUGAIN, 0x1f, 0, mugain_scale),
+	SOC_SINGLE_TLV("DAC MBC1 Comp Thresh Playback Volume",
+		R_DACMBCTHR1, FB_DACMBCTHR1_THRESH, 0xff, 0, compth_scale),
+	SOC_ENUM("DAC MBC1 Comp Ratio Switch",
+		dac_mbc1_compressor_ratio_enum),
+	SND_SOC_BYTES("DAC MBC1 Comp Atk Time", R_DACMBCATK1L, 2),
+	SND_SOC_BYTES("DAC MBC1 Comp Rel Time Const",
+		R_DACMBCREL1L, 2),
+
+	SOC_SINGLE("MBC2 Phase Invert", R_DACMBCMUG2, FB_DACMBCMUG2_PHASE,
+		1, 0),
+	SOC_SINGLE_TLV("DAC MBC2 Make-Up Gain Playback Volume",
+		R_DACMBCMUG2, FB_DACMBCMUG2_MUGAIN, 0x1f, 0, mugain_scale),
+	SOC_SINGLE_TLV("DAC MBC2 Comp Thresh Playback Volume",
+		R_DACMBCTHR2, FB_DACMBCTHR2_THRESH, 0xff, 0, compth_scale),
+	SOC_ENUM("DAC MBC2 Comp Ratio Switch",
+		dac_mbc2_compressor_ratio_enum),
+	SND_SOC_BYTES("DAC MBC2 Comp Atk Time", R_DACMBCATK2L, 2),
+	SND_SOC_BYTES("DAC MBC2 Comp Rel Time Const",
+		R_DACMBCREL2L, 2),
+
+	SOC_SINGLE("MBC3 Phase Invert", R_DACMBCMUG3, FB_DACMBCMUG3_PHASE,
+		1, 0),
+	SOC_SINGLE_TLV("DAC MBC3 Make-Up Gain Playback Volume",
+		R_DACMBCMUG3, FB_DACMBCMUG3_MUGAIN, 0x1f, 0, mugain_scale),
+	SOC_SINGLE_TLV("DAC MBC3 Comp Thresh Playback Volume",
+		R_DACMBCTHR3, FB_DACMBCTHR3_THRESH, 0xff, 0, compth_scale),
+	SOC_ENUM("DAC MBC3 Comp Ratio Switch",
+		dac_mbc3_compressor_ratio_enum),
+	SND_SOC_BYTES("DAC MBC3 Comp Atk Time", R_DACMBCATK3L, 2),
+	SND_SOC_BYTES("DAC MBC3 Comp Rel Time Const",
+		R_DACMBCREL3L, 2),
+};
+
+static int setup_sample_format(struct snd_soc_codec *codec,
+		snd_pcm_format_t format)
+{
+	unsigned int width;
+	int ret;
+
+	switch (format) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		width = RV_AIC1_WL_16;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		width = RV_AIC1_WL_20;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		width = RV_AIC1_WL_24;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		width = RV_AIC1_WL_32;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(codec->dev, "Unsupported format width (%d)\n", ret);
+		return ret;
+	}
+	ret = snd_soc_update_bits(codec, R_AIC1, RM_AIC1_WL, width);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set sample width (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int setup_sample_rate(struct snd_soc_codec *codec, unsigned int rate)
+{
+	struct tscs42xx *tscs42xx = snd_soc_codec_get_drvdata(codec);
+	unsigned int br, bm;
+	int ret;
+
+	switch (rate) {
+	case 8000:
+		br = RV_DACSR_DBR_32;
+		bm = RV_DACSR_DBM_PT25;
+		break;
+	case 16000:
+		br = RV_DACSR_DBR_32;
+		bm = RV_DACSR_DBM_PT5;
+		break;
+	case 24000:
+		br = RV_DACSR_DBR_48;
+		bm = RV_DACSR_DBM_PT5;
+		break;
+	case 32000:
+		br = RV_DACSR_DBR_32;
+		bm = RV_DACSR_DBM_1;
+		break;
+	case 48000:
+		br = RV_DACSR_DBR_48;
+		bm = RV_DACSR_DBM_1;
+		break;
+	case 96000:
+		br = RV_DACSR_DBR_48;
+		bm = RV_DACSR_DBM_2;
+		break;
+	case 11025:
+		br = RV_DACSR_DBR_44_1;
+		bm = RV_DACSR_DBM_PT25;
+		break;
+	case 22050:
+		br = RV_DACSR_DBR_44_1;
+		bm = RV_DACSR_DBM_PT5;
+		break;
+	case 44100:
+		br = RV_DACSR_DBR_44_1;
+		bm = RV_DACSR_DBM_1;
+		break;
+	case 88200:
+		br = RV_DACSR_DBR_44_1;
+		bm = RV_DACSR_DBM_2;
+		break;
+	default:
+		dev_err(codec->dev, "Unsupported sample rate %d\n", rate);
+		return -EINVAL;
+	}
+
+	/* DAC and ADC share bit and frame clock */
+	ret = snd_soc_update_bits(codec, R_DACSR, RM_DACSR_DBR, br);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to update register (%d)\n", ret);
+		return ret;
+	}
+	ret = snd_soc_update_bits(codec, R_DACSR, RM_DACSR_DBM, bm);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to update register (%d)\n", ret);
+		return ret;
+	}
+	ret = snd_soc_update_bits(codec, R_ADCSR, RM_DACSR_DBR, br);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to update register (%d)\n", ret);
+		return ret;
+	}
+	ret = snd_soc_update_bits(codec, R_ADCSR, RM_DACSR_DBM, bm);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to update register (%d)\n", ret);
+		return ret;
+	}
+
+	mutex_lock(&tscs42xx->audio_params_lock);
+
+	tscs42xx->samplerate = rate;
+
+	mutex_unlock(&tscs42xx->audio_params_lock);
+
+	return 0;
+}
+
+struct reg_setting {
+	unsigned int addr;
+	unsigned int val;
+	unsigned int mask;
+};
+
+#define PLL_REG_SETTINGS_COUNT 13
+struct pll_ctl {
+	int input_freq;
+	struct reg_setting settings[PLL_REG_SETTINGS_COUNT];
+};
+
+#define PLL_CTL(f, rt, rd, r1b_l, r9, ra, rb,		\
+		rc, r12, r1b_h, re, rf, r10, r11)	\
+	{						\
+		.input_freq = f,			\
+		.settings = {				\
+			{R_TIMEBASE,  rt,   0xFF},	\
+			{R_PLLCTLD,   rd,   0xFF},	\
+			{R_PLLCTL1B, r1b_l, 0x0F},	\
+			{R_PLLCTL9,   r9,   0xFF},	\
+			{R_PLLCTLA,   ra,   0xFF},	\
+			{R_PLLCTLB,   rb,   0xFF},	\
+			{R_PLLCTLC,   rc,   0xFF},	\
+			{R_PLLCTL12, r12,   0xFF},	\
+			{R_PLLCTL1B, r1b_h, 0xF0},	\
+			{R_PLLCTLE,   re,   0xFF},	\
+			{R_PLLCTLF,   rf,   0xFF},	\
+			{R_PLLCTL10, r10,   0xFF},	\
+			{R_PLLCTL11, r11,   0xFF},	\
+		},					\
+	}
+
+static const struct pll_ctl pll_ctls[] = {
+	PLL_CTL(1411200, 0x05,
+		0x39, 0x04, 0x07, 0x02, 0xC3, 0x04,
+		0x1B, 0x10, 0x03, 0x03, 0xD0, 0x02),
+	PLL_CTL(1536000, 0x05,
+		0x1A, 0x04, 0x02, 0x03, 0xE0, 0x01,
+		0x1A, 0x10, 0x02, 0x03, 0xB9, 0x01),
+	PLL_CTL(2822400, 0x0A,
+		0x23, 0x04, 0x07, 0x04, 0xC3, 0x04,
+		0x22, 0x10, 0x05, 0x03, 0x58, 0x02),
+	PLL_CTL(3072000, 0x0B,
+		0x22, 0x04, 0x07, 0x03, 0x48, 0x03,
+		0x1A, 0x10, 0x04, 0x03, 0xB9, 0x01),
+	PLL_CTL(5644800, 0x15,
+		0x23, 0x04, 0x0E, 0x04, 0xC3, 0x04,
+		0x1A, 0x10, 0x08, 0x03, 0xE0, 0x01),
+	PLL_CTL(6144000, 0x17,
+		0x1A, 0x04, 0x08, 0x03, 0xE0, 0x01,
+		0x1A, 0x10, 0x08, 0x03, 0xB9, 0x01),
+	PLL_CTL(12000000, 0x2E,
+		0x1B, 0x04, 0x19, 0x03, 0x00, 0x03,
+		0x2A, 0x10, 0x19, 0x05, 0x98, 0x04),
+	PLL_CTL(19200000, 0x4A,
+		0x13, 0x04, 0x14, 0x03, 0x80, 0x01,
+		0x1A, 0x10, 0x19, 0x03, 0xB9, 0x01),
+	PLL_CTL(22000000, 0x55,
+		0x2A, 0x04, 0x37, 0x05, 0x00, 0x06,
+		0x22, 0x10, 0x26, 0x03, 0x49, 0x02),
+	PLL_CTL(22579200, 0x57,
+		0x22, 0x04, 0x31, 0x03, 0x20, 0x03,
+		0x1A, 0x10, 0x1D, 0x03, 0xB3, 0x01),
+	PLL_CTL(24000000, 0x5D,
+		0x13, 0x04, 0x19, 0x03, 0x80, 0x01,
+		0x1B, 0x10, 0x19, 0x05, 0x4C, 0x02),
+	PLL_CTL(24576000, 0x5F,
+		0x13, 0x04, 0x1D, 0x03, 0xB3, 0x01,
+		0x22, 0x10, 0x40, 0x03, 0x72, 0x03),
+	PLL_CTL(27000000, 0x68,
+		0x22, 0x04, 0x4B, 0x03, 0x00, 0x04,
+		0x2A, 0x10, 0x7D, 0x03, 0x20, 0x06),
+	PLL_CTL(36000000, 0x8C,
+		0x1B, 0x04, 0x4B, 0x03, 0x00, 0x03,
+		0x2A, 0x10, 0x7D, 0x03, 0x98, 0x04),
+	PLL_CTL(25000000, 0x61,
+		0x1B, 0x04, 0x37, 0x03, 0x2B, 0x03,
+		0x1A, 0x10, 0x2A, 0x03, 0x39, 0x02),
+	PLL_CTL(26000000, 0x65,
+		0x23, 0x04, 0x41, 0x05, 0x00, 0x06,
+		0x1A, 0x10, 0x26, 0x03, 0xEF, 0x01),
+	PLL_CTL(12288000, 0x2F,
+		0x1A, 0x04, 0x12, 0x03, 0x1C, 0x02,
+		0x22, 0x10, 0x20, 0x03, 0x72, 0x03),
+	PLL_CTL(40000000, 0x9B,
+		0x22, 0x08, 0x7D, 0x03, 0x80, 0x04,
+		0x23, 0x10, 0x7D, 0x05, 0xE4, 0x06),
+	PLL_CTL(512000, 0x01,
+		0x22, 0x04, 0x01, 0x03, 0xD0, 0x02,
+		0x1B, 0x10, 0x01, 0x04, 0x72, 0x03),
+	PLL_CTL(705600, 0x02,
+		0x22, 0x04, 0x02, 0x03, 0x15, 0x04,
+		0x22, 0x10, 0x01, 0x04, 0x80, 0x02),
+	PLL_CTL(1024000, 0x03,
+		0x22, 0x04, 0x02, 0x03, 0xD0, 0x02,
+		0x1B, 0x10, 0x02, 0x04, 0x72, 0x03),
+	PLL_CTL(2048000, 0x07,
+		0x22, 0x04, 0x04, 0x03, 0xD0, 0x02,
+		0x1B, 0x10, 0x04, 0x04, 0x72, 0x03),
+	PLL_CTL(2400000, 0x08,
+		0x22, 0x04, 0x05, 0x03, 0x00, 0x03,
+		0x23, 0x10, 0x05, 0x05, 0x98, 0x04),
+};
+
+static const struct pll_ctl *get_pll_ctl(int input_freq)
+{
+	int i;
+	const struct pll_ctl *pll_ctl = NULL;
+
+	for (i = 0; i < ARRAY_SIZE(pll_ctls); ++i)
+		if (input_freq == pll_ctls[i].input_freq) {
+			pll_ctl = &pll_ctls[i];
+			break;
+		}
+
+	return pll_ctl;
+}
+
+static int set_pll_ctl_from_input_freq(struct snd_soc_codec *codec,
+		const int input_freq)
+{
+	int ret;
+	int i;
+	const struct pll_ctl *pll_ctl;
+
+	pll_ctl = get_pll_ctl(input_freq);
+	if (!pll_ctl) {
+		ret = -EINVAL;
+		dev_err(codec->dev, "No PLL input entry for %d (%d)\n",
+			input_freq, ret);
+		return ret;
+	}
+
+	for (i = 0; i < PLL_REG_SETTINGS_COUNT; ++i) {
+		ret = snd_soc_update_bits(codec,
+			pll_ctl->settings[i].addr,
+			pll_ctl->settings[i].mask,
+			pll_ctl->settings[i].val);
+		if (ret < 0) {
+			dev_err(codec->dev, "Failed to set pll ctl (%d)\n",
+				ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int tscs42xx_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params,
+		struct snd_soc_dai *codec_dai)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	int ret;
+
+	ret = setup_sample_format(codec, params_format(params));
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to setup sample format (%d)\n",
+			ret);
+		return ret;
+	}
+
+	ret = setup_sample_rate(codec, params_rate(params));
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to setup sample rate (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static inline int dac_mute(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	ret = snd_soc_update_bits(codec, R_CNVRTR1, RM_CNVRTR1_DACMU,
+		RV_CNVRTR1_DACMU_ENABLE);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to mute DAC (%d)\n",
+				ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static inline int dac_unmute(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	ret = snd_soc_update_bits(codec, R_CNVRTR1, RM_CNVRTR1_DACMU,
+		RV_CNVRTR1_DACMU_DISABLE);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to unmute DAC (%d)\n",
+				ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static inline int adc_mute(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	ret = snd_soc_update_bits(codec, R_CNVRTR0, RM_CNVRTR0_ADCMU,
+		RV_CNVRTR0_ADCMU_ENABLE);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to mute ADC (%d)\n",
+				ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static inline int adc_unmute(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	ret = snd_soc_update_bits(codec, R_CNVRTR0, RM_CNVRTR0_ADCMU,
+		RV_CNVRTR0_ADCMU_DISABLE);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to unmute ADC (%d)\n",
+				ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tscs42xx_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	int ret;
+
+	if (mute)
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			ret = dac_mute(codec);
+		else
+			ret = adc_mute(codec);
+	else
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			ret = dac_unmute(codec);
+		else
+			ret = adc_unmute(codec);
+
+	return ret;
+}
+
+static int tscs42xx_set_dai_fmt(struct snd_soc_dai *codec_dai,
+		unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	int ret;
+
+	/* Slave mode not supported since it needs always-on frame clock */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		ret = snd_soc_update_bits(codec, R_AIC1, RM_AIC1_MS,
+				RV_AIC1_MS_MASTER);
+		if (ret < 0) {
+			dev_err(codec->dev,
+				"Failed to set codec DAI master (%d)\n", ret);
+			return ret;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(codec->dev, "Unsupported format (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tscs42xx_set_dai_bclk_ratio(struct snd_soc_dai *codec_dai,
+		unsigned int ratio)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct tscs42xx *tscs42xx = snd_soc_codec_get_drvdata(codec);
+	unsigned int value;
+	int ret = 0;
+
+	switch (ratio) {
+	case 32:
+		value = RV_DACSR_DBCM_32;
+		break;
+	case 40:
+		value = RV_DACSR_DBCM_40;
+		break;
+	case 64:
+		value = RV_DACSR_DBCM_64;
+		break;
+	default:
+		dev_err(codec->dev, "Unsupported bclk ratio (%d)\n", ret);
+		return -EINVAL;
+	}
+
+	ret = snd_soc_update_bits(codec, R_DACSR, RM_DACSR_DBCM, value);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set DAC BCLK ratio (%d)\n", ret);
+		return ret;
+	}
+	ret = snd_soc_update_bits(codec, R_ADCSR, RM_ADCSR_ABCM, value);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set ADC BCLK ratio (%d)\n", ret);
+		return ret;
+	}
+
+	mutex_lock(&tscs42xx->audio_params_lock);
+
+	tscs42xx->bclk_ratio = ratio;
+
+	mutex_unlock(&tscs42xx->audio_params_lock);
+
+	return 0;
+}
+
+static int tscs42xx_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+	int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	int ret;
+
+	switch (clk_id) {
+	case TSCS42XX_PLL_SRC_XTAL:
+	case TSCS42XX_PLL_SRC_MCLK1:
+		ret = snd_soc_write(codec, R_PLLREFSEL,
+				RV_PLLREFSEL_PLL1_REF_SEL_XTAL_MCLK1 |
+				RV_PLLREFSEL_PLL2_REF_SEL_XTAL_MCLK1);
+		if (ret < 0) {
+			dev_err(codec->dev,
+				"Failed to set pll reference input (%d)\n",
+				ret);
+			return ret;
+		}
+		break;
+	case TSCS42XX_PLL_SRC_MCLK2:
+		ret = snd_soc_write(codec, R_PLLREFSEL,
+				RV_PLLREFSEL_PLL1_REF_SEL_MCLK2 |
+				RV_PLLREFSEL_PLL2_REF_SEL_MCLK2);
+		if (ret < 0) {
+			dev_err(codec->dev,
+				"Failed to set PLL reference (%d)\n", ret);
+			return ret;
+		}
+		break;
+	default:
+		dev_err(codec->dev, "pll src is unsupported\n");
+		return -EINVAL;
+	}
+
+	ret = set_pll_ctl_from_input_freq(codec, freq);
+	if (ret < 0) {
+		dev_err(codec->dev,
+			"Failed to setup PLL input freq (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops tscs42xx_dai_ops = {
+	.hw_params	= tscs42xx_hw_params,
+	.mute_stream	= tscs42xx_mute_stream,
+	.set_fmt	= tscs42xx_set_dai_fmt,
+	.set_bclk_ratio = tscs42xx_set_dai_bclk_ratio,
+	.set_sysclk	= tscs42xx_set_dai_sysclk,
+};
+
+static int part_is_valid(struct tscs42xx *tscs42xx)
+{
+	int val;
+	int ret;
+	unsigned int reg;
+
+	ret = regmap_read(tscs42xx->regmap, R_DEVIDH, &reg);
+	if (ret < 0)
+		return ret;
+
+	val = reg << 8;
+	ret = regmap_read(tscs42xx->regmap, R_DEVIDL, &reg);
+	if (ret < 0)
+		return ret;
+
+	val |= reg;
+
+	switch (val) {
+	case 0x4A74:
+	case 0x4A73:
+		return true;
+	default:
+		return false;
+	};
+}
+
+static struct snd_soc_codec_driver soc_codec_dev_tscs42xx = {
+	.component_driver = {
+		.dapm_widgets = tscs42xx_dapm_widgets,
+		.num_dapm_widgets = ARRAY_SIZE(tscs42xx_dapm_widgets),
+		.dapm_routes = tscs42xx_intercon,
+		.num_dapm_routes = ARRAY_SIZE(tscs42xx_intercon),
+		.controls =	tscs42xx_snd_controls,
+		.num_controls = ARRAY_SIZE(tscs42xx_snd_controls),
+	},
+};
+
+static inline void init_coeff_ram_cache(struct tscs42xx *tscs42xx)
+{
+	const u8 norm_addrs[] = { 0x00, 0x05, 0x0a, 0x0f, 0x14, 0x19, 0x1f,
+		0x20, 0x25, 0x2a, 0x2f, 0x34, 0x39, 0x3f, 0x40, 0x45, 0x4a,
+		0x4f, 0x54, 0x59, 0x5f, 0x60, 0x65, 0x6a, 0x6f, 0x74, 0x79,
+		0x7f, 0x80, 0x85, 0x8c, 0x91, 0x96, 0x97, 0x9c, 0xa3, 0xa8,
+		0xad, 0xaf, 0xb0, 0xb5, 0xba, 0xbf, 0xc4, 0xc9, };
+	u8 *coeff_ram = tscs42xx->coeff_ram;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(norm_addrs); i++)
+		coeff_ram[((norm_addrs[i] + 1) * COEFF_SIZE) - 1] = 0x40;
+}
+
+#define TSCS42XX_RATES SNDRV_PCM_RATE_8000_96000
+
+#define TSCS42XX_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE \
+	| SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver tscs42xx_dai = {
+	.name = "tscs42xx-HiFi",
+	.playback = {
+		.stream_name = "HiFi Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = TSCS42XX_RATES,
+		.formats = TSCS42XX_FORMATS,},
+	.capture = {
+		.stream_name = "HiFi Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = TSCS42XX_RATES,
+		.formats = TSCS42XX_FORMATS,},
+	.ops = &tscs42xx_dai_ops,
+	.symmetric_rates = 1,
+	.symmetric_channels = 1,
+	.symmetric_samplebits = 1,
+};
+
+static const struct reg_sequence tscs42xx_patch[] = {
+	{ R_AIC2, RV_AIC2_BLRCM_DAC_BCLK_LRCLK_SHARED },
+};
+
+static int tscs42xx_i2c_probe(struct i2c_client *i2c,
+		const struct i2c_device_id *id)
+{
+	struct tscs42xx *tscs42xx;
+	int ret = 0;
+
+	tscs42xx = devm_kzalloc(&i2c->dev, sizeof(*tscs42xx), GFP_KERNEL);
+	if (!tscs42xx) {
+		ret = -ENOMEM;
+		dev_err(&i2c->dev,
+			"Failed to allocate memory for data (%d)\n", ret);
+		return ret;
+	}
+	i2c_set_clientdata(i2c, tscs42xx);
+	tscs42xx->dev = &i2c->dev;
+
+	tscs42xx->regmap = devm_regmap_init_i2c(i2c, &tscs42xx_regmap);
+	if (IS_ERR(tscs42xx->regmap)) {
+		ret = PTR_ERR(tscs42xx->regmap);
+		dev_err(tscs42xx->dev, "Failed to allocate regmap (%d)\n", ret);
+		return ret;
+	}
+
+	init_coeff_ram_cache(tscs42xx);
+
+	ret = part_is_valid(tscs42xx);
+	if (ret <= 0) {
+		dev_err(tscs42xx->dev, "No valid part (%d)\n", ret);
+		ret = -ENODEV;
+		return ret;
+	}
+
+	ret = regmap_write(tscs42xx->regmap, R_RESET, RV_RESET_ENABLE);
+	if (ret < 0) {
+		dev_err(tscs42xx->dev, "Failed to reset device (%d)\n", ret);
+		return ret;
+	}
+
+	ret = regmap_register_patch(tscs42xx->regmap, tscs42xx_patch,
+			ARRAY_SIZE(tscs42xx_patch));
+	if (ret < 0) {
+		dev_err(tscs42xx->dev, "Failed to apply patch (%d)\n", ret);
+		return ret;
+	}
+
+	mutex_init(&tscs42xx->audio_params_lock);
+	mutex_init(&tscs42xx->coeff_ram_lock);
+	mutex_init(&tscs42xx->pll_lock);
+
+	ret = snd_soc_register_codec(tscs42xx->dev, &soc_codec_dev_tscs42xx,
+			&tscs42xx_dai, 1);
+	if (ret) {
+		dev_err(tscs42xx->dev, "Failed to register codec (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tscs42xx_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+
+	return 0;
+}
+
+static const struct i2c_device_id tscs42xx_i2c_id[] = {
+	{ "tscs42A1", 0 },
+	{ "tscs42A2", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tscs42xx_i2c_id);
+
+static const struct of_device_id tscs42xx_of_match[] = {
+	{ .compatible = "tempo,tscs42A1", },
+	{ .compatible = "tempo,tscs42A2", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tscs42xx_of_match);
+
+static struct i2c_driver tscs42xx_i2c_driver = {
+	.driver = {
+		.name = "tscs42xx",
+		.owner = THIS_MODULE,
+		.of_match_table = tscs42xx_of_match,
+	},
+	.probe =    tscs42xx_i2c_probe,
+	.remove =   tscs42xx_i2c_remove,
+	.id_table = tscs42xx_i2c_id,
+};
+
+module_i2c_driver(tscs42xx_i2c_driver);
+
+MODULE_AUTHOR("Tempo Semiconductor <steven.eckhoff.opensource@gmail.com");
+MODULE_DESCRIPTION("ASoC TSCS42xx driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/tscs42xx.h b/sound/soc/codecs/tscs42xx.h
new file mode 100644
index 000000000000..d4a30bcbf64b
--- /dev/null
+++ b/sound/soc/codecs/tscs42xx.h
@@ -0,0 +1,2693 @@
+// SPDX-License-Identifier: GPL-2.0
+// tscs42xx.h -- TSCS42xx ALSA SoC Audio driver
+// Copyright 2017 Tempo Semiconductor, Inc.
+// Author: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+
+#ifndef __WOOKIE_H__
+#define __WOOKIE_H__
+
+enum {
+	TSCS42XX_PLL_SRC_NONE,
+	TSCS42XX_PLL_SRC_XTAL,
+	TSCS42XX_PLL_SRC_MCLK1,
+	TSCS42XX_PLL_SRC_MCLK2,
+};
+
+#define R_HPVOLL        0x0
+#define R_HPVOLR        0x1
+#define R_SPKVOLL       0x2
+#define R_SPKVOLR       0x3
+#define R_DACVOLL       0x4
+#define R_DACVOLR       0x5
+#define R_ADCVOLL       0x6
+#define R_ADCVOLR       0x7
+#define R_INVOLL        0x8
+#define R_INVOLR        0x9
+#define R_INMODE        0x0B
+#define R_INSELL        0x0C
+#define R_INSELR        0x0D
+#define R_AIC1          0x13
+#define R_AIC2          0x14
+#define R_CNVRTR0       0x16
+#define R_ADCSR         0x17
+#define R_CNVRTR1       0x18
+#define R_DACSR         0x19
+#define R_PWRM1         0x1A
+#define R_PWRM2         0x1B
+#define R_CONFIG0       0x1F
+#define R_CONFIG1       0x20
+#define R_DMICCTL       0x24
+#define R_CLECTL        0x25
+#define R_MUGAIN        0x26
+#define R_COMPTH        0x27
+#define R_CMPRAT        0x28
+#define R_CATKTCL       0x29
+#define R_CATKTCH       0x2A
+#define R_CRELTCL       0x2B
+#define R_CRELTCH       0x2C
+#define R_LIMTH         0x2D
+#define R_LIMTGT        0x2E
+#define R_LATKTCL       0x2F
+#define R_LATKTCH       0x30
+#define R_LRELTCL       0x31
+#define R_LRELTCH       0x32
+#define R_EXPTH         0x33
+#define R_EXPRAT        0x34
+#define R_XATKTCL       0x35
+#define R_XATKTCH       0x36
+#define R_XRELTCL       0x37
+#define R_XRELTCH       0x38
+#define R_FXCTL         0x39
+#define R_DACCRWRL      0x3A
+#define R_DACCRWRM      0x3B
+#define R_DACCRWRH      0x3C
+#define R_DACCRRDL      0x3D
+#define R_DACCRRDM      0x3E
+#define R_DACCRRDH      0x3F
+#define R_DACCRADDR     0x40
+#define R_DCOFSEL       0x41
+#define R_PLLCTL9       0x4E
+#define R_PLLCTLA       0x4F
+#define R_PLLCTLB       0x50
+#define R_PLLCTLC       0x51
+#define R_PLLCTLD       0x52
+#define R_PLLCTLE       0x53
+#define R_PLLCTLF       0x54
+#define R_PLLCTL10      0x55
+#define R_PLLCTL11      0x56
+#define R_PLLCTL12      0x57
+#define R_PLLCTL1B      0x60
+#define R_PLLCTL1C      0x61
+#define R_TIMEBASE      0x77
+#define R_DEVIDL        0x7D
+#define R_DEVIDH        0x7E
+#define R_RESET         0x80
+#define R_DACCRSTAT     0x8A
+#define R_PLLCTL0       0x8E
+#define R_PLLREFSEL     0x8F
+#define R_DACMBCEN      0xC7
+#define R_DACMBCCTL     0xC8
+#define R_DACMBCMUG1    0xC9
+#define R_DACMBCTHR1    0xCA
+#define R_DACMBCRAT1    0xCB
+#define R_DACMBCATK1L   0xCC
+#define R_DACMBCATK1H   0xCD
+#define R_DACMBCREL1L   0xCE
+#define R_DACMBCREL1H   0xCF
+#define R_DACMBCMUG2    0xD0
+#define R_DACMBCTHR2    0xD1
+#define R_DACMBCRAT2    0xD2
+#define R_DACMBCATK2L   0xD3
+#define R_DACMBCATK2H   0xD4
+#define R_DACMBCREL2L   0xD5
+#define R_DACMBCREL2H   0xD6
+#define R_DACMBCMUG3    0xD7
+#define R_DACMBCTHR3    0xD8
+#define R_DACMBCRAT3    0xD9
+#define R_DACMBCATK3L   0xDA
+#define R_DACMBCATK3H   0xDB
+#define R_DACMBCREL3L   0xDC
+#define R_DACMBCREL3H   0xDD
+
+/* Helpers */
+#define RM(m, b) ((m)<<(b))
+#define RV(v, b) ((v)<<(b))
+
+/****************************
+ *      R_HPVOLL (0x0)      *
+ ****************************/
+
+/* Field Offsets */
+#define FB_HPVOLL                            0
+
+/* Field Masks */
+#define FM_HPVOLL                            0X7F
+
+/* Field Values */
+#define FV_HPVOLL_P6DB                       0x7F
+#define FV_HPVOLL_N88PT5DB                   0x1
+#define FV_HPVOLL_MUTE                       0x0
+
+/* Register Masks */
+#define RM_HPVOLL                            RM(FM_HPVOLL, FB_HPVOLL)
+
+/* Register Values */
+#define RV_HPVOLL_P6DB                       RV(FV_HPVOLL_P6DB, FB_HPVOLL)
+#define RV_HPVOLL_N88PT5DB                   RV(FV_HPVOLL_N88PT5DB, FB_HPVOLL)
+#define RV_HPVOLL_MUTE                       RV(FV_HPVOLL_MUTE, FB_HPVOLL)
+
+/****************************
+ *      R_HPVOLR (0x1)      *
+ ****************************/
+
+/* Field Offsets */
+#define FB_HPVOLR                            0
+
+/* Field Masks */
+#define FM_HPVOLR                            0X7F
+
+/* Field Values */
+#define FV_HPVOLR_P6DB                       0x7F
+#define FV_HPVOLR_N88PT5DB                   0x1
+#define FV_HPVOLR_MUTE                       0x0
+
+/* Register Masks */
+#define RM_HPVOLR                            RM(FM_HPVOLR, FB_HPVOLR)
+
+/* Register Values */
+#define RV_HPVOLR_P6DB                       RV(FV_HPVOLR_P6DB, FB_HPVOLR)
+#define RV_HPVOLR_N88PT5DB                   RV(FV_HPVOLR_N88PT5DB, FB_HPVOLR)
+#define RV_HPVOLR_MUTE                       RV(FV_HPVOLR_MUTE, FB_HPVOLR)
+
+/*****************************
+ *      R_SPKVOLL (0x2)      *
+ *****************************/
+
+/* Field Offsets */
+#define FB_SPKVOLL                           0
+
+/* Field Masks */
+#define FM_SPKVOLL                           0X7F
+
+/* Field Values */
+#define FV_SPKVOLL_P12DB                     0x7F
+#define FV_SPKVOLL_N77PT25DB                 0x8
+#define FV_SPKVOLL_MUTE                      0x0
+
+/* Register Masks */
+#define RM_SPKVOLL                           RM(FM_SPKVOLL, FB_SPKVOLL)
+
+/* Register Values */
+#define RV_SPKVOLL_P12DB                     RV(FV_SPKVOLL_P12DB, FB_SPKVOLL)
+#define RV_SPKVOLL_N77PT25DB \
+	 RV(FV_SPKVOLL_N77PT25DB, FB_SPKVOLL)
+
+#define RV_SPKVOLL_MUTE                      RV(FV_SPKVOLL_MUTE, FB_SPKVOLL)
+
+/*****************************
+ *      R_SPKVOLR (0x3)      *
+ *****************************/
+
+/* Field Offsets */
+#define FB_SPKVOLR                           0
+
+/* Field Masks */
+#define FM_SPKVOLR                           0X7F
+
+/* Field Values */
+#define FV_SPKVOLR_P12DB                     0x7F
+#define FV_SPKVOLR_N77PT25DB                 0x8
+#define FV_SPKVOLR_MUTE                      0x0
+
+/* Register Masks */
+#define RM_SPKVOLR                           RM(FM_SPKVOLR, FB_SPKVOLR)
+
+/* Register Values */
+#define RV_SPKVOLR_P12DB                     RV(FV_SPKVOLR_P12DB, FB_SPKVOLR)
+#define RV_SPKVOLR_N77PT25DB \
+	 RV(FV_SPKVOLR_N77PT25DB, FB_SPKVOLR)
+
+#define RV_SPKVOLR_MUTE                      RV(FV_SPKVOLR_MUTE, FB_SPKVOLR)
+
+/*****************************
+ *      R_DACVOLL (0x4)      *
+ *****************************/
+
+/* Field Offsets */
+#define FB_DACVOLL                           0
+
+/* Field Masks */
+#define FM_DACVOLL                           0XFF
+
+/* Field Values */
+#define FV_DACVOLL_0DB                       0xFF
+#define FV_DACVOLL_N95PT625DB                0x1
+#define FV_DACVOLL_MUTE                      0x0
+
+/* Register Masks */
+#define RM_DACVOLL                           RM(FM_DACVOLL, FB_DACVOLL)
+
+/* Register Values */
+#define RV_DACVOLL_0DB                       RV(FV_DACVOLL_0DB, FB_DACVOLL)
+#define RV_DACVOLL_N95PT625DB \
+	 RV(FV_DACVOLL_N95PT625DB, FB_DACVOLL)
+
+#define RV_DACVOLL_MUTE                      RV(FV_DACVOLL_MUTE, FB_DACVOLL)
+
+/*****************************
+ *      R_DACVOLR (0x5)      *
+ *****************************/
+
+/* Field Offsets */
+#define FB_DACVOLR                           0
+
+/* Field Masks */
+#define FM_DACVOLR                           0XFF
+
+/* Field Values */
+#define FV_DACVOLR_0DB                       0xFF
+#define FV_DACVOLR_N95PT625DB                0x1
+#define FV_DACVOLR_MUTE                      0x0
+
+/* Register Masks */
+#define RM_DACVOLR                           RM(FM_DACVOLR, FB_DACVOLR)
+
+/* Register Values */
+#define RV_DACVOLR_0DB                       RV(FV_DACVOLR_0DB, FB_DACVOLR)
+#define RV_DACVOLR_N95PT625DB \
+	 RV(FV_DACVOLR_N95PT625DB, FB_DACVOLR)
+
+#define RV_DACVOLR_MUTE                      RV(FV_DACVOLR_MUTE, FB_DACVOLR)
+
+/*****************************
+ *      R_ADCVOLL (0x6)      *
+ *****************************/
+
+/* Field Offsets */
+#define FB_ADCVOLL                           0
+
+/* Field Masks */
+#define FM_ADCVOLL                           0XFF
+
+/* Field Values */
+#define FV_ADCVOLL_P24DB                     0xFF
+#define FV_ADCVOLL_N71PT25DB                 0x1
+#define FV_ADCVOLL_MUTE                      0x0
+
+/* Register Masks */
+#define RM_ADCVOLL                           RM(FM_ADCVOLL, FB_ADCVOLL)
+
+/* Register Values */
+#define RV_ADCVOLL_P24DB                     RV(FV_ADCVOLL_P24DB, FB_ADCVOLL)
+#define RV_ADCVOLL_N71PT25DB \
+	 RV(FV_ADCVOLL_N71PT25DB, FB_ADCVOLL)
+
+#define RV_ADCVOLL_MUTE                      RV(FV_ADCVOLL_MUTE, FB_ADCVOLL)
+
+/*****************************
+ *      R_ADCVOLR (0x7)      *
+ *****************************/
+
+/* Field Offsets */
+#define FB_ADCVOLR                           0
+
+/* Field Masks */
+#define FM_ADCVOLR                           0XFF
+
+/* Field Values */
+#define FV_ADCVOLR_P24DB                     0xFF
+#define FV_ADCVOLR_N71PT25DB                 0x1
+#define FV_ADCVOLR_MUTE                      0x0
+
+/* Register Masks */
+#define RM_ADCVOLR                           RM(FM_ADCVOLR, FB_ADCVOLR)
+
+/* Register Values */
+#define RV_ADCVOLR_P24DB                     RV(FV_ADCVOLR_P24DB, FB_ADCVOLR)
+#define RV_ADCVOLR_N71PT25DB \
+	 RV(FV_ADCVOLR_N71PT25DB, FB_ADCVOLR)
+
+#define RV_ADCVOLR_MUTE                      RV(FV_ADCVOLR_MUTE, FB_ADCVOLR)
+
+/****************************
+ *      R_INVOLL (0x8)      *
+ ****************************/
+
+/* Field Offsets */
+#define FB_INVOLL_INMUTEL                    7
+#define FB_INVOLL_IZCL                       6
+#define FB_INVOLL                            0
+
+/* Field Masks */
+#define FM_INVOLL_INMUTEL                    0X1
+#define FM_INVOLL_IZCL                       0X1
+#define FM_INVOLL                            0X3F
+
+/* Field Values */
+#define FV_INVOLL_INMUTEL_ENABLE             0x1
+#define FV_INVOLL_INMUTEL_DISABLE            0x0
+#define FV_INVOLL_IZCL_ENABLE                0x1
+#define FV_INVOLL_IZCL_DISABLE               0x0
+#define FV_INVOLL_P30DB                      0x3F
+#define FV_INVOLL_N17PT25DB                  0x0
+
+/* Register Masks */
+#define RM_INVOLL_INMUTEL \
+	 RM(FM_INVOLL_INMUTEL, FB_INVOLL_INMUTEL)
+
+#define RM_INVOLL_IZCL                       RM(FM_INVOLL_IZCL, FB_INVOLL_IZCL)
+#define RM_INVOLL                            RM(FM_INVOLL, FB_INVOLL)
+
+/* Register Values */
+#define RV_INVOLL_INMUTEL_ENABLE \
+	 RV(FV_INVOLL_INMUTEL_ENABLE, FB_INVOLL_INMUTEL)
+
+#define RV_INVOLL_INMUTEL_DISABLE \
+	 RV(FV_INVOLL_INMUTEL_DISABLE, FB_INVOLL_INMUTEL)
+
+#define RV_INVOLL_IZCL_ENABLE \
+	 RV(FV_INVOLL_IZCL_ENABLE, FB_INVOLL_IZCL)
+
+#define RV_INVOLL_IZCL_DISABLE \
+	 RV(FV_INVOLL_IZCL_DISABLE, FB_INVOLL_IZCL)
+
+#define RV_INVOLL_P30DB                      RV(FV_INVOLL_P30DB, FB_INVOLL)
+#define RV_INVOLL_N17PT25DB                  RV(FV_INVOLL_N17PT25DB, FB_INVOLL)
+
+/****************************
+ *      R_INVOLR (0x9)      *
+ ****************************/
+
+/* Field Offsets */
+#define FB_INVOLR_INMUTER                    7
+#define FB_INVOLR_IZCR                       6
+#define FB_INVOLR                            0
+
+/* Field Masks */
+#define FM_INVOLR_INMUTER                    0X1
+#define FM_INVOLR_IZCR                       0X1
+#define FM_INVOLR                            0X3F
+
+/* Field Values */
+#define FV_INVOLR_INMUTER_ENABLE             0x1
+#define FV_INVOLR_INMUTER_DISABLE            0x0
+#define FV_INVOLR_IZCR_ENABLE                0x1
+#define FV_INVOLR_IZCR_DISABLE               0x0
+#define FV_INVOLR_P30DB                      0x3F
+#define FV_INVOLR_N17PT25DB                  0x0
+
+/* Register Masks */
+#define RM_INVOLR_INMUTER \
+	 RM(FM_INVOLR_INMUTER, FB_INVOLR_INMUTER)
+
+#define RM_INVOLR_IZCR                       RM(FM_INVOLR_IZCR, FB_INVOLR_IZCR)
+#define RM_INVOLR                            RM(FM_INVOLR, FB_INVOLR)
+
+/* Register Values */
+#define RV_INVOLR_INMUTER_ENABLE \
+	 RV(FV_INVOLR_INMUTER_ENABLE, FB_INVOLR_INMUTER)
+
+#define RV_INVOLR_INMUTER_DISABLE \
+	 RV(FV_INVOLR_INMUTER_DISABLE, FB_INVOLR_INMUTER)
+
+#define RV_INVOLR_IZCR_ENABLE \
+	 RV(FV_INVOLR_IZCR_ENABLE, FB_INVOLR_IZCR)
+
+#define RV_INVOLR_IZCR_DISABLE \
+	 RV(FV_INVOLR_IZCR_DISABLE, FB_INVOLR_IZCR)
+
+#define RV_INVOLR_P30DB                      RV(FV_INVOLR_P30DB, FB_INVOLR)
+#define RV_INVOLR_N17PT25DB                  RV(FV_INVOLR_N17PT25DB, FB_INVOLR)
+
+/*****************************
+ *      R_INMODE (0x0B)      *
+ *****************************/
+
+/* Field Offsets */
+#define FB_INMODE_DS                         0
+
+/* Field Masks */
+#define FM_INMODE_DS                         0X1
+
+/* Field Values */
+#define FV_INMODE_DS_LRIN1                   0x0
+#define FV_INMODE_DS_LRIN2                   0x1
+
+/* Register Masks */
+#define RM_INMODE_DS                         RM(FM_INMODE_DS, FB_INMODE_DS)
+
+/* Register Values */
+#define RV_INMODE_DS_LRIN1 \
+	 RV(FV_INMODE_DS_LRIN1, FB_INMODE_DS)
+
+#define RV_INMODE_DS_LRIN2 \
+	 RV(FV_INMODE_DS_LRIN2, FB_INMODE_DS)
+
+
+/*****************************
+ *      R_INSELL (0x0C)      *
+ *****************************/
+
+/* Field Offsets */
+#define FB_INSELL                            6
+#define FB_INSELL_MICBSTL                    4
+
+/* Field Masks */
+#define FM_INSELL                            0X3
+#define FM_INSELL_MICBSTL                    0X3
+
+/* Field Values */
+#define FV_INSELL_IN1                        0x0
+#define FV_INSELL_IN2                        0x1
+#define FV_INSELL_IN3                        0x2
+#define FV_INSELL_D2S                        0x3
+#define FV_INSELL_MICBSTL_OFF                0x0
+#define FV_INSELL_MICBSTL_10DB               0x1
+#define FV_INSELL_MICBSTL_20DB               0x2
+#define FV_INSELL_MICBSTL_30DB               0x3
+
+/* Register Masks */
+#define RM_INSELL                            RM(FM_INSELL, FB_INSELL)
+#define RM_INSELL_MICBSTL \
+	 RM(FM_INSELL_MICBSTL, FB_INSELL_MICBSTL)
+
+
+/* Register Values */
+#define RV_INSELL_IN1                        RV(FV_INSELL_IN1, FB_INSELL)
+#define RV_INSELL_IN2                        RV(FV_INSELL_IN2, FB_INSELL)
+#define RV_INSELL_IN3                        RV(FV_INSELL_IN3, FB_INSELL)
+#define RV_INSELL_D2S                        RV(FV_INSELL_D2S, FB_INSELL)
+#define RV_INSELL_MICBSTL_OFF \
+	 RV(FV_INSELL_MICBSTL_OFF, FB_INSELL_MICBSTL)
+
+#define RV_INSELL_MICBSTL_10DB \
+	 RV(FV_INSELL_MICBSTL_10DB, FB_INSELL_MICBSTL)
+
+#define RV_INSELL_MICBSTL_20DB \
+	 RV(FV_INSELL_MICBSTL_20DB, FB_INSELL_MICBSTL)
+
+#define RV_INSELL_MICBSTL_30DB \
+	 RV(FV_INSELL_MICBSTL_30DB, FB_INSELL_MICBSTL)
+
+
+/*****************************
+ *      R_INSELR (0x0D)      *
+ *****************************/
+
+/* Field Offsets */
+#define FB_INSELR                            6
+#define FB_INSELR_MICBSTR                    4
+
+/* Field Masks */
+#define FM_INSELR                            0X3
+#define FM_INSELR_MICBSTR                    0X3
+
+/* Field Values */
+#define FV_INSELR_IN1                        0x0
+#define FV_INSELR_IN2                        0x1
+#define FV_INSELR_IN3                        0x2
+#define FV_INSELR_D2S                        0x3
+#define FV_INSELR_MICBSTR_OFF                0x0
+#define FV_INSELR_MICBSTR_10DB               0x1
+#define FV_INSELR_MICBSTR_20DB               0x2
+#define FV_INSELR_MICBSTR_30DB               0x3
+
+/* Register Masks */
+#define RM_INSELR                            RM(FM_INSELR, FB_INSELR)
+#define RM_INSELR_MICBSTR \
+	 RM(FM_INSELR_MICBSTR, FB_INSELR_MICBSTR)
+
+
+/* Register Values */
+#define RV_INSELR_IN1                        RV(FV_INSELR_IN1, FB_INSELR)
+#define RV_INSELR_IN2                        RV(FV_INSELR_IN2, FB_INSELR)
+#define RV_INSELR_IN3                        RV(FV_INSELR_IN3, FB_INSELR)
+#define RV_INSELR_D2S                        RV(FV_INSELR_D2S, FB_INSELR)
+#define RV_INSELR_MICBSTR_OFF \
+	 RV(FV_INSELR_MICBSTR_OFF, FB_INSELR_MICBSTR)
+
+#define RV_INSELR_MICBSTR_10DB \
+	 RV(FV_INSELR_MICBSTR_10DB, FB_INSELR_MICBSTR)
+
+#define RV_INSELR_MICBSTR_20DB \
+	 RV(FV_INSELR_MICBSTR_20DB, FB_INSELR_MICBSTR)
+
+#define RV_INSELR_MICBSTR_30DB \
+	 RV(FV_INSELR_MICBSTR_30DB, FB_INSELR_MICBSTR)
+
+
+/***************************
+ *      R_AIC1 (0x13)      *
+ ***************************/
+
+/* Field Offsets */
+#define FB_AIC1_BCLKINV                      6
+#define FB_AIC1_MS                           5
+#define FB_AIC1_LRP                          4
+#define FB_AIC1_WL                           2
+#define FB_AIC1_FORMAT                       0
+
+/* Field Masks */
+#define FM_AIC1_BCLKINV                      0X1
+#define FM_AIC1_MS                           0X1
+#define FM_AIC1_LRP                          0X1
+#define FM_AIC1_WL                           0X3
+#define FM_AIC1_FORMAT                       0X3
+
+/* Field Values */
+#define FV_AIC1_BCLKINV_ENABLE               0x1
+#define FV_AIC1_BCLKINV_DISABLE              0x0
+#define FV_AIC1_MS_MASTER                    0x1
+#define FV_AIC1_MS_SLAVE                     0x0
+#define FV_AIC1_LRP_INVERT                   0x1
+#define FV_AIC1_LRP_NORMAL                   0x0
+#define FV_AIC1_WL_16                        0x0
+#define FV_AIC1_WL_20                        0x1
+#define FV_AIC1_WL_24                        0x2
+#define FV_AIC1_WL_32                        0x3
+#define FV_AIC1_FORMAT_RIGHT                 0x0
+#define FV_AIC1_FORMAT_LEFT                  0x1
+#define FV_AIC1_FORMAT_I2S                   0x2
+
+/* Register Masks */
+#define RM_AIC1_BCLKINV \
+	 RM(FM_AIC1_BCLKINV, FB_AIC1_BCLKINV)
+
+#define RM_AIC1_MS                           RM(FM_AIC1_MS, FB_AIC1_MS)
+#define RM_AIC1_LRP                          RM(FM_AIC1_LRP, FB_AIC1_LRP)
+#define RM_AIC1_WL                           RM(FM_AIC1_WL, FB_AIC1_WL)
+#define RM_AIC1_FORMAT                       RM(FM_AIC1_FORMAT, FB_AIC1_FORMAT)
+
+/* Register Values */
+#define RV_AIC1_BCLKINV_ENABLE \
+	 RV(FV_AIC1_BCLKINV_ENABLE, FB_AIC1_BCLKINV)
+
+#define RV_AIC1_BCLKINV_DISABLE \
+	 RV(FV_AIC1_BCLKINV_DISABLE, FB_AIC1_BCLKINV)
+
+#define RV_AIC1_MS_MASTER                    RV(FV_AIC1_MS_MASTER, FB_AIC1_MS)
+#define RV_AIC1_MS_SLAVE                     RV(FV_AIC1_MS_SLAVE, FB_AIC1_MS)
+#define RV_AIC1_LRP_INVERT \
+	 RV(FV_AIC1_LRP_INVERT, FB_AIC1_LRP)
+
+#define RV_AIC1_LRP_NORMAL \
+	 RV(FV_AIC1_LRP_NORMAL, FB_AIC1_LRP)
+
+#define RV_AIC1_WL_16                        RV(FV_AIC1_WL_16, FB_AIC1_WL)
+#define RV_AIC1_WL_20                        RV(FV_AIC1_WL_20, FB_AIC1_WL)
+#define RV_AIC1_WL_24                        RV(FV_AIC1_WL_24, FB_AIC1_WL)
+#define RV_AIC1_WL_32                        RV(FV_AIC1_WL_32, FB_AIC1_WL)
+#define RV_AIC1_FORMAT_RIGHT \
+	 RV(FV_AIC1_FORMAT_RIGHT, FB_AIC1_FORMAT)
+
+#define RV_AIC1_FORMAT_LEFT \
+	 RV(FV_AIC1_FORMAT_LEFT, FB_AIC1_FORMAT)
+
+#define RV_AIC1_FORMAT_I2S \
+	 RV(FV_AIC1_FORMAT_I2S, FB_AIC1_FORMAT)
+
+
+/***************************
+ *      R_AIC2 (0x14)      *
+ ***************************/
+
+/* Field Offsets */
+#define FB_AIC2_DACDSEL                      6
+#define FB_AIC2_ADCDSEL                      4
+#define FB_AIC2_TRI                          3
+#define FB_AIC2_BLRCM                        0
+
+/* Field Masks */
+#define FM_AIC2_DACDSEL                      0X3
+#define FM_AIC2_ADCDSEL                      0X3
+#define FM_AIC2_TRI                          0X1
+#define FM_AIC2_BLRCM                        0X7
+
+/* Field Values */
+#define FV_AIC2_BLRCM_DAC_BCLK_LRCLK_SHARED  0x3
+
+/* Register Masks */
+#define RM_AIC2_DACDSEL \
+	 RM(FM_AIC2_DACDSEL, FB_AIC2_DACDSEL)
+
+#define RM_AIC2_ADCDSEL \
+	 RM(FM_AIC2_ADCDSEL, FB_AIC2_ADCDSEL)
+
+#define RM_AIC2_TRI                          RM(FM_AIC2_TRI, FB_AIC2_TRI)
+#define RM_AIC2_BLRCM                        RM(FM_AIC2_BLRCM, FB_AIC2_BLRCM)
+
+/* Register Values */
+#define RV_AIC2_BLRCM_DAC_BCLK_LRCLK_SHARED \
+	 RV(FV_AIC2_BLRCM_DAC_BCLK_LRCLK_SHARED, FB_AIC2_BLRCM)
+
+
+/******************************
+ *      R_CNVRTR0 (0x16)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_CNVRTR0_ADCPOLR                   7
+#define FB_CNVRTR0_ADCPOLL                   6
+#define FB_CNVRTR0_AMONOMIX                  4
+#define FB_CNVRTR0_ADCMU                     3
+#define FB_CNVRTR0_HPOR                      2
+#define FB_CNVRTR0_ADCHPDR                   1
+#define FB_CNVRTR0_ADCHPDL                   0
+
+/* Field Masks */
+#define FM_CNVRTR0_ADCPOLR                   0X1
+#define FM_CNVRTR0_ADCPOLL                   0X1
+#define FM_CNVRTR0_AMONOMIX                  0X3
+#define FM_CNVRTR0_ADCMU                     0X1
+#define FM_CNVRTR0_HPOR                      0X1
+#define FM_CNVRTR0_ADCHPDR                   0X1
+#define FM_CNVRTR0_ADCHPDL                   0X1
+
+/* Field Values */
+#define FV_CNVRTR0_ADCPOLR_INVERT            0x1
+#define FV_CNVRTR0_ADCPOLR_NORMAL            0x0
+#define FV_CNVRTR0_ADCPOLL_INVERT            0x1
+#define FV_CNVRTR0_ADCPOLL_NORMAL            0x0
+#define FV_CNVRTR0_ADCMU_ENABLE              0x1
+#define FV_CNVRTR0_ADCMU_DISABLE             0x0
+#define FV_CNVRTR0_ADCHPDR_ENABLE            0x1
+#define FV_CNVRTR0_ADCHPDR_DISABLE           0x0
+#define FV_CNVRTR0_ADCHPDL_ENABLE            0x1
+#define FV_CNVRTR0_ADCHPDL_DISABLE           0x0
+
+/* Register Masks */
+#define RM_CNVRTR0_ADCPOLR \
+	 RM(FM_CNVRTR0_ADCPOLR, FB_CNVRTR0_ADCPOLR)
+
+#define RM_CNVRTR0_ADCPOLL \
+	 RM(FM_CNVRTR0_ADCPOLL, FB_CNVRTR0_ADCPOLL)
+
+#define RM_CNVRTR0_AMONOMIX \
+	 RM(FM_CNVRTR0_AMONOMIX, FB_CNVRTR0_AMONOMIX)
+
+#define RM_CNVRTR0_ADCMU \
+	 RM(FM_CNVRTR0_ADCMU, FB_CNVRTR0_ADCMU)
+
+#define RM_CNVRTR0_HPOR \
+	 RM(FM_CNVRTR0_HPOR, FB_CNVRTR0_HPOR)
+
+#define RM_CNVRTR0_ADCHPDR \
+	 RM(FM_CNVRTR0_ADCHPDR, FB_CNVRTR0_ADCHPDR)
+
+#define RM_CNVRTR0_ADCHPDL \
+	 RM(FM_CNVRTR0_ADCHPDL, FB_CNVRTR0_ADCHPDL)
+
+
+/* Register Values */
+#define RV_CNVRTR0_ADCPOLR_INVERT \
+	 RV(FV_CNVRTR0_ADCPOLR_INVERT, FB_CNVRTR0_ADCPOLR)
+
+#define RV_CNVRTR0_ADCPOLR_NORMAL \
+	 RV(FV_CNVRTR0_ADCPOLR_NORMAL, FB_CNVRTR0_ADCPOLR)
+
+#define RV_CNVRTR0_ADCPOLL_INVERT \
+	 RV(FV_CNVRTR0_ADCPOLL_INVERT, FB_CNVRTR0_ADCPOLL)
+
+#define RV_CNVRTR0_ADCPOLL_NORMAL \
+	 RV(FV_CNVRTR0_ADCPOLL_NORMAL, FB_CNVRTR0_ADCPOLL)
+
+#define RV_CNVRTR0_ADCMU_ENABLE \
+	 RV(FV_CNVRTR0_ADCMU_ENABLE, FB_CNVRTR0_ADCMU)
+
+#define RV_CNVRTR0_ADCMU_DISABLE \
+	 RV(FV_CNVRTR0_ADCMU_DISABLE, FB_CNVRTR0_ADCMU)
+
+#define RV_CNVRTR0_ADCHPDR_ENABLE \
+	 RV(FV_CNVRTR0_ADCHPDR_ENABLE, FB_CNVRTR0_ADCHPDR)
+
+#define RV_CNVRTR0_ADCHPDR_DISABLE \
+	 RV(FV_CNVRTR0_ADCHPDR_DISABLE, FB_CNVRTR0_ADCHPDR)
+
+#define RV_CNVRTR0_ADCHPDL_ENABLE \
+	 RV(FV_CNVRTR0_ADCHPDL_ENABLE, FB_CNVRTR0_ADCHPDL)
+
+#define RV_CNVRTR0_ADCHPDL_DISABLE \
+	 RV(FV_CNVRTR0_ADCHPDL_DISABLE, FB_CNVRTR0_ADCHPDL)
+
+
+/****************************
+ *      R_ADCSR (0x17)      *
+ ****************************/
+
+/* Field Offsets */
+#define FB_ADCSR_ABCM                        6
+#define FB_ADCSR_ABR                         3
+#define FB_ADCSR_ABM                         0
+
+/* Field Masks */
+#define FM_ADCSR_ABCM                        0X3
+#define FM_ADCSR_ABR                         0X3
+#define FM_ADCSR_ABM                         0X7
+
+/* Field Values */
+#define FV_ADCSR_ABCM_AUTO                   0x0
+#define FV_ADCSR_ABCM_32                     0x1
+#define FV_ADCSR_ABCM_40                     0x2
+#define FV_ADCSR_ABCM_64                     0x3
+#define FV_ADCSR_ABR_32                      0x0
+#define FV_ADCSR_ABR_44_1                    0x1
+#define FV_ADCSR_ABR_48                      0x2
+#define FV_ADCSR_ABM_PT25                    0x0
+#define FV_ADCSR_ABM_PT5                     0x1
+#define FV_ADCSR_ABM_1                       0x2
+#define FV_ADCSR_ABM_2                       0x3
+
+/* Register Masks */
+#define RM_ADCSR_ABCM                        RM(FM_ADCSR_ABCM, FB_ADCSR_ABCM)
+#define RM_ADCSR_ABR                         RM(FM_ADCSR_ABR, FB_ADCSR_ABR)
+#define RM_ADCSR_ABM                         RM(FM_ADCSR_ABM, FB_ADCSR_ABM)
+
+/* Register Values */
+#define RV_ADCSR_ABCM_AUTO \
+	 RV(FV_ADCSR_ABCM_AUTO, FB_ADCSR_ABCM)
+
+#define RV_ADCSR_ABCM_32 \
+	 RV(FV_ADCSR_ABCM_32, FB_ADCSR_ABCM)
+
+#define RV_ADCSR_ABCM_40 \
+	 RV(FV_ADCSR_ABCM_40, FB_ADCSR_ABCM)
+
+#define RV_ADCSR_ABCM_64 \
+	 RV(FV_ADCSR_ABCM_64, FB_ADCSR_ABCM)
+
+#define RV_ADCSR_ABR_32                      RV(FV_ADCSR_ABR_32, FB_ADCSR_ABR)
+#define RV_ADCSR_ABR_44_1 \
+	 RV(FV_ADCSR_ABR_44_1, FB_ADCSR_ABR)
+
+#define RV_ADCSR_ABR_48                      RV(FV_ADCSR_ABR_48, FB_ADCSR_ABR)
+#define RV_ADCSR_ABR_                        RV(FV_ADCSR_ABR_, FB_ADCSR_ABR)
+#define RV_ADCSR_ABM_PT25 \
+	 RV(FV_ADCSR_ABM_PT25, FB_ADCSR_ABM)
+
+#define RV_ADCSR_ABM_PT5                     RV(FV_ADCSR_ABM_PT5, FB_ADCSR_ABM)
+#define RV_ADCSR_ABM_1                       RV(FV_ADCSR_ABM_1, FB_ADCSR_ABM)
+#define RV_ADCSR_ABM_2                       RV(FV_ADCSR_ABM_2, FB_ADCSR_ABM)
+
+/******************************
+ *      R_CNVRTR1 (0x18)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_CNVRTR1_DACPOLR                   7
+#define FB_CNVRTR1_DACPOLL                   6
+#define FB_CNVRTR1_DMONOMIX                  4
+#define FB_CNVRTR1_DACMU                     3
+#define FB_CNVRTR1_DEEMPH                    2
+#define FB_CNVRTR1_DACDITH                   0
+
+/* Field Masks */
+#define FM_CNVRTR1_DACPOLR                   0X1
+#define FM_CNVRTR1_DACPOLL                   0X1
+#define FM_CNVRTR1_DMONOMIX                  0X3
+#define FM_CNVRTR1_DACMU                     0X1
+#define FM_CNVRTR1_DEEMPH                    0X1
+#define FM_CNVRTR1_DACDITH                   0X3
+
+/* Field Values */
+#define FV_CNVRTR1_DACPOLR_INVERT            0x1
+#define FV_CNVRTR1_DACPOLR_NORMAL            0x0
+#define FV_CNVRTR1_DACPOLL_INVERT            0x1
+#define FV_CNVRTR1_DACPOLL_NORMAL            0x0
+#define FV_CNVRTR1_DMONOMIX_ENABLE           0x1
+#define FV_CNVRTR1_DMONOMIX_DISABLE          0x0
+#define FV_CNVRTR1_DACMU_ENABLE              0x1
+#define FV_CNVRTR1_DACMU_DISABLE             0x0
+
+/* Register Masks */
+#define RM_CNVRTR1_DACPOLR \
+	 RM(FM_CNVRTR1_DACPOLR, FB_CNVRTR1_DACPOLR)
+
+#define RM_CNVRTR1_DACPOLL \
+	 RM(FM_CNVRTR1_DACPOLL, FB_CNVRTR1_DACPOLL)
+
+#define RM_CNVRTR1_DMONOMIX \
+	 RM(FM_CNVRTR1_DMONOMIX, FB_CNVRTR1_DMONOMIX)
+
+#define RM_CNVRTR1_DACMU \
+	 RM(FM_CNVRTR1_DACMU, FB_CNVRTR1_DACMU)
+
+#define RM_CNVRTR1_DEEMPH \
+	 RM(FM_CNVRTR1_DEEMPH, FB_CNVRTR1_DEEMPH)
+
+#define RM_CNVRTR1_DACDITH \
+	 RM(FM_CNVRTR1_DACDITH, FB_CNVRTR1_DACDITH)
+
+
+/* Register Values */
+#define RV_CNVRTR1_DACPOLR_INVERT \
+	 RV(FV_CNVRTR1_DACPOLR_INVERT, FB_CNVRTR1_DACPOLR)
+
+#define RV_CNVRTR1_DACPOLR_NORMAL \
+	 RV(FV_CNVRTR1_DACPOLR_NORMAL, FB_CNVRTR1_DACPOLR)
+
+#define RV_CNVRTR1_DACPOLL_INVERT \
+	 RV(FV_CNVRTR1_DACPOLL_INVERT, FB_CNVRTR1_DACPOLL)
+
+#define RV_CNVRTR1_DACPOLL_NORMAL \
+	 RV(FV_CNVRTR1_DACPOLL_NORMAL, FB_CNVRTR1_DACPOLL)
+
+#define RV_CNVRTR1_DMONOMIX_ENABLE \
+	 RV(FV_CNVRTR1_DMONOMIX_ENABLE, FB_CNVRTR1_DMONOMIX)
+
+#define RV_CNVRTR1_DMONOMIX_DISABLE \
+	 RV(FV_CNVRTR1_DMONOMIX_DISABLE, FB_CNVRTR1_DMONOMIX)
+
+#define RV_CNVRTR1_DACMU_ENABLE \
+	 RV(FV_CNVRTR1_DACMU_ENABLE, FB_CNVRTR1_DACMU)
+
+#define RV_CNVRTR1_DACMU_DISABLE \
+	 RV(FV_CNVRTR1_DACMU_DISABLE, FB_CNVRTR1_DACMU)
+
+
+/****************************
+ *      R_DACSR (0x19)      *
+ ****************************/
+
+/* Field Offsets */
+#define FB_DACSR_DBCM                        6
+#define FB_DACSR_DBR                         3
+#define FB_DACSR_DBM                         0
+
+/* Field Masks */
+#define FM_DACSR_DBCM                        0X3
+#define FM_DACSR_DBR                         0X3
+#define FM_DACSR_DBM                         0X7
+
+/* Field Values */
+#define FV_DACSR_DBCM_AUTO                   0x0
+#define FV_DACSR_DBCM_32                     0x1
+#define FV_DACSR_DBCM_40                     0x2
+#define FV_DACSR_DBCM_64                     0x3
+#define FV_DACSR_DBR_32                      0x0
+#define FV_DACSR_DBR_44_1                    0x1
+#define FV_DACSR_DBR_48                      0x2
+#define FV_DACSR_DBM_PT25                    0x0
+#define FV_DACSR_DBM_PT5                     0x1
+#define FV_DACSR_DBM_1                       0x2
+#define FV_DACSR_DBM_2                       0x3
+
+/* Register Masks */
+#define RM_DACSR_DBCM                        RM(FM_DACSR_DBCM, FB_DACSR_DBCM)
+#define RM_DACSR_DBR                         RM(FM_DACSR_DBR, FB_DACSR_DBR)
+#define RM_DACSR_DBM                         RM(FM_DACSR_DBM, FB_DACSR_DBM)
+
+/* Register Values */
+#define RV_DACSR_DBCM_AUTO \
+	 RV(FV_DACSR_DBCM_AUTO, FB_DACSR_DBCM)
+
+#define RV_DACSR_DBCM_32 \
+	 RV(FV_DACSR_DBCM_32, FB_DACSR_DBCM)
+
+#define RV_DACSR_DBCM_40 \
+	 RV(FV_DACSR_DBCM_40, FB_DACSR_DBCM)
+
+#define RV_DACSR_DBCM_64 \
+	 RV(FV_DACSR_DBCM_64, FB_DACSR_DBCM)
+
+#define RV_DACSR_DBR_32                      RV(FV_DACSR_DBR_32, FB_DACSR_DBR)
+#define RV_DACSR_DBR_44_1 \
+	 RV(FV_DACSR_DBR_44_1, FB_DACSR_DBR)
+
+#define RV_DACSR_DBR_48                      RV(FV_DACSR_DBR_48, FB_DACSR_DBR)
+#define RV_DACSR_DBM_PT25 \
+	 RV(FV_DACSR_DBM_PT25, FB_DACSR_DBM)
+
+#define RV_DACSR_DBM_PT5                     RV(FV_DACSR_DBM_PT5, FB_DACSR_DBM)
+#define RV_DACSR_DBM_1                       RV(FV_DACSR_DBM_1, FB_DACSR_DBM)
+#define RV_DACSR_DBM_2                       RV(FV_DACSR_DBM_2, FB_DACSR_DBM)
+
+/****************************
+ *      R_PWRM1 (0x1A)      *
+ ****************************/
+
+/* Field Offsets */
+#define FB_PWRM1_BSTL                        7
+#define FB_PWRM1_BSTR                        6
+#define FB_PWRM1_PGAL                        5
+#define FB_PWRM1_PGAR                        4
+#define FB_PWRM1_ADCL                        3
+#define FB_PWRM1_ADCR                        2
+#define FB_PWRM1_MICB                        1
+#define FB_PWRM1_DIGENB                      0
+
+/* Field Masks */
+#define FM_PWRM1_BSTL                        0X1
+#define FM_PWRM1_BSTR                        0X1
+#define FM_PWRM1_PGAL                        0X1
+#define FM_PWRM1_PGAR                        0X1
+#define FM_PWRM1_ADCL                        0X1
+#define FM_PWRM1_ADCR                        0X1
+#define FM_PWRM1_MICB                        0X1
+#define FM_PWRM1_DIGENB                      0X1
+
+/* Field Values */
+#define FV_PWRM1_BSTL_ENABLE                 0x1
+#define FV_PWRM1_BSTL_DISABLE                0x0
+#define FV_PWRM1_BSTR_ENABLE                 0x1
+#define FV_PWRM1_BSTR_DISABLE                0x0
+#define FV_PWRM1_PGAL_ENABLE                 0x1
+#define FV_PWRM1_PGAL_DISABLE                0x0
+#define FV_PWRM1_PGAR_ENABLE                 0x1
+#define FV_PWRM1_PGAR_DISABLE                0x0
+#define FV_PWRM1_ADCL_ENABLE                 0x1
+#define FV_PWRM1_ADCL_DISABLE                0x0
+#define FV_PWRM1_ADCR_ENABLE                 0x1
+#define FV_PWRM1_ADCR_DISABLE                0x0
+#define FV_PWRM1_MICB_ENABLE                 0x1
+#define FV_PWRM1_MICB_DISABLE                0x0
+#define FV_PWRM1_DIGENB_DISABLE              0x1
+#define FV_PWRM1_DIGENB_ENABLE               0x0
+
+/* Register Masks */
+#define RM_PWRM1_BSTL                        RM(FM_PWRM1_BSTL, FB_PWRM1_BSTL)
+#define RM_PWRM1_BSTR                        RM(FM_PWRM1_BSTR, FB_PWRM1_BSTR)
+#define RM_PWRM1_PGAL                        RM(FM_PWRM1_PGAL, FB_PWRM1_PGAL)
+#define RM_PWRM1_PGAR                        RM(FM_PWRM1_PGAR, FB_PWRM1_PGAR)
+#define RM_PWRM1_ADCL                        RM(FM_PWRM1_ADCL, FB_PWRM1_ADCL)
+#define RM_PWRM1_ADCR                        RM(FM_PWRM1_ADCR, FB_PWRM1_ADCR)
+#define RM_PWRM1_MICB                        RM(FM_PWRM1_MICB, FB_PWRM1_MICB)
+#define RM_PWRM1_DIGENB \
+	 RM(FM_PWRM1_DIGENB, FB_PWRM1_DIGENB)
+
+
+/* Register Values */
+#define RV_PWRM1_BSTL_ENABLE \
+	 RV(FV_PWRM1_BSTL_ENABLE, FB_PWRM1_BSTL)
+
+#define RV_PWRM1_BSTL_DISABLE \
+	 RV(FV_PWRM1_BSTL_DISABLE, FB_PWRM1_BSTL)
+
+#define RV_PWRM1_BSTR_ENABLE \
+	 RV(FV_PWRM1_BSTR_ENABLE, FB_PWRM1_BSTR)
+
+#define RV_PWRM1_BSTR_DISABLE \
+	 RV(FV_PWRM1_BSTR_DISABLE, FB_PWRM1_BSTR)
+
+#define RV_PWRM1_PGAL_ENABLE \
+	 RV(FV_PWRM1_PGAL_ENABLE, FB_PWRM1_PGAL)
+
+#define RV_PWRM1_PGAL_DISABLE \
+	 RV(FV_PWRM1_PGAL_DISABLE, FB_PWRM1_PGAL)
+
+#define RV_PWRM1_PGAR_ENABLE \
+	 RV(FV_PWRM1_PGAR_ENABLE, FB_PWRM1_PGAR)
+
+#define RV_PWRM1_PGAR_DISABLE \
+	 RV(FV_PWRM1_PGAR_DISABLE, FB_PWRM1_PGAR)
+
+#define RV_PWRM1_ADCL_ENABLE \
+	 RV(FV_PWRM1_ADCL_ENABLE, FB_PWRM1_ADCL)
+
+#define RV_PWRM1_ADCL_DISABLE \
+	 RV(FV_PWRM1_ADCL_DISABLE, FB_PWRM1_ADCL)
+
+#define RV_PWRM1_ADCR_ENABLE \
+	 RV(FV_PWRM1_ADCR_ENABLE, FB_PWRM1_ADCR)
+
+#define RV_PWRM1_ADCR_DISABLE \
+	 RV(FV_PWRM1_ADCR_DISABLE, FB_PWRM1_ADCR)
+
+#define RV_PWRM1_MICB_ENABLE \
+	 RV(FV_PWRM1_MICB_ENABLE, FB_PWRM1_MICB)
+
+#define RV_PWRM1_MICB_DISABLE \
+	 RV(FV_PWRM1_MICB_DISABLE, FB_PWRM1_MICB)
+
+#define RV_PWRM1_DIGENB_DISABLE \
+	 RV(FV_PWRM1_DIGENB_DISABLE, FB_PWRM1_DIGENB)
+
+#define RV_PWRM1_DIGENB_ENABLE \
+	 RV(FV_PWRM1_DIGENB_ENABLE, FB_PWRM1_DIGENB)
+
+
+/****************************
+ *      R_PWRM2 (0x1B)      *
+ ****************************/
+
+/* Field Offsets */
+#define FB_PWRM2_D2S                         7
+#define FB_PWRM2_HPL                         6
+#define FB_PWRM2_HPR                         5
+#define FB_PWRM2_SPKL                        4
+#define FB_PWRM2_SPKR                        3
+#define FB_PWRM2_INSELL                      2
+#define FB_PWRM2_INSELR                      1
+#define FB_PWRM2_VREF                        0
+
+/* Field Masks */
+#define FM_PWRM2_D2S                         0X1
+#define FM_PWRM2_HPL                         0X1
+#define FM_PWRM2_HPR                         0X1
+#define FM_PWRM2_SPKL                        0X1
+#define FM_PWRM2_SPKR                        0X1
+#define FM_PWRM2_INSELL                      0X1
+#define FM_PWRM2_INSELR                      0X1
+#define FM_PWRM2_VREF                        0X1
+
+/* Field Values */
+#define FV_PWRM2_D2S_ENABLE                  0x1
+#define FV_PWRM2_D2S_DISABLE                 0x0
+#define FV_PWRM2_HPL_ENABLE                  0x1
+#define FV_PWRM2_HPL_DISABLE                 0x0
+#define FV_PWRM2_HPR_ENABLE                  0x1
+#define FV_PWRM2_HPR_DISABLE                 0x0
+#define FV_PWRM2_SPKL_ENABLE                 0x1
+#define FV_PWRM2_SPKL_DISABLE                0x0
+#define FV_PWRM2_SPKR_ENABLE                 0x1
+#define FV_PWRM2_SPKR_DISABLE                0x0
+#define FV_PWRM2_INSELL_ENABLE               0x1
+#define FV_PWRM2_INSELL_DISABLE              0x0
+#define FV_PWRM2_INSELR_ENABLE               0x1
+#define FV_PWRM2_INSELR_DISABLE              0x0
+#define FV_PWRM2_VREF_ENABLE                 0x1
+#define FV_PWRM2_VREF_DISABLE                0x0
+
+/* Register Masks */
+#define RM_PWRM2_D2S                         RM(FM_PWRM2_D2S, FB_PWRM2_D2S)
+#define RM_PWRM2_HPL                         RM(FM_PWRM2_HPL, FB_PWRM2_HPL)
+#define RM_PWRM2_HPR                         RM(FM_PWRM2_HPR, FB_PWRM2_HPR)
+#define RM_PWRM2_SPKL                        RM(FM_PWRM2_SPKL, FB_PWRM2_SPKL)
+#define RM_PWRM2_SPKR                        RM(FM_PWRM2_SPKR, FB_PWRM2_SPKR)
+#define RM_PWRM2_INSELL \
+	 RM(FM_PWRM2_INSELL, FB_PWRM2_INSELL)
+
+#define RM_PWRM2_INSELR \
+	 RM(FM_PWRM2_INSELR, FB_PWRM2_INSELR)
+
+#define RM_PWRM2_VREF                        RM(FM_PWRM2_VREF, FB_PWRM2_VREF)
+
+/* Register Values */
+#define RV_PWRM2_D2S_ENABLE \
+	 RV(FV_PWRM2_D2S_ENABLE, FB_PWRM2_D2S)
+
+#define RV_PWRM2_D2S_DISABLE \
+	 RV(FV_PWRM2_D2S_DISABLE, FB_PWRM2_D2S)
+
+#define RV_PWRM2_HPL_ENABLE \
+	 RV(FV_PWRM2_HPL_ENABLE, FB_PWRM2_HPL)
+
+#define RV_PWRM2_HPL_DISABLE \
+	 RV(FV_PWRM2_HPL_DISABLE, FB_PWRM2_HPL)
+
+#define RV_PWRM2_HPR_ENABLE \
+	 RV(FV_PWRM2_HPR_ENABLE, FB_PWRM2_HPR)
+
+#define RV_PWRM2_HPR_DISABLE \
+	 RV(FV_PWRM2_HPR_DISABLE, FB_PWRM2_HPR)
+
+#define RV_PWRM2_SPKL_ENABLE \
+	 RV(FV_PWRM2_SPKL_ENABLE, FB_PWRM2_SPKL)
+
+#define RV_PWRM2_SPKL_DISABLE \
+	 RV(FV_PWRM2_SPKL_DISABLE, FB_PWRM2_SPKL)
+
+#define RV_PWRM2_SPKR_ENABLE \
+	 RV(FV_PWRM2_SPKR_ENABLE, FB_PWRM2_SPKR)
+
+#define RV_PWRM2_SPKR_DISABLE \
+	 RV(FV_PWRM2_SPKR_DISABLE, FB_PWRM2_SPKR)
+
+#define RV_PWRM2_INSELL_ENABLE \
+	 RV(FV_PWRM2_INSELL_ENABLE, FB_PWRM2_INSELL)
+
+#define RV_PWRM2_INSELL_DISABLE \
+	 RV(FV_PWRM2_INSELL_DISABLE, FB_PWRM2_INSELL)
+
+#define RV_PWRM2_INSELR_ENABLE \
+	 RV(FV_PWRM2_INSELR_ENABLE, FB_PWRM2_INSELR)
+
+#define RV_PWRM2_INSELR_DISABLE \
+	 RV(FV_PWRM2_INSELR_DISABLE, FB_PWRM2_INSELR)
+
+#define RV_PWRM2_VREF_ENABLE \
+	 RV(FV_PWRM2_VREF_ENABLE, FB_PWRM2_VREF)
+
+#define RV_PWRM2_VREF_DISABLE \
+	 RV(FV_PWRM2_VREF_DISABLE, FB_PWRM2_VREF)
+
+
+/******************************
+ *      R_CONFIG0 (0x1F)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_CONFIG0_ASDM                      6
+#define FB_CONFIG0_DSDM                      4
+#define FB_CONFIG0_DC_BYPASS                 1
+#define FB_CONFIG0_SD_FORCE_ON               0
+
+/* Field Masks */
+#define FM_CONFIG0_ASDM                      0X3
+#define FM_CONFIG0_DSDM                      0X3
+#define FM_CONFIG0_DC_BYPASS                 0X1
+#define FM_CONFIG0_SD_FORCE_ON               0X1
+
+/* Field Values */
+#define FV_CONFIG0_ASDM_HALF                 0x1
+#define FV_CONFIG0_ASDM_FULL                 0x2
+#define FV_CONFIG0_ASDM_AUTO                 0x3
+#define FV_CONFIG0_DSDM_HALF                 0x1
+#define FV_CONFIG0_DSDM_FULL                 0x2
+#define FV_CONFIG0_DSDM_AUTO                 0x3
+#define FV_CONFIG0_DC_BYPASS_ENABLE          0x1
+#define FV_CONFIG0_DC_BYPASS_DISABLE         0x0
+#define FV_CONFIG0_SD_FORCE_ON_ENABLE        0x1
+#define FV_CONFIG0_SD_FORCE_ON_DISABLE       0x0
+
+/* Register Masks */
+#define RM_CONFIG0_ASDM \
+	 RM(FM_CONFIG0_ASDM, FB_CONFIG0_ASDM)
+
+#define RM_CONFIG0_DSDM \
+	 RM(FM_CONFIG0_DSDM, FB_CONFIG0_DSDM)
+
+#define RM_CONFIG0_DC_BYPASS \
+	 RM(FM_CONFIG0_DC_BYPASS, FB_CONFIG0_DC_BYPASS)
+
+#define RM_CONFIG0_SD_FORCE_ON \
+	 RM(FM_CONFIG0_SD_FORCE_ON, FB_CONFIG0_SD_FORCE_ON)
+
+
+/* Register Values */
+#define RV_CONFIG0_ASDM_HALF \
+	 RV(FV_CONFIG0_ASDM_HALF, FB_CONFIG0_ASDM)
+
+#define RV_CONFIG0_ASDM_FULL \
+	 RV(FV_CONFIG0_ASDM_FULL, FB_CONFIG0_ASDM)
+
+#define RV_CONFIG0_ASDM_AUTO \
+	 RV(FV_CONFIG0_ASDM_AUTO, FB_CONFIG0_ASDM)
+
+#define RV_CONFIG0_DSDM_HALF \
+	 RV(FV_CONFIG0_DSDM_HALF, FB_CONFIG0_DSDM)
+
+#define RV_CONFIG0_DSDM_FULL \
+	 RV(FV_CONFIG0_DSDM_FULL, FB_CONFIG0_DSDM)
+
+#define RV_CONFIG0_DSDM_AUTO \
+	 RV(FV_CONFIG0_DSDM_AUTO, FB_CONFIG0_DSDM)
+
+#define RV_CONFIG0_DC_BYPASS_ENABLE \
+	 RV(FV_CONFIG0_DC_BYPASS_ENABLE, FB_CONFIG0_DC_BYPASS)
+
+#define RV_CONFIG0_DC_BYPASS_DISABLE \
+	 RV(FV_CONFIG0_DC_BYPASS_DISABLE, FB_CONFIG0_DC_BYPASS)
+
+#define RV_CONFIG0_SD_FORCE_ON_ENABLE \
+	 RV(FV_CONFIG0_SD_FORCE_ON_ENABLE, FB_CONFIG0_SD_FORCE_ON)
+
+#define RV_CONFIG0_SD_FORCE_ON_DISABLE \
+	 RV(FV_CONFIG0_SD_FORCE_ON_DISABLE, FB_CONFIG0_SD_FORCE_ON)
+
+
+/******************************
+ *      R_CONFIG1 (0x20)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_CONFIG1_EQ2_EN                    7
+#define FB_CONFIG1_EQ2_BE                    4
+#define FB_CONFIG1_EQ1_EN                    3
+#define FB_CONFIG1_EQ1_BE                    0
+
+/* Field Masks */
+#define FM_CONFIG1_EQ2_EN                    0X1
+#define FM_CONFIG1_EQ2_BE                    0X7
+#define FM_CONFIG1_EQ1_EN                    0X1
+#define FM_CONFIG1_EQ1_BE                    0X7
+
+/* Field Values */
+#define FV_CONFIG1_EQ2_EN_ENABLE             0x1
+#define FV_CONFIG1_EQ2_EN_DISABLE            0x0
+#define FV_CONFIG1_EQ2_BE_PRE                0x0
+#define FV_CONFIG1_EQ2_BE_PRE_EQ_0           0x1
+#define FV_CONFIG1_EQ2_BE_PRE_EQ0_1          0x2
+#define FV_CONFIG1_EQ2_BE_PRE_EQ0_2          0x3
+#define FV_CONFIG1_EQ2_BE_PRE_EQ0_3          0x4
+#define FV_CONFIG1_EQ2_BE_PRE_EQ0_4          0x5
+#define FV_CONFIG1_EQ2_BE_PRE_EQ0_5          0x6
+#define FV_CONFIG1_EQ1_EN_ENABLE             0x1
+#define FV_CONFIG1_EQ1_EN_DISABLE            0x0
+#define FV_CONFIG1_EQ1_BE_PRE                0x0
+#define FV_CONFIG1_EQ1_BE_PRE_EQ_0           0x1
+#define FV_CONFIG1_EQ1_BE_PRE_EQ0_1          0x2
+#define FV_CONFIG1_EQ1_BE_PRE_EQ0_2          0x3
+#define FV_CONFIG1_EQ1_BE_PRE_EQ0_3          0x4
+#define FV_CONFIG1_EQ1_BE_PRE_EQ0_4          0x5
+#define FV_CONFIG1_EQ1_BE_PRE_EQ0_5          0x6
+
+/* Register Masks */
+#define RM_CONFIG1_EQ2_EN \
+	 RM(FM_CONFIG1_EQ2_EN, FB_CONFIG1_EQ2_EN)
+
+#define RM_CONFIG1_EQ2_BE \
+	 RM(FM_CONFIG1_EQ2_BE, FB_CONFIG1_EQ2_BE)
+
+#define RM_CONFIG1_EQ1_EN \
+	 RM(FM_CONFIG1_EQ1_EN, FB_CONFIG1_EQ1_EN)
+
+#define RM_CONFIG1_EQ1_BE \
+	 RM(FM_CONFIG1_EQ1_BE, FB_CONFIG1_EQ1_BE)
+
+
+/* Register Values */
+#define RV_CONFIG1_EQ2_EN_ENABLE \
+	 RV(FV_CONFIG1_EQ2_EN_ENABLE, FB_CONFIG1_EQ2_EN)
+
+#define RV_CONFIG1_EQ2_EN_DISABLE \
+	 RV(FV_CONFIG1_EQ2_EN_DISABLE, FB_CONFIG1_EQ2_EN)
+
+#define RV_CONFIG1_EQ2_BE_PRE \
+	 RV(FV_CONFIG1_EQ2_BE_PRE, FB_CONFIG1_EQ2_BE)
+
+#define RV_CONFIG1_EQ2_BE_PRE_EQ_0 \
+	 RV(FV_CONFIG1_EQ2_BE_PRE_EQ_0, FB_CONFIG1_EQ2_BE)
+
+#define RV_CONFIG1_EQ2_BE_PRE_EQ0_1 \
+	 RV(FV_CONFIG1_EQ2_BE_PRE_EQ0_1, FB_CONFIG1_EQ2_BE)
+
+#define RV_CONFIG1_EQ2_BE_PRE_EQ0_2 \
+	 RV(FV_CONFIG1_EQ2_BE_PRE_EQ0_2, FB_CONFIG1_EQ2_BE)
+
+#define RV_CONFIG1_EQ2_BE_PRE_EQ0_3 \
+	 RV(FV_CONFIG1_EQ2_BE_PRE_EQ0_3, FB_CONFIG1_EQ2_BE)
+
+#define RV_CONFIG1_EQ2_BE_PRE_EQ0_4 \
+	 RV(FV_CONFIG1_EQ2_BE_PRE_EQ0_4, FB_CONFIG1_EQ2_BE)
+
+#define RV_CONFIG1_EQ2_BE_PRE_EQ0_5 \
+	 RV(FV_CONFIG1_EQ2_BE_PRE_EQ0_5, FB_CONFIG1_EQ2_BE)
+
+#define RV_CONFIG1_EQ1_EN_ENABLE \
+	 RV(FV_CONFIG1_EQ1_EN_ENABLE, FB_CONFIG1_EQ1_EN)
+
+#define RV_CONFIG1_EQ1_EN_DISABLE \
+	 RV(FV_CONFIG1_EQ1_EN_DISABLE, FB_CONFIG1_EQ1_EN)
+
+#define RV_CONFIG1_EQ1_BE_PRE \
+	 RV(FV_CONFIG1_EQ1_BE_PRE, FB_CONFIG1_EQ1_BE)
+
+#define RV_CONFIG1_EQ1_BE_PRE_EQ_0 \
+	 RV(FV_CONFIG1_EQ1_BE_PRE_EQ_0, FB_CONFIG1_EQ1_BE)
+
+#define RV_CONFIG1_EQ1_BE_PRE_EQ0_1 \
+	 RV(FV_CONFIG1_EQ1_BE_PRE_EQ0_1, FB_CONFIG1_EQ1_BE)
+
+#define RV_CONFIG1_EQ1_BE_PRE_EQ0_2 \
+	 RV(FV_CONFIG1_EQ1_BE_PRE_EQ0_2, FB_CONFIG1_EQ1_BE)
+
+#define RV_CONFIG1_EQ1_BE_PRE_EQ0_3 \
+	 RV(FV_CONFIG1_EQ1_BE_PRE_EQ0_3, FB_CONFIG1_EQ1_BE)
+
+#define RV_CONFIG1_EQ1_BE_PRE_EQ0_4 \
+	 RV(FV_CONFIG1_EQ1_BE_PRE_EQ0_4, FB_CONFIG1_EQ1_BE)
+
+#define RV_CONFIG1_EQ1_BE_PRE_EQ0_5 \
+	 RV(FV_CONFIG1_EQ1_BE_PRE_EQ0_5, FB_CONFIG1_EQ1_BE)
+
+
+/******************************
+ *      R_DMICCTL (0x24)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_DMICCTL_DMICEN                    7
+#define FB_DMICCTL_DMONO                     4
+#define FB_DMICCTL_DMPHADJ                   2
+#define FB_DMICCTL_DMRATE                    0
+
+/* Field Masks */
+#define FM_DMICCTL_DMICEN                    0X1
+#define FM_DMICCTL_DMONO                     0X1
+#define FM_DMICCTL_DMPHADJ                   0X3
+#define FM_DMICCTL_DMRATE                    0X3
+
+/* Field Values */
+#define FV_DMICCTL_DMICEN_ENABLE             0x1
+#define FV_DMICCTL_DMICEN_DISABLE            0x0
+#define FV_DMICCTL_DMONO_STEREO              0x0
+#define FV_DMICCTL_DMONO_MONO                0x1
+
+/* Register Masks */
+#define RM_DMICCTL_DMICEN \
+	 RM(FM_DMICCTL_DMICEN, FB_DMICCTL_DMICEN)
+
+#define RM_DMICCTL_DMONO \
+	 RM(FM_DMICCTL_DMONO, FB_DMICCTL_DMONO)
+
+#define RM_DMICCTL_DMPHADJ \
+	 RM(FM_DMICCTL_DMPHADJ, FB_DMICCTL_DMPHADJ)
+
+#define RM_DMICCTL_DMRATE \
+	 RM(FM_DMICCTL_DMRATE, FB_DMICCTL_DMRATE)
+
+
+/* Register Values */
+#define RV_DMICCTL_DMICEN_ENABLE \
+	 RV(FV_DMICCTL_DMICEN_ENABLE, FB_DMICCTL_DMICEN)
+
+#define RV_DMICCTL_DMICEN_DISABLE \
+	 RV(FV_DMICCTL_DMICEN_DISABLE, FB_DMICCTL_DMICEN)
+
+#define RV_DMICCTL_DMONO_STEREO \
+	 RV(FV_DMICCTL_DMONO_STEREO, FB_DMICCTL_DMONO)
+
+#define RV_DMICCTL_DMONO_MONO \
+	 RV(FV_DMICCTL_DMONO_MONO, FB_DMICCTL_DMONO)
+
+
+/*****************************
+ *      R_CLECTL (0x25)      *
+ *****************************/
+
+/* Field Offsets */
+#define FB_CLECTL_LVL_MODE                   4
+#define FB_CLECTL_WINDOWSEL                  3
+#define FB_CLECTL_EXP_EN                     2
+#define FB_CLECTL_LIMIT_EN                   1
+#define FB_CLECTL_COMP_EN                    0
+
+/* Field Masks */
+#define FM_CLECTL_LVL_MODE                   0X1
+#define FM_CLECTL_WINDOWSEL                  0X1
+#define FM_CLECTL_EXP_EN                     0X1
+#define FM_CLECTL_LIMIT_EN                   0X1
+#define FM_CLECTL_COMP_EN                    0X1
+
+/* Field Values */
+#define FV_CLECTL_LVL_MODE_AVG               0x0
+#define FV_CLECTL_LVL_MODE_PEAK              0x1
+#define FV_CLECTL_WINDOWSEL_512              0x0
+#define FV_CLECTL_WINDOWSEL_64               0x1
+#define FV_CLECTL_EXP_EN_ENABLE              0x1
+#define FV_CLECTL_EXP_EN_DISABLE             0x0
+#define FV_CLECTL_LIMIT_EN_ENABLE            0x1
+#define FV_CLECTL_LIMIT_EN_DISABLE           0x0
+#define FV_CLECTL_COMP_EN_ENABLE             0x1
+#define FV_CLECTL_COMP_EN_DISABLE            0x0
+
+/* Register Masks */
+#define RM_CLECTL_LVL_MODE \
+	 RM(FM_CLECTL_LVL_MODE, FB_CLECTL_LVL_MODE)
+
+#define RM_CLECTL_WINDOWSEL \
+	 RM(FM_CLECTL_WINDOWSEL, FB_CLECTL_WINDOWSEL)
+
+#define RM_CLECTL_EXP_EN \
+	 RM(FM_CLECTL_EXP_EN, FB_CLECTL_EXP_EN)
+
+#define RM_CLECTL_LIMIT_EN \
+	 RM(FM_CLECTL_LIMIT_EN, FB_CLECTL_LIMIT_EN)
+
+#define RM_CLECTL_COMP_EN \
+	 RM(FM_CLECTL_COMP_EN, FB_CLECTL_COMP_EN)
+
+
+/* Register Values */
+#define RV_CLECTL_LVL_MODE_AVG \
+	 RV(FV_CLECTL_LVL_MODE_AVG, FB_CLECTL_LVL_MODE)
+
+#define RV_CLECTL_LVL_MODE_PEAK \
+	 RV(FV_CLECTL_LVL_MODE_PEAK, FB_CLECTL_LVL_MODE)
+
+#define RV_CLECTL_WINDOWSEL_512 \
+	 RV(FV_CLECTL_WINDOWSEL_512, FB_CLECTL_WINDOWSEL)
+
+#define RV_CLECTL_WINDOWSEL_64 \
+	 RV(FV_CLECTL_WINDOWSEL_64, FB_CLECTL_WINDOWSEL)
+
+#define RV_CLECTL_EXP_EN_ENABLE \
+	 RV(FV_CLECTL_EXP_EN_ENABLE, FB_CLECTL_EXP_EN)
+
+#define RV_CLECTL_EXP_EN_DISABLE \
+	 RV(FV_CLECTL_EXP_EN_DISABLE, FB_CLECTL_EXP_EN)
+
+#define RV_CLECTL_LIMIT_EN_ENABLE \
+	 RV(FV_CLECTL_LIMIT_EN_ENABLE, FB_CLECTL_LIMIT_EN)
+
+#define RV_CLECTL_LIMIT_EN_DISABLE \
+	 RV(FV_CLECTL_LIMIT_EN_DISABLE, FB_CLECTL_LIMIT_EN)
+
+#define RV_CLECTL_COMP_EN_ENABLE \
+	 RV(FV_CLECTL_COMP_EN_ENABLE, FB_CLECTL_COMP_EN)
+
+#define RV_CLECTL_COMP_EN_DISABLE \
+	 RV(FV_CLECTL_COMP_EN_DISABLE, FB_CLECTL_COMP_EN)
+
+
+/*****************************
+ *      R_MUGAIN (0x26)      *
+ *****************************/
+
+/* Field Offsets */
+#define FB_MUGAIN_CLEMUG                     0
+
+/* Field Masks */
+#define FM_MUGAIN_CLEMUG                     0X1F
+
+/* Field Values */
+#define FV_MUGAIN_CLEMUG_46PT5DB             0x1F
+#define FV_MUGAIN_CLEMUG_0DB                 0x0
+
+/* Register Masks */
+#define RM_MUGAIN_CLEMUG \
+	 RM(FM_MUGAIN_CLEMUG, FB_MUGAIN_CLEMUG)
+
+
+/* Register Values */
+#define RV_MUGAIN_CLEMUG_46PT5DB \
+	 RV(FV_MUGAIN_CLEMUG_46PT5DB, FB_MUGAIN_CLEMUG)
+
+#define RV_MUGAIN_CLEMUG_0DB \
+	 RV(FV_MUGAIN_CLEMUG_0DB, FB_MUGAIN_CLEMUG)
+
+
+/*****************************
+ *      R_COMPTH (0x27)      *
+ *****************************/
+
+/* Field Offsets */
+#define FB_COMPTH                            0
+
+/* Field Masks */
+#define FM_COMPTH                            0XFF
+
+/* Field Values */
+#define FV_COMPTH_0DB                        0xFF
+#define FV_COMPTH_N95PT625DB                 0x0
+
+/* Register Masks */
+#define RM_COMPTH                            RM(FM_COMPTH, FB_COMPTH)
+
+/* Register Values */
+#define RV_COMPTH_0DB                        RV(FV_COMPTH_0DB, FB_COMPTH)
+#define RV_COMPTH_N95PT625DB \
+	 RV(FV_COMPTH_N95PT625DB, FB_COMPTH)
+
+
+/*****************************
+ *      R_CMPRAT (0x28)      *
+ *****************************/
+
+/* Field Offsets */
+#define FB_CMPRAT                            0
+
+/* Field Masks */
+#define FM_CMPRAT                            0X1F
+
+/* Register Masks */
+#define RM_CMPRAT                            RM(FM_CMPRAT, FB_CMPRAT)
+
+/******************************
+ *      R_CATKTCL (0x29)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_CATKTCL                           0
+
+/* Field Masks */
+#define FM_CATKTCL                           0XFF
+
+/* Register Masks */
+#define RM_CATKTCL                           RM(FM_CATKTCL, FB_CATKTCL)
+
+/******************************
+ *      R_CATKTCH (0x2A)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_CATKTCH                           0
+
+/* Field Masks */
+#define FM_CATKTCH                           0XFF
+
+/* Register Masks */
+#define RM_CATKTCH                           RM(FM_CATKTCH, FB_CATKTCH)
+
+/******************************
+ *      R_CRELTCL (0x2B)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_CRELTCL                           0
+
+/* Field Masks */
+#define FM_CRELTCL                           0XFF
+
+/* Register Masks */
+#define RM_CRELTCL                           RM(FM_CRELTCL, FB_CRELTCL)
+
+/******************************
+ *      R_CRELTCH (0x2C)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_CRELTCH                           0
+
+/* Field Masks */
+#define FM_CRELTCH                           0XFF
+
+/* Register Masks */
+#define RM_CRELTCH                           RM(FM_CRELTCH, FB_CRELTCH)
+
+/****************************
+ *      R_LIMTH (0x2D)      *
+ ****************************/
+
+/* Field Offsets */
+#define FB_LIMTH                             0
+
+/* Field Masks */
+#define FM_LIMTH                             0XFF
+
+/* Field Values */
+#define FV_LIMTH_0DB                         0xFF
+#define FV_LIMTH_N95PT625DB                  0x0
+
+/* Register Masks */
+#define RM_LIMTH                             RM(FM_LIMTH, FB_LIMTH)
+
+/* Register Values */
+#define RV_LIMTH_0DB                         RV(FV_LIMTH_0DB, FB_LIMTH)
+#define RV_LIMTH_N95PT625DB                  RV(FV_LIMTH_N95PT625DB, FB_LIMTH)
+
+/*****************************
+ *      R_LIMTGT (0x2E)      *
+ *****************************/
+
+/* Field Offsets */
+#define FB_LIMTGT                            0
+
+/* Field Masks */
+#define FM_LIMTGT                            0XFF
+
+/* Field Values */
+#define FV_LIMTGT_0DB                        0xFF
+#define FV_LIMTGT_N95PT625DB                 0x0
+
+/* Register Masks */
+#define RM_LIMTGT                            RM(FM_LIMTGT, FB_LIMTGT)
+
+/* Register Values */
+#define RV_LIMTGT_0DB                        RV(FV_LIMTGT_0DB, FB_LIMTGT)
+#define RV_LIMTGT_N95PT625DB \
+	 RV(FV_LIMTGT_N95PT625DB, FB_LIMTGT)
+
+
+/******************************
+ *      R_LATKTCL (0x2F)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_LATKTCL                           0
+
+/* Field Masks */
+#define FM_LATKTCL                           0XFF
+
+/* Register Masks */
+#define RM_LATKTCL                           RM(FM_LATKTCL, FB_LATKTCL)
+
+/******************************
+ *      R_LATKTCH (0x30)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_LATKTCH                           0
+
+/* Field Masks */
+#define FM_LATKTCH                           0XFF
+
+/* Register Masks */
+#define RM_LATKTCH                           RM(FM_LATKTCH, FB_LATKTCH)
+
+/******************************
+ *      R_LRELTCL (0x31)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_LRELTCL                           0
+
+/* Field Masks */
+#define FM_LRELTCL                           0XFF
+
+/* Register Masks */
+#define RM_LRELTCL                           RM(FM_LRELTCL, FB_LRELTCL)
+
+/******************************
+ *      R_LRELTCH (0x32)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_LRELTCH                           0
+
+/* Field Masks */
+#define FM_LRELTCH                           0XFF
+
+/* Register Masks */
+#define RM_LRELTCH                           RM(FM_LRELTCH, FB_LRELTCH)
+
+/****************************
+ *      R_EXPTH (0x33)      *
+ ****************************/
+
+/* Field Offsets */
+#define FB_EXPTH                             0
+
+/* Field Masks */
+#define FM_EXPTH                             0XFF
+
+/* Field Values */
+#define FV_EXPTH_0DB                         0xFF
+#define FV_EXPTH_N95PT625DB                  0x0
+
+/* Register Masks */
+#define RM_EXPTH                             RM(FM_EXPTH, FB_EXPTH)
+
+/* Register Values */
+#define RV_EXPTH_0DB                         RV(FV_EXPTH_0DB, FB_EXPTH)
+#define RV_EXPTH_N95PT625DB                  RV(FV_EXPTH_N95PT625DB, FB_EXPTH)
+
+/*****************************
+ *      R_EXPRAT (0x34)      *
+ *****************************/
+
+/* Field Offsets */
+#define FB_EXPRAT                            0
+
+/* Field Masks */
+#define FM_EXPRAT                            0X7
+
+/* Register Masks */
+#define RM_EXPRAT                            RM(FM_EXPRAT, FB_EXPRAT)
+
+/******************************
+ *      R_XATKTCL (0x35)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_XATKTCL                           0
+
+/* Field Masks */
+#define FM_XATKTCL                           0XFF
+
+/* Register Masks */
+#define RM_XATKTCL                           RM(FM_XATKTCL, FB_XATKTCL)
+
+/******************************
+ *      R_XATKTCH (0x36)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_XATKTCH                           0
+
+/* Field Masks */
+#define FM_XATKTCH                           0XFF
+
+/* Register Masks */
+#define RM_XATKTCH                           RM(FM_XATKTCH, FB_XATKTCH)
+
+/******************************
+ *      R_XRELTCL (0x37)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_XRELTCL                           0
+
+/* Field Masks */
+#define FM_XRELTCL                           0XFF
+
+/* Register Masks */
+#define RM_XRELTCL                           RM(FM_XRELTCL, FB_XRELTCL)
+
+/******************************
+ *      R_XRELTCH (0x38)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_XRELTCH                           0
+
+/* Field Masks */
+#define FM_XRELTCH                           0XFF
+
+/* Register Masks */
+#define RM_XRELTCH                           RM(FM_XRELTCH, FB_XRELTCH)
+
+/****************************
+ *      R_FXCTL (0x39)      *
+ ****************************/
+
+/* Field Offsets */
+#define FB_FXCTL_3DEN                        4
+#define FB_FXCTL_TEEN                        3
+#define FB_FXCTL_TNLFBYPASS                  2
+#define FB_FXCTL_BEEN                        1
+#define FB_FXCTL_BNLFBYPASS                  0
+
+/* Field Masks */
+#define FM_FXCTL_3DEN                        0X1
+#define FM_FXCTL_TEEN                        0X1
+#define FM_FXCTL_TNLFBYPASS                  0X1
+#define FM_FXCTL_BEEN                        0X1
+#define FM_FXCTL_BNLFBYPASS                  0X1
+
+/* Field Values */
+#define FV_FXCTL_3DEN_ENABLE                 0x1
+#define FV_FXCTL_3DEN_DISABLE                0x0
+#define FV_FXCTL_TEEN_ENABLE                 0x1
+#define FV_FXCTL_TEEN_DISABLE                0x0
+#define FV_FXCTL_TNLFBYPASS_ENABLE           0x1
+#define FV_FXCTL_TNLFBYPASS_DISABLE          0x0
+#define FV_FXCTL_BEEN_ENABLE                 0x1
+#define FV_FXCTL_BEEN_DISABLE                0x0
+#define FV_FXCTL_BNLFBYPASS_ENABLE           0x1
+#define FV_FXCTL_BNLFBYPASS_DISABLE          0x0
+
+/* Register Masks */
+#define RM_FXCTL_3DEN                        RM(FM_FXCTL_3DEN, FB_FXCTL_3DEN)
+#define RM_FXCTL_TEEN                        RM(FM_FXCTL_TEEN, FB_FXCTL_TEEN)
+#define RM_FXCTL_TNLFBYPASS \
+	 RM(FM_FXCTL_TNLFBYPASS, FB_FXCTL_TNLFBYPASS)
+
+#define RM_FXCTL_BEEN                        RM(FM_FXCTL_BEEN, FB_FXCTL_BEEN)
+#define RM_FXCTL_BNLFBYPASS \
+	 RM(FM_FXCTL_BNLFBYPASS, FB_FXCTL_BNLFBYPASS)
+
+
+/* Register Values */
+#define RV_FXCTL_3DEN_ENABLE \
+	 RV(FV_FXCTL_3DEN_ENABLE, FB_FXCTL_3DEN)
+
+#define RV_FXCTL_3DEN_DISABLE \
+	 RV(FV_FXCTL_3DEN_DISABLE, FB_FXCTL_3DEN)
+
+#define RV_FXCTL_TEEN_ENABLE \
+	 RV(FV_FXCTL_TEEN_ENABLE, FB_FXCTL_TEEN)
+
+#define RV_FXCTL_TEEN_DISABLE \
+	 RV(FV_FXCTL_TEEN_DISABLE, FB_FXCTL_TEEN)
+
+#define RV_FXCTL_TNLFBYPASS_ENABLE \
+	 RV(FV_FXCTL_TNLFBYPASS_ENABLE, FB_FXCTL_TNLFBYPASS)
+
+#define RV_FXCTL_TNLFBYPASS_DISABLE \
+	 RV(FV_FXCTL_TNLFBYPASS_DISABLE, FB_FXCTL_TNLFBYPASS)
+
+#define RV_FXCTL_BEEN_ENABLE \
+	 RV(FV_FXCTL_BEEN_ENABLE, FB_FXCTL_BEEN)
+
+#define RV_FXCTL_BEEN_DISABLE \
+	 RV(FV_FXCTL_BEEN_DISABLE, FB_FXCTL_BEEN)
+
+#define RV_FXCTL_BNLFBYPASS_ENABLE \
+	 RV(FV_FXCTL_BNLFBYPASS_ENABLE, FB_FXCTL_BNLFBYPASS)
+
+#define RV_FXCTL_BNLFBYPASS_DISABLE \
+	 RV(FV_FXCTL_BNLFBYPASS_DISABLE, FB_FXCTL_BNLFBYPASS)
+
+
+/*******************************
+ *      R_DACCRWRL (0x3A)      *
+ *******************************/
+
+/* Field Offsets */
+#define FB_DACCRWRL_DACCRWDL                 0
+
+/* Field Masks */
+#define FM_DACCRWRL_DACCRWDL                 0XFF
+
+/* Register Masks */
+#define RM_DACCRWRL_DACCRWDL \
+	 RM(FM_DACCRWRL_DACCRWDL, FB_DACCRWRL_DACCRWDL)
+
+
+/*******************************
+ *      R_DACCRWRM (0x3B)      *
+ *******************************/
+
+/* Field Offsets */
+#define FB_DACCRWRM_DACCRWDM                 0
+
+/* Field Masks */
+#define FM_DACCRWRM_DACCRWDM                 0XFF
+
+/* Register Masks */
+#define RM_DACCRWRM_DACCRWDM \
+	 RM(FM_DACCRWRM_DACCRWDM, FB_DACCRWRM_DACCRWDM)
+
+
+/*******************************
+ *      R_DACCRWRH (0x3C)      *
+ *******************************/
+
+/* Field Offsets */
+#define FB_DACCRWRH_DACCRWDH                 0
+
+/* Field Masks */
+#define FM_DACCRWRH_DACCRWDH                 0XFF
+
+/* Register Masks */
+#define RM_DACCRWRH_DACCRWDH \
+	 RM(FM_DACCRWRH_DACCRWDH, FB_DACCRWRH_DACCRWDH)
+
+
+/*******************************
+ *      R_DACCRRDL (0x3D)      *
+ *******************************/
+
+/* Field Offsets */
+#define FB_DACCRRDL                          0
+
+/* Field Masks */
+#define FM_DACCRRDL                          0XFF
+
+/* Register Masks */
+#define RM_DACCRRDL                          RM(FM_DACCRRDL, FB_DACCRRDL)
+
+/*******************************
+ *      R_DACCRRDM (0x3E)      *
+ *******************************/
+
+/* Field Offsets */
+#define FB_DACCRRDM                          0
+
+/* Field Masks */
+#define FM_DACCRRDM                          0XFF
+
+/* Register Masks */
+#define RM_DACCRRDM                          RM(FM_DACCRRDM, FB_DACCRRDM)
+
+/*******************************
+ *      R_DACCRRDH (0x3F)      *
+ *******************************/
+
+/* Field Offsets */
+#define FB_DACCRRDH                          0
+
+/* Field Masks */
+#define FM_DACCRRDH                          0XFF
+
+/* Register Masks */
+#define RM_DACCRRDH                          RM(FM_DACCRRDH, FB_DACCRRDH)
+
+/********************************
+ *      R_DACCRADDR (0x40)      *
+ ********************************/
+
+/* Field Offsets */
+#define FB_DACCRADDR_DACCRADD                0
+
+/* Field Masks */
+#define FM_DACCRADDR_DACCRADD                0XFF
+
+/* Register Masks */
+#define RM_DACCRADDR_DACCRADD \
+	 RM(FM_DACCRADDR_DACCRADD, FB_DACCRADDR_DACCRADD)
+
+
+/******************************
+ *      R_DCOFSEL (0x41)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_DCOFSEL_DC_COEF_SEL               0
+
+/* Field Masks */
+#define FM_DCOFSEL_DC_COEF_SEL               0X7
+
+/* Field Values */
+#define FV_DCOFSEL_DC_COEF_SEL_2_N8          0x0
+#define FV_DCOFSEL_DC_COEF_SEL_2_N9          0x1
+#define FV_DCOFSEL_DC_COEF_SEL_2_N10         0x2
+#define FV_DCOFSEL_DC_COEF_SEL_2_N11         0x3
+#define FV_DCOFSEL_DC_COEF_SEL_2_N12         0x4
+#define FV_DCOFSEL_DC_COEF_SEL_2_N13         0x5
+#define FV_DCOFSEL_DC_COEF_SEL_2_N14         0x6
+#define FV_DCOFSEL_DC_COEF_SEL_2_N15         0x7
+
+/* Register Masks */
+#define RM_DCOFSEL_DC_COEF_SEL \
+	 RM(FM_DCOFSEL_DC_COEF_SEL, FB_DCOFSEL_DC_COEF_SEL)
+
+
+/* Register Values */
+#define RV_DCOFSEL_DC_COEF_SEL_2_N8 \
+	 RV(FV_DCOFSEL_DC_COEF_SEL_2_N8, FB_DCOFSEL_DC_COEF_SEL)
+
+#define RV_DCOFSEL_DC_COEF_SEL_2_N9 \
+	 RV(FV_DCOFSEL_DC_COEF_SEL_2_N9, FB_DCOFSEL_DC_COEF_SEL)
+
+#define RV_DCOFSEL_DC_COEF_SEL_2_N10 \
+	 RV(FV_DCOFSEL_DC_COEF_SEL_2_N10, FB_DCOFSEL_DC_COEF_SEL)
+
+#define RV_DCOFSEL_DC_COEF_SEL_2_N11 \
+	 RV(FV_DCOFSEL_DC_COEF_SEL_2_N11, FB_DCOFSEL_DC_COEF_SEL)
+
+#define RV_DCOFSEL_DC_COEF_SEL_2_N12 \
+	 RV(FV_DCOFSEL_DC_COEF_SEL_2_N12, FB_DCOFSEL_DC_COEF_SEL)
+
+#define RV_DCOFSEL_DC_COEF_SEL_2_N13 \
+	 RV(FV_DCOFSEL_DC_COEF_SEL_2_N13, FB_DCOFSEL_DC_COEF_SEL)
+
+#define RV_DCOFSEL_DC_COEF_SEL_2_N14 \
+	 RV(FV_DCOFSEL_DC_COEF_SEL_2_N14, FB_DCOFSEL_DC_COEF_SEL)
+
+#define RV_DCOFSEL_DC_COEF_SEL_2_N15 \
+	 RV(FV_DCOFSEL_DC_COEF_SEL_2_N15, FB_DCOFSEL_DC_COEF_SEL)
+
+
+/******************************
+ *      R_PLLCTL9 (0x4E)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_PLLCTL9_REFDIV_PLL1               0
+
+/* Field Masks */
+#define FM_PLLCTL9_REFDIV_PLL1               0XFF
+
+/* Register Masks */
+#define RM_PLLCTL9_REFDIV_PLL1 \
+	 RM(FM_PLLCTL9_REFDIV_PLL1, FB_PLLCTL9_REFDIV_PLL1)
+
+
+/******************************
+ *      R_PLLCTLA (0x4F)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_PLLCTLA_OUTDIV_PLL1               0
+
+/* Field Masks */
+#define FM_PLLCTLA_OUTDIV_PLL1               0XFF
+
+/* Register Masks */
+#define RM_PLLCTLA_OUTDIV_PLL1 \
+	 RM(FM_PLLCTLA_OUTDIV_PLL1, FB_PLLCTLA_OUTDIV_PLL1)
+
+
+/******************************
+ *      R_PLLCTLB (0x50)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_PLLCTLB_FBDIV_PLL1L               0
+
+/* Field Masks */
+#define FM_PLLCTLB_FBDIV_PLL1L               0XFF
+
+/* Register Masks */
+#define RM_PLLCTLB_FBDIV_PLL1L \
+	 RM(FM_PLLCTLB_FBDIV_PLL1L, FB_PLLCTLB_FBDIV_PLL1L)
+
+
+/******************************
+ *      R_PLLCTLC (0x51)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_PLLCTLC_FBDIV_PLL1H               0
+
+/* Field Masks */
+#define FM_PLLCTLC_FBDIV_PLL1H               0X7
+
+/* Register Masks */
+#define RM_PLLCTLC_FBDIV_PLL1H \
+	 RM(FM_PLLCTLC_FBDIV_PLL1H, FB_PLLCTLC_FBDIV_PLL1H)
+
+
+/******************************
+ *      R_PLLCTLD (0x52)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_PLLCTLD_RZ_PLL1                   3
+#define FB_PLLCTLD_CP_PLL1                   0
+
+/* Field Masks */
+#define FM_PLLCTLD_RZ_PLL1                   0X7
+#define FM_PLLCTLD_CP_PLL1                   0X7
+
+/* Register Masks */
+#define RM_PLLCTLD_RZ_PLL1 \
+	 RM(FM_PLLCTLD_RZ_PLL1, FB_PLLCTLD_RZ_PLL1)
+
+#define RM_PLLCTLD_CP_PLL1 \
+	 RM(FM_PLLCTLD_CP_PLL1, FB_PLLCTLD_CP_PLL1)
+
+
+/******************************
+ *      R_PLLCTLE (0x53)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_PLLCTLE_REFDIV_PLL2               0
+
+/* Field Masks */
+#define FM_PLLCTLE_REFDIV_PLL2               0XFF
+
+/* Register Masks */
+#define RM_PLLCTLE_REFDIV_PLL2 \
+	 RM(FM_PLLCTLE_REFDIV_PLL2, FB_PLLCTLE_REFDIV_PLL2)
+
+
+/******************************
+ *      R_PLLCTLF (0x54)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_PLLCTLF_OUTDIV_PLL2               0
+
+/* Field Masks */
+#define FM_PLLCTLF_OUTDIV_PLL2               0XFF
+
+/* Register Masks */
+#define RM_PLLCTLF_OUTDIV_PLL2 \
+	 RM(FM_PLLCTLF_OUTDIV_PLL2, FB_PLLCTLF_OUTDIV_PLL2)
+
+
+/*******************************
+ *      R_PLLCTL10 (0x55)      *
+ *******************************/
+
+/* Field Offsets */
+#define FB_PLLCTL10_FBDIV_PLL2L              0
+
+/* Field Masks */
+#define FM_PLLCTL10_FBDIV_PLL2L              0XFF
+
+/* Register Masks */
+#define RM_PLLCTL10_FBDIV_PLL2L \
+	 RM(FM_PLLCTL10_FBDIV_PLL2L, FB_PLLCTL10_FBDIV_PLL2L)
+
+
+/*******************************
+ *      R_PLLCTL11 (0x56)      *
+ *******************************/
+
+/* Field Offsets */
+#define FB_PLLCTL11_FBDIV_PLL2H              0
+
+/* Field Masks */
+#define FM_PLLCTL11_FBDIV_PLL2H              0X7
+
+/* Register Masks */
+#define RM_PLLCTL11_FBDIV_PLL2H \
+	 RM(FM_PLLCTL11_FBDIV_PLL2H, FB_PLLCTL11_FBDIV_PLL2H)
+
+
+/*******************************
+ *      R_PLLCTL12 (0x57)      *
+ *******************************/
+
+/* Field Offsets */
+#define FB_PLLCTL12_RZ_PLL2                  3
+#define FB_PLLCTL12_CP_PLL2                  0
+
+/* Field Masks */
+#define FM_PLLCTL12_RZ_PLL2                  0X7
+#define FM_PLLCTL12_CP_PLL2                  0X7
+
+/* Register Masks */
+#define RM_PLLCTL12_RZ_PLL2 \
+	 RM(FM_PLLCTL12_RZ_PLL2, FB_PLLCTL12_RZ_PLL2)
+
+#define RM_PLLCTL12_CP_PLL2 \
+	 RM(FM_PLLCTL12_CP_PLL2, FB_PLLCTL12_CP_PLL2)
+
+
+/*******************************
+ *      R_PLLCTL1B (0x60)      *
+ *******************************/
+
+/* Field Offsets */
+#define FB_PLLCTL1B_VCOI_PLL2                4
+#define FB_PLLCTL1B_VCOI_PLL1                2
+
+/* Field Masks */
+#define FM_PLLCTL1B_VCOI_PLL2                0X3
+#define FM_PLLCTL1B_VCOI_PLL1                0X3
+
+/* Register Masks */
+#define RM_PLLCTL1B_VCOI_PLL2 \
+	 RM(FM_PLLCTL1B_VCOI_PLL2, FB_PLLCTL1B_VCOI_PLL2)
+
+#define RM_PLLCTL1B_VCOI_PLL1 \
+	 RM(FM_PLLCTL1B_VCOI_PLL1, FB_PLLCTL1B_VCOI_PLL1)
+
+
+/*******************************
+ *      R_PLLCTL1C (0x61)      *
+ *******************************/
+
+/* Field Offsets */
+#define FB_PLLCTL1C_PDB_PLL2                 2
+#define FB_PLLCTL1C_PDB_PLL1                 1
+
+/* Field Masks */
+#define FM_PLLCTL1C_PDB_PLL2                 0X1
+#define FM_PLLCTL1C_PDB_PLL1                 0X1
+
+/* Field Values */
+#define FV_PLLCTL1C_PDB_PLL2_ENABLE          0x1
+#define FV_PLLCTL1C_PDB_PLL2_DISABLE         0x0
+#define FV_PLLCTL1C_PDB_PLL1_ENABLE          0x1
+#define FV_PLLCTL1C_PDB_PLL1_DISABLE         0x0
+
+/* Register Masks */
+#define RM_PLLCTL1C_PDB_PLL2 \
+	 RM(FM_PLLCTL1C_PDB_PLL2, FB_PLLCTL1C_PDB_PLL2)
+
+#define RM_PLLCTL1C_PDB_PLL1 \
+	 RM(FM_PLLCTL1C_PDB_PLL1, FB_PLLCTL1C_PDB_PLL1)
+
+
+/* Register Values */
+#define RV_PLLCTL1C_PDB_PLL2_ENABLE \
+	 RV(FV_PLLCTL1C_PDB_PLL2_ENABLE, FB_PLLCTL1C_PDB_PLL2)
+
+#define RV_PLLCTL1C_PDB_PLL2_DISABLE \
+	 RV(FV_PLLCTL1C_PDB_PLL2_DISABLE, FB_PLLCTL1C_PDB_PLL2)
+
+#define RV_PLLCTL1C_PDB_PLL1_ENABLE \
+	 RV(FV_PLLCTL1C_PDB_PLL1_ENABLE, FB_PLLCTL1C_PDB_PLL1)
+
+#define RV_PLLCTL1C_PDB_PLL1_DISABLE \
+	 RV(FV_PLLCTL1C_PDB_PLL1_DISABLE, FB_PLLCTL1C_PDB_PLL1)
+
+
+/*******************************
+ *      R_TIMEBASE (0x77)      *
+ *******************************/
+
+/* Field Offsets */
+#define FB_TIMEBASE_DIVIDER                  0
+
+/* Field Masks */
+#define FM_TIMEBASE_DIVIDER                  0XFF
+
+/* Register Masks */
+#define RM_TIMEBASE_DIVIDER \
+	 RM(FM_TIMEBASE_DIVIDER, FB_TIMEBASE_DIVIDER)
+
+
+/*****************************
+ *      R_DEVIDL (0x7D)      *
+ *****************************/
+
+/* Field Offsets */
+#define FB_DEVIDL_DIDL                       0
+
+/* Field Masks */
+#define FM_DEVIDL_DIDL                       0XFF
+
+/* Register Masks */
+#define RM_DEVIDL_DIDL                       RM(FM_DEVIDL_DIDL, FB_DEVIDL_DIDL)
+
+/*****************************
+ *      R_DEVIDH (0x7E)      *
+ *****************************/
+
+/* Field Offsets */
+#define FB_DEVIDH_DIDH                       0
+
+/* Field Masks */
+#define FM_DEVIDH_DIDH                       0XFF
+
+/* Register Masks */
+#define RM_DEVIDH_DIDH                       RM(FM_DEVIDH_DIDH, FB_DEVIDH_DIDH)
+
+/****************************
+ *      R_RESET (0x80)      *
+ ****************************/
+
+/* Field Offsets */
+#define FB_RESET                             0
+
+/* Field Masks */
+#define FM_RESET                             0XFF
+
+/* Field Values */
+#define FV_RESET_ENABLE                      0x85
+
+/* Register Masks */
+#define RM_RESET                             RM(FM_RESET, FB_RESET)
+
+/* Register Values */
+#define RV_RESET_ENABLE                      RV(FV_RESET_ENABLE, FB_RESET)
+
+/********************************
+ *      R_DACCRSTAT (0x8A)      *
+ ********************************/
+
+/* Field Offsets */
+#define FB_DACCRSTAT_DACCR_BUSY              7
+
+/* Field Masks */
+#define FM_DACCRSTAT_DACCR_BUSY              0X1
+
+/* Register Masks */
+#define RM_DACCRSTAT_DACCR_BUSY \
+	 RM(FM_DACCRSTAT_DACCR_BUSY, FB_DACCRSTAT_DACCR_BUSY)
+
+
+/******************************
+ *      R_PLLCTL0 (0x8E)      *
+ ******************************/
+
+/* Field Offsets */
+#define FB_PLLCTL0_PLL2_LOCK                 1
+#define FB_PLLCTL0_PLL1_LOCK                 0
+
+/* Field Masks */
+#define FM_PLLCTL0_PLL2_LOCK                 0X1
+#define FM_PLLCTL0_PLL1_LOCK                 0X1
+
+/* Register Masks */
+#define RM_PLLCTL0_PLL2_LOCK \
+	 RM(FM_PLLCTL0_PLL2_LOCK, FB_PLLCTL0_PLL2_LOCK)
+
+#define RM_PLLCTL0_PLL1_LOCK \
+	 RM(FM_PLLCTL0_PLL1_LOCK, FB_PLLCTL0_PLL1_LOCK)
+
+
+/********************************
+ *      R_PLLREFSEL (0x8F)      *
+ ********************************/
+
+/* Field Offsets */
+#define FB_PLLREFSEL_PLL2_REF_SEL            4
+#define FB_PLLREFSEL_PLL1_REF_SEL            0
+
+/* Field Masks */
+#define FM_PLLREFSEL_PLL2_REF_SEL            0X7
+#define FM_PLLREFSEL_PLL1_REF_SEL            0X7
+
+/* Field Values */
+#define FV_PLLREFSEL_PLL2_REF_SEL_XTAL_MCLK1 0x0
+#define FV_PLLREFSEL_PLL2_REF_SEL_MCLK2      0x1
+#define FV_PLLREFSEL_PLL1_REF_SEL_XTAL_MCLK1 0x0
+#define FV_PLLREFSEL_PLL1_REF_SEL_MCLK2      0x1
+
+/* Register Masks */
+#define RM_PLLREFSEL_PLL2_REF_SEL \
+	 RM(FM_PLLREFSEL_PLL2_REF_SEL, FB_PLLREFSEL_PLL2_REF_SEL)
+
+#define RM_PLLREFSEL_PLL1_REF_SEL \
+	 RM(FM_PLLREFSEL_PLL1_REF_SEL, FB_PLLREFSEL_PLL1_REF_SEL)
+
+
+/* Register Values */
+#define RV_PLLREFSEL_PLL2_REF_SEL_XTAL_MCLK1 \
+	 RV(FV_PLLREFSEL_PLL2_REF_SEL_XTAL_MCLK1, FB_PLLREFSEL_PLL2_REF_SEL)
+
+#define RV_PLLREFSEL_PLL2_REF_SEL_MCLK2 \
+	 RV(FV_PLLREFSEL_PLL2_REF_SEL_MCLK2, FB_PLLREFSEL_PLL2_REF_SEL)
+
+#define RV_PLLREFSEL_PLL1_REF_SEL_XTAL_MCLK1 \
+	 RV(FV_PLLREFSEL_PLL1_REF_SEL_XTAL_MCLK1, FB_PLLREFSEL_PLL1_REF_SEL)
+
+#define RV_PLLREFSEL_PLL1_REF_SEL_MCLK2 \
+	 RV(FV_PLLREFSEL_PLL1_REF_SEL_MCLK2, FB_PLLREFSEL_PLL1_REF_SEL)
+
+
+/*******************************
+ *      R_DACMBCEN (0xC7)      *
+ *******************************/
+
+/* Field Offsets */
+#define FB_DACMBCEN_MBCEN3                   2
+#define FB_DACMBCEN_MBCEN2                   1
+#define FB_DACMBCEN_MBCEN1                   0
+
+/* Field Masks */
+#define FM_DACMBCEN_MBCEN3                   0X1
+#define FM_DACMBCEN_MBCEN2                   0X1
+#define FM_DACMBCEN_MBCEN1                   0X1
+
+/* Register Masks */
+#define RM_DACMBCEN_MBCEN3 \
+	 RM(FM_DACMBCEN_MBCEN3, FB_DACMBCEN_MBCEN3)
+
+#define RM_DACMBCEN_MBCEN2 \
+	 RM(FM_DACMBCEN_MBCEN2, FB_DACMBCEN_MBCEN2)
+
+#define RM_DACMBCEN_MBCEN1 \
+	 RM(FM_DACMBCEN_MBCEN1, FB_DACMBCEN_MBCEN1)
+
+
+/********************************
+ *      R_DACMBCCTL (0xC8)      *
+ ********************************/
+
+/* Field Offsets */
+#define FB_DACMBCCTL_LVLMODE3                5
+#define FB_DACMBCCTL_WINSEL3                 4
+#define FB_DACMBCCTL_LVLMODE2                3
+#define FB_DACMBCCTL_WINSEL2                 2
+#define FB_DACMBCCTL_LVLMODE1                1
+#define FB_DACMBCCTL_WINSEL1                 0
+
+/* Field Masks */
+#define FM_DACMBCCTL_LVLMODE3                0X1
+#define FM_DACMBCCTL_WINSEL3                 0X1
+#define FM_DACMBCCTL_LVLMODE2                0X1
+#define FM_DACMBCCTL_WINSEL2                 0X1
+#define FM_DACMBCCTL_LVLMODE1                0X1
+#define FM_DACMBCCTL_WINSEL1                 0X1
+
+/* Register Masks */
+#define RM_DACMBCCTL_LVLMODE3 \
+	 RM(FM_DACMBCCTL_LVLMODE3, FB_DACMBCCTL_LVLMODE3)
+
+#define RM_DACMBCCTL_WINSEL3 \
+	 RM(FM_DACMBCCTL_WINSEL3, FB_DACMBCCTL_WINSEL3)
+
+#define RM_DACMBCCTL_LVLMODE2 \
+	 RM(FM_DACMBCCTL_LVLMODE2, FB_DACMBCCTL_LVLMODE2)
+
+#define RM_DACMBCCTL_WINSEL2 \
+	 RM(FM_DACMBCCTL_WINSEL2, FB_DACMBCCTL_WINSEL2)
+
+#define RM_DACMBCCTL_LVLMODE1 \
+	 RM(FM_DACMBCCTL_LVLMODE1, FB_DACMBCCTL_LVLMODE1)
+
+#define RM_DACMBCCTL_WINSEL1 \
+	 RM(FM_DACMBCCTL_WINSEL1, FB_DACMBCCTL_WINSEL1)
+
+
+/*********************************
+ *      R_DACMBCMUG1 (0xC9)      *
+ *********************************/
+
+/* Field Offsets */
+#define FB_DACMBCMUG1_PHASE                  5
+#define FB_DACMBCMUG1_MUGAIN                 0
+
+/* Field Masks */
+#define FM_DACMBCMUG1_PHASE                  0X1
+#define FM_DACMBCMUG1_MUGAIN                 0X1F
+
+/* Register Masks */
+#define RM_DACMBCMUG1_PHASE \
+	 RM(FM_DACMBCMUG1_PHASE, FB_DACMBCMUG1_PHASE)
+
+#define RM_DACMBCMUG1_MUGAIN \
+	 RM(FM_DACMBCMUG1_MUGAIN, FB_DACMBCMUG1_MUGAIN)
+
+
+/*********************************
+ *      R_DACMBCTHR1 (0xCA)      *
+ *********************************/
+
+/* Field Offsets */
+#define FB_DACMBCTHR1_THRESH                 0
+
+/* Field Masks */
+#define FM_DACMBCTHR1_THRESH                 0XFF
+
+/* Register Masks */
+#define RM_DACMBCTHR1_THRESH \
+	 RM(FM_DACMBCTHR1_THRESH, FB_DACMBCTHR1_THRESH)
+
+
+/*********************************
+ *      R_DACMBCRAT1 (0xCB)      *
+ *********************************/
+
+/* Field Offsets */
+#define FB_DACMBCRAT1_RATIO                  0
+
+/* Field Masks */
+#define FM_DACMBCRAT1_RATIO                  0X1F
+
+/* Register Masks */
+#define RM_DACMBCRAT1_RATIO \
+	 RM(FM_DACMBCRAT1_RATIO, FB_DACMBCRAT1_RATIO)
+
+
+/**********************************
+ *      R_DACMBCATK1L (0xCC)      *
+ **********************************/
+
+/* Field Offsets */
+#define FB_DACMBCATK1L_TCATKL                0
+
+/* Field Masks */
+#define FM_DACMBCATK1L_TCATKL                0XFF
+
+/* Register Masks */
+#define RM_DACMBCATK1L_TCATKL \
+	 RM(FM_DACMBCATK1L_TCATKL, FB_DACMBCATK1L_TCATKL)
+
+
+/**********************************
+ *      R_DACMBCATK1H (0xCD)      *
+ **********************************/
+
+/* Field Offsets */
+#define FB_DACMBCATK1H_TCATKH                0
+
+/* Field Masks */
+#define FM_DACMBCATK1H_TCATKH                0XFF
+
+/* Register Masks */
+#define RM_DACMBCATK1H_TCATKH \
+	 RM(FM_DACMBCATK1H_TCATKH, FB_DACMBCATK1H_TCATKH)
+
+
+/**********************************
+ *      R_DACMBCREL1L (0xCE)      *
+ **********************************/
+
+/* Field Offsets */
+#define FB_DACMBCREL1L_TCRELL                0
+
+/* Field Masks */
+#define FM_DACMBCREL1L_TCRELL                0XFF
+
+/* Register Masks */
+#define RM_DACMBCREL1L_TCRELL \
+	 RM(FM_DACMBCREL1L_TCRELL, FB_DACMBCREL1L_TCRELL)
+
+
+/**********************************
+ *      R_DACMBCREL1H (0xCF)      *
+ **********************************/
+
+/* Field Offsets */
+#define FB_DACMBCREL1H_TCRELH                0
+
+/* Field Masks */
+#define FM_DACMBCREL1H_TCRELH                0XFF
+
+/* Register Masks */
+#define RM_DACMBCREL1H_TCRELH \
+	 RM(FM_DACMBCREL1H_TCRELH, FB_DACMBCREL1H_TCRELH)
+
+
+/*********************************
+ *      R_DACMBCMUG2 (0xD0)      *
+ *********************************/
+
+/* Field Offsets */
+#define FB_DACMBCMUG2_PHASE                  5
+#define FB_DACMBCMUG2_MUGAIN                 0
+
+/* Field Masks */
+#define FM_DACMBCMUG2_PHASE                  0X1
+#define FM_DACMBCMUG2_MUGAIN                 0X1F
+
+/* Register Masks */
+#define RM_DACMBCMUG2_PHASE \
+	 RM(FM_DACMBCMUG2_PHASE, FB_DACMBCMUG2_PHASE)
+
+#define RM_DACMBCMUG2_MUGAIN \
+	 RM(FM_DACMBCMUG2_MUGAIN, FB_DACMBCMUG2_MUGAIN)
+
+
+/*********************************
+ *      R_DACMBCTHR2 (0xD1)      *
+ *********************************/
+
+/* Field Offsets */
+#define FB_DACMBCTHR2_THRESH                 0
+
+/* Field Masks */
+#define FM_DACMBCTHR2_THRESH                 0XFF
+
+/* Register Masks */
+#define RM_DACMBCTHR2_THRESH \
+	 RM(FM_DACMBCTHR2_THRESH, FB_DACMBCTHR2_THRESH)
+
+
+/*********************************
+ *      R_DACMBCRAT2 (0xD2)      *
+ *********************************/
+
+/* Field Offsets */
+#define FB_DACMBCRAT2_RATIO                  0
+
+/* Field Masks */
+#define FM_DACMBCRAT2_RATIO                  0X1F
+
+/* Register Masks */
+#define RM_DACMBCRAT2_RATIO \
+	 RM(FM_DACMBCRAT2_RATIO, FB_DACMBCRAT2_RATIO)
+
+
+/**********************************
+ *      R_DACMBCATK2L (0xD3)      *
+ **********************************/
+
+/* Field Offsets */
+#define FB_DACMBCATK2L_TCATKL                0
+
+/* Field Masks */
+#define FM_DACMBCATK2L_TCATKL                0XFF
+
+/* Register Masks */
+#define RM_DACMBCATK2L_TCATKL \
+	 RM(FM_DACMBCATK2L_TCATKL, FB_DACMBCATK2L_TCATKL)
+
+
+/**********************************
+ *      R_DACMBCATK2H (0xD4)      *
+ **********************************/
+
+/* Field Offsets */
+#define FB_DACMBCATK2H_TCATKH                0
+
+/* Field Masks */
+#define FM_DACMBCATK2H_TCATKH                0XFF
+
+/* Register Masks */
+#define RM_DACMBCATK2H_TCATKH \
+	 RM(FM_DACMBCATK2H_TCATKH, FB_DACMBCATK2H_TCATKH)
+
+
+/**********************************
+ *      R_DACMBCREL2L (0xD5)      *
+ **********************************/
+
+/* Field Offsets */
+#define FB_DACMBCREL2L_TCRELL                0
+
+/* Field Masks */
+#define FM_DACMBCREL2L_TCRELL                0XFF
+
+/* Register Masks */
+#define RM_DACMBCREL2L_TCRELL \
+	 RM(FM_DACMBCREL2L_TCRELL, FB_DACMBCREL2L_TCRELL)
+
+
+/**********************************
+ *      R_DACMBCREL2H (0xD6)      *
+ **********************************/
+
+/* Field Offsets */
+#define FB_DACMBCREL2H_TCRELH                0
+
+/* Field Masks */
+#define FM_DACMBCREL2H_TCRELH                0XFF
+
+/* Register Masks */
+#define RM_DACMBCREL2H_TCRELH \
+	 RM(FM_DACMBCREL2H_TCRELH, FB_DACMBCREL2H_TCRELH)
+
+
+/*********************************
+ *      R_DACMBCMUG3 (0xD7)      *
+ *********************************/
+
+/* Field Offsets */
+#define FB_DACMBCMUG3_PHASE                  5
+#define FB_DACMBCMUG3_MUGAIN                 0
+
+/* Field Masks */
+#define FM_DACMBCMUG3_PHASE                  0X1
+#define FM_DACMBCMUG3_MUGAIN                 0X1F
+
+/* Register Masks */
+#define RM_DACMBCMUG3_PHASE \
+	 RM(FM_DACMBCMUG3_PHASE, FB_DACMBCMUG3_PHASE)
+
+#define RM_DACMBCMUG3_MUGAIN \
+	 RM(FM_DACMBCMUG3_MUGAIN, FB_DACMBCMUG3_MUGAIN)
+
+
+/*********************************
+ *      R_DACMBCTHR3 (0xD8)      *
+ *********************************/
+
+/* Field Offsets */
+#define FB_DACMBCTHR3_THRESH                 0
+
+/* Field Masks */
+#define FM_DACMBCTHR3_THRESH                 0XFF
+
+/* Register Masks */
+#define RM_DACMBCTHR3_THRESH \
+	 RM(FM_DACMBCTHR3_THRESH, FB_DACMBCTHR3_THRESH)
+
+
+/*********************************
+ *      R_DACMBCRAT3 (0xD9)      *
+ *********************************/
+
+/* Field Offsets */
+#define FB_DACMBCRAT3_RATIO                  0
+
+/* Field Masks */
+#define FM_DACMBCRAT3_RATIO                  0X1F
+
+/* Register Masks */
+#define RM_DACMBCRAT3_RATIO \
+	 RM(FM_DACMBCRAT3_RATIO, FB_DACMBCRAT3_RATIO)
+
+
+/**********************************
+ *      R_DACMBCATK3L (0xDA)      *
+ **********************************/
+
+/* Field Offsets */
+#define FB_DACMBCATK3L_TCATKL                0
+
+/* Field Masks */
+#define FM_DACMBCATK3L_TCATKL                0XFF
+
+/* Register Masks */
+#define RM_DACMBCATK3L_TCATKL \
+	 RM(FM_DACMBCATK3L_TCATKL, FB_DACMBCATK3L_TCATKL)
+
+
+/**********************************
+ *      R_DACMBCATK3H (0xDB)      *
+ **********************************/
+
+/* Field Offsets */
+#define FB_DACMBCATK3H_TCATKH                0
+
+/* Field Masks */
+#define FM_DACMBCATK3H_TCATKH                0XFF
+
+/* Register Masks */
+#define RM_DACMBCATK3H_TCATKH \
+	 RM(FM_DACMBCATK3H_TCATKH, FB_DACMBCATK3H_TCATKH)
+
+
+/**********************************
+ *      R_DACMBCREL3L (0xDC)      *
+ **********************************/
+
+/* Field Offsets */
+#define FB_DACMBCREL3L_TCRELL                0
+
+/* Field Masks */
+#define FM_DACMBCREL3L_TCRELL                0XFF
+
+/* Register Masks */
+#define RM_DACMBCREL3L_TCRELL \
+	 RM(FM_DACMBCREL3L_TCRELL, FB_DACMBCREL3L_TCRELL)
+
+
+/**********************************
+ *      R_DACMBCREL3H (0xDD)      *
+ **********************************/
+
+/* Field Offsets */
+#define FB_DACMBCREL3H_TCRELH                0
+
+/* Field Masks */
+#define FM_DACMBCREL3H_TCRELH                0XFF
+
+/* Register Masks */
+#define RM_DACMBCREL3H_TCRELH \
+	 RM(FM_DACMBCREL3H_TCRELH, FB_DACMBCREL3H_TCRELH)
+
+
+#endif /* __WOOKIE_H__ */
-- 
2.11.0
