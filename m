From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 4/8] regulator: helpers: Add regmap
	set_soft_start helper
Date: Tue, 28 Mar 2017 15:14:40 +0100
Message-ID: <1490710484-25277-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1490710484-25277-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id CB7622669CD
 for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2017 16:13:42 +0200 (CEST)
In-Reply-To: <1490710484-25277-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

Add a helper function regulator_set_soft_start_regmap to allow regmap
based regulators to easily enable soft start.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

Changes since v1:
 - Added documentation for the new regulator_desc fields to the kernel doc.

 drivers/regulator/helpers.c      | 18 ++++++++++++++++++
 include/linux/regulator/driver.h |  8 ++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index 379cdac..a75e7da 100644
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
index dac8e7b1..1054c03 100644
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
2.1.4
