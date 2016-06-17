From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8810: Add driver for Nuvoton codec
	chip NAU88C10
Date: Fri, 17 Jun 2016 16:40:34 +0800
Message-ID: <1466152834-29615-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C870D26070C
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2016 10:39:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, John Hsu <KCHSU0@nuvoton.com>, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The driver is for codec NAU88C10 of Nuvoton Technology Corporation.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 .../devicetree/bindings/sound/nau8810.txt          |  16 +
 sound/soc/codecs/Kconfig                           |   5 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/nau8810.c                         | 833 +++++++++++++++++++++
 sound/soc/codecs/nau8810.h                         | 272 +++++++
 5 files changed, 1128 insertions(+)
 create mode 100755 Documentation/devicetree/bindings/sound/nau8810.txt
 create mode 100755 sound/soc/codecs/nau8810.c
 create mode 100755 sound/soc/codecs/nau8810.h

diff --git a/Documentation/devicetree/bindings/sound/nau8810.txt b/Documentation/devicetree/bindings/sound/nau8810.txt
new file mode 100755
index 0000000..05830e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nau8810.txt
@@ -0,0 +1,16 @@
+NAU8810 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+
+  - compatible : "nuvoton,nau8810"
+
+  - reg : the I2C address of the device.
+
+Example:
+
+codec: nau8810@1a {
+	compatible = "nuvoton,nau8810";
+	reg = <0x1a>;
+};
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index cb57f8f..bbd7324 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -91,6 +91,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_MAX9877 if I2C
 	select SND_SOC_MC13783 if MFD_MC13XXX
 	select SND_SOC_ML26124 if I2C
+	select SND_SOC_NAU8810 if I2C
 	select SND_SOC_NAU8825 if I2C
 	select SND_SOC_HDMI_CODEC
 	select SND_SOC_PCM1681 if I2C
@@ -1046,6 +1047,10 @@ config SND_SOC_MC13783
 config SND_SOC_ML26124
 	tristate
 
+config SND_SOC_NAU8810
+	tristate "Nuvoton Technology Corporation NAU88C10 CODEC"
+	depends on I2C
+
 config SND_SOC_NAU8825
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 550a174..3c15bc5 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -84,6 +84,7 @@ snd-soc-max9850-objs := max9850.o
 snd-soc-max9860-objs := max9860.o
 snd-soc-mc13783-objs := mc13783.o
 snd-soc-ml26124-objs := ml26124.o
+snd-soc-nau8810-objs := nau8810.o
 snd-soc-nau8825-objs := nau8825.o
 snd-soc-hdmi-codec-objs := hdmi-codec.o
 snd-soc-pcm1681-objs := pcm1681.o
@@ -301,6 +302,7 @@ obj-$(CONFIG_SND_SOC_MAX9850)	+= snd-soc-max9850.o
 obj-$(CONFIG_SND_SOC_MAX9860)	+= snd-soc-max9860.o
 obj-$(CONFIG_SND_SOC_MC13783)	+= snd-soc-mc13783.o
 obj-$(CONFIG_SND_SOC_ML26124)	+= snd-soc-ml26124.o
+obj-$(CONFIG_SND_SOC_NAU8810)   += snd-soc-nau8810.o
 obj-$(CONFIG_SND_SOC_NAU8825)   += snd-soc-nau8825.o
 obj-$(CONFIG_SND_SOC_HDMI_CODEC)	+= snd-soc-hdmi-codec.o
 obj-$(CONFIG_SND_SOC_PCM1681)	+= snd-soc-pcm1681.o
diff --git a/sound/soc/codecs/nau8810.c b/sound/soc/codecs/nau8810.c
new file mode 100755
index 0000000..d03e9c76
--- /dev/null
+++ b/sound/soc/codecs/nau8810.c
@@ -0,0 +1,833 @@
+/*
+ * nau8810.c  --  NAU8810 ALSA Soc Audio driver
+ *
+ * Copyright 2016 Nuvoton Technology Corp.
+ *
+ * Author: David Lin <ctlin0@nuvoton.com>
+ *
+ * Based on WM8974.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+
+#include "nau8810.h"
+
+
+static const int nau8810_mclk_scaler[] = { 10, 15, 20, 30, 40, 60, 80, 120 };
+
+static const struct reg_default nau8810_reg_defaults[] = {
+	{ NAU8810_REG_POWER1, 0x0000 },
+	{ NAU8810_REG_POWER2, 0x0000 },
+	{ NAU8810_REG_POWER3, 0x0000 },
+	{ NAU8810_REG_IFACE, 0x0050 },
+	{ NAU8810_REG_COMP, 0x0000 },
+	{ NAU8810_REG_CLOCK, 0x0140 },
+	{ NAU8810_REG_SMPLR, 0x0000 },
+	{ NAU8810_REG_DAC, 0x0000 },
+	{ NAU8810_REG_DACGAIN, 0x00FF },
+	{ NAU8810_REG_ADC, 0x0100 },
+	{ NAU8810_REG_ADCGAIN, 0x00FF },
+	{ NAU8810_REG_EQ1, 0x012C },
+	{ NAU8810_REG_EQ2, 0x002C },
+	{ NAU8810_REG_EQ3, 0x002C },
+	{ NAU8810_REG_EQ4, 0x002C },
+	{ NAU8810_REG_EQ5, 0x002C },
+	{ NAU8810_REG_DACLIM1, 0x0032 },
+	{ NAU8810_REG_DACLIM2, 0x0000 },
+	{ NAU8810_REG_NOTCH1, 0x0000 },
+	{ NAU8810_REG_NOTCH2, 0x0000 },
+	{ NAU8810_REG_NOTCH3, 0x0000 },
+	{ NAU8810_REG_NOTCH4, 0x0000 },
+	{ NAU8810_REG_ALC1, 0x0038 },
+	{ NAU8810_REG_ALC2, 0x000B },
+	{ NAU8810_REG_ALC3, 0x0032 },
+	{ NAU8810_REG_NOISEGATE, 0x0000 },
+	{ NAU8810_REG_PLLN, 0x0008 },
+	{ NAU8810_REG_PLLK1, 0x000C },
+	{ NAU8810_REG_PLLK2, 0x0093 },
+	{ NAU8810_REG_PLLK3, 0x00E9 },
+	{ NAU8810_REG_ATTEN, 0x0000 },
+	{ NAU8810_REG_INPUT_SIGNAL, 0x0003 },
+	{ NAU8810_REG_PGAGAIN, 0x0010 },
+	{ NAU8810_REG_ADCBOOST, 0x0100 },
+	{ NAU8810_REG_OUTPUT, 0x0002 },
+	{ NAU8810_REG_SPKMIX, 0x0001 },
+	{ NAU8810_REG_SPKGAIN, 0x0039 },
+	{ NAU8810_REG_MONOMIX, 0x0001 },
+	{ NAU8810_REG_POWER4, 0x0000 },
+	{ NAU8810_REG_TSLOTCTL1, 0x0000 },
+	{ NAU8810_REG_TSLOTCTL2, 0x0020 },
+	{ NAU8810_REG_DEVICE_REVID, 0x00EF },
+	{ NAU8810_REG_I2C_DEVICEID, 0x001A },
+	{ NAU8810_REG_ADDITIONID, 0x00CA },
+	{ NAU8810_REG_RESERVE, 0x0124 },
+	{ NAU8810_REG_OUTCTL, 0x0001 },
+	{ NAU8810_REG_ALC1ENHAN1, 0x0000 },
+	{ NAU8810_REG_ALC1ENHAN2, 0x0039 },
+	{ NAU8810_REG_MISCCTL, 0x0000 },
+	{ NAU8810_REG_OUTTIEOFF, 0x0000 },
+	{ NAU8810_REG_AGCP2POUT, 0x0000 },
+	{ NAU8810_REG_AGCPOUT, 0x0000 },
+	{ NAU8810_REG_AMTCTL, 0x0000 },
+	{ NAU8810_REG_OUTTIEOFFMAN, 0x0000 },
+};
+
+static bool nau8810_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case NAU8810_REG_RESET ... NAU8810_REG_SMPLR:
+	case NAU8810_REG_DAC ... NAU8810_REG_DACGAIN:
+	case NAU8810_REG_ADC ... NAU8810_REG_ADCGAIN:
+	case NAU8810_REG_EQ1 ... NAU8810_REG_EQ5:
+	case NAU8810_REG_DACLIM1 ... NAU8810_REG_DACLIM2:
+	case NAU8810_REG_NOTCH1 ... NAU8810_REG_NOTCH4:
+	case NAU8810_REG_ALC1 ... NAU8810_REG_ATTEN:
+	case NAU8810_REG_INPUT_SIGNAL ... NAU8810_REG_PGAGAIN:
+	case NAU8810_REG_ADCBOOST:
+	case NAU8810_REG_OUTPUT ... NAU8810_REG_SPKMIX:
+	case NAU8810_REG_SPKGAIN:
+	case NAU8810_REG_MONOMIX:
+	case NAU8810_REG_POWER4 ... NAU8810_REG_TSLOTCTL2:
+	case NAU8810_REG_DEVICE_REVID ... NAU8810_REG_RESERVE:
+	case NAU8810_REG_ALC1ENHAN1 ... NAU8810_REG_ALC1ENHAN2:
+	case NAU8810_REG_MISCCTL:
+	case NAU8810_REG_OUTTIEOFF ... NAU8810_REG_OUTTIEOFFMAN:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool nau8810_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case NAU8810_REG_RESET ... NAU8810_REG_SMPLR:
+	case NAU8810_REG_DAC ... NAU8810_REG_DACGAIN:
+	case NAU8810_REG_ADC ... NAU8810_REG_ADCGAIN:
+	case NAU8810_REG_EQ1 ... NAU8810_REG_EQ5:
+	case NAU8810_REG_DACLIM1 ... NAU8810_REG_DACLIM2:
+	case NAU8810_REG_NOTCH1 ... NAU8810_REG_NOTCH4:
+	case NAU8810_REG_ALC1 ... NAU8810_REG_ATTEN:
+	case NAU8810_REG_INPUT_SIGNAL ... NAU8810_REG_PGAGAIN:
+	case NAU8810_REG_ADCBOOST:
+	case NAU8810_REG_OUTPUT ... NAU8810_REG_SPKMIX:
+	case NAU8810_REG_SPKGAIN:
+	case NAU8810_REG_MONOMIX:
+	case NAU8810_REG_POWER4 ... NAU8810_REG_TSLOTCTL2:
+	case NAU8810_REG_ALC1ENHAN1 ... NAU8810_REG_ALC1ENHAN2:
+	case NAU8810_REG_MISCCTL:
+	case NAU8810_REG_OUTTIEOFF ... NAU8810_REG_OUTTIEOFFMAN:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool nau8810_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case NAU8810_REG_RESET:
+	case NAU8810_REG_EQ1 ... NAU8810_REG_EQ5:
+	case NAU8810_REG_NOTCH1 ... NAU8810_REG_NOTCH4:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int nau8810_reg_write(void *context, unsigned int reg,
+			      unsigned int value)
+{
+	struct i2c_client *client = context;
+	uint8_t buf[2];
+	__be16 *out = (void *)buf;
+	int ret;
+
+	*out = cpu_to_be16((reg << 9) | value);
+	ret = i2c_master_send(client, buf, sizeof(buf));
+	if (ret == sizeof(buf))
+		return 0;
+	else if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
+static int nau8810_reg_read(void *context, unsigned int reg,
+			     unsigned int *value)
+{
+	struct i2c_client *client = context;
+	struct i2c_msg xfer[2];
+	uint8_t reg_buf;
+	uint16_t val_buf;
+	int ret;
+
+	reg_buf = (uint8_t)(reg << 1);
+	xfer[0].addr = client->addr;
+	xfer[0].len = sizeof(reg_buf);
+	xfer[0].buf = &reg_buf;
+	xfer[0].flags = 0;
+
+	xfer[1].addr = client->addr;
+	xfer[1].len = sizeof(val_buf);
+	xfer[1].buf = (uint8_t *)&val_buf;
+	xfer[1].flags = I2C_M_RD;
+
+	ret = i2c_transfer(client->adapter, xfer, ARRAY_SIZE(xfer));
+	if (ret < 0)
+		return ret;
+	else if (ret != ARRAY_SIZE(xfer))
+		return -EIO;
+
+	*value = be16_to_cpu(val_buf);
+
+	return 0;
+}
+
+static const char * const nau8810_companding[] = {
+	"Off", "NC", "u-law", "A-law"
+};
+static const char * const nau8810_deemp[] = {
+	"None", "32kHz", "44.1kHz", "48kHz"
+};
+static const char * const nau8810_eqmode[] = {"Capture", "Playback" };
+static const char * const nau8810_bw[] = {"Narrow", "Wide" };
+static const char * const nau8810_eq1[] = {
+	"80Hz", "105Hz", "135Hz", "175Hz"
+};
+static const char * const nau8810_eq2[] = {
+	"230Hz", "300Hz", "385Hz", "500Hz"
+};
+static const char * const nau8810_eq3[] = {
+	"650Hz", "850Hz", "1.1kHz", "1.4kHz"
+};
+static const char * const nau8810_eq4[] = {
+	"1.8kHz", "2.4kHz", "3.2kHz", "4.1kHz"
+};
+static const char * const nau8810_eq5[] = {
+	"5.3kHz", "6.9kHz", "9kHz", "11.7kHz"
+};
+static const char * const nau8810_alc[] = {"Normal", "Limiter" };
+
+static const struct soc_enum nau8810_enum[] = {
+	SOC_ENUM_SINGLE(NAU8810_REG_COMP, NAU8810_ADCCM_SFT,
+		ARRAY_SIZE(nau8810_companding), nau8810_companding),
+	SOC_ENUM_SINGLE(NAU8810_REG_COMP, NAU8810_DACCM_SFT,
+		ARRAY_SIZE(nau8810_companding), nau8810_companding),
+	SOC_ENUM_SINGLE(NAU8810_REG_DAC, NAU8810_DEEMP_SFT,
+		ARRAY_SIZE(nau8810_deemp), nau8810_deemp),
+	SOC_ENUM_SINGLE(NAU8810_REG_EQ1, NAU8810_EQM_SFT,
+		ARRAY_SIZE(nau8810_eqmode), nau8810_eqmode),
+
+	SOC_ENUM_SINGLE(NAU8810_REG_EQ1, NAU8810_EQ1CF_SFT,
+		ARRAY_SIZE(nau8810_eq1), nau8810_eq1),
+	SOC_ENUM_SINGLE(NAU8810_REG_EQ2, NAU8810_EQ2BW_SFT,
+		ARRAY_SIZE(nau8810_bw), nau8810_bw),
+	SOC_ENUM_SINGLE(NAU8810_REG_EQ2, NAU8810_EQ2CF_SFT,
+		ARRAY_SIZE(nau8810_eq2), nau8810_eq2),
+	SOC_ENUM_SINGLE(NAU8810_REG_EQ3, NAU8810_EQ3BW_SFT,
+		ARRAY_SIZE(nau8810_bw), nau8810_bw),
+
+	SOC_ENUM_SINGLE(NAU8810_REG_EQ3, NAU8810_EQ3CF_SFT,
+		ARRAY_SIZE(nau8810_eq3), nau8810_eq3),
+	SOC_ENUM_SINGLE(NAU8810_REG_EQ4, NAU8810_EQ4BW_SFT,
+		ARRAY_SIZE(nau8810_bw), nau8810_bw),
+	SOC_ENUM_SINGLE(NAU8810_REG_EQ4, NAU8810_EQ4CF_SFT,
+		ARRAY_SIZE(nau8810_eq4), nau8810_eq4),
+	SOC_ENUM_SINGLE(NAU8810_REG_EQ5, NAU8810_EQ5CF_SFT,
+		ARRAY_SIZE(nau8810_eq5), nau8810_eq5),
+
+	SOC_ENUM_SINGLE(NAU8810_REG_ALC3, NAU8810_ALCM_SFT,
+		ARRAY_SIZE(nau8810_alc), nau8810_alc),
+};
+
+static const DECLARE_TLV_DB_SCALE(digital_tlv, -12750, 50, 1);
+static const DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
+static const DECLARE_TLV_DB_SCALE(inpga_tlv, -1200, 75, 0);
+static const DECLARE_TLV_DB_SCALE(spk_tlv, -5700, 100, 0);
+
+static const struct snd_kcontrol_new nau8810_snd_controls[] = {
+
+	SOC_ENUM("ADC Companding", nau8810_enum[0]),
+	SOC_ENUM("DAC Companding", nau8810_enum[1]),
+	SOC_ENUM("DAC De-emphasis", nau8810_enum[2]),
+	SOC_ENUM("EQ Function", nau8810_enum[3]),
+	SOC_ENUM("EQ1 Cut Off", nau8810_enum[4]),
+	SOC_ENUM("EQ2 Bandwidth", nau8810_enum[5]),
+	SOC_ENUM("EQ2 Cut Off", nau8810_enum[6]),
+	SOC_ENUM("EQ3 Bandwidth", nau8810_enum[7]),
+	SOC_ENUM("EQ3 Cut Off", nau8810_enum[8]),
+	SOC_ENUM("EQ4 Bandwidth", nau8810_enum[9]),
+	SOC_ENUM("EQ4 Cut Off", nau8810_enum[10]),
+	SOC_ENUM("EQ5 Cut Off", nau8810_enum[11]),
+	SOC_ENUM("ALC Mode", nau8810_enum[12]),
+
+	SOC_SINGLE("Digital Loopback Switch", NAU8810_REG_COMP,
+		NAU8810_ADDAP_SFT, 1, 0),
+
+	SOC_SINGLE("DAC Inversion Switch", NAU8810_REG_DAC,
+		NAU8810_DACPL_SFT, 1, 0),
+	SOC_SINGLE_TLV("Playback Gain", NAU8810_REG_DACGAIN,
+		NAU8810_DACGAIN_SFT, 0xff, 0, digital_tlv),
+
+	SOC_SINGLE("High Pass Filter Switch", NAU8810_REG_ADC,
+		NAU8810_HPFEN_SFT, 1, 0),
+	SOC_SINGLE("High Pass Cut Off", NAU8810_REG_ADC,
+		NAU8810_HPF_SFT, 0x7, 0),
+
+	SOC_SINGLE("ADC Inversion Switch", NAU8810_REG_ADC,
+		NAU8810_ADCPL_SFT, 1, 0),
+	SOC_SINGLE_TLV("Capture Gain", NAU8810_REG_ADCGAIN,
+		NAU8810_ADCGAIN_SFT, 0xff, 0, digital_tlv),
+
+	SOC_SINGLE_TLV("EQ1 Gain", NAU8810_REG_EQ1,
+		NAU8810_EQ1GC_SFT, 0x18, 1, eq_tlv),
+	SOC_SINGLE_TLV("EQ2 Gain", NAU8810_REG_EQ2,
+		NAU8810_EQ2GC_SFT, 0x18, 1, eq_tlv),
+	SOC_SINGLE_TLV("EQ3 Gain", NAU8810_REG_EQ3,
+		NAU8810_EQ3GC_SFT, 0x18, 1, eq_tlv),
+	SOC_SINGLE_TLV("EQ4 Gain", NAU8810_REG_EQ4,
+		NAU8810_EQ4GC_SFT, 0x18, 1, eq_tlv),
+	SOC_SINGLE_TLV("EQ5 Gain", NAU8810_REG_EQ5,
+		NAU8810_EQ5GC_SFT, 0x18, 1, eq_tlv),
+
+	SOC_SINGLE("DAC Limiter Switch", NAU8810_REG_DACLIM1,
+		NAU8810_DACLIMEN_SFT, 1, 0),
+	SOC_SINGLE("DAC Limiter Decay", NAU8810_REG_DACLIM1,
+		NAU8810_DACLIMDCY_SFT, 0xf, 0),
+	SOC_SINGLE("DAC Limiter Attack", NAU8810_REG_DACLIM1,
+		NAU8810_DACLIMATK_SFT, 0xf, 0),
+
+	SOC_SINGLE("DAC Limiter Threshold", NAU8810_REG_DACLIM2,
+		NAU8810_DACLIMTHL_SFT, 0x7, 0),
+	SOC_SINGLE("DAC Limiter Boost", NAU8810_REG_DACLIM2,
+		NAU8810_DACLIMBST_SFT, 0xf, 0),
+
+	SOC_SINGLE("ALC Enable Switch", NAU8810_REG_ALC1,
+		NAU8810_ALCEN_SFT, 1, 0),
+	SOC_SINGLE("ALC Max Gain", NAU8810_REG_ALC1,
+		NAU8810_ALCMXGAIN_SFT, 0x7, 0),
+	SOC_SINGLE("ALC Min Gain", NAU8810_REG_ALC1,
+		NAU8810_ALCMINGAIN_SFT, 0x7, 0),
+
+	SOC_SINGLE("ALC ZC Switch", NAU8810_REG_ALC2,
+		NAU8810_ALCZC_SFT, 1, 0),
+	SOC_SINGLE("ALC Hold", NAU8810_REG_ALC2,
+		NAU8810_ALCHT_SFT, 0xf, 0),
+	SOC_SINGLE("ALC Target", NAU8810_REG_ALC2,
+		NAU8810_ALCSL_SFT, 0xf, 0),
+
+	SOC_SINGLE("ALC Decay", NAU8810_REG_ALC3,
+		NAU8810_ALCDCY_SFT, 0xf, 0),
+	SOC_SINGLE("ALC Attack", NAU8810_REG_ALC3,
+		NAU8810_ALCATK_SFT, 0xf, 0),
+
+	SOC_SINGLE("ALC Noise Gate Switch", NAU8810_REG_NOISEGATE,
+		NAU8810_ALCNEN_SFT, 1, 0),
+	SOC_SINGLE("ALC Noise Gate Threshold", NAU8810_REG_NOISEGATE,
+		NAU8810_ALCNTH_SFT, 0x7, 0),
+
+	SOC_SINGLE("PGA ZC Switch", NAU8810_REG_PGAGAIN,
+		NAU8810_PGAZC_SFT, 1, 0),
+	SOC_SINGLE_TLV("PGA Volume", NAU8810_REG_PGAGAIN,
+		NAU8810_PGAGAIN_SFT, 0x3f, 0, inpga_tlv),
+
+	SOC_SINGLE("Speaker ZC Switch", NAU8810_REG_SPKGAIN,
+		NAU8810_SPKZC_SFT, 1, 0),
+	SOC_SINGLE("Speaker Mute Switch", NAU8810_REG_SPKGAIN,
+		NAU8810_SPKMT_SFT, 1, 0),
+	SOC_SINGLE_TLV("Speaker Volume", NAU8810_REG_SPKGAIN,
+		NAU8810_SPKGAIN_SFT, 0x3f, 0, spk_tlv),
+
+	SOC_SINGLE("Capture Boost(+20dB)", NAU8810_REG_ADCBOOST,
+		NAU8810_PGABST_SFT, 1, 0),
+	SOC_SINGLE("Mono Mute Switch", NAU8810_REG_MONOMIX,
+		NAU8810_MOUTMXMT_SFT, 1, 0),
+
+	SOC_SINGLE("DAC Oversampling Rate(128x) Switch", NAU8810_REG_DAC,
+		NAU8810_DACOS_SFT, 1, 0),
+	SOC_SINGLE("ADC Oversampling Rate(128x) Switch", NAU8810_REG_ADC,
+		NAU8810_ADCOS_SFT, 1, 0),
+};
+
+/* Speaker Output Mixer */
+static const struct snd_kcontrol_new nau8810_speaker_mixer_controls[] = {
+	SOC_DAPM_SINGLE("Line Bypass Switch", NAU8810_REG_SPKMIX,
+		NAU8810_BYPSPK_SFT, 1, 0),
+	SOC_DAPM_SINGLE("PCM Playback Switch", NAU8810_REG_SPKMIX,
+		NAU8810_DACSPK_SFT, 1, 0),
+};
+
+/* Mono Output Mixer */
+static const struct snd_kcontrol_new nau8810_mono_mixer_controls[] = {
+	SOC_DAPM_SINGLE("Line Bypass Switch", NAU8810_REG_MONOMIX,
+		NAU8810_BYPMOUT_SFT, 1, 0),
+	SOC_DAPM_SINGLE("PCM Playback Switch", NAU8810_REG_MONOMIX,
+		NAU8810_DACMOUT_SFT, 1, 0),
+};
+
+/* PGA Mute */
+static const struct snd_kcontrol_new nau8810_inpga_mute[] = {
+	SOC_DAPM_SINGLE("PGA Mute Switch", NAU8810_REG_PGAGAIN,
+		NAU8810_PGAMT_SFT, 1, 0),
+};
+
+/* Input PGA */
+static const struct snd_kcontrol_new nau8810_inpga[] = {
+	SOC_DAPM_SINGLE("MicN Switch", NAU8810_REG_INPUT_SIGNAL,
+		NAU8810_NMICPGA_SFT, 1, 0),
+	SOC_DAPM_SINGLE("MicP Switch", NAU8810_REG_INPUT_SIGNAL,
+		NAU8810_PMICPGA_SFT, 1, 0),
+};
+
+/* Mic Input boost vol */
+static const struct snd_kcontrol_new nau8810_mic_boost_controls =
+	SOC_DAPM_SINGLE("Mic Volume", NAU8810_REG_ADCBOOST,
+		NAU8810_PMICBSTGAIN_SFT, 0x7, 0);
+
+static const struct snd_soc_dapm_widget nau8810_dapm_widgets[] = {
+	SND_SOC_DAPM_MIXER("Speaker Mixer", NAU8810_REG_POWER3,
+		NAU8810_SPKMX_EN_SFT, 0, &nau8810_speaker_mixer_controls[0],
+		ARRAY_SIZE(nau8810_speaker_mixer_controls)),
+	SND_SOC_DAPM_MIXER("Mono Mixer", NAU8810_REG_POWER3,
+		NAU8810_MOUTMX_EN_SFT, 0, &nau8810_mono_mixer_controls[0],
+		ARRAY_SIZE(nau8810_mono_mixer_controls)),
+	SND_SOC_DAPM_DAC("DAC", "HiFi Playback", NAU8810_REG_POWER3,
+		NAU8810_DAC_EN_SFT, 0),
+	SND_SOC_DAPM_ADC("ADC", "HiFi Capture", NAU8810_REG_POWER2,
+		NAU8810_ADC_EN_SFT, 0),
+	SND_SOC_DAPM_PGA("SpkN Out", NAU8810_REG_POWER3,
+		NAU8810_NSPK_EN_SFT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("SpkP Out", NAU8810_REG_POWER3,
+		NAU8810_PSPK_EN_SFT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Mono Out", NAU8810_REG_POWER3,
+		NAU8810_MOUT_EN_SFT, 0, NULL, 0),
+
+	SND_SOC_DAPM_MIXER("Input PGA", NAU8810_REG_POWER2,
+		NAU8810_PGA_EN_SFT, 0, nau8810_inpga,
+		ARRAY_SIZE(nau8810_inpga)),
+	SND_SOC_DAPM_MIXER("Input Boost Stage", NAU8810_REG_POWER2,
+		NAU8810_BST_EN_SFT, 0, nau8810_inpga_mute,
+		ARRAY_SIZE(nau8810_inpga_mute)),
+
+	SND_SOC_DAPM_SUPPLY("Mic Bias", NAU8810_REG_POWER1,
+		NAU8810_MICBIAS_EN_SFT, 0, NULL, 0),
+
+	SND_SOC_DAPM_INPUT("MICN"),
+	SND_SOC_DAPM_INPUT("MICP"),
+	SND_SOC_DAPM_OUTPUT("MONOOUT"),
+	SND_SOC_DAPM_OUTPUT("SPKOUTP"),
+	SND_SOC_DAPM_OUTPUT("SPKOUTN"),
+};
+
+static const struct snd_soc_dapm_route nau8810_dapm_routes[] = {
+	/* Mono output mixer */
+	{"Mono Mixer", "PCM Playback Switch", "DAC"},
+	{"Mono Mixer", "Line Bypass Switch", "Input Boost Stage"},
+
+	/* Speaker output mixer */
+	{"Speaker Mixer", "PCM Playback Switch", "DAC"},
+	{"Speaker Mixer", "Line Bypass Switch", "Input Boost Stage"},
+
+	/* Outputs */
+	{"Mono Out", NULL, "Mono Mixer"},
+	{"MONOOUT", NULL, "Mono Out"},
+	{"SpkN Out", NULL, "Speaker Mixer"},
+	{"SpkP Out", NULL, "Speaker Mixer"},
+	{"SPKOUTN", NULL, "SpkN Out"},
+	{"SPKOUTP", NULL, "SpkP Out"},
+
+	/* Input Boost Stage */
+	{"ADC", NULL, "Input Boost Stage"},
+	{"Input Boost Stage", NULL, "Input PGA"},
+	{"Input Boost Stage", NULL, "MICP"},
+
+	/* Input PGA */
+	{"Input PGA", "MicN Switch", "MICN"},
+	{"Input PGA", "MicP Switch", "MICP"},
+};
+
+static int nau8810_set_sysclk(struct snd_soc_dai *dai,
+				 int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct nau8810 *nau8810 = snd_soc_codec_get_drvdata(codec);
+
+	nau8810->sysclk = freq;
+	dev_dbg(nau8810->dev, "master sysclk %dHz\n", nau8810->sysclk);
+
+	return 0;
+}
+
+static int nau8810_config_clkdiv(struct nau8810 *nau8810, int div, int rate)
+{
+	struct regmap *regmap = nau8810->regmap;
+	int i, sclk, imclk;
+
+	switch (nau8810->div_id) {
+	case NAU8810_MCLK_DIV_PLL:
+		/* master clock from PLL and enable PLL */
+		regmap_update_bits(regmap, NAU8810_REG_CLOCK,
+			NAU8810_MCLKSEL_MASK, (div << NAU8810_MCLKSEL_SFT));
+		regmap_update_bits(regmap, NAU8810_REG_POWER1,
+			NAU8810_PLL_EN, NAU8810_PLL_EN);
+		regmap_update_bits(regmap, NAU8810_REG_CLOCK,
+			NAU8810_CLKM_MASK, NAU8810_CLKM_PLL);
+		break;
+
+	case NAU8810_MCLK_DIV_MCLK:
+		/* Configure the master clock prescaler div to make system
+		 * clock to approximate the internal master clock (IMCLK);
+		 * and large or equal to IMCLK.
+		 */
+		div = 0;
+		imclk = rate * 256;
+		for (i = 1; i < ARRAY_SIZE(nau8810_mclk_scaler); i++) {
+			sclk = (nau8810->sysclk * 10) /
+				nau8810_mclk_scaler[i];
+			if (sclk < imclk)
+				break;
+			div = i;
+		}
+		dev_dbg(nau8810->dev,
+			"master clock prescaler %x for fs %d\n", div, rate);
+
+		/* master clock from MCLK and disable PLL */
+		regmap_update_bits(regmap, NAU8810_REG_CLOCK,
+			NAU8810_MCLKSEL_MASK, (div << NAU8810_MCLKSEL_SFT));
+		regmap_update_bits(regmap, NAU8810_REG_CLOCK,
+			NAU8810_CLKM_MASK, NAU8810_CLKM_MCLK);
+		regmap_update_bits(regmap, NAU8810_REG_POWER1,
+			NAU8810_PLL_EN, 0);
+		break;
+
+	case NAU8810_BCLK_DIV:
+		regmap_update_bits(regmap, NAU8810_REG_CLOCK,
+			NAU8810_BCLKSEL_MASK, (div << NAU8810_BCLKSEL_SFT));
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int nau8810_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct nau8810 *nau8810 = snd_soc_codec_get_drvdata(codec);
+	int ret = 0;
+
+	nau8810->div_id = div_id;
+	if (div_id != NAU8810_MCLK_DIV_MCLK)
+		/* Defer the master clock prescaler configuration to DAI
+		 * hardware parameter if master clock from MCLK because
+		 * it needs runtime fs information to get the proper div.
+		 */
+		ret = nau8810_config_clkdiv(nau8810, div, 0);
+
+	return ret;
+}
+
+static int nau8810_set_dai_fmt(struct snd_soc_dai *codec_dai,
+		unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct nau8810 *nau8810 = snd_soc_codec_get_drvdata(codec);
+	u16 ctrl1_val = 0, ctrl2_val = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		ctrl2_val |= NAU8810_CLKIO_MASTER;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		ctrl1_val |= NAU8810_AIFMT_I2S;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		ctrl1_val |= NAU8810_AIFMT_LEFT;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		ctrl1_val |= NAU8810_AIFMT_PCM_A;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		ctrl1_val |= NAU8810_BCLKP_IB | NAU8810_FSP_IF;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		ctrl1_val |= NAU8810_BCLKP_IB;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		ctrl1_val |= NAU8810_FSP_IF;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(nau8810->regmap, NAU8810_REG_IFACE,
+		NAU8810_AIFMT_MASK | NAU8810_FSP_IF |
+		NAU8810_BCLKP_IB, ctrl1_val);
+	regmap_update_bits(nau8810->regmap, NAU8810_REG_CLOCK,
+		NAU8810_CLKIO_MASK, ctrl2_val);
+
+	return 0;
+}
+
+static int nau8810_pcm_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct nau8810 *nau8810 = snd_soc_codec_get_drvdata(codec);
+	int val_len = 0, val_rate = 0;
+
+	switch (params_width(params)) {
+	case 16:
+		break;
+	case 20:
+		val_len |= NAU8810_WLEN_20;
+		break;
+	case 24:
+		val_len |= NAU8810_WLEN_24;
+		break;
+	case 32:
+		val_len |= NAU8810_WLEN_32;
+		break;
+	}
+
+	switch (params_rate(params)) {
+	case 8000:
+		val_rate |= NAU8810_SMPLR_8K;
+		break;
+	case 11025:
+		val_rate |= NAU8810_SMPLR_12K;
+		break;
+	case 16000:
+		val_rate |= NAU8810_SMPLR_16K;
+		break;
+	case 22050:
+		val_rate |= NAU8810_SMPLR_24K;
+		break;
+	case 32000:
+		val_rate |= NAU8810_SMPLR_32K;
+		break;
+	case 44100:
+	case 48000:
+		break;
+	}
+
+	regmap_update_bits(nau8810->regmap, NAU8810_REG_IFACE,
+		NAU8810_WLEN_MASK, val_len);
+	regmap_update_bits(nau8810->regmap, NAU8810_REG_SMPLR,
+		NAU8810_SMPLR_MASK, val_rate);
+
+	/* If the master clock is from MCLK, provide the runtime FS for driver
+	 * to get the master clock prescaler configuration.
+	 */
+	if (nau8810->div_id == NAU8810_MCLK_DIV_MCLK)
+		nau8810_config_clkdiv(nau8810, 0, params_rate(params));
+
+	return 0;
+}
+
+static int nau8810_set_bias_level(struct snd_soc_codec *codec,
+	enum snd_soc_bias_level level)
+{
+	struct nau8810 *nau8810 = snd_soc_codec_get_drvdata(codec);
+	struct regmap *map = nau8810->regmap;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+	case SND_SOC_BIAS_PREPARE:
+		regmap_update_bits(map, NAU8810_REG_POWER1,
+			NAU8810_REFIMP_MASK, NAU8810_REFIMP_80K);
+		break;
+
+	case SND_SOC_BIAS_STANDBY:
+		regmap_update_bits(map, NAU8810_REG_POWER1,
+			NAU8810_IOBUF_EN | NAU8810_ABIAS_EN,
+			NAU8810_IOBUF_EN | NAU8810_ABIAS_EN);
+
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+			regcache_sync(map);
+			regmap_update_bits(map, NAU8810_REG_POWER1,
+				NAU8810_REFIMP_MASK, NAU8810_REFIMP_3K);
+			mdelay(100);
+		}
+		regmap_update_bits(map, NAU8810_REG_POWER1,
+			NAU8810_REFIMP_MASK, NAU8810_REFIMP_300K);
+		break;
+
+	case SND_SOC_BIAS_OFF:
+		regmap_write(map, NAU8810_REG_POWER1, 0);
+		regmap_write(map, NAU8810_REG_POWER2, 0);
+		regmap_write(map, NAU8810_REG_POWER3, 0);
+		break;
+	}
+
+	return 0;
+}
+
+
+#define NAU8810_RATES (SNDRV_PCM_RATE_8000_48000)
+
+#define NAU8810_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
+	SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+static const struct snd_soc_dai_ops nau8810_ops = {
+	.hw_params = nau8810_pcm_hw_params,
+	.set_fmt = nau8810_set_dai_fmt,
+	.set_sysclk = nau8810_set_sysclk,
+	.set_clkdiv = nau8810_set_clkdiv,
+};
+
+static struct snd_soc_dai_driver nau8810_dai = {
+	.name = "nau8810-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,   /* Only 1 channel of data */
+		.rates = NAU8810_RATES,
+		.formats = NAU8810_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,   /* Only 1 channel of data */
+		.rates = NAU8810_RATES,
+		.formats = NAU8810_FORMATS,
+	},
+	.ops = &nau8810_ops,
+	.symmetric_rates = 1,
+};
+
+static const struct regmap_config nau8810_regmap_config = {
+	.reg_bits = 7,
+	.val_bits = 9,
+
+	.max_register = NAU8810_REG_MAX,
+	.readable_reg = nau8810_readable_reg,
+	.writeable_reg = nau8810_writeable_reg,
+	.volatile_reg = nau8810_volatile_reg,
+	.reg_read = nau8810_reg_read,
+	.reg_write = nau8810_reg_write,
+
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = nau8810_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(nau8810_reg_defaults),
+};
+
+static int nau8810_probe(struct snd_soc_codec *codec)
+{
+	struct nau8810 *nau8810 = snd_soc_codec_get_drvdata(codec);
+
+	regmap_write(nau8810->regmap, NAU8810_REG_RESET, 0x00);
+
+	return 0;
+}
+
+static struct snd_soc_codec_driver soc_codec_dev_nau8810 = {
+	.probe = nau8810_probe,
+	.set_bias_level = nau8810_set_bias_level,
+	.suspend_bias_off = true,
+
+	.controls = nau8810_snd_controls,
+	.num_controls = ARRAY_SIZE(nau8810_snd_controls),
+	.dapm_widgets = nau8810_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(nau8810_dapm_widgets),
+	.dapm_routes = nau8810_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(nau8810_dapm_routes),
+};
+
+static int nau8810_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	struct device *dev = &i2c->dev;
+	struct nau8810 *nau8810 = dev_get_platdata(dev);
+
+	if (!nau8810) {
+		nau8810 = devm_kzalloc(dev, sizeof(*nau8810), GFP_KERNEL);
+		if (!nau8810)
+			return -ENOMEM;
+	}
+	i2c_set_clientdata(i2c, nau8810);
+
+	nau8810->regmap = devm_regmap_init(dev, NULL,
+				i2c, &nau8810_regmap_config);
+	if (IS_ERR(nau8810->regmap))
+		return PTR_ERR(nau8810->regmap);
+
+	nau8810->dev = dev;
+
+	return snd_soc_register_codec(dev,
+		&soc_codec_dev_nau8810, &nau8810_dai, 1);
+}
+
+static int nau8810_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+
+	return 0;
+}
+
+static const struct i2c_device_id nau8810_i2c_id[] = {
+	{ "nau8810", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, nau8810_i2c_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id nau8810_of_match[] = {
+	{ .compatible = "nuvoton,nau8810", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, nau8810_of_match);
+#endif
+
+static struct i2c_driver nau8810_i2c_driver = {
+	.driver = {
+		.name = "nau8810",
+		.of_match_table = of_match_ptr(nau8810_of_match),
+	},
+	.probe =    nau8810_i2c_probe,
+	.remove =   nau8810_i2c_remove,
+	.id_table = nau8810_i2c_id,
+};
+
+module_i2c_driver(nau8810_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC NAU8810 driver");
+MODULE_AUTHOR("David Lin <ctlin0@nuvoton.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/nau8810.h b/sound/soc/codecs/nau8810.h
new file mode 100755
index 0000000..174d26e
--- /dev/null
+++ b/sound/soc/codecs/nau8810.h
@@ -0,0 +1,272 @@
+/*
+ * NAU8810 ALSA SoC audio driver
+ *
+ * Copyright 2016 Nuvoton Technology Corp.
+ * Author: David Lin <ctlin0@nuvoton.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __NAU8810_H__
+#define __NAU8810_H__
+
+#define NAU8810_REG_RESET		0x00
+#define NAU8810_REG_POWER1		0x01
+#define NAU8810_REG_POWER2		0x02
+#define NAU8810_REG_POWER3		0x03
+#define NAU8810_REG_IFACE		0x04
+#define NAU8810_REG_COMP		0x05
+#define NAU8810_REG_CLOCK		0x06
+#define NAU8810_REG_SMPLR		0x07
+#define NAU8810_REG_DAC		0x0A
+#define NAU8810_REG_DACGAIN		0x0B
+#define NAU8810_REG_ADC		0x0E
+#define NAU8810_REG_ADCGAIN		0x0F
+#define NAU8810_REG_EQ1		0x12
+#define NAU8810_REG_EQ2		0x13
+#define NAU8810_REG_EQ3		0x14
+#define NAU8810_REG_EQ4		0x15
+#define NAU8810_REG_EQ5		0x16
+#define NAU8810_REG_DACLIM1		0x18
+#define NAU8810_REG_DACLIM2		0x19
+#define NAU8810_REG_NOTCH1		0x1B
+#define NAU8810_REG_NOTCH2		0x1C
+#define NAU8810_REG_NOTCH3		0x1D
+#define NAU8810_REG_NOTCH4		0x1E
+#define NAU8810_REG_ALC1		0x20
+#define NAU8810_REG_ALC2		0x21
+#define NAU8810_REG_ALC3		0x22
+#define NAU8810_REG_NOISEGATE		0x23
+#define NAU8810_REG_PLLN		0x24
+#define NAU8810_REG_PLLK1		0x25
+#define NAU8810_REG_PLLK2		0x26
+#define NAU8810_REG_PLLK3		0x27
+#define NAU8810_REG_ATTEN		0x28
+#define NAU8810_REG_INPUT_SIGNAL	0x2C
+#define NAU8810_REG_PGAGAIN		0x2D
+#define NAU8810_REG_ADCBOOST		0x2F
+#define NAU8810_REG_OUTPUT		0x31
+#define NAU8810_REG_SPKMIX		0x32
+#define NAU8810_REG_SPKGAIN		0x36
+#define NAU8810_REG_MONOMIX		0x38
+#define NAU8810_REG_POWER4		0x3A
+#define NAU8810_REG_TSLOTCTL1		0x3B
+#define NAU8810_REG_TSLOTCTL2		0x3C
+#define NAU8810_REG_DEVICE_REVID	0x3E
+#define NAU8810_REG_I2C_DEVICEID	0x3F
+#define NAU8810_REG_ADDITIONID	0x40
+#define NAU8810_REG_RESERVE		0x41
+#define NAU8810_REG_OUTCTL		0x45
+#define NAU8810_REG_ALC1ENHAN1	0x46
+#define NAU8810_REG_ALC1ENHAN2	0x47
+#define NAU8810_REG_MISCCTL		0x49
+#define NAU8810_REG_OUTTIEOFF		0x4B
+#define NAU8810_REG_AGCP2POUT	0x4C
+#define NAU8810_REG_AGCPOUT		0x4D
+#define NAU8810_REG_AMTCTL		0x4E
+#define NAU8810_REG_OUTTIEOFFMAN	0x4F
+#define NAU8810_REG_MAX		NAU8810_REG_OUTTIEOFFMAN
+
+
+/* NAU8810_REG_POWER1 (0x1) */
+#define NAU8810_DCBUF_EN		(0x1 << 8)
+#define NAU8810_PLL_EN			(0x1 << 5)
+#define NAU8810_MICBIAS_EN_SFT	4
+#define NAU8810_ABIAS_EN		(0x1 << 3)
+#define NAU8810_IOBUF_EN		(0x1 << 2)
+#define NAU8810_REFIMP_MASK		0x3
+#define NAU8810_REFIMP_DIS		0x0
+#define NAU8810_REFIMP_80K		0x1
+#define NAU8810_REFIMP_300K		0x2
+#define NAU8810_REFIMP_3K		0x3
+
+/* NAU8810_REG_POWER2 (0x2) */
+#define NAU8810_BST_EN_SFT		4
+#define NAU8810_PGA_EN_SFT		2
+#define NAU8810_ADC_EN_SFT		0
+
+/* NAU8810_REG_POWER3 (0x3) */
+#define NAU8810_DAC_EN_SFT		0
+#define NAU8810_SPKMX_EN_SFT		2
+#define NAU8810_MOUTMX_EN_SFT	3
+#define NAU8810_PSPK_EN_SFT		5
+#define NAU8810_NSPK_EN_SFT		6
+#define NAU8810_MOUT_EN_SFT		7
+
+/* NAU8810_REG_IFACE (0x4) */
+#define NAU8810_AIFMT_SFT		3
+#define NAU8810_AIFMT_MASK		(0x3 << NAU8810_AIFMT_SFT)
+#define NAU8810_AIFMT_RIGHT		(0x0 << NAU8810_AIFMT_SFT)
+#define NAU8810_AIFMT_LEFT		(0x1 << NAU8810_AIFMT_SFT)
+#define NAU8810_AIFMT_I2S		(0x2 << NAU8810_AIFMT_SFT)
+#define NAU8810_AIFMT_PCM_A		(0x3 << NAU8810_AIFMT_SFT)
+#define NAU8810_WLEN_SFT		5
+#define NAU8810_WLEN_MASK		(0x3 << NAU8810_WLEN_SFT)
+#define NAU8810_WLEN_16		(0x0 << NAU8810_WLEN_SFT)
+#define NAU8810_WLEN_20		(0x1 << NAU8810_WLEN_SFT)
+#define NAU8810_WLEN_24		(0x2 << NAU8810_WLEN_SFT)
+#define NAU8810_WLEN_32		(0x3 << NAU8810_WLEN_SFT)
+#define NAU8810_FSP_IF			(0x1 << 7)
+#define NAU8810_BCLKP_IB		(0x1 << 8)
+
+/* NAU8810_REG_COMP (0x5) */
+#define NAU8810_ADDAP_SFT		0
+#define NAU8810_ADCCM_SFT		1
+#define NAU8810_DACCM_SFT		3
+
+/* NAU8810_REG_CLOCK (0x6) */
+#define NAU8810_CLKIO_MASK		0x1
+#define NAU8810_CLKIO_SLAVE		0x0
+#define NAU8810_CLKIO_MASTER		0x1
+#define NAU8810_BCLKSEL_SFT		2
+#define NAU8810_BCLKSEL_MASK		(0x7 << NAU8810_BCLKSEL_SFT)
+#define NAU8810_BCLKDIV_1		(0x0 << NAU8810_BCLKSEL_SFT)
+#define NAU8810_BCLKDIV_2		(0x1 << NAU8810_BCLKSEL_SFT)
+#define NAU8810_BCLKDIV_4		(0x2 << NAU8810_BCLKSEL_SFT)
+#define NAU8810_BCLKDIV_8		(0x3 << NAU8810_BCLKSEL_SFT)
+#define NAU8810_BCLKDIV_16		(0x4 << NAU8810_BCLKSEL_SFT)
+#define NAU8810_BCLKDIV_32		(0x5 << NAU8810_BCLKSEL_SFT)
+#define NAU8810_MCLKSEL_SFT		5
+#define NAU8810_MCLKSEL_MASK		(0x7 << NAU8810_MCLKSEL_SFT)
+#define NAU8810_CLKM_SFT		8
+#define NAU8810_CLKM_MASK		(0x1 << NAU8810_CLKM_SFT)
+#define NAU8810_CLKM_MCLK		(0x0 << NAU8810_CLKM_SFT)
+#define NAU8810_CLKM_PLL		(0x1 << NAU8810_CLKM_SFT)
+
+/* NAU8810_REG_SMPLR (0x7) */
+#define NAU8810_SMPLR_SFT		1
+#define NAU8810_SMPLR_MASK		(0x7 << NAU8810_SMPLR_SFT)
+#define NAU8810_SMPLR_48K		(0x0 << NAU8810_SMPLR_SFT)
+#define NAU8810_SMPLR_32K		(0x1 << NAU8810_SMPLR_SFT)
+#define NAU8810_SMPLR_24K		(0x2 << NAU8810_SMPLR_SFT)
+#define NAU8810_SMPLR_16K		(0x3 << NAU8810_SMPLR_SFT)
+#define NAU8810_SMPLR_12K		(0x4 << NAU8810_SMPLR_SFT)
+#define NAU8810_SMPLR_8K		(0x5 << NAU8810_SMPLR_SFT)
+
+/* NAU8810_REG_DAC (0xA) */
+#define NAU8810_DACPL_SFT		0
+#define NAU8810_DACOS_SFT		3
+#define NAU8810_DEEMP_SFT		4
+
+/* NAU8810_REG_DACGAIN (0xB) */
+#define NAU8810_DACGAIN_SFT		0
+
+/* NAU8810_REG_ADC (0xE) */
+#define NAU8810_ADCPL_SFT		0
+#define NAU8810_ADCOS_SFT		3
+#define NAU8810_HPF_SFT		4
+#define NAU8810_HPFEN_SFT		8
+
+/* NAU8810_REG_ADCGAIN (0xF) */
+#define NAU8810_ADCGAIN_SFT		0
+
+/* NAU8810_REG_EQ1 (0x12) */
+#define NAU8810_EQ1GC_SFT		0
+#define NAU8810_EQ1CF_SFT		5
+#define NAU8810_EQM_SFT		8
+
+/* NAU8810_REG_EQ2 (0x13) */
+#define NAU8810_EQ2GC_SFT		0
+#define NAU8810_EQ2CF_SFT		5
+#define NAU8810_EQ2BW_SFT		8
+
+/* NAU8810_REG_EQ3 (0x14) */
+#define NAU8810_EQ3GC_SFT		0
+#define NAU8810_EQ3CF_SFT		5
+#define NAU8810_EQ3BW_SFT		8
+
+/* NAU8810_REG_EQ4 (0x15) */
+#define NAU8810_EQ4GC_SFT		0
+#define NAU8810_EQ4CF_SFT		5
+#define NAU8810_EQ4BW_SFT		8
+
+/* NAU8810_REG_EQ5 (0x16) */
+#define NAU8810_EQ5GC_SFT		0
+#define NAU8810_EQ5CF_SFT		5
+
+/* NAU8810_REG_DACLIM1 (0x18) */
+#define NAU8810_DACLIMATK_SFT		0
+#define NAU8810_DACLIMDCY_SFT		4
+#define NAU8810_DACLIMEN_SFT		8
+
+/* NAU8810_REG_DACLIM2 (0x19) */
+#define NAU8810_DACLIMBST_SFT		0
+#define NAU8810_DACLIMTHL_SFT		4
+
+/* NAU8810_REG_ALC1 (0x20) */
+#define NAU8810_ALCMINGAIN_SFT	0
+#define NAU8810_ALCMXGAIN_SFT		3
+#define NAU8810_ALCEN_SFT		8
+
+/* NAU8810_REG_ALC2 (0x21) */
+#define NAU8810_ALCSL_SFT		0
+#define NAU8810_ALCHT_SFT		4
+#define NAU8810_ALCZC_SFT		8
+
+/* NAU8810_REG_ALC3 (0x22) */
+#define NAU8810_ALCATK_SFT		0
+#define NAU8810_ALCDCY_SFT		4
+#define NAU8810_ALCM_SFT		8
+
+/* NAU8810_REG_NOISEGATE (0x23) */
+#define NAU8810_ALCNTH_SFT		0
+#define NAU8810_ALCNEN_SFT		3
+
+/* NAU8810_REG_PLLN (0x24) */
+#define NAU8810_PLLN_MASK		0xF
+#define NAU8810_PLLMCLK_DIV2		(0x1 << 4)
+
+/* NAU8810_REG_PLLK1 (0x25) */
+#define NAU8810_PLLK1_MASK		0x3F
+
+/* NAU8810_REG_PLLK2 (0x26) */
+#define NAU8810_PLLK2_MASK		0x1FF
+
+/* NAU8810_REG_PLLK3 (0x27) */
+#define NAU8810_PLLK3_MASK		0x1FF
+
+/* NAU8810_REG_INPUT_SIGNAL (0x2C) */
+#define NAU8810_PMICPGA_SFT		0
+#define NAU8810_NMICPGA_SFT		1
+
+/* NAU8810_REG_PGAGAIN (0x2D) */
+#define NAU8810_PGAGAIN_SFT		0
+#define NAU8810_PGAMT_SFT		6
+#define NAU8810_PGAZC_SFT		7
+
+/* NAU8810_REG_ADCBOOST (0x2F) */
+#define NAU8810_PMICBSTGAIN_SFT	4
+#define NAU8810_PGABST_SFT		8
+
+/* NAU8810_REG_SPKMIX (0x32) */
+#define NAU8810_DACSPK_SFT		0
+#define NAU8810_BYPSPK_SFT		1
+
+/* NAU8810_REG_SPKGAIN (0x36) */
+#define NAU8810_SPKGAIN_SFT		0
+#define NAU8810_SPKMT_SFT		6
+#define NAU8810_SPKZC_SFT		7
+
+/* NAU8810_REG_MONOMIX (0x38) */
+#define NAU8810_DACMOUT_SFT		0
+#define NAU8810_BYPMOUT_SFT		1
+#define NAU8810_MOUTMXMT_SFT		6
+
+
+/* Clock divider Id's */
+enum {
+	NAU8810_MCLK_DIV_PLL,
+	NAU8810_MCLK_DIV_MCLK,
+	NAU8810_BCLK_DIV,
+};
+
+struct nau8810 {
+	struct device *dev;
+	struct regmap *regmap;
+	int sysclk;
+	int div_id;
+};
+
+#endif
-- 
2.6.4
