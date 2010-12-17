From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] regulator: Clean up logging a bit
Date: Fri, 17 Dec 2010 16:04:12 +0000
Message-ID: <1292601852-21905-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A0E7F1037FC
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 17:04:14 +0100 (CET)
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

The recent introduction of standard regulator API logging macros means
that all our log messages have at least the function name in them and
logging that the constraints are for the regulator API is probably a
bit much.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/regulator/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ab419f8..911b774 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -739,7 +739,7 @@ static void print_constraints(struct regulator_dev *rdev)
 	if (constraints->valid_modes_mask & REGULATOR_MODE_STANDBY)
 		count += sprintf(buf + count, "standby");
 
-	rdev_info(rdev, "regulator: %s\n", buf);
+	rdev_info(rdev, "%s\n", buf);
 }
 
 static int machine_constraints_voltage(struct regulator_dev *rdev,
-- 
1.7.1
