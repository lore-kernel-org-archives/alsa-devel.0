From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Rework quirk logic" to the asoc tree
Date: Thu, 26 Oct 2017 15:16:58 +0100 (BST)
Message-ID: <20171026141658.69A5F44005B@finisterre.ee.mobilebroadband>
References: <20171020111859.2448-5-carlo@caione.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171020111859.2448-5-carlo@caione.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Carlo Caione <carlo@endlessm.com>
Cc: Mark Brown <broonie@kernel.org>, linux@endlessm.com, bardliao@realtek.com, oder_chiou@realtek.com, pierre-louis.bossart@linux.intel.combroonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, albertchen@realtek.com, edgar_shen@realtek.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: Rework quirk logic

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b4435130bc19cd54631588355b16326aeb760e34 Mon Sep 17 00:00:00 2001
From: Carlo Caione <carlo@endlessm.com>
Date: Fri, 20 Oct 2017 12:18:58 +0100
Subject: [PATCH] ASoC: rt5651: Rework quirk logic

Rework a bit the quirk logic in the codec driver to simplify the
DMI-based quirk assignment for non-DT platforms.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.14.1
