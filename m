From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 2/2] ASoC: codecs: Add initial PCM1862/63/64/65
	universal ADC driver
Date: Fri, 10 Nov 2017 13:57:11 -0600
Message-ID: <20171110195711.24210-2-afd@ti.com>
References: <20171110195711.24210-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 by alsa0.perex.cz (Postfix) with ESMTP id E8633267940
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 20:57:14 +0100 (CET)
In-Reply-To: <20171110195711.24210-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Andreas Dannenberg <dannenberg@ti.com>

This is an initial version of the PCM186x codec driver supporting both
2-channel and 4-channel device variants. Not all device features are
supported yet such as master/slave mode PLL configuration for which the
codec driver currently relies on the PCM186x built-in clock
auto-detection feature or the connection of digital microphones.
However here is what's here and what should work:

- Support for SPI and I2C low-level interfaces
- Regmap support and basic register definitions
- Input Mixer and Mux selection
- I2C, LJ, and TDM DAI format support

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Signed-off-by: Michael Stecklein <m-stecklein@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/Kconfig       |  17 +
 sound/soc/codecs/Makefile      |   6 +
 sound/soc/codecs/pcm186x-i2c.c |  79 +++++
 sound/soc/codecs/pcm186x-spi.c |  79 +++++
 sound/soc/codecs/pcm186x.c     | 778 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/pcm186x.h     | 271 ++++++++++++++
 6 files changed, 1230 insertions(+)
 create mode 100644 sound/soc/codecs/pcm186x-i2c.c
 create mode 100644 sound/soc/codecs/pcm186x-spi.c
 create mode 100644 sound/soc/codecs/pcm186x.c
 create mode 100644 sound/soc/codecs/pcm186x.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c367d11079bc..c4f01f58fd2c 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -109,6 +109,8 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_PCM1681 if I2C
 	select SND_SOC_PCM179X_I2C if I2C
 	select SND_SOC_PCM179X_SPI if SPI_MASTER
+	select SND_SOC_PCM186X_I2C if I2C
+	select SND_SOC_PCM186X_SPI if SPI_MASTER
 	select SND_SOC_PCM3008
 	select SND_SOC_PCM3168A_I2C if I2C
 	select SND_SOC_PCM3168A_SPI if SPI_MASTER
@@ -661,6 +663,21 @@ config SND_SOC_PCM179X_SPI
 	  Enable support for Texas Instruments PCM179x CODEC.
 	  Select this if your PCM179x is connected via an SPI bus.
 
+config SND_SOC_PCM186X
+	tristate
+
+config SND_SOC_PCM186X_I2C
+	tristate "Texas Instruments PCM186x CODECs - I2C"
+	depends on I2C
+	select SND_SOC_PCM186X
+	select REGMAP_I2C
+
+config SND_SOC_PCM186X_SPI
+	tristate "Texas Instruments PCM186x CODECs - SPI"
+	depends on SPI_MASTER
+	select SND_SOC_PCM186X
+	select REGMAP_SPI
+
 config SND_SOC_PCM3008
        tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 05018b7ca72b..a660c969c1f7 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -105,6 +105,9 @@ snd-soc-pcm1681-objs := pcm1681.o
 snd-soc-pcm179x-codec-objs := pcm179x.o
 snd-soc-pcm179x-i2c-objs := pcm179x-i2c.o
 snd-soc-pcm179x-spi-objs := pcm179x-spi.o
+snd-soc-pcm186x-objs := pcm186x.o
+snd-soc-pcm186x-i2c-objs := pcm186x-i2c.o
+snd-soc-pcm186x-spi-objs := pcm186x-spi.o
 snd-soc-pcm3008-objs := pcm3008.o
 snd-soc-pcm3168a-objs := pcm3168a.o
 snd-soc-pcm3168a-i2c-objs := pcm3168a-i2c.o
@@ -345,6 +348,9 @@ obj-$(CONFIG_SND_SOC_PCM1681)	+= snd-soc-pcm1681.o
 obj-$(CONFIG_SND_SOC_PCM179X)	+= snd-soc-pcm179x-codec.o
 obj-$(CONFIG_SND_SOC_PCM179X_I2C)	+= snd-soc-pcm179x-i2c.o
 obj-$(CONFIG_SND_SOC_PCM179X_SPI)	+= snd-soc-pcm179x-spi.o
+obj-$(CONFIG_SND_SOC_PCM186X)	+= snd-soc-pcm186x.o
+obj-$(CONFIG_SND_SOC_PCM186X_I2C)	+= snd-soc-pcm186x-i2c.o
+obj-$(CONFIG_SND_SOC_PCM186X_SPI)	+= snd-soc-pcm186x-spi.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
 obj-$(CONFIG_SND_SOC_PCM3168A)	+= snd-soc-pcm3168a.o
 obj-$(CONFIG_SND_SOC_PCM3168A_I2C)	+= snd-soc-pcm3168a-i2c.o
diff --git a/sound/soc/codecs/pcm186x-i2c.c b/sound/soc/codecs/pcm186x-i2c.c
new file mode 100644
index 000000000000..b42f1390d45b
--- /dev/null
+++ b/sound/soc/codecs/pcm186x-i2c.c
@@ -0,0 +1,79 @@
+/*
+ * Texas Instruments PCM186x Universal Audio ADC - I2C
+ *
+ * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com
+ *	Andreas Dannenberg <dannenberg@ti.com>
+ *	Andrew F. Davis <afd@ti.com>
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
+#include <linux/i2c.h>
+
+#include "pcm186x.h"
+
+static const struct of_device_id pcm186x_of_match[] = {
+	{ .compatible = "ti,pcm1862", .data = (void *)PCM1862 },
+	{ .compatible = "ti,pcm1863", .data = (void *)PCM1863 },
+	{ .compatible = "ti,pcm1864", .data = (void *)PCM1864 },
+	{ .compatible = "ti,pcm1865", .data = (void *)PCM1865 },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pcm186x_of_match);
+
+static int pcm186x_i2c_probe(struct i2c_client *i2c,
+			     const struct i2c_device_id *id)
+{
+	const enum pcm186x_type type = (enum pcm186x_type)id->driver_data;
+	int irq = i2c->irq;
+	struct regmap *regmap;
+
+	dev_info(&i2c->dev, "%s() i2c->addr=%d\n", __func__, i2c->addr);
+
+	regmap = devm_regmap_init_i2c(i2c, &pcm186x_regmap);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return pcm186x_probe(&i2c->dev, type, irq, regmap);
+}
+
+static int pcm186x_i2c_remove(struct i2c_client *i2c)
+{
+	pcm186x_remove(&i2c->dev);
+	return 0;
+}
+
+static const struct i2c_device_id pcm186x_i2c_id[] = {
+	{ "pcm1862", PCM1862 },
+	{ "pcm1863", PCM1863 },
+	{ "pcm1864", PCM1864 },
+	{ "pcm1865", PCM1865 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pcm186x_i2c_id);
+
+static struct i2c_driver pcm186x_i2c_driver = {
+	.probe		= pcm186x_i2c_probe,
+	.remove		= pcm186x_i2c_remove,
+	.id_table	= pcm186x_i2c_id,
+	.driver		= {
+		.name	= "pcm186x",
+		.of_match_table = pcm186x_of_match,
+		.pm     = &pcm186x_pm_ops,
+	},
+};
+module_i2c_driver(pcm186x_i2c_driver);
+
+MODULE_DESCRIPTION("PCM186x Universal Audio ADC I2C Interface Driver");
+MODULE_AUTHOR("Andreas Dannenberg <dannenberg@ti.com>");
+MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/pcm186x-spi.c b/sound/soc/codecs/pcm186x-spi.c
new file mode 100644
index 000000000000..d15ccc20ef97
--- /dev/null
+++ b/sound/soc/codecs/pcm186x-spi.c
@@ -0,0 +1,79 @@
+/*
+ * Texas Instruments PCM186x Universal Audio ADC - SPI
+ *
+ * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com
+ *	Andreas Dannenberg <dannenberg@ti.com>
+ *	Andrew F. Davis <afd@ti.com>
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
+#include <linux/spi/spi.h>
+
+#include "pcm186x.h"
+
+static const struct of_device_id pcm186x_of_match[] = {
+	{ .compatible = "ti,pcm1862", .data = (void *)PCM1862 },
+	{ .compatible = "ti,pcm1863", .data = (void *)PCM1863 },
+	{ .compatible = "ti,pcm1864", .data = (void *)PCM1864 },
+	{ .compatible = "ti,pcm1865", .data = (void *)PCM1865 },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pcm186x_of_match);
+
+static int pcm186x_spi_probe(struct spi_device *spi)
+{
+	const enum pcm186x_type type =
+			 (enum pcm186x_type)spi_get_device_id(spi)->driver_data;
+	int irq = spi->irq;
+	struct regmap *regmap;
+
+	dev_info(&spi->dev, "%s()\n", __func__);
+
+	regmap = devm_regmap_init_spi(spi, &pcm186x_regmap);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return pcm186x_probe(&spi->dev, type, irq, regmap);
+}
+
+static int pcm186x_spi_remove(struct spi_device *spi)
+{
+	pcm186x_remove(&spi->dev);
+	return 0;
+}
+
+static const struct spi_device_id pcm186x_spi_id[] = {
+	{ "pcm1862", PCM1862 },
+	{ "pcm1863", PCM1863 },
+	{ "pcm1864", PCM1864 },
+	{ "pcm1865", PCM1865 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, pcm186x_spi_id);
+
+static struct spi_driver pcm186x_spi_driver = {
+	.probe		= pcm186x_spi_probe,
+	.remove		= pcm186x_spi_remove,
+	.id_table	= pcm186x_spi_id,
+	.driver		= {
+		.name	= "pcm186x",
+		.of_match_table = pcm186x_of_match,
+		.pm     = &pcm186x_pm_ops,
+	},
+};
+module_spi_driver(pcm186x_spi_driver);
+
+MODULE_DESCRIPTION("PCM186x Universal Audio ADC SPI Interface Driver");
+MODULE_AUTHOR("Andreas Dannenberg <dannenberg@ti.com>");
+MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/pcm186x.c b/sound/soc/codecs/pcm186x.c
new file mode 100644
index 000000000000..7217d01d0347
--- /dev/null
+++ b/sound/soc/codecs/pcm186x.c
@@ -0,0 +1,778 @@
+/*
+ * Texas Instruments PCM186x Universal Audio ADC
+ *
+ * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com
+ *	Andreas Dannenberg <dannenberg@ti.com>
+ *	Andrew F. Davis <afd@ti.com>
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
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/jack.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+
+#include "pcm186x.h"
+
+static const char * const pcm186x_supply_names[] = {
+	"avdd",		/* Analog power supply. Connect to 3.3-V supply. */
+	"dvdd",		/* Digital power supply. Connect to 3.3-V supply. */
+	"iovdd"		/* I/O power supply. Connect to 3.3-V or 1.8-V. */
+};
+#define PCM186x_NUM_SUPPLIES ARRAY_SIZE(pcm186x_supply_names)
+
+struct pcm186x_priv {
+	struct regmap *regmap;
+	struct regulator_bulk_data supplies[PCM186x_NUM_SUPPLIES];
+	unsigned int sysclk;
+	unsigned int tdm_offset;
+	bool is_tdm_mode;
+	bool is_master_mode;
+};
+
+static const DECLARE_TLV_DB_SCALE(pcm186x_pga_tlv, -1200, 4000, 50);
+
+static const struct snd_kcontrol_new pcm1863_snd_controls[] = {
+	SOC_DOUBLE_R_S_TLV("Analog Gain", PCM186X_PGA_VAL_CH1_L,
+			   PCM186X_PGA_VAL_CH1_R, 0, -24, 80, 7, 0,
+			   pcm186x_pga_tlv),
+};
+
+static const struct snd_kcontrol_new pcm1865_snd_controls[] = {
+	SOC_DOUBLE_R_S_TLV("ADC1 Analog Gain", PCM186X_PGA_VAL_CH1_L,
+			   PCM186X_PGA_VAL_CH1_R, 0, -24, 80, 7, 0,
+			   pcm186x_pga_tlv),
+	SOC_DOUBLE_R_S_TLV("ADC2 Analog Gain", PCM186X_PGA_VAL_CH2_L,
+			   PCM186X_PGA_VAL_CH2_R, 0, -24, 80, 7, 0,
+			   pcm186x_pga_tlv),
+};
+
+const unsigned int pcm186x_adc_input_channel_sel_value[] = {
+	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	0x10, 0x20, 0x30
+};
+
+static const char * const pcm186x_adcl_input_channel_sel_text[] = {
+	"No Select",
+	"VINL1[SE]",					/* Default for ADC1L */
+	"VINL2[SE]",					/* Default for ADC2L */
+	"VINL2[SE] + VINL1[SE]",
+	"VINL3[SE]",
+	"VINL3[SE] + VINL1[SE]",
+	"VINL3[SE] + VINL2[SE]",
+	"VINL3[SE] + VINL2[SE] + VINL1[SE]",
+	"VINL4[SE]",
+	"VINL4[SE] + VINL1[SE]",
+	"VINL4[SE] + VINL2[SE]",
+	"VINL4[SE] + VINL2[SE] + VINL1[SE]",
+	"VINL4[SE] + VINL3[SE]",
+	"VINL4[SE] + VINL3[SE] + VINL1[SE]",
+	"VINL4[SE] + VINL3[SE] + VINL2[SE]",
+	"VINL4[SE] + VINL3[SE] + VINL2[SE] + VINL1[SE]",
+	"{VIN1P, VIN1M}[DIFF]",
+	"{VIN4P, VIN4M}[DIFF]",
+	"{VIN1P, VIN1M}[DIFF] + {VIN4P, VIN4M}[DIFF]"
+};
+
+static const char * const pcm186x_adcr_input_channel_sel_text[] = {
+	"No Select",
+	"VINR1[SE]",					/* Default for ADC1R */
+	"VINR2[SE]",					/* Default for ADC2R */
+	"VINR2[SE] + VINR1[SE]",
+	"VINR3[SE]",
+	"VINR3[SE] + VINR1[SE]",
+	"VINR3[SE] + VINR2[SE]",
+	"VINR3[SE] + VINR2[SE] + VINR1[SE]",
+	"VINR4[SE]",
+	"VINR4[SE] + VINR1[SE]",
+	"VINR4[SE] + VINR2[SE]",
+	"VINR4[SE] + VINR2[SE] + VINR1[SE]",
+	"VINR4[SE] + VINR3[SE]",
+	"VINR4[SE] + VINR3[SE] + VINR1[SE]",
+	"VINR4[SE] + VINR3[SE] + VINR2[SE]",
+	"VINR4[SE] + VINR3[SE] + VINR2[SE] + VINR1[SE]",
+	"{VIN2P, VIN2M}[DIFF]",
+	"{VIN3P, VIN3M}[DIFF]",
+	"{VIN2P, VIN2M}[DIFF] + {VIN3P, VIN3M}[DIFF]"
+};
+
+static const struct soc_enum pcm186x_adc_input_channel_sel[] = {
+	SOC_VALUE_ENUM_SINGLE(PCM186X_ADC1_INPUT_SEL_L, 0,
+			      PCM186X_ADC_INPUT_SEL_MASK,
+			      ARRAY_SIZE(pcm186x_adcl_input_channel_sel_text),
+			      pcm186x_adcl_input_channel_sel_text,
+			      pcm186x_adc_input_channel_sel_value),
+	SOC_VALUE_ENUM_SINGLE(PCM186X_ADC1_INPUT_SEL_R, 0,
+			      PCM186X_ADC_INPUT_SEL_MASK,
+			      ARRAY_SIZE(pcm186x_adcr_input_channel_sel_text),
+			      pcm186x_adcr_input_channel_sel_text,
+			      pcm186x_adc_input_channel_sel_value),
+	SOC_VALUE_ENUM_SINGLE(PCM186X_ADC2_INPUT_SEL_L, 0,
+			      PCM186X_ADC_INPUT_SEL_MASK,
+			      ARRAY_SIZE(pcm186x_adcl_input_channel_sel_text),
+			      pcm186x_adcl_input_channel_sel_text,
+			      pcm186x_adc_input_channel_sel_value),
+	SOC_VALUE_ENUM_SINGLE(PCM186X_ADC2_INPUT_SEL_R, 0,
+			      PCM186X_ADC_INPUT_SEL_MASK,
+			      ARRAY_SIZE(pcm186x_adcr_input_channel_sel_text),
+			      pcm186x_adcr_input_channel_sel_text,
+			      pcm186x_adc_input_channel_sel_value),
+};
+
+static const struct snd_kcontrol_new pcm186x_adc_mux_controls[] = {
+	SOC_DAPM_ENUM("ADC1 Left Input", pcm186x_adc_input_channel_sel[0]),
+	SOC_DAPM_ENUM("ADC1 Right Input", pcm186x_adc_input_channel_sel[1]),
+	SOC_DAPM_ENUM("ADC2 Left Input", pcm186x_adc_input_channel_sel[2]),
+	SOC_DAPM_ENUM("ADC2 Right Input", pcm186x_adc_input_channel_sel[3]),
+};
+
+static const struct snd_soc_dapm_widget pcm1863_dapm_widgets[] = {
+	SND_SOC_DAPM_INPUT("VINL1"),
+	SND_SOC_DAPM_INPUT("VINR1"),
+	SND_SOC_DAPM_INPUT("VINL2"),
+	SND_SOC_DAPM_INPUT("VINR2"),
+	SND_SOC_DAPM_INPUT("VINL3"),
+	SND_SOC_DAPM_INPUT("VINR3"),
+	SND_SOC_DAPM_INPUT("VINL4"),
+	SND_SOC_DAPM_INPUT("VINR4"),
+
+	SND_SOC_DAPM_MUX("ADC Left Capture Source", SND_SOC_NOPM, 0, 0,
+			 &pcm186x_adc_mux_controls[0]),
+	SND_SOC_DAPM_MUX("ADC Right Capture Source", SND_SOC_NOPM, 0, 0,
+			 &pcm186x_adc_mux_controls[1]),
+
+	/*
+	 * Put the codec into SLEEP mode when not in use, allowing the
+	 * Energysense mechanism to operate.
+	 */
+	SND_SOC_DAPM_ADC("ADC", "HiFi Capture", PCM186X_POWER_CTRL, 1,  0),
+};
+
+static const struct snd_soc_dapm_widget pcm1865_dapm_widgets[] = {
+	SND_SOC_DAPM_INPUT("VINL1"),
+	SND_SOC_DAPM_INPUT("VINR1"),
+	SND_SOC_DAPM_INPUT("VINL2"),
+	SND_SOC_DAPM_INPUT("VINR2"),
+	SND_SOC_DAPM_INPUT("VINL3"),
+	SND_SOC_DAPM_INPUT("VINR3"),
+	SND_SOC_DAPM_INPUT("VINL4"),
+	SND_SOC_DAPM_INPUT("VINR4"),
+
+	SND_SOC_DAPM_MUX("ADC1 Left Capture Source", SND_SOC_NOPM, 0, 0,
+			 &pcm186x_adc_mux_controls[0]),
+	SND_SOC_DAPM_MUX("ADC1 Right Capture Source", SND_SOC_NOPM, 0, 0,
+			 &pcm186x_adc_mux_controls[1]),
+	SND_SOC_DAPM_MUX("ADC2 Left Capture Source", SND_SOC_NOPM, 0, 0,
+			 &pcm186x_adc_mux_controls[2]),
+	SND_SOC_DAPM_MUX("ADC2 Right Capture Source", SND_SOC_NOPM, 0, 0,
+			 &pcm186x_adc_mux_controls[3]),
+
+	/*
+	 * Put the codec into SLEEP mode when not in use, allowing the
+	 * Energysense mechanism to operate.
+	 */
+	SND_SOC_DAPM_ADC("ADC1", "HiFi Capture 1", PCM186X_POWER_CTRL, 1,  0),
+	SND_SOC_DAPM_ADC("ADC2", "HiFi Capture 2", PCM186X_POWER_CTRL, 1,  0),
+};
+
+static const struct snd_soc_dapm_route pcm1863_dapm_routes[] = {
+	{ "ADC Left Capture Source", NULL, "VINL1" },
+	{ "ADC Left Capture Source", NULL, "VINR1" },
+	{ "ADC Left Capture Source", NULL, "VINL2" },
+	{ "ADC Left Capture Source", NULL, "VINR2" },
+	{ "ADC Left Capture Source", NULL, "VINL3" },
+	{ "ADC Left Capture Source", NULL, "VINR3" },
+	{ "ADC Left Capture Source", NULL, "VINL4" },
+	{ "ADC Left Capture Source", NULL, "VINR4" },
+
+	{ "ADC", NULL, "ADC Left Capture Source" },
+
+	{ "ADC Right Capture Source", NULL, "VINL1" },
+	{ "ADC Right Capture Source", NULL, "VINR1" },
+	{ "ADC Right Capture Source", NULL, "VINL2" },
+	{ "ADC Right Capture Source", NULL, "VINR2" },
+	{ "ADC Right Capture Source", NULL, "VINL3" },
+	{ "ADC Right Capture Source", NULL, "VINR3" },
+	{ "ADC Right Capture Source", NULL, "VINL4" },
+	{ "ADC Right Capture Source", NULL, "VINR4" },
+
+	{ "ADC", NULL, "ADC Right Capture Source" },
+};
+
+static const struct snd_soc_dapm_route pcm1865_dapm_routes[] = {
+	{ "ADC1 Left Capture Source", NULL, "VINL1" },
+	{ "ADC1 Left Capture Source", NULL, "VINR1" },
+	{ "ADC1 Left Capture Source", NULL, "VINL2" },
+	{ "ADC1 Left Capture Source", NULL, "VINR2" },
+	{ "ADC1 Left Capture Source", NULL, "VINL3" },
+	{ "ADC1 Left Capture Source", NULL, "VINR3" },
+	{ "ADC1 Left Capture Source", NULL, "VINL4" },
+	{ "ADC1 Left Capture Source", NULL, "VINR4" },
+
+	{ "ADC1", NULL, "ADC1 Left Capture Source" },
+
+	{ "ADC1 Right Capture Source", NULL, "VINL1" },
+	{ "ADC1 Right Capture Source", NULL, "VINR1" },
+	{ "ADC1 Right Capture Source", NULL, "VINL2" },
+	{ "ADC1 Right Capture Source", NULL, "VINR2" },
+	{ "ADC1 Right Capture Source", NULL, "VINL3" },
+	{ "ADC1 Right Capture Source", NULL, "VINR3" },
+	{ "ADC1 Right Capture Source", NULL, "VINL4" },
+	{ "ADC1 Right Capture Source", NULL, "VINR4" },
+
+	{ "ADC1", NULL, "ADC1 Right Capture Source" },
+
+	{ "ADC2 Left Capture Source", NULL, "VINL1" },
+	{ "ADC2 Left Capture Source", NULL, "VINR1" },
+	{ "ADC2 Left Capture Source", NULL, "VINL2" },
+	{ "ADC2 Left Capture Source", NULL, "VINR2" },
+	{ "ADC2 Left Capture Source", NULL, "VINL3" },
+	{ "ADC2 Left Capture Source", NULL, "VINR3" },
+	{ "ADC2 Left Capture Source", NULL, "VINL4" },
+	{ "ADC2 Left Capture Source", NULL, "VINR4" },
+
+	{ "ADC2", NULL, "ADC2 Left Capture Source" },
+
+	{ "ADC2 Right Capture Source", NULL, "VINL1" },
+	{ "ADC2 Right Capture Source", NULL, "VINR1" },
+	{ "ADC2 Right Capture Source", NULL, "VINL2" },
+	{ "ADC2 Right Capture Source", NULL, "VINR2" },
+	{ "ADC2 Right Capture Source", NULL, "VINL3" },
+	{ "ADC2 Right Capture Source", NULL, "VINR3" },
+	{ "ADC2 Right Capture Source", NULL, "VINL4" },
+	{ "ADC2 Right Capture Source", NULL, "VINR4" },
+
+	{ "ADC2", NULL, "ADC2 Right Capture Source" },
+};
+
+static int pcm186x_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+
+	struct pcm186x_priv *priv = snd_soc_codec_get_drvdata(codec);
+	unsigned int rate = params_rate(params);
+	unsigned int format = params_format(params);
+	unsigned int width = params_width(params);
+	unsigned int channels = params_channels(params);
+	unsigned int div_lrck;
+	unsigned int div_bck;
+	u8 tdm_tx_sel = 0;
+	u8 pcm_cfg = 0;
+	int ret;
+
+	dev_dbg(codec->dev, "%s() rate=%u format=0x%x width=%u channels=%u\n",
+		__func__, rate, format, width, channels);
+
+	switch (width) {
+	case 16:
+		pcm_cfg = PCM186X_PCM_CFG_RX_WLEN_16 |
+			  PCM186X_PCM_CFG_TX_WLEN_16;
+		break;
+	case 20:
+		pcm_cfg = PCM186X_PCM_CFG_RX_WLEN_20 |
+			  PCM186X_PCM_CFG_TX_WLEN_20;
+		break;
+	case 24:
+		pcm_cfg = PCM186X_PCM_CFG_RX_WLEN_24 |
+			  PCM186X_PCM_CFG_TX_WLEN_24;
+		break;
+	case 32:
+		pcm_cfg = PCM186X_PCM_CFG_RX_WLEN_32 |
+			  PCM186X_PCM_CFG_TX_WLEN_32;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_update_bits(codec, PCM186X_PCM_CFG,
+			    PCM186X_PCM_CFG_RX_WLEN_MASK |
+			    PCM186X_PCM_CFG_TX_WLEN_MASK,
+			    pcm_cfg);
+
+	div_lrck = width * channels;
+
+	if (priv->is_tdm_mode) {
+		/* Select TDM transmission data */
+		switch (channels) {
+		case 2:
+			tdm_tx_sel = PCM186X_TDM_TX_SEL_2CH;
+			break;
+		case 4:
+			tdm_tx_sel = PCM186X_TDM_TX_SEL_4CH;
+			break;
+		case 6:
+			tdm_tx_sel = PCM186X_TDM_TX_SEL_6CH;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		snd_soc_update_bits(codec, PCM186X_TDM_TX_SEL,
+				    PCM186X_TDM_TX_SEL_MASK, tdm_tx_sel);
+
+		/* In DSP/TDM mode, the LRCLK divider must be 256 */
+		div_lrck = 256;
+
+		/* Configure 1/256 duty cycle for LRCK */
+		snd_soc_update_bits(codec, PCM186X_PCM_CFG,
+				    PCM186X_PCM_CFG_TDM_LRCK_MODE,
+				    PCM186X_PCM_CFG_TDM_LRCK_MODE);
+	}
+
+	/* Only configure clock dividers in master mode. */
+	if (priv->is_master_mode) {
+		div_bck = priv->sysclk / (div_lrck * rate);
+
+		dev_dbg(codec->dev,
+			"%s() master_clk=%u div_bck=%u div_lrck=%u\n",
+			__func__, priv->sysclk, div_bck, div_lrck);
+
+		ret = regmap_write(priv->regmap, PCM186X_BCK_DIV, div_bck - 1);
+		if (ret < 0) {
+			dev_err(codec->dev,
+				"failed to write register: %d\n", ret);
+			return ret;
+		}
+
+		ret = regmap_write(priv->regmap, PCM186X_LRK_DIV,
+				   div_lrck - 1);
+		if (ret < 0) {
+			dev_err(codec->dev, "failed to write register: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int pcm186x_set_fmt(struct snd_soc_dai *dai, unsigned int format)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct pcm186x_priv *priv = snd_soc_codec_get_drvdata(codec);
+	u8 clk_ctrl = 0;
+	u8 pcm_cfg = 0;
+
+	dev_dbg(codec->dev, "%s() format=0x%x\n", __func__, format);
+
+	/* set master/slave audio interface */
+	switch (format & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		if (!priv->sysclk) {
+			dev_err(codec->dev, "operating in master mode requires sysclock to be configured!\n");
+			return -EINVAL;
+		}
+		clk_ctrl |= PCM186X_CLK_CTRL_MST_MODE;
+		priv->is_master_mode = true;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		priv->is_master_mode = false;
+		break;
+	default:
+		dev_alert(codec->dev, "Invalid DAI master/slave interface\n");
+		return -EINVAL;
+	}
+
+	snd_soc_update_bits(codec, PCM186X_CLK_CTRL,
+			    PCM186X_CLK_CTRL_MST_MODE, clk_ctrl);
+
+	/* set interface polarity */
+	switch (format & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	default:
+		dev_alert(codec->dev, "Inverted DAI clocks not supported\n");
+		return -EINVAL;
+	}
+
+	/* set interface format */
+	switch (format & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		pcm_cfg = PCM186X_PCM_CFG_FMT_I2S;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		pcm_cfg = PCM186X_PCM_CFG_FMT_LEFTJ;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		priv->tdm_offset += 1;
+		/* Fall through... DSP_A uses the same basic config as DSP_B
+		 * except we need to shift the TDM output by one BCK cycle
+		 */
+	case SND_SOC_DAIFMT_DSP_B:
+		priv->is_tdm_mode = true;
+		pcm_cfg = PCM186X_PCM_CFG_FMT_TDM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_write(codec, PCM186X_TDM_TX_OFFSET, priv->tdm_offset);
+
+	snd_soc_update_bits(codec, PCM186X_PCM_CFG,
+			    PCM186X_PCM_CFG_FMT_MASK, pcm_cfg);
+
+	return 0;
+}
+
+static int pcm186x_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+				unsigned int rx_mask, int slots, int slot_width)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct pcm186x_priv *priv = snd_soc_codec_get_drvdata(codec);
+	unsigned int first_slot, last_slot, tdm_offset;
+
+	dev_dbg(codec->dev,
+		"%s() tx_mask=0x%x rx_mask=0x%x slots=%d slot_width=%d\n",
+		__func__, tx_mask, rx_mask, slots, slot_width);
+
+	if (!tx_mask) {
+		dev_err(codec->dev, "tdm tx mask must not be 0\n");
+		return -EINVAL;
+	}
+
+	first_slot = __ffs(tx_mask);
+	last_slot = __fls(tx_mask);
+
+	if (last_slot - first_slot != hweight32(tx_mask) - 1) {
+		dev_err(codec->dev, "tdm tx mask must be contiguous\n");
+		return -EINVAL;
+	}
+
+	tdm_offset = first_slot * slot_width;
+
+	if (tdm_offset > 255) {
+		dev_err(codec->dev, "tdm tx slot selection out of bounds\n");
+		return -EINVAL;
+	}
+
+	priv->tdm_offset = tdm_offset;
+
+	return 0;
+}
+
+static int pcm186x_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
+				  unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct pcm186x_priv *priv = snd_soc_codec_get_drvdata(codec);
+
+	dev_dbg(codec->dev, "%s() clk_id=%d freq=%u dir=%d\n",
+		__func__, clk_id, freq, dir);
+
+	priv->sysclk = freq;
+
+	return 0;
+}
+
+const struct snd_soc_dai_ops pcm186x_dai_ops = {
+	.set_sysclk = pcm186x_set_dai_sysclk,
+	.set_tdm_slot = pcm186x_set_tdm_slot,
+	.set_fmt = pcm186x_set_fmt,
+	.hw_params = pcm186x_hw_params,
+
+};
+
+static struct snd_soc_dai_driver pcm1863_dai = {
+	.name = "pcm1863-aif",
+	.capture = {
+		 .stream_name = "AIF Capture",
+		 .channels_min = 1,
+		 .channels_max = 2,
+		 .rates = PCM186X_RATES,
+		 .formats = PCM186X_FORMATS,
+	 },
+	.ops = &pcm186x_dai_ops,
+};
+
+static struct snd_soc_dai_driver pcm1865_dai = {
+	.name = "pcm1865-aif",
+	.capture = {
+		 .stream_name = "AIF Capture",
+		 .channels_min = 1,
+		 .channels_max = 4,
+		 .rates = PCM186X_RATES,
+		 .formats = PCM186X_FORMATS,
+	 },
+	.ops = &pcm186x_dai_ops,
+};
+
+static int pcm186x_power_on(struct snd_soc_codec *codec)
+{
+	struct pcm186x_priv *priv = snd_soc_codec_get_drvdata(codec);
+	int ret = 0;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(priv->supplies),
+				    priv->supplies);
+	if (ret)
+		return ret;
+
+	regcache_cache_only(priv->regmap, false);
+	ret = regcache_sync(priv->regmap);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to restore cache\n");
+		regcache_cache_only(priv->regmap, true);
+		regulator_bulk_disable(ARRAY_SIZE(priv->supplies),
+				       priv->supplies);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int pcm186x_power_off(struct snd_soc_codec *codec)
+{
+	struct pcm186x_priv *priv = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	regcache_cache_only(priv->regmap, true);
+	ret = regulator_bulk_disable(ARRAY_SIZE(priv->supplies),
+				     priv->supplies);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int pcm186x_set_bias_level(struct snd_soc_codec *codec,
+				  enum snd_soc_bias_level level)
+{
+	dev_dbg(codec->dev, "## %s: %d -> %d\n", __func__,
+		snd_soc_codec_get_bias_level(codec), level);
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		pcm186x_power_on(codec);
+		break;
+	case SND_SOC_BIAS_OFF:
+		pcm186x_power_off(codec);
+		break;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_codec_driver soc_codec_dev_pcm1863 = {
+	.set_bias_level = pcm186x_set_bias_level,
+
+	.component_driver = {
+		.controls = pcm1863_snd_controls,
+		.num_controls = ARRAY_SIZE(pcm1863_snd_controls),
+		.dapm_widgets = pcm1863_dapm_widgets,
+		.num_dapm_widgets = ARRAY_SIZE(pcm1863_dapm_widgets),
+		.dapm_routes = pcm1863_dapm_routes,
+		.num_dapm_routes = ARRAY_SIZE(pcm1863_dapm_routes),
+	},
+};
+
+static struct snd_soc_codec_driver soc_codec_dev_pcm1865 = {
+	.set_bias_level = pcm186x_set_bias_level,
+
+	.component_driver = {
+		.controls = pcm1865_snd_controls,
+		.num_controls = ARRAY_SIZE(pcm1865_snd_controls),
+		.dapm_widgets = pcm1865_dapm_widgets,
+		.num_dapm_widgets = ARRAY_SIZE(pcm1865_dapm_widgets),
+		.dapm_routes = pcm1865_dapm_routes,
+		.num_dapm_routes = ARRAY_SIZE(pcm1865_dapm_routes),
+	},
+};
+
+static bool pcm186x_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case PCM186X_PAGE:
+	case PCM186X_DEVICE_STATUS:
+	case PCM186X_FSAMPLE_STATUS:
+	case PCM186X_DIV_STATUS:
+	case PCM186X_CLK_STATUS:
+	case PCM186X_SUPPLY_STATUS:
+	case PCM186X_MMAP_STAT_CTRL:
+	case PCM186X_MMAP_ADDRESS:
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * The PCM186x's page register is located on every page, allowing to program it
+ * without having to switch pages. Take advantage of this by defining the range
+ * such to have this register located inside the data window.
+ */
+static const struct regmap_range_cfg pcm186x_range = {
+	.name = "Pages",
+	.range_max = PCM186X_MAX_REGISTER,
+	.selector_reg = PCM186X_PAGE,
+	.selector_mask = 0xff,
+	.window_len = PCM186X_PAGE_LEN,
+};
+
+const struct regmap_config pcm186x_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.volatile_reg = pcm186x_volatile,
+
+	.ranges = &pcm186x_range,
+	.num_ranges = 1,
+
+	.max_register = PCM186X_MAX_REGISTER,
+
+	.cache_type = REGCACHE_RBTREE,
+};
+EXPORT_SYMBOL_GPL(pcm186x_regmap);
+
+int pcm186x_probe(struct device *dev, enum pcm186x_type type, int irq,
+		  struct regmap *regmap)
+{
+	struct pcm186x_priv *priv;
+	int i, ret;
+
+	dev_dbg(dev, "%s()\n", __func__);
+
+	priv = devm_kzalloc(dev, sizeof(struct pcm186x_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, priv);
+	priv->regmap = regmap;
+
+	for (i = 0; i < ARRAY_SIZE(priv->supplies); i++)
+		priv->supplies[i].supply = pcm186x_supply_names[i];
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(priv->supplies),
+				      priv->supplies);
+	if (ret != 0) {
+		dev_err(dev, "failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
+	/* Reset device registers for a consistent power-on like state */
+	ret = regmap_write(regmap, PCM186X_PAGE, PCM186X_RESET);
+	if (ret != 0) {
+		dev_err(dev, "failed to write device: %d\n", ret);
+		return ret;
+	}
+
+	switch (type) {
+	case PCM1865:
+	case PCM1864:
+		ret = snd_soc_register_codec(dev, &soc_codec_dev_pcm1865,
+					     &pcm1865_dai, 1);
+		break;
+	case PCM1863:
+	case PCM1862:
+		/* Fall through... */
+	default:
+		ret = snd_soc_register_codec(dev, &soc_codec_dev_pcm1863,
+					     &pcm1863_dai, 1);
+	}
+	if (ret != 0) {
+		dev_err(dev, "failed to register CODEC: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pcm186x_probe);
+
+int pcm186x_remove(struct device *dev)
+{
+	snd_soc_unregister_codec(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pcm186x_remove);
+
+static int  __maybe_unused pcm186x_suspend(struct device *dev)
+{
+	struct pcm186x_priv *priv = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(dev, "%s()\n", __func__);
+
+	ret = regmap_update_bits(priv->regmap, PCM186X_POWER_CTRL,
+				 PCM186X_PWR_CTRL_PWRDN,
+				 PCM186X_PWR_CTRL_PWRDN);
+	if (ret != 0) {
+		dev_err(dev, "failed to write register: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_bulk_disable(ARRAY_SIZE(priv->supplies),
+				     priv->supplies);
+	if (ret != 0) {
+		dev_err(dev, "failed to disable supplies: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int  __maybe_unused pcm186x_resume(struct device *dev)
+{
+	struct pcm186x_priv *priv = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(dev, "%s()\n", __func__);
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(priv->supplies),
+				    priv->supplies);
+	if (ret != 0) {
+		dev_err(dev, "failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
+	regcache_cache_only(priv->regmap, false);
+	ret = regcache_sync(priv->regmap);
+	if (ret != 0) {
+		dev_err(dev, "failed to sync cache: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(priv->regmap, PCM186X_POWER_CTRL,
+				 PCM186X_PWR_CTRL_PWRDN, 0);
+	if (ret != 0) {
+		dev_err(dev, "failed to write register: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+const struct dev_pm_ops pcm186x_pm_ops = {
+	SET_RUNTIME_PM_OPS(pcm186x_suspend, pcm186x_resume, NULL)
+};
+EXPORT_SYMBOL_GPL(pcm186x_pm_ops);
+
+MODULE_DESCRIPTION("PCM186x Universal Audio ADC driver");
+MODULE_AUTHOR("Andreas Dannenberg <dannenberg@ti.com>");
+MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/pcm186x.h b/sound/soc/codecs/pcm186x.h
new file mode 100644
index 000000000000..631f7db8e868
--- /dev/null
+++ b/sound/soc/codecs/pcm186x.h
@@ -0,0 +1,271 @@
+/*
+ * Texas Instruments PCM186x Universal Audio ADC
+ *
+ * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com
+ *	Andreas Dannenberg <dannenberg@ti.com>
+ *	Andrew F. Davis <afd@ti.com>
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
+#ifndef _PCM186X_H_
+#define _PCM186X_H_
+
+#include <linux/pm.h>
+#include <linux/regmap.h>
+
+enum pcm186x_type {
+	PCM1862,
+	PCM1863,
+	PCM1864,
+	PCM1865,
+};
+
+#define PCM186X_RATES	SNDRV_PCM_RATE_8000_192000
+#define PCM186X_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+			 SNDRV_PCM_FMTBIT_S20_3LE |\
+			 SNDRV_PCM_FMTBIT_S24_LE | \
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+#define PCM186X_PAGE_LEN		0x0100
+#define PCM186X_PAGE_BASE(n)		(PCM186X_PAGE_LEN * n)
+
+/* The page selection register address is the same on all pages */
+#define PCM186X_PAGE			0
+
+/* Register Definitions - Page 0 */
+#define PCM186X_PGA_VAL_CH1_L		(PCM186X_PAGE_BASE(0) +   1)
+#define PCM186X_PGA_VAL_CH1_R		(PCM186X_PAGE_BASE(0) +   2)
+#define PCM186X_PGA_VAL_CH2_L		(PCM186X_PAGE_BASE(0) +   3)
+#define PCM186X_PGA_VAL_CH2_R		(PCM186X_PAGE_BASE(0) +   4)
+#define PCM186X_PGA_CTRL		(PCM186X_PAGE_BASE(0) +   5)
+#define PCM186X_ADC1_INPUT_SEL_L	(PCM186X_PAGE_BASE(0) +   6)
+#define PCM186X_ADC1_INPUT_SEL_R	(PCM186X_PAGE_BASE(0) +   7)
+#define PCM186X_ADC2_INPUT_SEL_L	(PCM186X_PAGE_BASE(0) +   8)
+#define PCM186X_ADC2_INPUT_SEL_R	(PCM186X_PAGE_BASE(0) +   9)
+#define PCM186X_AUXADC_INPUT_SEL	(PCM186X_PAGE_BASE(0) +  10)
+#define PCM186X_PCM_CFG			(PCM186X_PAGE_BASE(0) +  11)
+#define PCM186X_TDM_TX_SEL		(PCM186X_PAGE_BASE(0) +  12)
+#define PCM186X_TDM_TX_OFFSET		(PCM186X_PAGE_BASE(0) +  13)
+#define PCM186X_TDM_RX_OFFSET		(PCM186X_PAGE_BASE(0) +  14)
+#define PCM186X_DPGA_VAL_CH1_L		(PCM186X_PAGE_BASE(0) +  15)
+#define PCM186X_GPIO1_0_CTRL		(PCM186X_PAGE_BASE(0) +  16)
+#define PCM186X_GPIO3_2_CTRL		(PCM186X_PAGE_BASE(0) +  17)
+#define PCM186X_GPIO1_0_DIR_CTRL	(PCM186X_PAGE_BASE(0) +  18)
+#define PCM186X_GPIO3_2_DIR_CTRL	(PCM186X_PAGE_BASE(0) +  19)
+#define PCM186X_GPIO_IN_OUT		(PCM186X_PAGE_BASE(0) +  20)
+#define PCM186X_GPIO_PULL_CTRL		(PCM186X_PAGE_BASE(0) +  21)
+#define PCM186X_DPGA_VAL_CH1_R		(PCM186X_PAGE_BASE(0) +  22)
+#define PCM186X_DPGA_VAL_CH2_L		(PCM186X_PAGE_BASE(0) +  23)
+#define PCM186X_DPGA_VAL_CH2_R		(PCM186X_PAGE_BASE(0) +  24)
+#define PCM186X_DPGA_GAIN_CTRL		(PCM186X_PAGE_BASE(0) +  25)
+#define PCM186X_DPGA_MIC_CTRL		(PCM186X_PAGE_BASE(0) +  26)
+#define PCM186X_DIN_RESAMP_CTRL		(PCM186X_PAGE_BASE(0) +  27)
+#define PCM186X_CLK_CTRL		(PCM186X_PAGE_BASE(0) +  32)
+#define PCM186X_DSP1_CLK_DIV		(PCM186X_PAGE_BASE(0) +  33)
+#define PCM186X_DSP2_CLK_DIV		(PCM186X_PAGE_BASE(0) +  34)
+#define PCM186X_ADC_CLK_DIV		(PCM186X_PAGE_BASE(0) +  35)
+#define PCM186X_PLL_SCK_DIV		(PCM186X_PAGE_BASE(0) +  37)
+#define PCM186X_BCK_DIV			(PCM186X_PAGE_BASE(0) +  38)
+#define PCM186X_LRK_DIV			(PCM186X_PAGE_BASE(0) +  39)
+#define PCM186X_PLL_CTRL		(PCM186X_PAGE_BASE(0) +  40)
+#define PCM186X_PLL_P_DIV		(PCM186X_PAGE_BASE(0) +  41)
+#define PCM186X_PLL_R_DIV		(PCM186X_PAGE_BASE(0) +  42)
+#define PCM186X_PLL_J_DIV		(PCM186X_PAGE_BASE(0) +  43)
+#define PCM186X_PLL_D_DIV_LSB		(PCM186X_PAGE_BASE(0) +  44)
+#define PCM186X_PLL_D_DIV_MSB		(PCM186X_PAGE_BASE(0) +  45)
+#define PCM186X_SIGDET_MODE		(PCM186X_PAGE_BASE(0) +  48)
+#define PCM186X_SIGDET_MASK		(PCM186X_PAGE_BASE(0) +  49)
+#define PCM186X_SIGDET_STAT		(PCM186X_PAGE_BASE(0) +  50)
+#define PCM186X_SIGDET_LOSS_TIME	(PCM186X_PAGE_BASE(0) +  52)
+#define PCM186X_SIGDET_SCAN_TIME	(PCM186X_PAGE_BASE(0) +  53)
+#define PCM186X_SIGDET_INT_INTVL	(PCM186X_PAGE_BASE(0) +  54)
+#define PCM186X_SIGDET_DC_REF_CH1_L	(PCM186X_PAGE_BASE(0) +  64)
+#define PCM186X_SIGDET_DC_DIFF_CH1_L	(PCM186X_PAGE_BASE(0) +  65)
+#define PCM186X_SIGDET_DC_LEV_CH1_L	(PCM186X_PAGE_BASE(0) +  66)
+#define PCM186X_SIGDET_DC_REF_CH1_R	(PCM186X_PAGE_BASE(0) +  67)
+#define PCM186X_SIGDET_DC_DIFF_CH1_R	(PCM186X_PAGE_BASE(0) +  68)
+#define PCM186X_SIGDET_DC_LEV_CH1_R	(PCM186X_PAGE_BASE(0) +  69)
+#define PCM186X_SIGDET_DC_REF_CH2_L	(PCM186X_PAGE_BASE(0) +  70)
+#define PCM186X_SIGDET_DC_DIFF_CH2_L	(PCM186X_PAGE_BASE(0) +  71)
+#define PCM186X_SIGDET_DC_LEV_CH2_L	(PCM186X_PAGE_BASE(0) +  72)
+#define PCM186X_SIGDET_DC_REF_CH2_R	(PCM186X_PAGE_BASE(0) +  73)
+#define PCM186X_SIGDET_DC_DIFF_CH2_R	(PCM186X_PAGE_BASE(0) +  74)
+#define PCM186X_SIGDET_DC_LEV_CH2_R	(PCM186X_PAGE_BASE(0) +  75)
+#define PCM186X_SIGDET_DC_REF_CH3_L	(PCM186X_PAGE_BASE(0) +  76)
+#define PCM186X_SIGDET_DC_DIFF_CH3_L	(PCM186X_PAGE_BASE(0) +  77)
+#define PCM186X_SIGDET_DC_LEV_CH3_L	(PCM186X_PAGE_BASE(0) +  78)
+#define PCM186X_SIGDET_DC_REF_CH3_R	(PCM186X_PAGE_BASE(0) +  79)
+#define PCM186X_SIGDET_DC_DIFF_CH3_R	(PCM186X_PAGE_BASE(0) +  80)
+#define PCM186X_SIGDET_DC_LEV_CH3_R	(PCM186X_PAGE_BASE(0) +  81)
+#define PCM186X_SIGDET_DC_REF_CH4_L	(PCM186X_PAGE_BASE(0) +  82)
+#define PCM186X_SIGDET_DC_DIFF_CH4_L	(PCM186X_PAGE_BASE(0) +  83)
+#define PCM186X_SIGDET_DC_LEV_CH4_L	(PCM186X_PAGE_BASE(0) +  84)
+#define PCM186X_SIGDET_DC_REF_CH4_R	(PCM186X_PAGE_BASE(0) +  85)
+#define PCM186X_SIGDET_DC_DIFF_CH4_R	(PCM186X_PAGE_BASE(0) +  86)
+#define PCM186X_SIGDET_DC_LEV_CH4_R	(PCM186X_PAGE_BASE(0) +  87)
+#define PCM186X_AUXADC_DATA_CTRL	(PCM186X_PAGE_BASE(0) +  88)
+#define PCM186X_AUXADC_DATA_LSB		(PCM186X_PAGE_BASE(0) +  89)
+#define PCM186X_AUXADC_DATA_MSB		(PCM186X_PAGE_BASE(0) +  90)
+#define PCM186X_INT_ENABLE		(PCM186X_PAGE_BASE(0) +  96)
+#define PCM186X_INT_FLAG		(PCM186X_PAGE_BASE(0) +  97)
+#define PCM186X_INT_POL_WIDTH		(PCM186X_PAGE_BASE(0) +  98)
+#define PCM186X_POWER_CTRL		(PCM186X_PAGE_BASE(0) + 112)
+#define PCM186X_FILTER_MUTE_CTRL	(PCM186X_PAGE_BASE(0) + 113)
+#define PCM186X_DEVICE_STATUS		(PCM186X_PAGE_BASE(0) + 114)
+#define PCM186X_FSAMPLE_STATUS		(PCM186X_PAGE_BASE(0) + 115)
+#define PCM186X_DIV_STATUS		(PCM186X_PAGE_BASE(0) + 116)
+#define PCM186X_CLK_STATUS		(PCM186X_PAGE_BASE(0) + 117)
+#define PCM186X_SUPPLY_STATUS		(PCM186X_PAGE_BASE(0) + 120)
+
+/* Register Definitions - Page 1 */
+#define PCM186X_MMAP_STAT_CTRL		(PCM186X_PAGE_BASE(1) +   1)
+#define PCM186X_MMAP_ADDRESS		(PCM186X_PAGE_BASE(1) +   2)
+#define PCM186X_MEM_WDATA0		(PCM186X_PAGE_BASE(1) +   4)
+#define PCM186X_MEM_WDATA1		(PCM186X_PAGE_BASE(1) +   5)
+#define PCM186X_MEM_WDATA2		(PCM186X_PAGE_BASE(1) +   6)
+#define PCM186X_MEM_WDATA3		(PCM186X_PAGE_BASE(1) +   7)
+#define PCM186X_MEM_RDATA0		(PCM186X_PAGE_BASE(1) +   8)
+#define PCM186X_MEM_RDATA1		(PCM186X_PAGE_BASE(1) +   9)
+#define PCM186X_MEM_RDATA2		(PCM186X_PAGE_BASE(1) +  10)
+#define PCM186X_MEM_RDATA3		(PCM186X_PAGE_BASE(1) +  11)
+
+/* Register Definitions - Page 3 */
+#define PCM186X_OSC_PWR_DOWN_CTRL	(PCM186X_PAGE_BASE(3) +  18)
+#define PCM186X_MIC_BIAS_CTRL		(PCM186X_PAGE_BASE(3) +  21)
+
+/* Register Definitions - Page 253 */
+#define PCM186X_CURR_TRIM_CTRL		(PCM186X_PAGE_BASE(253) +  20)
+
+#define PCM186X_MAX_REGISTER		PCM186X_CURR_TRIM_CTRL
+
+/*
+ * Register definitions for DSP accessed indirectly through PCM186X_MEM_X using
+ * a special sequence. Each of the registers holds 24 bits. See device data
+ * sheet for details.
+ */
+#define PCM186X_DSP_MIX1_CH1L		0x00
+#define PCM186X_DSP_MIX1_CH1R		0x01
+#define PCM186X_DSP_MIX1_CH2L		0x02
+#define PCM186X_DSP_MIX1_CH2R		0x03
+#define PCM186X_DSP_MIX1_I2SL		0x04
+#define PCM186X_DSP_MIX1_I2SR		0x05
+#define PCM186X_DSP_MIX2_CH1L		0x06
+#define PCM186X_DSP_MIX2_CH1R		0x07
+#define PCM186X_DSP_MIX2_CH2L		0x08
+#define PCM186X_DSP_MIX2_CH2R		0x09
+#define PCM186X_DSP_MIX2_I2SL		0x0a
+#define PCM186X_DSP_MIX2_I2SR		0x0b
+#define PCM186X_DSP_MIX3_CH1L		0x0c
+#define PCM186X_DSP_MIX3_CH1R		0x0d
+#define PCM186X_DSP_MIX3_CH2L		0x0e
+#define PCM186X_DSP_MIX3_CH2R		0x0f
+#define PCM186X_DSP_MIX3_I2SL		0x10
+#define PCM186X_DSP_MIX3_I2SR		0x11
+#define PCM186X_DSP_MIX4_CH1L		0x12
+#define PCM186X_DSP_MIX4_CH1R		0x13
+#define PCM186X_DSP_MIX4_CH2L		0x14
+#define PCM186X_DSP_MIX4_CH2R		0x15
+#define PCM186X_DSP_MIX4_I2SL		0x16
+#define PCM186X_DSP_MIX4_I2SR		0x17
+#define PCM186X_DSP_LPF_B0		0x20
+#define PCM186X_DSP_LPF_B1		0x21
+#define PCM186X_DSP_LPF_B2		0x22
+#define PCM186X_DSP_LPF_A1		0x23
+#define PCM186X_DSP_LPF_A2		0x24
+#define PCM186X_DSP_HPF_B0		0x25
+#define PCM186X_DSP_HPF_B1		0x26
+#define PCM186X_DSP_HPF_B2		0x27
+#define PCM186X_DSP_HPF_A1		0x28
+#define PCM186X_DSP_HPF_A2		0x29
+#define PCM186X_DSP_LOSS_THRESH		0x2c
+#define PCM186X_DSP_RES_THRESH		0x2d
+
+/* PCM186X_PAGE */
+#define PCM186X_PAGE_0			0x00
+#define PCM186X_PAGE_1			0x01
+#define PCM186X_PAGE_3			0x03
+#define PCM186X_RESET			0xff
+
+/* PCM186X_ADCX_INPUT_SEL_X */
+#define PCM186X_ADC_INPUT_SEL_POL	BIT(7)
+#define PCM186X_ADC_INPUT_SEL_MASK	GENMASK(5, 0)
+
+/* PCM186X_PCM_CFG */
+#define PCM186X_PCM_CFG_RX_WLEN_32	(0x0 << 6)
+#define PCM186X_PCM_CFG_RX_WLEN_24	(0x1 << 6)
+#define PCM186X_PCM_CFG_RX_WLEN_20	(0x2 << 6)
+#define PCM186X_PCM_CFG_RX_WLEN_16	(0x3 << 6)
+#define PCM186X_PCM_CFG_RX_WLEN_MASK	GENMASK(7, 6)
+#define PCM186X_PCM_CFG_TDM_LRCK_MODE	BIT(4)
+#define PCM186X_PCM_CFG_TX_WLEN_32	(0x0 << 2)
+#define PCM186X_PCM_CFG_TX_WLEN_24	(0x1 << 2)
+#define PCM186X_PCM_CFG_TX_WLEN_20	(0x2 << 2)
+#define PCM186X_PCM_CFG_TX_WLEN_16	(0x3 << 2)
+#define PCM186X_PCM_CFG_TX_WLEN_MASK	GENMASK(3, 2)
+#define PCM186X_PCM_CFG_FMT_I2S		0x00
+#define PCM186X_PCM_CFG_FMT_LEFTJ	0x01
+#define PCM186X_PCM_CFG_FMT_RIGHTJ	0x02
+#define PCM186X_PCM_CFG_FMT_TDM		0x03
+#define PCM186X_PCM_CFG_FMT_MASK	GENMASK(1, 0)
+
+/* PCM186X_TDM_TX_SEL */
+#define PCM186X_TDM_TX_SEL_2CH		0x00
+#define PCM186X_TDM_TX_SEL_4CH		0x01
+#define PCM186X_TDM_TX_SEL_6CH		0x02
+#define PCM186X_TDM_TX_SEL_MASK		0x03
+
+/* PCM186X_CLK_CTRL */
+#define PCM186X_CLK_CTRL_SCK_XI_SEL1	BIT(7)
+#define PCM186X_CLK_CTRL_SCK_XI_SEL0	BIT(6)
+#define PCM186X_CLK_CTRL_SCK_SRC_PLL	BIT(5)
+#define PCM186X_CLK_CTRL_MST_MODE	BIT(4)
+#define PCM186X_CLK_CTRL_ADC_SRC_PLL	BIT(3)
+#define PCM186X_CLK_CTRL_DSP2_SRC_PLL	BIT(2)
+#define PCM186X_CLK_CTRL_DSP1_SRC_PLL	BIT(1)
+#define PCM186X_CLK_CTRL_CLKDET_EN	BIT(0)
+
+/* PCM186X_PLL_CTRL */
+#define PCM186X_PLL_CTRL_LOCK		BIT(4)
+#define PCM186X_PLL_CTRL_REF_SEL	BIT(1)
+#define PCM186X_PLL_CTRL_EN		BIT(0)
+
+/* PCM186X_POWER_CTRL */
+#define PCM186X_PWR_CTRL_PWRDN		BIT(2)
+#define PCM186X_PWR_CTRL_SLEEP		BIT(1)
+#define PCM186X_PWR_CTRL_STBY		BIT(0)
+
+/* PCM186X_CLK_STATUS */
+#define PCM186X_CLK_STATUS_LRCKHLT	BIT(6)
+#define PCM186X_CLK_STATUS_BCKHLT	BIT(5)
+#define PCM186X_CLK_STATUS_SCKHLT	BIT(4)
+#define PCM186X_CLK_STATUS_LRCKERR	BIT(2)
+#define PCM186X_CLK_STATUS_BCKERR	BIT(1)
+#define PCM186X_CLK_STATUS_SCKERR	BIT(0)
+
+/* PCM186X_SUPPLY_STATUS */
+#define PCM186X_SUPPLY_STATUS_DVDD	BIT(2)
+#define PCM186X_SUPPLY_STATUS_AVDD	BIT(1)
+#define PCM186X_SUPPLY_STATUS_LDO	BIT(0)
+
+/* PCM186X_MMAP_STAT_CTRL */
+#define PCM186X_MMAP_STAT_DONE		BIT(4)
+#define PCM186X_MMAP_STAT_BUSY		BIT(2)
+#define PCM186X_MMAP_STAT_R_REQ		BIT(1)
+#define PCM186X_MMAP_STAT_W_REQ		BIT(0)
+
+extern const struct dev_pm_ops pcm186x_pm_ops;
+extern const struct regmap_config pcm186x_regmap;
+
+int pcm186x_probe(struct device *dev, enum pcm186x_type type, int irq,
+		  struct regmap *regmap);
+int pcm186x_remove(struct device *dev);
+
+#endif /* _PCM186X_H_ */
-- 
2.15.0
