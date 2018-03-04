From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 03/22] ASoC: rt5651: Configure jack-detect
	source through a device-property
Date: Sun,  4 Mar 2018 15:35:51 +0100
Message-ID: <20180304143610.21125-4-hdegoede@redhat.com>
References: <20180304143610.21125-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B9F1267016
 for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2018 15:36:18 +0100 (CET)
In-Reply-To: <20180304143610.21125-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Configure the jack-detect source through a device-property which can be
set by code outside of the codec driver. Rather then putting platform
specific DMI quirks inside the generic codec driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3
-Split out the machine-driver and dt-bindings changes into separate patches,
 keeping just the codec driver changes in this patch

Changes in v2:
-New patch in v2 of this patch-set
---
 include/sound/rt5651.h    |  4 ++++
 sound/soc/codecs/rt5651.c | 33 +++++++--------------------------
 2 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/include/sound/rt5651.h b/include/sound/rt5651.h
index 1612462bf5ad..725b36c329d0 100644
--- a/include/sound/rt5651.h
+++ b/include/sound/rt5651.h
@@ -11,6 +11,10 @@
 #ifndef __LINUX_SND_RT5651_H
 #define __LINUX_SND_RT5651_H
 
+/*
+ * Note these MUST match the values from the DT binding:
+ * Documentation/devicetree/bindings/sound/rt5651.txt
+ */
 enum rt5651_jd_src {
 	RT5651_JD_NULL,
 	RT5651_JD1_1,
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 7bff5cda61fd..f80b3da4667f 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -19,7 +19,6 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/acpi.h>
-#include <linux/dmi.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -32,8 +31,6 @@
 #include "rl6231.h"
 #include "rt5651.h"
 
-#define RT5651_JD_MAP(quirk)	((quirk) & GENMASK(7, 0))
-
 #define RT5651_DEVICE_ID_VALUE 0x6281
 
 #define RT5651_PR_RANGE_BASE (0xff + 1)
@@ -41,8 +38,6 @@
 
 #define RT5651_PR_BASE (RT5651_PR_RANGE_BASE + (0 * RT5651_PR_SPACING))
 
-static unsigned long rt5651_quirk;
-
 static const struct regmap_range_cfg rt5651_ranges[] = {
 	{ .name = "PR", .range_min = RT5651_PR_BASE,
 	  .range_max = RT5651_PR_BASE + 0xb4,
@@ -1675,6 +1670,9 @@ static int rt5651_set_jack(struct snd_soc_component *component,
  */
 static void rt5651_apply_properties(struct snd_soc_component *component)
 {
+	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
+	u32 val;
+
 	if (device_property_read_bool(component->dev, "realtek,in2-differential"))
 		snd_soc_component_update_bits(component, RT5651_IN1_IN2,
 				RT5651_IN_DF2, RT5651_IN_DF2);
@@ -1682,6 +1680,10 @@ static void rt5651_apply_properties(struct snd_soc_component *component)
 	if (device_property_read_bool(component->dev, "realtek,dmic-en"))
 		snd_soc_component_update_bits(component, RT5651_GPIO_CTRL1,
 				RT5651_GP2_PIN_MASK, RT5651_GP2_PIN_DMIC1_SCL);
+
+	if (device_property_read_u32(component->dev,
+				     "realtek,jack-detect-source", &val) == 0)
+		rt5651->jd_src = val;
 }
 
 static int rt5651_probe(struct snd_soc_component *component)
@@ -1832,24 +1834,6 @@ static const struct i2c_device_id rt5651_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5651_i2c_id);
 
-static int rt5651_quirk_cb(const struct dmi_system_id *id)
-{
-	rt5651_quirk = (unsigned long) id->driver_data;
-	return 1;
-}
-
-static const struct dmi_system_id rt5651_quirk_table[] = {
-	{
-		.callback = rt5651_quirk_cb,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "KIANO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "KIANO SlimNote 14.2"),
-		},
-		.driver_data = (unsigned long *) RT5651_JD1_1,
-	},
-	{}
-};
-
 static int rt5651_jack_detect(struct snd_soc_component *component, int jack_insert)
 {
 	int jack_type;
@@ -1917,9 +1901,6 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, rt5651);
 
-	dmi_check_system(rt5651_quirk_table);
-	rt5651->jd_src = RT5651_JD_MAP(rt5651_quirk);
-
 	rt5651->regmap = devm_regmap_init_i2c(i2c, &rt5651_regmap);
 	if (IS_ERR(rt5651->regmap)) {
 		ret = PTR_ERR(rt5651->regmap);
-- 
2.14.3
