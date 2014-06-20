From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4 v2] regulator: arizona-ldo1: Do not control
	clocking from regulator
Date: Fri, 20 Jun 2014 15:41:13 +0100
Message-ID: <1403275273-22713-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1403275273-22713-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7D2DE2650FE
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 16:50:20 +0200 (CEST)
In-Reply-To: <1403275273-22713-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lee.jones@linaro.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>

Using the driver for the internal regulator to also control
the clock frequency of blocks inside the codec is an
unexpected side-effect for a regulator, and also means that
the core clocks won't be changed as expected if an external
regulator is used to power the codec.

The clocking control is now handled by the core arizona MFD
driver so can be removed from the LDO1 driver.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 drivers/regulator/arizona-ldo1.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index 04f262a..47b48c8 100644
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
