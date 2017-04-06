From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "regulator: helpers: Add regmap set_soft_start helper" to the regulator tree
Date: Thu, 06 Apr 2017 19:55:35 +0100
Message-ID: <E1cwCZD-0001vH-Uj@debutante>
References: <1490710484-25277-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490710484-25277-4-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.orglinux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   regulator: helpers: Add regmap set_soft_start helper

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

>From a7a453f56a1a116027f84ac53b365eb045a0e279 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Date: Tue, 28 Mar 2017 15:14:40 +0100
Subject: [PATCH] regulator: helpers: Add regmap set_soft_start helper

Add a helper function regulator_set_soft_start_regmap to allow regmap
based regulators to easily enable soft start.

Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/regulator/helpers.c      | 18 ++++++++++++++++++
 include/linux/regulator/driver.h |  8 ++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index 379cdacc05d8..a75e7da49af8 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -446,6 +446,24 @@ int regulator_set_bypass_regmap(struct regulator_dev *rdev, bool enable)
 EXPORT_SYMBOL_GPL(regulator_set_bypass_regmap);
 
 /**
+ * regulator_set_soft_start_regmap - Default set_soft_start() using regmap
+ *
+ * @rdev: device to operate on.
+ */
+int regulator_set_soft_start_regmap(struct regulator_dev *rdev)
+{
+	unsigned int val;
+
+	val = rdev->desc->soft_start_val_on;
+	if (!val)
+		val = rdev->desc->soft_start_mask;
+
+	return regmap_update_bits(rdev->regmap, rdev->desc->soft_start_reg,
+				  rdev->desc->soft_start_mask, val);
+}
+EXPORT_SYMBOL_GPL(regulator_set_soft_start_regmap);
+
+/**
  * regulator_get_bypass_regmap - Default get_bypass() using regmap
  *
  * @rdev: device to operate on.
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index dac8e7b16bc6..1054c033e783 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -292,6 +292,10 @@ enum regulator_type {
  *			   set_active_discharge
  * @active_discharge_reg: Register for control when using regmap
  *			  set_active_discharge
+ * @soft_start_reg: Register for control when using regmap set_soft_start
+ * @soft_start_mask: Mask for control when using regmap set_soft_start
+ * @soft_start_val_on: Enabling value for control when using regmap
+ *                     set_soft_start
  *
  * @enable_time: Time taken for initial enable of regulator (in uS).
  * @off_on_delay: guard time (in uS), before re-enabling a regulator
@@ -345,6 +349,9 @@ struct regulator_desc {
 	unsigned int active_discharge_off;
 	unsigned int active_discharge_mask;
 	unsigned int active_discharge_reg;
+	unsigned int soft_start_reg;
+	unsigned int soft_start_mask;
+	unsigned int soft_start_val_on;
 
 	unsigned int enable_time;
 
@@ -476,6 +483,7 @@ int regulator_set_voltage_time_sel(struct regulator_dev *rdev,
 				   unsigned int new_selector);
 int regulator_set_bypass_regmap(struct regulator_dev *rdev, bool enable);
 int regulator_get_bypass_regmap(struct regulator_dev *rdev, bool *enable);
+int regulator_set_soft_start_regmap(struct regulator_dev *rdev);
 
 int regulator_set_active_discharge_regmap(struct regulator_dev *rdev,
 					  bool enable);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
