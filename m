From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH v2] ASoC: add TI ts3a227e headset chip driver
Date: Wed, 12 Nov 2014 16:15:38 -0800
Message-ID: <1415837738-22888-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f201.google.com (mail-pd0-f201.google.com
 [209.85.192.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BA1C2657DD
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 01:16:58 +0100 (CET)
Received: by mail-pd0-f201.google.com with SMTP id r10so2162504pdi.2
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 16:16:57 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: bleung@chromium.org, Dylan Reid <dgreid@chromium.org>, broonie@kernel.org, dmitry.torokhov@gmail.com
List-Id: alsa-devel@alsa-project.org

The TS3A227E is an autonomous audio accessory detection and
configuration switch that detects 3-pole or 4-pole audio accessories
and configures internal switches to route the signals accordingly.

This chip also has built-in support for the new button standard
described in the Android "Wired audio headset specification" v1.0.
These buttons will be reported on the jack as buttons 0-3 mapped to
KEY_MEDIA, KEY_VOLUMEUP, KEY_VOLUMEDOWN, and KEY_VOICE_COMMAND.

This will be added as an aux_dev and have the jack passed in from the
machine driver.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
Changes since v1:
Use button to key mapping instead of separate input device
---
 .../devicetree/bindings/sound/ts3a227e.txt         |  26 ++
 sound/soc/codecs/Kconfig                           |   5 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/ts3a227e.c                        | 321 +++++++++++++++++++++
 sound/soc/codecs/ts3a227e.h                        |  17 ++
 5 files changed, 371 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ts3a227e.txt
 create mode 100644 sound/soc/codecs/ts3a227e.c
 create mode 100644 sound/soc/codecs/ts3a227e.h

diff --git a/Documentation/devicetree/bindings/sound/ts3a227e.txt b/Documentation/devicetree/bindings/sound/ts3a227e.txt
new file mode 100644
index 0000000..e8bf23e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ts3a227e.txt
@@ -0,0 +1,26 @@
+Texas Instruments TS3A227E
+Autonomous Audio Accessory Detection and Configuration Switch
+
+The TS3A227E detect headsets of 3-ring and 4-ring standards and
+switches automatically to route the microphone correctly.  It also
+handles key press detection in accordance with the Android audio
+headset specification v1.0.
+
+Required properties:
+
+ - compatible:		Should contain "ti,ts3a227e".
+ - reg:			The i2c address. Should contain <0x3b>.
+ - interrupt-parent:	The parent interrupt controller
+ - interrupts:		Interrupt number for /INT pin from the 227e
+
+
+Examples:
+
+	i2c {
+		ts3a227e@3b {
+			compatible = "ti,ts3a227e";
+			reg = <0x3b>;
+			interrupt-parent = <&gpio>;
+			interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+		};
+	};
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index a68d173..243ec86 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -109,6 +109,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TLV320AIC3X if I2C
 	select SND_SOC_TPA6130A2 if I2C
 	select SND_SOC_TLV320DAC33 if I2C
+	select SND_SOC_TS3A227E if I2C
 	select SND_SOC_TWL4030 if TWL4030_CORE
 	select SND_SOC_TWL6040 if TWL6040_CORE
 	select SND_SOC_UDA134X
@@ -607,6 +608,10 @@ config SND_SOC_TLV320AIC3X
 config SND_SOC_TLV320DAC33
 	tristate
 
+config SND_SOC_TS3A227E
+	tristate "TI Headset/Mic detect and keypress chip"
+	depends on I2C
+
 config SND_SOC_TWL4030
 	select MFD_TWL4030_AUDIO
 	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 5dce451..a1eb7ef 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -109,6 +109,7 @@ snd-soc-tlv320aic31xx-objs := tlv320aic31xx.o
 snd-soc-tlv320aic32x4-objs := tlv320aic32x4.o
 snd-soc-tlv320aic3x-objs := tlv320aic3x.o
 snd-soc-tlv320dac33-objs := tlv320dac33.o
+snd-soc-ts3a227e-objs := ts3a227e.o
 snd-soc-twl4030-objs := twl4030.o
 snd-soc-twl6040-objs := twl6040.o
 snd-soc-uda134x-objs := uda134x.o
@@ -282,6 +283,7 @@ obj-$(CONFIG_SND_SOC_TLV320AIC31XX)     += snd-soc-tlv320aic31xx.o
 obj-$(CONFIG_SND_SOC_TLV320AIC32X4)     += snd-soc-tlv320aic32x4.o
 obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
 obj-$(CONFIG_SND_SOC_TLV320DAC33)	+= snd-soc-tlv320dac33.o
+obj-$(CONFIG_SND_SOC_TS3A227E)	+= snd-soc-ts3a227e.o
 obj-$(CONFIG_SND_SOC_TWL4030)	+= snd-soc-twl4030.o
 obj-$(CONFIG_SND_SOC_TWL6040)	+= snd-soc-twl6040.o
 obj-$(CONFIG_SND_SOC_UDA134X)	+= snd-soc-uda134x.o
diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
new file mode 100644
index 0000000..4ca6ddc
--- /dev/null
+++ b/sound/soc/codecs/ts3a227e.c
@@ -0,0 +1,321 @@
+/*
+ * TS3A227E Autonomous Audio Accessory Detection and Configuration Switch
+ *
+ * Copyright (C) 2014 Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/regmap.h>
+
+#include <sound/core.h>
+#include <sound/jack.h>
+#include <sound/soc.h>
+
+struct ts3a227e {
+	struct regmap *regmap;
+	struct snd_soc_jack *jack;
+	bool plugged;
+	bool mic_present;
+	unsigned int buttons_held;
+};
+
+/* Button values to be  reported on the jack */
+static const int ts3a227e_buttons[] = {
+	SND_JACK_BTN_0,
+	SND_JACK_BTN_1,
+	SND_JACK_BTN_2,
+	SND_JACK_BTN_3,
+};
+
+#define TS3A227E_NUM_BUTTONS 4
+#define TS3A227E_JACK_MASK (SND_JACK_HEADPHONE | \
+			    SND_JACK_MICROPHONE | \
+			    SND_JACK_BTN_0 | \
+			    SND_JACK_BTN_1 | \
+			    SND_JACK_BTN_2 | \
+			    SND_JACK_BTN_3)
+
+/* TS3A227E registers */
+#define TS3A227E_REG_DEVICE_ID		0x00
+#define TS3A227E_REG_INTERRUPT		0x01
+#define TS3A227E_REG_KP_INTERRUPT	0x02
+#define TS3A227E_REG_INTERRUPT_DISABLE	0x03
+#define TS3A227E_REG_SETTING_1		0x04
+#define TS3A227E_REG_SETTING_2		0x05
+#define TS3A227E_REG_SETTING_3		0x06
+#define TS3A227E_REG_SWITCH_CONTROL_1	0x07
+#define TS3A227E_REG_SWITCH_CONTROL_2	0x08
+#define TS3A227E_REG_SWITCH_STATUS_1	0x09
+#define TS3A227E_REG_SWITCH_STATUS_2	0x0a
+#define TS3A227E_REG_ACCESSORY_STATUS	0x0b
+#define TS3A227E_REG_ADC_OUTPUT		0x0c
+#define TS3A227E_REG_KP_THRESHOLD_1	0x0d
+#define TS3A227E_REG_KP_THRESHOLD_2	0x0e
+#define TS3A227E_REG_KP_THRESHOLD_3	0x0f
+
+/* TS3A227E_REG_INTERRUPT 0x01 */
+#define INS_REM_EVENT 0x01
+#define DETECTION_COMPLETE_EVENT 0x02
+
+/* TS3A227E_REG_KP_INTERRUPT 0x02 */
+#define PRESS_MASK(idx) (0x01 << (2 * (idx)))
+#define RELEASE_MASK(idx) (0x02 << (2 * (idx)))
+
+/* TS3A227E_REG_INTERRUPT_DISABLE 0x03 */
+#define INS_REM_INT_DISABLE 0x01
+#define DETECTION_COMPLETE_INT_DISABLE 0x02
+#define ADC_COMPLETE_INT_DISABLE 0x04
+#define INTB_DISABLE 0x08
+
+/* TS3A227E_REG_SETTING_2 0x05 */
+#define KP_ENABLE 0x04
+
+/* TS3A227E_REG_ACCESSORY_STATUS  0x0b */
+#define TYPE_3_POLE 0x01
+#define TYPE_4_POLE_OMTP 0x02
+#define TYPE_4_POLE_STANDARD 0x04
+#define JACK_INSERTED 0x08
+#define EITHER_MIC_MASK (TYPE_4_POLE_OMTP | TYPE_4_POLE_STANDARD)
+
+static const struct reg_default ts3a227e_reg_defaults[] = {
+	{ TS3A227E_REG_DEVICE_ID, 0x10 },
+	{ TS3A227E_REG_INTERRUPT, 0x00 },
+	{ TS3A227E_REG_KP_INTERRUPT, 0x00 },
+	{ TS3A227E_REG_INTERRUPT_DISABLE, 0x08 },
+	{ TS3A227E_REG_SETTING_1, 0x23 },
+	{ TS3A227E_REG_SETTING_2, 0x00 },
+	{ TS3A227E_REG_SETTING_3, 0x0e },
+	{ TS3A227E_REG_SWITCH_CONTROL_1, 0x00 },
+	{ TS3A227E_REG_SWITCH_CONTROL_2, 0x00 },
+	{ TS3A227E_REG_SWITCH_STATUS_1, 0x0c },
+	{ TS3A227E_REG_SWITCH_STATUS_2, 0x00 },
+	{ TS3A227E_REG_ACCESSORY_STATUS, 0x00 },
+	{ TS3A227E_REG_ADC_OUTPUT, 0x00 },
+	{ TS3A227E_REG_KP_THRESHOLD_1, 0x20 },
+	{ TS3A227E_REG_KP_THRESHOLD_2, 0x40 },
+	{ TS3A227E_REG_KP_THRESHOLD_3, 0x68 },
+};
+
+static bool ts3a227e_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TS3A227E_REG_DEVICE_ID ... TS3A227E_REG_KP_THRESHOLD_3:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool ts3a227e_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TS3A227E_REG_INTERRUPT_DISABLE ... TS3A227E_REG_SWITCH_CONTROL_2:
+	case TS3A227E_REG_KP_THRESHOLD_1 ... TS3A227E_REG_KP_THRESHOLD_3:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool ts3a227e_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TS3A227E_REG_INTERRUPT ... TS3A227E_REG_INTERRUPT_DISABLE:
+	case TS3A227E_REG_SETTING_2:
+	case TS3A227E_REG_SWITCH_STATUS_1 ... TS3A227E_REG_ADC_OUTPUT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void ts3a227e_jack_report(struct ts3a227e *ts3a227e)
+{
+	unsigned int i;
+	int report = 0;
+
+	if (!ts3a227e->jack)
+		return;
+
+	if (ts3a227e->plugged)
+		report = SND_JACK_HEADPHONE;
+	if (ts3a227e->mic_present)
+		report |= SND_JACK_MICROPHONE;
+	for (i = 0; i < TS3A227E_NUM_BUTTONS; i++) {
+		if (ts3a227e->buttons_held & (1 << i))
+			report |= ts3a227e_buttons[i];
+	}
+	snd_soc_jack_report(ts3a227e->jack, report, TS3A227E_JACK_MASK);
+}
+
+static void ts3a227e_new_jack_state(struct ts3a227e *ts3a227e, unsigned acc_reg)
+{
+	bool plugged, mic_present;
+
+	plugged = !!(acc_reg & JACK_INSERTED);
+	mic_present = plugged && !!(acc_reg & EITHER_MIC_MASK);
+
+	ts3a227e->plugged = plugged;
+
+	if (mic_present != ts3a227e->mic_present) {
+		ts3a227e->mic_present = mic_present;
+		ts3a227e->buttons_held = 0;
+		if (mic_present) {
+			/* Enable key press detection. */
+			regmap_update_bits(ts3a227e->regmap,
+					   TS3A227E_REG_SETTING_2,
+					   KP_ENABLE, KP_ENABLE);
+		}
+	}
+}
+
+static irqreturn_t ts3a227e_interrupt(int irq, void *data)
+{
+	struct ts3a227e *ts3a227e = (struct ts3a227e *)data;
+	struct regmap *regmap = ts3a227e->regmap;
+	unsigned int int_reg, kp_int_reg, acc_reg, i;
+
+	/* Check for plug/unplug. */
+	regmap_read(regmap, TS3A227E_REG_INTERRUPT, &int_reg);
+	if (int_reg & (DETECTION_COMPLETE_EVENT | INS_REM_EVENT)) {
+		regmap_read(regmap, TS3A227E_REG_ACCESSORY_STATUS, &acc_reg);
+		ts3a227e_new_jack_state(ts3a227e, acc_reg);
+	}
+
+	/* Report any key events. */
+	regmap_read(regmap, TS3A227E_REG_KP_INTERRUPT, &kp_int_reg);
+	for (i = 0; i < TS3A227E_NUM_BUTTONS; i++) {
+		if (kp_int_reg & PRESS_MASK(i))
+			ts3a227e->buttons_held |= (1 << i);
+		if (kp_int_reg & RELEASE_MASK(i))
+			ts3a227e->buttons_held &= ~(1 << i);
+	}
+
+	ts3a227e_jack_report(ts3a227e);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * ts3a227e_enable_jack_detect - Specify a jack for event reporting
+ *
+ * @codec:  codec to register the jack with
+ * @jack: jack to use to report headset and button events on
+ *
+ * After this function has been called the headset insert/remove and button
+ * events 0-3 will be routed to the given jack.  Jack can be null to stop
+ * reporting.
+ */
+int ts3a227e_enable_jack_detect(struct snd_soc_codec *codec,
+				struct snd_soc_jack *jack)
+{
+	struct ts3a227e *ts3a227e = snd_soc_codec_get_drvdata(codec);
+
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_MEDIA);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
+
+	ts3a227e->jack = jack;
+	ts3a227e_jack_report(ts3a227e);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ts3a227e_enable_jack_detect);
+
+static struct snd_soc_codec_driver ts3a227e_codec_driver;
+
+static const struct regmap_config ts3a227e_regmap_config = {
+	.val_bits = 8,
+	.reg_bits = 8,
+
+	.max_register = TS3A227E_REG_KP_THRESHOLD_3,
+	.readable_reg = ts3a227e_readable_reg,
+	.writeable_reg = ts3a227e_writeable_reg,
+	.volatile_reg = ts3a227e_volatile_reg,
+
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = ts3a227e_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(ts3a227e_reg_defaults),
+};
+
+static int ts3a227e_i2c_probe(struct i2c_client *i2c,
+			      const struct i2c_device_id *id)
+{
+	struct ts3a227e *ts3a227e;
+	struct device *dev = &i2c->dev;
+	int ret;
+
+	ts3a227e = devm_kzalloc(&i2c->dev, sizeof(*ts3a227e), GFP_KERNEL);
+	if (ts3a227e == NULL)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, ts3a227e);
+
+	ts3a227e->regmap = devm_regmap_init_i2c(i2c, &ts3a227e_regmap_config);
+	if (IS_ERR(ts3a227e->regmap))
+		return PTR_ERR(ts3a227e->regmap);
+
+	ret = devm_request_threaded_irq(dev, i2c->irq, NULL, ts3a227e_interrupt,
+					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					"TS3A227E", ts3a227e);
+	if (ret) {
+		dev_err(dev, "Cannot request irq %d (%d)\n", i2c->irq, ret);
+		return ret;
+	}
+
+	ret = snd_soc_register_codec(&i2c->dev, &ts3a227e_codec_driver,
+				     NULL, 0);
+	if (ret)
+		return ret;
+
+	/* Enable interrupts except for ADC complete. */
+	regmap_update_bits(ts3a227e->regmap, TS3A227E_REG_INTERRUPT_DISABLE,
+			   INTB_DISABLE | ADC_COMPLETE_INT_DISABLE,
+			   ADC_COMPLETE_INT_DISABLE);
+
+	return 0;
+}
+
+static int ts3a227e_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	return 0;
+}
+
+static const struct i2c_device_id ts3a227e_i2c_ids[] = {
+	{ "ts3a227e", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ts3a227e_i2c_ids);
+
+static const struct of_device_id ts3a227e_of_match[] = {
+	{ .compatible = "ti,ts3a227e", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ts3a227e_of_match);
+
+static struct i2c_driver ts3a227e_driver = {
+	.driver = {
+		.name = "ts3a227e",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(ts3a227e_of_match),
+	},
+	.probe = ts3a227e_i2c_probe,
+	.remove = ts3a227e_i2c_remove,
+	.id_table = ts3a227e_i2c_ids,
+};
+module_i2c_driver(ts3a227e_driver);
+
+MODULE_DESCRIPTION("ASoC ts3a227e driver");
+MODULE_AUTHOR("Dylan Reid <dgreid@chromium.org>");
+MODULE_LICENSE("GPLv2");
diff --git a/sound/soc/codecs/ts3a227e.h b/sound/soc/codecs/ts3a227e.h
new file mode 100644
index 0000000..8a58886
--- /dev/null
+++ b/sound/soc/codecs/ts3a227e.h
@@ -0,0 +1,17 @@
+/*
+ * TS3A227E Autonous Audio Accessory Detection and Configureation Switch
+ *
+ * Copyright (C) 2014 Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _TS3A227E_H
+#define _TS3A227E_H
+
+int ts3a227e_enable_jack_detect(struct snd_soc_codec *codec,
+				struct snd_soc_jack *jack);
+
+#endif
-- 
2.1.2.330.g565301e
