From: yang.a.fang@intel.com
Subject: [PATCH] ASoC: Intel: Get correct usage_count value to load firmware
Date: Tue, 14 Jul 2015 11:13:46 -0700
Message-ID: <1436897626-118574-1-git-send-email-yang.a.fang@intel.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, srinivas.sripathi@intel.com, shilpa.sreeramalu@intel.com, dinesh.mirche@intel.com, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Shilpa Sreeramalu <shilpa.sreeramalu@intel.com>

The usage_count variable was read before it was set to the correct
value, due to which the firmware load was failing. Because of this
IPC messages sent to the firmware were timing out causing a delay
of about 1 second while playing audio from the internal speakers.

With this patch the usage_count is read after the function call
pm_runtime_get_sync which will increment the usage_count variable
and the firmware load is successful and all the IPC messages are
processed correctly.

Cc: stable@vger.kernel.org
Signed-off-by: Shilpa Sreeramalu <shilpa.sreeramalu@intel.com>
---
 sound/soc/intel/atom/sst/sst_drv_interface.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_drv_interface.c b/sound/soc/intel/atom/sst/sst_drv_interface.c
index 620da1d..440b953 100644
--- a/sound/soc/intel/atom/sst/sst_drv_interface.c
+++ b/sound/soc/intel/atom/sst/sst_drv_interface.c
@@ -42,6 +42,11 @@
 #define MIN_FRAGMENT_SIZE (50 * 1024)
 #define MAX_FRAGMENT_SIZE (1024 * 1024)
 #define SST_GET_BYTES_PER_SAMPLE(pcm_wd_sz)  (((pcm_wd_sz + 15) >> 4) << 1)
+#ifdef PM_CONFIG
+#define GET_USAGE_COUNT(dev) (atomic_read(&dev->power.usage_count))
+#else
+#define GET_USAGE_COUNT(dev) 1
+#endif
 
 int free_stream_context(struct intel_sst_drv *ctx, unsigned int str_id)
 {
@@ -141,15 +146,9 @@ static int sst_power_control(struct device *dev, bool state)
 	int ret = 0;
 	int usage_count = 0;
 
-#ifdef CONFIG_PM
-	usage_count = atomic_read(&dev->power.usage_count);
-#else
-	usage_count = 1;
-#endif
-
 	if (state == true) {
 		ret = pm_runtime_get_sync(dev);
-
+		usage_count = GET_USAGE_COUNT(dev);
 		dev_dbg(ctx->dev, "Enable: pm usage count: %d\n", usage_count);
 		if (ret < 0) {
 			dev_err(ctx->dev, "Runtime get failed with err: %d\n", ret);
@@ -164,6 +163,7 @@ static int sst_power_control(struct device *dev, bool state)
 			}
 		}
 	} else {
+		usage_count = GET_USAGE_COUNT(dev);
 		dev_dbg(ctx->dev, "Disable: pm usage count: %d\n", usage_count);
 		return sst_pm_runtime_put(ctx);
 	}
-- 
1.7.9.5
