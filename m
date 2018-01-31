From: Cosmin-Gabriel Samoila <cosmin.samoila-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH] ASoC: codecs: Add support for AK4458 DAC driver
Date: Wed, 31 Jan 2018 15:20:09 +0200
Message-ID: <1517404809-25250-1-git-send-email-cosmin.samoila@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wakasugi.jb-r6lgfPJHJciWyREYz5tgSuqrae++aQT8@public.gmane.org, shengjiu.wang-3arQi8VN3Tc@public.gmane.org, daniel.baluta-3arQi8VN3Tc@public.gmane.org, mihai.serban-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cosmin.samoila-3arQi8VN3Tc@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org, Mihai Serban <mihai.serban-3arQi8VN3Tc@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The AK4458 is a 32-bit 8ch Premium DAC that corresponds
to a 768kHz PCM input and an 11.2MHz DSD input at maximum.
It supports I2S, DSD and TDM modes with 24 or 32 bit MSB
or 16, 24, 32 LSB formats. Its datasheet is available here:
https://www.akm.com/akm/en/file/datasheet/AK4458VN.pdf

Signed-off-by: Junichi Wakasugi <wakasugi.jb-r6lgfPJHJciWyREYz5tgSuqrae++aQT8@public.gmane.org>
Signed-off-by: Mihai Serban <mihai.serban-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Shengjiu Wang <shengjiu.wang-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila-3arQi8VN3Tc@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/ak4458.txt |   23 +
 sound/soc/codecs/Kconfig                           |   18 +
 sound/soc/codecs/Makefile                          |    6 +
 sound/soc/codecs/ak4458-i2c.c                      |   79 ++
 sound/soc/codecs/ak4458-spi.c                      |   61 ++
 sound/soc/codecs/ak4458.c                          | 1132 ++++++++++++++++++++
 sound/soc/codecs/ak4458.h                          |  127 +++
 7 files changed, 1446 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak4458.txt
 create mode 100644 sound/soc/codecs/ak4458-i2c.c
 create mode 100644 sound/soc/codecs/ak4458-spi.c
 create mode 100644 sound/soc/codecs/ak4458.c
 create mode 100644 sound/soc/codecs/ak4458.h

diff --git a/Documentation/devicetree/bindings/sound/ak4458.txt b/Documentation/devicetree/bindings/sound/ak4458.txt
new file mode 100644
index 0000000..b9e6eb3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ak4458.txt
@@ -0,0 +1,23 @@
+AK4458 audio DAC
+
+This device supports both I2C and SPI modes.
+
+Required properties:
+
+- compatible : "asahi-kasei,ak4458"
+- reg : The I2C address of the device for I2C, the chip select number for SPI.
+- asahi-kasei,pdn-gpios: A GPIO specifier for the GPIO controlling
+	the power down & reset pin.
+- asahi-kasei,mute-gpios: A GPIO specifier for the GPIO controlling
+	the soft mute pin.
+
+Example:
+
+&i2c {
+	ak4458: ak4458@10 {
+		compatible = "asahi-kasei,ak4458";
+		reg = <0x10>;
+		asahi-kasei,pdn-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>
+		asahi-kasei,mute-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>
+	};
+};
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 2b331f7..488bf48 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -35,6 +35,9 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_ADAU7002
 	select SND_SOC_ADS117X
 	select SND_SOC_AK4104 if SPI_MASTER
+	select SND_SOC_AK4458
+	select SND_SOC_AK4458_I2C if I2C
+	select SND_SOC_AK4458_SPI if SPI_MASTER
 	select SND_SOC_AK4535 if I2C
 	select SND_SOC_AK4554
 	select SND_SOC_AK4613 if I2C
@@ -375,6 +378,21 @@ config SND_SOC_AK4104
 	tristate "AKM AK4104 CODEC"
 	depends on SPI_MASTER
 
+config SND_SOC_AK4458
+	tristate
+
+config SND_SOC_AK4458_I2C
+	tristate "AKM AK4458 DAC I2c"
+	depends on I2C
+	select SND_SOC_AK4458
+	select REGMAP_I2C
+
+config SND_SOC_AK4458_SPI
+	tristate "AKM AK4458 DAC SPI"
+	depends on SPI_MASTER
+	select SND_SOC_AK4458
+	select REGMAP_SPI
+
 config SND_SOC_AK4535
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index da15713..53bd24b 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -27,6 +27,9 @@ snd-soc-adav801-objs := adav801.o
 snd-soc-adav803-objs := adav803.o
 snd-soc-ads117x-objs := ads117x.o
 snd-soc-ak4104-objs := ak4104.o
+snd-soc-ak4458-objs := ak4458.o
+snd-soc-ak4458-i2c-objs := ak4458-i2c.o
+snd-soc-ak4458-spi-objs := ak4458-spi.o
 snd-soc-ak4535-objs := ak4535.o
 snd-soc-ak4554-objs := ak4554.o
 snd-soc-ak4613-objs := ak4613.o
@@ -270,6 +273,9 @@ obj-$(CONFIG_SND_SOC_ADAV801)  += snd-soc-adav801.o
 obj-$(CONFIG_SND_SOC_ADAV803)  += snd-soc-adav803.o
 obj-$(CONFIG_SND_SOC_ADS117X)	+= snd-soc-ads117x.o
 obj-$(CONFIG_SND_SOC_AK4104)	+= snd-soc-ak4104.o
+obj-$(CONFIG_SND_SOC_AK4458)	+= snd-soc-ak4458.o
+obj-$(CONFIG_SND_SOC_AK4458_I2C)	+= snd-soc-ak4458-i2c.o
+obj-$(CONFIG_SND_SOC_AK4458_SPI)	+= snd-soc-ak4458-spi.o
 obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
 obj-$(CONFIG_SND_SOC_AK4554)	+= snd-soc-ak4554.o
 obj-$(CONFIG_SND_SOC_AK4613)	+= snd-soc-ak4613.o
diff --git a/sound/soc/codecs/ak4458-i2c.c b/sound/soc/codecs/ak4458-i2c.c
new file mode 100644
index 0000000..9313aef
--- /dev/null
+++ b/sound/soc/codecs/ak4458-i2c.c
@@ -0,0 +1,79 @@
+/*
+ * ak4458-i2c.c  --  AK4458 DAC - I2C
+ *
+ * Copyright 2018 NXP
+ *
+ * Author: Mihai Serban <mihai.serban-3arQi8VN3Tc@public.gmane.org>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/pm_runtime.h>
+
+#include "ak4458.h"
+
+static int ak4458_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	struct regmap *regmap;
+	int ret;
+
+	regmap = devm_regmap_init_i2c(i2c, &ak4458_i2c_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	ret = ak4458_probe(&i2c->dev, regmap);
+	if (ret)
+		return ret;
+
+	pm_runtime_enable(&i2c->dev);
+
+	return 0;
+}
+
+static int ak4458_i2c_remove(struct i2c_client *i2c)
+{
+	ak4458_remove(&i2c->dev);
+	pm_runtime_disable(&i2c->dev);
+
+	return 0;
+}
+
+static const struct i2c_device_id ak4458_i2c_id[] = {
+	{ "ak4458", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ak4458_i2c_id);
+
+static const struct of_device_id ak4458_of_match[] = {
+	{ .compatible = "asahi-kasei,ak4458", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ak4458_of_match);
+
+static struct i2c_driver ak4458_i2c_driver = {
+	.driver = {
+		.name = "ak4458",
+		.pm = &ak4458_pm,
+		.of_match_table = ak4458_of_match,
+	},
+	.probe = ak4458_i2c_probe,
+	.remove = ak4458_i2c_remove,
+	.id_table = ak4458_i2c_id
+};
+
+module_i2c_driver(ak4458_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC AK4458 driver - I2C");
+MODULE_AUTHOR("Mihai Serban <mihai.serban-3arQi8VN3Tc@public.gmane.org>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ak4458-spi.c b/sound/soc/codecs/ak4458-spi.c
new file mode 100644
index 0000000..91cafc7
--- /dev/null
+++ b/sound/soc/codecs/ak4458-spi.c
@@ -0,0 +1,61 @@
+/*
+ * ak4458-spi.c  --  AK4458 DAC - SPI
+ *
+ * Copyright 2018 NXP
+ *
+ * Author: Mihai Serban <mihai.serban-3arQi8VN3Tc@public.gmane.org>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+
+#include "ak4458.h"
+
+static int ak4458_spi_probe(struct spi_device *spi)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_spi(spi, &ak4458_spi_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return ak4458_probe(&spi->dev, regmap);
+}
+
+static int ak4458_spi_remove(struct spi_device *spi)
+{
+	ak4458_remove(&spi->dev);
+	return 0;
+}
+
+static const struct of_device_id ak4458_of_match[] = {
+	{ .compatible = "asahi-kasei,ak4458", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ak4458_of_match);
+
+static struct spi_driver ak4458_spi_driver = {
+	.driver = {
+		.name = "ak4458",
+		.pm = &ak4458_pm,
+		.of_match_table = ak4458_of_match,
+	},
+	.probe = ak4458_spi_probe,
+	.remove = ak4458_spi_remove
+};
+
+module_spi_driver(ak4458_spi_driver);
+
+MODULE_DESCRIPTION("ASoC AK4458 driver - SPI");
+MODULE_AUTHOR("Mihai Serban <mihai.serban-3arQi8VN3Tc@public.gmane.org>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
new file mode 100644
index 0000000..1c2180d
--- /dev/null
+++ b/sound/soc/codecs/ak4458.c
@@ -0,0 +1,1132 @@
+/*
+ * ak4458.c  --  audio driver for AK4458 DAC
+ *
+ * Copyright (C) 2016 Asahi Kasei Microdevices Corporation
+ * Copyright 2018 NXP
+ *
+ * Authors:
+ * Tsuyoshi Mutsuro
+ * Junichi Wakasugi <wakasugi.jb-r6lgfPJHJciWyREYz5tgSuqrae++aQT8@public.gmane.org>
+ * Mihai Serban <mihai.serban-3arQi8VN3Tc@public.gmane.org>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+#include <sound/pcm_params.h>
+#include <linux/pm_runtime.h>
+
+#include "ak4458.h"
+
+/* AK4458 Codec Private Data */
+struct ak4458_priv {
+	struct device *dev;
+	struct regmap *regmap;
+	int pdn_gpio;
+	int mute_gpio;
+	int sds;	/* SDS2-0 bits */
+	int digfil;	/* SSLOW, SD, SLOW bits */
+	int fs;		/* sampling rate */
+	int lr[4];	/* (MONO, INVL, INVR, SELLR) x4ch */
+	int fmt;
+	int slots;
+	int slot_width;
+};
+
+static const struct reg_default ak4458_reg_defaults[] = {
+	{ 0x00, 0x0C },	/*	0x00	AK4458_00_CONTROL1	*/
+	{ 0x01, 0x22 },	/*	0x01	AK4458_01_CONTROL2	*/
+	{ 0x02, 0x00 },	/*	0x02	AK4458_02_CONTROL3	*/
+	{ 0x03, 0xFF },	/*	0x03	AK4458_03_LCHATT	*/
+	{ 0x04, 0xFF },	/*	0x04	AK4458_04_RCHATT	*/
+	{ 0x05, 0x00 },	/*	0x05	AK4458_05_CONTROL4	*/
+	{ 0x06, 0x00 },	/*	0x06	AK4458_06_DSD1		*/
+	{ 0x07, 0x03 },	/*	0x07	AK4458_07_CONTROL5	*/
+	{ 0x08, 0x00 },	/*	0x08	AK4458_08_SOUND_CONTROL	*/
+	{ 0x09, 0x00 },	/*	0x09	AK4458_09_DSD2		*/
+	{ 0x0A, 0x0D },	/*	0x0A	AK4458_0A_CONTROL6	*/
+	{ 0x0B, 0x0C },	/*	0x0B	AK4458_0B_CONTROL7	*/
+	{ 0x0C, 0x00 },	/*	0x0C	AK4458_0C_CONTROL8	*/
+	{ 0x0D, 0x00 },	/*	0x0D	AK4458_0D_CONTROL9	*/
+	{ 0x0E, 0x50 },	/*	0x0E	AK4458_0E_CONTROL10	*/
+	{ 0x0F, 0xFF },	/*	0x0F	AK4458_0F_L2CHATT	*/
+	{ 0x10, 0xFF },	/*	0x10	AK4458_10_R2CHATT	*/
+	{ 0x11, 0xFF },	/*	0x11	AK4458_11_L3CHATT	*/
+	{ 0x12, 0xFF },	/*	0x12	AK4458_12_R3CHATT	*/
+	{ 0x13, 0xFF },	/*	0x13	AK4458_13_L4CHATT	*/
+	{ 0x14, 0xFF },	/*	0x14	AK4458_14_R4CHATT	*/
+};
+
+static const struct regmap_range ak4458_spi_non_readable_reg_ranges[] = {
+	regmap_reg_range(AK4458_00_CONTROL1, AK4458_14_R4CHATT),
+};
+
+static const struct regmap_access_table ak4458_spi_readable_regs = {
+	.no_ranges = ak4458_spi_non_readable_reg_ranges,
+	.n_no_ranges = ARRAY_SIZE(ak4458_spi_non_readable_reg_ranges),
+};
+
+/*
+ * Volume control:
+ * from -127 to 0 dB in 0.5 dB steps (mute instead of -127.5 dB)
+ */
+static DECLARE_TLV_DB_SCALE(latt_tlv, -12750, 50, 1);
+static DECLARE_TLV_DB_SCALE(ratt_tlv, -12750, 50, 1);
+
+/*
+ * DEM1 bit DEM0 bit Mode
+ * 0 0 44.1kHz
+ * 0 1 OFF (default)
+ * 1 0 48kHz
+ * 1 1 32kHz
+ */
+static const char * const ak4458_dem_select_texts[] = {
+	"44.1kHz", "OFF", "48kHz", "32kHz"
+};
+
+/*
+ * SSLOW, SD, SLOW bits Digital Filter Setting
+ * 0, 0, 0 : Sharp Roll-Off Filter
+ * 0, 0, 1 : Slow Roll-Off Filter
+ * 0, 1, 0 : Short delay Sharp Roll-Off Filter
+ * 0, 1, 1 : Short delay Slow Roll-Off Filter
+ * 1, *, * : Super Slow Roll-Off Filter
+ */
+static const char * const ak4458_digfil_select_texts[] = {
+	"Sharp Roll-Off Filter",
+	"Slow Roll-Off Filter",
+	"Short delay Sharp Roll-Off Filter",
+	"Short delay Slow Roll-Off Filter",
+	"Super Slow Roll-Off Filter"
+};
+
+/*
+ * DZFB: Inverting Enable of DZF
+ * 0: DZF goes H at Zero Detection
+ * 1: DZF goes L at Zero Detection
+ */
+static const char * const ak4458_dzfb_select_texts[] = {"H", "L"};
+
+/*
+ * SC1-0 bits: Sound Mode Setting
+ * 0 0 : Sound Mode 0
+ * 0 1 : Sound Mode 1
+ * 1 0 : Sound Mode 2
+ * 1 1 : Reserved
+ */
+static const char * const ak4458_sc_select_texts[] = {
+	"Sound Mode 0", "Sound Mode 1", "Sound Mode 2"
+};
+
+/*
+ * SDS2-0 bits: Output Data Select
+ * Refer to Data Sheet
+ */
+static const char * const ak4458_sds_select_texts[] = {
+	"Setting 0", "Setting 1", "Setting 2", "Setting 3",
+	"Setting 4", "Setting 5", "Setting 6", "Setting 7",
+};
+
+/*
+ * TDM1-0 bits: TDM Mode Setting
+ * 0 0 : Normal Mode
+ * 0 1 : TDM128 Mode
+ * 1 0 : TDM256 Mode
+ * 1 1 : TDM512 Mode
+ */
+static const char * const ak4458_tdm_select_texts[] = {
+	"Normal Mode", "TDM128 Mode", "TDM256 Mode", "TDM512 Mode"
+};
+
+/* FIR2-0 bits: FIR Filter Mode Setting */
+static const char * const ak4458_fir_select_texts[] = {
+	"Mode 0", "Mode 1", "Mode 2", "Mode 3",
+	"Mode 4", "Mode 5", "Mode 6", "Mode 7",
+};
+
+/* Mono and SELLR bit Setting (1~4) */
+static const char * const ak4458_dac_LR_select_texts[] = {
+	"Lch In, Rch In",
+	"Lch In, Rch In Invert",
+	"Lch In Invert, Rch In",
+	"Lch In Invert, Rch In Invert",
+	"Rch In, Lch In",
+	"Rch In, Lch In Invert",
+	"Rch In Invert, Lch In",
+	"Rch In Invert, Lch In Invert",
+	"Lch In, Lch In",
+	"Lch In, Lch In Invert",
+	"Lch In Invert, Lch In",
+	"Lch In Invert, Lch In Invert",
+	"Rch In, Rch In",
+	"Rch In, Rch In Invert",
+	"Rch In Invert, Rch In",
+	"Rch In Invert, Rch In Invert",
+};
+
+/* ATS1-0 bits Attenuation Speed */
+static const char * const ak4458_ats_select_texts[] = {
+	"4080/fs", "2040/fs", "510/fs", "255/fs",
+};
+
+/* DIF2 bit Audio Interface Format Setting(BICK fs) */
+static const char * const ak4458_dif_select_texts[] = {"32fs,48fs", "64fs",};
+
+static int get_DAC1_LR(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.enumerated.item[0] = ak4458->lr[0];
+
+	return 0;
+}
+
+static int get_DAC2_LR(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.enumerated.item[0] = ak4458->lr[1];
+
+	return 0;
+}
+
+static int get_DAC3_LR(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.enumerated.item[0] = ak4458->lr[2];
+
+	return 0;
+}
+
+static int get_DAC4_LR(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.enumerated.item[0] = ak4458->lr[3];
+
+	return 0;
+}
+
+static int get_digfil(struct snd_kcontrol *kcontrol,
+		      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.enumerated.item[0] = ak4458->digfil;
+
+	return 0;
+}
+
+static int get_sds(struct snd_kcontrol *kcontrol,
+		   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.enumerated.item[0] = ak4458->sds;
+
+	return 0;
+}
+
+static int set_digfil(struct snd_kcontrol *kcontrol,
+		      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+
+	int reg_01, reg_02, reg_05, num;
+
+	num = ucontrol->value.enumerated.item[0];
+	if (num > 4)
+		return -EINVAL;
+
+	ak4458->digfil = num;
+
+	/* write SD bit */
+	reg_01 = snd_soc_read(codec, AK4458_01_CONTROL2);
+	reg_01 &= ~AK4458_SD_MASK;
+
+	reg_01 |= ((ak4458->digfil & 0x02) << 4);
+	snd_soc_write(codec, AK4458_01_CONTROL2, reg_01);
+
+	/* write SLOW bit */
+	reg_02 = snd_soc_read(codec, AK4458_02_CONTROL3);
+	reg_02 &= ~AK4458_SLOW_MASK;
+
+	reg_02 |= (ak4458->digfil & 0x01);
+	snd_soc_write(codec, AK4458_02_CONTROL3, reg_02);
+
+	/* write SSLOW bit */
+	reg_05 = snd_soc_read(codec, AK4458_05_CONTROL4);
+	reg_05 &= ~AK4458_SSLOW_MASK;
+
+	reg_05 |= ((ak4458->digfil & 0x04) >> 2);
+	snd_soc_write(codec, AK4458_05_CONTROL4, reg_05);
+
+	return 0;
+}
+
+static int set_sds(struct snd_kcontrol *kcontrol,
+		   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+
+	int reg_0b, reg_0a;
+
+	if (ucontrol->value.enumerated.item[0] > 7)
+		return -EINVAL;
+
+	ak4458->sds = ucontrol->value.enumerated.item[0];
+
+	/* write SDS0 bit */
+	reg_0b = snd_soc_read(codec, AK4458_0B_CONTROL7);
+	reg_0b &= ~AK4458_SDS0__MASK;
+
+	reg_0b |= ((ak4458->sds & 0x01) << 4);
+	snd_soc_write(codec, AK4458_0B_CONTROL7, reg_0b);
+
+	/* write SDS1,2 bits */
+	reg_0a = snd_soc_read(codec, AK4458_0A_CONTROL6);
+	reg_0a &= ~AK4458_SDS12_MASK;
+
+	reg_0a |= ((ak4458->sds & 0x02) << 4);
+	reg_0a |= ((ak4458->sds & 0x04) << 2);
+	snd_soc_write(codec, AK4458_0A_CONTROL6, reg_0a);
+
+	return 0;
+}
+
+static int set_DAC1_LR(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+
+	int reg_02, reg_05;
+
+	if (ucontrol->value.enumerated.item[0] > 15)
+		return -EINVAL;
+
+	ak4458->lr[0] = ucontrol->value.enumerated.item[0];
+
+	/* write MONO1 and SELLR1 bits */
+	reg_02 = snd_soc_read(codec, AK4458_02_CONTROL3);
+	reg_02 &= ~AK4458_DAC1_LR_MASK;
+
+	reg_02 |= (ak4458->lr[0] & 0x08) << 0;
+	reg_02 |= (ak4458->lr[0] & 0x04) >> 1;
+	snd_soc_write(codec, AK4458_02_CONTROL3, reg_02);
+
+	/* write INVL1 and INVR1 bits */
+	reg_05 = snd_soc_read(codec, AK4458_05_CONTROL4);
+	reg_05 &= ~AK4458_DAC1_INV_MASK;
+
+	reg_05 |= (ak4458->lr[0] & 0x02) << 6;
+	reg_05 |= (ak4458->lr[0] & 0x01) << 6;
+	snd_soc_write(codec, AK4458_05_CONTROL4, reg_05);
+
+	return 0;
+}
+
+static int set_DAC2_LR(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+
+	int reg_0D, reg_05;
+
+	if (ucontrol->value.enumerated.item[0] > 15)
+		return -EINVAL;
+
+	ak4458->lr[1] = ucontrol->value.enumerated.item[0];
+
+	/* write MONO2 bit */
+	reg_0D = snd_soc_read(codec, AK4458_0D_CONTROL9);
+	reg_0D &= ~AK4458_DAC2_MASK1;
+
+	reg_0D |= (ak4458->lr[1] & 0x08) << 2;
+	snd_soc_write(codec, AK4458_0D_CONTROL9, reg_0D);
+
+	/* write SELLR2 and INVL1 and INVR1 bits */
+	reg_05 = snd_soc_read(codec, AK4458_05_CONTROL4);
+	reg_05 &= ~AK4458_DAC2_MASK2;
+
+	reg_05 |= (ak4458->lr[1] & 0x04) << 1;
+	reg_05 |= (ak4458->lr[1] & 0x02) << 4;
+	reg_05 |= (ak4458->lr[1] & 0x01) << 4;
+	snd_soc_write(codec, AK4458_05_CONTROL4, reg_05);
+
+	return 0;
+}
+
+static int set_DAC3_LR(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+
+	int reg_0C, reg_0D;
+
+	if (ucontrol->value.enumerated.item[0] > 15)
+		return -EINVAL;
+
+	ak4458->lr[2] = ucontrol->value.enumerated.item[0];
+
+	/* write MONO3 and SELLR3 bits */
+	reg_0D = snd_soc_read(codec, AK4458_0D_CONTROL9);
+	reg_0D &= ~AK4458_DAC3_LR_MASK;
+
+	reg_0D |= (ak4458->lr[2] & 0x08) << 3;
+	reg_0D |= (ak4458->lr[2] & 0x04) << 0;
+	snd_soc_write(codec, AK4458_0D_CONTROL9, reg_0D);
+
+	/* write INVL3 and INVR3 bits */
+	reg_0C = snd_soc_read(codec, AK4458_0C_CONTROL8);
+	reg_0C &= ~AK4458_DAC3_INV_MASK;
+
+	reg_0C |= (ak4458->lr[2] & 0x02) << 3;
+	reg_0C |= (ak4458->lr[2] & 0x01) << 5;
+	snd_soc_write(codec, AK4458_0C_CONTROL8, reg_0C);
+
+	return 0;
+}
+
+static int set_DAC4_LR(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+
+	int reg_0C, reg_0D;
+
+	if (ucontrol->value.enumerated.item[0] > 15)
+		return -EINVAL;
+
+	ak4458->lr[3] = ucontrol->value.enumerated.item[0];
+
+	/* write MONO4 and SELLR4 bits */
+	reg_0D = snd_soc_read(codec, AK4458_0D_CONTROL9);
+	reg_0D &= ~AK4458_DAC4_LR_MASK;
+
+	reg_0D |= (ak4458->lr[3] & 0x08) << 4;
+	reg_0D |= (ak4458->lr[3] & 0x04) << 1;
+	snd_soc_write(codec, AK4458_0D_CONTROL9, reg_0D);
+
+	/* write INVL4 and INVR4 bits */
+	reg_0C = snd_soc_read(codec, AK4458_0C_CONTROL8);
+	reg_0C &= ~AK4458_DAC4_INV_MASK;
+
+	reg_0C |= (ak4458->lr[3] & 0x02) << 5;
+	reg_0C |= (ak4458->lr[3] & 0x01) << 7;
+	snd_soc_write(codec, AK4458_0C_CONTROL8, reg_0C);
+
+	return 0;
+}
+
+static const struct soc_enum ak4458_dac_enum[] = {
+/*0*/	SOC_ENUM_SINGLE(AK4458_01_CONTROL2, 1,
+			ARRAY_SIZE(ak4458_dem_select_texts),
+			ak4458_dem_select_texts),
+/*1*/	SOC_ENUM_SINGLE(AK4458_0A_CONTROL6, 0,
+			ARRAY_SIZE(ak4458_dem_select_texts),
+			ak4458_dem_select_texts),
+/*2*/	SOC_ENUM_SINGLE(AK4458_0E_CONTROL10, 4,
+			ARRAY_SIZE(ak4458_dem_select_texts),
+			ak4458_dem_select_texts),
+/*3*/	SOC_ENUM_SINGLE(AK4458_0E_CONTROL10, 6,
+			ARRAY_SIZE(ak4458_dem_select_texts),
+			ak4458_dem_select_texts),
+/*4*/	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(ak4458_digfil_select_texts),
+			    ak4458_digfil_select_texts),
+/*5*/	SOC_ENUM_SINGLE(AK4458_02_CONTROL3, 2,
+			ARRAY_SIZE(ak4458_dzfb_select_texts),
+			ak4458_dzfb_select_texts),
+/*6*/	SOC_ENUM_SINGLE(AK4458_08_SOUND_CONTROL, 0,
+			ARRAY_SIZE(ak4458_sc_select_texts),
+			ak4458_sc_select_texts),
+/*7*/	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(ak4458_sds_select_texts),
+			    ak4458_sds_select_texts),
+/*8*/	SOC_ENUM_SINGLE(AK4458_0C_CONTROL8, 0,
+			ARRAY_SIZE(ak4458_fir_select_texts),
+			ak4458_fir_select_texts),
+/*9*/	SOC_ENUM_SINGLE(AK4458_0A_CONTROL6, 6,
+			ARRAY_SIZE(ak4458_tdm_select_texts),
+			ak4458_tdm_select_texts),
+/*10*/  SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(ak4458_dac_LR_select_texts),
+			    ak4458_dac_LR_select_texts),
+/*11*/	SOC_ENUM_SINGLE(AK4458_0B_CONTROL7, 6,
+			ARRAY_SIZE(ak4458_ats_select_texts),
+			ak4458_ats_select_texts),
+/*12*/	SOC_ENUM_SINGLE(AK4458_00_CONTROL1, 3,
+			ARRAY_SIZE(ak4458_dif_select_texts),
+			ak4458_dif_select_texts),
+};
+
+static const struct snd_kcontrol_new ak4458_snd_controls[] = {
+	SOC_SINGLE_TLV("AK4458 L1ch Digital Volume",
+		       AK4458_03_LCHATT, 0/*shift*/, 0xFF/*max value*/,
+		       0/*invert*/, latt_tlv),
+	SOC_SINGLE_TLV("AK4458 R1ch Digital Volume",
+		       AK4458_04_RCHATT, 0, 0xFF, 0, ratt_tlv),
+	SOC_SINGLE_TLV("AK4458 L2ch Digital Volume",
+		       AK4458_0F_L2CHATT, 0/*shift*/, 0xFF/*max value*/,
+		       0/*invert*/, latt_tlv),
+	SOC_SINGLE_TLV("AK4458 R2ch Digital Volume",
+		       AK4458_10_R2CHATT, 0, 0xFF, 0, ratt_tlv),
+	SOC_SINGLE_TLV("AK4458 L3ch Digital Volume",
+		       AK4458_11_L3CHATT, 0/*shift*/, 0xFF/*max value*/,
+		       0/*invert*/, latt_tlv),
+	SOC_SINGLE_TLV("AK4458 R3ch Digital Volume",
+		       AK4458_12_R3CHATT, 0, 0xFF, 0, ratt_tlv),
+	SOC_SINGLE_TLV("AK4458 L4ch Digital Volume",
+		       AK4458_13_L4CHATT, 0/*shift*/, 0xFF/*max value*/,
+		       0/*invert*/, latt_tlv),
+	SOC_SINGLE_TLV("AK4458 R4ch Digital Volume",
+		       AK4458_14_R4CHATT, 0, 0xFF, 0, ratt_tlv),
+
+	SOC_ENUM("AK4458 De-emphasis Response DAC1", ak4458_dac_enum[0]),
+	SOC_ENUM("AK4458 De-emphasis Response DAC2", ak4458_dac_enum[1]),
+	SOC_ENUM("AK4458 De-emphasis Response DAC3", ak4458_dac_enum[2]),
+	SOC_ENUM("AK4458 De-emphasis Response DAC4", ak4458_dac_enum[3]),
+	SOC_ENUM_EXT("AK4458 Digital Filter Setting", ak4458_dac_enum[4],
+		     get_digfil, set_digfil),
+	SOC_ENUM("AK4458 Inverting Enable of DZFB", ak4458_dac_enum[5]),
+	SOC_ENUM("AK4458 Sound Mode", ak4458_dac_enum[6]),
+	SOC_ENUM_EXT("AK4458 SDS Setting", ak4458_dac_enum[7],
+		     get_sds, set_sds),
+	SOC_ENUM("AK4458 FIR Filter Mode Setting", ak4458_dac_enum[8]),
+	SOC_ENUM("AK4458 TDM Mode Setting", ak4458_dac_enum[9]),
+	SOC_ENUM_EXT("AK4458 DAC1 LRch Setting", ak4458_dac_enum[10],
+		     get_DAC1_LR, set_DAC1_LR),
+	SOC_ENUM_EXT("AK4458 DAC2 LRch Setting", ak4458_dac_enum[10],
+		     get_DAC2_LR, set_DAC2_LR),
+	SOC_ENUM_EXT("AK4458 DAC3 LRch Setting", ak4458_dac_enum[10],
+		     get_DAC3_LR, set_DAC3_LR),
+	SOC_ENUM_EXT("AK4458 DAC4 LRch Setting", ak4458_dac_enum[10],
+		     get_DAC4_LR, set_DAC4_LR),
+	SOC_ENUM("AK4458 Attenuation transition Time Setting",
+		 ak4458_dac_enum[11]),
+	SOC_ENUM("AK4458 BICK fs Setting", ak4458_dac_enum[12]),
+};
+
+static const char * const ak4458_dac_select_texts[] = { "OFF", "ON" };
+
+static const struct soc_enum ak4458_dac_mux_enum =
+	SOC_ENUM_SINGLE(0, 0,
+			ARRAY_SIZE(ak4458_dac_select_texts),
+			ak4458_dac_select_texts);
+static const struct snd_kcontrol_new ak4458_dac1_mux_control =
+	SOC_DAPM_ENUM("DAC1 Switch", ak4458_dac_mux_enum);
+static const struct snd_kcontrol_new ak4458_dac2_mux_control =
+	SOC_DAPM_ENUM("DAC2 Switch", ak4458_dac_mux_enum);
+static const struct snd_kcontrol_new ak4458_dac3_mux_control =
+	SOC_DAPM_ENUM("DAC3 Switch", ak4458_dac_mux_enum);
+static const struct snd_kcontrol_new ak4458_dac4_mux_control =
+	SOC_DAPM_ENUM("DAC4 Switch", ak4458_dac_mux_enum);
+
+/* ak4458 dapm widgets */
+static const struct snd_soc_dapm_widget ak4458_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("AK4458 DAC1", NULL, AK4458_0A_CONTROL6, 2, 0),/*pw*/
+	SND_SOC_DAPM_AIF_IN("AK4458 SDTI", "Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_OUTPUT("AK4458 AOUTA"),
+
+	SND_SOC_DAPM_DAC("AK4458 DAC2", NULL, AK4458_0A_CONTROL6, 3, 0),/*pw*/
+	SND_SOC_DAPM_OUTPUT("AK4458 AOUTB"),
+
+	SND_SOC_DAPM_DAC("AK4458 DAC3", NULL, AK4458_0B_CONTROL7, 2, 0),/*pw*/
+	SND_SOC_DAPM_OUTPUT("AK4458 AOUTC"),
+
+	SND_SOC_DAPM_DAC("AK4458 DAC4", NULL, AK4458_0B_CONTROL7, 3, 0),/*pw*/
+	SND_SOC_DAPM_OUTPUT("AK4458 AOUTD"),
+
+	SND_SOC_DAPM_MUX("DAC1 to AOUTA", SND_SOC_NOPM, 0, 0,
+			 &ak4458_dac1_mux_control),/*nopm*/
+	SND_SOC_DAPM_MUX("DAC2 to AOUTB", SND_SOC_NOPM, 0, 0,
+			 &ak4458_dac2_mux_control),/*nopm*/
+	SND_SOC_DAPM_MUX("DAC3 to AOUTC", SND_SOC_NOPM, 0, 0,
+			 &ak4458_dac3_mux_control),/*nopm*/
+	SND_SOC_DAPM_MUX("DAC4 to AOUTD", SND_SOC_NOPM, 0, 0,
+			 &ak4458_dac4_mux_control),/*nopm*/
+};
+
+static const struct snd_soc_dapm_route ak4458_intercon[] = {
+	{"DAC1 to AOUTA",	"ON",	"AK4458 SDTI"},
+	{"AK4458 DAC1",		NULL, "DAC1 to AOUTA"},
+	{"AK4458 AOUTA",	NULL, "AK4458 DAC1"},
+
+	{"DAC2 to AOUTB",	"ON",	"AK4458 SDTI"},
+	{"AK4458 DAC2",		NULL, "DAC2 to AOUTB"},
+	{"AK4458 AOUTB",	NULL, "AK4458 DAC2"},
+
+	{"DAC3 to AOUTC",	"ON",	"AK4458 SDTI"},
+	{"AK4458 DAC3",		NULL,	"DAC3 to AOUTC"},
+	{"AK4458 AOUTC",	NULL,	"AK4458 DAC3"},
+
+	{"DAC4 to AOUTD",	"ON",	"AK4458 SDTI"},
+	{"AK4458 DAC4",		NULL,	"DAC4 to AOUTD"},
+	{"AK4458 AOUTD",	NULL,   "AK4458 DAC4"},
+};
+
+static int ak4458_rstn_control(struct snd_soc_codec *codec, int bit)
+{
+	u8 rstn;
+
+	dev_dbg(codec->dev, "%s(%d)\n", __func__, __LINE__);
+
+	rstn = snd_soc_read(codec, AK4458_00_CONTROL1);
+	rstn &= ~AK4458_RSTN_MASK;
+
+	if (bit)
+		rstn |= AK4458_RSTN;
+
+	snd_soc_write(codec, AK4458_00_CONTROL1, rstn);
+
+	return 0;
+}
+
+static int ak4458_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+	u8 format;
+	int pcm_width = max(params_physical_width(params), ak4458->slot_width);
+
+#ifdef AK4458_ACKS_USE_MANUAL_MODE
+	u8 dfs1, dfs2;
+#endif
+	int nfs1;
+
+	dev_dbg(dai->dev, "%s(%d)\n", __func__, __LINE__);
+
+	format = snd_soc_read(codec, AK4458_00_CONTROL1);
+	format &= ~AK4458_DIF_MASK;
+
+	nfs1 = params_rate(params);
+	ak4458->fs = nfs1;
+
+#ifdef AK4458_ACKS_USE_MANUAL_MODE
+	dfs1 = snd_soc_read(codec, AK4458_01_CONTROL2);
+	dfs1 &= ~AK4458_DFS01_MASK;
+
+	dfs2 = snd_soc_read(codec, AK4458_05_CONTROL4);
+	dfs2 &= ~AK4458_DFS2__MASK;
+
+	switch (nfs1) {
+	case 8000:
+	case 11025:
+	case 16000:
+	case 22050:
+	case 32000:
+	case 44100:
+	case 48000:
+		dfs1 |= AK4458_DFS01_48KHZ;
+		dfs2 |= AK4458_DFS2__48KHZ;
+		break;
+	case 88200:
+	case 96000:
+		dfs1 |= AK4458_DFS01_96KHZ;
+		dfs2 |= AK4458_DFS2__96KHZ;
+		break;
+	case 176400:
+	case 192000:
+		dfs1 |= AK4458_DFS01_192KHZ;
+		dfs2 |= AK4458_DFS2__192KHZ;
+		break;
+	case 384000:
+		dfs1 |= AK4458_DFS01_384KHZ;
+		dfs2 |= AK4458_DFS2__384KHZ;
+		break;
+	case 768000:
+		dfs1 |= AK4458_DFS01_768KHZ;
+		dfs2 |= AK4458_DFS2__768KHZ;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_write(codec, AK4458_01_CONTROL2, dfs1);
+	snd_soc_write(codec, AK4458_05_CONTROL4, dfs2);
+
+	ak4458_rstn_control(codec, 0);
+	ak4458_rstn_control(codec, 1);
+
+#else
+	snd_soc_update_bits(codec, AK4458_00_CONTROL1, 0x80, 0x80);
+#endif
+
+	switch (pcm_width) {
+	case 16:
+		if (ak4458->fmt == SND_SOC_DAIFMT_I2S)
+			format |= AK4458_DIF_24BIT_I2S;
+		else
+			format |= AK4458_DIF_16BIT_LSB;
+		break;
+	case 32:
+		if (ak4458->fmt == SND_SOC_DAIFMT_I2S)
+			format |= AK4458_DIF_32BIT_I2S;
+		else if (ak4458->fmt == SND_SOC_DAIFMT_LEFT_J)
+			format |= AK4458_DIF_32BIT_MSB;
+		else if (ak4458->fmt == SND_SOC_DAIFMT_RIGHT_J)
+			format |= AK4458_DIF_32BIT_LSB;
+		else if (ak4458->fmt == SND_SOC_DAIFMT_DSP_B)
+			format |= AK4458_DIF_32BIT_MSB;
+		else
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_write(codec, AK4458_00_CONTROL1, format);
+
+	ak4458_rstn_control(codec, 0);
+	ak4458_rstn_control(codec, 1);
+
+	return 0;
+}
+
+static int ak4458_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
+				 unsigned int freq, int dir)
+{
+	dev_dbg(dai->dev, "%s(%d)\n", __func__, __LINE__);
+
+	return 0;
+}
+
+static int ak4458_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+	u8 format;
+
+	/* set master/slave audio interface */
+	format = snd_soc_read(codec, AK4458_00_CONTROL1);
+
+	dev_dbg(dai->dev, "%s(%d) addr 00H = %02X\n",
+		__func__, __LINE__, format);
+
+	format &= ~AK4458_DIF_MASK;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS: /* Slave Mode */
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM: /* Master Mode is not supported */
+	case SND_SOC_DAIFMT_CBS_CFM:
+	case SND_SOC_DAIFMT_CBM_CFS:
+	default:
+		dev_err(codec->dev, "Master mode unsupported\n");
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_RIGHT_J:
+		ak4458->fmt = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		ak4458->fmt = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
+		break;
+	default:
+		dev_err(codec->dev, "Audio format 0x%02X unsupported\n",
+			fmt & SND_SOC_DAIFMT_FORMAT_MASK);
+		return -EINVAL;
+	}
+
+	/* set format */
+	dev_dbg(dai->dev, "%s(%d) addr 00H = %02X\n",
+		__func__, __LINE__, format);
+	snd_soc_write(codec, AK4458_00_CONTROL1, format);
+
+	ak4458_rstn_control(codec, 0);
+	ak4458_rstn_control(codec, 1);
+
+	return 0;
+}
+
+static int ak4458_trigger(struct snd_pcm_substream *substream, int cmd,
+			  struct snd_soc_dai *codec_dai)
+{
+	int ret = 0;
+
+	dev_dbg(codec_dai->dev, "%s(%d)\n", __func__, __LINE__);
+	return ret;
+}
+
+static int ak4458_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
+{
+	dev_dbg(codec->dev, "%s(%d)\n", __func__, __LINE__);
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+	case SND_SOC_BIAS_PREPARE:
+	case SND_SOC_BIAS_STANDBY:
+		break;
+	case SND_SOC_BIAS_OFF:
+		break;
+	}
+
+	return 0;
+}
+
+static const int att_speed[] = { 4080, 2040, 510, 255 };
+
+static int ak4458_set_dai_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+	int nfs, ndt, ret, reg;
+	int ats;
+
+	nfs = ak4458->fs;
+
+	reg = snd_soc_read(codec, AK4458_0B_CONTROL7);
+	ats = (reg & 0xC0) >> 6;
+
+	dev_dbg(dai->dev, "%s mute[%s] nfs[%d]\n", __func__,
+		mute ? "ON" : "OFF", nfs);
+
+	ndt = att_speed[ats] / (nfs / 1000);
+
+	if (mute) { /* SMUTE: 1 , MUTE */
+		ret = snd_soc_update_bits(codec, AK4458_01_CONTROL2,  0x01, 1);
+		mdelay(ndt);
+		dev_dbg(dai->dev, "%s(%d) mdelay(%d ms)\n",
+			__func__, __LINE__, ndt);
+
+		if (gpio_is_valid(ak4458->mute_gpio))
+			gpio_set_value_cansleep(ak4458->mute_gpio, 1);
+
+		dev_dbg(dai->dev, "%s External Mute = ON\n", __func__);
+	} else { /* SMUTE: 0 ,NORMAL operation */
+		if (gpio_is_valid(ak4458->mute_gpio))
+			gpio_set_value_cansleep(ak4458->mute_gpio, 0);
+
+		dev_dbg(dai->dev, "%s External Mute = OFF\n", __func__);
+		ret = snd_soc_update_bits(codec, AK4458_01_CONTROL2, 0x01, 0);
+		mdelay(ndt);
+		dev_dbg(dai->dev, "%s(%d) mdelay(%d ms)\n",
+			__func__, __LINE__, ndt);
+	}
+	dev_dbg(dai->dev, "%s(%d) ret[%d]\n", __func__, __LINE__, ret);
+
+	return 0;
+}
+
+static int ak4458_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+			       unsigned int rx_mask, int slots, int slot_width)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+	int tdm_mode = 0;
+	int reg;
+
+	ak4458->slots = slots;
+	ak4458->slot_width = slot_width;
+
+	switch (slots * slot_width) {
+	case 128:
+		tdm_mode = 1;
+		break;
+	case 256:
+		tdm_mode = 2;
+		break;
+	case 512:
+		tdm_mode = 3;
+		break;
+	default:
+		tdm_mode = 0;
+		break;
+	}
+
+	reg = snd_soc_read(codec, AK4458_0A_CONTROL6);
+	reg &= ~(0x3 << 6);
+	reg |= tdm_mode << 6;
+	snd_soc_write(codec, AK4458_0A_CONTROL6, reg);
+
+	return 0;
+}
+
+#define AK4458_RATES	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
+	SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
+	SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
+	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
+	SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |\
+	SNDRV_PCM_RATE_192000)
+	/* | SNDRV_PCM_RATE_384000 | SNDRV_PCM_RATE_768000 */
+
+#define AK4458_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S24_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+static const unsigned int ak4458_rates[] = {
+	8000, 11025,  16000, 22050,
+	32000, 44100, 48000, 88200,
+	96000, 176400, 192000, 352800,
+	384000, 705600, 768000, 1411200,
+	2822400,
+};
+
+static const struct snd_pcm_hw_constraint_list ak4458_rate_constraints = {
+	.count = ARRAY_SIZE(ak4458_rates),
+	.list = ak4458_rates,
+};
+
+static int ak4458_startup(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	int ret;
+
+	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
+					 SNDRV_PCM_HW_PARAM_RATE,
+					 &ak4458_rate_constraints);
+
+	return ret;
+}
+
+static struct snd_soc_dai_ops ak4458_dai_ops = {
+	.startup        = ak4458_startup,
+	.hw_params	= ak4458_hw_params,
+	.set_sysclk	= ak4458_set_dai_sysclk,
+	.set_fmt	= ak4458_set_dai_fmt,
+	.trigger	= ak4458_trigger,
+	.digital_mute	= ak4458_set_dai_mute,
+	.set_tdm_slot	= ak4458_set_tdm_slot,
+};
+
+static struct snd_soc_dai_driver ak4458_dai = {
+	.name = "ak4458-aif",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 8,
+		.rates = SNDRV_PCM_RATE_KNOT,
+		.formats = AK4458_FORMATS,
+	},
+	.ops = &ak4458_dai_ops,
+};
+
+static void ak4458_init_reg(struct snd_soc_codec *codec)
+{
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+
+	dev_dbg(codec->dev, "%s(%d)\n", __func__, __LINE__);
+
+	/* External Mute ON */
+	if (gpio_is_valid(ak4458->mute_gpio))
+		gpio_set_value_cansleep(ak4458->mute_gpio, 1);
+
+	if (gpio_is_valid(ak4458->pdn_gpio)) {
+		gpio_set_value_cansleep(ak4458->pdn_gpio, 0);
+		usleep_range(1000, 2000);
+		gpio_set_value_cansleep(ak4458->pdn_gpio, 1);
+		usleep_range(1000, 2000);
+	}
+
+	ak4458_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+#ifndef AK4458_ACKS_USE_MANUAL_MODE
+	snd_soc_update_bits(codec, AK4458_00_CONTROL1,
+			    0x80, 0x80);   /* ACKS bit = 1; 10000000 */
+	dev_dbg(codec->dev, "%s ACKS bit = 1\n", __func__);
+#endif
+
+	ak4458_rstn_control(codec, 0);
+	ak4458_rstn_control(codec, 1);
+}
+
+static int ak4458_codec_probe(struct snd_soc_codec *codec)
+{
+	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
+
+	dev_dbg(codec->dev, "%s(%d)\n", __func__, __LINE__);
+
+	ak4458_init_reg(codec);
+
+	ak4458->fs = 48000;
+
+	return 0;
+}
+
+static int ak4458_codec_remove(struct snd_soc_codec *codec)
+{
+	dev_dbg(codec->dev, "%s(%d)\n", __func__, __LINE__);
+
+	ak4458_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int ak4458_runtime_suspend(struct device *dev)
+{
+	struct ak4458_priv *ak4458 = dev_get_drvdata(dev);
+
+	regcache_cache_only(ak4458->regmap, true);
+
+	if (gpio_is_valid(ak4458->pdn_gpio)) {
+		gpio_set_value_cansleep(ak4458->pdn_gpio, 0);
+		usleep_range(1000, 2000);
+	}
+
+	if (gpio_is_valid(ak4458->mute_gpio))
+		gpio_set_value_cansleep(ak4458->mute_gpio, 0);
+
+	return 0;
+}
+
+static int ak4458_runtime_resume(struct device *dev)
+{
+	struct ak4458_priv *ak4458 = dev_get_drvdata(dev);
+
+	if (gpio_is_valid(ak4458->mute_gpio))
+		gpio_set_value_cansleep(ak4458->mute_gpio, 1);
+
+	if (gpio_is_valid(ak4458->pdn_gpio)) {
+		gpio_set_value_cansleep(ak4458->pdn_gpio, 0);
+		usleep_range(1000, 2000);
+		gpio_set_value_cansleep(ak4458->pdn_gpio, 1);
+		usleep_range(1000, 2000);
+	}
+
+	regcache_cache_only(ak4458->regmap, false);
+	regcache_mark_dirty(ak4458->regmap);
+
+	return regcache_sync(ak4458->regmap);
+}
+#endif /* CONFIG_PM */
+
+struct snd_soc_codec_driver soc_codec_dev_ak4458 = {
+	.probe = ak4458_codec_probe,
+	.remove = ak4458_codec_remove,
+	.set_bias_level = ak4458_set_bias_level,
+
+	.component_driver = {
+		.controls = ak4458_snd_controls,
+		.num_controls = ARRAY_SIZE(ak4458_snd_controls),
+		.dapm_widgets = ak4458_dapm_widgets,
+		.num_dapm_widgets = ARRAY_SIZE(ak4458_dapm_widgets),
+		.dapm_routes = ak4458_intercon,
+		.num_dapm_routes = ARRAY_SIZE(ak4458_intercon),
+	},
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_ak4458);
+
+const struct regmap_config ak4458_i2c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = AK4458_14_R4CHATT,
+	.reg_defaults = ak4458_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(ak4458_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+};
+EXPORT_SYMBOL_GPL(ak4458_i2c_regmap_config);
+
+const struct regmap_config ak4458_spi_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = AK4458_14_R4CHATT,
+	.rd_table = &ak4458_spi_readable_regs,
+	.reg_defaults = ak4458_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(ak4458_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+};
+EXPORT_SYMBOL_GPL(ak4458_spi_regmap_config);
+
+int ak4458_probe(struct device *dev, struct regmap *regmap)
+{
+	struct ak4458_priv *ak4458;
+	struct device_node *np = dev->of_node;
+	int ret;
+
+	ak4458 = devm_kzalloc(dev, sizeof(*ak4458), GFP_KERNEL);
+	if (!ak4458)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, ak4458);
+
+	ak4458->dev = dev;
+	ak4458->regmap = regmap;
+
+	ak4458->pdn_gpio = of_get_named_gpio(np, "ak4458,pdn-gpio", 0);
+	if (gpio_is_valid(ak4458->pdn_gpio)) {
+		ret = devm_gpio_request_one(dev, ak4458->pdn_gpio,
+					    GPIOF_OUT_INIT_LOW, "ak4458,pdn");
+		if (ret) {
+			dev_err(dev, "unable to get pdn gpio\n");
+			return ret;
+		}
+	}
+
+	ak4458->mute_gpio = of_get_named_gpio(np, "ak4458,mute_gpio", 0);
+	if (gpio_is_valid(ak4458->mute_gpio)) {
+		ret = devm_gpio_request_one(dev, ak4458->pdn_gpio,
+					    GPIOF_OUT_INIT_LOW, "ak4458,mute");
+		if (ret) {
+			dev_err(dev, "unable to get mute gpio\n");
+			return ret;
+		}
+	}
+
+	ret = snd_soc_register_codec(dev, &soc_codec_dev_ak4458,
+				     &ak4458_dai, 1);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register CODEC: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ak4458_probe);
+
+void ak4458_remove(struct device *dev)
+{
+	snd_soc_unregister_codec(dev);
+}
+EXPORT_SYMBOL_GPL(ak4458_remove);
+
+const struct dev_pm_ops ak4458_pm = {
+	SET_RUNTIME_PM_OPS(ak4458_runtime_suspend, ak4458_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+EXPORT_SYMBOL_GPL(ak4458_pm);
+
+MODULE_AUTHOR("Junichi Wakasugi <wakasugi.jb-r6lgfPJHJciWyREYz5tgSuqrae++aQT8@public.gmane.org>");
+MODULE_AUTHOR("Mihai Serban <mihai.serban-3arQi8VN3Tc@public.gmane.org>");
+MODULE_DESCRIPTION("ASoC AK4458 DAC driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ak4458.h b/sound/soc/codecs/ak4458.h
new file mode 100644
index 0000000..dd3eb23
--- /dev/null
+++ b/sound/soc/codecs/ak4458.h
@@ -0,0 +1,127 @@
+/*
+ * ak4458.h  --  audio driver for AK4458
+ *
+ * Copyright (C) 2016 Asahi Kasei Microdevices Corporation
+ * Author:  Tsuyoshi Mutsuro
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _AK4458_H
+#define _AK4458_H
+
+#include <linux/regmap.h>
+
+/* Settings */
+
+#define AK4458_00_CONTROL1			0x00
+#define AK4458_01_CONTROL2			0x01
+#define AK4458_02_CONTROL3			0x02
+#define AK4458_03_LCHATT			0x03
+#define AK4458_04_RCHATT			0x04
+#define AK4458_05_CONTROL4			0x05
+#define AK4458_06_DSD1				0x06
+#define AK4458_07_CONTROL5			0x07
+#define AK4458_08_SOUND_CONTROL			0x08
+#define AK4458_09_DSD2				0x09
+#define AK4458_0A_CONTROL6			0x0A
+#define AK4458_0B_CONTROL7			0x0B
+#define AK4458_0C_CONTROL8			0x0C
+#define AK4458_0D_CONTROL9			0x0D
+#define AK4458_0E_CONTROL10			0x0E
+#define AK4458_0F_L2CHATT			0x0F
+#define AK4458_10_R2CHATT			0x10
+#define AK4458_11_L3CHATT			0x11
+#define AK4458_12_R3CHATT			0x12
+#define AK4458_13_L4CHATT			0x13
+#define AK4458_14_R4CHATT			0x14
+
+/* Bitfield Definitions */
+
+/* AK4458_00_CONTROL1 (0x00) Fields
+ * Addr Register Name  D7     D6    D5    D4    D3    D2    D1    D0
+ * 00H  Control 1      ACKS   0     0     0     DIF2  DIF1  DIF0  RSTN
+ */
+
+/* MONO1 & SELLR1 bits */
+#define AK4458_DAC1_LR_MASK	0x0A
+#define AK4458_DAC1_INV_MASK	0xC0
+
+/* MONO2 & SELLR2 bits */
+#define AK4458_DAC2_MASK1	0x20
+#define AK4458_DAC2_MASK2	0x38
+
+/* MONO3 & SELLR3 bits */
+#define AK4458_DAC3_LR_MASK	0x44
+#define AK4458_DAC3_INV_MASK	0x30
+
+/* MONO4 & SELLR4 bits */
+#define AK4458_DAC4_LR_MASK	0x88
+#define AK4458_DAC4_INV_MASK	0xC0
+
+/* SDS2-0 bits */
+#define AK4458_SDS0__MASK	0x10
+#define AK4458_SDS12_MASK	0x30
+
+/* Digital Filter (SD, SLOW, SSLOW) */
+#define AK4458_SD_MASK		0x20
+#define AK4458_SLOW_MASK	0x01
+#define AK4458_SSLOW_MASK	0x01
+
+/* DIF2	1 0
+ *  x	1 0 MSB justified  Figure 3 (default)
+ *  x	1 1 I2S Compliment  Figure 4
+ */
+
+#define AK4458_DIF_MASK			0x0E
+#define AK4458_DIF_MSB_LOW_FS_MODE	(2 << 1)
+#define AK4458_DIF_I2S_LOW_FS_MODE	(3 << 1)
+
+#define AK4458_DIF_16BIT_LSB	(0 << 1)
+#define AK4458_DIF_24BIT_MSB	(2 << 1)
+#define AK4458_DIF_24BIT_I2S	(3 << 1)
+#define AK4458_DIF_24BIT_LSB	(4 << 1)
+#define AK4458_DIF_32BIT_LSB	(5 << 1)
+#define AK4458_DIF_32BIT_MSB	(6 << 1)
+#define AK4458_DIF_32BIT_I2S	(7 << 1)
+
+/* AK4458_00_CONTROL1 (0x00) D0 bit */
+#define AK4458_RSTN_MASK		0x01
+#define AK4458_RSTN			(0x1 << 0)
+
+/* ACKS is Auto mode so disable the Manual feature */
+#ifdef AK4458_ACKS_USE_MANUAL_MODE
+/* AK4458_01_CONTROL2 (0x01) and AK4458_05_CONTROL4 (0x05) Fields */
+#define AK4458_DFS01_MASK		0x18
+#define AK4458_DFS2__MASK		0x02
+#define AK4458_DFS01_48KHZ		(0x0 << 3)  //  30kHz to 54kHz
+#define AK4458_DFS2__48KHZ		(0x0 << 1)  //  30kHz to 54kHz
+
+#define AK4458_DFS01_96KHZ		(0x1 << 3)  //  54kHz to 108kHz
+#define AK4458_DFS2__96KHZ		(0x0 << 1)  //  54kHz to 108kHz
+
+#define AK4458_DFS01_192KHZ		(0x2 << 3)  //  120kHz  to 216kHz
+#define AK4458_DFS2__192KHZ		(0x0 << 1)  //  120kHz  to 216kHz
+
+#define AK4458_DFS01_384KHZ		(0x0 << 3)	//	384kHz
+#define AK4458_DFS2__384KHZ		(0x1 << 1)	//	384kHz
+
+#define AK4458_DFS01_768KHZ		(0x1 << 3)	//	768kHz
+#define AK4458_DFS2__768KHZ		(0x1 << 1)	//	768kHz
+#endif
+
+extern const struct regmap_config ak4458_i2c_regmap_config;
+extern const struct regmap_config ak4458_spi_regmap_config;
+extern const struct dev_pm_ops ak4458_pm;
+
+int ak4458_probe(struct device *dev, struct regmap *regmap);
+void ak4458_remove(struct device *dev);
+
+#endif
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
