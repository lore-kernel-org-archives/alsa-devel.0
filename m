From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] regulator: Make core more chatty about some
	errors
Date: Tue, 12 Jul 2011 11:20:37 +0900
Message-ID: <1310437237-16459-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E3CA924754
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jul 2011 04:20:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Prevent some head scratching by making the core log about some rare but
possible errors with invalid voltage ranges and modes being set.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/regulator/core.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f59821f..3700d09 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -151,8 +151,11 @@ static int regulator_check_voltage(struct regulator_dev *rdev,
 	if (*min_uV < rdev->constraints->min_uV)
 		*min_uV = rdev->constraints->min_uV;
 
-	if (*min_uV > *max_uV)
+	if (*min_uV > *max_uV) {
+		rdev_err(rdev, "unsupportable voltage range: %d-%duV\n",
+			 min_uV, max_uV);
 		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -205,8 +208,11 @@ static int regulator_check_current_limit(struct regulator_dev *rdev,
 	if (*min_uA < rdev->constraints->min_uA)
 		*min_uA = rdev->constraints->min_uA;
 
-	if (*min_uA > *max_uA)
+	if (*min_uA > *max_uA) {
+		rdev_err(rdev, "unsupportable current range: %d-%duA\n",
+			 min_uA, max_uA);
 		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -221,6 +227,7 @@ static int regulator_mode_constrain(struct regulator_dev *rdev, int *mode)
 	case REGULATOR_MODE_STANDBY:
 		break;
 	default:
+		rdev_err(rdev, "invalid mode %x specified\n", *mode);
 		return -EINVAL;
 	}
 
-- 
1.7.5.4
