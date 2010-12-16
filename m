From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] regulator: Convert WM835x to use
	get_voltage_sel()
Date: Thu, 16 Dec 2010 11:48:26 +0000
Message-ID: <1292500106-20807-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2F49F2438C
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2010 12:48:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/regulator/wm8350-regulator.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/wm8350-regulator.c b/drivers/regulator/wm8350-regulator.c
index 7e45b0d..1bcb22c 100644
--- a/drivers/regulator/wm8350-regulator.c
+++ b/drivers/regulator/wm8350-regulator.c
@@ -405,11 +405,10 @@ static int wm8350_dcdc_set_voltage(struct regulator_dev *rdev, int min_uV,
 	return 0;
 }
 
-static int wm8350_dcdc_get_voltage(struct regulator_dev *rdev)
+static int wm8350_dcdc_get_voltage_sel(struct regulator_dev *rdev)
 {
 	struct wm8350 *wm8350 = rdev_get_drvdata(rdev);
 	int volt_reg, dcdc = rdev_get_id(rdev);
-	u16 val;
 
 	switch (dcdc) {
 	case WM8350_DCDC_1:
@@ -431,8 +430,7 @@ static int wm8350_dcdc_get_voltage(struct regulator_dev *rdev)
 	}
 
 	/* all DCDCs have same mV bits */
-	val = wm8350_reg_read(wm8350, volt_reg) & WM8350_DC1_VSEL_MASK;
-	return wm8350_dcdc_val_to_mvolts(val) * 1000;
+	return wm8350_reg_read(wm8350, volt_reg) & WM8350_DC1_VSEL_MASK;
 }
 
 static int wm8350_dcdc_list_voltage(struct regulator_dev *rdev,
@@ -807,11 +805,10 @@ static int wm8350_ldo_set_voltage(struct regulator_dev *rdev, int min_uV,
 	return 0;
 }
 
-static int wm8350_ldo_get_voltage(struct regulator_dev *rdev)
+static int wm8350_ldo_get_voltage_sel(struct regulator_dev *rdev)
 {
 	struct wm8350 *wm8350 = rdev_get_drvdata(rdev);
 	int volt_reg, ldo = rdev_get_id(rdev);
-	u16 val;
 
 	switch (ldo) {
 	case WM8350_LDO_1:
@@ -831,8 +828,7 @@ static int wm8350_ldo_get_voltage(struct regulator_dev *rdev)
 	}
 
 	/* all LDOs have same mV bits */
-	val = wm8350_reg_read(wm8350, volt_reg) & WM8350_LDO1_VSEL_MASK;
-	return wm8350_ldo_val_to_mvolts(val) * 1000;
+	return wm8350_reg_read(wm8350, volt_reg) & WM8350_LDO1_VSEL_MASK;
 }
 
 static int wm8350_ldo_list_voltage(struct regulator_dev *rdev,
@@ -1229,7 +1225,7 @@ static int wm8350_ldo_is_enabled(struct regulator_dev *rdev)
 
 static struct regulator_ops wm8350_dcdc_ops = {
 	.set_voltage = wm8350_dcdc_set_voltage,
-	.get_voltage = wm8350_dcdc_get_voltage,
+	.get_voltage_sel = wm8350_dcdc_get_voltage_sel,
 	.list_voltage = wm8350_dcdc_list_voltage,
 	.enable = wm8350_dcdc_enable,
 	.disable = wm8350_dcdc_disable,
@@ -1253,7 +1249,7 @@ static struct regulator_ops wm8350_dcdc2_5_ops = {
 
 static struct regulator_ops wm8350_ldo_ops = {
 	.set_voltage = wm8350_ldo_set_voltage,
-	.get_voltage = wm8350_ldo_get_voltage,
+	.get_voltage_sel = wm8350_ldo_get_voltage_sel,
 	.list_voltage = wm8350_ldo_list_voltage,
 	.enable = wm8350_ldo_enable,
 	.disable = wm8350_ldo_disable,
-- 
1.7.1
