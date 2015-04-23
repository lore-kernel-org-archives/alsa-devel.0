From: yang.a.fang@intel.com
Subject: [PATCH 2/2] ASoC: rt5645: set platform data base on DMI
Date: Thu, 23 Apr 2015 16:35:18 -0700
Message-ID: <1429832118-20741-2-git-send-email-yang.a.fang@intel.com>
References: <1429832118-20741-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E786426041F
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 01:35:59 +0200 (CEST)
In-Reply-To: <1429832118-20741-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, praveen.k.jain@intel.com, denny.iriawan@intel.com, "Fang, Yang A" <yang.a.fang@intel.com>, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

set platform specific data for intel strago platform

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/codecs/rt5645.c |   51 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index e16724a..14cabee 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -19,6 +19,7 @@
 #include <linux/spi/spi.h>
 #include <linux/gpio.h>
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -2628,6 +2629,39 @@ static struct acpi_device_id rt5645_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, rt5645_acpi_match);
 #endif
 
+static struct rt5645_priv *grt5645;
+
+static int strago_quirk_cb(const struct dmi_system_id *id)
+{
+	struct rt5645_priv **rt5645;
+
+	rt5645 = (struct rt5645_priv **)id->driver_data;
+
+	if (*rt5645) {
+
+		(*rt5645)->pdata.dmic_en = 1;
+		(*rt5645)->pdata.dmic1_data_pin = -1;
+		(*rt5645)->pdata.dmic2_data_pin = RT5645_DMIC_DATA_IN2P;
+		(*rt5645)->pdata.en_jd_func = 1;
+		(*rt5645)->pdata.jd_mode = 3;
+
+	}
+
+	return 1;
+}
+
+static struct dmi_system_id dmi_platform_intel_braswell[] __initdata = {
+	{
+		.ident = "Intel Strago",
+		.callback = strago_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Strago"),
+		},
+		.driver_data = (void *)&grt5645,
+	},
+	{ }
+};
+
 static int rt5645_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -2635,17 +2669,32 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 	struct rt5645_priv *rt5645;
 	int ret;
 	unsigned int val;
+	struct gpio_desc *gpiod;
 
 	rt5645 = devm_kzalloc(&i2c->dev, sizeof(struct rt5645_priv),
 				GFP_KERNEL);
 	if (rt5645 == NULL)
 		return -ENOMEM;
 
+	grt5645 = rt5645;
 	rt5645->i2c = i2c;
 	i2c_set_clientdata(i2c, rt5645);
 
-	if (pdata)
+	if (pdata) {
 		rt5645->pdata = *pdata;
+	} else {
+		dmi_check_system(dmi_platform_intel_braswell);
+		gpiod = devm_gpiod_get_index(&i2c->dev, "rt5645", 0);
+
+		if (IS_ERR(gpiod) || gpiod_direction_input(gpiod)) {
+			rt5645->pdata.hp_det_gpio = -1;
+			dev_err(&i2c->dev, "failed to initialize gpiod\n");
+		} else {
+			rt5645->pdata.hp_det_gpio = desc_to_gpio(gpiod);
+			rt5645->pdata.gpio_hp_det_active_high
+						= !gpiod_is_active_low(gpiod);
+		}
+	}
 
 	rt5645->regmap = devm_regmap_init_i2c(i2c, &rt5645_regmap);
 	if (IS_ERR(rt5645->regmap)) {
-- 
1.7.9.5
