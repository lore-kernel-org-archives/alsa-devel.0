From: Junjie Mao <junjie.mao@enight.me>
Subject: [PATCH] ASoC: Intel: fix runtime pm imbalance on error
Date: Fri, 17 Jul 2015 10:29:00 +0800
Message-ID: <1437100140-5048-1-git-send-email-junjie.mao@enight.me>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jie Yang <yang.jie@intel.com>, Fang Yang A <yang.a.fang@intel.com>, Junjie Mao <junjie.mao@enight.me>, Dan Carpenter <dan.carpenter@oracle.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

pm_runtime_get_sync() increments the runtime PM usage counter even the
call returns an error code. Thus a pairing decrement is needed on the
error handling path to keep the counter balanced.

Signed-off-by: Junjie Mao <junjie.mao@enight.me>
---
 sound/soc/intel/atom/sst/sst_drv_interface.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_drv_interface.c b/sound/soc/intel/atom/sst/sst_drv_interface.c
index 620da1d1b9e3..27a9653aa3d9 100644
--- a/sound/soc/intel/atom/sst/sst_drv_interface.c
+++ b/sound/soc/intel/atom/sst/sst_drv_interface.c
@@ -152,6 +152,7 @@ static int sst_power_control(struct device *dev, bool state)
 
 		dev_dbg(ctx->dev, "Enable: pm usage count: %d\n", usage_count);
 		if (ret < 0) {
+			pm_runtime_put_sync(dev);
 			dev_err(ctx->dev, "Runtime get failed with err: %d\n", ret);
 			return ret;
 		}
@@ -204,8 +205,10 @@ static int sst_cdev_open(struct device *dev,
 	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
 
 	retval = pm_runtime_get_sync(ctx->dev);
-	if (retval < 0)
+	if (retval < 0) {
+		pm_runtime_put_sync(ctx->dev);
 		return retval;
+	}
 
 	str_id = sst_get_stream(ctx, str_params);
 	if (str_id > 0) {
@@ -672,8 +675,10 @@ static int sst_send_byte_stream(struct device *dev,
 	if (NULL == bytes)
 		return -EINVAL;
 	ret_val = pm_runtime_get_sync(ctx->dev);
-	if (ret_val < 0)
+	if (ret_val < 0) {
+		pm_runtime_put_sync(ctx->dev);
 		return ret_val;
+	}
 
 	ret_val = sst_send_byte_stream_mrfld(ctx, bytes);
 	sst_pm_runtime_put(ctx);
-- 
1.9.3
