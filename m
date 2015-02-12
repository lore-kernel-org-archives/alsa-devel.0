From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 11/13] ASoC: Intel: Move the fw download to
	power_control
Date: Thu, 12 Feb 2015 10:00:03 +0530
Message-ID: <1423715405-4562-12-git-send-email-vinod.koul@intel.com>
References: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BB1A8265141
 for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2015 05:33:00 +0100 (CET)
In-Reply-To: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Thus removing the runtime_resume handler.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst.c               |   18 +-----------------
 sound/soc/intel/sst/sst_drv_interface.c |   27 +++++++++++++++++++++++----
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index 6f39f4d4e326..10d9f5a72391 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -496,21 +496,6 @@ iram:
 	return ret;
 }
 
-static int intel_sst_runtime_resume(struct device *dev)
-{
-	int ret = 0;
-	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
-
-	if (ctx->sst_state == SST_RESET) {
-		ret = sst_load_fw(ctx);
-		if (ret) {
-			dev_err(dev, "FW download fail %d\n", ret);
-			sst_set_fw_state_locked(ctx, SST_RESET);
-		}
-	}
-	return ret;
-}
-
 static int intel_sst_resume(struct device *dev)
 {
 	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
@@ -519,7 +504,7 @@ static int intel_sst_resume(struct device *dev)
 	struct sst_block *block;
 
 	if (!fw_save)
-		return intel_sst_runtime_resume(dev);
+		return 0;
 
 	sst_set_fw_state_locked(ctx, SST_FW_LOADING);
 
@@ -564,6 +549,5 @@ const struct dev_pm_ops intel_sst_pm = {
 	.suspend = intel_sst_suspend,
 	.resume = intel_sst_resume,
 	.runtime_suspend = intel_sst_runtime_suspend,
-	.runtime_resume = intel_sst_runtime_resume,
 };
 EXPORT_SYMBOL_GPL(intel_sst_pm);
diff --git a/sound/soc/intel/sst/sst_drv_interface.c b/sound/soc/intel/sst/sst_drv_interface.c
index 5d56fcdd58d8..5c9399160430 100644
--- a/sound/soc/intel/sst/sst_drv_interface.c
+++ b/sound/soc/intel/sst/sst_drv_interface.c
@@ -138,12 +138,31 @@ int sst_get_stream(struct intel_sst_drv *ctx,
 static int sst_power_control(struct device *dev, bool state)
 {
 	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+	int ret = 0;
 
-	dev_dbg(ctx->dev, "state:%d", state);
-	if (state == true)
-		return pm_runtime_get_sync(dev);
-	else
+	if (state == true) {
+		ret = pm_runtime_get_sync(dev);
+		dev_dbg(ctx->dev, "Enable: pm usage count: %d\n",
+				atomic_read(&dev->power.usage_count));
+		if (ret < 0) {
+			dev_err(ctx->dev, "Runtime get failed with err: %d\n", ret);
+			return ret;
+		}
+		if ((ctx->sst_state == SST_RESET) &&
+			(atomic_read(&dev->power.usage_count) == 1)) {
+			ret = sst_load_fw(ctx);
+			if (ret) {
+				dev_err(dev, "FW download fail %d\n", ret);
+				sst_set_fw_state_locked(ctx, SST_RESET);
+				ret = sst_pm_runtime_put(ctx);
+			}
+		}
+	} else {
+		dev_dbg(ctx->dev, "Disable: pm usage count: %d\n",
+				atomic_read(&dev->power.usage_count));
 		return sst_pm_runtime_put(ctx);
+	}
+	return ret;
 }
 
 /*
-- 
1.7.9.5
