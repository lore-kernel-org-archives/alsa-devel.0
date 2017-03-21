From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH 2/6] regulator: helpers: Add regmap set_pull_down helper
Date: Tue, 21 Mar 2017 14:45:35 +0000
Message-ID: <1490107539-23995-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1490107539-23995-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490107539-23995-1-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Add a helper function regulator_set_pull_down_regmap to allow regmap
based regulators to easily enable pull down.

Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 drivers/regulator/helpers.c      | 18 ++++++++++++++++++
 include/linux/regulator/driver.h |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index a75e7da..2ae7c3a 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -464,6 +464,24 @@ int regulator_set_soft_start_regmap(struct regulator_dev *rdev)
 EXPORT_SYMBOL_GPL(regulator_set_soft_start_regmap);
 
 /**
+ * regulator_set_pull_down_regmap - Default set_pull_down() using regmap
+ *
+ * @rdev: device to operate on.
+ */
+int regulator_set_pull_down_regmap(struct regulator_dev *rdev)
+{
+	unsigned int val;
+
+	val = rdev->desc->pull_down_val_on;
+	if (!val)
+		val = rdev->desc->pull_down_mask;
+
+	return regmap_update_bits(rdev->regmap, rdev->desc->pull_down_reg,
+				  rdev->desc->pull_down_mask, val);
+}
+EXPORT_SYMBOL_GPL(regulator_set_pull_down_regmap);
+
+/**
  * regulator_get_bypass_regmap - Default get_bypass() using regmap
  *
  * @rdev: device to operate on.
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 7e2e70d..97b55b5 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -348,6 +348,9 @@ struct regulator_desc {
 	unsigned int soft_start_reg;
 	unsigned int soft_start_mask;
 	unsigned int soft_start_val_on;
+	unsigned int pull_down_reg;
+	unsigned int pull_down_mask;
+	unsigned int pull_down_val_on;
 
 	unsigned int enable_time;
 
@@ -480,6 +483,7 @@ int regulator_set_voltage_time_sel(struct regulator_dev *rdev,
 int regulator_set_bypass_regmap(struct regulator_dev *rdev, bool enable);
 int regulator_get_bypass_regmap(struct regulator_dev *rdev, bool *enable);
 int regulator_set_soft_start_regmap(struct regulator_dev *rdev);
+int regulator_set_pull_down_regmap(struct regulator_dev *rdev);
 
 int regulator_set_active_discharge_regmap(struct regulator_dev *rdev,
 					  bool enable);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
