From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH 3/3] ASoC: MAX9877: add MAX9877 amp driver
Date: Wed, 15 Jul 2009 20:34:00 +0900
Message-ID: <4A5DBEA8.3060201@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 1877A10382B
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jul 2009 13:34:03 +0200 (CEST)
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KMT006FTMSOGK@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 15 Jul 2009 20:34:00 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KMT00GSXMSOOT@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 15 Jul 2009 20:34:00 +0900 (KST)
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
Cc: kyungmin.park@samsung.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The MAX9877 combines a high-efficiency Class D audio power amplifier
with a stereo Class AB capacitor-less DirectDrive headphone amplifier.

The max9877_add_controls() is called to register the MAX9877 specific
controls on machine specific init() of the machine driver.

The datasheet for the MAX9877 can find at the following url:
http://datasheets.maxim-ic.com/en/ds/MAX9877.pdf

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
This patch is version 2. I updated from review of version 1.

Change log:
v2: - add SND_SOC_MAX9877 to SND_SOC_ALL_CODECS on Kconfig.
    - use SOC_DOUBLE_R_EXT_TLV instead of SOC_SINGLE_EXT_TLV for HP
      volume control.
    - modify max9877_get_reg() and max9877_set_reg for double reg
      controls.
    - add EXPORT_SYMBOL_GPL(max9877_add_controls).
    

 sound/soc/codecs/Kconfig   |    5 +
 sound/soc/codecs/Makefile  |    6 +
 sound/soc/codecs/max9877.c |  270 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/max9877.h |   37 ++++++
 4 files changed, 318 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/max9877.c
 create mode 100644 sound/soc/codecs/max9877.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index b674d3a..16a710f 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -49,6 +49,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM9705 if SND_SOC_AC97_BUS
 	select SND_SOC_WM9712 if SND_SOC_AC97_BUS
 	select SND_SOC_WM9713 if SND_SOC_AC97_BUS
+	select SND_SOC_MAX9877 if I2C
         help
           Normally ASoC codec drivers are only built if a machine driver which
           uses them is also built since they are only usable with a machine
@@ -188,3 +189,7 @@ config SND_SOC_WM9712
 
 config SND_SOC_WM9713
 	tristate
+
+# Amp
+config SND_SOC_MAX9877
+	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 301eb08..cf111c9 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -38,6 +38,9 @@ snd-soc-wm9705-objs := wm9705.o
 snd-soc-wm9712-objs := wm9712.o
 snd-soc-wm9713-objs := wm9713.o
 
+# Amp
+snd-soc-max9877-objs := max9877.o
+
 obj-$(CONFIG_SND_SOC_AC97_CODEC)	+= snd-soc-ac97.o
 obj-$(CONFIG_SND_SOC_AD1980)	+= snd-soc-ad1980.o
 obj-$(CONFIG_SND_SOC_AD73311) += snd-soc-ad73311.o
@@ -77,3 +80,6 @@ obj-$(CONFIG_SND_SOC_WM9081)	+= snd-soc-wm9081.o
 obj-$(CONFIG_SND_SOC_WM9705)	+= snd-soc-wm9705.o
 obj-$(CONFIG_SND_SOC_WM9712)	+= snd-soc-wm9712.o
 obj-$(CONFIG_SND_SOC_WM9713)	+= snd-soc-wm9713.o
+
+# Amp
+obj-$(CONFIG_SND_SOC_MAX9877)	+= snd-soc-max9877.o
diff --git a/sound/soc/codecs/max9877.c b/sound/soc/codecs/max9877.c
new file mode 100644
index 0000000..7df9a7c
--- /dev/null
+++ b/sound/soc/codecs/max9877.c
@@ -0,0 +1,270 @@
+/*
+ * max9877.c  --  amp driver for max9877
+ *
+ * Copyright (C) 2009 Samsung Electronics Co.Ltd
+ * Author: Joonyoung Shim <jy0922.shim@samsung.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#include "max9877.h"
+
+static struct i2c_client *i2c;
+
+static u8 max9877_regs[5] = { 0x40, 0x00, 0x00, 0x00, 0x49 };
+
+static void max9877_write_regs(void)
+{
+	if (i2c_master_send(i2c, max9877_regs, 5) != 5)
+		dev_err(&i2c->dev, "i2c write failed\n");
+}
+
+static int max9877_get_reg(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int reg = mc->reg;
+	int reg2 = mc->rreg;
+	int shift = mc->shift;
+	int mask = mc->max;
+
+	ucontrol->value.integer.value[0] = (max9877_regs[reg] >> shift) & mask;
+
+	if (reg2)
+		ucontrol->value.integer.value[1] =
+			(max9877_regs[reg2] >> shift) & mask;
+
+	return 0;
+}
+
+static int max9877_set_reg(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int reg = mc->reg;
+	int reg2 = mc->rreg;
+	int shift = mc->shift;
+	int mask = mc->max;
+	int change = 1;
+	int change2 = 1;
+	int ret = 0;
+
+	if (((max9877_regs[reg] >> shift) & mask) ==
+			ucontrol->value.integer.value[0])
+		change = 0;
+
+	if (reg2)
+		if (((max9877_regs[reg2] >> shift) & mask) ==
+				ucontrol->value.integer.value[1])
+			change2 = 0;
+
+	if (change) {
+		max9877_regs[reg] &= ~(mask << shift);
+		max9877_regs[reg] |= ucontrol->value.integer.value[0] << shift;
+		ret = change;
+	}
+
+	if (reg2 && change2) {
+		max9877_regs[reg2] &= ~(mask << shift);
+		max9877_regs[reg2] |= ucontrol->value.integer.value[1] << shift;
+		ret = change2;
+	}
+
+	if (ret)
+		max9877_write_regs();
+
+	return ret;
+}
+
+static int max9877_get_out_mode(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	u8 value = max9877_regs[MAX9877_OUTPUT_MODE] & MAX9877_OUTMODE_MASK;
+
+	if (value)
+		value -= 1;
+
+	ucontrol->value.integer.value[0] = value;
+	return 0;
+}
+
+static int max9877_set_out_mode(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	u8 value = ucontrol->value.integer.value[0];
+
+	if (value)
+		value += 1;
+
+	if ((max9877_regs[MAX9877_OUTPUT_MODE] & MAX9877_OUTMODE_MASK) == value)
+		return 0;
+
+	max9877_regs[MAX9877_OUTPUT_MODE] |= value;
+	max9877_write_regs();
+	return 1;
+}
+
+static int max9877_get_osc_mode(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	u8 value = (max9877_regs[MAX9877_OUTPUT_MODE] & MAX9877_OSC_MASK);
+
+	value = value >> MAX9877_OSC_OFFSET;
+
+	ucontrol->value.integer.value[0] = value;
+	return 0;
+}
+
+static int max9877_set_osc_mode(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	u8 value = ucontrol->value.integer.value[0];
+
+	value = value << MAX9877_OSC_OFFSET;
+	if ((max9877_regs[MAX9877_OUTPUT_MODE] & MAX9877_OSC_MASK) == value)
+		return 0;
+
+	max9877_regs[MAX9877_OUTPUT_MODE] |= value;
+	max9877_write_regs();
+	return 1;
+}
+
+static const unsigned int max9877_pgain_tlv[] = {
+	TLV_DB_RANGE_HEAD(2),
+	0, 1, TLV_DB_SCALE_ITEM(0, 900, 0),
+	2, 2, TLV_DB_SCALE_ITEM(2000, 0, 0),
+};
+
+static const unsigned int max9877_output_tlv[] = {
+	TLV_DB_RANGE_HEAD(4),
+	0, 7, TLV_DB_SCALE_ITEM(-7900, 400, 1),
+	8, 15, TLV_DB_SCALE_ITEM(-4700, 300, 0),
+	16, 23, TLV_DB_SCALE_ITEM(-2300, 200, 0),
+	24, 31, TLV_DB_SCALE_ITEM(-700, 100, 0),
+};
+
+static const char *max9877_out_mode[] = {
+	"INA -> SPK",
+	"INA -> HP",
+	"INA -> SPK and HP",
+	"INB -> SPK",
+	"INB -> HP",
+	"INB -> SPK and HP",
+	"INA + INB -> SPK",
+	"INA + INB -> HP",
+	"INA + INB -> SPK and HP",
+};
+
+static const char *max9877_osc_mode[] = {
+	"1176KHz",
+	"1100KHz",
+	"700KHz",
+};
+
+static const struct soc_enum max9877_enum[] = {
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(max9877_out_mode), max9877_out_mode),
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(max9877_osc_mode), max9877_osc_mode),
+};
+
+static const struct snd_kcontrol_new max9877_controls[] = {
+	SOC_SINGLE_EXT_TLV("MAX9877 PGAINA Playback Volume",
+			MAX9877_INPUT_MODE, 0, 2, 0,
+			max9877_get_reg, max9877_set_reg, max9877_pgain_tlv),
+	SOC_SINGLE_EXT_TLV("MAX9877 PGAINB Playback Volume",
+			MAX9877_INPUT_MODE, 2, 2, 0,
+			max9877_get_reg, max9877_set_reg, max9877_pgain_tlv),
+	SOC_SINGLE_EXT_TLV("MAX9877 Amp Speaker Playback Volume",
+			MAX9877_SPK_VOLUME, 0, 31, 0,
+			max9877_get_reg, max9877_set_reg, max9877_output_tlv),
+	SOC_DOUBLE_R_EXT_TLV("MAX9877 Amp HP Playback Volume",
+			MAX9877_HPL_VOLUME, MAX9877_HPR_VOLUME, 0, 31, 0,
+			max9877_get_reg, max9877_set_reg, max9877_output_tlv),
+	SOC_SINGLE_EXT("MAX9877 INB Stereo Switch",
+			MAX9877_INPUT_MODE, 4, 1, 1,
+			max9877_get_reg, max9877_set_reg),
+	SOC_SINGLE_EXT("MAX9877 INA Stereo Switch",
+			MAX9877_INPUT_MODE, 5, 1, 1,
+			max9877_get_reg, max9877_set_reg),
+	SOC_SINGLE_EXT("MAX9877 Zero-crossing detection Switch",
+			MAX9877_INPUT_MODE, 6, 1, 0,
+			max9877_get_reg, max9877_set_reg),
+	SOC_SINGLE_EXT("MAX9877 Bypass Mode Switch",
+			MAX9877_OUTPUT_MODE, 6, 1, 0,
+			max9877_get_reg, max9877_set_reg),
+	SOC_SINGLE_EXT("MAX9877 Shutdown Mode Switch",
+			MAX9877_OUTPUT_MODE, 7, 1, 1,
+			max9877_get_reg, max9877_set_reg),
+	SOC_ENUM_EXT("MAX9877 Output Mode", max9877_enum[0],
+			max9877_get_out_mode, max9877_set_out_mode),
+	SOC_ENUM_EXT("MAX9877 Oscillator Mode", max9877_enum[1],
+			max9877_get_osc_mode, max9877_set_osc_mode),
+};
+
+/* This function is called from ASoC machine driver */
+int max9877_add_controls(struct snd_soc_codec *codec)
+{
+	return snd_soc_add_controls(codec, max9877_controls,
+			ARRAY_SIZE(max9877_controls));
+}
+EXPORT_SYMBOL_GPL(max9877_add_controls);
+
+static int __devinit max9877_i2c_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	i2c = client;
+
+	max9877_write_regs();
+
+	return 0;
+}
+
+static __devexit int max9877_i2c_remove(struct i2c_client *client)
+{
+	i2c = NULL;
+
+	return 0;
+}
+
+static const struct i2c_device_id max9877_i2c_id[] = {
+	{ "max9877", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max9877_i2c_id);
+
+static struct i2c_driver max9877_i2c_driver = {
+	.driver = {
+		.name = "max9877",
+		.owner = THIS_MODULE,
+	},
+	.probe = max9877_i2c_probe,
+	.remove = __devexit_p(max9877_i2c_remove),
+	.id_table = max9877_i2c_id,
+};
+
+static int __init max9877_init(void)
+{
+	return i2c_add_driver(&max9877_i2c_driver);
+}
+module_init(max9877_init);
+
+static void __exit max9877_exit(void)
+{
+	i2c_del_driver(&max9877_i2c_driver);
+}
+module_exit(max9877_exit);
+
+MODULE_DESCRIPTION("ASoC MAX9877 amp driver");
+MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/max9877.h b/sound/soc/codecs/max9877.h
new file mode 100644
index 0000000..6da7229
--- /dev/null
+++ b/sound/soc/codecs/max9877.h
@@ -0,0 +1,37 @@
+/*
+ * max9877.h  --  amp driver for max9877
+ *
+ * Copyright (C) 2009 Samsung Electronics Co.Ltd
+ * Author: Joonyoung Shim <jy0922.shim@samsung.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#ifndef _MAX9877_H
+#define _MAX9877_H
+
+#define MAX9877_INPUT_MODE		0x00
+#define MAX9877_SPK_VOLUME		0x01
+#define MAX9877_HPL_VOLUME		0x02
+#define MAX9877_HPR_VOLUME		0x03
+#define MAX9877_OUTPUT_MODE		0x04
+
+/* MAX9877_INPUT_MODE */
+#define MAX9877_INB			(1 << 4)
+#define MAX9877_INA			(1 << 5)
+#define MAX9877_ZCD			(1 << 6)
+
+/* MAX9877_OUTPUT_MODE */
+#define MAX9877_OUTMODE_MASK		(15 << 0)
+#define MAX9877_OSC_MASK		(3 << 4)
+#define MAX9877_OSC_OFFSET		4
+#define MAX9877_BYPASS			(1 << 6)
+#define MAX9877_SHDN			(1 << 7)
+
+extern int max9877_add_controls(struct snd_soc_codec *codec);
+
+#endif
-- 
1.6.0.4
