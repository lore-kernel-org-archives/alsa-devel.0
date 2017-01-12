From: Shrirang Bagul <shrirang.bagul@canonical.com>
Subject: [PATCH v2 1/4] ASoC: rt5660: Add ACPI support
Date: Thu, 12 Jan 2017 20:00:58 +0800
Message-ID: <20170112120101.16933-2-shrirang.bagul@canonical.com>
References: <20170112120101.16933-1-shrirang.bagul@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170112120101.16933-1-shrirang.bagul@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Dell IoT Gateways, RT5660 codec is available with ACPI ID 10EC3277.
Also, GPIO's are only available by index, so we register mappings to allow
machine drivers to access them by name.

Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
---
 sound/soc/codecs/rt5660.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/sound/soc/codecs/rt5660.c b/sound/soc/codecs/rt5660.c
index 76cf76a..06cdcec 100644
--- a/sound/soc/codecs/rt5660.c
+++ b/sound/soc/codecs/rt5660.c
@@ -9,6 +9,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -40,6 +41,12 @@
 
 #define RT5660_PR_BASE (RT5660_PR_RANGE_BASE + (0 * RT5660_PR_SPACING))
 
+/* GPIO indexes defined by ACPI */
+enum {
+	RT5660_GPIO_WAKE_INTR		= 0,
+	RT5660_GPIO_LINEOUT_MUTE	= 1,
+};
+
 static const struct regmap_range_cfg rt5660_ranges[] = {
 	{ .name = "PR", .range_min = RT5660_PR_BASE,
 	  .range_max = RT5660_PR_BASE + 0xf3,
@@ -1245,10 +1252,31 @@ MODULE_DEVICE_TABLE(of, rt5660_of_match);
 
 static const struct acpi_device_id rt5660_acpi_match[] = {
 	{ "10EC5660", 0 },
+	{ "10EC3277", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, rt5660_acpi_match);
 
+static const struct acpi_gpio_params audio_wake_intr_gpio = { RT5660_GPIO_WAKE_INTR, 0, false };
+static const struct acpi_gpio_params lineout_mute_gpio = { RT5660_GPIO_LINEOUT_MUTE, 0, true };
+
+static const struct acpi_gpio_mapping byt_rt5660_gpios[] = {
+	{ "audio-wake-intr-gpios", &audio_wake_intr_gpio, 1 },
+	{ "lineout-mute-gpios", &lineout_mute_gpio, 1 },
+	{ NULL },
+};
+
+static void rt5660_read_acpi_properties(struct rt5660_priv *rt5660,
+		struct device *dev)
+{
+	int ret;
+
+	ret = acpi_dev_add_driver_gpios(ACPI_COMPANION(dev),
+			byt_rt5660_gpios);
+	if (ret)
+		dev_warn(dev, "Failed to add driver gpios\n");
+}
+
 static int rt5660_parse_dt(struct rt5660_priv *rt5660, struct device *dev)
 {
 	rt5660->pdata.in1_diff = device_property_read_bool(dev,
@@ -1288,6 +1316,10 @@ static int rt5660_i2c_probe(struct i2c_client *i2c,
 		rt5660->pdata = *pdata;
 	else if (i2c->dev.of_node)
 		rt5660_parse_dt(rt5660, &i2c->dev);
+	else if (ACPI_HANDLE(&i2c->dev))
+		rt5660_read_acpi_properties(rt5660, &i2c->dev);
+	else
+		return -EINVAL;
 
 	rt5660->regmap = devm_regmap_init_i2c(i2c, &rt5660_regmap);
 	if (IS_ERR(rt5660->regmap)) {
-- 
2.9.3
