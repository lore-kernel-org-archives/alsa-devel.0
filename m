From: Julian Scheel <julian@jusst.de>
Subject: [PATCH] ASoC: Add pcm9211 driver
Date: Tue, 23 May 2017 11:09:31 +0200
Message-ID: <20170523090931.9697-1-julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web01.jusst.de (jusst.de [188.40.114.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B967266A65
 for <alsa-devel@alsa-project.org>; Tue, 23 May 2017 11:09:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, broonie@kernel.org, lars@metafoo.de, ckeepax@opensource.wolfsonmicro.com
Cc: Julian Scheel <julian@jusst.de>
List-Id: alsa-devel@alsa-project.org

This adds a driver for the TI PCM9211 digital audio interfaces
transceiver. The driver currently only handles the receiver aspect of
the chip and supports only control of the primary I2S (MAIN) output
port. Support for AUX output is trivial to add, but wasn't done due to
missing hardware for testing. The same goes for the transmitter
functionality.
The driver uses some extra device-tree fields to allow configuration of
pin functions directly out of this driver.

Signed-off-by: Julian Scheel <julian@jusst.de>
---
 .../devicetree/bindings/sound/pcm9211.txt          |  118 ++
 MAINTAINERS                                        |    6 +
 include/dt-bindings/sound/pcm9211.h                |   55 +
 sound/soc/codecs/Kconfig                           |   10 +
 sound/soc/codecs/Makefile                          |    4 +
 sound/soc/codecs/pcm9211-i2c.c                     |   65 +
 sound/soc/codecs/pcm9211.c                         | 1357 ++++++++++++++++++++
 sound/soc/codecs/pcm9211.h                         |  206 +++
 8 files changed, 1821 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/pcm9211.txt
 create mode 100644 include/dt-bindings/sound/pcm9211.h
 create mode 100644 sound/soc/codecs/pcm9211-i2c.c
 create mode 100644 sound/soc/codecs/pcm9211.c
 create mode 100644 sound/soc/codecs/pcm9211.h

diff --git a/Documentation/devicetree/bindings/sound/pcm9211.txt b/Documentation/devicetree/bindings/sound/pcm9211.txt
new file mode 100644
index 000000000000..bfc29889caf6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/pcm9211.txt
@@ -0,0 +1,118 @@
+PCM9211 audio CODEC
+
+This device support both I2C and SPI (configured with pin strapping
+on the board). The driver is currently implementing i2c only.
+
+Required properties:
+
+  - compatible : "ti,pcm9211"
+
+  - reg : the I2C address of the device for I2C, the chip select
+          number for SPI.
+
+  - VCCAD-supply, VCC-supply, VDDRX-supply and AVDD-supply :
+   power supplies for the device, as covered in bindings/regulator/regulator.txt
+
+Optional properties:
+
+  - clocks : A clock specifier for the clock connected to XTI. While the
+    device could work without it, this driver currently relies on it being
+    available
+
+  - clock-names : Must speficy "xti" to match the requested clock.
+
+  - reset-gpios : GPIO wired to the reset pin, if not supplied a soft-reset is
+    used as fallback
+
+  - int0-gpios : GPIO connected to interrupt0 output of the PCM9211. The
+    line can be configured to any of MPO0,1 and MPIOA,B,C0-4 and error/int0.
+    If this is specified it is used as an interrupt to notify alsa controls
+    about changes of the incoming sampling rate on DIR (spdif) as well as NPCM
+    status.
+
+  - ti,group-function: An array with size 3 specifying function for pingroups
+    A, B and C.  Possible values are defined in dt-bindings/sound/pcm9211.h
+
+  - ti,mpio-a-flags-gpio: An array with size 4 specifying flags out or gpio
+    mode per pin, when function DIR_FLAGS_GPIO is selected for group a.
+    Possible values are defined in dt-bindings/sound/pcm9211.h
+
+  - ti,mpio-b-flags-gpio: An array with size 4 specifying flags out or gpio
+    mode per pin, when function DIR_FLAGS_GPIO is selected for group b.
+    Possible values are defined in dt-bindings/sound/pcm9211.h
+
+  - ti,mpio-c-flags-gpio: An array with size 4 specifying flags out or gpio
+    mode per pin, when function DIR_FLAGS_GPIO is selected for group c.
+    Possible values are defined in dt-bindings/sound/pcm9211.h
+
+  - ti,mpio-a-flag: An array with size 4 specifying flag assinged per pin,
+    when function DIR_FLAGS_GPIO is selected for group a and pin is set to
+    flags mode.
+    Possible values are defined in dt-bindings/sound/pcm9211.h
+
+  - ti,mpio-b-flag: An array with size 4 specifying flag assinged per pin,
+    when function DIR_FLAGS_GPIO is selected for group b and pin is set to
+    flags mode.
+    Possible values are defined in dt-bindings/sound/pcm9211.h
+
+  - ti,mpio-c-flag: An array with size 4 specifying flag assinged per pin,
+    when function DIR_FLAGS_GPIO is selected for group c and pin is set to
+    flags mode.
+    Possible values are defined in dt-bindings/sound/pcm9211.h
+
+  - ti,mpo-function: An array with size 2 specifying flag assinged per mpo
+    pin.
+    Possible values are defined in dt-bindings/sound/pcm9211.h
+
+  - ti,int0-function: Selects error/int0 pin function.
+    Possible values are defined in dt-bindings/sound/pcm9211.h
+
+  - ti,int1-function: Selects error/int1 pin function.
+    Possible values are defined in dt-bindings/sound/pcm9211.h
+
+Examples:
+
+	pcm9211: pcm9211@43 {
+		compatible = "ti,pcm9211";
+		reg = <0x43>;
+
+		VCCAD-supply = <&reg_5v0_analog>;
+		VCC-supply = <&reg_3v3_pll_analog>;
+		VDDRX-supply = <&reg_3v3>;
+		DVDD-supply = <&reg_3v3>;
+
+		clocks = <&xti_clk>;
+		clock-names = "xti";
+	};
+
+
+	pcm9211: pcm9211@43 {
+		compatible = "ti,pcm9211";
+		reg = <0x43>;
+
+		VCCAD-supply = <&reg_5v0_analog>;
+		VCC-supply = <&reg_3v3_pll_analog>;
+		VDDRX-supply = <&reg_3v3>;
+		DVDD-supply = <&reg_3v3>;
+
+		clocks = <&xti_clk>;
+		clock-names = "xti";
+
+		reset-gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
+		int-gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
+
+		ti,group-function = /bits/ 8
+			<PCM9211_MPIO_A_GROUP_BIPHASE_INPUT,
+			PCM9211_MPIO_B_GROUP_DIR_FLAGS_GPIO,
+			PCM9211_MPIO_C_GROUP_AUXIN1>;
+		ti,mpio-b-flags-gpio = /bits/ 8
+			<PCM9211_MPIO_DIR_FLAGS,
+			PCM9211_MPIO_DIR_FLAGS,
+			PCM9211_MPIO_DIR_FLAGS,
+			PCM9211_MPIO_DIR_FLAGS>;
+		ti,mpio-b-flag = /bits/ 8
+			<PCM9211_MPIO_FLAG_INT0,
+			PCM9211_MPIO_FLAG_CLKST,
+			PCM9211_MPIO_FLAG_CLKST,
+			PCM9211_MPIO_FLAG_CLKST>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index c2ffc96ccf4c..1f3b2e98dd9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9985,6 +9985,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/pci/pci-thunder-*
 F:	drivers/pci/host/pci-thunder-*
 
+PCM9211 AUDIO CODEC DRIVER
+M:	Julian Scheel <julian@jusst.de>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	sound/soc/codecs/pcm9211*
+
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
 L:	linux-pcmcia@lists.infradead.org
diff --git a/include/dt-bindings/sound/pcm9211.h b/include/dt-bindings/sound/pcm9211.h
new file mode 100644
index 000000000000..6d1367f21d25
--- /dev/null
+++ b/include/dt-bindings/sound/pcm9211.h
@@ -0,0 +1,55 @@
+#ifndef __DT_PCM9211_H
+#define __DT_PCM9211_H
+
+/* INT0/ERROR select */
+#define PCM9211_ERROR_INT0_ERROR			0
+#define PCM9211_ERROR_INT0_INT0				1
+
+/* INT1/NPCM select */
+#define PCM9211_NPCM_INT1_NPCM				0
+#define PCM9211_NPCM_INT1_INT1				1
+
+/* MPIO group functions */
+#define PCM9211_MPIO_A_GROUP_BIPHASE_INPUT		0
+#define PCM9211_MPIO_A_GROUP_CLKST_VOUT_XMCK_INT0	1
+#define PCM9211_MPIO_A_GROUP_SEC_BCK_LRCK_XMCKO_INT0	2
+#define PCM9211_MPIO_A_GROUP_DIR_FLAGS_GPIO		3
+
+#define PCM9211_MPIO_B_GROUP_AUXIN2			0
+#define PCM9211_MPIO_B_GROUP_AUXOUT			1
+#define PCM9211_MPIO_B_GROUP_SAMPLING_FREQ_RES		2
+#define PCM9211_MPIO_B_GROUP_DIR_FLAGS_GPIO		3
+#define PCM9211_MPIO_B_GROUP_DIR_BCUV_BFRAME_VUC	4
+#define PCM9211_MPIO_B_GROUP_EXT_ADC_IN			5
+#define PCM9211_MPIO_B_GROUP_TEST_MODE			7
+
+#define PCM9211_MPIO_C_GROUP_AUXIN1			0
+#define PCM9211_MPIO_C_GROUP_ADC_CLOCK_DATA		1
+#define PCM9211_MPIO_C_GROUP_SAMPLING_FREQ_RES		2
+#define PCM9211_MPIO_C_GROUP_DIR_FLAGS_GPIO		3
+#define PCM9211_MPIO_C_GROUP_DIR_BCUV_BFRAME_VUC	4
+#define PCM9211_MPIO_C_GROUP_DIT_CLOCK_DATA		5
+
+/* MPIO flags/gpio select */
+#define PCM9211_MPIO_DIR_FLAGS				0
+#define PCM9211_MPIO_GPIO				1
+
+/* MPIO flags */
+#define PCM9211_MPIO_FLAG_CLKST				0
+#define PCM9211_MPIO_FLAG_EMPH				1
+#define PCM9211_MPIO_FLAG_BPSYNC			2
+#define PCM9211_MPIO_FLAG_DTSCD				3
+#define PCM9211_MPIO_FLAG_PARITY			4
+#define PCM9211_MPIO_FLAG_LOCK				5
+#define PCM9211_MPIO_FLAG_VOUT				6
+#define PCM9211_MPIO_FLAG_UOUT				7
+#define PCM9211_MPIO_FLAG_COUT				8
+#define PCM9211_MPIO_FLAG_BFRAME			9
+#define PCM9211_MPIO_FLAG_FSOUT0			10
+#define PCM9211_MPIO_FLAG_FSOUT1			11
+#define PCM9211_MPIO_FLAG_FSOUT2			12
+#define PCM9211_MPIO_FLAG_FSOUT3			13
+#define PCM9211_MPIO_FLAG_INT0				14
+#define PCM9211_MPIO_FLAG_INT1				15
+
+#endif
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 883ed4c8a551..d7cf85ba020f 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -113,6 +113,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_PCM5102A
 	select SND_SOC_PCM512x_I2C if I2C
 	select SND_SOC_PCM512x_SPI if SPI_MASTER
+	select SND_SOC_PCM9211_I2C if I2C
 	select SND_SOC_RT286 if I2C
 	select SND_SOC_RT298 if I2C
 	select SND_SOC_RT5514 if I2C
@@ -684,6 +685,15 @@ config SND_SOC_PCM512x_SPI
 	select SND_SOC_PCM512x
 	select REGMAP_SPI
 
+config SND_SOC_PCM9211
+	tristate
+
+config SND_SOC_PCM9211_I2C
+	tristate "Texas Instruments PCM9211 CODEC - I2C"
+	depends on I2C
+	select SND_SOC_PCM9211
+	select REGMAP_I2C
+
 config SND_SOC_RL6231
 	tristate
 	default y if SND_SOC_RT5514=y
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 28a63fdaf982..a8eecee5fcfc 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -110,6 +110,8 @@ snd-soc-pcm5102a-objs := pcm5102a.o
 snd-soc-pcm512x-objs := pcm512x.o
 snd-soc-pcm512x-i2c-objs := pcm512x-i2c.o
 snd-soc-pcm512x-spi-objs := pcm512x-spi.o
+snd-soc-pcm9211-objs := pcm9211.o
+snd-soc-pcm9211-i2c-objs := pcm9211-i2c.o
 snd-soc-rl6231-objs := rl6231.o
 snd-soc-rl6347a-objs := rl6347a.o
 snd-soc-rt286-objs := rt286.o
@@ -344,6 +346,8 @@ obj-$(CONFIG_SND_SOC_PCM5102A)	+= snd-soc-pcm5102a.o
 obj-$(CONFIG_SND_SOC_PCM512x)	+= snd-soc-pcm512x.o
 obj-$(CONFIG_SND_SOC_PCM512x_I2C)	+= snd-soc-pcm512x-i2c.o
 obj-$(CONFIG_SND_SOC_PCM512x_SPI)	+= snd-soc-pcm512x-spi.o
+obj-$(CONFIG_SND_SOC_PCM9211)	+= snd-soc-pcm9211.o
+obj-$(CONFIG_SND_SOC_PCM9211_I2C)	+= snd-soc-pcm9211-i2c.o
 obj-$(CONFIG_SND_SOC_RL6231)	+= snd-soc-rl6231.o
 obj-$(CONFIG_SND_SOC_RL6347A)	+= snd-soc-rl6347a.o
 obj-$(CONFIG_SND_SOC_RT286)	+= snd-soc-rt286.o
diff --git a/sound/soc/codecs/pcm9211-i2c.c b/sound/soc/codecs/pcm9211-i2c.c
new file mode 100644
index 000000000000..e0678b280f11
--- /dev/null
+++ b/sound/soc/codecs/pcm9211-i2c.c
@@ -0,0 +1,65 @@
+/*
+ * PCM9211 codec i2c driver
+ *
+ * Copyright (C) 2017 jusst technologies GmbH / jusst.engineering
+ *
+ * Author: Julian Scheel <julian@jusst.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+
+#include <sound/soc.h>
+
+#include "pcm9211.h"
+
+static int pcm9211_i2c_probe(struct i2c_client *i2c,
+		const struct i2c_device_id *id)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(i2c, &pcm9211_regmap);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return pcm9211_probe(&i2c->dev, regmap);
+}
+
+static int pcm9211_i2c_remove(struct i2c_client *i2c)
+{
+	pcm9211_remove(&i2c->dev);
+
+	return 0;
+}
+
+static const struct i2c_device_id pcm9211_i2c_id[] = {
+	{ "pcm9211", },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pcm9211_i2c_id);
+
+static const struct of_device_id pcm9211_of_match[] = {
+	{ .compatible = "ti,pcm9211", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pcm9211_of_match);
+
+static struct i2c_driver pcm9211_i2c_driver = {
+	.probe = pcm9211_i2c_probe,
+	.remove = pcm9211_i2c_remove,
+	.id_table = pcm9211_i2c_id,
+	.driver = {
+		.name = "pcm9211",
+		.of_match_table = pcm9211_of_match,
+		.pm = &pcm9211_pm_ops,
+	},
+};
+module_i2c_driver(pcm9211_i2c_driver);
+
+MODULE_DESCRIPTION("PCM9211 I2C codec driver");
+MODULE_AUTHOR("Julian Scheel <julian@jusst.de>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/pcm9211.c b/sound/soc/codecs/pcm9211.c
new file mode 100644
index 000000000000..0ab4ad551df8
--- /dev/null
+++ b/sound/soc/codecs/pcm9211.c
@@ -0,0 +1,1357 @@
+/*
+ * PCM9211 codec driver
+ *
+ * Copyright (C) 2017 jusst technologies GmbH / jusst.engineering
+ *
+ * Author; Julian Scheel <julian@jusst.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/regulator/consumer.h>
+#include <linux/gpio/consumer.h>
+#include <linux/pm_runtime.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+
+#include <sound/control.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#include "pcm9211.h"
+
+#define PCM9211_MAX_SYSCLK 24576000
+
+#define PCM9211_SUPPLIES 4
+static const char *const pcm9211_supply_names[PCM9211_SUPPLIES] = {
+	"VCCAD",
+	"VCC",
+	"VDDRX",
+	"DVDD",
+};
+
+struct pcm9211_priv {
+	struct regulator_bulk_data supplies[PCM9211_SUPPLIES];
+	struct snd_pcm_hw_constraint_list rate_constraints;
+	struct delayed_work npcm_clear_work;
+	struct snd_kcontrol *preamble_ctl;
+	struct snd_kcontrol *npcm_ctl;
+	struct snd_kcontrol *rate_ctl;
+	struct snd_kcontrol *dts_ctl;
+	struct snd_soc_codec *codec;
+	struct gpio_desc *reset;
+	struct gpio_desc *int0;
+	struct regmap *regmap;
+	struct device *dev;
+	struct clk *xti;
+
+	unsigned int dir_rate;
+	unsigned long sysclk;
+	u8 burst_preamble[4];
+	u8 npcm_state;
+};
+
+static const struct regmap_range pcm9211_reg_rd_range[] = {
+	regmap_reg_range(PCM9211_ERR_OUT, PCM9211_PD_BUF1),
+	regmap_reg_range(PCM9211_SYS_RESET, PCM9211_SYS_RESET),
+	regmap_reg_range(PCM9211_ADC_CTRL1, PCM9211_ADC_CTRL1),
+	regmap_reg_range(PCM9211_ADC_L_CH_ATT, PCM9211_ADC_CTRL3),
+	regmap_reg_range(PCM9211_DIR_STATUS1, PCM9211_DIT_STATUS6),
+	regmap_reg_range(PCM9211_MAIN_AUX_MUTE, PCM9211_MPIO_C_DATA_IN),
+};
+
+static const struct regmap_access_table pcm9211_reg_rd_table = {
+	.yes_ranges = pcm9211_reg_rd_range,
+	.n_yes_ranges = ARRAY_SIZE(pcm9211_reg_rd_range),
+};
+
+static const struct regmap_range pcm9211_reg_wr_range[] = {
+	regmap_reg_range(PCM9211_ERR_OUT, PCM9211_INT1_CAUSE),
+	regmap_reg_range(PCM9211_INT_POLARITY, PCM9211_FS_CALC_TARGET),
+	regmap_reg_range(PCM9211_SYS_RESET, PCM9211_SYS_RESET),
+	regmap_reg_range(PCM9211_ADC_CTRL1, PCM9211_ADC_CTRL1),
+	regmap_reg_range(PCM9211_ADC_L_CH_ATT, PCM9211_ADC_CTRL3),
+	regmap_reg_range(PCM9211_DIT_CTRL1, PCM9211_DIT_STATUS6),
+	regmap_reg_range(PCM9211_MAIN_AUX_MUTE, PCM9211_MPIO_C_DATA_OUT),
+};
+
+static const struct regmap_access_table pcm9211_reg_wr_table = {
+	.yes_ranges = pcm9211_reg_wr_range,
+	.n_yes_ranges = ARRAY_SIZE(pcm9211_reg_wr_range),
+};
+
+static const struct regmap_range pcm9211_reg_volatile_range[] = {
+	regmap_reg_range(PCM9211_INT0_OUT, PCM9211_INT1_OUT),
+	regmap_reg_range(PCM9211_BIPHASE_INFO, PCM9211_PD_BUF1),
+	regmap_reg_range(PCM9211_DIR_STATUS1, PCM9211_DIR_STATUS6),
+};
+
+static const struct regmap_access_table pcm9211_reg_volatile_table = {
+	.yes_ranges = pcm9211_reg_volatile_range,
+	.n_yes_ranges = ARRAY_SIZE(pcm9211_reg_volatile_range),
+};
+
+static const struct reg_default pcm9211_reg_defaults[] = {
+	{ PCM9211_ERR_OUT, 0x00 },
+	{ PCM9211_DIR_INITIAL1, 0x00 },
+	{ PCM9211_DIR_INITIAL2, 0x01 },
+	{ PCM9211_DIR_INITIAL3, 0x04 },
+	{ PCM9211_OSC_CTRL, 0x00 },
+	{ PCM9211_ERR_CAUSE, 0x01 },
+	{ PCM9211_AUTO_SEL_CAUSE, 0x01 },
+	{ PCM9211_DIR_FS_RANGE, 0x00 },
+	{ PCM9211_NON_PCM_DEF, 0x03 },
+	{ PCM9211_DTS_CD_LD, 0x0c },
+	{ PCM9211_INT0_CAUSE, 0xff },
+	{ PCM9211_INT1_CAUSE, 0xff },
+	{ PCM9211_INT0_OUT, 0x00 },
+	{ PCM9211_INT1_OUT, 0x00 },
+	{ PCM9211_INT_POLARITY, 0x00 },
+	{ PCM9211_DIR_OUT_FMT, 0x04 },
+	{ PCM9211_DIR_RSCLK_RATIO, 0x02 },
+	{ PCM9211_XTI_SCLK_FREQ, 0x1a },
+	{ PCM9211_DIR_SOURCE_BIT2, 0x22 },
+	{ PCM9211_XTI_SOURCE_BIT2, 0x22 },
+	{ PCM9211_DIR_INP_BIPHASE, 0xc2 },
+	{ PCM9211_RECOUT0_BIPHASE, 0x02 },
+	{ PCM9211_RECOUT1_BIPHASE, 0x02 },
+	{ PCM9211_FS_CALC_TARGET, 0x00 },
+	{ PCM9211_FS_CALC_RESULT, 0x08 },
+	{ PCM9211_BIPHASE_INFO, 0x08 },
+	{ PCM9211_PC_BUF0, 0x01 },
+	{ PCM9211_PC_BUF1, 0x00 },
+	{ PCM9211_PD_BUF0, 0x20 },
+	{ PCM9211_PD_BUF1, 0x57 },
+	{ PCM9211_SYS_RESET, 0x40 },
+	{ PCM9211_ADC_CTRL1, 0x02 },
+	{ PCM9211_ADC_L_CH_ATT, 0xd7 },
+	{ PCM9211_ADC_R_CH_ATT, 0xd7 },
+	{ PCM9211_ADC_CTRL2, 0x00 },
+	{ PCM9211_ADC_CTRL3, 0x00 },
+	{ PCM9211_DIR_STATUS1, 0x04 },
+	{ PCM9211_DIR_STATUS2, 0x00 },
+	{ PCM9211_DIR_STATUS3, 0x00 },
+	{ PCM9211_DIR_STATUS4, 0x00 },
+	{ PCM9211_DIR_STATUS5, 0x00 },
+	{ PCM9211_DIR_STATUS6, 0x00 },
+	{ PCM9211_DIT_CTRL1, 0x44 },
+	{ PCM9211_DIT_CTRL2, 0x10 },
+	{ PCM9211_DIT_CTRL3, 0x00 },
+	{ PCM9211_DIT_STATUS1, 0x00 },
+	{ PCM9211_DIT_STATUS2, 0x00 },
+	{ PCM9211_DIT_STATUS3, 0x00 },
+	{ PCM9211_DIT_STATUS4, 0x00 },
+	{ PCM9211_DIT_STATUS5, 0x00 },
+	{ PCM9211_DIT_STATUS6, 0x00 },
+	{ PCM9211_MAIN_AUX_MUTE, 0x00 },
+	{ PCM9211_MAIN_OUT_SOURCE, 0x00 },
+	{ PCM9211_AUX_OUT_SOURCE, 0x00 },
+	{ PCM9211_MPIO_B_MAIN_HIZ, 0x00 },
+	{ PCM9211_MPIO_C_MPIO_A_HIZ, 0x0f },
+	{ PCM9211_MPIO_GROUP, 0x40 },
+	{ PCM9211_MPIO_A_FLAGS, 0x00 },
+	{ PCM9211_MPIO_B_MPIO_C_FLAGS, 0x00 },
+	{ PCM9211_MPIO_A1_A0_OUT_FLAG, 0x00 },
+	{ PCM9211_MPIO_A3_A2_OUT_FLAG, 0x00 },
+	{ PCM9211_MPIO_B1_B0_OUT_FLAG, 0x00 },
+	{ PCM9211_MPIO_B3_B2_OUT_FLAG, 0x00 },
+	{ PCM9211_MPIO_C1_C0_OUT_FLAG, 0x00 },
+	{ PCM9211_MPIO_C3_C2_OUT_FLAG, 0x00 },
+	{ PCM9211_MPO_1_0_FUNC, 0x3d },
+	{ PCM9211_MPIO_A_B_DIR, 0x00 },
+	{ PCM9211_MPIO_C_DIR, 0x00 },
+	{ PCM9211_MPIO_A_B_DATA_OUT, 0x00 },
+	{ PCM9211_MPIO_C_DATA_OUT, 0x00 },
+	{ PCM9211_MPIO_A_B_DATA_IN, 0x00 },
+	{ PCM9211_MPIO_C_DATA_IN, 0x02 },
+};
+
+const struct regmap_config pcm9211_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = PCM9211_MPIO_C_DATA_IN,
+	.wr_table = &pcm9211_reg_wr_table,
+	.rd_table = &pcm9211_reg_rd_table,
+	.volatile_table = &pcm9211_reg_volatile_table,
+	.reg_defaults = pcm9211_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(pcm9211_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+};
+EXPORT_SYMBOL_GPL(pcm9211_regmap);
+
+static const u32 adc_rates[] = { 48000, 92000 };
+static const struct snd_pcm_hw_constraint_list adc_rate_constraints = {
+	.count = ARRAY_SIZE(adc_rates),
+	.list = adc_rates,
+};
+
+static const int biphase_rates[] = {
+	0, 8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100,
+	48000, 64000, 88200, 96000, 128000, 176400, 192000
+};
+
+static const unsigned int pcm9211_sck_ratios[] = { 1, 2, 4, 8 };
+static const unsigned int pcm9211_bck_ratios[] = { 2, 4, 8, 16 };
+static const unsigned int pcm9211_lrck_ratios[] = { 128, 256, 512, 1024 };
+#define PCM9211_NUM_SCK_RATIOS ARRAY_SIZE(pcm9211_sck_ratios)
+#define PCM9211_NUM_BCK_RATIOS ARRAY_SIZE(pcm9211_bck_ratios)
+#define PCM9211_NUM_LRCK_RATIOS ARRAY_SIZE(pcm9211_lrck_ratios)
+
+static int pcm9211_main_output_port(struct device *dev)
+{
+	struct pcm9211_priv *priv = dev_get_drvdata(dev);
+	unsigned int val;
+	unsigned int port;
+	int ret;
+
+	ret = regmap_read(priv->regmap, PCM9211_MAIN_OUT_SOURCE, &val);
+	if (ret) {
+		dev_err(dev, "Failed to read selected source: %d\n", ret);
+		return ret;
+	}
+
+	port = (val & PCM9211_MOPSRC_MASK) >> PCM9211_MOPSRC_SHIFT;
+	if (port == PCM9211_MOSRC_AUTO) {
+		ret = regmap_read(priv->regmap, PCM9211_BIPHASE_INFO, &val);
+		if (ret) {
+			dev_err(dev, "Failed to read biphase information: %d\n",
+					ret);
+			return ret;
+		}
+
+		/* Assumes that Sampling Frequency Status calculation
+		 * corresponds with DIR Lock, which seems to to be exposed to
+		 * any register directly
+		 */
+		if ((val & PCM9211_BIPHASE_SFSST_MASK) == 0)
+			port = PCM9211_MOSRC_DIR;
+		else
+			port = PCM9211_MOSRC_ADC;
+	}
+
+	return port;
+}
+
+static int pcm9211_dir_rate(struct device *dev)
+{
+	struct pcm9211_priv *priv = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(priv->regmap, PCM9211_BIPHASE_INFO, &val);
+	if (ret) {
+		dev_err(dev, "Failed to read biphase information: %d\n", ret);
+		return ret;
+	}
+
+	if ((val & PCM9211_BIPHASE_SFSST_MASK)) {
+		dev_dbg(dev, "Biphase Fs calculation not locked\n");
+		return 0;
+	}
+
+	return biphase_rates[(val & PCM9211_BIPHASE_SFSOUT_MASK)
+		>> PCM9211_BIPHASE_SFSOUT_SHIFT];
+}
+
+static int pcm9211_read_burst_preamble(struct device *dev)
+{
+	struct pcm9211_priv *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regmap_raw_read(priv->regmap, PCM9211_PC_BUF0,
+			priv->burst_preamble, 4);
+	if (ret) {
+		dev_err(dev, "Failed to read burst preamble: %d\n", ret);
+		return ret;
+	}
+
+	dev_dbg(dev, "Burst preamble: 0x%02x 0x%02x 0x%02x 0x%02x\n",
+			priv->burst_preamble[0], priv->burst_preamble[1],
+			priv->burst_preamble[2], priv->burst_preamble[3]);
+
+	return 0;
+}
+
+static int pcm9211_dir_rate_kctl_info(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 8000;
+	uinfo->value.integer.min = 96000;
+
+	return 0;
+}
+
+static int pcm9211_dir_rate_kctl(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct pcm9211_priv *priv = snd_soc_component_get_drvdata(component);
+	struct device *dev = priv->dev;
+
+	/* If we have an interrupt connected dir_rate is up-to-date */
+	if (!priv->int0)
+		priv->dir_rate = pcm9211_dir_rate(dev);
+
+	ucontrol->value.integer.value[0] = priv->dir_rate;
+
+	return 0;
+}
+
+#define pcm9211_dir_npcm_kctl_info snd_ctl_boolean_mono_info
+#define pcm9211_dir_npcm_kctl pcm9211_int0_kctl
+
+#define pcm9211_dir_dtscd_kctl_info snd_ctl_boolean_mono_info
+#define pcm9211_dir_dtscd_kctl pcm9211_int0_kctl
+
+static int pcm9211_int0_kctl(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct pcm9211_priv *priv = snd_soc_component_get_drvdata(component);
+	u8 mask = kcontrol->private_value & 0xff;
+	struct device *dev = priv->dev;
+	unsigned int cause;
+	int ret;
+
+	/* If interrupt line is not connected read the last interrupt state */
+	if (!priv->int0) {
+		ret = regmap_read(priv->regmap, PCM9211_INT0_OUT, &cause);
+		if (ret) {
+			dev_err(dev, "Failed to read int0 cause: %d\n", ret);
+			return IRQ_HANDLED;
+		}
+		priv->npcm_state = cause & (PCM9211_INT0_MNPCM0_MASK |
+				PCM9211_INT0_MDTSCD0_MASK);
+	}
+
+	ucontrol->value.integer.value[0] = (priv->npcm_state & mask) == mask;
+
+	return 0;
+}
+
+static int pcm9211_dir_preamble_kctl_info(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	uinfo->count = 4;
+
+	return 0;
+}
+
+static int pcm9211_dir_preamble_kctl(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct pcm9211_priv *priv = snd_soc_component_get_drvdata(component);
+	struct device *dev = priv->dev;
+
+	/* If we have an interrupt connected preamble is up-to-date */
+	if (!priv->int0)
+		priv->dir_rate = pcm9211_read_burst_preamble(dev);
+
+	memcpy(ucontrol->value.bytes.data, priv->burst_preamble, 4);
+
+	return 0;
+}
+
+static struct snd_kcontrol* pcm9211_get_ctl(struct device *dev, const char *name)
+{
+	struct pcm9211_priv *priv = dev_get_drvdata(dev);
+	struct snd_ctl_elem_id elem_id;
+
+	memset(&elem_id, 0, sizeof(elem_id));
+	elem_id.iface = SNDRV_CTL_ELEM_IFACE_PCM;
+	strcpy(elem_id.name, name);
+	return snd_ctl_find_id(priv->codec->component.card->snd_card, &elem_id);
+}
+
+static struct snd_kcontrol* pcm9211_get_rate_ctl(struct device *dev)
+{
+	struct pcm9211_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv->rate_ctl)
+		priv->rate_ctl = pcm9211_get_ctl(dev, "DIR Sample Rate");
+
+	return priv->rate_ctl;
+}
+
+static struct snd_kcontrol* pcm9211_get_npcm_ctl(struct device *dev)
+{
+	struct pcm9211_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv->npcm_ctl)
+		priv->npcm_ctl = pcm9211_get_ctl(dev, "DIR Non-PCM Bitstream");
+
+	return priv->npcm_ctl;
+}
+
+static struct snd_kcontrol* pcm9211_get_dtscd_ctl(struct device *dev)
+{
+	struct pcm9211_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv->dts_ctl)
+		priv->dts_ctl = pcm9211_get_ctl(dev, "DIR DTS Bitstream");
+
+	return priv->dts_ctl;
+}
+
+static struct snd_kcontrol* pcm9211_get_burst_preamble_ctl(struct device *dev)
+{
+	struct pcm9211_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv->preamble_ctl)
+		priv->preamble_ctl = pcm9211_get_ctl(dev, "DIR Burst Preamble");
+
+	return priv->preamble_ctl;
+}
+
+static irqreturn_t pcm9211_interrupt(int irq, void *data)
+{
+	struct pcm9211_priv *priv = data;
+	struct device *dev = priv->dev;
+
+	unsigned int cause;
+	int rate;
+	int ret;
+
+	ret = regmap_read(priv->regmap, PCM9211_INT0_OUT, &cause);
+	if (ret) {
+		dev_err(dev, "Failed to read int0 cause: %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	if (cause & PCM9211_INT0_MFSCHG0_MASK) {
+		/* Interrupt is generated before the Fs calculation has
+		 * finished. Give it time to settle.
+		 */
+		usleep_range(15000, 16000);
+		rate = pcm9211_dir_rate(dev);
+
+		if (rate < 0) {
+			dev_err(dev, "Failed to retrieve DIR rate: %d\n", rate);
+			goto preamble;
+		}
+
+		if (rate == priv->dir_rate)
+			goto preamble;
+
+		priv->dir_rate = rate;
+		dev_dbg(dev, "DIR sampling rate changed to: %d\n", rate);
+
+		if (priv->codec == NULL || pcm9211_get_rate_ctl(dev) == NULL)
+			goto preamble;
+
+		snd_ctl_notify(priv->codec->component.card->snd_card,
+				SNDRV_CTL_EVENT_MASK_VALUE,
+				&pcm9211_get_rate_ctl(dev)->id);
+	}
+
+preamble:
+	if ((cause & PCM9211_INT0_MPCRNW0_MASK)) {
+		if (pcm9211_read_burst_preamble(dev) < 0)
+			goto npcm;
+
+		if (priv->codec == NULL ||
+				pcm9211_get_burst_preamble_ctl(dev) == NULL)
+			goto dts;
+
+		snd_ctl_notify(priv->codec->component.card->snd_card,
+				SNDRV_CTL_EVENT_MASK_VALUE,
+				&pcm9211_get_burst_preamble_ctl(dev)->id);
+	}
+
+npcm:
+	if ((cause & PCM9211_INT0_MNPCM0_MASK)) {
+		/* PCM9211 does not generate an interrupt for NPCM0 1->0
+		 * transition, but continously generates interrupts as long as
+		 * NPCM0 is high, so use a timeout to clear */
+		cancel_delayed_work_sync(&priv->npcm_clear_work);
+		queue_delayed_work(system_wq, &priv->npcm_clear_work,
+				msecs_to_jiffies(100));
+
+
+		if ((cause & PCM9211_INT0_MNPCM0_MASK) !=
+				(priv->npcm_state & PCM9211_INT0_MNPCM0_MASK))
+			dev_dbg(dev, "NPCM status on interrupt: %d\n",
+					(cause & PCM9211_INT0_MNPCM0_MASK) ==
+					PCM9211_INT0_MNPCM0_MASK);
+
+		priv->npcm_state = (priv->npcm_state &
+				~PCM9211_INT0_MNPCM0_MASK) |
+			(cause & PCM9211_INT0_MNPCM0_MASK);
+
+		if (priv->codec == NULL || pcm9211_get_npcm_ctl(dev) == NULL)
+			goto dts;
+
+		snd_ctl_notify(priv->codec->component.card->snd_card,
+				SNDRV_CTL_EVENT_MASK_VALUE,
+				&pcm9211_get_npcm_ctl(dev)->id);
+	}
+
+dts:
+	if (cause & PCM9211_INT0_MDTSCD0_MASK) {
+		dev_dbg(dev, "DTSCD status on interrupt: %d\n",
+				(cause & PCM9211_INT0_MDTSCD0_MASK) ==
+				PCM9211_INT0_MDTSCD0_MASK);
+		priv->npcm_state |= PCM9211_INT0_MDTSCD0_MASK;
+
+		if (priv->codec == NULL || pcm9211_get_dtscd_ctl(dev) == NULL)
+			return IRQ_HANDLED;
+
+		snd_ctl_notify(priv->codec->component.card->snd_card,
+				SNDRV_CTL_EVENT_MASK_VALUE,
+				&pcm9211_get_dtscd_ctl(dev)->id);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int pcm9211_startup(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct pcm9211_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct device *dev = codec->dev;
+	int port;
+
+	port = pcm9211_main_output_port(dev);
+	if (port < 0) {
+		dev_err(dev, "Failed to read selected port: %d\n", port);
+		return port;
+	}
+
+	if (port == PCM9211_MOSRC_ADC)
+		return snd_pcm_hw_constraint_list(substream->runtime,
+				0, SNDRV_PCM_HW_PARAM_RATE,
+				&adc_rate_constraints);
+
+	priv->dir_rate = pcm9211_dir_rate(dev);
+	priv->rate_constraints.count = 1;
+	priv->rate_constraints.list = &priv->dir_rate;
+	priv->rate_constraints.mask = 0;
+
+	dev_dbg(dev, "Detected biphase rate is %d Hz\n", priv->dir_rate);
+
+	return snd_pcm_hw_constraint_list(substream->runtime,
+			0, SNDRV_PCM_HW_PARAM_RATE, &priv->rate_constraints);
+}
+
+static int pcm9211_set_dai_sysclk(struct snd_soc_dai *dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct pcm9211_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct device *dev = codec->dev;
+
+	int ret;
+
+	if (freq > PCM9211_MAX_SYSCLK) {
+		dev_err(dev, "System clock greater %d is not supported\n",
+				PCM9211_MAX_SYSCLK);
+		return -EINVAL;
+	}
+
+	ret = clk_set_rate(priv->xti, freq);
+	if (ret)
+		return ret;
+
+	priv->sysclk = freq;
+
+	return 0;
+}
+
+static int pcm9211_set_dai_fmt(struct snd_soc_dai *dai,
+		unsigned int format)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct pcm9211_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct device *dev = codec->dev;
+	u32 adfmt, dirfmt;
+	int ret;
+
+	/* Configure format for ADC and DIR block, if main output source is
+	 * set to AUTO the output port may switch between them at any time
+	 */
+	switch (format & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		adfmt = PCM9211_ADFMT_I2S;
+		dirfmt = PCM9211_DIR_FMT_I2S;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		adfmt = PCM9211_ADFMT_RIGHT_J;
+		dirfmt = PCM9211_DIR_FMT_RIGHT_J;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		adfmt = PCM9211_ADFMT_LEFT_J;
+		dirfmt = PCM9211_DIR_FMT_LEFT_J;
+		break;
+	default:
+		dev_err(dev, "Unsupported DAI format\n");
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(priv->regmap, PCM9211_ADC_CTRL2,
+			PCM9211_ADFMT_MASK, adfmt << PCM9211_ADFMT_SHIFT);
+	if (ret) {
+		dev_err(dev, "Failed to update ADC format: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(priv->regmap, PCM9211_DIR_OUT_FMT,
+			PCM9211_DIR_FMT_MASK, dirfmt << PCM9211_DIR_FMT_SHIFT);
+	if (ret) {
+		dev_err(dev, "Failed to update ADC format: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int pcm9211_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params,
+		struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct pcm9211_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct device *dev = codec->dev;
+	unsigned int sclk = 1;
+	unsigned int rate;
+	unsigned int bck;
+	unsigned int ratio;
+	unsigned int port;
+	int ret;
+	int i;
+
+	rate = params_rate(params);
+	bck = rate * 64;
+
+	port = pcm9211_main_output_port(dev);
+	if (port == PCM9211_MOSRC_ADC) {
+		switch (rate) {
+		case 48000:
+			sclk = 12288000;
+			break;
+		case 96000:
+			sclk = 24576000;
+			break;
+		default:
+			dev_err(dev, "Rate %d unsupported.\n", rate);
+			return -EINVAL;
+		}
+
+		/* Systemclock setup */
+		ratio = priv->sysclk / sclk;
+		for (i = 0; i < PCM9211_NUM_SCK_RATIOS; i++) {
+			if (pcm9211_sck_ratios[i] == ratio)
+				break;
+		}
+		if (i == PCM9211_NUM_SCK_RATIOS) {
+			dev_err(dev, "SCK divider %d is not supported\n",
+					ratio);
+			return -EINVAL;
+		}
+		ret = regmap_update_bits(priv->regmap, PCM9211_XTI_SCLK_FREQ,
+				PCM9211_XTI_XSCK_MASK,
+				i << PCM9211_XTI_XSCK_SHIFT);
+
+		if (ret) {
+			dev_err(dev, "Failed to configure SCK divider: %d\n",
+					ret);
+			return ret;
+		}
+
+		/* Bitclock setup */
+		ratio = priv->sysclk / bck;
+		for (i = 0; i < PCM9211_NUM_BCK_RATIOS; i++) {
+			if (pcm9211_bck_ratios[i] == ratio)
+				break;
+		}
+		if (i == PCM9211_NUM_BCK_RATIOS) {
+			dev_err(dev, "BCK divider %d is not supported\n",
+					ratio);
+			return -EINVAL;
+		}
+		ret = regmap_update_bits(priv->regmap, PCM9211_XTI_SCLK_FREQ,
+				PCM9211_XTI_BCK_MASK,
+				i << PCM9211_XTI_BCK_SHIFT);
+		if (ret) {
+			dev_err(dev, "Failed to configure BCK divider: %d\n",
+					ret);
+			return ret;
+		}
+
+		/* Frameclock setup */
+		ratio = priv->sysclk / rate;
+		for (i = 0; i < PCM9211_NUM_LRCK_RATIOS; i++) {
+			if (pcm9211_lrck_ratios[i] == ratio)
+				break;
+		}
+		if (i == PCM9211_NUM_LRCK_RATIOS) {
+			dev_err(dev, "LRCK divider %d is not supported\n",
+					ratio);
+			return -EINVAL;
+		}
+		ret = regmap_update_bits(priv->regmap, PCM9211_XTI_SCLK_FREQ,
+				PCM9211_XTI_LRCK_MASK,
+				i << PCM9211_XTI_LRCK_SHIFT);
+		if (ret) {
+			dev_err(dev, "Failed to configure LRCK divider: %d\n",
+					ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int pcm9211_reset(struct device *dev)
+{
+	struct pcm9211_priv *priv = dev_get_drvdata(dev);
+	int ret;
+
+	/* Use reset gpio if available, otherwise soft-reset */
+	if (priv->reset) {
+		gpiod_set_value_cansleep(priv->reset, 0);
+		usleep_range(500, 1000);
+		gpiod_set_value_cansleep(priv->reset, 1);
+	} else {
+		ret = regmap_update_bits(priv->regmap, PCM9211_SYS_RESET,
+				PCM9211_SYS_RESET_MRST, 0);
+		if (ret) {
+			dev_err(dev, "Could not reset device: %d\n", ret);
+			return ret;
+		}
+		usleep_range(10000, 15000);
+	}
+
+	regcache_mark_dirty(priv->regmap);
+
+	return 0;
+}
+
+static int pcm9211_write_pinconfig(struct device *dev)
+{
+	struct pcm9211_priv *priv = dev_get_drvdata(dev);
+	u8 values[4];
+	int val;
+	int ret;
+	int i;
+
+	ret = of_property_read_u8_array(dev->of_node, "ti,group-function",
+			values, 3);
+	if (!ret) {
+		val = (values[0] & PCM9211_MPASEL_MASK) <<
+			PCM9211_MPASEL_SHIFT |
+			(values[1] & PCM9211_MPBSEL_MASK) <<
+			PCM9211_MPBSEL_SHIFT |
+			(values[2] & PCM9211_MPCSEL_MASK) <<
+			PCM9211_MPCSEL_SHIFT;
+		ret = regmap_write(priv->regmap, PCM9211_MPIO_GROUP, val);
+		if (ret) {
+			dev_err(dev, "Failed to write mpio group functions: %d\n",
+					ret);
+			return ret;
+		}
+	}
+
+	ret = of_property_read_u8_array(dev->of_node, "ti,mpio-a-flags-gpio",
+			values, 4);
+	if (!ret) {
+		/* Write MPIO A flags/gpio selection */
+		for (i = 0, val = 0; i < 4; i++)
+			val |= (values[i] << PCM9211_MPAxSEL_SHIFT(i)) &
+				PCM9211_MPAxSEL_MASK(i);
+
+		ret = regmap_update_bits(priv->regmap, PCM9211_MPIO_A_FLAGS,
+				PCM9211_MPAxSEL_MASK(0) | PCM9211_MPAxSEL_MASK(1) |
+				PCM9211_MPAxSEL_MASK(2), val);
+		if (ret) {
+			dev_err(dev, "Failed to update mpio_a flags: %d\n", ret);
+			return ret;
+		}
+	}
+
+	ret = of_property_read_u8_array(dev->of_node, "ti,mpio-b-flags-gpio",
+			values, 4);
+	if (!ret) {
+		/* Write MPIO B flags/gpio selection */
+		for (i = 0, val = 0; i < 4; i++)
+			val |= (values[i] << PCM9211_MPBxSEL_SHIFT(i)) &
+				PCM9211_MPBxSEL_MASK(i);
+
+		ret = regmap_update_bits(priv->regmap,
+				PCM9211_MPIO_B_MPIO_C_FLAGS,
+				PCM9211_MPBxSEL_MASK(0) |
+				PCM9211_MPBxSEL_MASK(1) |
+				PCM9211_MPBxSEL_MASK(2), val);
+		if (ret) {
+			dev_err(dev, "Failed to update mpio_a flags: %d\n",
+					ret);
+			return ret;
+		}
+	}
+
+	ret = of_property_read_u8_array(dev->of_node, "ti,mpio-c-flags-gpio",
+			values, 4);
+	if (!ret) {
+		/* Write MPIO B flags/gpio selection */
+		for (i = 0, val = 0; i < 4; i++)
+			val |= (values[i] << PCM9211_MPCxSEL_SHIFT(i)) &
+				PCM9211_MPCxSEL_MASK(i);
+
+		ret = regmap_update_bits(priv->regmap,
+				PCM9211_MPIO_B_MPIO_C_FLAGS,
+				PCM9211_MPCxSEL_MASK(0) |
+				PCM9211_MPCxSEL_MASK(1) |
+				PCM9211_MPCxSEL_MASK(2), val);
+		if (ret) {
+			dev_err(dev, "Failed to update mpio_a flags: %d\n",
+					ret);
+			return ret;
+		}
+	}
+
+	ret = of_property_read_u8_array(dev->of_node, "ti,mpio-a-flag",
+			values, 4);
+	if (!ret) {
+		/* Write MPIO A flag selection */
+		for (i = 0, val = 0; i < 2; i++)
+			val |= (values[i] <<
+					PCM9211_MPIO_ABCx_FLAG_SHIFT(i)) &
+				PCM9211_MPIO_ABCx_FLAG_MASK(i);
+		ret = regmap_write(priv->regmap, PCM9211_MPIO_A1_A0_OUT_FLAG,
+				val);
+		if (ret) {
+			dev_err(dev, "Failed to update mpio_a1/0 flags: %d\n",
+					ret);
+			return ret;
+		}
+
+		for (i = 2, val = 0; i < 4; i++)
+			val |= (values[i] <<
+					PCM9211_MPIO_ABCx_FLAG_SHIFT(i)) &
+				PCM9211_MPIO_ABCx_FLAG_MASK(i);
+		ret = regmap_write(priv->regmap, PCM9211_MPIO_A3_A2_OUT_FLAG,
+				val);
+		if (ret) {
+			dev_err(dev, "Failed to update mpio_a3/2 flags: %d\n",
+					ret);
+			return ret;
+		}
+	}
+
+	ret = of_property_read_u8_array(dev->of_node, "ti,mpio-b-flag",
+			values, 4);
+	if (!ret) {
+		/* Write MPIO B flag selection */
+		for (i = 0, val = 0; i < 2; i++)
+			val |= (values[i] << PCM9211_MPIO_ABCx_FLAG_SHIFT(i)) &
+				PCM9211_MPIO_ABCx_FLAG_MASK(i);
+		ret = regmap_write(priv->regmap, PCM9211_MPIO_B1_B0_OUT_FLAG,
+				val);
+		if (ret) {
+			dev_err(dev, "Failed to update mpio_b1/0 flags: %d\n",
+					ret);
+			return ret;
+		}
+
+		for (i = 2, val = 0; i < 4; i++)
+			val |= (values[i] << PCM9211_MPIO_ABCx_FLAG_SHIFT(i)) &
+				PCM9211_MPIO_ABCx_FLAG_MASK(i);
+		ret = regmap_write(priv->regmap, PCM9211_MPIO_B3_B2_OUT_FLAG,
+				val);
+		if (ret) {
+			dev_err(dev, "Failed to update mpio_b3/2 flags: %d\n",
+					ret);
+			return ret;
+		}
+	}
+
+	ret = of_property_read_u8_array(dev->of_node, "ti,mpio-c-flag",
+				  values, 4);
+	if (!ret) {
+		/* Write MPIO C flag selection */
+		for (i = 0, val = 0; i < 2; i++)
+			val |= (values[i] << PCM9211_MPIO_ABCx_FLAG_SHIFT(i)) &
+				PCM9211_MPIO_ABCx_FLAG_MASK(i);
+		ret = regmap_write(priv->regmap, PCM9211_MPIO_C1_C0_OUT_FLAG,
+				val);
+		if (ret) {
+			dev_err(dev, "Failed to update mpio_c1/0 flags: %d\n",
+					ret);
+			return ret;
+		}
+
+		for (i = 2, val = 0; i < 4; i++)
+			val |= (values[i] << PCM9211_MPIO_ABCx_FLAG_SHIFT(i)) &
+				PCM9211_MPIO_ABCx_FLAG_MASK(i);
+		ret = regmap_write(priv->regmap, PCM9211_MPIO_C3_C2_OUT_FLAG,
+				val);
+		if (ret) {
+			dev_err(dev, "Failed to update mpio_c3/2 flags: %d\n",
+					ret);
+			return ret;
+		}
+	}
+
+	ret = of_property_read_u8_array(dev->of_node, "ti,mpo-function",
+			values, 2);
+	if (!ret) {
+		/* Write MPO function selection */
+		for (i = 0, val = 0; i < 2; i++)
+			val |= (values[i] << PCM9211_MPOxOUT_SHIFT(i)) &
+				PCM9211_MPOxOUT_MASK(i);
+		ret = regmap_write(priv->regmap, PCM9211_MPO_1_0_FUNC, val);
+		if (ret) {
+			dev_err(dev, "Failed to update mpo function selection: %d\n",
+					ret);
+			return ret;
+		}
+	}
+
+	ret = of_property_read_u8(dev->of_node, "ti,int0-function", values);
+	if (!ret) {
+		val = values[0] ? PCM9211_ERROR_INT0_MASK : 0;
+		ret = regmap_update_bits(priv->regmap, PCM9211_ERR_OUT,
+				PCM9211_ERROR_INT0_MASK, val);
+		if (ret) {
+			dev_err(dev, "Failed to update int0 function selection: %d\n",
+					ret);
+			return ret;
+		}
+	}
+
+	ret = of_property_read_u8(dev->of_node, "ti,int1-function", values);
+	if (!ret) {
+		val = values[0] ? PCM9211_NPCM_INT1_MASK : 0;
+		ret = regmap_update_bits(priv->regmap, PCM9211_ERR_OUT,
+				PCM9211_NPCM_INT1_MASK, val);
+		if (ret) {
+			dev_err(dev, "Failed to update int1 function selection: %d\n",
+					ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void pcm9211_npcm_clear_work(struct work_struct *work)
+{
+	struct pcm9211_priv *priv = container_of(work, struct pcm9211_priv,
+			npcm_clear_work.work);
+	u8 old_state = priv->npcm_state;
+	struct device *dev = priv->dev;
+
+	/* Clear NPCM & DTSCD, as DTSCD is only valid as long as NPCM is */
+	priv->npcm_state &= ~(PCM9211_INT0_MNPCM0_MASK |
+			PCM9211_INT0_MDTSCD0_MASK);
+
+	dev_dbg(dev, "Clear NPCM flag after timeout\n");
+
+	if (priv->codec == NULL || pcm9211_get_dtscd_ctl(dev) == NULL ||
+			pcm9211_get_npcm_ctl(dev) == NULL)
+		return;
+
+	if (old_state & PCM9211_INT0_MNPCM0_MASK)
+		snd_ctl_notify(priv->codec->component.card->snd_card,
+				SNDRV_CTL_EVENT_MASK_VALUE,
+				&pcm9211_get_npcm_ctl(dev)->id);
+
+	if (old_state & PCM9211_INT0_MDTSCD0_MASK)
+		snd_ctl_notify(priv->codec->component.card->snd_card,
+				SNDRV_CTL_EVENT_MASK_VALUE,
+				&pcm9211_get_dtscd_ctl(dev)->id);
+}
+
+static int pcm9211_soc_probe(struct snd_soc_codec *codec)
+{
+	struct pcm9211_priv *priv = snd_soc_codec_get_drvdata(codec);
+
+	priv->codec = codec;
+
+	return 0;
+}
+
+/* Simple Controls */
+static const DECLARE_TLV_DB_SCALE(pcm9211_adc_tlv, -10050, 50, 1);
+static const char *const pcm9211_main_outputs[] = { "AUTO", "DIR", "ADC",
+	"AUXIN0", "AUXIN1", "AUXIN2" };
+static const struct soc_enum pcm9211_main_sclk_enum =
+	SOC_ENUM_SINGLE(PCM9211_MAIN_OUT_SOURCE, 4, 4, pcm9211_main_outputs);
+
+static const struct snd_kcontrol_new pcm9211_snd_controls[] = {
+	SOC_DOUBLE_R_RANGE_TLV("ADC Attenuation",
+			PCM9211_ADC_L_CH_ATT,
+			PCM9211_ADC_R_CH_ATT,
+			0, 14, 255, 0, pcm9211_adc_tlv),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = "DIR Sample Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ |
+			SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = pcm9211_dir_rate_kctl_info,
+		.get = pcm9211_dir_rate_kctl,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = "DIR Non-PCM Bitstream",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ |
+			SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = pcm9211_dir_npcm_kctl_info,
+		.get = pcm9211_dir_npcm_kctl,
+		.private_value = PCM9211_INT0_MNPCM0_MASK,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = "DIR DTS Bitstream",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ |
+			SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = pcm9211_dir_dtscd_kctl_info,
+		.get = pcm9211_dir_dtscd_kctl,
+		.private_value = PCM9211_INT0_MDTSCD0_MASK,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = "DIR Burst Preamble",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ |
+			SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = pcm9211_dir_preamble_kctl_info,
+		.get = pcm9211_dir_preamble_kctl,
+	},
+	SOC_ENUM("MAIN SCLK Output Select", pcm9211_main_sclk_enum),
+};
+
+/* DAPM Controls */
+static const char *const pcm9211_dir_inputs[] = { "RXIN0", "RXIN1", "RXIN2",
+	"RXIN3", "RXIN4", "RXIN5", "RXIN6", "RXIN7" };
+static const struct soc_enum pcm9211_dir_mux_enum =
+	SOC_ENUM_SINGLE(PCM9211_DIR_INP_BIPHASE, 0, 8, pcm9211_dir_inputs);
+static const struct snd_kcontrol_new pcm9211_dir_mux_control =
+	SOC_DAPM_ENUM("DIR Input Select", pcm9211_dir_mux_enum);
+
+static const struct soc_enum pcm9211_main_out_enum =
+	SOC_ENUM_SINGLE(PCM9211_MAIN_OUT_SOURCE, 0, 4, pcm9211_main_outputs);
+static const struct snd_kcontrol_new pcm9211_main_out_control =
+	SOC_DAPM_ENUM("MAIN Output Select", pcm9211_main_out_enum);
+
+/* DAPM widgets */
+static const struct snd_soc_dapm_widget pcm9211_dapm_widgets[] = {
+	/* Inputs */
+	SND_SOC_DAPM_INPUT("RXIN0"),
+	SND_SOC_DAPM_INPUT("RXIN1"),
+	SND_SOC_DAPM_INPUT("RXIN2"),
+	SND_SOC_DAPM_INPUT("RXIN3"),
+	SND_SOC_DAPM_INPUT("RXIN4"),
+	SND_SOC_DAPM_INPUT("RXIN5"),
+	SND_SOC_DAPM_INPUT("RXIN6"),
+	SND_SOC_DAPM_INPUT("RXIN7"),
+	SND_SOC_DAPM_INPUT("VINL"),
+	SND_SOC_DAPM_INPUT("VINR"),
+
+	SND_SOC_DAPM_ADC("ADC", NULL, PCM9211_SYS_RESET,
+			PCM9211_SYS_RESET_ADDIS_SHIFT, 1),
+
+	/* Processing */
+	SND_SOC_DAPM_AIF_IN("DIR", NULL, 0, PCM9211_SYS_RESET,
+			PCM9211_SYS_RESET_RXDIS_SHIFT, 1),
+	SND_SOC_DAPM_MIXER("AUTO", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	/* Internal routing */
+	SND_SOC_DAPM_MUX("DIR Input Mux", SND_SOC_NOPM, 0, 0,
+			&pcm9211_dir_mux_control),
+	SND_SOC_DAPM_MUX("MAIN Output Mux", SND_SOC_NOPM, 0, 0,
+			&pcm9211_main_out_control),
+
+	/* Outputs */
+	SND_SOC_DAPM_OUTPUT("MAIN"),
+};
+
+/* DAPM Routing */
+static const struct snd_soc_dapm_route pcm9211_dapm_routes[] = {
+	{ "DIR Input Mux", "RXIN0", "RXIN0" },
+	{ "DIR Input Mux", "RXIN1", "RXIN1" },
+	{ "DIR Input Mux", "RXIN2", "RXIN2" },
+	{ "DIR Input Mux", "RXIN3", "RXIN3" },
+	{ "DIR Input Mux", "RXIN4", "RXIN4" },
+	{ "DIR Input Mux", "RXIN5", "RXIN5" },
+	{ "DIR Input Mux", "RXIN6", "RXIN6" },
+	{ "DIR Input Mux", "RXIN7", "RXIN7" },
+
+	{ "ADC", NULL, "VINL" },
+	{ "ADC", NULL, "VINR" },
+
+	{ "DIR", NULL, "DIR Input Mux" },
+	{ "AUTO", NULL, "DIR" },
+	{ "AUTO", NULL, "ADC" },
+
+	{ "MAIN Output Mux", "DIR", "DIR" },
+	{ "MAIN Output Mux", "ADC", "ADC" },
+	{ "MAIN Output Mux", "AUTO", "AUTO" },
+
+	{ "MAIN", NULL, "MAIN Output Mux" },
+};
+
+static struct snd_soc_dai_ops pcm9211_dai_ops = {
+	.startup = pcm9211_startup,
+	.hw_params = pcm9211_hw_params,
+	.set_sysclk = pcm9211_set_dai_sysclk,
+	.set_fmt = pcm9211_set_dai_fmt,
+};
+
+/* BCLK is always 64 * FS == 32 bit/channel */
+#define PCM9211_FORMATS SNDRV_PCM_FMTBIT_S32_LE
+struct snd_soc_dai_driver pcm9211_dai = {
+	.name = "pcm9211-hifi",
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_192000,
+		.formats = PCM9211_FORMATS,
+	},
+	.ops = &pcm9211_dai_ops,
+};
+
+static const struct snd_soc_codec_driver pcm9211_driver = {
+	.probe = pcm9211_soc_probe,
+	.component_driver = {
+		.controls = pcm9211_snd_controls,
+		.num_controls = ARRAY_SIZE(pcm9211_snd_controls),
+		.dapm_widgets = pcm9211_dapm_widgets,
+		.num_dapm_widgets = ARRAY_SIZE(pcm9211_dapm_widgets),
+		.dapm_routes = pcm9211_dapm_routes,
+		.num_dapm_routes = ARRAY_SIZE(pcm9211_dapm_routes),
+	},
+};
+
+int pcm9211_probe(struct device *dev, struct regmap *regmap)
+{
+	struct pcm9211_priv *priv;
+	unsigned int cause;
+	int ret;
+	int i;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (priv == NULL)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, priv);
+	priv->dev = dev;
+	priv->regmap = regmap;
+
+	priv->xti = devm_clk_get(dev, "xti");
+	if (IS_ERR(priv->xti)) {
+		ret = PTR_ERR(priv->xti);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get clock 'xti': %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(priv->xti);
+	if (ret) {
+		dev_err(dev, "Failed to enable xti clock: %d\n", ret);
+		return ret;
+	}
+
+	priv->sysclk = clk_get_rate(priv->xti);
+	if (priv->sysclk > PCM9211_MAX_SYSCLK) {
+		dev_err(dev, "xti clock rate (%lu) exceeds supported max %u\n",
+				priv->sysclk, PCM9211_MAX_SYSCLK);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(priv->supplies); i++)
+		priv->supplies[i].supply = pcm9211_supply_names[i];
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(priv->supplies),
+			priv->supplies);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get supplies: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(priv->supplies),
+			priv->supplies);
+	if (ret) {
+		dev_err(dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
+	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->reset)) {
+		ret = PTR_ERR(priv->reset);
+		dev_err(dev, "Failed to get reset gpio: %d\n", ret);
+		return ret;
+	}
+
+	pcm9211_reset(dev);
+
+	priv->int0 = devm_gpiod_get_optional(dev, "int0", GPIOD_IN);
+	if (IS_ERR(priv->reset)) {
+		ret = PTR_ERR(priv->reset);
+		dev_err(dev, "Failed to get reset gpio: %d\n", ret);
+		return ret;
+	}
+
+	if (priv->int0) {
+		int irq = gpiod_to_irq(priv->int0);
+
+		if (irq < 0) {
+			dev_err(dev, "Configured 'int0' gpio cannot be used as IRQ: %d\n",
+					irq);
+			return irq;
+		}
+
+		INIT_DELAYED_WORK(&priv->npcm_clear_work,
+				pcm9211_npcm_clear_work);
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+				pcm9211_interrupt,
+				IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+				"pcm9211", priv);
+		if (ret) {
+			dev_err(dev, "Failed to request irq: %d\n", ret);
+			return ret;
+		}
+
+		/* Set interrupt to use positive polarity */
+		ret = regmap_update_bits(priv->regmap, PCM9211_INT_POLARITY,
+				PCM9211_INT0_POLARITY_POS_MASK,
+				PCM9211_INT0_POLARITY_POS_MASK);
+		if (ret) {
+			dev_err(dev, "Failed to configure int0 polaroty: %d\n",
+					ret);
+			return ret;
+		}
+	}
+
+	ret = pcm9211_write_pinconfig(dev);
+	if (ret)
+		return ret;
+
+	/* Unmap NPCM, DTS, Burst Preamble and Fs change interrupt */
+	ret = regmap_update_bits(priv->regmap, PCM9211_INT0_CAUSE,
+			PCM9211_INT0_MNPCM0_MASK | PCM9211_INT0_MDTSCD0_MASK |
+			PCM9211_INT0_MPCRNW0_MASK | PCM9211_INT0_MFSCHG0_MASK,
+			0);
+	if (ret) {
+		dev_err(dev, "Failed to unmask interrupt causes: %d\n", ret);
+		return ret;
+	}
+
+	/* Enable DTSCD detection */
+	ret = regmap_update_bits(priv->regmap, PCM9211_NON_PCM_DEF,
+			PCM9211_NON_PCM_DTS_CD_DET_MASK,
+			PCM9211_NON_PCM_DTS_CD_DET_MASK);
+	if (ret) {
+		dev_err(dev, "Failed to enable DTSCD detection: %d\n", ret);
+		return ret;
+	}
+
+	/* Read initial sampling rate and npcm state */
+	priv->dir_rate = pcm9211_dir_rate(dev);
+	ret = regmap_read(priv->regmap, PCM9211_INT0_OUT, &cause);
+	if (ret) {
+		dev_err(dev, "Failed to read int0 cause: %d\n", ret);
+		return IRQ_HANDLED;
+	}
+	priv->npcm_state = cause;
+
+	ret = snd_soc_register_codec(dev, &pcm9211_driver, &pcm9211_dai, 1);
+	if (ret) {
+		dev_err(dev, "Failed to register codec: %d\n", ret);
+		return ret;
+	}
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_idle(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pcm9211_probe);
+
+void pcm9211_remove(struct device *dev)
+{
+	struct pcm9211_priv *priv = dev_get_drvdata(dev);
+
+	snd_soc_unregister_codec(dev);
+	pm_runtime_disable(dev);
+	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
+	clk_disable_unprepare(priv->xti);
+}
+EXPORT_SYMBOL_GPL(pcm9211_remove);
+
+#ifdef CONFIG_PM
+static int pcm9211_runtime_resume(struct device *dev)
+{
+	struct pcm9211_priv *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(priv->xti);
+	if (ret) {
+		dev_err(dev, "Failed to enable xti clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->supplies);
+	if (ret) {
+		dev_err(dev, "Failed to enable supplies: %d\n", ret);
+		goto err_reg;
+	}
+
+	ret = pcm9211_reset(dev);
+	if (ret) {
+		dev_err(dev, "Failed to reset device: %d\n", ret);
+		goto err;
+	}
+
+	regcache_cache_only(priv->regmap, false);
+	regcache_mark_dirty(priv->regmap);
+
+	ret = regcache_sync(priv->regmap);
+	if (ret) {
+		dev_err(dev, "Failed to sync regmap: %d\n", ret);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
+err_reg:
+	clk_disable_unprepare(priv->xti);
+
+	return ret;
+}
+
+static int pcm9211_runtime_suspend(struct device *dev)
+{
+	struct pcm9211_priv *priv = dev_get_drvdata(dev);
+
+	regcache_cache_only(priv->regmap, true);
+	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
+	clk_disable_unprepare(priv->xti);
+
+	return 0;
+}
+#endif
+
+const struct dev_pm_ops pcm9211_pm_ops = {
+	SET_RUNTIME_PM_OPS(pcm9211_runtime_suspend, pcm9211_runtime_resume,
+			NULL)
+};
+EXPORT_SYMBOL_GPL(pcm9211_pm_ops);
+
+MODULE_DESCRIPTION("PCM9211 codec driver");
+MODULE_AUTHOR("Julian Scheel <julian@jusst.de>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/pcm9211.h b/sound/soc/codecs/pcm9211.h
new file mode 100644
index 000000000000..3ad9e9e9419a
--- /dev/null
+++ b/sound/soc/codecs/pcm9211.h
@@ -0,0 +1,206 @@
+/*
+ * PCM9211 codec driver header
+ *
+ * Copyright (C) 2017 jusst technologies GmbH / jusst.engineering
+ *
+ * Author: Julian Scheel <julian@jusst.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#ifndef __PCM9211_H_
+#define __PCM9211_H_
+
+extern const struct dev_pm_ops pcm9211_pm_ops;
+extern const struct regmap_config pcm9211_regmap;
+
+extern int pcm9211_probe(struct device *dev, struct regmap *regmap);
+extern void pcm9211_remove(struct device *dev);
+
+/* Register definitions */
+#define PCM9211_ERR_OUT			0x20
+#define PCM9211_DIR_INITIAL1		0x21
+#define PCM9211_DIR_INITIAL2		0x22
+#define PCM9211_DIR_INITIAL3		0x23
+#define PCM9211_OSC_CTRL		0x24
+#define PCM9211_ERR_CAUSE		0x25
+#define PCM9211_AUTO_SEL_CAUSE		0x26
+#define PCM9211_DIR_FS_RANGE		0x27
+#define PCM9211_NON_PCM_DEF		0x28
+#define PCM9211_DTS_CD_LD		0x29
+#define PCM9211_INT0_CAUSE		0x2a
+#define PCM9211_INT1_CAUSE		0x2b
+#define PCM9211_INT0_OUT		0x2c
+#define PCM9211_INT1_OUT		0x2d
+#define PCM9211_INT_POLARITY		0x2e
+#define PCM9211_DIR_OUT_FMT		0x2f
+#define PCM9211_DIR_RSCLK_RATIO		0x30
+#define PCM9211_XTI_SCLK_FREQ		0x31
+#define PCM9211_DIR_SOURCE_BIT2		0x32
+#define PCM9211_XTI_SOURCE_BIT2		0x33
+#define PCM9211_DIR_INP_BIPHASE		0x34
+#define PCM9211_RECOUT0_BIPHASE		0x35
+#define PCM9211_RECOUT1_BIPHASE		0x36
+#define PCM9211_FS_CALC_TARGET		0x37
+#define PCM9211_FS_CALC_RESULT		0x38
+#define PCM9211_BIPHASE_INFO		0x39
+#define PCM9211_PC_BUF0			0x3a
+#define PCM9211_PC_BUF1			0x3b
+#define PCM9211_PD_BUF0			0x3c
+#define PCM9211_PD_BUF1			0x3d
+
+#define PCM9211_SYS_RESET		0x40
+
+#define PCM9211_ADC_CTRL1		0x42
+
+#define PCM9211_ADC_L_CH_ATT		0x46
+#define PCM9211_ADC_R_CH_ATT		0x47
+#define PCM9211_ADC_CTRL2		0x48
+#define PCM9211_ADC_CTRL3		0x49
+
+#define PCM9211_DIR_STATUS1		0x5a
+#define PCM9211_DIR_STATUS2		0x5b
+#define PCM9211_DIR_STATUS3		0x5c
+#define PCM9211_DIR_STATUS4		0x5d
+#define PCM9211_DIR_STATUS5		0x5e
+#define PCM9211_DIR_STATUS6		0x5f
+#define PCM9211_DIT_CTRL1		0x60
+#define PCM9211_DIT_CTRL2		0x61
+#define PCM9211_DIT_CTRL3		0x62
+#define PCM9211_DIT_STATUS1		0x63
+#define PCM9211_DIT_STATUS2		0x64
+#define PCM9211_DIT_STATUS3		0x65
+#define PCM9211_DIT_STATUS4		0x66
+#define PCM9211_DIT_STATUS5		0x67
+#define PCM9211_DIT_STATUS6		0x68
+
+#define PCM9211_MAIN_AUX_MUTE		0x6a
+#define PCM9211_MAIN_OUT_SOURCE		0x6b
+#define PCM9211_AUX_OUT_SOURCE		0x6c
+#define PCM9211_MPIO_B_MAIN_HIZ		0x6d
+#define PCM9211_MPIO_C_MPIO_A_HIZ	0x6e
+#define PCM9211_MPIO_GROUP		0x6f
+#define PCM9211_MPIO_A_FLAGS		0x70
+#define PCM9211_MPIO_B_MPIO_C_FLAGS	0x71
+#define PCM9211_MPIO_A1_A0_OUT_FLAG	0x72
+#define PCM9211_MPIO_A3_A2_OUT_FLAG	0x73
+#define PCM9211_MPIO_B1_B0_OUT_FLAG	0x74
+#define PCM9211_MPIO_B3_B2_OUT_FLAG	0x75
+#define PCM9211_MPIO_C1_C0_OUT_FLAG	0x76
+#define PCM9211_MPIO_C3_C2_OUT_FLAG	0x77
+#define PCM9211_MPO_1_0_FUNC		0x78
+#define PCM9211_MPIO_A_B_DIR		0x79
+#define PCM9211_MPIO_C_DIR		0x7a
+#define PCM9211_MPIO_A_B_DATA_OUT	0x7b
+#define PCM9211_MPIO_C_DATA_OUT		0x7c
+#define PCM9211_MPIO_A_B_DATA_IN	0x7d
+#define PCM9211_MPIO_C_DATA_IN		0x7e
+
+
+/* Register field values (only used ones) */
+
+/* PCM9211_ERR_OUT */
+#define PCM9211_ERROR_INT0_MASK		BIT(2)
+#define PCM9211_NPCM_INT1_MASK		BIT(0)
+
+/* PCM9211_NON_PCM_DEF */
+#define PCM9211_NON_PCM_DTS_CD_DET_MASK	BIT(2)
+
+/* PCM9211_INT0_CAUSE */
+#define PCM9211_INT0_MNPCM0_MASK	BIT(6)
+#define PCM9211_INT0_MDTSCD0_MASK	BIT(4)
+#define PCM9211_INT0_MPCRNW0_MASK	BIT(2)
+#define PCM9211_INT0_MFSCHG0_MASK	BIT(1)
+
+/* PCM9211_INT_POLARITY	*/
+#define PCM9211_INT0_POLARITY_POS_MASK	BIT(2)
+
+/* PCM9211_DIR_OUT_FMT */
+#define PCM9211_DIR_FMT_MASK		0x7
+#define PCM9211_DIR_FMT_SHIFT		0
+
+#define PCM9211_DIR_FMT_I2S		4
+#define PCM9211_DIR_FMT_LEFT_J		5
+#define PCM9211_DIR_FMT_RIGHT_J		0
+
+/* PCM9211_XTI_SCLK_FREQ */
+#define PCM9211_XTI_XSCK_SHIFT		4
+#define PCM9211_XTI_XSCK_MASK		(0x3 << PCM9211_XTI_XSCK_SHIFT)
+#define PCM9211_XTI_BCK_SHIFT		2
+#define PCM9211_XTI_BCK_MASK		(0x3 << PCM9211_XTI_BCK_SHIFT)
+#define PCM9211_XTI_LRCK_SHIFT		0
+#define PCM9211_XTI_LRCK_MASK		(0x3 << PCM9211_XTI_LRCK_SHIFT)
+
+
+/* PCM9211_BIPHASE_INFO */
+#define PCM9211_BIPHASE_SFSST_SHIFT	7
+#define PCM9211_BIPHASE_SFSST_MASK	BIT(PCM9211_BIPHASE_SFSST_SHIFT)
+#define PCM9211_BIPHASE_SFSOUT_SHIFT	0
+#define PCM9211_BIPHASE_SFSOUT_MASK	(0xf << PCM9211_BIPHASE_SFSOUT_SHIFT)
+
+
+/* PCM9211_SYS_RESET */
+#define PCM9211_SYS_RESET_MRST		BIT(7)
+#define PCM9211_SYS_RESET_RXDIS_SHIFT	4
+#define PCM9211_SYS_RESET_ADDIS_SHIFT	5
+
+
+/* PCM9211_ADC_CTRL2 */
+#define PCM9211_ADFMT_MASK		0x3
+#define PCM9211_ADFMT_SHIFT		0
+
+#define PCM9211_ADFMT_I2S		0
+#define PCM9211_ADFMT_LEFT_J		1
+#define PCM9211_ADFMT_RIGHT_J		2
+
+
+/* PCM9211_MAIN_OUT_SOURCE */
+#define PCM9211_MOSSRC_SHIFT		4
+#define PCM9211_MOPSRC_SHIFT		0
+#define PCM9211_MOSRC_MASK		0x7
+#define PCM9211_MOSSRC_MASK		\
+	(PCM9211_MOSRC_MASK << PCM9211_MOSSRC_SHIFT)
+#define PCM9211_MOPSRC_MASK		\
+	(PCM9211_MOSRC_MASK << PCM9211_MOPSRC_SHIFT)
+
+#define PCM9211_MOSRC_AUTO		0
+#define PCM9211_MOSRC_DIR		1
+#define PCM9211_MOSRC_ADC		2
+#define PCM9211_MOSRC_AUXIN0		3
+#define PCM9211_MOSRC_AUXIN1		4
+#define PCM9211_MOSRC_AUXIN2		5
+
+
+/* PCM9211_MPIO_GROUP */
+#define PCM9211_MPASEL_SHIFT		6
+#define PCM9211_MPASEL_MASK		(0x2 << PCM9211_MPASEL_SHIFT)
+#define PCM9211_MPBSEL_SHIFT		3
+#define PCM9211_MPBSEL_MASK		(0x7 << PCM9211_MPBSEL_SHIFT)
+#define PCM9211_MPCSEL_SHIFT		0
+#define PCM9211_MPCSEL_MASK		(0x7 << PCM9211_MPCSEL_SHIFT)
+
+
+/* PCM9211_MPIO_A_FLAGS */
+#define PCM9211_MPAxSEL_SHIFT(x)	(x)
+#define PCM9211_MPAxSEL_MASK(x)		BIT(PCM9211_MPAxSEL_SHIFT(x))
+
+
+/* PCM9211_MPIO_B_MPIO_C_FLAGS */
+#define PCM9211_MPBxSEL_SHIFT(x)	((x) + 4)
+#define PCM9211_MPBxSEL_MASK(x)		BIT(PCM9211_MPBxSEL_SHIFT(x))
+#define PCM9211_MPCxSEL_SHIFT(x)	(x)
+#define PCM9211_MPCxSEL_MASK(x)		BIT(PCM9211_MPCxSEL_SHIFT(x))
+
+
+/* PCM9211_MPIO_A1_A0_OUT_FLAG..PCM9211_MPIO_C3_C2_OUT_FLAG */
+#define PCM9211_MPIO_ABCx_FLAG_SHIFT(x)	(((x) % 2) * 4)
+#define PCM9211_MPIO_ABCx_FLAG_MASK(x)	(0xf << PCM9211_MPIO_ABCx_FLAG_SHIFT(x))
+
+
+/* PCM9211_MPO_1_0_FUNC */
+#define PCM9211_MPOxOUT_SHIFT(x)	((x) * 4)
+#define PCM9211_MPOxOUT_MASK(x)		(0xf << PCM9211_MPOxOUT_SHIFT(x))
+
+#endif
-- 
2.12.2
