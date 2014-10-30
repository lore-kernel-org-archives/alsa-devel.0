From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Intel: fix build with runtime PM
	disabled.
Date: Thu, 30 Oct 2014 14:58:19 +0000
Message-ID: <1414681099-11307-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 66BD826060C
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 15:58:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix the following errors:

All error/warnings:

>> sound/soc/intel/sst-haswell-pcm.c:1168:13: error: 'hsw_pcm_prepare' undeclared here (not in a function)
     .prepare = hsw_pcm_prepare,
                ^
>> sound/soc/intel/sst-haswell-pcm.c:1169:14: error: 'hsw_pcm_complete' undeclared here (not in a function)
     .complete = hsw_pcm_complete,
                 ^
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-haswell-ipc.c |  2 +-
 sound/soc/intel/sst-haswell-pcm.c | 14 ++++++--------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 0ea7c3d..ffd5728 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -1711,7 +1711,7 @@ void sst_hsw_runtime_module_free(struct sst_module_runtime *runtime)
 	sst_module_runtime_free(runtime);
 }
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 static int sst_hsw_dx_state_dump(struct sst_hsw *hsw)
 {
 	struct sst_dsp *sst = hsw->dsp;
diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 4489a35..cd54dd9 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -1058,6 +1058,12 @@ static int hsw_pcm_runtime_resume(struct device *dev)
 	return ret;
 }
 
+#else
+#define hsw_pcm_runtime_idle		NULL
+#define hsw_pcm_runtime_suspend		NULL
+#define hsw_pcm_runtime_resume		NULL
+#endif
+
 static void hsw_pcm_complete(struct device *dev)
 {
 	struct hsw_priv_data *pdata = dev_get_drvdata(dev);
@@ -1153,14 +1159,6 @@ static int hsw_pcm_prepare(struct device *dev)
 	return 0;
 }
 
-#else
-#define hsw_pcm_runtime_idle		NULL
-#define hsw_pcm_runtime_suspend		NULL
-#define hsw_pcm_runtime_resume		NULL
-#define hsw_pcm_runtime_complete	NULL
-#define hsw_pcm_runtime_prepare		NULL
-#endif
-
 static const struct dev_pm_ops hsw_pcm_pm = {
 	.runtime_idle = hsw_pcm_runtime_idle,
 	.runtime_suspend = hsw_pcm_runtime_suspend,
-- 
2.1.0
