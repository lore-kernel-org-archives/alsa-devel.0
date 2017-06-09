From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] ASoC: rt5677: Introduce proper table
	for ACPI enumeration
Date: Fri,  9 Jun 2017 23:49:52 +0300
Message-ID: <20170609204954.40310-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id B8A322676D8
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 22:50:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, John Keeping <john@metanate.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

I2C devices are enumerated by IDs, and not by instances.
Make it clear by using proper module device table for ACPI case.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/codecs/rt5677.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 65ac4518ad06..64cf6cc41ad1 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5030,7 +5030,6 @@ static const struct regmap_config rt5677_regmap = {
 static const struct i2c_device_id rt5677_i2c_id[] = {
 	{ "rt5677", RT5677 },
 	{ "rt5676", RT5676 },
-	{ "RT5677CE:00", RT5677 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rt5677_i2c_id);
@@ -5041,6 +5040,14 @@ static const struct of_device_id rt5677_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rt5677_of_match);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id rt5677_acpi_match[] = {
+	{ "RT5677CE", RT5677 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, rt5677_acpi_match);
+#endif
+
 static const struct acpi_gpio_params plug_det_gpio = { RT5677_GPIO_PLUG_DET, 0, false };
 static const struct acpi_gpio_params mic_present_gpio = { RT5677_GPIO_MIC_PRESENT_L, 0, false };
 static const struct acpi_gpio_params headphone_enable_gpio = { RT5677_GPIO_HP_AMP_SHDN_L, 0, false };
@@ -5301,6 +5308,7 @@ static struct i2c_driver rt5677_i2c_driver = {
 	.driver = {
 		.name = "rt5677",
 		.of_match_table = rt5677_of_match,
+		.acpi_match_table = ACPI_PTR(rt5677_acpi_match),
 	},
 	.probe = rt5677_i2c_probe,
 	.remove   = rt5677_i2c_remove,
-- 
2.11.0
