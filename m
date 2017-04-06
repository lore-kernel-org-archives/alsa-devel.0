From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "regulator: helpers: Add regmap set_pull_down helper" to the regulator tree
Date: Thu, 06 Apr 2017 19:55:33 +0100
Message-ID: <E1cwCZB-0001u0-0R@debutante>
References: <1490710484-25277-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490710484-25277-5-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.orglinux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   regulator: helpers: Add regmap set_pull_down helper

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

>From f7d37bc3cb20828ac43b22cbd40222877ee2c46a Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Date: Tue, 28 Mar 2017 15:14:41 +0100
Subject: [PATCH] regulator: helpers: Add regmap set_pull_down helper

Add a helper function regulator_set_pull_down_regmap to allow regmap
based regulators to easily enable pull down.

Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/regulator/helpers.c      | 18 ++++++++++++++++++
 include/linux/regulator/driver.h |  8 ++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index a75e7da49af8..2ae7c3ac5940 100644
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
index 1054c033e783..8a9078dd2a5f 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -296,6 +296,10 @@ enum regulator_type {
  * @soft_start_mask: Mask for control when using regmap set_soft_start
  * @soft_start_val_on: Enabling value for control when using regmap
  *                     set_soft_start
+ * @pull_down_reg: Register for control when using regmap set_pull_down
+ * @pull_down_mask: Mask for control when using regmap set_pull_down
+ * @pull_down_val_on: Enabling value for control when using regmap
+ *                     set_pull_down
  *
  * @enable_time: Time taken for initial enable of regulator (in uS).
  * @off_on_delay: guard time (in uS), before re-enabling a regulator
@@ -352,6 +356,9 @@ struct regulator_desc {
 	unsigned int soft_start_reg;
 	unsigned int soft_start_mask;
 	unsigned int soft_start_val_on;
+	unsigned int pull_down_reg;
+	unsigned int pull_down_mask;
+	unsigned int pull_down_val_on;
 
 	unsigned int enable_time;
 
@@ -484,6 +491,7 @@ int regulator_set_voltage_time_sel(struct regulator_dev *rdev,
 int regulator_set_bypass_regmap(struct regulator_dev *rdev, bool enable);
 int regulator_get_bypass_regmap(struct regulator_dev *rdev, bool *enable);
 int regulator_set_soft_start_regmap(struct regulator_dev *rdev);
+int regulator_set_pull_down_regmap(struct regulator_dev *rdev);
 
 int regulator_set_active_discharge_regmap(struct regulator_dev *rdev,
 					  bool enable);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
