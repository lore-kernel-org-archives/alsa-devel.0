From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 4/6] mfd: arizona: Add gating of external MCLKn clocks
Date: Fri, 2 Sep 2016 16:52:46 +0100
Message-ID: <1472831568-466-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1472831568-466-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472831568-466-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org
Cc: lgirdwood@gmail.com, s.nawrocki@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Sylwester Nawrocki <s.nawrocki@samsung.com>

This patch adds requesting of the clocks supplied on MCLK1, MCLK2 pins,
gating of the 32k clock is added to the arizona_clk32k_enable(),
arizona_clk32k_disable() helpers.

It's a temporary change until the CODEC's clock controller gets exposed
through the clk API and is helpful for board configurations where the
MCLK clocks are not provided by always on oscillators.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 drivers/mfd/arizona-core.c       | 30 ++++++++++++++++++++++++++++--
 include/linux/mfd/arizona/core.h |  9 +++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index e4f97b3..4fa0fae 100644
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
@@ -1000,6 +1015,7 @@ static const struct mfd_cell wm8998_devs[] = {
 
 int arizona_dev_init(struct arizona *arizona)
 {
+	const char * const mclk_name[] = { "mclk1", "mclk2" };
 	struct device *dev = arizona->dev;
 	const char *type_name = NULL;
 	unsigned int reg, val, mask;
@@ -1016,6 +1032,16 @@ int arizona_dev_init(struct arizona *arizona)
 	else
 		arizona_of_get_core_pdata(arizona);
 
+	BUILD_BUG_ON(ARRAY_SIZE(arizona->mclk) != ARRAY_SIZE(mclk_name));
+	for (i = 0; i < ARRAY_SIZE(arizona->mclk); i++) {
+		arizona->mclk[i] = devm_clk_get(arizona->dev, mclk_name[i]);
+		if (IS_ERR(arizona->mclk[i])) {
+			dev_info(arizona->dev, "Failed to get %s: %ld\n",
+				 mclk_name[i], PTR_ERR(arizona->mclk[i]));
+			arizona->mclk[i] = NULL;
+		}
+	}
+
 	regcache_cache_only(arizona->regmap, true);
 
 	switch (arizona->type) {
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
2.1.4
