From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [RFC PATCH] mfd: arizona: Add gating of external MCLKn clocks
Date: Fri, 19 Aug 2016 19:17:16 +0200
Message-ID: <1471627036-19465-1-git-send-email-s.nawrocki@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com
Cc: lee.jones@linaro.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org

This patch adds handling of the CODEC's external MCLK{1,2} clocks
needed for board configurations where these clocks are not always on
oscillators.
The 32k source MCLKn clock is basically kept permanently enabled while
the other MCLKn clock is being gated in the MFD's runtime suspend/resume
callbacks.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
I'm not sure it's a correct approach hence only an RFC patch.
---
 drivers/mfd/arizona-core.c       | 105 ++++++++++++++++++++++++++++++++-------
 include/linux/mfd/arizona/core.h |   9 ++++
 2 files changed, 96 insertions(+), 18 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index e4f97b3..a733b61 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -10,6 +10,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
@@ -49,7 +50,15 @@ int arizona_clk32k_enable(struct arizona *arizona)
 		case ARIZONA_32KZ_MCLK1:
 			ret = pm_runtime_get_sync(arizona->dev);
 			if (ret != 0)
-				goto out;
+				goto err_ref;
+			ret = clk_prepare_enable(arizona->mclk[ARIZONA_MCLK1]);
+			if (ret != 0)
+				goto err_pm;
+			break;
+		case ARIZONA_32KZ_MCLK2:
+			ret = clk_prepare_enable(arizona->mclk[ARIZONA_MCLK2]);
+			if (ret != 0)
+				goto err_ref;
 			break;
 		}
 
@@ -58,7 +67,9 @@ int arizona_clk32k_enable(struct arizona *arizona)
 					 ARIZONA_CLK_32K_ENA);
 	}
 
-out:
+err_pm:
+	pm_runtime_put_sync(arizona->dev);
+err_ref:
 	if (ret != 0)
 		arizona->clk32k_ref--;
 
@@ -83,6 +94,10 @@ int arizona_clk32k_disable(struct arizona *arizona)
 		switch (arizona->pdata.clk32k_src) {
 		case ARIZONA_32KZ_MCLK1:
 			pm_runtime_put_sync(arizona->dev);
+			clk_disable_unprepare(arizona->mclk[ARIZONA_MCLK1]);
+			break;
+		case ARIZONA_32KZ_MCLK2:
+			clk_disable_unprepare(arizona->mclk[ARIZONA_MCLK2]);
 			break;
 		}
 	}
@@ -93,6 +108,34 @@ int arizona_clk32k_disable(struct arizona *arizona)
 }
 EXPORT_SYMBOL_GPL(arizona_clk32k_disable);
 
+/* Enable all external MCLKn clocks except the 32k source clock */
+int arizona_mclk_enable(struct arizona *arizona)
+{
+	int ret;
+
+	if (arizona->pdata.clk32k_src != ARIZONA_32KZ_MCLK1) {
+		ret = clk_prepare_enable(arizona->mclk[ARIZONA_MCLK1]);
+		if (ret != 0)
+			return ret;
+	}
+	if (arizona->pdata.clk32k_src != ARIZONA_32KZ_MCLK2) {
+		ret = clk_prepare_enable(arizona->mclk[ARIZONA_MCLK2]);
+		if (ret != 0)
+			return ret;
+	}
+	return 0;
+}
+
+/* Disable all external MCLKn clocks except the 32k source clock */
+void arizona_mclk_disable(struct arizona *arizona)
+{
+	if (arizona->pdata.clk32k_src != ARIZONA_32KZ_MCLK1)
+		clk_disable_unprepare(arizona->mclk[ARIZONA_MCLK1]);
+
+	if (arizona->pdata.clk32k_src != ARIZONA_32KZ_MCLK2)
+		clk_disable_unprepare(arizona->mclk[ARIZONA_MCLK2]);
+}
+
 static irqreturn_t arizona_clkgen_err(int irq, void *data)
 {
 	struct arizona *arizona = data;
@@ -533,6 +576,12 @@ static int arizona_runtime_resume(struct device *dev)
 		return ret;
 	}
 
+	ret = arizona_mclk_enable(arizona);
+	if (ret != 0) {
+		dev_err(dev, "Failed to enable mclk: %d\n", ret);
+		goto err_reg;
+	}
+
 	if (arizona->has_fully_powered_off) {
 		arizona_disable_reset(arizona);
 		enable_irq(arizona->irq);
@@ -546,14 +595,14 @@ static int arizona_runtime_resume(struct device *dev)
 		if (arizona->external_dcvdd) {
 			ret = arizona_connect_dcvdd(arizona);
 			if (ret != 0)
-				goto err;
+				goto err_clk;
 		}
 
 		ret = wm5102_patch(arizona);
 		if (ret != 0) {
 			dev_err(arizona->dev, "Failed to apply patch: %d\n",
 				ret);
-			goto err;
+			goto err_clk;
 		}
 
 		ret = wm5102_apply_hardware_patch(arizona);
@@ -561,19 +610,19 @@ static int arizona_runtime_resume(struct device *dev)
 			dev_err(arizona->dev,
 				"Failed to apply hardware patch: %d\n",
 				ret);
-			goto err;
+			goto err_clk;
 		}
 		break;
 	case WM5110:
 	case WM8280:
 		ret = arizona_wait_for_boot(arizona);
 		if (ret)
-			goto err;
+			goto err_clk;
 
 		if (arizona->external_dcvdd) {
 			ret = arizona_connect_dcvdd(arizona);
 			if (ret != 0)
-				goto err;
+				goto err_clk;
 		} else {
 			/*
 			 * As this is only called for the internal regulator
@@ -586,7 +635,7 @@ static int arizona_runtime_resume(struct device *dev)
 				dev_err(arizona->dev,
 					"Failed to set resume voltage: %d\n",
 					ret);
-				goto err;
+				goto err_clk;
 			}
 		}
 
@@ -595,24 +644,24 @@ static int arizona_runtime_resume(struct device *dev)
 			dev_err(arizona->dev,
 				"Failed to re-apply sleep patch: %d\n",
 				ret);
-			goto err;
+			goto err_clk;
 		}
 		break;
 	case WM1831:
 	case CS47L24:
 		ret = arizona_wait_for_boot(arizona);
 		if (ret != 0)
-			goto err;
+			goto err_clk;
 		break;
 	default:
 		ret = arizona_wait_for_boot(arizona);
 		if (ret != 0)
-			goto err;
+			goto err_clk;
 
 		if (arizona->external_dcvdd) {
 			ret = arizona_connect_dcvdd(arizona);
 			if (ret != 0)
-				goto err;
+				goto err_clk;
 		}
 		break;
 	}
@@ -620,12 +669,14 @@ static int arizona_runtime_resume(struct device *dev)
 	ret = regcache_sync(arizona->regmap);
 	if (ret != 0) {
 		dev_err(arizona->dev, "Failed to restore register cache\n");
-		goto err;
+		goto err_clk;
 	}
 
 	return 0;
 
-err:
+err_clk:
+	arizona_mclk_disable(arizona);
+err_reg:
 	regcache_cache_only(arizona->regmap, true);
 	regulator_disable(arizona->dcvdd);
 	return ret;
@@ -707,6 +758,7 @@ static int arizona_runtime_suspend(struct device *dev)
 	regcache_cache_only(arizona->regmap, true);
 	regcache_mark_dirty(arizona->regmap);
 	regulator_disable(arizona->dcvdd);
+	arizona_mclk_disable(arizona);
 
 	/* Allow us to completely power down if no jack detection */
 	if (!jd_active) {
@@ -1000,6 +1052,7 @@ static const struct mfd_cell wm8998_devs[] = {
 
 int arizona_dev_init(struct arizona *arizona)
 {
+	const char * const mclk_name[] = { "mclk1", "mclk2" };
 	struct device *dev = arizona->dev;
 	const char *type_name = NULL;
 	unsigned int reg, val, mask;
@@ -1016,6 +1069,15 @@ int arizona_dev_init(struct arizona *arizona)
 	else
 		arizona_of_get_core_pdata(arizona);
 
+	for (i = 0; i < ARRAY_SIZE(arizona->mclk); i++) {
+		arizona->mclk[i] = devm_clk_get(arizona->dev, mclk_name[i]);
+		if (IS_ERR(arizona->mclk[i])) {
+			dev_info(arizona->dev, "Failed to get mclk%d: %ld\n",
+				 i, PTR_ERR(arizona->mclk[i]));
+			arizona->mclk[i] = NULL;
+		}
+	}
+
 	regcache_cache_only(arizona->regmap, true);
 
 	switch (arizona->type) {
@@ -1101,6 +1163,16 @@ int arizona_dev_init(struct arizona *arizona)
 		goto err_enable;
 	}
 
+	/* Chip default */
+	if (!arizona->pdata.clk32k_src)
+		arizona->pdata.clk32k_src = ARIZONA_32KZ_MCLK2;
+
+	ret = arizona_mclk_enable(arizona);
+	if (ret != 0) {
+		dev_err(dev, "Failed to enable mclk: %d\n", ret);
+		goto err_enable;
+	}
+
 	arizona_disable_reset(arizona);
 
 	regcache_cache_only(arizona->regmap, false);
@@ -1332,10 +1404,6 @@ int arizona_dev_init(struct arizona *arizona)
 			     arizona->pdata.gpio_defaults[i]);
 	}
 
-	/* Chip default */
-	if (!arizona->pdata.clk32k_src)
-		arizona->pdata.clk32k_src = ARIZONA_32KZ_MCLK2;
-
 	switch (arizona->pdata.clk32k_src) {
 	case ARIZONA_32KZ_MCLK1:
 	case ARIZONA_32KZ_MCLK2:
@@ -1490,6 +1558,7 @@ err_pm:
 	pm_runtime_disable(arizona->dev);
 err_reset:
 	arizona_enable_reset(arizona);
+	arizona_mclk_disable(arizona);
 	regulator_disable(arizona->dcvdd);
 err_enable:
 	regulator_bulk_disable(arizona->num_core_supplies,
diff --git a/include/linux/mfd/arizona/core.h b/include/linux/mfd/arizona/core.h
index 58ab4c0..b9909bb 100644
--- a/include/linux/mfd/arizona/core.h
+++ b/include/linux/mfd/arizona/core.h
@@ -13,6 +13,7 @@
 #ifndef _WM_ARIZONA_CORE_H
 #define _WM_ARIZONA_CORE_H
 
+#include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
 #include <linux/regmap.h>
@@ -21,6 +22,12 @@
 
 #define ARIZONA_MAX_CORE_SUPPLIES 2
 
+enum {
+	ARIZONA_MCLK1,
+	ARIZONA_MCLK2,
+	ARIZONA_NUM_MCLK
+};
+
 enum arizona_type {
 	WM5102 = 1,
 	WM5110 = 2,
@@ -139,6 +146,8 @@ struct arizona {
 	struct mutex clk_lock;
 	int clk32k_ref;
 
+	struct clk *mclk[ARIZONA_NUM_MCLK];
+
 	bool ctrlif_error;
 
 	struct snd_soc_dapm_context *dapm;
-- 
1.9.1
