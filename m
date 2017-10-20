From: Carlo Caione <carlo@caione.org>
Subject: [PATCH v2 4/5] ASoC: rt5651: Rework quirk logic
Date: Fri, 20 Oct 2017 12:18:58 +0100
Message-ID: <20171020111859.2448-5-carlo@caione.org>
References: <20171020111859.2448-1-carlo@caione.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171020111859.2448-1-carlo@caione.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@endlessm.com, bardliao@realtek.com, oder_chiou@realtek.com, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, albertchen@realtek.com, edgar_shen@realtek.com
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Carlo Caione <carlo@endlessm.com>

Rework a bit the quirk logic in the codec driver to simplify the
DMI-based quirk assignment for non-DT platforms.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 sound/soc/codecs/rt5651.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 91f254391452..f01d41101631 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -31,6 +32,10 @@
 #include "rl6231.h"
 #include "rt5651.h"
 
+#define RT5651_JD_MAP(quirk)	((quirk) & GENMASK(7, 0))
+#define RT5651_IN2_DIFF		BIT(16)
+#define RT5651_DMIC_EN		BIT(17)
+
 #define RT5651_DEVICE_ID_VALUE 0x6281
 
 #define RT5651_PR_RANGE_BASE (0xff + 1)
@@ -38,6 +43,8 @@
 
 #define RT5651_PR_BASE (RT5651_PR_RANGE_BASE + (0 * RT5651_PR_SPACING))
 
+static unsigned long rt5651_quirk;
+
 static const struct regmap_range_cfg rt5651_ranges[] = {
 	{ .name = "PR", .range_min = RT5651_PR_BASE,
 	  .range_max = RT5651_PR_BASE + 0xb4,
@@ -1739,16 +1746,36 @@ static const struct i2c_device_id rt5651_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5651_i2c_id);
 
+static int rt5651_quirk_cb(const struct dmi_system_id *id)
+{
+	rt5651_quirk = (unsigned long) id->driver_data;
+	return 1;
+}
+
+static const struct dmi_system_id rt5651_quirk_table[] = {
+	{}
+};
+
 static int rt5651_parse_dt(struct rt5651_priv *rt5651, struct device_node *np)
 {
-	rt5651->pdata.in2_diff = of_property_read_bool(np,
-		"realtek,in2-differential");
-	rt5651->pdata.dmic_en = of_property_read_bool(np,
-		"realtek,dmic-en");
+	if (of_property_read_bool(np, "realtek,in2-differential"))
+		rt5651_quirk |= RT5651_IN2_DIFF;
+	if (of_property_read_bool(np, "realtek,dmic-en"))
+		rt5651_quirk |= RT5651_DMIC_EN;
 
 	return 0;
 }
 
+static void rt5651_set_pdata(struct rt5651_priv *rt5651)
+{
+	if (rt5651_quirk & RT5651_IN2_DIFF)
+		rt5651->pdata.in2_diff = true;
+	if (rt5651_quirk & RT5651_DMIC_EN)
+		rt5651->pdata.dmic_en = true;
+	if (RT5651_JD_MAP(rt5651_quirk))
+		rt5651->pdata.jd_src = RT5651_JD_MAP(rt5651_quirk);
+}
+
 static irqreturn_t rt5651_irq(int irq, void *data)
 {
 	struct rt5651_priv *rt5651 = data;
@@ -1854,6 +1881,10 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 		rt5651->pdata = *pdata;
 	else if (i2c->dev.of_node)
 		rt5651_parse_dt(rt5651, i2c->dev.of_node);
+	else
+		dmi_check_system(rt5651_quirk_table);
+
+	rt5651_set_pdata(rt5651);
 
 	rt5651->regmap = devm_regmap_init_i2c(i2c, &rt5651_regmap);
 	if (IS_ERR(rt5651->regmap)) {
-- 
2.14.2
