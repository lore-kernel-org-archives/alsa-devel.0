From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Subject: [PATCH v2] Add support for Tempo Semiconductor's
	TSCS42xx audio CODEC
Date: Tue, 14 Nov 2017 12:34:08 -0600
Message-ID: <20171114183408.20504-1-steven.eckhoff.opensource@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com
 [74.125.82.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A777B266F61
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 19:34:33 +0100 (CET)
Received: by mail-ot0-f193.google.com with SMTP id g104so5390854otg.7
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 10:34:33 -0800 (PST)
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
Cc: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Currently there is no support for the TSCS42xx audio CODEC.

Add support for it.

Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 .../ABI/testing/sysfs-bus-i2c-devices-tscs42xx.txt |  185 ++
 .../devicetree/bindings/sound/tscs42xx.txt         |   24 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 MAINTAINERS                                        |    5 +
 sound/soc/codecs/Kconfig                           |    8 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/tscs42xx.c                        | 2006 +++++++++++++++
 sound/soc/codecs/tscs42xx.h                        | 2693 ++++++++++++++++++++
 8 files changed, 4924 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-tscs42xx.txt
 create mode 100644 Documentation/devicetree/bindings/sound/tscs42xx.txt
 create mode 100644 sound/soc/codecs/tscs42xx.c
 create mode 100644 sound/soc/codecs/tscs42xx.h

diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-tscs42xx.txt b/Documentation/ABI/testing/sysfs-bus-i2c-devices-tscs42xx.txt
new file mode 100644
index 000000000000..ed409a97e812
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-tscs42xx.txt
@@ -0,0 +1,185 @@
+What:		/sys/bus/i2c/devices/.../dsp/eq[n]_ch[n]_[ab][n]
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Sets the equalizer biquad coefficient
+
+What:		/sys/bus/i2c/devices/.../dsp/eq[n]_ch[n]_prescale
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Sets the prescaler attenuation of the equalizer
+		biquad cascade
+
+What:		/sys/bus/i2c/devices/.../dsp/bass_ext[n]_[ab][n]
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Sets the bass extraction biquad coefficient
+
+What:		/sys/bus/i2c/devices/.../dsp/bass_lmt_[ab][n]
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Sets the bass non linear function coefficient
+
+What:		/sys/bus/i2c/devices/.../dsp/bass_cto_[ab][n]
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Sets the bass cut-off biquad coefficient
+
+What:		/sys/bus/i2c/devices/.../dsp/treb_ext[n]_[ab][n]
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Sets the treb extraction biquad coefficient
+
+What:		/sys/bus/i2c/devices/.../dsp/treb_lmt_[ab][n]
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Sets the treb non linear function coefficient
+
+What:		/sys/bus/i2c/devices/.../dsp/treb_cto_[ab][n]
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Sets the treb cut-off biquad coefficient
+
+What:		/sys/bus/i2c/devices/.../dsp/3d_coef
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Sets the 3d coefficient
+
+What:		/sys/bus/i2c/devices/.../dsp/3d_mix
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Sets 3d mix coefficient
+
+What:		/sys/bus/i2c/devices/.../dsp/bass_mix
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Sets bass mix coefficient
+
+What:		/sys/bus/i2c/devices/.../dsp/treb_mix
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Sets treb mix coefficient
+
+What:		/sys/bus/i2c/devices/.../controls/eq1_en
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Enables equalizer one
+
+What:		/sys/bus/i2c/devices/.../controls/eq1_bands_en
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Enables equalizer one bands:
+			0h = Pre-scale only
+			1h = Pre-scale + EQ band 0
+			2h = Pre-scale + EQ bands 0 to 1
+			...
+			6h = Pre-scale + EQ bands 0 to 5
+
+What:		/sys/bus/i2c/devices/.../controls/eq2_en
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Enables equalizer one
+
+What:		/sys/bus/i2c/devices/.../controls/eq2_bands_en
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Enables equalizer one bands:
+			0h = Pre-scale only
+			1h = Pre-scale + EQ band 0
+			2h = Pre-scale + EQ bands 0 to 1
+			...
+			6h = Pre-scale + EQ bands 0 to 5
+
+What:		/sys/bus/i2c/devices/.../controls/cle_level_mode
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Sets the compressor, limiter and expander level detection mode:
+			0h = Average
+			1h = Peak
+
+What:		/sys/bus/i2c/devices/.../controls/cle_level_detect_window
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Sets the compressor, limiter and expander level detection mode
+		window:
+			0h = Equivalent of 512 samples
+				at the selected Base Rate (~10-16ms)
+			1h = Equivalent of 64 samples
+				at the selected Base Rate (~1.3-2ms)
+
+What:		/sys/bus/i2c/devices/.../controls/exp_en
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Enables the expander
+
+What:		/sys/bus/i2c/devices/.../controls/limit_en
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Enables the limiter
+
+What:		/sys/bus/i2c/devices/.../controls/comp_en
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Enables the compressor
+
+What:		/sys/bus/i2c/devices/.../controls/3d_en
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Enables the 3D enhancer
+
+What:		/sys/bus/i2c/devices/.../controls/treb_en
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Enables the treble enhancer
+
+What:		/sys/bus/i2c/devices/.../controls/treb_nlf_bypass
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Enables the treble non-linear function bypass
+
+What:		/sys/bus/i2c/devices/.../controls/bass_en
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Enables the bass enhancer
+
+What:		/sys/bus/i2c/devices/.../controls/bass_nlf_bypass
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Enables the bass non-linear function bypass
+
+What:		/sys/bus/i2c/devices/.../control_regs/export
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Adds the specified control register to the sysfs interface
+
+What:		/sys/bus/i2c/devices/.../control_regs/unexport
+Date:		November 2017
+KernelVersion:	4.14
+Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+Description:	Removes the specified control register to the sysfs interface
diff --git a/Documentation/devicetree/bindings/sound/tscs42xx.txt b/Documentation/devicetree/bindings/sound/tscs42xx.txt
new file mode 100644
index 000000000000..2f9c8affde48
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tscs42xx.txt
@@ -0,0 +1,24 @@
+TSCS42XX Audio CODEC
+
+Required Properties:
+
+  - compatible : "tscs:tscs42xx"
+
+  - reg : The I2C address of the device
+
+  - mclk-src : The source of the master clock. This can be "mclk" or "xtal".
+
+  - mclk-src-freq : The frequency of the master clock
+
+  - clocks : The phandle of the master clock
+
+Example:
+
+codec: tscs42xx@69 {
+	compatible = "tscs,tscs42xx";
+	reg = <0x69>;
+	mclk-src = "mclk";
+	mclk-src-freq = <25000000>;
+	clocks = <&cprman BCM2835_CLOCK_GP1>;
+	status = "okay";
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index b1eeca851d6f..24036f503aa0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -349,6 +349,7 @@ tpo	TPO
 tronfy	Tronfy
 tronsmart	Tronsmart
 truly	Truly Semiconductors Limited
+tscs	Tempo Semiconductor
 tsd	Theobroma Systems Design und Consulting GmbH
 tyan	Tyan Computer Corporation
 ucrobotics	uCRobotics
diff --git a/MAINTAINERS b/MAINTAINERS
index 650aa0e0e9d8..63d1d892842a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13674,6 +13674,11 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git
 S:	Maintained
 K:	^Subject:.*(?i)trivial
 
+TEMPO SEMICONDUCTOR DRIVERS
+M:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+S:	Maintained
+F:	sound/soc/codecs/tscs42xx.*
+
 TTY LAYER
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Jiri Slaby <jslaby@suse.com>
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c367d11079bc..34e911c1e082 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -217,6 +217,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM9705 if SND_SOC_AC97_BUS
 	select SND_SOC_WM9712 if SND_SOC_AC97_BUS
 	select SND_SOC_WM9713 if SND_SOC_AC97_BUS
+	select SND_SOC_TSCS42XX if I2C
         help
           Normally ASoC codec drivers are only built if a machine driver which
           uses them is also built since they are only usable with a machine
@@ -1142,6 +1143,13 @@ config SND_SOC_ZX_AUD96P22
 	depends on I2C
 	select REGMAP_I2C
 
+config SND_SOC_TSCS42XX
+	tristate "Tempo Semiconductor TSCS42xx CODEC"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Add support for Tempo Semiconductor's TSCS42xx audio CODEC.
+
 # Amp
 config SND_SOC_LM4857
 	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 05018b7ca72b..a20e643b4067 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -230,6 +230,7 @@ snd-soc-wm9712-objs := wm9712.o
 snd-soc-wm9713-objs := wm9713.o
 snd-soc-wm-hubs-objs := wm_hubs.o
 snd-soc-zx-aud96p22-objs := zx_aud96p22.o
+snd-soc-tscs42xx-objs := tscs42xx.o
 # Amp
 snd-soc-dio2125-objs := dio2125.o
 snd-soc-max9877-objs := max9877.o
@@ -468,6 +469,7 @@ obj-$(CONFIG_SND_SOC_WM9713)	+= snd-soc-wm9713.o
 obj-$(CONFIG_SND_SOC_WM_ADSP)	+= snd-soc-wm-adsp.o
 obj-$(CONFIG_SND_SOC_WM_HUBS)	+= snd-soc-wm-hubs.o
 obj-$(CONFIG_SND_SOC_ZX_AUD96P22) += snd-soc-zx-aud96p22.o
+obj-$(CONFIG_SND_SOC_TSCS42XX)	+= snd-soc-tscs42xx.o
 
 # Amp
 obj-$(CONFIG_SND_SOC_DIO2125)	+= snd-soc-dio2125.o
diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
new file mode 100644
index 000000000000..dad874a19c58
--- /dev/null
+++ b/sound/soc/codecs/tscs42xx.c
@@ -0,0 +1,2006 @@
+/*
+ * tscs42xx.c -- TSCS42xx ALSA SoC Audio driver
+ *
+ * Copyright 2017 Tempo Semiconductor, Inc.
+ *
+ * Author: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/moduleparam.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/of_device.h>
+#include <linux/mutex.h>
+#include <linux/clk.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+#include <linux/firmware.h>
+#include <linux/sysfs.h>
+
+#include "tscs42xx.h"
+
+enum {
+	PLL_SRC_CLK_XTAL,
+	PLL_SRC_CLK_MCLK2,
+};
+
+/*
+ * Functions that receive a pointer to data
+ * should assume that the data is locked.
+ */
+struct tscs42xx_priv {
+	struct regmap *regmap;
+	struct clk *mclk;
+	int mclk_src_freq;
+	int pll_src_clk;
+	int bclk_ratio;
+	int samplerate;
+	int pll_users;
+	struct snd_soc_codec *codec;
+	struct mutex lock;
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
+};
+
+static struct reg_default r_inits[] = {
+	{ .reg = R_ADCSR,   .def = RV_ADCSR_ABCM_64 },
+	{ .reg = R_DACSR,   .def = RV_DACSR_DBCM_64 },
+	{ .reg = R_AIC2,    .def = RV_AIC2_BLRCM_DAC_BCLK_LRCLK_SHARED },
+};
+
+#define NUM_DACCR_BYTES 3
+static int load_dac_coefficient_ram(struct snd_soc_codec *codec)
+{
+	const struct firmware *fw = NULL;
+	int ret;
+	int i;
+	int j;
+	int addr;
+
+	ret = request_firmware_direct(&fw, "tscs42xx_daccram.dfw", codec->dev);
+	if (ret) {
+		dev_info(codec->dev,
+			"No tscs42xx_daccram.dfw file found (%d)\n", ret);
+		return 0;
+	}
+
+	if (fw->size % NUM_DACCR_BYTES != 0) {
+		ret = -EINVAL;
+		dev_err(codec->dev, "Malformed daccram file (%d)\n", ret);
+		return ret;
+	}
+
+	for (i = 0, addr = 0; i < fw->size; i += NUM_DACCR_BYTES, addr++) {
+
+		do {
+			ret = snd_soc_read(codec, R_DACCRSTAT);
+		} while (ret > 0);
+
+		if (ret < 0) {
+			dev_err(codec->dev,
+				"Failed to read daccrstat (%d)\n", ret);
+			return ret;
+		}
+
+		/* Explicit address update */
+		ret = snd_soc_write(codec, R_DACCRADDR, addr);
+		if (ret < 0) {
+			dev_err(codec->dev,
+				"Failed to write DACCRADDR (%d)\n", ret);
+			return ret;
+		}
+
+		for (j = 0; j < NUM_DACCR_BYTES; j++) { /* FW in big endian */
+
+			do {
+				ret = snd_soc_read(codec, R_DACCRSTAT);
+			} while (ret > 0);
+
+			if (ret < 0) {
+				dev_err(codec->dev,
+					"Failed to read daccrstat (%d)\n", ret);
+				return ret;
+			}
+
+			/* Write LSB first due to auto increment on MSB */
+			ret = snd_soc_write(codec, R_DACCRWRL + j,
+					fw->data[i + NUM_DACCR_BYTES - 1 - j]);
+			if (ret < 0) {
+				dev_err(codec->dev,
+					"Failed to write coefficient (%d)\n",
+					ret);
+				return ret;
+			}
+		}
+	}
+
+	dev_info(codec->dev, "Loaded tscs42xx_daccram.dfw\n");
+
+	return 0;
+}
+
+#define NUM_CONTROL_BYTES 2
+static int load_control_regs(struct snd_soc_codec *codec)
+{
+	const struct firmware *fw = NULL;
+	int ret;
+	int i;
+
+	ret = request_firmware_direct(&fw, "tscs42xx_controls.dfw", codec->dev);
+	if (ret) {
+		dev_info(codec->dev,
+			"No tscs42xx_controls.dfw file found (%d)\n", ret);
+		return 0;
+	}
+
+	if (fw->size % NUM_CONTROL_BYTES != 0) {
+		ret = -EINVAL;
+		dev_err(codec->dev, "Malformed controls file (%d)\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < fw->size; i += NUM_CONTROL_BYTES) {
+		ret = snd_soc_write(codec, fw->data[i], fw->data[i + 1]);
+		if (ret < 0) {
+			dev_err(codec->dev, "Failed to write control (%d)\n",
+				ret);
+			return ret;
+		}
+	}
+
+	dev_info(codec->dev, "Loaded tscs42xx_controls.dfw\n");
+
+	return 0;
+}
+
+#define PLL_LOCK_TIME_MAX 10
+static bool plls_locked(struct snd_soc_codec *codec)
+{
+	int reg;
+	int count;
+	bool ret = false;
+
+	for (count = 0; count < PLL_LOCK_TIME_MAX; count++) {
+		reg = snd_soc_read(codec, R_PLLCTL0);
+		if (reg < 0) {
+			dev_err(codec->dev,
+				"Failed to read PLL lock status (%d)\n", ret);
+			break;
+		} else if (reg > 0) {
+			ret = true;
+			break;
+		}
+		mdelay(1);
+	}
+
+	return ret;
+}
+
+/* D2S Input Select */
+static const char * const d2s_input_select_text[] = {
+	"Line 1", "Line 2"
+};
+
+static const struct soc_enum d2s_input_select_enum =
+SOC_ENUM_SINGLE(R_INMODE, FB_INMODE_DS, ARRAY_SIZE(d2s_input_select_text),
+		d2s_input_select_text);
+
+static const struct snd_kcontrol_new d2s_input_mux =
+SOC_DAPM_ENUM("D2S_IN_MUX", d2s_input_select_enum);
+
+/* Input L Capture Route */
+static const char * const input_select_text[] = {
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
+static const char * const ch_map_select_text[] = {
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
+	mdelay(5);
+	return 0;
+}
+
+static int dapm_micb_event(struct snd_soc_dapm_widget *w,
+			 struct snd_kcontrol *kcontrol, int event)
+{
+	mdelay(5);
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget tscs42xx_dapm_widgets[] = {
+	SND_SOC_DAPM_SUPPLY_S("Vref", 1, R_PWRM2, FB_PWRM2_VREF, 0,
+		dapm_vref_event, SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_PRE_PMD),
+
+	/* Headphone */
+	SND_SOC_DAPM_DAC("DAC L", "HiFi Playback", R_PWRM2, FB_PWRM2_HPL, 0),
+	SND_SOC_DAPM_DAC("DAC R", "HiFi Playback", R_PWRM2, FB_PWRM2_HPR, 0),
+	SND_SOC_DAPM_OUTPUT("Headphone L"),
+	SND_SOC_DAPM_OUTPUT("Headphone R"),
+
+	/* Speaker */
+	SND_SOC_DAPM_DAC("ClassD L", "HiFi Playback",
+		R_PWRM2, FB_PWRM2_SPKL, 0),
+	SND_SOC_DAPM_DAC("ClassD R", "HiFi Playback",
+		R_PWRM2, FB_PWRM2_SPKR, 0),
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
+	SND_SOC_DAPM_INPUT("Digital Mic L"),
+	SND_SOC_DAPM_INPUT("Digital Mic R"),
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
+	{"DAC L", NULL, "Vref"},
+	{"DAC R", NULL, "Vref"},
+	{"Headphone L", NULL, "DAC L"},
+	{"Headphone R", NULL, "DAC R"},
+
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
+	{"ADC L", NULL, "ADC Mute"},
+	{"ADC R", NULL, "ADC Mute"},
+};
+
+/***********
+ * Volumes *
+ ***********/
+
+static DECLARE_TLV_DB_SCALE(hpvol, -8850, 75, 0);
+static DECLARE_TLV_DB_SCALE(spkvol, -7725, 75, 0);
+static DECLARE_TLV_DB_SCALE(dacvol, -9563, 38, 0);
+static DECLARE_TLV_DB_SCALE(adcvol, -7125, 38, 0);
+static DECLARE_TLV_DB_SCALE(invol, -1725, 75, 0);
+
+/*********
+ * INSEL *
+ *********/
+
+static DECLARE_TLV_DB_SCALE(mic_boost_tlv, 0, 1000, 0);
+
+/************
+ * CONTROLS *
+ ************/
+static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
+	/* Volumes */
+	SOC_DOUBLE_R_TLV("Headphone Playback Volume", R_HPVOLL, R_HPVOLR,
+			FB_HPVOLL, 0x7F, 0, hpvol),
+	SOC_DOUBLE_R_TLV("Speaker Playback Volume", R_SPKVOLL, R_SPKVOLR,
+			FB_SPKVOLL, 0x7F, 0, spkvol),
+	SOC_DOUBLE_R_TLV("Master Playback Volume", R_DACVOLL, R_DACVOLR,
+			FB_DACVOLL, 0xFF, 0, dacvol),
+	SOC_DOUBLE_R_TLV("PCM Capture Volume", R_ADCVOLL, R_ADCVOLR,
+			FB_ADCVOLL, 0xFF, 0, adcvol),
+	SOC_DOUBLE_R_TLV("Master Capture Volume", R_INVOLL, R_INVOLR,
+			FB_INVOLL, 0x3F, 0, invol),
+
+	/* INSEL */
+	SOC_DOUBLE_R_TLV("Mic Boost Capture Volume", R_INSELL, R_INSELR,
+			FB_INSELL_MICBSTL, FV_INSELL_MICBSTL_30DB,
+			0, mic_boost_tlv),
+
+	/* Input Channel Map */
+	SOC_ENUM("Input Channel Map Switch", ch_map_select_enum),
+};
+
+#define TSCS42XX_RATES SNDRV_PCM_RATE_8000_96000
+
+#define TSCS42XX_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE \
+	| SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
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
+static int setup_sample_rate(struct snd_soc_codec *codec,
+		unsigned int rate,
+		struct tscs42xx_priv *tscs42xx)
+{
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
+	tscs42xx->samplerate = rate;
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
+#define PLL_CTL(f, rt, rd, r1b_l, r9, ra, rb,				\
+		rc, r12, r1b_h, re, rf, r10, r11)			\
+	{								\
+		.input_freq = f,					\
+		.settings = {						\
+			{R_TIMEBASE,  rt,   0xFF},			\
+			{R_PLLCTLD,   rd,   0xFF},			\
+			{R_PLLCTL1B, r1b_l, 0x0F},			\
+			{R_PLLCTL9,   r9,   0xFF},			\
+			{R_PLLCTLA,   ra,   0xFF},			\
+			{R_PLLCTLB,   rb,   0xFF},			\
+			{R_PLLCTLC,   rc,   0xFF},			\
+			{R_PLLCTL12, r12,   0xFF},			\
+			{R_PLLCTL1B, r1b_h, 0xF0},			\
+			{R_PLLCTLE,   re,   0xFF},			\
+			{R_PLLCTLF,   rf,   0xFF},			\
+			{R_PLLCTL10, r10,   0xFF},			\
+			{R_PLLCTL11, r11,   0xFF},			\
+		},							\
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
+static int configure_clocks(struct snd_soc_codec *codec,
+		struct tscs42xx_priv *tscs42xx)
+{
+	int ret;
+
+	ret = set_pll_ctl_from_input_freq(codec, tscs42xx->mclk_src_freq);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to setup PLL input (%d)\n", ret);
+		return ret;
+	}
+
+	switch (tscs42xx->pll_src_clk) {
+	case PLL_SRC_CLK_XTAL:
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
+	case PLL_SRC_CLK_MCLK2:
+		ret = clk_set_rate(tscs42xx->mclk, tscs42xx->mclk_src_freq);
+		if (ret < 0) {
+			dev_err(codec->dev,
+				"Could not set mclk rate %d (%d)\n",
+				tscs42xx->mclk_src_freq, ret);
+			return ret;
+		}
+
+		ret = clk_prepare_enable(tscs42xx->mclk);
+		if (ret < 0) {
+			dev_err(codec->dev, "Failed to enable mclk: (%d)\n",
+				ret);
+			return ret;
+		}
+
+		ret = snd_soc_write(codec, R_PLLREFSEL,
+				RV_PLLREFSEL_PLL1_REF_SEL_MCLK2 |
+				RV_PLLREFSEL_PLL2_REF_SEL_MCLK2);
+		if (ret < 0) {
+			dev_err(codec->dev,
+				"Failed to set PLL reference (%d)\n", ret);
+			return ret;
+		}
+		break;
+	}
+
+	return 0;
+}
+
+static int power_down_audio_plls(struct snd_soc_codec *codec,
+	struct tscs42xx_priv *tscs42xx)
+{
+	int ret;
+
+	tscs42xx->pll_users--;
+	if (tscs42xx->pll_users > 0)
+		return 0;
+
+	ret = snd_soc_update_bits(codec, R_PLLCTL1C,
+			RM_PLLCTL1C_PDB_PLL1,
+			RV_PLLCTL1C_PDB_PLL1_DISABLE);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to turn PLL off (%d)\n", ret);
+		return ret;
+	}
+	ret = snd_soc_update_bits(codec, R_PLLCTL1C,
+			RM_PLLCTL1C_PDB_PLL2,
+			RV_PLLCTL1C_PDB_PLL2_DISABLE);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to turn PLL off (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int power_up_audio_plls(struct snd_soc_codec *codec,
+	struct tscs42xx_priv *tscs42xx)
+{
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
+	ret = snd_soc_update_bits(codec, R_PLLCTL1C, mask, val);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to turn PLL on (%d)\n", ret);
+		return ret;
+	}
+
+	if (!plls_locked(codec)) {
+		dev_err(codec->dev, "Failed to lock plls\n");
+		return -ENOMSG;
+	}
+
+	tscs42xx->pll_users++;
+
+	return 0;
+}
+
+static int tscs42xx_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params,
+		struct snd_soc_dai *codec_dai)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct tscs42xx_priv *tscs42xx = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	mutex_lock(&tscs42xx->lock);
+
+	ret = setup_sample_format(codec, params_format(params));
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to setup sample format (%d)\n",
+			ret);
+		goto exit;
+	}
+
+	ret = setup_sample_rate(codec, params_rate(params), tscs42xx);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to setup sample rate (%d)\n", ret);
+		goto exit;
+	}
+
+	ret = 0;
+exit:
+	mutex_unlock(&tscs42xx->lock);
+
+	return ret;
+}
+
+static int dac_mute(struct snd_soc_codec *codec,
+	struct tscs42xx_priv *tscs42xx)
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
+	ret = power_down_audio_plls(codec, tscs42xx);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to power down plls (%d)\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int dac_unmute(struct snd_soc_codec *codec,
+	struct tscs42xx_priv *tscs42xx)
+{
+	int ret;
+
+	ret = power_up_audio_plls(codec, tscs42xx);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to power up plls (%d)\n",
+			ret);
+		return ret;
+	}
+
+	ret = snd_soc_update_bits(codec, R_CNVRTR1, RM_CNVRTR1_DACMU,
+		RV_CNVRTR1_DACMU_DISABLE);
+	if (ret < 0) {
+		power_down_audio_plls(codec, tscs42xx);
+		dev_err(codec->dev, "Failed to unmute DAC (%d)\n",
+				ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int adc_mute(struct snd_soc_codec *codec,
+	struct tscs42xx_priv *tscs42xx)
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
+	ret = power_down_audio_plls(codec, tscs42xx);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to power down plls (%d)\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int adc_unmute(struct snd_soc_codec *codec,
+	struct tscs42xx_priv *tscs42xx)
+{
+	int ret;
+
+	ret = power_up_audio_plls(codec, tscs42xx);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to power up plls (%d)\n",
+			ret);
+		return ret;
+	}
+
+	ret = snd_soc_update_bits(codec, R_CNVRTR0, RM_CNVRTR0_ADCMU,
+		RV_CNVRTR0_ADCMU_DISABLE);
+	if (ret < 0) {
+		power_down_audio_plls(codec, tscs42xx);
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
+	struct tscs42xx_priv *tscs42xx = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	mutex_lock(&tscs42xx->lock);
+
+	if (mute)
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			ret = dac_mute(codec, tscs42xx);
+		else
+			ret = adc_mute(codec, tscs42xx);
+	else
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			ret = dac_unmute(codec, tscs42xx);
+		else
+			ret = adc_unmute(codec, tscs42xx);
+
+	mutex_unlock(&tscs42xx->lock);
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
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		ret = snd_soc_update_bits(codec, R_AIC1, RM_AIC1_MS,
+				RV_AIC1_MS_MASTER);
+		if (ret < 0)
+			dev_err(codec->dev,
+				"Failed to set codec DAI master (%d)\n", ret);
+		else
+			ret = 0;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		ret = -EINVAL;
+		dev_err(codec->dev, "tscs42xx slave mode not supported (%d)\n",
+			ret);
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(codec->dev, "Unsupported format (%d)\n", ret);
+		break;
+	}
+
+	return ret;
+}
+
+static int tscs42xx_set_bclk_ratio(struct snd_soc_dai *codec_dai,
+		unsigned int ratio)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct tscs42xx_priv *tscs42xx = snd_soc_codec_get_drvdata(codec);
+	unsigned int value;
+	int ret = 0;
+
+	mutex_lock(&tscs42xx->lock);
+
+	switch (ratio) {
+	case 32:
+	value = RV_DACSR_DBCM_32;
+		break;
+	case 40:
+	value = RV_DACSR_DBCM_40;
+		break;
+	case 64:
+	value = RV_DACSR_DBCM_64;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(codec->dev, "Unsupported bclk ratio (%d)\n", ret);
+		goto exit;
+	}
+
+	ret = snd_soc_update_bits(codec, R_DACSR, RM_DACSR_DBCM, value);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set DAC BCLK ratio (%d)\n", ret);
+		goto exit;
+	}
+	ret = snd_soc_update_bits(codec, R_ADCSR, RM_ADCSR_ABCM, value);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set ADC BCLK ratio (%d)\n", ret);
+		goto exit;
+	}
+
+	tscs42xx->bclk_ratio = ratio;
+
+	ret = 0;
+exit:
+	mutex_unlock(&tscs42xx->lock);
+
+	return ret;
+}
+
+static const struct snd_soc_dai_ops tscs42xx_dai_ops = {
+	.hw_params	= tscs42xx_hw_params,
+	.mute_stream	= tscs42xx_mute_stream,
+	.set_fmt	= tscs42xx_set_dai_fmt,
+	.set_bclk_ratio = tscs42xx_set_bclk_ratio,
+};
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
+};
+
+static int tscs42xx_i2c_read(struct i2c_client *i2c, u8 reg, u8 *val)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte(i2c, reg);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "I2C write failed (%d)\n", ret);
+		return ret;
+	}
+
+	ret = i2c_smbus_read_byte(i2c);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "I2C read failed (%d)\n", ret);
+		return ret;
+	}
+
+	*val = (u8)ret;
+
+	return 0;
+}
+
+static int part_is_valid(struct i2c_client *i2c)
+{
+	int val;
+	int ret;
+	u8 reg;
+
+	ret = tscs42xx_i2c_read(i2c, R_DEVIDH, &reg);
+	if (ret < 0)
+		return ret;
+
+	val = reg << 8;
+	ret = tscs42xx_i2c_read(i2c, R_DEVIDL, &reg);
+	if (ret < 0)
+		return ret;
+
+	val |= reg;
+
+	switch (val) {
+	case 0x4A74:
+	case 0x4A73:
+		ret = true;
+		break;
+	default:
+		ret = false;
+		break;
+	};
+
+	if (ret)
+		dev_info(&i2c->dev, "Found part 0x%04x\n", val);
+	else
+		dev_err(&i2c->dev, "0x%04x is not a valid part\n", val);
+
+	return ret;
+}
+
+static int set_data_from_of(struct i2c_client *i2c,
+		struct tscs42xx_priv *tscs42xx)
+{
+	struct device_node *np = i2c->dev.of_node;
+	const char *mclk_src = NULL;
+	int ret;
+
+	ret = of_property_read_string(np, "mclk-src", &mclk_src);
+	if (ret) {
+		dev_err(&i2c->dev, "mclk-src is needed (%d)\n", ret);
+		return ret;
+	}
+
+	if (!strncmp(mclk_src, "mclk", 4)) {
+		tscs42xx->mclk = devm_clk_get(&i2c->dev, NULL);
+		if (IS_ERR(tscs42xx->mclk)) {
+			dev_info(&i2c->dev, "mclk not present trying again\n");
+			return -EPROBE_DEFER;
+		}
+		tscs42xx->pll_src_clk = PLL_SRC_CLK_MCLK2;
+	} else if (!strncmp(mclk_src, "xtal", 4)) {
+		tscs42xx->pll_src_clk = PLL_SRC_CLK_XTAL;
+	} else {
+		dev_err(&i2c->dev, "mclk-src %s is unsupported\n", mclk_src);
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(np, "mclk-src-freq",
+			&tscs42xx->mclk_src_freq);
+	if (ret) {
+		dev_err(&i2c->dev, "mclk-src-freq not provided (%d)\n", ret);
+		return ret;
+	}
+	if (!get_pll_ctl(tscs42xx->mclk_src_freq)) {
+		dev_err(&i2c->dev, "mclk frequency unsupported\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+/*******************
+ * SYSFS Interface *
+ *******************/
+#define FMODE 0664
+
+/* Control Reg Interface */
+
+struct tempo_control_reg {
+	struct device *dev;
+	struct kobject *dir_kobj;
+	struct kobj_attribute val_kobj_attr;
+	struct kobj_attribute addr_kobj_attr;
+	const char *name;
+	const uint8_t addr;
+};
+
+static ssize_t ctrl_reg_val_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct tempo_control_reg *control_reg =
+		container_of(attr, struct tempo_control_reg, val_kobj_attr);
+	struct tscs42xx_priv *tscs42xx = dev_get_drvdata(control_reg->dev);
+	unsigned int show;
+	int ret = 0;
+
+	ret = regmap_read(tscs42xx->regmap,
+			control_reg->addr,
+			&show);
+	if (ret < 0)
+		return ret;
+
+	ret = sprintf(buf, "0x%02x\n", show);
+
+	return ret;
+}
+
+static ssize_t ctrl_reg_val_store(struct kobject *kobj,
+		struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct tempo_control_reg *control_reg =
+		container_of(attr, struct tempo_control_reg, val_kobj_attr);
+	struct tscs42xx_priv *tscs42xx = dev_get_drvdata(control_reg->dev);
+	unsigned int store;
+	int ret;
+
+	ret = kstrtoint(buf, 0, &store);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(tscs42xx->regmap, control_reg->addr, store);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t ctrl_reg_addr_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct tempo_control_reg *control_reg =
+		container_of(attr, struct tempo_control_reg, addr_kobj_attr);
+
+	return sprintf(buf, "0x%02x\n", control_reg->addr);
+}
+
+#define TEMPO_CONTROL_REG(_name, _addr)				\
+	{							\
+		NULL,						\
+		NULL,						\
+		__ATTR(value, FMODE, ctrl_reg_val_show,		\
+			ctrl_reg_val_store),			\
+		__ATTR(address, FMODE, ctrl_reg_addr_show,	\
+			NULL),					\
+		.name = __stringify(_name),			\
+		.addr = _addr,					\
+	}
+
+static struct tempo_control_reg control_regs[] = {
+	TEMPO_CONTROL_REG(config0, R_CONFIG0),		/* 0x1F */
+	TEMPO_CONTROL_REG(config1, R_CONFIG1),		/* 0x20 */
+	TEMPO_CONTROL_REG(clectl, R_CLECTL),		/* 0x25 */
+	TEMPO_CONTROL_REG(mugain, R_MUGAIN),		/* 0x26 */
+	TEMPO_CONTROL_REG(compth, R_COMPTH),		/* 0x27 */
+	TEMPO_CONTROL_REG(cmprat, R_CMPRAT),		/* 0x28 */
+	TEMPO_CONTROL_REG(catktcl, R_CATKTCL),		/* 0x29 */
+	TEMPO_CONTROL_REG(catktch, R_CATKTCH),		/* 0x2A */
+	TEMPO_CONTROL_REG(creltcl, R_CRELTCL),		/* 0x2B */
+	TEMPO_CONTROL_REG(creltch, R_CRELTCH),		/* 0x2C */
+	TEMPO_CONTROL_REG(limth, R_LIMTH),		/* 0x2D */
+	TEMPO_CONTROL_REG(limtgt, R_LIMTGT),		/* 0x2E */
+	TEMPO_CONTROL_REG(latktcl, R_LATKTCL),		/* 0x2F */
+	TEMPO_CONTROL_REG(latktch, R_LATKTCH),		/* 0x30 */
+	TEMPO_CONTROL_REG(lreltcl, R_LRELTCL),		/* 0x31 */
+	TEMPO_CONTROL_REG(lreltch, R_LRELTCH),		/* 0x32 */
+	TEMPO_CONTROL_REG(expth, R_EXPTH),		/* 0x33 */
+	TEMPO_CONTROL_REG(exprat, R_EXPRAT),		/* 0x34 */
+	TEMPO_CONTROL_REG(xatktcl, R_XATKTCL),		/* 0x35 */
+	TEMPO_CONTROL_REG(xatktch, R_XATKTCH),		/* 0x36 */
+	TEMPO_CONTROL_REG(xreltcl, R_XRELTCL),		/* 0x37 */
+	TEMPO_CONTROL_REG(xreltch, R_XRELTCH),		/* 0x38 */
+	TEMPO_CONTROL_REG(fxctl, R_FXCTL),		/* 0x39 */
+	TEMPO_CONTROL_REG(daccrwrl, R_DACCRWRL),	/* 0x3A */
+	TEMPO_CONTROL_REG(daccrwrm, R_DACCRWRM),	/* 0x3B */
+	TEMPO_CONTROL_REG(daccrwrh, R_DACCRWRH),	/* 0x3C */
+	TEMPO_CONTROL_REG(daccrrdl, R_DACCRRDL),	/* 0x3D */
+	TEMPO_CONTROL_REG(daccrrdm, R_DACCRRDM),	/* 0x3E */
+	TEMPO_CONTROL_REG(daccrrdh, R_DACCRRDH),	/* 0x3F */
+	TEMPO_CONTROL_REG(daccraddr, R_DACCRADDR),	/* 0x40 */
+	TEMPO_CONTROL_REG(dcofsel, R_DCOFSEL),		/* 0x41 */
+	TEMPO_CONTROL_REG(daccrstat, R_DACCRSTAT),	/* 0x8A */
+	TEMPO_CONTROL_REG(dacmbcen, R_DACMBCEN),	/* 0xC7 */
+	TEMPO_CONTROL_REG(dacmbcctl, R_DACMBCCTL),	/* 0xC8 */
+	TEMPO_CONTROL_REG(dacmbcmug1, R_DACMBCMUG1),	/* 0xC9 */
+	TEMPO_CONTROL_REG(dacmbcthr1, R_DACMBCTHR1),	/* 0xCA */
+	TEMPO_CONTROL_REG(dacmbcrat1, R_DACMBCRAT1),	/* 0xCB */
+	TEMPO_CONTROL_REG(dacmbcatk1l, R_DACMBCATK1L),	/* 0xCC */
+	TEMPO_CONTROL_REG(dacmbcatk1h, R_DACMBCATK1H),	/* 0xCD */
+	TEMPO_CONTROL_REG(dacmbcrel1l, R_DACMBCREL1L),	/* 0xCE */
+	TEMPO_CONTROL_REG(dacmbcrel1h, R_DACMBCREL1H),	/* 0xCF */
+	TEMPO_CONTROL_REG(dacmbcmug2, R_DACMBCMUG2),	/* 0xD0 */
+	TEMPO_CONTROL_REG(dacmbcthr2, R_DACMBCTHR2),	/* 0xD1 */
+	TEMPO_CONTROL_REG(dacmbcrat2, R_DACMBCRAT2),	/* 0xD2 */
+	TEMPO_CONTROL_REG(dacmbcatk2l, R_DACMBCATK2L),	/* 0xD3 */
+	TEMPO_CONTROL_REG(dacmbcatk2h, R_DACMBCATK2H),	/* 0xD4 */
+	TEMPO_CONTROL_REG(dacmbcrel2l, R_DACMBCREL2L),	/* 0xD5 */
+	TEMPO_CONTROL_REG(dacmbcrel2h, R_DACMBCREL2H),	/* 0xD6 */
+	TEMPO_CONTROL_REG(dacmbcmug3, R_DACMBCMUG3),	/* 0xD7 */
+	TEMPO_CONTROL_REG(dacmbcthr3, R_DACMBCTHR3),	/* 0xD8 */
+	TEMPO_CONTROL_REG(dacmbcrat3, R_DACMBCRAT3),	/* 0xD9 */
+	TEMPO_CONTROL_REG(dacmbcatk3l, R_DACMBCATK3L),	/* 0xDA */
+	TEMPO_CONTROL_REG(dacmbcatk3h, R_DACMBCATK3H),	/* 0xDB */
+	TEMPO_CONTROL_REG(dacmbcrel3l, R_DACMBCREL3L),	/* 0xDC */
+	TEMPO_CONTROL_REG(dacmbcrel3h, R_DACMBCREL3H),	/* 0xDD */
+};
+
+static ssize_t control_reg_export_store(struct kobject *kobj,
+		struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	int i;
+	int ret;
+	char *nl;
+
+	/* Strip the newline */
+	nl = strchr(buf, '\n');
+	if (nl != NULL)
+		*nl = '\0';
+
+	for (i = 0; i < ARRAY_SIZE(control_regs); i++) {
+		if (strcmp(buf, control_regs[i].name) == 0) {
+
+			if (control_regs[i].dir_kobj)
+				break;
+
+			control_regs[i].dev = kobj_to_dev(kobj->parent);
+			if (!control_regs[i].dev)
+				return -ENODEV;
+			control_regs[i].dir_kobj = kobject_create_and_add(
+				control_regs[i].name, kobj);
+			if (!control_regs[i].dir_kobj)
+				return -ENOMEM;
+			ret = sysfs_create_file(control_regs[i].dir_kobj,
+					&control_regs[i].val_kobj_attr.attr);
+			if (ret < 0)
+				return ret;
+			ret = sysfs_create_file(control_regs[i].dir_kobj,
+					&control_regs[i].addr_kobj_attr.attr);
+			if (ret < 0)
+				return ret;
+
+			return count;
+		}
+	}
+
+	return count;
+}
+
+static ssize_t control_reg_unexport_store(struct kobject *kobj,
+		struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	int i;
+	char *nl;
+
+	/* Strip the newline */
+	nl = strchr(buf, '\n');
+	if (nl != NULL)
+		*nl = '\0';
+
+	for (i = 0; i < ARRAY_SIZE(control_regs); i++) {
+		if (strcmp(buf, control_regs[i].name) == 0) {
+			if (control_regs[i].dir_kobj) {
+				sysfs_remove_file(control_regs[i].dir_kobj,
+					&control_regs[i].val_kobj_attr.attr);
+				sysfs_remove_file(control_regs[i].dir_kobj,
+					&control_regs[i].addr_kobj_attr.attr);
+				kobject_put(control_regs[i].dir_kobj);
+				control_regs[i].dir_kobj = NULL;
+				return count;
+			}
+		}
+	}
+
+	return count;
+}
+
+static struct kobj_attribute control_reg_export =
+	__ATTR(export, 0664, NULL, control_reg_export_store);
+static struct kobj_attribute control_reg_unexport =
+	__ATTR(unexport, 0664, NULL, control_reg_unexport_store);
+
+/* Control Interface */
+
+struct tempo_control {
+	struct device *dev;
+	struct kobj_attribute kobj_attr;
+	uint8_t addr;
+	uint8_t mask;
+	uint8_t shift;
+};
+
+static ssize_t ctrl_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct tempo_control *control =
+		container_of(attr, struct tempo_control, kobj_attr);
+	struct tscs42xx_priv *tscs42xx = dev_get_drvdata(control->dev);
+	unsigned int val, show;
+	int ret;
+
+	ret = regmap_read(tscs42xx->regmap,
+			control->addr,
+			&val);
+	if (ret < 0)
+		return ret;
+	show = (val & control->mask) >> control->shift;
+
+	return sprintf(buf, "0x%02x\n", show);
+}
+
+static ssize_t ctrl_store(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct tempo_control *control =
+		container_of(attr, struct tempo_control, kobj_attr);
+	struct tscs42xx_priv *tscs42xx = dev_get_drvdata(control->dev);
+	unsigned int store;
+	int ret;
+
+	ret = kstrtoint(buf, 0, &store);
+	if (ret < 0)
+		return ret;
+
+	store = store << control->shift;
+	ret = regmap_update_bits(tscs42xx->regmap,
+				control->addr, control->mask, store);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+#define TEMPO_CONTROL(_name, _addr, _mask, _shift)			\
+	{								\
+		NULL,							\
+		__ATTR(_name, FMODE, ctrl_show, ctrl_store),		\
+		.addr = _addr,						\
+		.mask = _mask,						\
+		.shift = _shift,					\
+	}
+
+/* Coefficient Interface */
+
+struct tempo_coefficient {
+	struct device *dev;
+	struct kobj_attribute kobj_attr;
+	uint8_t addr;
+};
+
+static int enable_daccram_access(struct tscs42xx_priv *tscs42xx)
+{
+	struct snd_soc_codec *codec = tscs42xx->codec;
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	int ret;
+
+	/* DAC needs to be powered */
+	ret = snd_soc_dapm_force_enable_pin(dapm, "DAC L");
+	if (ret < 0) {
+		dev_err(codec->dev,
+			"Failed to enable DAC for DACCRAM access (%d)\n", ret);
+		return ret;
+	}
+	ret = snd_soc_dapm_sync(dapm);
+	if (ret < 0) {
+		dev_err(codec->dev,
+			"Failed to sync dapm context (%d)\n", ret);
+		return ret;
+	}
+
+	/* If no one is using the PLL make sure there is a valid rate */
+	if (tscs42xx->pll_users == 0)
+		tscs42xx->samplerate = 48000;
+
+	return power_up_audio_plls(tscs42xx->codec, tscs42xx);
+}
+
+static int disable_daccram_access(struct tscs42xx_priv *tscs42xx)
+{
+	struct snd_soc_codec *codec = tscs42xx->codec;
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	int ret;
+
+	/* DAC needs to be powered */
+	ret = snd_soc_dapm_disable_pin(dapm, "DAC L");
+	if (ret < 0) {
+		dev_err(codec->dev,
+			"Failed to disable DAC after DACCRAM access (%d)\n",
+			ret);
+		return ret;
+	}
+	ret = snd_soc_dapm_sync(dapm);
+	if (ret < 0) {
+		dev_err(codec->dev,
+			"Failed to sync dapm context (%d)\n", ret);
+		return ret;
+	}
+
+	return power_down_audio_plls(tscs42xx->codec, tscs42xx);
+}
+
+static ssize_t cff_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct tempo_coefficient *coefficient =
+			container_of(attr, struct tempo_coefficient, kobj_attr);
+	struct tscs42xx_priv *tscs42xx = dev_get_drvdata(coefficient->dev);
+	unsigned int val, show;
+	int ret;
+
+	mutex_lock(&tscs42xx->lock);
+
+	ret = enable_daccram_access(tscs42xx);
+	if (ret < 0)
+		goto early_exit;
+
+	ret = regmap_write(tscs42xx->regmap,
+			R_DACCRADDR,
+			coefficient->addr);
+	if (ret < 0)
+		goto exit;
+	ret = regmap_read(tscs42xx->regmap,
+			R_DACCRRDL,
+			&val);
+	if (ret < 0)
+		goto exit;
+	show = val;
+	ret = regmap_read(tscs42xx->regmap,
+			R_DACCRRDM,
+			&val);
+	if (ret < 0)
+		goto exit;
+	show |= (val << 8);
+	ret = regmap_read(tscs42xx->regmap,
+			R_DACCRRDH,
+			&val);
+	if (ret < 0)
+		goto exit;
+	show |= (val << 16);
+
+	ret = sprintf(buf, "0x%06x\n", show);
+exit:
+	disable_daccram_access(tscs42xx);
+
+early_exit:
+	mutex_unlock(&tscs42xx->lock);
+
+	return ret;
+}
+
+static ssize_t cff_store(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct tempo_coefficient *coefficient =
+			container_of(attr, struct tempo_coefficient, kobj_attr);
+	struct tscs42xx_priv *tscs42xx = dev_get_drvdata(coefficient->dev);
+	unsigned int val, store;
+	int ret;
+
+	mutex_lock(&tscs42xx->lock);
+
+	ret = enable_daccram_access(tscs42xx);
+	if (ret < 0)
+		goto early_exit;
+
+	ret = kstrtoint(buf, 0, &store);
+	if (ret < 0)
+		goto exit;
+
+	ret = regmap_write(tscs42xx->regmap,
+			R_DACCRADDR,
+			coefficient->addr);
+	if (ret < 0)
+		goto exit;
+	val = store & 0xff;
+	ret = regmap_write(tscs42xx->regmap,
+			R_DACCRWRL,
+			val);
+	if (ret < 0)
+		goto exit;
+	val = (store >> 8) & 0xff;
+	ret = regmap_write(tscs42xx->regmap,
+			R_DACCRWRM,
+			val);
+	if (ret < 0)
+		goto exit;
+	val = (store >> 16) & 0xff;
+	ret = regmap_write(tscs42xx->regmap,
+			R_DACCRWRH,
+			val);
+	if (ret < 0)
+		goto exit;
+
+	ret = count;
+exit:
+	disable_daccram_access(tscs42xx);
+
+early_exit:
+	mutex_unlock(&tscs42xx->lock);
+
+	return ret;
+}
+
+#define TEMPO_COEFFICIENT(_name, _addr)					\
+	{								\
+		NULL,							\
+		__ATTR(_name, FMODE, cff_show, cff_store),		\
+		.addr = _addr,						\
+	}
+
+#define BQC_COUNT 5
+
+struct tempo_biquad {
+	struct tempo_coefficient coefficients[BQC_COUNT];
+};
+
+#define TEMPO_BIQUAD(name, addr)					\
+	{								\
+		.coefficients = {					\
+			TEMPO_COEFFICIENT(name ## _b0, ((addr) + 0)),	\
+			TEMPO_COEFFICIENT(name ## _b1, ((addr) + 1)),	\
+			TEMPO_COEFFICIENT(name ## _b2, ((addr) + 2)),	\
+			TEMPO_COEFFICIENT(name ## _a1, ((addr) + 3)),	\
+			TEMPO_COEFFICIENT(name ## _a2, ((addr) + 4))	\
+		},							\
+	}
+
+static struct tempo_biquad dsp_biquads[] = {
+	/* EQ1 */
+	TEMPO_BIQUAD(eq1_ch0_band1, 0x00),
+	TEMPO_BIQUAD(eq1_ch0_band2, 0x05),
+	TEMPO_BIQUAD(eq1_ch0_band3, 0x0a),
+	TEMPO_BIQUAD(eq1_ch0_band4, 0x0f),
+	TEMPO_BIQUAD(eq1_ch0_band5, 0x14),
+	TEMPO_BIQUAD(eq1_ch0_band6, 0x19),
+	TEMPO_BIQUAD(eq1_ch1_band1, 0x20),
+	TEMPO_BIQUAD(eq1_ch1_band2, 0x25),
+	TEMPO_BIQUAD(eq1_ch1_band3, 0x2a),
+	TEMPO_BIQUAD(eq1_ch1_band4, 0x2f),
+	TEMPO_BIQUAD(eq1_ch1_band5, 0x34),
+	TEMPO_BIQUAD(eq1_ch1_band6, 0x39),
+	/* EQ2 */
+	TEMPO_BIQUAD(eq2_ch0_band1, 0x40),
+	TEMPO_BIQUAD(eq2_ch0_band2, 0x45),
+	TEMPO_BIQUAD(eq2_ch0_band3, 0x4a),
+	TEMPO_BIQUAD(eq2_ch0_band4, 0x4f),
+	TEMPO_BIQUAD(eq2_ch0_band5, 0x54),
+	TEMPO_BIQUAD(eq2_ch0_band6, 0x59),
+	TEMPO_BIQUAD(eq2_ch1_band1, 0x60),
+	TEMPO_BIQUAD(eq2_ch1_band2, 0x65),
+	TEMPO_BIQUAD(eq2_ch1_band3, 0x6a),
+	TEMPO_BIQUAD(eq2_ch1_band4, 0x6f),
+	TEMPO_BIQUAD(eq2_ch1_band5, 0x74),
+	TEMPO_BIQUAD(eq2_ch1_band6, 0x79),
+	/* Bass */
+	TEMPO_BIQUAD(bass_ext1, 0x80),
+	TEMPO_BIQUAD(bass_ext2, 0x85),
+	TEMPO_BIQUAD(bass_lmt, 0x8c),
+	TEMPO_BIQUAD(bass_cto, 0x91),
+	/* Treble */
+	TEMPO_BIQUAD(treb_ext1, 0x97),
+	TEMPO_BIQUAD(treb_ext2, 0x9c),
+	TEMPO_BIQUAD(treb_lmt, 0xa3),
+	TEMPO_BIQUAD(treb_cto, 0xa8),
+	/* Multi Band Compressor */
+	TEMPO_BIQUAD(mbc_1_bq1, 0xb0),
+	TEMPO_BIQUAD(mbc_1_bq2, 0xb5),
+	TEMPO_BIQUAD(mbc_2_bq1, 0xba),
+	TEMPO_BIQUAD(mbc_2_bq2, 0xbf),
+	TEMPO_BIQUAD(mbc_3_bq1, 0xc4),
+	TEMPO_BIQUAD(mbc_3_bq2, 0xc9),
+};
+
+static struct tempo_coefficient gen_coefficients[] = {
+	/* 3D */
+	TEMPO_COEFFICIENT(3d_coef, 0xae),
+	TEMPO_COEFFICIENT(3d_mix, 0xaf),
+	/* EQ1 */
+	TEMPO_COEFFICIENT(eq1_ch0_prescale, 0x1f),
+	TEMPO_COEFFICIENT(eq1_ch1_prescale, 0x3f),
+	/* EQ2 */
+	TEMPO_COEFFICIENT(eq2_ch0_prescale, 0x5f),
+	TEMPO_COEFFICIENT(eq2_ch1_prescale, 0x7f),
+	/* Bass */
+	TEMPO_COEFFICIENT(bass_nlf_m1, 0x8a),
+	TEMPO_COEFFICIENT(bass_nlf_m2, 0x8b),
+	TEMPO_COEFFICIENT(bass_mix, 0x96),
+	/* Treble */
+	TEMPO_COEFFICIENT(treb_nlf_m1, 0xa1),
+	TEMPO_COEFFICIENT(treb_nlf_m2, 0xa2),
+	TEMPO_COEFFICIENT(treb_mix, 0xad),
+};
+
+static struct tempo_control controls[] = {
+	TEMPO_CONTROL(eq1_en, R_CONFIG1,
+			RM_CONFIG1_EQ1_EN, FB_CONFIG1_EQ1_EN),
+
+	TEMPO_CONTROL(eq1_bands_en, R_CONFIG1,
+			RM_CONFIG1_EQ1_BE, FB_CONFIG1_EQ1_BE),
+
+	TEMPO_CONTROL(eq2_en, R_CONFIG1,
+			RM_CONFIG1_EQ2_EN, FB_CONFIG1_EQ2_EN),
+
+	TEMPO_CONTROL(eq2_bands_en, R_CONFIG1,
+			RM_CONFIG1_EQ2_BE, FB_CONFIG1_EQ2_BE),
+
+	TEMPO_CONTROL(cle_level_mode, R_CLECTL,
+			RM_CLECTL_LVL_MODE, FB_CLECTL_LVL_MODE),
+
+	TEMPO_CONTROL(cle_level_detect_window, R_CLECTL,
+			RM_CLECTL_WINDOWSEL, FB_CLECTL_WINDOWSEL),
+
+	TEMPO_CONTROL(exp_en, R_CLECTL, RM_CLECTL_EXP_EN, FB_CLECTL_EXP_EN),
+
+	TEMPO_CONTROL(limit_en, R_CLECTL, RM_CLECTL_LIMIT_EN,
+		FB_CLECTL_LIMIT_EN),
+
+	TEMPO_CONTROL(comp_en, R_CLECTL, RM_CLECTL_COMP_EN, FB_CLECTL_COMP_EN),
+
+	TEMPO_CONTROL(3d_en, R_FXCTL, RM_FXCTL_3DEN, FB_FXCTL_3DEN),
+
+	TEMPO_CONTROL(treb_en, R_FXCTL, RM_FXCTL_TEEN, FB_FXCTL_TEEN),
+
+	TEMPO_CONTROL(treb_nlf_bypass, R_FXCTL, RM_FXCTL_TNLFBYPASS,
+		FB_FXCTL_TNLFBYPASS),
+
+	TEMPO_CONTROL(bass_en, R_FXCTL, RM_FXCTL_BEEN, FB_FXCTL_BEEN),
+
+	TEMPO_CONTROL(bass_nlf_bypass, R_FXCTL, RM_FXCTL_BNLFBYPASS,
+		FB_FXCTL_BNLFBYPASS),
+};
+
+static int create_sysfs_interface(struct kobject *parent_kobj)
+{
+	struct kobject *dsp_kobj;
+	struct kobject *controls_kobj;
+	struct kobject *control_regs_dir_kobj;
+	int i, j;
+	int ret;
+
+	dsp_kobj = kobject_create_and_add("dsp", parent_kobj);
+	if (!dsp_kobj)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(dsp_biquads); i++) {
+		for (j = 0; j < BQC_COUNT; j++) {
+			dsp_biquads[i].coefficients[j].dev =
+				kobj_to_dev(parent_kobj);
+			if (!dsp_biquads[i].coefficients[j].dev)
+				return -ENODEV;
+			ret = sysfs_create_file(dsp_kobj,
+				&dsp_biquads[i].coefficients[j].kobj_attr.attr);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(gen_coefficients); i++) {
+		gen_coefficients[i].dev = kobj_to_dev(parent_kobj);
+		if (!gen_coefficients[i].dev)
+			return -ENODEV;
+		ret = sysfs_create_file(dsp_kobj,
+			&gen_coefficients[i].kobj_attr.attr);
+		if (ret < 0)
+			return ret;
+	}
+
+	controls_kobj = kobject_create_and_add("controls",
+		parent_kobj);
+	if (!controls_kobj)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(controls); i++) {
+		controls[i].dev = kobj_to_dev(parent_kobj);
+		if (!controls[i].dev)
+			return -ENODEV;
+		ret = sysfs_create_file(controls_kobj,
+					&controls[i].kobj_attr.attr);
+		if (ret < 0)
+			return ret;
+	}
+
+	control_regs_dir_kobj = kobject_create_and_add("control_regs",
+							parent_kobj);
+
+	ret = sysfs_create_file(control_regs_dir_kobj,
+				&control_reg_export.attr);
+	if (ret < 0)
+		return ret;
+
+	ret = sysfs_create_file(control_regs_dir_kobj,
+				&control_reg_unexport.attr);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int tscs42xx_probe(struct snd_soc_codec *codec)
+{
+	struct tscs42xx_priv *tscs42xx = snd_soc_codec_get_drvdata(codec);
+	int i;
+	int ret;
+
+	mutex_lock(&tscs42xx->lock);
+
+	ret = create_sysfs_interface(&codec->dev->kobj);
+	if (ret < 0) {
+		dev_info(codec->dev, "Failed to create dsp interface (%d)\n",
+			ret);
+		goto exit;
+	}
+
+	tscs42xx->codec = codec;
+
+	ret = configure_clocks(codec, tscs42xx);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to configure clocks (%d)\n", ret);
+		goto exit;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(r_inits); ++i) {
+		ret = snd_soc_write(codec, r_inits[i].reg, r_inits[i].def);
+		if (ret < 0) {
+			dev_err(codec->dev,
+				"Failed to write codec defaults (%d)\n", ret);
+			goto exit;
+		}
+	}
+
+	/* Power up an interface so the daccram can be accessed */
+	ret = snd_soc_update_bits(codec, R_PWRM2, RM_PWRM2_HPL,
+		RV_PWRM2_HPL_ENABLE);
+	if (ret < 0) {
+		dev_err(codec->dev,
+			"Failed to power up interface (%d)\n", ret);
+		goto exit;
+	}
+
+	/* PLLs also needed to be powered */
+	tscs42xx->samplerate = 48000; /* No valid rate exist yet */
+	ret = power_up_audio_plls(codec, tscs42xx);
+	if (ret < 0) {
+		goto exit;
+		snd_soc_update_bits(codec, R_PWRM2,
+					RM_PWRM2_HPL, RV_PWRM2_HPL_DISABLE);
+	}
+
+	ret = load_dac_coefficient_ram(codec);
+	if (ret < 0) {
+		dev_info(codec->dev, "Failed to load DAC Coefficients (%d)\n",
+			ret);
+		power_down_audio_plls(codec, tscs42xx);
+		snd_soc_update_bits(codec, R_PWRM2,
+					RM_PWRM2_HPL, RV_PWRM2_HPL_DISABLE);
+		goto exit;
+	}
+
+	ret = load_control_regs(codec);
+	if (ret < 0) {
+		dev_info(codec->dev, "Failed to load controls (%d)\n",
+			ret);
+		power_down_audio_plls(codec, tscs42xx);
+		snd_soc_update_bits(codec, R_PWRM2,
+					RM_PWRM2_HPL, RV_PWRM2_HPL_DISABLE);
+		goto exit;
+	}
+
+	power_down_audio_plls(codec, tscs42xx);
+	snd_soc_update_bits(codec, R_PWRM2, RM_PWRM2_HPL, RV_PWRM2_HPL_DISABLE);
+
+	ret = 0;
+exit:
+	mutex_unlock(&tscs42xx->lock);
+
+	return ret;
+}
+
+static int tscs42xx_remove(struct snd_soc_codec *codec)
+{
+	return 0;
+}
+
+static struct snd_soc_codec_driver soc_codec_dev_tscs42xx = {
+	.probe =	tscs42xx_probe,
+	.remove =	tscs42xx_remove,
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
+static int tscs42xx_i2c_probe(struct i2c_client *i2c,
+		const struct i2c_device_id *id)
+{
+	struct tscs42xx_priv *tscs42xx;
+	int ret = 0;
+
+	tscs42xx = devm_kzalloc(&i2c->dev, sizeof(*tscs42xx), GFP_KERNEL);
+	if (!tscs42xx)
+		return -ENOMEM;
+
+	mutex_init(&tscs42xx->lock);
+	mutex_lock(&tscs42xx->lock);
+
+	tscs42xx->pll_users = 0;
+
+	ret = set_data_from_of(i2c, tscs42xx);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Error parsing device tree info (%d)", ret);
+		goto exit;
+	}
+
+	ret = part_is_valid(i2c);
+	if (ret <= 0) {
+		dev_err(&i2c->dev, "No valid part (%d)\n", ret);
+		ret = -ENODEV;
+		goto exit;
+	}
+
+	/* Reset device */
+	ret = i2c_smbus_write_byte_data(i2c, R_RESET,
+			RV_RESET_ENABLE);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to reset device (%d)\n", ret);
+		goto exit;
+	}
+
+	tscs42xx->regmap = devm_regmap_init_i2c(i2c, &tscs42xx_regmap);
+	if (IS_ERR(tscs42xx->regmap)) {
+		ret = PTR_ERR(tscs42xx->regmap);
+		dev_err(&i2c->dev, "Failed to allocat regmap (%d)\n", ret);
+		goto exit;
+	}
+
+	i2c_set_clientdata(i2c, tscs42xx);
+
+	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_tscs42xx,
+			&tscs42xx_dai, 1);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to register codec (%d)\n", ret);
+		goto exit;
+	}
+
+	ret = 0;
+exit:
+	mutex_unlock(&tscs42xx->lock);
+
+	return ret;
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
+	{ "tscs42xx", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tscs42xx_i2c_id);
+
+static const struct of_device_id tscs42xx_of_match[] = {
+	{ .compatible = "tscs,tscs42xx", },
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
+static int __init tscs42xx_modinit(void)
+{
+	int ret = 0;
+
+	ret = i2c_add_driver(&tscs42xx_i2c_driver);
+	if (ret < 0)
+		pr_err("Failed to register TSCS42xx I2C driver (%d)\n", ret);
+
+	return ret;
+}
+module_init(tscs42xx_modinit);
+
+static void __exit tscs42xx_exit(void)
+{
+	i2c_del_driver(&tscs42xx_i2c_driver);
+}
+module_exit(tscs42xx_exit);
+
+MODULE_AUTHOR("Tempo Semiconductor <steven.eckhoff.opensource@gmail.com");
+MODULE_DESCRIPTION("ASoC TSCS42xx driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/tscs42xx.h b/sound/soc/codecs/tscs42xx.h
new file mode 100644
index 000000000000..e38ff8c7b6c9
--- /dev/null
+++ b/sound/soc/codecs/tscs42xx.h
@@ -0,0 +1,2693 @@
+/*
+ * tscs42xx.c -- TSCS42xx ALSA SoC Audio driver
+ *
+ * Copyright 2017 Tempo Semiconductor, Inc.
+ *
+ * Author: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __WOOKIE_H__
+#define __WOOKIE_H__
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
