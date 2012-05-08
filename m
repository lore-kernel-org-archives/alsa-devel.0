From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 10/11] ASoC: codecs: Add AB8500 codec-driver
Date: Tue, 8 May 2012 15:57:30 +0200
Message-ID: <1336485450-27405-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog111.obsmtp.com (eu1sys200aog111.obsmtp.com
	[207.126.144.131])
	by alsa0.perex.cz (Postfix) with ESMTP id 66CD910446F
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 15:57:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

Add codec-driver for ST-Ericsson AB8500 mixed-signal ASIC.

Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>
---
 sound/soc/codecs/Kconfig        |    4 +
 sound/soc/codecs/Makefile       |    3 +
 sound/soc/codecs/ab8500-codec.c | 2852 +++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ab8500-codec.h |  608 +++++++++
 4 files changed, 3467 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/ab8500-codec.c
 create mode 100644 sound/soc/codecs/ab8500-codec.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6508e8b..c7e0e8f 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -12,6 +12,7 @@ config SND_SOC_ALL_CODECS
 	tristate "Build all ASoC CODEC drivers"
 	select SND_SOC_88PM860X if MFD_88PM860X
 	select SND_SOC_L3
+	select SND_SOC_AB8500_CODEC if ABX500_CORE
 	select SND_SOC_AC97_CODEC if SND_SOC_AC97_BUS
 	select SND_SOC_AD1836 if SPI_MASTER
 	select SND_SOC_AD193X if SND_SOC_I2C_AND_SPI
@@ -126,6 +127,9 @@ config SND_SOC_WM_HUBS
 	default y if SND_SOC_WM8993=y || SND_SOC_WM8994=y
 	default m if SND_SOC_WM8993=m || SND_SOC_WM8994=m
 
+config SND_SOC_AB8500_CODEC
+	tristate
+
 config SND_SOC_AC97_CODEC
 	tristate
 	select SND_AC97_CODEC
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 6662eb0..d7b96a6 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -1,4 +1,5 @@
 snd-soc-88pm860x-objs := 88pm860x-codec.o
+snd-soc-ab8500-codec-objs := ab8500-codec.o
 snd-soc-ac97-objs := ac97.o
 snd-soc-ad1836-objs := ad1836.o
 snd-soc-ad193x-objs := ad193x.o
@@ -103,6 +104,7 @@ snd-soc-max9877-objs := max9877.o
 snd-soc-tpa6130a2-objs := tpa6130a2.o
 
 obj-$(CONFIG_SND_SOC_88PM860X)	+= snd-soc-88pm860x.o
+obj-$(CONFIG_SND_SOC_AB8500_CODEC)	+= snd-soc-ab8500-codec.o
 obj-$(CONFIG_SND_SOC_AC97_CODEC)	+= snd-soc-ac97.o
 obj-$(CONFIG_SND_SOC_AD1836)	+= snd-soc-ad1836.o
 obj-$(CONFIG_SND_SOC_AD193X)	+= snd-soc-ad193x.o
@@ -205,3 +207,4 @@ obj-$(CONFIG_SND_SOC_WM_HUBS)	+= snd-soc-wm-hubs.o
 # Amp
 obj-$(CONFIG_SND_SOC_MAX9877)	+= snd-soc-max9877.o
 obj-$(CONFIG_SND_SOC_TPA6130A2)	+= snd-soc-tpa6130a2.o
+
diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
new file mode 100644
index 0000000..f44a481
--- /dev/null
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -0,0 +1,2852 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2012
+ *
+ * Author: Ola Lilja <ola.o.lilja@stericsson.com>,
+ *         Kristoffer Karlsson <kristoffer.karlsson@stericsson.com>,
+ *         Roger Nilsson <roger.xr.nilsson@stericsson.com>,
+ *         for ST-Ericsson.
+ *
+ *         Based on the early work done by:
+ *         Mikko J. Lehto <mikko.lehto@symbio.com>,
+ *         Mikko Sarmanne <mikko.sarmanne@symbio.com>,
+ *         Jarmo K. Kuronen <jarmo.kuronen@symbio.com>,
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/platform_device.h>
+#include <linux/mutex.h>
+#include <linux/mfd/abx500/ab8500.h>
+#include <linux/mfd/abx500.h>
+#include <linux/mfd/abx500/ab8500-sysctrl.h>
+#include <linux/clk.h>
+#include <linux/regulator/consumer.h>
+
+#include <mach/board-mop500-audio.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/tlv.h>
+
+#include "ab8500-codec.h"
+
+/* Macrocell value definitions */
+#define CLK_32K_OUT2_DISABLE			0x01
+#define INACTIVE_RESET_AUDIO			0x02
+#define ENABLE_AUDIO_CLK_TO_AUDIO_BLK		0x10
+#define ENABLE_VINTCORE12_SUPPLY		0x04
+#define GPIO27_DIR_OUTPUT			0x04
+#define GPIO29_DIR_OUTPUT			0x10
+#define GPIO31_DIR_OUTPUT			0x40
+
+/* Macrocell register definitions */
+#define AB8500_CTRL3_REG			0x0200
+#define AB8500_GPIO_DIR4_REG			0x1013
+
+/* Nr of FIR/IIR-coeff banks in ANC-block */
+#define AB8500_NR_OF_ANC_COEFF_BANKS		2
+
+/* Minimum duration to keep ANC IIR Init bit high or
+low before proceeding with the configuration sequence */
+#define AB8500_ANC_SM_DELAY			2000
+
+#define AB8500_FILTER_CONTROL(xname, xcount, xmin, xmax) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.info = filter_control_info, \
+	.get = filter_control_get, .put = filter_control_put, \
+	.private_value = (unsigned long)&(struct filter_control) \
+		{.count = xcount, .min = xmin, .max = xmax} }
+
+struct filter_control {
+	long min, max;
+	unsigned int count;
+	long value[128];
+};
+
+/* Sidetone states */
+static const char * const enum_sid_state[] = {
+	"Unconfigured",
+	"Apply FIR",
+	"FIR is configured",
+};
+enum sid_state {
+	SID_UNCONFIGURED = 0,
+	SID_APPLY_FIR = 1,
+	SID_FIR_CONFIGURED = 2,
+};
+
+static const char * const enum_anc_state[] = {
+	"Unconfigured",
+	"Apply FIR and IIR",
+	"FIR and IIR are configured",
+	"Apply FIR",
+	"FIR is configured",
+	"Apply IIR",
+	"IIR is configured"
+};
+enum anc_state {
+	ANC_UNCONFIGURED = 0,
+	ANC_APPLY_FIR_IIR = 1,
+	ANC_FIR_IIR_CONFIGURED = 2,
+	ANC_APPLY_FIR = 3,
+	ANC_FIR_CONFIGURED = 4,
+	ANC_APPLY_IIR = 5,
+	ANC_IIR_CONFIGURED = 6
+};
+
+/* Analog microphones */
+enum amic_idx {
+	AMIC_IDX_1A,
+	AMIC_IDX_1B,
+	AMIC_IDX_2
+};
+
+/* Clocks */
+static const char * const enum_mclk[] = {
+	"SYSCLK",
+	"ULPCLK"
+};
+enum mclk {
+	MCLK_SYSCLK,
+	MCLK_ULPCLK,
+};
+
+/* Private data for AB8500 device-driver */
+struct ab8500_codec_drvdata {
+	/* Clocks */
+	enum mclk mclk_sel;
+	struct clk *clk_ptr_intclk;
+	struct clk *clk_ptr_sysclk;
+	struct clk *clk_ptr_ulpclk;
+
+	/* Sidetone */
+	long *sid_fir_values;
+	enum sid_state sid_status;
+
+	/* ANC */
+	long *anc_fir_values;
+	long *anc_iir_values;
+	enum anc_state anc_status;
+};
+
+static inline const char *amic_micbias_str(enum amic_micbias micbias)
+{
+	switch (micbias) {
+	case AMIC_MICBIAS_VAMIC1:
+		return "VAMIC1";
+	case AMIC_MICBIAS_VAMIC2:
+		return "VAMIC2";
+	default:
+		return "Unknown";
+	}
+}
+
+static inline const char *amic_type_str(enum amic_type type)
+{
+	switch (type) {
+	case AMIC_TYPE_DIFFERENTIAL:
+		return "DIFFERENTIAL";
+	case AMIC_TYPE_SINGLE_ENDED:
+		return "SINGLE ENDED";
+	default:
+		return "Unknown";
+	}
+}
+
+/*
+ * Read'n'write functions
+ */
+
+/* Read a register from the audio-bank of AB8500 */
+static unsigned int ab8500_codec_read_reg(struct snd_soc_codec *codec,
+					unsigned int reg)
+{
+	int status;
+	unsigned int value = 0;
+
+	u8 value8;
+	status = abx500_get_register_interruptible(codec->dev, AB8500_AUDIO,
+						reg, &value8);
+	if (status < 0) {
+		dev_err(codec->dev,
+			"%s: ERROR: Register (0x%02x:0x%02x) read failed (%d).\n",
+			__func__, (u8)AB8500_AUDIO, (u8)reg, status);
+	} else {
+		dev_dbg(codec->dev,
+			"%s: Read 0x%02x from register 0x%02x:0x%02x\n",
+			__func__, value8, (u8)AB8500_AUDIO, (u8)reg);
+		value = (unsigned int)value8;
+	}
+
+	return value;
+}
+
+/* Write to a register in the audio-bank of AB8500 */
+static int ab8500_codec_write_reg(struct snd_soc_codec *codec,
+				unsigned int reg, unsigned int value)
+{
+	int status;
+
+	status = abx500_set_register_interruptible(codec->dev, AB8500_AUDIO,
+						reg, value);
+	if (status < 0)
+		dev_err(codec->dev,
+			"%s: ERROR: Register (%02x:%02x) write failed (%d).\n",
+			__func__, (u8)AB8500_AUDIO, (u8)reg, status);
+	else
+		dev_dbg(codec->dev,
+			"%s: Wrote 0x%02x into register %02x:%02x\n",
+			__func__, (u8)value, (u8)AB8500_AUDIO, (u8)reg);
+
+	return status;
+}
+
+/*
+ * Regulator functions
+ */
+
+static void show_regulator_status(struct snd_soc_dapm_context *dapm)
+{
+	struct device *dev = dapm->dev;
+
+	dev_dbg(dev, "%s: Regulator-status:\n", __func__);
+	dev_dbg(dev, "%s:     V-AUD: %s\n", __func__,
+		(snd_soc_dapm_get_regulator_status(dapm, "V-AUD") > 0) ?
+			"On" : "Off");
+	dev_dbg(dev, "%s:     V-AMIC1: %s\n", __func__,
+		(snd_soc_dapm_get_regulator_status(dapm, "V-AMIC1") > 0) ?
+			"On" : "Off");
+	dev_dbg(dev, "%s:     V-AMIC2: %s\n", __func__,
+		(snd_soc_dapm_get_regulator_status(dapm, "V-AMIC2") > 0) ?
+			"On" : "Off");
+	dev_dbg(dev, "%s:     V-DMIC: %s\n", __func__,
+		(snd_soc_dapm_get_regulator_status(dapm, "V-DMIC") > 0) ?
+			"On" : "Off");
+}
+
+/*
+ * Clock functions
+ */
+
+static void show_clock_status(struct snd_soc_dapm_context *dapm)
+{
+	struct device *dev = dapm->dev;
+
+	dev_dbg(dev, "%s: Clock-status:\n", __func__);
+	dev_dbg(dev, "%s:     audioclk: %s\n", __func__,
+		(snd_soc_dapm_get_power_status(dapm, "audioclk") > 0) ?
+			"On" : "Off");
+	dev_dbg(dev, "%s:     gpio.1: %s\n", __func__,
+		(snd_soc_dapm_get_power_status(dapm, "gpio.1") > 0) ?
+			"On" : "Off");
+}
+
+/*
+ * DAPM-events
+ */
+
+static int dapm_mainsupply_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *k, int event)
+{
+	show_regulator_status(w->dapm);
+	show_clock_status(w->dapm);
+
+	return 0;
+}
+
+/*
+ * Controls - DAPM
+ */
+
+/* Earpiece */
+
+/* Earpiece source selector */
+static const char * const enum_ear_lineout_source[] = {"Headset Left",
+						"Speaker Left"};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_ear_lineout_source, AB8500_DMICFILTCONF,
+			AB8500_DMICFILTCONF_DA3TOEAR, enum_ear_lineout_source);
+static const struct snd_kcontrol_new dapm_ear_lineout_source =
+	SOC_DAPM_ENUM("Earpiece or LineOut Mono Source",
+		dapm_enum_ear_lineout_source);
+
+/* LineOut */
+
+/* LineOut source selector */
+static const char * const enum_lineout_source[] = {"Mono Path", "Stereo Path"};
+static SOC_ENUM_DOUBLE_DECL(dapm_enum_lineout_source, AB8500_ANACONF5,
+			AB8500_ANACONF5_HSLDACTOLOL,
+			AB8500_ANACONF5_HSRDACTOLOR, enum_lineout_source);
+static const struct snd_kcontrol_new dapm_lineout_source[] = {
+	SOC_DAPM_ENUM("LineOut Source", dapm_enum_lineout_source),
+};
+
+/* Handsfree */
+
+/* Speaker Left - ANC selector */
+static const char * const enum_HFx_sel[] = {"Audio Path", "ANC"};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_HFl_sel, AB8500_DIGMULTCONF2,
+			AB8500_DIGMULTCONF2_HFLSEL, enum_HFx_sel);
+static const struct snd_kcontrol_new dapm_HFl_select[] = {
+	SOC_DAPM_ENUM("Speaker Left Source", dapm_enum_HFl_sel),
+};
+
+/* Speaker Right - ANC selector */
+static SOC_ENUM_SINGLE_DECL(dapm_enum_HFr_sel, AB8500_DIGMULTCONF2,
+			AB8500_DIGMULTCONF2_HFRSEL, enum_HFx_sel);
+static const struct snd_kcontrol_new dapm_HFr_select[] = {
+	SOC_DAPM_ENUM("Speaker Right Source", dapm_enum_HFr_sel),
+};
+
+/* Mic 1 */
+
+/* Mic 1 - Mic 1a or 1b selector */
+static const char * const enum_mic1ab_sel[] = {"Mic 1b", "Mic 1a"};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_mic1ab_sel, AB8500_ANACONF3,
+			AB8500_ANACONF3_MIC1SEL, enum_mic1ab_sel);
+static const struct snd_kcontrol_new dapm_mic1ab_mux[] = {
+	SOC_DAPM_ENUM("Mic 1a or 1b Select", dapm_enum_mic1ab_sel),
+};
+
+/* Mic 1 - AD3 - Mic 1 or DMic 3 selector */
+static const char * const enum_ad3_sel[] = {"Mic 1", "DMic 3"};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_ad3_sel, AB8500_DIGMULTCONF1,
+			AB8500_DIGMULTCONF1_AD3SEL, enum_ad3_sel);
+static const struct snd_kcontrol_new dapm_ad3_select[] = {
+	SOC_DAPM_ENUM("AD3 Source Select", dapm_enum_ad3_sel),
+};
+
+/* Mic 1 - AD6 - Mic 1 or DMic 6 selector */
+static const char * const enum_ad6_sel[] = {"Mic 1", "DMic 6"};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_ad6_sel, AB8500_DIGMULTCONF1,
+			AB8500_DIGMULTCONF1_AD6SEL, enum_ad6_sel);
+static const struct snd_kcontrol_new dapm_ad6_select[] = {
+	SOC_DAPM_ENUM("AD6 Source Select", dapm_enum_ad6_sel),
+};
+
+/* Mic 2 */
+
+/* Mic 2 - AD5 - Mic 2 or DMic 5 selector */
+static const char * const enum_ad5_sel[] = {"Mic 2", "DMic 5"};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_ad5_sel, AB8500_DIGMULTCONF1,
+			AB8500_DIGMULTCONF1_AD5SEL, enum_ad5_sel);
+static const struct snd_kcontrol_new dapm_ad5_select[] = {
+	SOC_DAPM_ENUM("AD5 Source Select", dapm_enum_ad5_sel),
+};
+
+/* LineIn */
+
+/* LineIn left - AD1 - LineIn Left or DMic 1 selector */
+static const char * const enum_ad1_sel[] = {"LineIn Left", "DMic 1"};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_ad1_sel, AB8500_DIGMULTCONF1,
+			AB8500_DIGMULTCONF1_AD1SEL, enum_ad1_sel);
+static const struct snd_kcontrol_new dapm_ad1_select[] = {
+	SOC_DAPM_ENUM("AD1 Source Select", dapm_enum_ad1_sel),
+};
+
+/* LineIn right - Mic 2 or LineIn Right selector */
+static const char * const enum_mic2lr_sel[] = {"Mic 2", "LineIn Right"};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_mic2lr_sel, AB8500_ANACONF3,
+			AB8500_ANACONF3_LINRSEL, enum_mic2lr_sel);
+static const struct snd_kcontrol_new dapm_mic2lr_select[] = {
+	SOC_DAPM_ENUM("Mic 2 or LINR Select", dapm_enum_mic2lr_sel),
+};
+
+/* LineIn right - AD2 - LineIn Right or DMic2 selector */
+static const char * const enum_ad2_sel[] = {"LineIn Right", "DMic 2"};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_ad2_sel, AB8500_DIGMULTCONF1,
+			AB8500_DIGMULTCONF1_AD2SEL, enum_ad2_sel);
+static const struct snd_kcontrol_new dapm_ad2_select[] = {
+	SOC_DAPM_ENUM("AD2 Source Select", dapm_enum_ad2_sel),
+};
+
+
+/* ANC */
+
+static const char * const enum_anc_in_sel[] = {"Mic 1 / DMic 6",
+					"Mic 2 / DMic 5"};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_anc_in_sel, AB8500_DMICFILTCONF,
+			AB8500_DMICFILTCONF_ANCINSEL, enum_anc_in_sel);
+static const struct snd_kcontrol_new dapm_anc_in_select[] = {
+	SOC_DAPM_ENUM("ANC Source", dapm_enum_anc_in_sel),
+};
+
+/* ANC - Enable/Disable */
+static const struct snd_kcontrol_new dapm_anc_enable[] = {
+	SOC_DAPM_SINGLE("Switch", AB8500_ANCCONF1,
+			AB8500_ANCCONF1_ENANC, 0, 0),
+};
+
+/* ANC to Earpiece - Mute */
+static const struct snd_kcontrol_new dapm_anc_ear_mute[] = {
+	SOC_DAPM_SINGLE("Switch", AB8500_DIGMULTCONF1,
+			AB8500_DIGMULTCONF1_ANCSEL, 1, 0),
+};
+
+/* Sidetone left */
+
+/* Sidetone left - Input selector */
+static const char * const enum_stfir1_in_sel[] = {
+	"LineIn Left", "LineIn Right", "Mic 1", "Headset Left"
+};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_stfir1_in_sel, AB8500_DIGMULTCONF2,
+			AB8500_DIGMULTCONF2_FIRSID1SEL, enum_stfir1_in_sel);
+static const struct snd_kcontrol_new dapm_stfir1_in_select[] = {
+	SOC_DAPM_ENUM("Sidetone Left Source", dapm_enum_stfir1_in_sel),
+};
+
+/* Sidetone right path */
+
+/* Sidetone right - Input selector */
+static const char * const enum_stfir2_in_sel[] = {
+	"LineIn Right", "Mic 1", "DMic 4", "Headset Right"
+};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_stfir2_in_sel, AB8500_DIGMULTCONF2,
+			AB8500_DIGMULTCONF2_FIRSID2SEL, enum_stfir2_in_sel);
+static const struct snd_kcontrol_new dapm_stfir2_in_select[] = {
+	SOC_DAPM_ENUM("Sidetone Right Source", dapm_enum_stfir2_in_sel),
+};
+
+/* Vibra */
+
+static const char * const enum_pwm2vibx[] = {"Audio Path", "PWM Generator"};
+
+static SOC_ENUM_SINGLE_DECL(dapm_enum_pwm2vib1, AB8500_PWMGENCONF1,
+			AB8500_PWMGENCONF1_PWMTOVIB1, enum_pwm2vibx);
+
+static const struct snd_kcontrol_new dapm_pwm2vib1[] = {
+	SOC_DAPM_ENUM("Vibra 1 Controller", dapm_enum_pwm2vib1),
+};
+
+static SOC_ENUM_SINGLE_DECL(dapm_enum_pwm2vib2, AB8500_PWMGENCONF1,
+			AB8500_PWMGENCONF1_PWMTOVIB2, enum_pwm2vibx);
+
+static const struct snd_kcontrol_new dapm_pwm2vib2[] = {
+	SOC_DAPM_ENUM("Vibra 2 Controller", dapm_enum_pwm2vib2),
+};
+
+/*
+ * DAPM-widgets
+ */
+
+static const struct snd_soc_dapm_widget ab8500_dapm_widgets[] = {
+
+	/* Clocks */
+	SND_SOC_DAPM_CLOCK_SUPPLY("audioclk", 0),
+	SND_SOC_DAPM_CLOCK_SUPPLY("gpio.1", 1),
+
+	/* Regulators */
+	SND_SOC_DAPM_REGULATOR_SUPPLY("V-AUD", 0),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("V-AMIC1", 0),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("V-AMIC2", 0),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("V-DMIC", 0),
+
+	/* Power */
+	SND_SOC_DAPM_SUPPLY("Audio Power",
+			AB8500_POWERUP, AB8500_POWERUP_POWERUP, 0,
+			NULL, PRE_PMU_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("Audio Analog Power",
+			AB8500_POWERUP, AB8500_POWERUP_ENANA, 0,
+			NULL, PRE_PMU_POST_PMD),
+
+	/* Main supply node */
+	SND_SOC_DAPM_SUPPLY("Main Supply", SND_SOC_NOPM, 0, 0,
+			dapm_mainsupply_event, PRE_PMU_POST_PMD),
+
+	/* DA/AD */
+
+	SND_SOC_DAPM_INPUT("ADC Input"),
+	SND_SOC_DAPM_ADC("ADC", "ab8500_0c", SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_DAC("DAC", "ab8500_0p", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_OUTPUT("DAC Output"),
+
+	SND_SOC_DAPM_AIF_IN("DA_IN1", "ab8500_0p", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("DA_IN2", "ab8500_0p", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("DA_IN3", "ab8500_0p", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("DA_IN4", "ab8500_0p", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("DA_IN5", "ab8500_0p", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("DA_IN6", "ab8500_0p", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AD_OUT1", "ab8500_0c", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AD_OUT2", "ab8500_0c", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AD_OUT3", "ab8500_0c", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AD_OUT4", "ab8500_0c", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AD_OUT57", "ab8500_0c", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AD_OUT68", "ab8500_0c", 0, SND_SOC_NOPM, 0, 0),
+
+	/* Headset path */
+
+	SND_SOC_DAPM_SUPPLY("Charge Pump", AB8500_ANACONF5,
+			AB8500_ANACONF5_ENCPHS, 0, NULL, 0),
+
+	SND_SOC_DAPM_DAC("DA1 Enable", "ab8500_0p",
+			AB8500_DAPATHENA, AB8500_DAPATHENA_ENDA1, 0),
+	SND_SOC_DAPM_DAC("DA2 Enable", "ab8500_0p",
+			AB8500_DAPATHENA, AB8500_DAPATHENA_ENDA2, 0),
+
+	SND_SOC_DAPM_PGA("HSL Digital Gain", SND_SOC_NOPM, 0, 0,
+			NULL, 0),
+	SND_SOC_DAPM_PGA("HSR Digital Gain", SND_SOC_NOPM, 0, 0,
+			NULL, 0),
+
+	SND_SOC_DAPM_DAC("HSL DAC", "ab8500_0p",
+			AB8500_DAPATHCONF, AB8500_DAPATHCONF_ENDACHSL, 0),
+	SND_SOC_DAPM_DAC("HSR DAC", "ab8500_0p",
+			AB8500_DAPATHCONF, AB8500_DAPATHCONF_ENDACHSR, 0),
+	SND_SOC_DAPM_MIXER("HSL DAC Mute", AB8500_MUTECONF,
+			AB8500_MUTECONF_MUTDACHSL, 1,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("HSR DAC Mute", AB8500_MUTECONF,
+			AB8500_MUTECONF_MUTDACHSR, 1,
+			NULL, 0),
+	SND_SOC_DAPM_DAC("HSL DAC Driver", "ab8500_0p",
+			AB8500_ANACONF3, AB8500_ANACONF3_ENDRVHSL, 0),
+	SND_SOC_DAPM_DAC("HSR DAC Driver", "ab8500_0p",
+			AB8500_ANACONF3, AB8500_ANACONF3_ENDRVHSR, 0),
+
+	SND_SOC_DAPM_MIXER("HSL Mute",
+			AB8500_MUTECONF, AB8500_MUTECONF_MUTHSL, 1,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("HSR Mute",
+			AB8500_MUTECONF, AB8500_MUTECONF_MUTHSR, 1,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("HSL Enable",
+			AB8500_ANACONF4, AB8500_ANACONF4_ENHSL, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("HSR Enable",
+			AB8500_ANACONF4, AB8500_ANACONF4_ENHSR, 0,
+			NULL, 0),
+	SND_SOC_DAPM_PGA("HSL Gain",
+			SND_SOC_NOPM, 0, 0,
+			NULL, 0),
+	SND_SOC_DAPM_PGA("HSR Gain",
+			SND_SOC_NOPM, 0, 0,
+			NULL, 0),
+
+	SND_SOC_DAPM_OUTPUT("Headset Left"),
+	SND_SOC_DAPM_OUTPUT("Headset Right"),
+
+	/* LineOut path */
+
+	SND_SOC_DAPM_MUX("LineOut Source",
+			SND_SOC_NOPM, 0, 0, dapm_lineout_source),
+
+	SND_SOC_DAPM_MIXER("LOL Disable HFL",
+			AB8500_ANACONF4, AB8500_ANACONF4_ENHFL, 1,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("LOR Disable HFR",
+			AB8500_ANACONF4, AB8500_ANACONF4_ENHFR, 1,
+			NULL, 0),
+
+	SND_SOC_DAPM_MIXER("LOL Enable",
+			AB8500_ANACONF5, AB8500_ANACONF5_ENLOL, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("LOR Enable",
+			AB8500_ANACONF5, AB8500_ANACONF5_ENLOR, 0,
+			NULL, 0),
+
+	SND_SOC_DAPM_OUTPUT("LineOut Left"),
+	SND_SOC_DAPM_OUTPUT("LineOut Right"),
+
+	/* Earpiece path */
+
+	SND_SOC_DAPM_MUX("Earpiece or LineOut Mono Source",
+			SND_SOC_NOPM, 0, 0, &dapm_ear_lineout_source),
+	SND_SOC_DAPM_MIXER("EAR DAC",
+			AB8500_DAPATHCONF, AB8500_DAPATHCONF_ENDACEAR, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("EAR Mute",
+			AB8500_MUTECONF, AB8500_MUTECONF_MUTEAR, 1,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("EAR Enable",
+			AB8500_ANACONF4, AB8500_ANACONF4_ENEAR, 0,
+			NULL, 0),
+
+	SND_SOC_DAPM_OUTPUT("Earpiece"),
+
+	/* Handsfree path */
+
+	SND_SOC_DAPM_MIXER("DA3 Channel Gain",
+			AB8500_DAPATHENA, AB8500_DAPATHENA_ENDA3, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("DA4 Channel Gain",
+			AB8500_DAPATHENA, AB8500_DAPATHENA_ENDA4, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MUX("Speaker Left Source",
+			SND_SOC_NOPM, 0, 0, dapm_HFl_select),
+	SND_SOC_DAPM_MUX("Speaker Right Source",
+			SND_SOC_NOPM, 0, 0, dapm_HFr_select),
+	SND_SOC_DAPM_MIXER("HFL DAC", AB8500_DAPATHCONF,
+			AB8500_DAPATHCONF_ENDACHFL, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("HFR DAC",
+			AB8500_DAPATHCONF, AB8500_DAPATHCONF_ENDACHFR, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("DA4 or ANC path to HfR",
+			AB8500_DIGMULTCONF2, AB8500_DIGMULTCONF2_DATOHFREN, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("DA3 or ANC path to HfL",
+			AB8500_DIGMULTCONF2, AB8500_DIGMULTCONF2_DATOHFLEN, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("HFL Enable",
+			AB8500_ANACONF4, AB8500_ANACONF4_ENHFL, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("HFR Enable",
+			AB8500_ANACONF4, AB8500_ANACONF4_ENHFR, 0,
+			NULL, 0),
+
+	SND_SOC_DAPM_OUTPUT("Speaker Left"),
+	SND_SOC_DAPM_OUTPUT("Speaker Right"),
+
+	/* Vibrator path */
+
+	SND_SOC_DAPM_INPUT("PWMGEN1"),
+	SND_SOC_DAPM_INPUT("PWMGEN2"),
+
+	SND_SOC_DAPM_MIXER("DA5 Channel Gain",
+			AB8500_DAPATHENA, AB8500_DAPATHENA_ENDA5, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("DA6 Channel Gain",
+			AB8500_DAPATHENA, AB8500_DAPATHENA_ENDA6, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("VIB1 DAC",
+			AB8500_DAPATHCONF, AB8500_DAPATHCONF_ENDACVIB1, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("VIB2 DAC",
+			AB8500_DAPATHCONF, AB8500_DAPATHCONF_ENDACVIB2, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MUX("Vibra 1 Controller",
+			SND_SOC_NOPM, 0, 0, dapm_pwm2vib1),
+	SND_SOC_DAPM_MUX("Vibra 2 Controller",
+			SND_SOC_NOPM, 0, 0, dapm_pwm2vib2),
+	SND_SOC_DAPM_MIXER("VIB1 Enable",
+			AB8500_ANACONF4, AB8500_ANACONF4_ENVIB1, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("VIB2 Enable",
+			AB8500_ANACONF4, AB8500_ANACONF4_ENVIB2, 0,
+			NULL, 0),
+
+	SND_SOC_DAPM_OUTPUT("Vibra 1"),
+	SND_SOC_DAPM_OUTPUT("Vibra 2"),
+
+	/* Mic 1 */
+
+	SND_SOC_DAPM_INPUT("Mic 1"),
+
+	SND_SOC_DAPM_MUX("Mic 1a or 1b Select",
+			SND_SOC_NOPM, 0, 0, dapm_mic1ab_mux),
+	SND_SOC_DAPM_MIXER("MIC1 Mute",
+			AB8500_ANACONF2, AB8500_ANACONF2_MUTMIC1, 1,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("MIC1A V-AMICx Enable",
+			AB8500_ANACONF2, AB8500_ANACONF2_ENMIC1, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("MIC1B V-AMICx Enable",
+			AB8500_ANACONF2, AB8500_ANACONF2_ENMIC1, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("MIC1 ADC",
+			AB8500_ANACONF3, AB8500_ANACONF3_ENADCMIC, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MUX("AD3 Source Select",
+			SND_SOC_NOPM, 0, 0, dapm_ad3_select),
+	SND_SOC_DAPM_MIXER("AD3 Channel Gain",
+			SND_SOC_NOPM, 0, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("AD3 Enable",
+			AB8500_ADPATHENA, AB8500_ADPATHENA_ENAD34, 0,
+			NULL, 0),
+
+	/* Mic 2 */
+
+	SND_SOC_DAPM_INPUT("Mic 2"),
+
+	SND_SOC_DAPM_MIXER("MIC2 Mute",
+			AB8500_ANACONF2, AB8500_ANACONF2_MUTMIC2, 1,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("MIC2 V-AMICx Enable", AB8500_ANACONF2,
+			AB8500_ANACONF2_ENMIC2, 0,
+			NULL, 0),
+
+	/* LineIn */
+
+	SND_SOC_DAPM_INPUT("LineIn Left"),
+	SND_SOC_DAPM_INPUT("LineIn Right"),
+
+	SND_SOC_DAPM_MIXER("LINL Mute",
+			AB8500_ANACONF2, AB8500_ANACONF2_MUTLINL, 1,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("LINR Mute",
+			AB8500_ANACONF2, AB8500_ANACONF2_MUTLINR, 1,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("LINL Enable", AB8500_ANACONF2,
+			AB8500_ANACONF2_ENLINL, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("LINR Enable", AB8500_ANACONF2,
+			AB8500_ANACONF2_ENLINR, 0,
+			NULL, 0),
+
+	/* LineIn Bypass path */
+	SND_SOC_DAPM_MIXER("LINL to HSL Gain",
+			SND_SOC_NOPM, 0, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("LINR to HSR Gain",
+			SND_SOC_NOPM, 0, 0,
+			NULL, 0),
+
+	/* LineIn, Mic 2 */
+	SND_SOC_DAPM_MUX("Mic 2 or LINR Select",
+			SND_SOC_NOPM, 0, 0, dapm_mic2lr_select),
+	SND_SOC_DAPM_MIXER("LINL ADC", AB8500_ANACONF3,
+			AB8500_ANACONF3_ENADCLINL, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("LINR ADC", AB8500_ANACONF3,
+			AB8500_ANACONF3_ENADCLINR, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MUX("AD1 Source Select",
+			SND_SOC_NOPM, 0, 0, dapm_ad1_select),
+	SND_SOC_DAPM_MUX("AD2 Source Select",
+			SND_SOC_NOPM, 0, 0, dapm_ad2_select),
+	SND_SOC_DAPM_MIXER("AD1 Channel Gain",
+			SND_SOC_NOPM, 0, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("AD2 Channel Gain",
+			SND_SOC_NOPM, 0, 0,
+			NULL, 0),
+
+	SND_SOC_DAPM_MIXER("AD12 Enable",
+			AB8500_ADPATHENA, AB8500_ADPATHENA_ENAD12, 0,
+			NULL, 0),
+
+	/* HD Capture path */
+
+	SND_SOC_DAPM_MUX("AD5 Source Select",
+			SND_SOC_NOPM, 0, 0, dapm_ad5_select),
+	SND_SOC_DAPM_MUX("AD6 Source Select",
+			SND_SOC_NOPM, 0, 0, dapm_ad6_select),
+	SND_SOC_DAPM_MIXER("AD5 Channel Gain",
+			SND_SOC_NOPM, 0, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("AD6 Channel Gain",
+			SND_SOC_NOPM, 0, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("AD57 Enable",
+			AB8500_ADPATHENA, AB8500_ADPATHENA_ENAD5768, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("AD68 Enable",
+			AB8500_ADPATHENA, AB8500_ADPATHENA_ENAD5768, 0,
+			NULL, 0),
+
+	/* Digital Microphone path */
+
+	SND_SOC_DAPM_INPUT("DMic 1"),
+	SND_SOC_DAPM_INPUT("DMic 2"),
+	SND_SOC_DAPM_INPUT("DMic 3"),
+	SND_SOC_DAPM_INPUT("DMic 4"),
+	SND_SOC_DAPM_INPUT("DMic 5"),
+	SND_SOC_DAPM_INPUT("DMic 6"),
+
+	SND_SOC_DAPM_MIXER("DMIC1",
+			AB8500_DIGMICCONF, AB8500_DIGMICCONF_ENDMIC1, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("DMIC2",
+			AB8500_DIGMICCONF, AB8500_DIGMICCONF_ENDMIC2, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("DMIC3",
+			AB8500_DIGMICCONF, AB8500_DIGMICCONF_ENDMIC3, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("DMIC4",
+			AB8500_DIGMICCONF, AB8500_DIGMICCONF_ENDMIC4, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("DMIC5",
+			AB8500_DIGMICCONF, AB8500_DIGMICCONF_ENDMIC5, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("DMIC6",
+			AB8500_DIGMICCONF, AB8500_DIGMICCONF_ENDMIC6, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("AD4 Channel Gain",
+			SND_SOC_NOPM, 0, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("AD4 Enable",
+			AB8500_ADPATHENA, AB8500_ADPATHENA_ENAD34,
+			0, NULL, 0),
+
+	/* Acoustical Noise Cancellation path */
+
+	SND_SOC_DAPM_INPUT("ANC Configure Input"),
+	SND_SOC_DAPM_OUTPUT("ANC Configure Output"),
+
+	SND_SOC_DAPM_MUX("ANC Source",
+			SND_SOC_NOPM, 0, 0,
+			dapm_anc_in_select),
+	SND_SOC_DAPM_SWITCH("ANC",
+			SND_SOC_NOPM, 0, 0,
+			dapm_anc_enable),
+	SND_SOC_DAPM_SWITCH("ANC to Earpiece",
+			SND_SOC_NOPM, 0, 0,
+			dapm_anc_ear_mute),
+
+	/* Sidetone Filter path */
+
+	SND_SOC_DAPM_MUX("Sidetone Left Source",
+			SND_SOC_NOPM, 0, 0,
+			dapm_stfir1_in_select),
+	SND_SOC_DAPM_MUX("Sidetone Right Source",
+			SND_SOC_NOPM, 0, 0,
+			dapm_stfir2_in_select),
+	SND_SOC_DAPM_MIXER("STFIR1 Control",
+			SND_SOC_NOPM, 0, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("STFIR2 Control",
+			SND_SOC_NOPM, 0, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("STFIR1 Gain",
+			SND_SOC_NOPM, 0, 0,
+			NULL, 0),
+	SND_SOC_DAPM_MIXER("STFIR2 Gain",
+			SND_SOC_NOPM, 0, 0,
+			NULL, 0),
+};
+
+/*
+ * DAPM-routes
+ */
+static const struct snd_soc_dapm_route ab8500_dapm_routes[] = {
+	/* Power AB8500 audio-block when AD/DA is active */
+	{"Main Supply", NULL, "V-AUD"},
+	{"Main Supply", NULL, "audioclk"},
+	{"Main Supply", NULL, "Audio Power"},
+	{"Main Supply", NULL, "Audio Analog Power"},
+	{"Main Supply", NULL, "gpio.1"},
+	{"DAC", NULL, "Main Supply"},
+	{"ADC", NULL, "Main Supply"},
+
+	/* ANC Configure */
+	{"ANC Configure Input", NULL, "Main Supply"},
+	{"ANC Configure Output", NULL, "ANC Configure Input"},
+
+	/* AD/DA */
+	{"ADC", NULL, "ADC Input"},
+	{"DAC Output", NULL, "DAC"},
+
+	/* Powerup charge pump if DA1/2 is in use */
+	{"DA_IN1", NULL, "Charge Pump"},
+	{"DA_IN2", NULL, "Charge Pump"},
+
+	/* Headset path */
+
+	{"DA1 Enable", NULL, "DA_IN1"},
+	{"DA2 Enable", NULL, "DA_IN2"},
+
+	{"HSL Digital Gain", NULL, "DA1 Enable"},
+	{"HSR Digital Gain", NULL, "DA2 Enable"},
+
+	{"HSL DAC", NULL, "HSL Digital Gain"},
+	{"HSR DAC", NULL, "HSR Digital Gain"},
+
+	{"HSL DAC Mute", NULL, "HSL DAC"},
+	{"HSR DAC Mute", NULL, "HSR DAC"},
+
+	{"HSL DAC Driver", NULL, "HSL DAC Mute"},
+	{"HSR DAC Driver", NULL, "HSR DAC Mute"},
+
+	{"HSL Mute", NULL, "HSL DAC Driver"},
+	{"HSR Mute", NULL, "HSR DAC Driver"},
+
+	{"HSL Enable", NULL, "HSL Mute"},
+	{"HSR Enable", NULL, "HSR Mute"},
+
+	{"HSL Gain", NULL, "HSL Enable"},
+	{"HSR Gain", NULL, "HSR Enable"},
+
+	{"Headset Left", NULL, "HSL Gain"},
+	{"Headset Right", NULL, "HSR Gain"},
+
+	/* HF or LineOut path */
+
+	{"DA3 Channel Gain", NULL, "DA_IN3"},
+	{"DA4 Channel Gain", NULL, "DA_IN4"},
+
+	{"Speaker Left Source", "Audio Path", "DA3 Channel Gain"},
+	{"Speaker Right Source", "Audio Path", "DA4 Channel Gain"},
+
+	{"DA3 or ANC path to HfL", NULL, "Speaker Left Source"},
+	{"DA4 or ANC path to HfR", NULL, "Speaker Right Source"},
+
+	/* HF path */
+
+	{"HFL DAC", NULL, "DA3 or ANC path to HfL"},
+	{"HFR DAC", NULL, "DA4 or ANC path to HfR"},
+
+	{"HFL Enable", NULL, "HFL DAC"},
+	{"HFR Enable", NULL, "HFR DAC"},
+
+	{"Speaker Left", NULL, "HFL Enable"},
+	{"Speaker Right", NULL, "HFR Enable"},
+
+	/* Earpiece path */
+
+	{"Earpiece or LineOut Mono Source", "Headset Left",
+		"HSL Digital Gain"},
+	{"Earpiece or LineOut Mono Source", "Speaker Left",
+		"DA3 or ANC path to HfL"},
+
+	{"EAR DAC", NULL, "Earpiece or LineOut Mono Source"},
+
+	{"EAR Mute", NULL, "EAR DAC"},
+
+	{"EAR Enable", NULL, "EAR Mute"},
+
+	{"Earpiece", NULL, "EAR Enable"},
+
+	/* LineOut path stereo */
+
+	{"LineOut Source", "Stereo Path", "HSL DAC Driver"},
+	{"LineOut Source", "Stereo Path", "HSR DAC Driver"},
+
+	/* LineOut path mono */
+
+	{"LineOut Source", "Mono Path", "EAR DAC"},
+
+	/* LineOut path */
+
+	{"LOL Disable HFL", NULL, "LineOut Source"},
+	{"LOR Disable HFR", NULL, "LineOut Source"},
+
+	{"LOL Enable", NULL, "LOL Disable HFL"},
+	{"LOR Enable", NULL, "LOR Disable HFR"},
+
+	{"LineOut Left", NULL, "LOL Enable"},
+	{"LineOut Right", NULL, "LOR Enable"},
+
+	/* Vibrator path */
+
+	{"DA5 Channel Gain", NULL, "DA_IN5"},
+	{"DA6 Channel Gain", NULL, "DA_IN6"},
+
+	{"VIB1 DAC", NULL, "DA5 Channel Gain"},
+	{"VIB2 DAC", NULL, "DA6 Channel Gain"},
+
+	{"Vibra 1 Controller", "Audio Path", "VIB1 DAC"},
+	{"Vibra 2 Controller", "Audio Path", "VIB2 DAC"},
+	{"Vibra 1 Controller", "PWM Generator", "PWMGEN1"},
+	{"Vibra 2 Controller", "PWM Generator", "PWMGEN2"},
+
+	{"VIB1 Enable", NULL, "Vibra 1 Controller"},
+	{"VIB2 Enable", NULL, "Vibra 2 Controller"},
+
+	{"Vibra 1", NULL, "VIB1 Enable"},
+	{"Vibra 2", NULL, "VIB2 Enable"},
+
+
+	/* Mic 2 */
+
+	{"MIC2 V-AMICx Enable", NULL, "Mic 2"},
+
+	/* LineIn */
+	{"LINL Mute", NULL, "LineIn Left"},
+	{"LINR Enable", NULL, "LineIn Right"},
+
+	{"LINL Enable", NULL, "LINL Mute"},
+	{"LINR Enable", NULL, "LineIn Right"},
+
+	/* LineIn, Mic 2 */
+	{"Mic 2 or LINR Select", "LineIn Right", "LINR Enable"},
+	{"Mic 2 or LINR Select", "Mic 2", "MIC2 V-AMICx Enable"},
+
+	{"LINL ADC", NULL, "LINL Enable"},
+	{"LINR ADC", NULL, "Mic 2 or LINR Select"},
+
+	{"AD1 Source Select", "LineIn Left", "LINL ADC"},
+	{"AD2 Source Select", "LineIn Right", "LINR ADC"},
+
+	{"AD1 Channel Gain", NULL, "AD1 Source Select"},
+	{"AD2 Channel Gain", NULL, "AD2 Source Select"},
+
+	{"AD12 Enable", NULL, "AD1 Channel Gain"},
+	{"AD12 Enable", NULL, "AD2 Channel Gain"},
+
+	{"AD_OUT1", NULL, "AD12 Enable"},
+	{"AD_OUT2", NULL, "AD12 Enable"},
+
+	/* Mic 1 */
+
+	{"MIC1 Mute", NULL, "Mic 1"},
+
+	{"MIC1A V-AMICx Enable", NULL, "MIC1 Mute"},
+	{"MIC1B V-AMICx Enable", NULL, "MIC1 Mute"},
+
+	{"Mic 1a or 1b Select", "Mic 1a", "MIC1A V-AMICx Enable"},
+	{"Mic 1a or 1b Select", "Mic 1b", "MIC1B V-AMICx Enable"},
+
+	{"MIC1 ADC", NULL, "Mic 1a or 1b Select"},
+
+	{"AD3 Source Select", "Mic 1", "MIC1 ADC"},
+
+	{"AD3 Channel Gain", NULL, "AD3 Source Select"},
+
+	{"AD3 Enable", NULL, "AD3 Channel Gain"},
+
+	{"AD_OUT3", NULL, "AD3 Enable"},
+
+	/* HD Capture path */
+
+	{"AD5 Source Select", "Mic 2", "LINR ADC"},
+	{"AD6 Source Select", "Mic 1", "MIC1 ADC"},
+
+	{"AD5 Channel Gain", NULL, "AD5 Source Select"},
+	{"AD6 Channel Gain", NULL, "AD6 Source Select"},
+
+	{"AD57 Enable", NULL, "AD5 Channel Gain"},
+	{"AD68 Enable", NULL, "AD6 Channel Gain"},
+
+	{"AD_OUT57", NULL, "AD57 Enable"},
+	{"AD_OUT68", NULL, "AD68 Enable"},
+
+	/* Digital Microphone path */
+
+	{"DMic 1", NULL, "V-DMIC"},
+	{"DMic 2", NULL, "V-DMIC"},
+	{"DMic 3", NULL, "V-DMIC"},
+	{"DMic 4", NULL, "V-DMIC"},
+	{"DMic 5", NULL, "V-DMIC"},
+	{"DMic 6", NULL, "V-DMIC"},
+
+	{"AD1 Source Select", NULL, "DMic 1"},
+	{"AD2 Source Select", NULL, "DMic 2"},
+	{"AD3 Source Select", NULL, "DMic 3"},
+	{"AD5 Source Select", NULL, "DMic 5"},
+	{"AD6 Source Select", NULL, "DMic 6"},
+
+	{"AD4 Channel Gain", NULL, "DMic 4"},
+	{"AD4 Enable", NULL, "AD4 Channel Gain"},
+
+	{"AD_OUT4", NULL, "AD4 Enable"},
+
+	/* LineIn Bypass path */
+
+	{"LINL to HSL Gain", NULL, "LINL Enable"},
+	{"LINR to HSR Gain", NULL, "LINR Enable"},
+
+	{"HSL DAC Driver", NULL, "LINL to HSL Gain"},
+	{"HSR DAC Driver", NULL, "LINR to HSR Gain"},
+
+	/* ANC path (Acoustic Noise Cancellation) */
+
+	{"ANC Source", "Mic 2 / DMic 5", "AD5 Channel Gain"},
+	{"ANC Source", "Mic 1 / DMic 6", "AD6 Channel Gain"},
+
+	{"ANC", "Switch", "ANC Source"},
+
+	{"Speaker Left Source", "ANC", "ANC"},
+	{"Speaker Right Source", "ANC", "ANC"},
+	{"ANC to Earpiece", "Switch", "ANC"},
+
+	{"HSL Digital Gain", NULL, "ANC to Earpiece"},
+
+	/* Sidetone Filter path */
+
+	{"Sidetone Left Source", "LineIn Left", "AD12 Enable"},
+	{"Sidetone Left Source", "LineIn Right", "AD12 Enable"},
+	{"Sidetone Left Source", "Mic 1", "AD3 Enable"},
+	{"Sidetone Left Source", "Headset Left", "DA_IN1"},
+	{"Sidetone Right Source", "LineIn Right", "AD12 Enable"},
+	{"Sidetone Right Source", "Mic 1", "AD3 Enable"},
+	{"Sidetone Right Source", "DMic 4", "AD4 Enable"},
+	{"Sidetone Right Source", "Headset Right", "DA_IN2"},
+
+	{"STFIR1 Control", NULL, "Sidetone Left Source"},
+	{"STFIR2 Control", NULL, "Sidetone Right Source"},
+
+	{"STFIR1 Gain", NULL, "STFIR1 Control"},
+	{"STFIR2 Gain", NULL, "STFIR2 Control"},
+
+	{"DA1 Enable", NULL, "STFIR1 Gain"},
+	{"DA2 Enable", NULL, "STFIR2 Gain"},
+};
+
+static const struct snd_soc_dapm_route ab8500_dapm_routes_mic1a_vamicx[] = {
+	{"MIC1A V-AMICx Enable", NULL, "V-AMIC1"},
+	{"MIC1A V-AMICx Enable", NULL, "V-AMIC2"},
+};
+
+static const struct snd_soc_dapm_route ab8500_dapm_routes_mic1b_vamicx[] = {
+	{"MIC1B V-AMICx Enable", NULL, "V-AMIC1"},
+	{"MIC1B V-AMICx Enable", NULL, "V-AMIC2"},
+};
+
+static const struct snd_soc_dapm_route ab8500_dapm_routes_mic2_vamicx[] = {
+	{"MIC2 V-AMICx Enable", NULL, "V-AMIC1"},
+	{"MIC2 V-AMICx Enable", NULL, "V-AMIC2"},
+};
+
+/* ANC FIR-coefficients configuration sequence */
+static void anc_fir(struct snd_soc_codec *codec,
+		unsigned int bnk, unsigned int par, unsigned int val)
+{
+	if (par == 0 && bnk == 0)
+		snd_soc_update_bits(codec, AB8500_ANCCONF1,
+			BIT(AB8500_ANCCONF1_ANCFIRUPDATE),
+			BIT(AB8500_ANCCONF1_ANCFIRUPDATE));
+
+	snd_soc_write(codec, AB8500_ANCCONF5, val >> 8 & 0xff);
+	snd_soc_write(codec, AB8500_ANCCONF6, val &  0xff);
+
+	if (par == AB8500_ANC_FIR_COEFFS - 1 && bnk == 1)
+		snd_soc_update_bits(codec, AB8500_ANCCONF1,
+			BIT(AB8500_ANCCONF1_ANCFIRUPDATE), 0);
+}
+
+/* ANC IIR-coefficients configuration sequence */
+static void anc_iir(struct snd_soc_codec *codec, unsigned int bnk,
+		unsigned int par, unsigned int val)
+{
+	if (par == 0) {
+		if (bnk == 0) {
+			snd_soc_update_bits(codec, AB8500_ANCCONF1,
+					BIT(AB8500_ANCCONF1_ANCIIRINIT),
+					BIT(AB8500_ANCCONF1_ANCIIRINIT));
+			usleep_range(AB8500_ANC_SM_DELAY, AB8500_ANC_SM_DELAY);
+			snd_soc_update_bits(codec, AB8500_ANCCONF1,
+					BIT(AB8500_ANCCONF1_ANCIIRINIT), 0);
+			usleep_range(AB8500_ANC_SM_DELAY, AB8500_ANC_SM_DELAY);
+		} else {
+			snd_soc_update_bits(codec, AB8500_ANCCONF1,
+					BIT(AB8500_ANCCONF1_ANCIIRUPDATE),
+					BIT(AB8500_ANCCONF1_ANCIIRUPDATE));
+		}
+	} else if (par > 3) {
+		snd_soc_write(codec, AB8500_ANCCONF7, 0);
+		snd_soc_write(codec, AB8500_ANCCONF8, val >> 16 & 0xff);
+	}
+
+	snd_soc_write(codec, AB8500_ANCCONF7, val >> 8 & 0xff);
+	snd_soc_write(codec, AB8500_ANCCONF8, val & 0xff);
+
+	if (par == AB8500_ANC_IIR_COEFFS - 1 && bnk == 1)
+		snd_soc_update_bits(codec, AB8500_ANCCONF1,
+			BIT(AB8500_ANCCONF1_ANCIIRUPDATE), 0);
+}
+
+/* ANC IIR-/FIR-coefficients configuration sequence */
+static void anc_configure(struct snd_soc_codec *codec,
+			bool apply_fir, bool apply_iir)
+{
+	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
+	unsigned int bnk, par, val;
+
+	dev_dbg(codec->dev, "%s: Enter.\n", __func__);
+
+	if (apply_fir)
+		snd_soc_update_bits(codec, AB8500_ANCCONF1,
+			BIT(AB8500_ANCCONF1_ENANC), 0);
+
+	snd_soc_update_bits(codec, AB8500_ANCCONF1,
+		BIT(AB8500_ANCCONF1_ENANC), BIT(AB8500_ANCCONF1_ENANC));
+
+	if (apply_fir)
+		for (bnk = 0; bnk < AB8500_NR_OF_ANC_COEFF_BANKS; bnk++)
+			for (par = 0; par < AB8500_ANC_FIR_COEFFS; par++) {
+				val = snd_soc_read(codec,
+						drvdata->anc_fir_values[par]);
+				anc_fir(codec, bnk, par, val);
+			}
+
+	if (apply_iir)
+		for (bnk = 0; bnk < AB8500_NR_OF_ANC_COEFF_BANKS; bnk++)
+			for (par = 0; par < AB8500_ANC_IIR_COEFFS; par++) {
+				val = snd_soc_read(codec,
+						drvdata->anc_iir_values[par]);
+				anc_iir(codec, bnk, par, val);
+			}
+
+	dev_dbg(codec->dev, "%s: Exit.\n", __func__);
+}
+
+/*
+ * Control-events
+ */
+
+static int sid_status_control_get(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
+
+	mutex_lock(&codec->mutex);
+	ucontrol->value.integer.value[0] = drvdata->sid_status;
+	mutex_unlock(&codec->mutex);
+
+	return 0;
+}
+
+/* Write sidetone FIR-coefficients configuration sequence */
+static int sid_status_control_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
+	unsigned int param, sidconf, val;
+	int status = 1;
+
+	dev_dbg(codec->dev, "%s: Enter\n", __func__);
+
+	if (ucontrol->value.integer.value[0] != SID_APPLY_FIR) {
+		dev_err(codec->dev,
+			"%s: ERROR: This control supports '%s' only!\n",
+			__func__, enum_sid_state[SID_APPLY_FIR]);
+		return 0;
+	}
+
+	mutex_lock(&codec->mutex);
+
+	sidconf = snd_soc_read(codec, AB8500_SIDFIRCONF);
+	if (((sidconf & BIT(AB8500_SIDFIRCONF_FIRSIDBUSY)) != 0)) {
+		if ((sidconf & BIT(AB8500_SIDFIRCONF_ENFIRSIDS)) == 0) {
+			dev_err(codec->dev, "%s: Sidetone busy while off!\n",
+				__func__);
+			status = -EPERM;
+		} else {
+			status = -EBUSY;
+		}
+		goto out;
+	}
+
+	snd_soc_write(codec, AB8500_SIDFIRADR, 0);
+
+	for (param = 0; param < AB8500_SID_FIR_COEFFS; param++) {
+		val = snd_soc_read(codec, drvdata->sid_fir_values[param]);
+		snd_soc_write(codec, AB8500_SIDFIRCOEF1, val >> 8 & 0xff);
+		snd_soc_write(codec, AB8500_SIDFIRCOEF2, val & 0xff);
+	}
+
+	snd_soc_update_bits(codec, AB8500_SIDFIRADR,
+		BIT(AB8500_SIDFIRADR_FIRSIDSET),
+		BIT(AB8500_SIDFIRADR_FIRSIDSET));
+	snd_soc_update_bits(codec, AB8500_SIDFIRADR,
+		BIT(AB8500_SIDFIRADR_FIRSIDSET), 0);
+
+	drvdata->sid_status = SID_FIR_CONFIGURED;
+
+out:
+	mutex_unlock(&codec->mutex);
+
+	dev_dbg(codec->dev, "%s: Exit\n", __func__);
+
+	return status;
+}
+
+static int anc_status_control_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
+
+	mutex_lock(&codec->mutex);
+	ucontrol->value.integer.value[0] = drvdata->anc_status;
+	mutex_unlock(&codec->mutex);
+
+	return 0;
+}
+
+static int anc_status_control_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
+	struct device *dev = codec->dev;
+	bool apply_fir, apply_iir;
+	int req, status;
+
+	dev_dbg(dev, "%s: Enter.\n", __func__);
+
+	req = ucontrol->value.integer.value[0];
+	if (req != ANC_APPLY_FIR_IIR && req != ANC_APPLY_FIR &&
+		req != ANC_APPLY_IIR) {
+		dev_err(dev, "%s: ERROR: Unsupported status to set '%s'!\n",
+			__func__, enum_anc_state[req]);
+		return -EINVAL;
+	}
+	apply_fir = req == ANC_APPLY_FIR || req == ANC_APPLY_FIR_IIR;
+	apply_iir = req == ANC_APPLY_IIR || req == ANC_APPLY_FIR_IIR;
+
+	status = snd_soc_dapm_force_enable_pin(&codec->dapm,
+					"ANC Configure Input");
+	if (status < 0) {
+		dev_err(dev,
+			"%s: ERROR: Failed to enable power (status = %d)!\n",
+			__func__, status);
+		goto cleanup;
+	}
+	snd_soc_dapm_sync(&codec->dapm);
+
+	mutex_lock(&codec->mutex);
+
+	anc_configure(codec, apply_fir, apply_iir);
+
+	if (apply_fir) {
+		if (drvdata->anc_status == ANC_IIR_CONFIGURED)
+			drvdata->anc_status = ANC_FIR_IIR_CONFIGURED;
+		else if (drvdata->anc_status != ANC_FIR_IIR_CONFIGURED)
+			drvdata->anc_status =  ANC_FIR_CONFIGURED;
+	}
+	if (apply_iir) {
+		if (drvdata->anc_status == ANC_FIR_CONFIGURED)
+			drvdata->anc_status = ANC_FIR_IIR_CONFIGURED;
+		else if (drvdata->anc_status != ANC_FIR_IIR_CONFIGURED)
+			drvdata->anc_status =  ANC_IIR_CONFIGURED;
+	}
+
+	mutex_unlock(&codec->mutex);
+
+	status = snd_soc_dapm_disable_pin(&codec->dapm, "ANC Configure Input");
+	snd_soc_dapm_sync(&codec->dapm);
+
+cleanup:
+	if (status < 0)
+		dev_err(dev, "%s: Unable to configure ANC! (status = %d)\n",
+			__func__, status);
+
+	dev_dbg(dev, "%s: Exit.\n", __func__);
+
+	return (status < 0) ? status : 1;
+}
+
+static int filter_control_info(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
+{
+	struct filter_control *fc =
+			(struct filter_control *)kcontrol->private_value;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = fc->count;
+	uinfo->value.integer.min = fc->min;
+	uinfo->value.integer.max = fc->max;
+
+	return 0;
+}
+
+static int filter_control_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct filter_control *fc =
+			(struct filter_control *)kcontrol->private_value;
+	unsigned int i;
+
+	for (i = 0; i < fc->count; i++)
+		ucontrol->value.integer.value[i] = fc->value[i];
+
+	return 0;
+}
+
+static int filter_control_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct filter_control *fc =
+			(struct filter_control *)kcontrol->private_value;
+	unsigned int i;
+
+	for (i = 0; i < fc->count; i++)
+		fc->value[i] = ucontrol->value.integer.value[i];
+
+	return 0;
+}
+
+static int mclk_input_control_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
+
+	ucontrol->value.enumerated.item[0] = drvdata->mclk_sel;
+
+	return 0;
+}
+
+static int mclk_input_control_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
+	unsigned int val;
+
+	val = (ucontrol->value.enumerated.item[0] != 0);
+	if (drvdata->mclk_sel == val)
+		return 0;
+
+	drvdata->mclk_sel = val;
+
+	return 1;
+}
+
+/*
+ * Controls - Non-DAPM ASoC
+ */
+
+static const char * const enum_ena_dis[] = {"Enabled", "Disabled"};
+static const char * const enum_dis_ena[] = {"Disabled", "Enabled"};
+
+static DECLARE_TLV_DB_SCALE(adx_dig_gain_tlv, -3200, 100, 1);
+/* -32dB = Mute */
+
+static DECLARE_TLV_DB_SCALE(dax_dig_gain_tlv, -6300, 100, 1);
+/* -63dB = Mute */
+
+static DECLARE_TLV_DB_SCALE(hs_ear_dig_gain_tlv, -100, 100, 1);
+/* -1dB = Mute */
+
+static const unsigned int hs_gain_tlv[] = {
+	TLV_DB_RANGE_HEAD(2),
+	0, 3, TLV_DB_SCALE_ITEM(-3200, 400, 0),
+	4, 15, TLV_DB_SCALE_ITEM(-1800, 200, 0),
+};
+
+static DECLARE_TLV_DB_SCALE(mic_gain_tlv, 0, 100, 0);
+
+static DECLARE_TLV_DB_SCALE(lin_gain_tlv, -1000, 200, 0);
+
+static DECLARE_TLV_DB_SCALE(lin2hs_gain_tlv, -3800, 200, 1);
+/* -38dB = Mute */
+
+/* Headset */
+
+static SOC_ENUM_SINGLE_DECL(soc_enum_hshpen,
+	AB8500_ANACONF1, AB8500_ANACONF1_HSHPEN, enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_hslowpow,
+	AB8500_ANACONF1, AB8500_ANACONF1_HSLOWPOW, enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_daclowpow1,
+	AB8500_ANACONF1, AB8500_ANACONF1_DACLOWPOW1, enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_daclowpow0,
+	AB8500_ANACONF1, AB8500_ANACONF1_DACLOWPOW0, enum_dis_ena);
+
+static const char * const enum_hsfadspeed[] = {"2ms", "0.5ms", "10.6ms",
+					"5ms"};
+static SOC_ENUM_SINGLE_DECL(soc_enum_hsfadspeed,
+	AB8500_DIGMICCONF, AB8500_DIGMICCONF_HSFADSPEED, enum_hsfadspeed);
+
+static const char * const enum_envdetthre[] = {
+	"250mV", "300mV", "350mV", "400mV",
+	"450mV", "500mV", "550mV", "600mV",
+	"650mV", "700mV", "750mV", "800mV",
+	"850mV", "900mV", "950mV", "1.00V" };
+static SOC_ENUM_SINGLE_DECL(soc_enum_envdetcpen,
+	AB8500_SIGENVCONF, AB8500_SIGENVCONF_ENVDETCPEN, enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_envdeththre,
+	AB8500_ENVCPCONF, AB8500_ENVCPCONF_ENVDETHTHRE, enum_envdetthre);
+static SOC_ENUM_SINGLE_DECL(soc_enum_envdetlthre,
+	AB8500_ENVCPCONF, AB8500_ENVCPCONF_ENVDETLTHRE, enum_envdetthre);
+static const char * const enum_envdettime[] = {
+	"26.6us", "53.2us", "106us",  "213us",
+	"426us",  "851us",  "1.70ms", "3.40ms",
+	"6.81ms", "13.6ms", "27.2ms", "54.5ms",
+	"109ms",  "218ms",  "436ms",  "872ms" };
+static SOC_ENUM_SINGLE_DECL(soc_enum_envdettime,
+	AB8500_SIGENVCONF, AB8500_SIGENVCONF_ENVDETTIME, enum_envdettime);
+
+static const char * const enum_sinc31[] = {"Sinc 3", "Sinc 1"};
+static SOC_ENUM_SINGLE_DECL(soc_enum_hsesinc, AB8500_HSLEARDIGGAIN,
+			AB8500_HSLEARDIGGAIN_HSSINC1, enum_sinc31);
+
+static const char * const enum_fadespeed[] = {"1ms", "4ms", "8ms", "16ms"};
+static SOC_ENUM_SINGLE_DECL(soc_enum_fadespeed, AB8500_HSRDIGGAIN,
+			AB8500_HSRDIGGAIN_FADESPEED, enum_fadespeed);
+
+/* Earpiece */
+
+static const char * const enum_lowpow[] = {"Normal", "Low Power"};
+static SOC_ENUM_SINGLE_DECL(soc_enum_eardaclowpow, AB8500_ANACONF1,
+			AB8500_ANACONF1_EARDACLOWPOW, enum_lowpow);
+static SOC_ENUM_SINGLE_DECL(soc_enum_eardrvlowpow, AB8500_ANACONF1,
+			AB8500_ANACONF1_EARDRVLOWPOW, enum_lowpow);
+
+/* Handsfree */
+
+static SOC_ENUM_SINGLE_DECL(soc_enum_parlhf, AB8500_CLASSDCONF1,
+			AB8500_CLASSDCONF1_PARLHF, enum_dis_ena);
+static SOC_ENUM_DOUBLE_DECL(soc_enum_hflrswap, AB8500_CLASSDCONF1,
+			AB8500_CLASSDCONF1_HFLSWAPEN,
+			AB8500_CLASSDCONF1_HFRSWAPEN, enum_dis_ena);
+
+/* Vibra */
+
+static SOC_ENUM_SINGLE_DECL(soc_enum_parlvib,
+			AB8500_CLASSDCONF1, AB8500_CLASSDCONF1_PARLVIB,
+			enum_dis_ena);
+static SOC_ENUM_DOUBLE_DECL(soc_enum_vib12swap, AB8500_CLASSDCONF1,
+			AB8500_CLASSDCONF1_VIB1SWAPEN,
+			AB8500_CLASSDCONF1_VIB2SWAPEN,
+			enum_dis_ena);
+
+/* Mic 1 */
+
+static SOC_ENUM_SINGLE_DECL(soc_enum_lowpowmic1,
+	AB8500_ANAGAIN1, AB8500_ANAGAINX_LOWPOWMICX, enum_dis_ena);
+
+/* Mic 2 */
+
+static SOC_ENUM_SINGLE_DECL(soc_enum_lowpowmic2,
+	AB8500_ANAGAIN2, AB8500_ANAGAINX_LOWPOWMICX, enum_dis_ena);
+
+/* AD */
+
+static SOC_ENUM_DOUBLE_DECL(soc_enum_ad12nh, AB8500_ADFILTCONF,
+	AB8500_ADFILTCONF_AD1NH, AB8500_ADFILTCONF_AD2NH, enum_ena_dis);
+static SOC_ENUM_DOUBLE_DECL(soc_enum_ad34nh, AB8500_ADFILTCONF,
+	AB8500_ADFILTCONF_AD3NH, AB8500_ADFILTCONF_AD4NH, enum_ena_dis);
+
+static const char * const enum_av_mode[] = {"Audio", "Voice"};
+static SOC_ENUM_DOUBLE_DECL(soc_enum_ad12voice, AB8500_ADFILTCONF,
+	AB8500_ADFILTCONF_AD1VOICE, AB8500_ADFILTCONF_AD2VOICE, enum_av_mode);
+static SOC_ENUM_DOUBLE_DECL(soc_enum_ad34voice, AB8500_ADFILTCONF,
+	AB8500_ADFILTCONF_AD3VOICE, AB8500_ADFILTCONF_AD4VOICE, enum_av_mode);
+
+/* DA */
+
+static SOC_ENUM_SINGLE_DECL(soc_enum_da12voice,
+			AB8500_DASLOTCONF1, AB8500_DASLOTCONF1_DA12VOICE,
+			enum_av_mode);
+static SOC_ENUM_SINGLE_DECL(soc_enum_da34voice,
+			AB8500_DASLOTCONF3, AB8500_DASLOTCONF3_DA34VOICE,
+			enum_av_mode);
+static SOC_ENUM_SINGLE_DECL(soc_enum_da56voice,
+			AB8500_DASLOTCONF5, AB8500_DASLOTCONF5_DA56VOICE,
+			enum_av_mode);
+
+static SOC_ENUM_SINGLE_DECL(soc_enum_swapda12_34,
+			AB8500_DASLOTCONF1, AB8500_DASLOTCONF1_SWAPDA12_34,
+			enum_dis_ena);
+
+static const char * const enum_da2hslr[] = {"Sidetone", "Audio Path"};
+static SOC_ENUM_DOUBLE_DECL(soc_enum_da2hslr, AB8500_DIGMULTCONF1,
+			AB8500_DIGMULTCONF1_DATOHSLEN,
+			AB8500_DIGMULTCONF1_DATOHSREN, enum_da2hslr);
+
+/* FIR-filters */
+static SOC_ENUM_DOUBLE_DECL(soc_enum_fir01byp, AB8500_CLASSDCONF2,
+			AB8500_CLASSDCONF2_FIRBYP0, AB8500_CLASSDCONF2_FIRBYP1,
+			enum_dis_ena);
+static SOC_ENUM_DOUBLE_DECL(soc_enum_fir23byp, AB8500_CLASSDCONF2,
+			AB8500_CLASSDCONF2_FIRBYP2,
+			AB8500_CLASSDCONF2_FIRBYP3, enum_dis_ena);
+
+static const char * const enum_sinc53[] = {"Sinc 5", "Sinc 3"};
+static SOC_ENUM_DOUBLE_DECL(soc_enum_dmic12sinc, AB8500_DMICFILTCONF,
+			AB8500_DMICFILTCONF_DMIC1SINC3,
+			AB8500_DMICFILTCONF_DMIC2SINC3, enum_sinc53);
+static SOC_ENUM_DOUBLE_DECL(soc_enum_dmic34sinc, AB8500_DMICFILTCONF,
+			AB8500_DMICFILTCONF_DMIC3SINC3,
+			AB8500_DMICFILTCONF_DMIC4SINC3, enum_sinc53);
+static SOC_ENUM_DOUBLE_DECL(soc_enum_dmic56sinc, AB8500_DMICFILTCONF,
+			AB8500_DMICFILTCONF_DMIC5SINC3,
+			AB8500_DMICFILTCONF_DMIC6SINC3, enum_sinc53);
+
+/* Class-D amps */
+static SOC_ENUM_DOUBLE_DECL(soc_enum_highvol01, AB8500_CLASSDCONF2,
+			AB8500_CLASSDCONF2_HIGHVOLEN0,
+			AB8500_CLASSDCONF2_HIGHVOLEN1, enum_dis_ena);
+static SOC_ENUM_DOUBLE_DECL(soc_enum_highvol23, AB8500_CLASSDCONF2,
+			AB8500_CLASSDCONF2_HIGHVOLEN2,
+			AB8500_CLASSDCONF2_HIGHVOLEN3, enum_dis_ena);
+
+/* Digital interface - Clocks */
+static SOC_ENUM_SINGLE_DECL(soc_enum_mastgen,
+			AB8500_DIGIFCONF1, AB8500_DIGIFCONF1_ENMASTGEN,
+			enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_fsbitclk0,
+			AB8500_DIGIFCONF1, AB8500_DIGIFCONF1_ENFSBITCLK0,
+			enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_fsbitclk1,
+			AB8500_DIGIFCONF1, AB8500_DIGIFCONF1_ENFSBITCLK1,
+			enum_dis_ena);
+static SOC_ENUM_SINGLE_EXT_DECL(soc_enum_mclk, enum_mclk);
+
+/* Digital interface - DA from slot mapping */
+static const char * const enum_da_from_slot_map[] = {"SLOT0",
+					"SLOT1",
+					"SLOT2",
+					"SLOT3",
+					"SLOT4",
+					"SLOT5",
+					"SLOT6",
+					"SLOT7",
+					"SLOT8",
+					"SLOT9",
+					"SLOT10",
+					"SLOT11",
+					"SLOT12",
+					"SLOT13",
+					"SLOT14",
+					"SLOT15",
+					"SLOT16",
+					"SLOT17",
+					"SLOT18",
+					"SLOT19",
+					"SLOT20",
+					"SLOT21",
+					"SLOT22",
+					"SLOT23",
+					"SLOT24",
+					"SLOT25",
+					"SLOT26",
+					"SLOT27",
+					"SLOT28",
+					"SLOT29",
+					"SLOT30",
+					"SLOT31"};
+static SOC_ENUM_SINGLE_DECL(soc_enum_da1slotmap,
+			AB8500_DASLOTCONF1, AB8500_DASLOTCONFX_SLTODAX_SHIFT,
+			enum_da_from_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_da2slotmap,
+			AB8500_DASLOTCONF2, AB8500_DASLOTCONFX_SLTODAX_SHIFT,
+			enum_da_from_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_da3slotmap,
+			AB8500_DASLOTCONF3, AB8500_DASLOTCONFX_SLTODAX_SHIFT,
+			enum_da_from_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_da4slotmap,
+			AB8500_DASLOTCONF4, AB8500_DASLOTCONFX_SLTODAX_SHIFT,
+			enum_da_from_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_da5slotmap,
+			AB8500_DASLOTCONF5, AB8500_DASLOTCONFX_SLTODAX_SHIFT,
+			enum_da_from_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_da6slotmap,
+			AB8500_DASLOTCONF6, AB8500_DASLOTCONFX_SLTODAX_SHIFT,
+			enum_da_from_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_da7slotmap,
+			AB8500_DASLOTCONF7, AB8500_DASLOTCONFX_SLTODAX_SHIFT,
+			enum_da_from_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_da8slotmap,
+			AB8500_DASLOTCONF8, AB8500_DASLOTCONFX_SLTODAX_SHIFT,
+			enum_da_from_slot_map);
+
+/* Digital interface - AD to slot mapping */
+static const char * const enum_ad_to_slot_map[] = {"AD_OUT1",
+					"AD_OUT2",
+					"AD_OUT3",
+					"AD_OUT4",
+					"AD_OUT5",
+					"AD_OUT6",
+					"AD_OUT7",
+					"AD_OUT8",
+					"zeroes",
+					"tristate"};
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot0map,
+			AB8500_ADSLOTSEL1, AB8500_ADSLOTSELX_EVEN_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot1map,
+			AB8500_ADSLOTSEL1, AB8500_ADSLOTSELX_ODD_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot2map,
+			AB8500_ADSLOTSEL2, AB8500_ADSLOTSELX_EVEN_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot3map,
+			AB8500_ADSLOTSEL2, AB8500_ADSLOTSELX_ODD_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot4map,
+			AB8500_ADSLOTSEL3, AB8500_ADSLOTSELX_EVEN_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot5map,
+			AB8500_ADSLOTSEL3, AB8500_ADSLOTSELX_ODD_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot6map,
+			AB8500_ADSLOTSEL4, AB8500_ADSLOTSELX_EVEN_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot7map,
+			AB8500_ADSLOTSEL4, AB8500_ADSLOTSELX_ODD_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot8map,
+			AB8500_ADSLOTSEL5, AB8500_ADSLOTSELX_EVEN_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot9map,
+			AB8500_ADSLOTSEL5, AB8500_ADSLOTSELX_ODD_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot10map,
+			AB8500_ADSLOTSEL6, AB8500_ADSLOTSELX_EVEN_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot11map,
+			AB8500_ADSLOTSEL6, AB8500_ADSLOTSELX_ODD_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot12map,
+			AB8500_ADSLOTSEL7, AB8500_ADSLOTSELX_EVEN_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot13map,
+			AB8500_ADSLOTSEL7, AB8500_ADSLOTSELX_ODD_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot14map,
+			AB8500_ADSLOTSEL8, AB8500_ADSLOTSELX_EVEN_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot15map,
+			AB8500_ADSLOTSEL8, AB8500_ADSLOTSELX_ODD_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot16map,
+			AB8500_ADSLOTSEL9, AB8500_ADSLOTSELX_EVEN_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot17map,
+			AB8500_ADSLOTSEL9, AB8500_ADSLOTSELX_ODD_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot18map,
+			AB8500_ADSLOTSEL10, AB8500_ADSLOTSELX_EVEN_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot19map,
+			AB8500_ADSLOTSEL10, AB8500_ADSLOTSELX_ODD_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot20map,
+			AB8500_ADSLOTSEL11, AB8500_ADSLOTSELX_EVEN_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot21map,
+			AB8500_ADSLOTSEL11, AB8500_ADSLOTSELX_ODD_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot22map,
+			AB8500_ADSLOTSEL12, AB8500_ADSLOTSELX_EVEN_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot23map,
+			AB8500_ADSLOTSEL12, AB8500_ADSLOTSELX_ODD_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot24map,
+			AB8500_ADSLOTSEL13, AB8500_ADSLOTSELX_EVEN_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot25map,
+			AB8500_ADSLOTSEL13, AB8500_ADSLOTSELX_ODD_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot26map,
+			AB8500_ADSLOTSEL14, AB8500_ADSLOTSELX_EVEN_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot27map,
+			AB8500_ADSLOTSEL14, AB8500_ADSLOTSELX_ODD_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot28map,
+			AB8500_ADSLOTSEL15, AB8500_ADSLOTSELX_EVEN_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot29map,
+			AB8500_ADSLOTSEL15, AB8500_ADSLOTSELX_ODD_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot30map,
+			AB8500_ADSLOTSEL16, AB8500_ADSLOTSELX_EVEN_SHIFT,
+			enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot31map,
+			AB8500_ADSLOTSEL16, AB8500_ADSLOTSELX_ODD_SHIFT,
+			enum_ad_to_slot_map);
+
+/* Digital interface - Digital loopback */
+static SOC_ENUM_SINGLE_DECL(soc_enum_ad1loop,
+			AB8500_DASLOTCONF1, AB8500_DASLOTCONF1_DAI7TOADO1,
+			enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_ad2loop,
+			AB8500_DASLOTCONF2, AB8500_DASLOTCONF2_DAI8TOADO2,
+			enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_ad3loop,
+			AB8500_DASLOTCONF3, AB8500_DASLOTCONF3_DAI7TOADO3,
+			enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_ad4loop,
+			AB8500_DASLOTCONF4, AB8500_DASLOTCONF4_DAI8TOADO4,
+			enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_ad5loop,
+			AB8500_DASLOTCONF5, AB8500_DASLOTCONF5_DAI7TOADO5,
+			enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_ad6loop,
+			AB8500_DASLOTCONF6, AB8500_DASLOTCONF6_DAI8TOADO6,
+			enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_ad7loop,
+			AB8500_DASLOTCONF7, AB8500_DASLOTCONF7_DAI8TOADO7,
+			enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_ad8loop,
+			AB8500_DASLOTCONF8, AB8500_DASLOTCONF8_DAI7TOADO8,
+			enum_dis_ena);
+
+/* Digital interface - Burst mode */
+static SOC_ENUM_SINGLE_DECL(soc_enum_if0fifoen,
+			AB8500_DIGIFCONF3, AB8500_DIGIFCONF3_IF0BFIFOEN,
+			enum_dis_ena);
+static const char * const enum_mask[] = {"Unmasked", "Masked"};
+static SOC_ENUM_SINGLE_DECL(soc_enum_bfifomask,
+			AB8500_FIFOCONF1, AB8500_FIFOCONF1_BFIFOMASK,
+			enum_mask);
+static const char * const enum_bitclk0[] = {"19_2_MHz", "38_4_MHz"};
+static SOC_ENUM_SINGLE_DECL(soc_enum_bfifo19m2,
+			AB8500_FIFOCONF1, AB8500_FIFOCONF1_BFIFO19M2,
+			enum_bitclk0);
+static const char * const enum_slavemaster[] = {"Slave", "Master"};
+static SOC_ENUM_SINGLE_DECL(soc_enum_bfifomast,
+			AB8500_FIFOCONF3, AB8500_FIFOCONF3_BFIFOMAST_SHIFT,
+			enum_slavemaster);
+static SOC_ENUM_SINGLE_DECL(soc_enum_bfifoint,
+			AB8500_FIFOCONF3, AB8500_FIFOCONF3_BFIFORUN_SHIFT,
+			enum_dis_ena);
+
+/* Sidetone */
+static SOC_ENUM_SINGLE_EXT_DECL(soc_enum_sidstate, enum_sid_state);
+
+/* ANC */
+static SOC_ENUM_SINGLE_EXT_DECL(soc_enum_ancstate, enum_anc_state);
+
+static struct snd_kcontrol_new ab8500_ctrls[] = {
+	/* Charge pump */
+	SOC_ENUM("Charge Pump High Threshold For Low Voltage",
+		soc_enum_envdeththre),
+	SOC_ENUM("Charge Pump Low Threshold For Low Voltage",
+		soc_enum_envdetlthre),
+	SOC_ENUM("Charge Pump Envelope Detection", soc_enum_envdetcpen),
+	SOC_ENUM("Charge Pump Envelope Detection Decay Time",
+		soc_enum_envdettime),
+
+	/* Headset */
+	SOC_ENUM("Headset Mode", soc_enum_da12voice),
+	SOC_ENUM("Headset High Pass", soc_enum_hshpen),
+	SOC_ENUM("Headset Low Power", soc_enum_hslowpow),
+	SOC_ENUM("Headset DAC Low Power", soc_enum_daclowpow1),
+	SOC_ENUM("Headset DAC Drv Low Power",
+		soc_enum_daclowpow0),
+	SOC_ENUM("Headset Fade Speed", soc_enum_hsfadspeed),
+	SOC_ENUM("Headset Source", soc_enum_da2hslr),
+	SOC_ENUM("Headset Filter", soc_enum_hsesinc),
+	SOC_DOUBLE_R_TLV("Headset Master Gain",
+		AB8500_DADIGGAIN1, AB8500_DADIGGAIN2,
+		0, AB8500_DADIGGAINX_DAXGAIN_MAX, 1, dax_dig_gain_tlv),
+	SOC_DOUBLE_R_TLV("Headset Digital Gain",
+		AB8500_HSLEARDIGGAIN, AB8500_HSRDIGGAIN,
+		0, AB8500_HSLEARDIGGAIN_HSLDGAIN_MAX, 1, hs_ear_dig_gain_tlv),
+	SOC_DOUBLE_TLV("Headset Gain",
+		AB8500_ANAGAIN3,
+		AB8500_ANAGAIN3_HSLGAIN, AB8500_ANAGAIN3_HSRGAIN,
+		AB8500_ANAGAIN3_HSXGAIN_MAX, 1, hs_gain_tlv),
+
+	/* Earpiece */
+	SOC_ENUM("Earpiece DAC Mode",
+		soc_enum_eardaclowpow),
+	SOC_ENUM("Earpiece DAC Drv Mode",
+		soc_enum_eardrvlowpow),
+
+	/* HandsFree */
+	SOC_ENUM("HF Mode", soc_enum_da34voice),
+	SOC_ENUM("HF and Headset Swap", soc_enum_swapda12_34),
+	SOC_ENUM("HF Low EMI Mode", soc_enum_hflrswap),
+	SOC_ENUM("HF FIR Bypass", soc_enum_fir01byp),
+	SOC_ENUM("HF High Volume", soc_enum_highvol01),
+	SOC_ENUM("HF L and R Bridge", soc_enum_parlhf),
+	SOC_DOUBLE_R_TLV("HF Master Gain",
+		AB8500_DADIGGAIN3, AB8500_DADIGGAIN4,
+		0, AB8500_DADIGGAINX_DAXGAIN_MAX, 1, dax_dig_gain_tlv),
+
+	/* Vibra */
+	SOC_ENUM("Vibra High Volume", soc_enum_highvol23),
+	SOC_ENUM("Vibra Low EMI Mode", soc_enum_vib12swap),
+	SOC_ENUM("Vibra FIR Bypass", soc_enum_fir23byp),
+	SOC_ENUM("Vibra Mode", soc_enum_da56voice),
+	SOC_DOUBLE_R("Vibra PWM Duty Cycle N",
+		AB8500_PWMGENCONF3, AB8500_PWMGENCONF5,
+		AB8500_PWMGENCONFX_PWMVIBXDUTCYC,
+		AB8500_PWMGENCONFX_PWMVIBXDUTCYC_MAX, 0),
+	SOC_DOUBLE_R("Vibra PWM Duty Cycle P",
+		AB8500_PWMGENCONF2, AB8500_PWMGENCONF4,
+		AB8500_PWMGENCONFX_PWMVIBXDUTCYC,
+		AB8500_PWMGENCONFX_PWMVIBXDUTCYC_MAX, 0),
+	SOC_ENUM("Vibra 1 and 2 Bridge", soc_enum_parlvib),
+	SOC_DOUBLE_R_TLV("Vibra Master Gain",
+		AB8500_DADIGGAIN5, AB8500_DADIGGAIN6,
+		0, AB8500_DADIGGAINX_DAXGAIN_MAX, 1, dax_dig_gain_tlv),
+
+	/* HandsFree, Vibra */
+	SOC_SINGLE("ClassD High Pass Gain",
+		AB8500_CLASSDCONF3, AB8500_CLASSDCONF3_DITHHPGAIN,
+		AB8500_CLASSDCONF3_DITHHPGAIN_MAX, 0),
+	SOC_SINGLE("ClassD White Gain",
+		AB8500_CLASSDCONF3, AB8500_CLASSDCONF3_DITHWGAIN,
+		AB8500_CLASSDCONF3_DITHWGAIN_MAX, 0),
+
+	/* Mic 1, Mic 2, LineIn */
+	SOC_DOUBLE_R_TLV("Mic Master Gain",
+		AB8500_ADDIGGAIN3, AB8500_ADDIGGAIN4,
+		0, AB8500_ADDIGGAINX_ADXGAIN_MAX, 1, adx_dig_gain_tlv),
+
+	/* Mic 1 */
+	SOC_ENUM("Mic 1 Low Power", soc_enum_lowpowmic1),
+	SOC_ENUM("Mic 2 Low Power", soc_enum_lowpowmic2),
+	SOC_SINGLE_TLV("Mic 1",
+		AB8500_ANAGAIN1,
+		AB8500_ANAGAINX_MICXGAIN,
+		AB8500_ANAGAINX_MICXGAIN_MAX, 0, mic_gain_tlv),
+
+	/* Mic 2 */
+	SOC_ENUM("Mic High Pass", soc_enum_ad34nh),
+	SOC_ENUM("Mic Mode", soc_enum_ad34voice),
+	SOC_ENUM("Mic Filter", soc_enum_dmic34sinc),
+	SOC_SINGLE_TLV("Mic 2",
+		AB8500_ANAGAIN2,
+		AB8500_ANAGAINX_MICXGAIN,
+		AB8500_ANAGAINX_MICXGAIN_MAX, 0, mic_gain_tlv),
+
+	/* LineIn */
+	SOC_ENUM("LineIn High Pass", soc_enum_ad12nh),
+	SOC_ENUM("LineIn Filter", soc_enum_dmic12sinc),
+	SOC_ENUM("LineIn Mode", soc_enum_ad12voice),
+	SOC_DOUBLE_R_TLV("LineIn Master Gain",
+		AB8500_ADDIGGAIN1, AB8500_ADDIGGAIN2,
+		0, AB8500_ADDIGGAINX_ADXGAIN_MAX, 1, adx_dig_gain_tlv),
+	SOC_DOUBLE_TLV("LineIn",
+		AB8500_ANAGAIN4,
+		AB8500_ANAGAIN4_LINLGAIN, AB8500_ANAGAIN4_LINRGAIN,
+		AB8500_ANAGAIN4_LINXGAIN_MAX, 0, lin_gain_tlv),
+	SOC_DOUBLE_R_TLV("LineIn to Headset Bypass",
+		AB8500_DIGLINHSLGAIN, AB8500_DIGLINHSRGAIN,
+		AB8500_DIGLINHSXGAIN_LINTOHSXGAIN,
+		AB8500_DIGLINHSXGAIN_LINTOHSXGAIN_MAX, 1, lin2hs_gain_tlv),
+
+	/* DMic */
+	SOC_ENUM("DMic Filter", soc_enum_dmic56sinc),
+	SOC_DOUBLE_R_TLV("DMic Master Gain",
+		AB8500_ADDIGGAIN5, AB8500_ADDIGGAIN6,
+		0, AB8500_ADDIGGAINX_ADXGAIN_MAX, 1, adx_dig_gain_tlv),
+
+	/* Digital gains */
+	SOC_ENUM("Digital Gain Fade Speed Switch", soc_enum_fadespeed),
+
+	/* Analog loopback */
+	SOC_DOUBLE_R_TLV("Analog Loopback Gain",
+		AB8500_ADDIGLOOPGAIN1, AB8500_ADDIGLOOPGAIN2,
+		0, AB8500_ADDIGLOOPGAINX_ADXLBGAIN_MAX, 1, dax_dig_gain_tlv),
+
+	/* Digital interface - Clocks */
+	SOC_ENUM("Digital Interface Master Generator Switch", soc_enum_mastgen),
+	SOC_ENUM_EXT("Master Clock Select",
+		soc_enum_mclk,
+		mclk_input_control_get, mclk_input_control_put),
+	SOC_ENUM("Digital Interface 0 Bit-clock Switch", soc_enum_fsbitclk0),
+	SOC_ENUM("Digital Interface 1 Bit-clock Switch", soc_enum_fsbitclk1),
+
+	/* Digital interface - DA from slot mapping */
+	SOC_ENUM("Digital Interface DA 1 From Slot Map", soc_enum_da1slotmap),
+	SOC_ENUM("Digital Interface DA 2 From Slot Map", soc_enum_da2slotmap),
+	SOC_ENUM("Digital Interface DA 3 From Slot Map", soc_enum_da3slotmap),
+	SOC_ENUM("Digital Interface DA 4 From Slot Map", soc_enum_da4slotmap),
+	SOC_ENUM("Digital Interface DA 5 From Slot Map", soc_enum_da5slotmap),
+	SOC_ENUM("Digital Interface DA 6 From Slot Map", soc_enum_da6slotmap),
+	SOC_ENUM("Digital Interface DA 7 From Slot Map", soc_enum_da7slotmap),
+	SOC_ENUM("Digital Interface DA 8 From Slot Map", soc_enum_da8slotmap),
+
+	/* Digital interface - AD to slot mapping */
+	SOC_ENUM("Digital Interface AD To Slot 0 Map", soc_enum_adslot0map),
+	SOC_ENUM("Digital Interface AD To Slot 1 Map", soc_enum_adslot1map),
+	SOC_ENUM("Digital Interface AD To Slot 2 Map", soc_enum_adslot2map),
+	SOC_ENUM("Digital Interface AD To Slot 3 Map", soc_enum_adslot3map),
+	SOC_ENUM("Digital Interface AD To Slot 4 Map", soc_enum_adslot4map),
+	SOC_ENUM("Digital Interface AD To Slot 5 Map", soc_enum_adslot5map),
+	SOC_ENUM("Digital Interface AD To Slot 6 Map", soc_enum_adslot6map),
+	SOC_ENUM("Digital Interface AD To Slot 7 Map", soc_enum_adslot7map),
+	SOC_ENUM("Digital Interface AD To Slot 8 Map", soc_enum_adslot8map),
+	SOC_ENUM("Digital Interface AD To Slot 9 Map", soc_enum_adslot9map),
+	SOC_ENUM("Digital Interface AD To Slot 10 Map", soc_enum_adslot10map),
+	SOC_ENUM("Digital Interface AD To Slot 11 Map", soc_enum_adslot11map),
+	SOC_ENUM("Digital Interface AD To Slot 12 Map", soc_enum_adslot12map),
+	SOC_ENUM("Digital Interface AD To Slot 13 Map", soc_enum_adslot13map),
+	SOC_ENUM("Digital Interface AD To Slot 14 Map", soc_enum_adslot14map),
+	SOC_ENUM("Digital Interface AD To Slot 15 Map", soc_enum_adslot15map),
+	SOC_ENUM("Digital Interface AD To Slot 16 Map", soc_enum_adslot16map),
+	SOC_ENUM("Digital Interface AD To Slot 17 Map", soc_enum_adslot17map),
+	SOC_ENUM("Digital Interface AD To Slot 18 Map", soc_enum_adslot18map),
+	SOC_ENUM("Digital Interface AD To Slot 19 Map", soc_enum_adslot19map),
+	SOC_ENUM("Digital Interface AD To Slot 20 Map", soc_enum_adslot20map),
+	SOC_ENUM("Digital Interface AD To Slot 21 Map", soc_enum_adslot21map),
+	SOC_ENUM("Digital Interface AD To Slot 22 Map", soc_enum_adslot22map),
+	SOC_ENUM("Digital Interface AD To Slot 23 Map", soc_enum_adslot23map),
+	SOC_ENUM("Digital Interface AD To Slot 24 Map", soc_enum_adslot24map),
+	SOC_ENUM("Digital Interface AD To Slot 25 Map", soc_enum_adslot25map),
+	SOC_ENUM("Digital Interface AD To Slot 26 Map", soc_enum_adslot26map),
+	SOC_ENUM("Digital Interface AD To Slot 27 Map", soc_enum_adslot27map),
+	SOC_ENUM("Digital Interface AD To Slot 28 Map", soc_enum_adslot28map),
+	SOC_ENUM("Digital Interface AD To Slot 29 Map", soc_enum_adslot29map),
+	SOC_ENUM("Digital Interface AD To Slot 30 Map", soc_enum_adslot30map),
+	SOC_ENUM("Digital Interface AD To Slot 31 Map", soc_enum_adslot31map),
+
+	/* Digital interface - Loopback */
+	SOC_ENUM("Digital Interface AD 1 Loopback Switch", soc_enum_ad1loop),
+	SOC_ENUM("Digital Interface AD 2 Loopback Switch", soc_enum_ad2loop),
+	SOC_ENUM("Digital Interface AD 3 Loopback Switch", soc_enum_ad3loop),
+	SOC_ENUM("Digital Interface AD 4 Loopback Switch", soc_enum_ad4loop),
+	SOC_ENUM("Digital Interface AD 5 Loopback Switch", soc_enum_ad5loop),
+	SOC_ENUM("Digital Interface AD 6 Loopback Switch", soc_enum_ad6loop),
+	SOC_ENUM("Digital Interface AD 7 Loopback Switch", soc_enum_ad7loop),
+	SOC_ENUM("Digital Interface AD 8 Loopback Switch", soc_enum_ad8loop),
+
+	/* Digital interface - Burst FIFO */
+	SOC_ENUM("Digital Interface 0 FIFO Enable Switch", soc_enum_if0fifoen),
+	SOC_ENUM("Burst FIFO Mask", soc_enum_bfifomask),
+	SOC_ENUM("Burst FIFO Bit-clock Frequency", soc_enum_bfifo19m2),
+	SOC_SINGLE("Burst FIFO Threshold",
+		AB8500_FIFOCONF1,
+		AB8500_FIFOCONF1_BFIFOINT_SHIFT,
+		AB8500_FIFOCONF1_BFIFOINT_MAX,
+		0),
+	SOC_SINGLE("Burst FIFO Length",
+		AB8500_FIFOCONF2,
+		AB8500_FIFOCONF2_BFIFOTX_SHIFT,
+		AB8500_FIFOCONF2_BFIFOTX_MAX,
+		0),
+	SOC_SINGLE("Burst FIFO EOS Extra Slots",
+		AB8500_FIFOCONF3,
+		AB8500_FIFOCONF3_BFIFOEXSL_SHIFT,
+		AB8500_FIFOCONF3_BFIFOEXSL_MAX,
+		0),
+	SOC_SINGLE("Burst FIFO FS Extra Bit-clocks",
+		AB8500_FIFOCONF3,
+		AB8500_FIFOCONF3_PREBITCLK0_SHIFT,
+		AB8500_FIFOCONF3_PREBITCLK0_MAX,
+		0),
+	SOC_ENUM("Burst FIFO Interface Mode", soc_enum_bfifomast),
+	SOC_ENUM("Burst FIFO Interface Switch", soc_enum_bfifoint),
+	SOC_SINGLE("Burst FIFO Switch Frame Number",
+		AB8500_FIFOCONF4,
+		AB8500_FIFOCONF4_BFIFOFRAMSW_SHIFT,
+		AB8500_FIFOCONF4_BFIFOFRAMSW_MAX,
+		0),
+	SOC_SINGLE("Burst FIFO Wake Up Delay",
+		AB8500_FIFOCONF5,
+		AB8500_FIFOCONF5_BFIFOWAKEUP_SHIFT,
+		AB8500_FIFOCONF5_BFIFOWAKEUP_MAX,
+		0),
+	SOC_SINGLE("Burst FIFO Samples In FIFO",
+		AB8500_FIFOCONF6,
+		AB8500_FIFOCONF6_BFIFOSAMPLE_SHIFT,
+		AB8500_FIFOCONF6_BFIFOSAMPLE_MAX,
+		0),
+
+	/* ANC */
+	SOC_ENUM_EXT("ANC Status", soc_enum_ancstate,
+		anc_status_control_get, anc_status_control_put),
+	SOC_SINGLE_XR_SX("ANC Warp Delay Shift",
+		AB8500_ANCCONF2, 1, AB8500_ANCCONF2_SHIFT,
+		AB8500_ANCCONF2_MIN, AB8500_ANCCONF2_MAX, 0),
+	SOC_SINGLE_XR_SX("ANC FIR Output Shift",
+		AB8500_ANCCONF3, 1, AB8500_ANCCONF3_SHIFT,
+		AB8500_ANCCONF3_MIN, AB8500_ANCCONF3_MAX, 0),
+	SOC_SINGLE_XR_SX("ANC IIR Output Shift",
+		AB8500_ANCCONF4, 1, AB8500_ANCCONF4_SHIFT,
+		AB8500_ANCCONF4_MIN, AB8500_ANCCONF4_MAX, 0),
+	SOC_SINGLE_XR_SX("ANC Warp Delay",
+		AB8500_ANCCONF9, 2, AB8500_ANC_WARP_DELAY_SHIFT,
+		AB8500_ANC_WARP_DELAY_MIN, AB8500_ANC_WARP_DELAY_MAX, 0),
+
+	/* Sidetone */
+	SOC_ENUM_EXT("Sidetone Status", soc_enum_sidstate,
+		sid_status_control_get, sid_status_control_put),
+	SOC_SINGLE_STROBE("Sidetone Reset",
+		AB8500_SIDFIRADR, AB8500_SIDFIRADR_FIRSIDSET, 0),
+};
+
+static struct snd_kcontrol_new ab8500_filter_controls[] = {
+	AB8500_FILTER_CONTROL("ANC FIR Coefficients", AB8500_ANC_FIR_COEFFS,
+		AB8500_ANC_FIR_COEFF_MIN, AB8500_ANC_FIR_COEFF_MAX),
+	AB8500_FILTER_CONTROL("ANC IIR Coefficients", AB8500_ANC_IIR_COEFFS,
+		AB8500_ANC_IIR_COEFF_MIN, AB8500_ANC_IIR_COEFF_MAX),
+	AB8500_FILTER_CONTROL("Sidetone FIR Coefficients",
+			AB8500_SID_FIR_COEFFS, AB8500_SID_FIR_COEFF_MIN,
+			AB8500_SID_FIR_COEFF_MAX)
+};
+enum ab8500_filter {
+	AB8500_FILTER_ANC_FIR = 0,
+	AB8500_FILTER_ANC_IIR = 1,
+	AB8500_FILTER_SID_FIR = 2,
+};
+
+static int ab8500_codec_set_format_if1(struct snd_soc_codec *codec,
+				unsigned int fmt)
+{
+	unsigned int mask, val;
+
+	/* Master or slave */
+
+	mask = BIT(AB8500_DIGIFCONF3_IF1MASTER);
+	val = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM: /* codec clk & FRM master */
+		dev_dbg(codec->dev, "%s: IF1 Master-mode: AB8500 master.\n",
+			__func__);
+		val |= BIT(AB8500_DIGIFCONF3_IF1MASTER);
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS: /* codec clk & FRM slave */
+		dev_dbg(codec->dev, "%s: IF1 Master-mode: AB8500 slave.\n",
+			__func__);
+		break;
+	case SND_SOC_DAIFMT_CBS_CFM: /* codec clk slave & FRM master */
+	case SND_SOC_DAIFMT_CBM_CFS: /* codec clk master & frame slave */
+		dev_err(codec->dev,
+			"%s: ERROR: The device is either a master or a slave.\n",
+			__func__);
+	default:
+		dev_err(codec->dev,
+			"%s: ERROR: Unsupported master mask 0x%x\n",
+			__func__, fmt & SND_SOC_DAIFMT_MASTER_MASK);
+		return -EINVAL;
+	}
+
+	snd_soc_update_bits(codec, AB8500_DIGIFCONF3,
+			BIT(AB8500_DIGIFCONF3_IF1MASTER),
+			BIT(AB8500_DIGIFCONF3_IF1MASTER));
+
+	/* I2S or TDM */
+
+	mask = BIT(AB8500_DIGIFCONF4_FSYNC1P) |
+			BIT(AB8500_DIGIFCONF4_BITCLK1P) |
+			BIT(AB8500_DIGIFCONF4_IF1FORMAT1) |
+			BIT(AB8500_DIGIFCONF4_IF1FORMAT0);
+	val = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S: /* I2S mode */
+		dev_dbg(codec->dev, "%s: IF1 Protocol: I2S\n", __func__);
+		val |= BIT(AB8500_DIGIFCONF4_IF1FORMAT1);
+		break;
+	case SND_SOC_DAIFMT_DSP_B: /* L data MSB during FRM LRC */
+		dev_dbg(codec->dev, "%s: IF1 Protocol: DSP B (TDM)\n",
+			__func__);
+		val |= BIT(AB8500_DIGIFCONF4_IF1FORMAT0);
+		break;
+	default:
+		dev_err(codec->dev, "%s: ERROR: Unsupported format (0x%x)!\n",
+			__func__, fmt & SND_SOC_DAIFMT_FORMAT_MASK);
+		return -EINVAL;
+	}
+
+	snd_soc_update_bits(codec, AB8500_DIGIFCONF4, mask, val);
+
+	return 0;
+}
+
+static int ab8500_codec_set_word_length_if1(struct snd_soc_codec *codec,
+					unsigned int wl)
+{
+	unsigned int mask, val;
+
+	mask = BIT(AB8500_DIGIFCONF4_IF1WL1) |
+		BIT(AB8500_DIGIFCONF4_IF1WL0);
+	val = 0;
+
+	switch (wl) {
+	case 16:
+		break;
+	case 20:
+		val |= BIT(AB8500_DIGIFCONF4_IF1WL0);
+		break;
+	case 24:
+		val |= BIT(AB8500_DIGIFCONF4_IF1WL1);
+		break;
+	case 32:
+		val |= BIT(AB8500_DIGIFCONF2_IF0WL1) |
+			BIT(AB8500_DIGIFCONF2_IF0WL0);
+		break;
+	default:
+		dev_err(codec->dev, "%s: Unsupporter word-length 0x%x\n",
+			__func__, wl);
+		return -EINVAL;
+	}
+
+	dev_dbg(codec->dev, "%s: Word-length: %d bits.\n", __func__, wl);
+	snd_soc_update_bits(codec, AB8500_DIGIFCONF4, mask, val);
+
+	return 0;
+}
+
+static int ab8500_codec_set_bit_delay_if1(struct snd_soc_codec *codec,
+					unsigned int delay)
+{
+	unsigned int mask, val;
+
+	mask = BIT(AB8500_DIGIFCONF4_IF1DEL);
+	val = 0;
+
+	switch (delay) {
+	case 0:
+		break;
+	case 1:
+		val |= BIT(AB8500_DIGIFCONF4_IF1DEL);
+		break;
+	default:
+		dev_err(codec->dev,
+			"%s: ERROR: Unsupported bit-delay (0x%x)!\n",
+			__func__, delay);
+		return -EINVAL;
+	}
+
+	dev_dbg(codec->dev, "%s: IF1 Bit-delay: %d bits.\n", __func__, delay);
+	snd_soc_update_bits(codec, AB8500_DIGIFCONF4, mask, val);
+
+	return 0;
+}
+
+/*
+ * Extended interface for codec-driver
+ */
+
+int ab8500_audio_init_audioblock(struct snd_soc_codec *codec)
+{
+	int status;
+
+	dev_dbg(codec->dev, "%s: Enter.\n", __func__);
+
+	/* Reset audio-registers and disable 32kHz-clock output 2 */
+	status = ab8500_sysctrl_write(AB8500_STW4500CTRL3,
+				AB8500_STW4500CTRL3_CLK32KOUT2DIS |
+					AB8500_STW4500CTRL3_RESETAUDN,
+				AB8500_STW4500CTRL3_RESETAUDN);
+	if (status < 0)
+		return status;
+
+	return 0;
+}
+
+int ab8500_audio_setup_mics(struct snd_soc_codec *codec,
+			struct amic_settings *amics)
+{
+	u8 value8;
+	unsigned int value;
+	int status;
+	const struct snd_soc_dapm_route *route;
+
+	dev_dbg(codec->dev, "%s: Enter.\n", __func__);
+
+	/* Set DMic-clocks to outputs */
+	status = abx500_get_register_interruptible(codec->dev, (u8)AB8500_MISC,
+						(u8)AB8500_GPIO_DIR4_REG,
+						&value8);
+	if (status < 0)
+		return status;
+	value = value8 | GPIO27_DIR_OUTPUT | GPIO29_DIR_OUTPUT |
+		GPIO31_DIR_OUTPUT;
+	status = abx500_set_register_interruptible(codec->dev,
+						(u8)AB8500_MISC,
+						(u8)AB8500_GPIO_DIR4_REG,
+						value);
+	if (status < 0)
+		return status;
+
+	/* Attach regulators to AMic DAPM-paths */
+	dev_dbg(codec->dev, "%s: Mic 1a regulator: %s\n", __func__,
+		amic_micbias_str(amics->mic1a_micbias));
+	route = &ab8500_dapm_routes_mic1a_vamicx[amics->mic1a_micbias];
+	status = snd_soc_dapm_add_routes(&codec->dapm, route, 1);
+	dev_dbg(codec->dev, "%s: Mic 1b regulator: %s\n", __func__,
+		amic_micbias_str(amics->mic1b_micbias));
+	route = &ab8500_dapm_routes_mic1b_vamicx[amics->mic1b_micbias];
+	status |= snd_soc_dapm_add_routes(&codec->dapm, route, 1);
+	dev_dbg(codec->dev, "%s: Mic 2 regulator: %s\n", __func__,
+		amic_micbias_str(amics->mic2_micbias));
+	route = &ab8500_dapm_routes_mic2_vamicx[amics->mic2_micbias];
+	status |= snd_soc_dapm_add_routes(&codec->dapm, route, 1);
+	if (status < 0) {
+		dev_err(codec->dev,
+			"%s: Failed to add AMic-regulator DAPM-routes (%d).\n",
+			__func__, status);
+		return status;
+	}
+
+	/* Set AMic-configuration */
+	dev_dbg(codec->dev, "%s: Mic 1 mic-type: %s\n", __func__,
+		amic_type_str(amics->mic1_type));
+	snd_soc_update_bits(codec, AB8500_ANAGAIN1, AB8500_ANAGAINX_ENSEMICX,
+			amics->mic1_type == AMIC_TYPE_DIFFERENTIAL ?
+				0 : AB8500_ANAGAINX_ENSEMICX);
+	dev_dbg(codec->dev, "%s: Mic 2 mic-type: %s\n", __func__,
+		amic_type_str(amics->mic2_type));
+	snd_soc_update_bits(codec, AB8500_ANAGAIN2, AB8500_ANAGAINX_ENSEMICX,
+			amics->mic2_type == AMIC_TYPE_DIFFERENTIAL ?
+				0 : AB8500_ANAGAINX_ENSEMICX);
+
+	return 0;
+}
+
+int ab8500_audio_set_ear_cmv(struct snd_soc_codec *codec,
+			enum ear_cm_voltage ear_cmv)
+{
+	char *cmv_str;
+
+	switch (ear_cmv) {
+	case EAR_CMV_0_95V:
+		cmv_str = "0.95V";
+		break;
+	case EAR_CMV_1_10V:
+		cmv_str = "1.10V";
+		break;
+	case EAR_CMV_1_27V:
+		cmv_str = "1.27V";
+		break;
+	case EAR_CMV_1_58V:
+		cmv_str = "1.58V";
+		break;
+	default:
+		dev_err(codec->dev,
+			"%s: Unknown earpiece CM-voltage (%d)!\n",
+			__func__, (int)ear_cmv);
+		return -EINVAL;
+	}
+	dev_dbg(codec->dev, "%s: Earpiece CM-voltage: %s\n", __func__,
+		cmv_str);
+	snd_soc_update_bits(codec, AB8500_ANACONF1, AB8500_ANACONF1_EARSELCM,
+			ear_cmv);
+
+	return 0;
+}
+
+int ab8500_audio_setup_if1(struct snd_soc_codec *codec,
+			unsigned int fmt,
+			unsigned int wl,
+			unsigned int delay)
+{
+	int status;
+
+	dev_dbg(codec->dev, "%s: Enter.\n", __func__);
+
+	status = ab8500_codec_set_format_if1(codec, fmt);
+	if (status < 0)
+		return -1;
+
+	status = ab8500_codec_set_bit_delay_if1(codec, delay);
+	if (status < 0)
+		return -1;
+
+
+	status = ab8500_codec_set_word_length_if1(codec, wl);
+	if (status < 0)
+		return -1;
+
+	return 0;
+}
+
+static int ab8500_audio_set_bit_delay(struct snd_soc_dai *dai,
+				unsigned int delay)
+{
+	unsigned int mask, val;
+	struct snd_soc_codec *codec = dai->codec;
+
+	mask = BIT(AB8500_DIGIFCONF2_IF0DEL);
+	val = 0;
+
+	switch (delay) {
+	case 0:
+		break;
+	case 1:
+		val |= BIT(AB8500_DIGIFCONF2_IF0DEL);
+		break;
+	default:
+		dev_err(dai->codec->dev,
+			"%s: ERROR: Unsupported bit-delay (0x%x)!\n",
+			__func__, delay);
+		return -EINVAL;
+	}
+
+	dev_dbg(dai->codec->dev, "%s: IF0 Bit-delay: %d bits.\n",
+		__func__, delay);
+	snd_soc_update_bits(codec, AB8500_DIGIFCONF2, mask, val);
+
+	return 0;
+}
+
+static int ab8500_codec_pcm_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *hw_params, struct snd_soc_dai *dai)
+{
+	dev_dbg(dai->codec->dev, "%s Enter.\n", __func__);
+
+	return 0;
+}
+
+/* Gates clocking according format mask */
+static int ab8500_codec_set_dai_clock_gate(struct snd_soc_codec *codec,
+					unsigned int fmt)
+{
+	unsigned int mask;
+	unsigned int val;
+
+	mask = BIT(AB8500_DIGIFCONF1_ENMASTGEN) |
+			BIT(AB8500_DIGIFCONF1_ENFSBITCLK0);
+
+	val = BIT(AB8500_DIGIFCONF1_ENMASTGEN);
+
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_MASK) {
+	case SND_SOC_DAIFMT_CONT: /* continuous clock */
+		dev_dbg(codec->dev, "%s: IF0 Clock is continuous.\n",
+			__func__);
+		val |= BIT(AB8500_DIGIFCONF1_ENFSBITCLK0);
+		break;
+	case SND_SOC_DAIFMT_GATED: /* clock is gated */
+		dev_dbg(codec->dev, "%s: IF0 Clock is gated.\n",
+			__func__);
+		break;
+	default:
+		dev_err(codec->dev,
+			"%s: ERROR: Unsupported clock mask (0x%x)!\n",
+			__func__, fmt & SND_SOC_DAIFMT_CLOCK_MASK);
+		return -EINVAL;
+	}
+
+	snd_soc_update_bits(codec, AB8500_DIGIFCONF1, mask, val);
+
+	return 0;
+}
+
+static int ab8500_codec_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	unsigned int mask;
+	unsigned int val;
+	struct snd_soc_codec *codec = dai->codec;
+	int status;
+
+	dev_dbg(codec->dev, "%s: Enter (fmt = 0x%x)\n", __func__, fmt);
+
+	mask = BIT(AB8500_DIGIFCONF3_IF1DATOIF0AD) |
+			BIT(AB8500_DIGIFCONF3_IF1CLKTOIF0CLK) |
+			BIT(AB8500_DIGIFCONF3_IF0BFIFOEN) |
+			BIT(AB8500_DIGIFCONF3_IF0MASTER);
+	val = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM: /* codec clk & FRM master */
+		dev_dbg(dai->codec->dev,
+			"%s: IF0 Master-mode: AB8500 master.\n", __func__);
+		val |= BIT(AB8500_DIGIFCONF3_IF0MASTER);
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS: /* codec clk & FRM slave */
+		dev_dbg(dai->codec->dev,
+			"%s: IF0 Master-mode: AB8500 slave.\n", __func__);
+		break;
+	case SND_SOC_DAIFMT_CBS_CFM: /* codec clk slave & FRM master */
+	case SND_SOC_DAIFMT_CBM_CFS: /* codec clk master & frame slave */
+		dev_err(dai->codec->dev,
+			"%s: ERROR: The device is either a master or a slave.\n",
+			__func__);
+	default:
+		dev_err(dai->codec->dev,
+			"%s: ERROR: Unsupporter master mask 0x%x\n",
+			__func__, fmt & SND_SOC_DAIFMT_MASTER_MASK);
+		return -EINVAL;
+		break;
+	}
+
+	snd_soc_update_bits(codec, AB8500_DIGIFCONF3, mask, val);
+
+	/* Set clock gating */
+	status = ab8500_codec_set_dai_clock_gate(codec, fmt);
+	if (status) {
+		dev_err(dai->codec->dev,
+			"%s: ERRROR: Failed to set clock gate (%d).\n",
+			__func__, status);
+		return status;
+	}
+
+	/* Setting data transfer format */
+
+	mask = BIT(AB8500_DIGIFCONF2_IF0FORMAT0) |
+		BIT(AB8500_DIGIFCONF2_IF0FORMAT1) |
+		BIT(AB8500_DIGIFCONF2_FSYNC0P) |
+		BIT(AB8500_DIGIFCONF2_BITCLK0P);
+	val = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S: /* I2S mode */
+		dev_dbg(dai->codec->dev, "%s: IF0 Protocol: I2S\n", __func__);
+		val |= BIT(AB8500_DIGIFCONF2_IF0FORMAT1);
+		ab8500_audio_set_bit_delay(dai, 0);
+		break;
+
+	case SND_SOC_DAIFMT_DSP_A: /* L data MSB after FRM LRC */
+		dev_dbg(dai->codec->dev,
+			"%s: IF0 Protocol: DSP A (TDM)\n", __func__);
+		val |= BIT(AB8500_DIGIFCONF2_IF0FORMAT0);
+		ab8500_audio_set_bit_delay(dai, 1);
+		break;
+
+	case SND_SOC_DAIFMT_DSP_B: /* L data MSB during FRM LRC */
+		dev_dbg(dai->codec->dev,
+			"%s: IF0 Protocol: DSP B (TDM)\n", __func__);
+		val |= BIT(AB8500_DIGIFCONF2_IF0FORMAT0);
+		ab8500_audio_set_bit_delay(dai, 0);
+		break;
+
+	default:
+		dev_err(dai->codec->dev,
+			"%s: ERROR: Unsupported format (0x%x)!\n",
+			__func__, fmt & SND_SOC_DAIFMT_FORMAT_MASK);
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF: /* normal bit clock + frame */
+		dev_dbg(dai->codec->dev,
+			"%s: IF0: Normal bit clock, normal frame\n",
+			__func__);
+		break;
+	case SND_SOC_DAIFMT_NB_IF: /* normal BCLK + inv FRM */
+		dev_dbg(dai->codec->dev,
+			"%s: IF0: Normal bit clock, inverted frame\n",
+			__func__);
+		val |= BIT(AB8500_DIGIFCONF2_FSYNC0P);
+		break;
+	case SND_SOC_DAIFMT_IB_NF: /* invert BCLK + nor FRM */
+		dev_dbg(dai->codec->dev,
+			"%s: IF0: Inverted bit clock, normal frame\n",
+			__func__);
+		val |= BIT(AB8500_DIGIFCONF2_BITCLK0P);
+		break;
+	case SND_SOC_DAIFMT_IB_IF: /* invert BCLK + FRM */
+		dev_dbg(dai->codec->dev,
+			"%s: IF0: Inverted bit clock, inverted frame\n",
+			__func__);
+		val |= BIT(AB8500_DIGIFCONF2_FSYNC0P);
+		val |= BIT(AB8500_DIGIFCONF2_BITCLK0P);
+		break;
+	default:
+		dev_err(dai->codec->dev,
+			"%s: ERROR: Unsupported INV mask 0x%x\n",
+			__func__, fmt & SND_SOC_DAIFMT_INV_MASK);
+		return -EINVAL;
+		break;
+	}
+
+	snd_soc_update_bits(codec, AB8500_DIGIFCONF2, mask, val);
+
+	return 0;
+}
+
+static int ab8500_codec_set_dai_tdm_slot(struct snd_soc_dai *dai,
+		unsigned int tx_mask, unsigned int rx_mask,
+		int slots, int slot_width)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	unsigned int val, mask, slots_active;
+
+	/* Only 16 bit slot width is supported at the moment in TDM mode */
+	if (slot_width != 16) {
+		dev_err(dai->codec->dev,
+			"%s: ERROR: Unsupported slot_width %d.\n",
+			__func__, slot_width);
+		return -EINVAL;
+	}
+
+	mask = BIT(AB8500_DIGIFCONF2_IF0WL0) |
+		BIT(AB8500_DIGIFCONF2_IF0WL1);
+	val = 0;
+
+	switch (slot_width) {
+	case 16:
+		break;
+	case 20:
+		val |= BIT(AB8500_DIGIFCONF2_IF0WL0);
+		break;
+	case 24:
+		val |= BIT(AB8500_DIGIFCONF2_IF0WL1);
+		break;
+	case 32:
+		val |= BIT(AB8500_DIGIFCONF2_IF0WL1) |
+			BIT(AB8500_DIGIFCONF2_IF0WL0);
+		break;
+	default:
+		dev_err(dai->codec->dev, "%s: Unsupported slot-width 0x%x\n",
+			__func__, slot_width);
+		return -EINVAL;
+	}
+
+	dev_dbg(dai->codec->dev, "%s: IF0 slot-width: %d bits.\n",
+		__func__, slot_width);
+	snd_soc_update_bits(codec, AB8500_DIGIFCONF2, mask, val);
+
+	/* Setup TDM clocking according to slot count */
+	dev_dbg(dai->codec->dev, "%s: Slots, total: %d\n", __func__, slots);
+	mask = BIT(AB8500_DIGIFCONF1_IF0BITCLKOS0) |
+			BIT(AB8500_DIGIFCONF1_IF0BITCLKOS1);
+	switch (slots) {
+	case 2:
+		val = AB8500_MASK_NONE;
+		break;
+	case 4:
+		val = BIT(AB8500_DIGIFCONF1_IF0BITCLKOS0);
+		break;
+	case 8:
+		val = BIT(AB8500_DIGIFCONF1_IF0BITCLKOS1);
+		break;
+	case 16:
+		val = BIT(AB8500_DIGIFCONF1_IF0BITCLKOS0) |
+			BIT(AB8500_DIGIFCONF1_IF0BITCLKOS1);
+		break;
+	default:
+		dev_err(dai->codec->dev,
+			"%s: ERROR: Unsupported number of slots (%d)!\n",
+			__func__, slots);
+		return -EINVAL;
+	}
+	snd_soc_update_bits(codec, AB8500_DIGIFCONF1, mask, val);
+
+	/* Setup TDM DA according to active tx slots */
+	mask = AB8500_DASLOTCONFX_SLTODAX_MASK;
+	slots_active = hweight32(tx_mask);
+	dev_dbg(dai->codec->dev, "%s: Slots, active, TX: %d\n", __func__,
+		slots_active);
+	switch (slots_active) {
+	case 0:
+		break;
+	case 1:
+		/* Slot 9 -> DA_IN1 & DA_IN3 */
+		snd_soc_update_bits(codec, AB8500_DASLOTCONF1, mask, 11);
+		snd_soc_update_bits(codec, AB8500_DASLOTCONF3, mask, 11);
+		snd_soc_update_bits(codec, AB8500_DASLOTCONF2, mask, 11);
+		snd_soc_update_bits(codec, AB8500_DASLOTCONF4, mask, 11);
+		break;
+	case 2:
+		/* Slot 9 -> DA_IN1 & DA_IN3, Slot 11 -> DA_IN2 & DA_IN4 */
+		snd_soc_update_bits(codec, AB8500_DASLOTCONF1, mask, 9);
+		snd_soc_update_bits(codec, AB8500_DASLOTCONF3, mask, 9);
+		snd_soc_update_bits(codec, AB8500_DASLOTCONF2, mask, 11);
+		snd_soc_update_bits(codec, AB8500_DASLOTCONF4, mask, 11);
+
+		break;
+	case 8:
+		dev_dbg(dai->codec->dev,
+			"%s: In 8-channel mode DA-from-slot mapping is set manually.",
+			__func__);
+		break;
+	default:
+		dev_err(dai->codec->dev,
+			"%s: Unsupported number of active TX-slots (%d)!\n",
+			__func__, slots_active);
+		return -EINVAL;
+	}
+
+	/* Setup TDM AD according to active RX-slots */
+	slots_active = hweight32(rx_mask);
+	dev_dbg(dai->codec->dev, "%s: Slots, active, RX: %d\n", __func__,
+		slots_active);
+	switch (slots_active) {
+	case 0:
+		break;
+	case 1:
+		/* AD_OUT3 -> slot 0 & 1 */
+		snd_soc_update_bits(codec, AB8500_ADSLOTSEL1, AB8500_MASK_ALL,
+				AB8500_ADSLOTSELX_AD_OUT3_TO_SLOT_EVEN |
+				AB8500_ADSLOTSELX_AD_OUT3_TO_SLOT_ODD);
+		break;
+	case 2:
+		/* AD_OUT3 -> slot 0, AD_OUT2 -> slot 1 */
+		snd_soc_update_bits(codec,
+				AB8500_ADSLOTSEL1,
+				AB8500_MASK_ALL,
+				AB8500_ADSLOTSELX_AD_OUT3_TO_SLOT_EVEN |
+				AB8500_ADSLOTSELX_AD_OUT2_TO_SLOT_ODD);
+		break;
+	case 8:
+		dev_dbg(dai->codec->dev,
+			"%s: In 8-channel mode AD-to-slot mapping is set manually.",
+			__func__);
+		break;
+	default:
+		dev_err(dai->codec->dev,
+			"%s: Unsupported number of active RX-slots (%d)!\n",
+			__func__, slots_active);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+struct snd_soc_dai_driver ab8500_codec_dai[] = {
+	{
+		.name = "ab8500-codec-dai.0",
+		.id = 0,
+		.playback = {
+			.stream_name = "ab8500_0p",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = AB8500_SUPPORTED_RATE,
+			.formats = AB8500_SUPPORTED_FMT,
+		},
+		.ops = (struct snd_soc_dai_ops[]) {
+			{
+				.hw_params = ab8500_codec_pcm_hw_params,
+				.set_tdm_slot = ab8500_codec_set_dai_tdm_slot,
+				.set_fmt = ab8500_codec_set_dai_fmt,
+			}
+		},
+		.symmetric_rates = 1
+	},
+	{
+		.name = "ab8500-codec-dai.1",
+		.id = 1,
+		.capture = {
+			.stream_name = "ab8500_0c",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = AB8500_SUPPORTED_RATE,
+			.formats = AB8500_SUPPORTED_FMT,
+		},
+		.ops = (struct snd_soc_dai_ops[]) {
+			{
+				.hw_params = ab8500_codec_pcm_hw_params,
+				.set_tdm_slot = ab8500_codec_set_dai_tdm_slot,
+				.set_fmt = ab8500_codec_set_dai_fmt,
+			}
+		},
+		.symmetric_rates = 1
+	}
+};
+
+static int ab8500_codec_probe(struct snd_soc_codec *codec)
+{
+	struct device *dev = codec->dev;
+	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(dev);
+	struct filter_control *fc;
+	int status;
+
+	dev_dbg(dev, "%s: Enter.\n", __func__);
+
+	status = ab8500_audio_init_audioblock(codec);
+	if (status < 0) {
+		dev_err(dev, "%s: failed to init audio-block (%d)!\n",
+			__func__, status);
+		return status;
+	}
+
+	/* Override HW-defaults */
+	ab8500_codec_write_reg(codec,
+				AB8500_ANACONF5,
+				BIT(AB8500_ANACONF5_HSAUTOEN));
+	ab8500_codec_write_reg(codec,
+				AB8500_SHORTCIRCONF,
+				BIT(AB8500_SHORTCIRCONF_HSZCDDIS));
+
+	/* Add filter controls */
+	status = snd_soc_add_codec_controls(codec, ab8500_filter_controls,
+				ARRAY_SIZE(ab8500_filter_controls));
+	if (status < 0) {
+		dev_err(dev,
+			"%s: failed to add ab8500 filter controls (%d).\n",
+			__func__, status);
+		return status;
+	}
+	fc = (struct filter_control *)
+		&ab8500_filter_controls[AB8500_FILTER_ANC_FIR].private_value;
+	drvdata->anc_fir_values = (long *)fc->value;
+	fc = (struct filter_control *)
+		&ab8500_filter_controls[AB8500_FILTER_ANC_IIR].private_value;
+	drvdata->anc_iir_values = (long *)fc->value;
+	fc = (struct filter_control *)
+		&ab8500_filter_controls[AB8500_FILTER_SID_FIR].private_value;
+	drvdata->sid_fir_values = (long *)fc->value;
+
+	(void)snd_soc_dapm_disable_pin(&codec->dapm, "ANC Configure Input");
+
+	if (IS_ERR(drvdata->clk_ptr_sysclk)) {
+		dev_err(dev,
+			"%s: ERROR: Clocks needed for streaming not available!",
+			__func__);
+		return PTR_ERR(drvdata->clk_ptr_sysclk);
+	}
+
+	/* Get references to clock-nodes */
+	drvdata->clk_ptr_sysclk = NULL;
+	drvdata->clk_ptr_ulpclk = NULL;
+	drvdata->clk_ptr_intclk = NULL;
+	drvdata->clk_ptr_sysclk = clk_get(dev, "sysclk");
+	if (IS_ERR(drvdata->clk_ptr_sysclk))
+		dev_warn(dev, "WARNING: clk_get failed for 'sysclk'!\n");
+	drvdata->clk_ptr_ulpclk = clk_get(dev, "ulpclk");
+	if (IS_ERR(drvdata->clk_ptr_ulpclk))
+		dev_warn(dev, "WARNING: clk_get failed for 'ulpclk'!\n");
+	drvdata->clk_ptr_intclk = clk_get(dev, "intclk");
+	if (IS_ERR(drvdata->clk_ptr_intclk))
+		dev_warn(dev, "WARNING: clk_get failed for 'intclk'!\n");
+
+	/* Set intclk default parent to ulpclk */
+	status = clk_set_parent(drvdata->clk_ptr_intclk,
+				drvdata->clk_ptr_ulpclk);
+	if (status)
+		dev_warn(dev,
+			"%s: WARNING: Setting intclk parent to ulpclk failed (ret = %d)!",
+			__func__, status);
+
+	drvdata->mclk_sel = MCLK_ULPCLK;
+
+	return status;
+}
+
+static struct snd_soc_codec_driver ab8500_codec_driver = {
+	.probe =		ab8500_codec_probe,
+	.read =			ab8500_codec_read_reg,
+	.write =		ab8500_codec_write_reg,
+	.reg_cache_size =	0,
+	.reg_word_size =	sizeof(u8),
+	.controls =		ab8500_ctrls,
+	.num_controls =		ARRAY_SIZE(ab8500_ctrls),
+	.dapm_widgets =		ab8500_dapm_widgets,
+	.num_dapm_widgets =	ARRAY_SIZE(ab8500_dapm_widgets),
+	.dapm_routes =		ab8500_dapm_routes,
+	.num_dapm_routes =	ARRAY_SIZE(ab8500_dapm_routes),
+};
+
+static int __devinit ab8500_codec_driver_probe(struct platform_device *pdev)
+{
+	int status;
+	struct ab8500_codec_drvdata *drvdata;
+
+	dev_dbg(&pdev->dev, "%s: Enter.\n", __func__);
+
+	/* Create driver private-data struct */
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct ab8500_codec_drvdata),
+			GFP_KERNEL);
+	drvdata->sid_status = SID_UNCONFIGURED;
+	drvdata->anc_status = ANC_UNCONFIGURED;
+	dev_set_drvdata(&pdev->dev, drvdata);
+
+	dev_dbg(&pdev->dev, "%s: Register codec.\n", __func__);
+	status = snd_soc_register_codec(&pdev->dev, &ab8500_codec_driver,
+				ab8500_codec_dai,
+				ARRAY_SIZE(ab8500_codec_dai));
+
+	if (status < 0)
+		dev_err(&pdev->dev,
+			"%s: Error: Failed to register codec (%d).\n",
+			__func__, status);
+
+	return status;
+}
+
+static int __devexit ab8500_codec_driver_remove(struct platform_device *pdev)
+{
+	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
+
+	dev_info(&pdev->dev, "%s Enter.\n", __func__);
+
+	snd_soc_unregister_codec(&pdev->dev);
+
+	if (drvdata->clk_ptr_sysclk != NULL)
+		clk_put(drvdata->clk_ptr_sysclk);
+	if (drvdata->clk_ptr_ulpclk != NULL)
+		clk_put(drvdata->clk_ptr_ulpclk);
+	if (drvdata->clk_ptr_intclk != NULL)
+		clk_put(drvdata->clk_ptr_intclk);
+
+	return 0;
+}
+
+static struct platform_driver ab8500_codec_platform_driver = {
+	.driver	= {
+		.name	= "ab8500-codec",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ab8500_codec_driver_probe,
+	.remove		= __devexit_p(ab8500_codec_driver_remove),
+	.suspend	= NULL,
+	.resume		= NULL,
+};
+module_platform_driver(ab8500_codec_platform_driver);
+
+MODULE_LICENSE("GPLv2");
+
diff --git a/sound/soc/codecs/ab8500-codec.h b/sound/soc/codecs/ab8500-codec.h
new file mode 100644
index 0000000..50282b3
--- /dev/null
+++ b/sound/soc/codecs/ab8500-codec.h
@@ -0,0 +1,608 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2012
+ *
+ * Author: Ola Lilja <ola.o.lilja@stericsson.com>,
+ *         Kristoffer Karlsson <kristoffer.karlsson@stericsson.com>,
+ *         Roger Nilsson <roger.xr.nilsson@stericsson.com>,
+ *         for ST-Ericsson.
+ *
+ *         Based on the early work done by:
+ *         Mikko J. Lehto <mikko.lehto@symbio.com>,
+ *         Mikko Sarmanne <mikko.sarmanne@symbio.com>,
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#ifndef AB8500_CODEC_REGISTERS_H
+#define AB8500_CODEC_REGISTERS_H
+
+#include <mach/board-mop500-audio.h>
+
+extern struct snd_soc_dai_driver ab8500_codec_dai[];
+extern struct snd_soc_codec_driver soc_codec_dev_ab8500;
+
+/* Extended interface for codec-driver */
+
+int ab8500_audio_setup_if1(struct snd_soc_codec *codec, unsigned int fmt,
+			unsigned int wl, unsigned int delay);
+int ab8500_audio_setup_macrocell(struct snd_soc_codec *codec);
+int ab8500_audio_setup_mics(struct snd_soc_codec *codec,
+			struct amic_settings *amics);
+int ab8500_audio_set_ear_cmv(struct snd_soc_codec *codec,
+			enum ear_cm_voltage ear_cmv);
+
+#define AB8500_SUPPORTED_RATE			(SNDRV_PCM_RATE_48000)
+#define AB8500_SUPPORTED_FMT			(SNDRV_PCM_FMTBIT_S16_LE)
+
+#define PRE_PMU_POST_PMD			(SND_SOC_DAPM_PRE_PMU | \
+						SND_SOC_DAPM_POST_PMD)
+
+/* AB8500 audio bank (0x0d) register definitions */
+
+#define AB8500_POWERUP				0x00
+#define AB8500_AUDSWRESET			0x01
+#define AB8500_ADPATHENA			0x02
+#define AB8500_DAPATHENA			0x03
+#define AB8500_ANACONF1				0x04
+#define AB8500_ANACONF2				0x05
+#define AB8500_DIGMICCONF			0x06
+#define AB8500_ANACONF3				0x07
+#define AB8500_ANACONF4				0x08
+#define AB8500_DAPATHCONF			0x09
+#define AB8500_MUTECONF				0x0A
+#define AB8500_SHORTCIRCONF			0x0B
+#define AB8500_ANACONF5				0x0C
+#define AB8500_ENVCPCONF			0x0D
+#define AB8500_SIGENVCONF			0x0E
+#define AB8500_PWMGENCONF1			0x0F
+#define AB8500_PWMGENCONF2			0x10
+#define AB8500_PWMGENCONF3			0x11
+#define AB8500_PWMGENCONF4			0x12
+#define AB8500_PWMGENCONF5			0x13
+#define AB8500_ANAGAIN1				0x14
+#define AB8500_ANAGAIN2				0x15
+#define AB8500_ANAGAIN3				0x16
+#define AB8500_ANAGAIN4				0x17
+#define AB8500_DIGLINHSLGAIN			0x18
+#define AB8500_DIGLINHSRGAIN			0x19
+#define AB8500_ADFILTCONF			0x1A
+#define AB8500_DIGIFCONF1			0x1B
+#define AB8500_DIGIFCONF2			0x1C
+#define AB8500_DIGIFCONF3			0x1D
+#define AB8500_DIGIFCONF4			0x1E
+#define AB8500_ADSLOTSEL1			0x1F
+#define AB8500_ADSLOTSEL2			0x20
+#define AB8500_ADSLOTSEL3			0x21
+#define AB8500_ADSLOTSEL4			0x22
+#define AB8500_ADSLOTSEL5			0x23
+#define AB8500_ADSLOTSEL6			0x24
+#define AB8500_ADSLOTSEL7			0x25
+#define AB8500_ADSLOTSEL8			0x26
+#define AB8500_ADSLOTSEL9			0x27
+#define AB8500_ADSLOTSEL10			0x28
+#define AB8500_ADSLOTSEL11			0x29
+#define AB8500_ADSLOTSEL12			0x2A
+#define AB8500_ADSLOTSEL13			0x2B
+#define AB8500_ADSLOTSEL14			0x2C
+#define AB8500_ADSLOTSEL15			0x2D
+#define AB8500_ADSLOTSEL16			0x2E
+#define AB8500_ADSLOTHIZCTRL1			0x2F
+#define AB8500_ADSLOTHIZCTRL2			0x30
+#define AB8500_ADSLOTHIZCTRL3			0x31
+#define AB8500_ADSLOTHIZCTRL4			0x32
+#define AB8500_DASLOTCONF1			0x33
+#define AB8500_DASLOTCONF2			0x34
+#define AB8500_DASLOTCONF3			0x35
+#define AB8500_DASLOTCONF4			0x36
+#define AB8500_DASLOTCONF5			0x37
+#define AB8500_DASLOTCONF6			0x38
+#define AB8500_DASLOTCONF7			0x39
+#define AB8500_DASLOTCONF8			0x3A
+#define AB8500_CLASSDCONF1			0x3B
+#define AB8500_CLASSDCONF2			0x3C
+#define AB8500_CLASSDCONF3			0x3D
+#define AB8500_DMICFILTCONF			0x3E
+#define AB8500_DIGMULTCONF1			0x3F
+#define AB8500_DIGMULTCONF2			0x40
+#define AB8500_ADDIGGAIN1			0x41
+#define AB8500_ADDIGGAIN2			0x42
+#define AB8500_ADDIGGAIN3			0x43
+#define AB8500_ADDIGGAIN4			0x44
+#define AB8500_ADDIGGAIN5			0x45
+#define AB8500_ADDIGGAIN6			0x46
+#define AB8500_DADIGGAIN1			0x47
+#define AB8500_DADIGGAIN2			0x48
+#define AB8500_DADIGGAIN3			0x49
+#define AB8500_DADIGGAIN4			0x4A
+#define AB8500_DADIGGAIN5			0x4B
+#define AB8500_DADIGGAIN6			0x4C
+#define AB8500_ADDIGLOOPGAIN1			0x4D
+#define AB8500_ADDIGLOOPGAIN2			0x4E
+#define AB8500_HSLEARDIGGAIN			0x4F
+#define AB8500_HSRDIGGAIN			0x50
+#define AB8500_SIDFIRGAIN1			0x51
+#define AB8500_SIDFIRGAIN2			0x52
+#define AB8500_ANCCONF1				0x53
+#define AB8500_ANCCONF2				0x54
+#define AB8500_ANCCONF3				0x55
+#define AB8500_ANCCONF4				0x56
+#define AB8500_ANCCONF5				0x57
+#define AB8500_ANCCONF6				0x58
+#define AB8500_ANCCONF7				0x59
+#define AB8500_ANCCONF8				0x5A
+#define AB8500_ANCCONF9				0x5B
+#define AB8500_ANCCONF10			0x5C
+#define AB8500_ANCCONF11			0x5D
+#define AB8500_ANCCONF12			0x5E
+#define AB8500_ANCCONF13			0x5F
+#define AB8500_ANCCONF14			0x60
+#define AB8500_SIDFIRADR			0x61
+#define AB8500_SIDFIRCOEF1			0x62
+#define AB8500_SIDFIRCOEF2			0x63
+#define AB8500_SIDFIRCONF			0x64
+#define AB8500_AUDINTMASK1			0x65
+#define AB8500_AUDINTSOURCE1			0x66
+#define AB8500_AUDINTMASK2			0x67
+#define AB8500_AUDINTSOURCE2			0x68
+#define AB8500_FIFOCONF1			0x69
+#define AB8500_FIFOCONF2			0x6A
+#define AB8500_FIFOCONF3			0x6B
+#define AB8500_FIFOCONF4			0x6C
+#define AB8500_FIFOCONF5			0x6D
+#define AB8500_FIFOCONF6			0x6E
+#define AB8500_AUDREV				0x6F
+
+#define AB8500_FIRST_REG			AB8500_POWERUP
+#define AB8500_LAST_REG				AB8500_AUDREV
+#define AB8500_CACHEREGNUM			(AB8500_LAST_REG + 1)
+
+#define AB8500_MASK_ALL				0xFF
+#define AB8500_MASK_NONE			0x00
+
+/* AB8500_POWERUP */
+#define AB8500_POWERUP_POWERUP			7
+#define AB8500_POWERUP_ENANA			3
+
+/* AB8500_AUDSWRESET */
+#define AB8500_AUDSWRESET_SWRESET		7
+
+/* AB8500_ADPATHENA */
+#define AB8500_ADPATHENA_ENAD12			7
+#define AB8500_ADPATHENA_ENAD34			5
+#define AB8500_ADPATHENA_ENAD5768		3
+
+/* AB8500_DAPATHENA */
+#define AB8500_DAPATHENA_ENDA1			7
+#define AB8500_DAPATHENA_ENDA2			6
+#define AB8500_DAPATHENA_ENDA3			5
+#define AB8500_DAPATHENA_ENDA4			4
+#define AB8500_DAPATHENA_ENDA5			3
+#define AB8500_DAPATHENA_ENDA6			2
+
+/* AB8500_ANACONF1 */
+#define AB8500_ANACONF1_HSLOWPOW		7
+#define AB8500_ANACONF1_DACLOWPOW1		6
+#define AB8500_ANACONF1_DACLOWPOW0		5
+#define AB8500_ANACONF1_EARDACLOWPOW		4
+#define AB8500_ANACONF1_EARSELCM		2
+#define AB8500_ANACONF1_HSHPEN			1
+#define AB8500_ANACONF1_EARDRVLOWPOW		0
+
+/* AB8500_ANACONF2 */
+#define AB8500_ANACONF2_ENMIC1			7
+#define AB8500_ANACONF2_ENMIC2			6
+#define AB8500_ANACONF2_ENLINL			5
+#define AB8500_ANACONF2_ENLINR			4
+#define AB8500_ANACONF2_MUTMIC1			3
+#define AB8500_ANACONF2_MUTMIC2			2
+#define AB8500_ANACONF2_MUTLINL			1
+#define AB8500_ANACONF2_MUTLINR			0
+
+/* AB8500_DIGMICCONF */
+#define AB8500_DIGMICCONF_ENDMIC1		7
+#define AB8500_DIGMICCONF_ENDMIC2		6
+#define AB8500_DIGMICCONF_ENDMIC3		5
+#define AB8500_DIGMICCONF_ENDMIC4		4
+#define AB8500_DIGMICCONF_ENDMIC5		3
+#define AB8500_DIGMICCONF_ENDMIC6		2
+#define AB8500_DIGMICCONF_HSFADSPEED		0
+
+/* AB8500_ANACONF3 */
+#define AB8500_ANACONF3_MIC1SEL			7
+#define AB8500_ANACONF3_LINRSEL			6
+#define AB8500_ANACONF3_ENDRVHSL		5
+#define AB8500_ANACONF3_ENDRVHSR		4
+#define AB8500_ANACONF3_ENADCMIC		2
+#define AB8500_ANACONF3_ENADCLINL		1
+#define AB8500_ANACONF3_ENADCLINR		0
+
+/* AB8500_ANACONF4 */
+#define AB8500_ANACONF4_DISPDVSS		7
+#define AB8500_ANACONF4_ENEAR			6
+#define AB8500_ANACONF4_ENHSL			5
+#define AB8500_ANACONF4_ENHSR			4
+#define AB8500_ANACONF4_ENHFL			3
+#define AB8500_ANACONF4_ENHFR			2
+#define AB8500_ANACONF4_ENVIB1			1
+#define AB8500_ANACONF4_ENVIB2			0
+
+/* AB8500_DAPATHCONF */
+#define AB8500_DAPATHCONF_ENDACEAR		6
+#define AB8500_DAPATHCONF_ENDACHSL		5
+#define AB8500_DAPATHCONF_ENDACHSR		4
+#define AB8500_DAPATHCONF_ENDACHFL		3
+#define AB8500_DAPATHCONF_ENDACHFR		2
+#define AB8500_DAPATHCONF_ENDACVIB1		1
+#define AB8500_DAPATHCONF_ENDACVIB2		0
+
+/* AB8500_MUTECONF */
+#define AB8500_MUTECONF_MUTEAR			6
+#define AB8500_MUTECONF_MUTHSL			5
+#define AB8500_MUTECONF_MUTHSR			4
+#define AB8500_MUTECONF_MUTDACEAR		2
+#define AB8500_MUTECONF_MUTDACHSL		1
+#define AB8500_MUTECONF_MUTDACHSR		0
+
+/* AB8500_SHORTCIRCONF */
+#define AB8500_SHORTCIRCONF_ENSHORTPWD		7
+#define AB8500_SHORTCIRCONF_EARSHORTDIS		6
+#define AB8500_SHORTCIRCONF_HSSHORTDIS		5
+#define AB8500_SHORTCIRCONF_HSPULLDEN		4
+#define AB8500_SHORTCIRCONF_HSOSCEN		2
+#define AB8500_SHORTCIRCONF_HSFADDIS		1
+#define AB8500_SHORTCIRCONF_HSZCDDIS		0
+/* Zero cross should be disabled */
+
+/* AB8500_ANACONF5 */
+#define AB8500_ANACONF5_ENCPHS			7
+#define AB8500_ANACONF5_HSLDACTOLOL		5
+#define AB8500_ANACONF5_HSRDACTOLOR		4
+#define AB8500_ANACONF5_ENLOL			3
+#define AB8500_ANACONF5_ENLOR			2
+#define AB8500_ANACONF5_HSAUTOEN		0
+
+/* AB8500_ENVCPCONF */
+#define AB8500_ENVCPCONF_ENVDETHTHRE		4
+#define AB8500_ENVCPCONF_ENVDETLTHRE		0
+#define AB8500_ENVCPCONF_ENVDETHTHRE_MAX	0x0F
+#define AB8500_ENVCPCONF_ENVDETLTHRE_MAX	0x0F
+
+/* AB8500_SIGENVCONF */
+#define AB8500_SIGENVCONF_CPLVEN		5
+#define AB8500_SIGENVCONF_ENVDETCPEN		4
+#define AB8500_SIGENVCONF_ENVDETTIME		0
+#define AB8500_SIGENVCONF_ENVDETTIME_MAX	0x0F
+
+/* AB8500_PWMGENCONF1 */
+#define AB8500_PWMGENCONF1_PWMTOVIB1		7
+#define AB8500_PWMGENCONF1_PWMTOVIB2		6
+#define AB8500_PWMGENCONF1_PWM1CTRL		5
+#define AB8500_PWMGENCONF1_PWM2CTRL		4
+#define AB8500_PWMGENCONF1_PWM1NCTRL		3
+#define AB8500_PWMGENCONF1_PWM1PCTRL		2
+#define AB8500_PWMGENCONF1_PWM2NCTRL		1
+#define AB8500_PWMGENCONF1_PWM2PCTRL		0
+
+/* AB8500_PWMGENCONF2 */
+/* AB8500_PWMGENCONF3 */
+/* AB8500_PWMGENCONF4 */
+/* AB8500_PWMGENCONF5 */
+#define AB8500_PWMGENCONFX_PWMVIBXPOL		7
+#define AB8500_PWMGENCONFX_PWMVIBXDUTCYC	0
+#define AB8500_PWMGENCONFX_PWMVIBXDUTCYC_MAX	0x64
+
+/* AB8500_ANAGAIN1 */
+/* AB8500_ANAGAIN2 */
+#define AB8500_ANAGAINX_ENSEMICX		7
+#define AB8500_ANAGAINX_LOWPOWMICX		6
+#define AB8500_ANAGAINX_MICXGAIN		0
+#define AB8500_ANAGAINX_MICXGAIN_MAX		0x1F
+
+/* AB8500_ANAGAIN3 */
+#define AB8500_ANAGAIN3_HSLGAIN			4
+#define AB8500_ANAGAIN3_HSRGAIN			0
+#define AB8500_ANAGAIN3_HSXGAIN_MAX		0x0F
+
+/* AB8500_ANAGAIN4 */
+#define AB8500_ANAGAIN4_LINLGAIN		4
+#define AB8500_ANAGAIN4_LINRGAIN		0
+#define AB8500_ANAGAIN4_LINXGAIN_MAX		0x0F
+
+/* AB8500_DIGLINHSLGAIN */
+/* AB8500_DIGLINHSRGAIN */
+#define AB8500_DIGLINHSXGAIN_LINTOHSXGAIN	0
+#define AB8500_DIGLINHSXGAIN_LINTOHSXGAIN_MAX	0x13
+
+/* AB8500_ADFILTCONF */
+#define AB8500_ADFILTCONF_AD1NH			7
+#define AB8500_ADFILTCONF_AD2NH			6
+#define AB8500_ADFILTCONF_AD3NH			5
+#define AB8500_ADFILTCONF_AD4NH			4
+#define AB8500_ADFILTCONF_AD1VOICE		3
+#define AB8500_ADFILTCONF_AD2VOICE		2
+#define AB8500_ADFILTCONF_AD3VOICE		1
+#define AB8500_ADFILTCONF_AD4VOICE		0
+
+/* AB8500_DIGIFCONF1 */
+#define AB8500_DIGIFCONF1_ENMASTGEN		7
+#define AB8500_DIGIFCONF1_IF1BITCLKOS1		6
+#define AB8500_DIGIFCONF1_IF1BITCLKOS0		5
+#define AB8500_DIGIFCONF1_ENFSBITCLK1		4
+#define AB8500_DIGIFCONF1_IF0BITCLKOS1		2
+#define AB8500_DIGIFCONF1_IF0BITCLKOS0		1
+#define AB8500_DIGIFCONF1_ENFSBITCLK0		0
+
+/* AB8500_DIGIFCONF2 */
+#define AB8500_DIGIFCONF2_FSYNC0P		6
+#define AB8500_DIGIFCONF2_BITCLK0P		5
+#define AB8500_DIGIFCONF2_IF0DEL		4
+#define AB8500_DIGIFCONF2_IF0FORMAT1		3
+#define AB8500_DIGIFCONF2_IF0FORMAT0		2
+#define AB8500_DIGIFCONF2_IF0WL1		1
+#define AB8500_DIGIFCONF2_IF0WL0		0
+
+/* AB8500_DIGIFCONF3 */
+#define AB8500_DIGIFCONF3_IF0DATOIF1AD		7
+#define AB8500_DIGIFCONF3_IF0CLKTOIF1CLK	6
+#define AB8500_DIGIFCONF3_IF1MASTER		5
+#define AB8500_DIGIFCONF3_IF1DATOIF0AD		3
+#define AB8500_DIGIFCONF3_IF1CLKTOIF0CLK	2
+#define AB8500_DIGIFCONF3_IF0MASTER		1
+#define AB8500_DIGIFCONF3_IF0BFIFOEN		0
+
+/* AB8500_DIGIFCONF4 */
+#define AB8500_DIGIFCONF4_FSYNC1P		6
+#define AB8500_DIGIFCONF4_BITCLK1P		5
+#define AB8500_DIGIFCONF4_IF1DEL		4
+#define AB8500_DIGIFCONF4_IF1FORMAT1		3
+#define AB8500_DIGIFCONF4_IF1FORMAT0		2
+#define AB8500_DIGIFCONF4_IF1WL1		1
+#define AB8500_DIGIFCONF4_IF1WL0		0
+
+/* AB8500_ADSLOTSELX */
+#define AB8500_ADSLOTSELX_AD_OUT1_TO_SLOT_ODD	0x00
+#define AB8500_ADSLOTSELX_AD_OUT2_TO_SLOT_ODD	0x01
+#define AB8500_ADSLOTSELX_AD_OUT3_TO_SLOT_ODD	0x02
+#define AB8500_ADSLOTSELX_AD_OUT4_TO_SLOT_ODD	0x03
+#define AB8500_ADSLOTSELX_AD_OUT5_TO_SLOT_ODD	0x04
+#define AB8500_ADSLOTSELX_AD_OUT6_TO_SLOT_ODD	0x05
+#define AB8500_ADSLOTSELX_AD_OUT7_TO_SLOT_ODD	0x06
+#define AB8500_ADSLOTSELX_AD_OUT8_TO_SLOT_ODD	0x07
+#define AB8500_ADSLOTSELX_ZEROES_TO_SLOT_ODD	0x08
+#define AB8500_ADSLOTSELX_TRISTATE_TO_SLOT_ODD	0x0F
+#define AB8500_ADSLOTSELX_AD_OUT1_TO_SLOT_EVEN	0x00
+#define AB8500_ADSLOTSELX_AD_OUT2_TO_SLOT_EVEN	0x10
+#define AB8500_ADSLOTSELX_AD_OUT3_TO_SLOT_EVEN	0x20
+#define AB8500_ADSLOTSELX_AD_OUT4_TO_SLOT_EVEN	0x30
+#define AB8500_ADSLOTSELX_AD_OUT5_TO_SLOT_EVEN	0x40
+#define AB8500_ADSLOTSELX_AD_OUT6_TO_SLOT_EVEN	0x50
+#define AB8500_ADSLOTSELX_AD_OUT7_TO_SLOT_EVEN	0x60
+#define AB8500_ADSLOTSELX_AD_OUT8_TO_SLOT_EVEN	0x70
+#define AB8500_ADSLOTSELX_ZEROES_TO_SLOT_EVEN	0x80
+#define AB8500_ADSLOTSELX_TRISTATE_TO_SLOT_EVEN	0xF0
+#define AB8500_ADSLOTSELX_EVEN_SHIFT		0
+#define AB8500_ADSLOTSELX_ODD_SHIFT		4
+
+/* AB8500_ADSLOTHIZCTRL1 */
+/* AB8500_ADSLOTHIZCTRL2 */
+/* AB8500_ADSLOTHIZCTRL3 */
+/* AB8500_ADSLOTHIZCTRL4 */
+/* AB8500_DASLOTCONF1 */
+#define AB8500_DASLOTCONF1_DA12VOICE		7
+#define AB8500_DASLOTCONF1_SWAPDA12_34		6
+#define AB8500_DASLOTCONF1_DAI7TOADO1		5
+
+/* AB8500_DASLOTCONF2 */
+#define AB8500_DASLOTCONF2_DAI8TOADO2		5
+
+/* AB8500_DASLOTCONF3 */
+#define AB8500_DASLOTCONF3_DA34VOICE		7
+#define AB8500_DASLOTCONF3_DAI7TOADO3		5
+
+/* AB8500_DASLOTCONF4 */
+#define AB8500_DASLOTCONF4_DAI8TOADO4		5
+
+/* AB8500_DASLOTCONF5 */
+#define AB8500_DASLOTCONF5_DA56VOICE		7
+#define AB8500_DASLOTCONF5_DAI7TOADO5		5
+
+/* AB8500_DASLOTCONF6 */
+#define AB8500_DASLOTCONF6_DAI8TOADO6		5
+
+/* AB8500_DASLOTCONF7 */
+#define AB8500_DASLOTCONF7_DAI8TOADO7		5
+
+/* AB8500_DASLOTCONF8 */
+#define AB8500_DASLOTCONF8_DAI7TOADO8		5
+
+#define AB8500_DASLOTCONFX_SLTODAX_SHIFT	0
+#define AB8500_DASLOTCONFX_SLTODAX_MASK		0x1F
+
+/* AB8500_CLASSDCONF1 */
+#define AB8500_CLASSDCONF1_PARLHF		7
+#define AB8500_CLASSDCONF1_PARLVIB		6
+#define AB8500_CLASSDCONF1_VIB1SWAPEN		3
+#define AB8500_CLASSDCONF1_VIB2SWAPEN		2
+#define AB8500_CLASSDCONF1_HFLSWAPEN		1
+#define AB8500_CLASSDCONF1_HFRSWAPEN		0
+
+/* AB8500_CLASSDCONF2 */
+#define AB8500_CLASSDCONF2_FIRBYP3		7
+#define AB8500_CLASSDCONF2_FIRBYP2		6
+#define AB8500_CLASSDCONF2_FIRBYP1		5
+#define AB8500_CLASSDCONF2_FIRBYP0		4
+#define AB8500_CLASSDCONF2_HIGHVOLEN3		3
+#define AB8500_CLASSDCONF2_HIGHVOLEN2		2
+#define AB8500_CLASSDCONF2_HIGHVOLEN1		1
+#define AB8500_CLASSDCONF2_HIGHVOLEN0		0
+
+/* AB8500_CLASSDCONF3 */
+#define AB8500_CLASSDCONF3_DITHHPGAIN		4
+#define AB8500_CLASSDCONF3_DITHHPGAIN_MAX	0x0A
+#define AB8500_CLASSDCONF3_DITHWGAIN		0
+#define AB8500_CLASSDCONF3_DITHWGAIN_MAX	0x0A
+
+/* AB8500_DMICFILTCONF */
+#define AB8500_DMICFILTCONF_ANCINSEL		7
+#define AB8500_DMICFILTCONF_DA3TOEAR		6
+#define AB8500_DMICFILTCONF_DMIC1SINC3		5
+#define AB8500_DMICFILTCONF_DMIC2SINC3		4
+#define AB8500_DMICFILTCONF_DMIC3SINC3		3
+#define AB8500_DMICFILTCONF_DMIC4SINC3		2
+#define AB8500_DMICFILTCONF_DMIC5SINC3		1
+#define AB8500_DMICFILTCONF_DMIC6SINC3		0
+
+/* AB8500_DIGMULTCONF1 */
+#define AB8500_DIGMULTCONF1_DATOHSLEN		7
+#define AB8500_DIGMULTCONF1_DATOHSREN		6
+#define AB8500_DIGMULTCONF1_AD1SEL		5
+#define AB8500_DIGMULTCONF1_AD2SEL		4
+#define AB8500_DIGMULTCONF1_AD3SEL		3
+#define AB8500_DIGMULTCONF1_AD5SEL		2
+#define AB8500_DIGMULTCONF1_AD6SEL		1
+#define AB8500_DIGMULTCONF1_ANCSEL		0
+
+/* AB8500_DIGMULTCONF2 */
+#define AB8500_DIGMULTCONF2_DATOHFREN		7
+#define AB8500_DIGMULTCONF2_DATOHFLEN		6
+#define AB8500_DIGMULTCONF2_HFRSEL		5
+#define AB8500_DIGMULTCONF2_HFLSEL		4
+#define AB8500_DIGMULTCONF2_FIRSID1SEL		2
+#define AB8500_DIGMULTCONF2_FIRSID2SEL		0
+
+/* AB8500_ADDIGGAIN1 */
+/* AB8500_ADDIGGAIN2 */
+/* AB8500_ADDIGGAIN3 */
+/* AB8500_ADDIGGAIN4 */
+/* AB8500_ADDIGGAIN5 */
+/* AB8500_ADDIGGAIN6 */
+#define AB8500_ADDIGGAINX_FADEDISADX		6
+#define AB8500_ADDIGGAINX_ADXGAIN_MAX		0x3F
+
+/* AB8500_DADIGGAIN1 */
+/* AB8500_DADIGGAIN2 */
+/* AB8500_DADIGGAIN3 */
+/* AB8500_DADIGGAIN4 */
+/* AB8500_DADIGGAIN5 */
+/* AB8500_DADIGGAIN6 */
+#define AB8500_DADIGGAINX_FADEDISDAX		6
+#define AB8500_DADIGGAINX_DAXGAIN_MAX		0x3F
+
+/* AB8500_ADDIGLOOPGAIN1 */
+/* AB8500_ADDIGLOOPGAIN2 */
+#define AB8500_ADDIGLOOPGAINX_FADEDISADXL	6
+#define AB8500_ADDIGLOOPGAINX_ADXLBGAIN_MAX	0x3F
+
+/* AB8500_HSLEARDIGGAIN */
+#define AB8500_HSLEARDIGGAIN_HSSINC1		7
+#define AB8500_HSLEARDIGGAIN_FADEDISHSL		4
+#define AB8500_HSLEARDIGGAIN_HSLDGAIN_MAX	0x09
+
+/* AB8500_HSRDIGGAIN */
+#define AB8500_HSRDIGGAIN_FADESPEED		6
+#define AB8500_HSRDIGGAIN_FADEDISHSR		4
+#define AB8500_HSRDIGGAIN_HSRDGAIN_MAX		0x09
+
+/* AB8500_SIDFIRGAIN1 */
+/* AB8500_SIDFIRGAIN2 */
+#define AB8500_SIDFIRGAINX_FIRSIDXGAIN_MAX	0x1F
+
+/* AB8500_ANCCONF1 */
+#define AB8500_ANCCONF1_ANCIIRUPDATE		3
+#define AB8500_ANCCONF1_ENANC			2
+#define AB8500_ANCCONF1_ANCIIRINIT		1
+#define AB8500_ANCCONF1_ANCFIRUPDATE		0
+
+/* AB8500_ANCCONF2 */
+#define AB8500_ANCCONF2_SHIFT			5
+#define AB8500_ANCCONF2_MIN			-0x10
+#define AB8500_ANCCONF2_MAX			0xF
+
+/* AB8500_ANCCONF3 */
+#define AB8500_ANCCONF3_SHIFT			5
+#define AB8500_ANCCONF3_MIN			-0x10
+#define AB8500_ANCCONF3_MAX			0xF
+
+/* AB8500_ANCCONF4 */
+#define AB8500_ANCCONF4_SHIFT			5
+#define AB8500_ANCCONF4_MIN			-0x10
+#define AB8500_ANCCONF4_MAX			0xF
+
+/* AB8500_ANC_FIR_COEFFS */
+#define AB8500_ANC_FIR_COEFF_MIN		-0x8000
+#define AB8500_ANC_FIR_COEFF_MAX		0x7FFF
+#define AB8500_ANC_FIR_COEFFS			15
+
+/* AB8500_ANC_IIR_COEFFS */
+#define AB8500_ANC_IIR_COEFF_MIN		-0x800000
+#define AB8500_ANC_IIR_COEFF_MAX		0x7FFFFF
+#define AB8500_ANC_IIR_COEFFS			24
+/* AB8500_ANC_WARP_DELAY */
+#define AB8500_ANC_WARP_DELAY_SHIFT		16
+#define AB8500_ANC_WARP_DELAY_MIN		0x0000
+#define AB8500_ANC_WARP_DELAY_MAX		0xFFFF
+
+/* AB8500_ANCCONF11 */
+/* AB8500_ANCCONF12 */
+/* AB8500_ANCCONF13 */
+/* AB8500_ANCCONF14 */
+
+/* AB8500_SIDFIRADR */
+#define AB8500_SIDFIRADR_FIRSIDSET		7
+#define AB8500_SIDFIRADR_ADDRESS_SHIFT		0
+#define AB8500_SIDFIRADR_ADDRESS_MAX		0x7F
+
+/* AB8500_SIDFIRCOEF1 */
+/* AB8500_SIDFIRCOEF2 */
+#define AB8500_SID_FIR_COEFF_MIN		0
+#define AB8500_SID_FIR_COEFF_MAX		0xFFFF
+#define AB8500_SID_FIR_COEFFS			128
+
+/* AB8500_SIDFIRCONF */
+#define AB8500_SIDFIRCONF_ENFIRSIDS		2
+#define AB8500_SIDFIRCONF_FIRSIDSTOIF1		1
+#define AB8500_SIDFIRCONF_FIRSIDBUSY		0
+
+/* AB8500_AUDINTMASK1 */
+/* AB8500_AUDINTSOURCE1 */
+/* AB8500_AUDINTMASK2 */
+/* AB8500_AUDINTSOURCE2 */
+
+/* AB8500_FIFOCONF1 */
+#define AB8500_FIFOCONF1_BFIFOMASK		0x80
+#define AB8500_FIFOCONF1_BFIFO19M2		0x40
+#define AB8500_FIFOCONF1_BFIFOINT_SHIFT		0
+#define AB8500_FIFOCONF1_BFIFOINT_MAX		0x3F
+
+/* AB8500_FIFOCONF2 */
+#define AB8500_FIFOCONF2_BFIFOTX_SHIFT		0
+#define AB8500_FIFOCONF2_BFIFOTX_MAX		0xFF
+
+/* AB8500_FIFOCONF3 */
+#define AB8500_FIFOCONF3_BFIFOEXSL_SHIFT	5
+#define AB8500_FIFOCONF3_BFIFOEXSL_MAX		0x5
+#define AB8500_FIFOCONF3_PREBITCLK0_SHIFT	2
+#define AB8500_FIFOCONF3_PREBITCLK0_MAX		0x7
+#define AB8500_FIFOCONF3_BFIFOMAST_SHIFT	1
+#define AB8500_FIFOCONF3_BFIFORUN_SHIFT		0
+
+/* AB8500_FIFOCONF4 */
+#define AB8500_FIFOCONF4_BFIFOFRAMSW_SHIFT	0
+#define AB8500_FIFOCONF4_BFIFOFRAMSW_MAX	0xFF
+
+/* AB8500_FIFOCONF5 */
+#define AB8500_FIFOCONF5_BFIFOWAKEUP_SHIFT	0
+#define AB8500_FIFOCONF5_BFIFOWAKEUP_MAX	0xFF
+
+/* AB8500_FIFOCONF6 */
+#define AB8500_FIFOCONF6_BFIFOSAMPLE_SHIFT	0
+#define AB8500_FIFOCONF6_BFIFOSAMPLE_MAX	0xFF
+
+/* AB8500_AUDREV */
+
+#endif
-- 
1.7.8.3
