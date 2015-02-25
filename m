From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: Intel: wrap runtime_pm usage count under
	CONFIG_PM
Date: Wed, 25 Feb 2015 21:37:52 +0530
Message-ID: <1424880472-1714-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B0AB026070E
 for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2015 17:11:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The struct dev_pm_ops defines usage_count only when CONFIG_PM is defined. So
we should use this variable only in cases where this falg is true.
So we define a local variable and read the value under this flag. In non PM
cases, we set this to 1.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst_drv_interface.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/sst/sst_drv_interface.c b/sound/soc/intel/sst/sst_drv_interface.c
index 549af7d7f6d0..f0e4b99b3aeb 100644
--- a/sound/soc/intel/sst/sst_drv_interface.c
+++ b/sound/soc/intel/sst/sst_drv_interface.c
@@ -139,17 +139,23 @@ static int sst_power_control(struct device *dev, bool state)
 {
 	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
 	int ret = 0;
+	int usage_count = 0;
+
+#ifdef CONFIG_PM
+	usage_count = atomic_read(&dev->power.usage_count);
+#else
+	usage_count = 1;
+#endif
 
 	if (state == true) {
 		ret = pm_runtime_get_sync(dev);
-		dev_dbg(ctx->dev, "Enable: pm usage count: %d\n",
-				atomic_read(&dev->power.usage_count));
+
+		dev_dbg(ctx->dev, "Enable: pm usage count: %d\n", usage_count);
 		if (ret < 0) {
 			dev_err(ctx->dev, "Runtime get failed with err: %d\n", ret);
 			return ret;
 		}
-		if ((ctx->sst_state == SST_RESET) &&
-			(atomic_read(&dev->power.usage_count) == 1)) {
+		if ((ctx->sst_state == SST_RESET) && (usage_count == 1)) {
 			ret = sst_load_fw(ctx);
 			if (ret) {
 				dev_err(dev, "FW download fail %d\n", ret);
@@ -158,8 +164,7 @@ static int sst_power_control(struct device *dev, bool state)
 			}
 		}
 	} else {
-		dev_dbg(ctx->dev, "Disable: pm usage count: %d\n",
-				atomic_read(&dev->power.usage_count));
+		dev_dbg(ctx->dev, "Disable: pm usage count: %d\n", usage_count);
 		return sst_pm_runtime_put(ctx);
 	}
 	return ret;
-- 
1.7.9.5
