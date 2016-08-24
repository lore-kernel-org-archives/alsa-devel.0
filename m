From: John Keeping <john@metanate.com>
Subject: [PATCH v2 1/2] ASoC: rt5677: Add ACPI support
Date: Wed, 24 Aug 2016 22:06:35 +0100
Message-ID: <89438b4e87725c528e325ce278a0f4319402db28.1472071966.git.john@metanate.com>
References: <20160814111823.1782-1-john@metanate.com>
 <cover.1472071966.git.john@metanate.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1472071966.git.john@metanate.com>
In-Reply-To: <cover.1472071966.git.john@metanate.com>
References: <cover.1472071966.git.john@metanate.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: John Keeping <john@metanate.com>, linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ben Zhang <benzh@chromium.org>, Dylan Reid <dgreid@chromium.org>, Genki Marshall <genki@genki.is>, Tom Rini <trini@konsulko.com>
List-Id: alsa-devel@alsa-project.org

The Chromebook Pixel 2015 uses this codec with the ACPI ID RT5677CE, but
does not use the standard DT property names so add a new function to
parse the codec properties from these ACPI properties.

Also, the GPIOs are only available by index, so we need to register a
mapping to allow machine drivers to access the GPIOs by name.

Signed-off-by: John Keeping <john@metanate.com>
---
Changes in v2:
- Add explicit values to ACPI GPIO enum
- Add new function for reading ACPI properties, leave the existing
  rt5677_read_device_properties() as it was
- Add entry to i2c_device_id table instead of adding acpi_driver_id

 sound/soc/codecs/rt5677.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index da9483c1c6fb..0e7aba1af881 100644
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
+	RT5677_GPIO_PLUG_DET		= 0,
+	RT5677_GPIO_MIC_PRESENT_L	= 1,
+	RT5677_GPIO_HOTWORD_DET_L	= 2,
+	RT5677_GPIO_DSP_INT		= 3,
+	RT5677_GPIO_HP_AMP_SHDN_L	= 4,
+};
+
 static const struct regmap_range_cfg rt5677_ranges[] = {
 	{
 		.name = "PR",
@@ -5018,10 +5028,47 @@ static const struct regmap_config rt5677_regmap = {
 static const struct i2c_device_id rt5677_i2c_id[] = {
 	{ "rt5677", RT5677 },
 	{ "rt5676", RT5676 },
+	{ "RT5677CE:00", RT5677 },
 	{ }
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
+static void rt5677_read_acpi_properties(struct rt5677_priv *rt5677,
+		struct device *dev)
+{
+	int ret;
+	u32 val;
+
+	ret = acpi_dev_add_driver_gpios(ACPI_COMPANION(dev),
+			bdw_rt5677_gpios);
+	if (ret)
+		dev_warn(dev, "Failed to add driver gpios\n");
+
+	if (!device_property_read_u32(dev, "DCLK", &val))
+		rt5677->pdata.dmic2_clk_pin = val;
+
+	rt5677->pdata.in1_diff = device_property_read_bool(dev, "IN1");
+	rt5677->pdata.in2_diff = device_property_read_bool(dev, "IN2");
+	rt5677->pdata.lout1_diff = device_property_read_bool(dev, "OUT1");
+	rt5677->pdata.lout2_diff = device_property_read_bool(dev, "OUT2");
+	rt5677->pdata.lout3_diff = device_property_read_bool(dev, "OUT3");
+
+	device_property_read_u32(dev, "JD1", &rt5677->pdata.jd1_gpio);
+	device_property_read_u32(dev, "JD2", &rt5677->pdata.jd2_gpio);
+	device_property_read_u32(dev, "JD3", &rt5677->pdata.jd3_gpio);
+}
+
 static void rt5677_read_device_properties(struct rt5677_priv *rt5677,
 		struct device *dev)
 {
@@ -5127,8 +5174,12 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 
 	if (pdata)
 		rt5677->pdata = *pdata;
-	else
+	else if (i2c->dev.of_node)
 		rt5677_read_device_properties(rt5677, &i2c->dev);
+	else if (ACPI_HANDLE(&i2c->dev))
+		rt5677_read_acpi_properties(rt5677, &i2c->dev);
+	else
+		return -EINVAL;
 
 	/* pow-ldo2 and reset are optional. The codec pins may be statically
 	 * connected on the board without gpios. If the gpio device property
-- 
2.9.3.728.g30b24b4.dirty
