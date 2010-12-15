From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] regulator: Allow modular build of mc13xxx-core
Date: Wed, 15 Dec 2010 14:06:13 +0000
Message-ID: <1292421973-27410-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 154F610385A
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2010 15:06:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since the MFD core for this device and the regulator drivers for these
devices can be built modular we should also support modular build of
the shared code for the regulator drivers, otherwise we try to link
built in code against modular code with unfortunate results.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/regulator/Kconfig                  |    2 +-
 drivers/regulator/mc13xxx-regulator-core.c |    5 +++++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 485a9bc..e1d9436 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -187,7 +187,7 @@ config REGULATOR_PCAP
 	 PCAP2 PMIC.
 
 config REGULATOR_MC13XXX_CORE
-	bool
+	tristate
 
 config REGULATOR_MC13783
 	tristate "Support regulators on Freescale MC13783 PMIC"
diff --git a/drivers/regulator/mc13xxx-regulator-core.c b/drivers/regulator/mc13xxx-regulator-core.c
index 448e8f4..da46b3c 100644
--- a/drivers/regulator/mc13xxx-regulator-core.c
+++ b/drivers/regulator/mc13xxx-regulator-core.c
@@ -123,6 +123,7 @@ int mc13xxx_get_best_voltage_index(struct regulator_dev *rdev,
 	}
 	return bestindex;
 }
+EXPORT_SYMBOL_GPL(mc13xxx_get_best_voltage_index);
 
 static int mc13xxx_regulator_set_voltage(struct regulator_dev *rdev, int min_uV,
 		int max_uV, unsigned *selector)
@@ -185,6 +186,7 @@ struct regulator_ops mc13xxx_regulator_ops = {
 	.set_voltage = mc13xxx_regulator_set_voltage,
 	.get_voltage = mc13xxx_regulator_get_voltage,
 };
+EXPORT_SYMBOL_GPL(mc13xxx_regulator_ops);
 
 int mc13xxx_fixed_regulator_set_voltage(struct regulator_dev *rdev, int min_uV,
 	       int max_uV, unsigned *selector)
@@ -202,6 +204,7 @@ int mc13xxx_fixed_regulator_set_voltage(struct regulator_dev *rdev, int min_uV,
 	else
 		return -EINVAL;
 }
+EXPORT_SYMBOL_GPL(mc13xxx_fixed_regulator_set_voltage);
 
 int mc13xxx_fixed_regulator_get_voltage(struct regulator_dev *rdev)
 {
@@ -213,6 +216,7 @@ int mc13xxx_fixed_regulator_get_voltage(struct regulator_dev *rdev)
 
 	return mc13xxx_regulators[id].voltages[0];
 }
+EXPORT_SYMBOL_GPL(mc13xxx_fixed_regulator_get_voltage);
 
 struct regulator_ops mc13xxx_fixed_regulator_ops = {
 	.enable = mc13xxx_regulator_enable,
@@ -222,6 +226,7 @@ struct regulator_ops mc13xxx_fixed_regulator_ops = {
 	.set_voltage = mc13xxx_fixed_regulator_set_voltage,
 	.get_voltage = mc13xxx_fixed_regulator_get_voltage,
 };
+EXPORT_SYMBOL_GPL(mc13xxx_fixed_regulator_ops);
 
 int mc13xxx_sw_regulator_is_enabled(struct regulator_dev *rdev)
 {
-- 
1.7.1
