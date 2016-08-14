From: John Keeping <john@metanate.com>
Subject: [PATCH 1/2] ASoC: rt5677: Add ACPI support
Date: Sun, 14 Aug 2016 12:18:22 +0100
Message-ID: <20160814111823.1782-2-john@metanate.com>
References: <20160814111823.1782-1-john@metanate.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160814111823.1782-1-john@metanate.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ben Zhang <benzh@chromium.org>, Dylan Reid <dgreid@chromium.org>, John Keeping <john@metanate.com>
List-Id: alsa-devel@alsa-project.org

The Chromebook Pixel 2015 uses this codec with the ACPI ID RT5677CE, so
add an ACPI match table and support for reading properties from ACPI.

Signed-off-by: John Keeping <john@metanate.com>
---
 sound/soc/codecs/rt5677.c | 109 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index da9483c1c6fb..72c4e15a0cc8 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -9,6 +9,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/acpi.h>
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -40,6 +41,15 @@
 
 #define RT5677_PR_BASE (RT5677_PR_RANGE_BASE + (0 * RT5677_PR_SPACING))
 
+/* GPIO indexes defined by ACPI */
+enum {
+	RT5677_GPIO_PLUG_DET,
+	RT5677_GPIO_MIC_PRESENT_L,
+	RT5677_GPIO_HOTWORD_DET_L,
+	RT5677_GPIO_DSP_INT,
+	RT5677_GPIO_HP_AMP_SHDN_L,
+};
+
 static const struct regmap_range_cfg rt5677_ranges[] = {
 	{
 		.name = "PR",
@@ -5022,29 +5032,57 @@ static const struct i2c_device_id rt5677_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5677_i2c_id);
 
+static const struct acpi_gpio_params plug_det_gpio = { RT5677_GPIO_PLUG_DET, 0, false };
+static const struct acpi_gpio_params mic_present_gpio = { RT5677_GPIO_MIC_PRESENT_L, 0, false };
+static const struct acpi_gpio_params headphone_enable_gpio = { RT5677_GPIO_HP_AMP_SHDN_L, 0, false };
+
+static const struct acpi_gpio_mapping bdw_rt5677_gpios[] = {
+	{ "plug-det-gpios", &plug_det_gpio, 1 },
+	{ "mic-present-gpios", &mic_present_gpio, 1 },
+	{ "headphone-enable-gpios", &headphone_enable_gpio, 1 },
+	{ NULL },
+};
+
 static void rt5677_read_device_properties(struct rt5677_priv *rt5677,
 		struct device *dev)
 {
-	rt5677->pdata.in1_diff = device_property_read_bool(dev,
-			"realtek,in1-differential");
-	rt5677->pdata.in2_diff = device_property_read_bool(dev,
-			"realtek,in2-differential");
-	rt5677->pdata.lout1_diff = device_property_read_bool(dev,
-			"realtek,lout1-differential");
-	rt5677->pdata.lout2_diff = device_property_read_bool(dev,
-			"realtek,lout2-differential");
-	rt5677->pdata.lout3_diff = device_property_read_bool(dev,
-			"realtek,lout3-differential");
-
-	device_property_read_u8_array(dev, "realtek,gpio-config",
-			rt5677->pdata.gpio_config, RT5677_GPIO_NUM);
-
-	device_property_read_u32(dev, "realtek,jd1-gpio",
-			&rt5677->pdata.jd1_gpio);
-	device_property_read_u32(dev, "realtek,jd2-gpio",
-			&rt5677->pdata.jd2_gpio);
-	device_property_read_u32(dev, "realtek,jd3-gpio",
-			&rt5677->pdata.jd3_gpio);
+	if (ACPI_HANDLE(dev)) {
+		u32 val;
+
+		if (!device_property_read_u32(dev, "DCLK", &val))
+			rt5677->pdata.dmic2_clk_pin = val;
+
+		rt5677->pdata.in1_diff = device_property_read_bool(dev, "IN1");
+		rt5677->pdata.in2_diff = device_property_read_bool(dev, "IN2");
+		rt5677->pdata.lout1_diff = device_property_read_bool(dev, "OUT1");
+		rt5677->pdata.lout2_diff = device_property_read_bool(dev, "OUT2");
+		rt5677->pdata.lout3_diff = device_property_read_bool(dev, "OUT3");
+
+		device_property_read_u32(dev, "JD1", &rt5677->pdata.jd1_gpio);
+		device_property_read_u32(dev, "JD2", &rt5677->pdata.jd2_gpio);
+		device_property_read_u32(dev, "JD3", &rt5677->pdata.jd3_gpio);
+	} else {
+		rt5677->pdata.in1_diff = device_property_read_bool(dev,
+				"realtek,in1-differential");
+		rt5677->pdata.in2_diff = device_property_read_bool(dev,
+				"realtek,in2-differential");
+		rt5677->pdata.lout1_diff = device_property_read_bool(dev,
+				"realtek,lout1-differential");
+		rt5677->pdata.lout2_diff = device_property_read_bool(dev,
+				"realtek,lout2-differential");
+		rt5677->pdata.lout3_diff = device_property_read_bool(dev,
+				"realtek,lout3-differential");
+
+		device_property_read_u8_array(dev, "realtek,gpio-config",
+				rt5677->pdata.gpio_config, RT5677_GPIO_NUM);
+
+		device_property_read_u32(dev, "realtek,jd1-gpio",
+				&rt5677->pdata.jd1_gpio);
+		device_property_read_u32(dev, "realtek,jd2-gpio",
+				&rt5677->pdata.jd2_gpio);
+		device_property_read_u32(dev, "realtek,jd3-gpio",
+				&rt5677->pdata.jd3_gpio);
+	}
 }
 
 static struct regmap_irq rt5677_irqs[] = {
@@ -5123,7 +5161,27 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, rt5677);
 
-	rt5677->type = id->driver_data;
+	if (ACPI_HANDLE(&i2c->dev)) {
+		const struct acpi_device_id *acpi_id;
+
+		acpi_id = acpi_match_device(i2c->dev.driver->acpi_match_table,
+					    &i2c->dev);
+		if (!acpi_id) {
+			dev_err(&i2c->dev, "No driver data\n");
+			return -EINVAL;
+		}
+		rt5677->type = acpi_id->driver_data;
+
+		ret = acpi_dev_add_driver_gpios(ACPI_COMPANION(&i2c->dev),
+						bdw_rt5677_gpios);
+		if (ret) {
+			dev_err(&i2c->dev, "Failed to add driver gpios\n");
+			return ret;
+		}
+
+	} else if (id) {
+		rt5677->type = id->driver_data;
+	}
 
 	if (pdata)
 		rt5677->pdata = *pdata;
@@ -5238,9 +5296,18 @@ static int rt5677_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id rt5677_acpi_id[] = {
+	{ "RT5677CE", RT5677 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, rt5677_acpi_id);
+#endif
+
 static struct i2c_driver rt5677_i2c_driver = {
 	.driver = {
 		.name = "rt5677",
+		.acpi_match_table = ACPI_PTR(rt5677_acpi_id),
 	},
 	.probe = rt5677_i2c_probe,
 	.remove   = rt5677_i2c_remove,
-- 
2.9.3.728.g30b24b4.dirty
