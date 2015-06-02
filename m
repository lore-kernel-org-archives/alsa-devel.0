From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v8 4/4] regulator: arizona-ldo1: Do not control DVFS clocking from regulator
Date: Tue,  2 Jun 2015 11:53:36 +0100
Message-ID: <1433242416-14958-4-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1433242416-14958-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433242416-14958-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Using the driver for the internal regulator to also enable/disable
the codec internal clock frequency controller is an unexpected
side-effect for a regulator, and also means that the core clocks
won't be changed as expected if an external regulator is used to
power the codec.

The DVFS is now handled by the codec driver so can be removed from
the LDO1 driver.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 drivers/regulator/arizona-ldo1.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index 9094163..5e947a8 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -78,11 +78,6 @@ static int arizona_ldo1_hc_set_voltage_sel(struct regulator_dev *rdev,
 	if (ret != 0)
 		return ret;
 
-	ret = regmap_update_bits(regmap, ARIZONA_DYNAMIC_FREQUENCY_SCALING_1,
-				 ARIZONA_SUBSYS_MAX_FREQ, val);
-	if (ret != 0)
-		return ret;
-
 	if (val)
 		return 0;
 
-- 
1.7.2.5
