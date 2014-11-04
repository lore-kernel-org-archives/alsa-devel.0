From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Fix build with CONFIG_SLEEP
	enabled.
Date: Tue,  4 Nov 2014 13:27:45 +0000
Message-ID: <1415107665-17460-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id AF037260619
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 14:27:55 +0100 (CET)
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

Fix the following build error when CONFIG_SLEEP is enabled and CONFIG_RUNTIME
is disabled. The BDW ADSP sleep PM functionality depends on the runtime pm
calls for context save/restore.

All error/warnings:

>> ERROR: "snd_soc_suspend" undefined!
>> ERROR: "snd_soc_resume" undefined!

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-haswell-pcm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 3cb9ed7..afbcc9b 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -1011,7 +1011,6 @@ static int hsw_pcm_dev_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 #ifdef CONFIG_PM_RUNTIME
 
 static int hsw_pcm_runtime_idle(struct device *dev)
@@ -1071,6 +1070,8 @@ static int hsw_pcm_runtime_resume(struct device *dev)
 #define hsw_pcm_runtime_resume		NULL
 #endif
 
+#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_PM_RUNTIME)
+
 static void hsw_pcm_complete(struct device *dev)
 {
 	struct hsw_priv_data *pdata = dev_get_drvdata(dev);
@@ -1166,6 +1167,11 @@ static int hsw_pcm_prepare(struct device *dev)
 	return 0;
 }
 
+#else
+#define hsw_pcm_prepare		NULL
+#define hsw_pcm_complete	NULL
+#endif
+
 static const struct dev_pm_ops hsw_pcm_pm = {
 	.runtime_idle = hsw_pcm_runtime_idle,
 	.runtime_suspend = hsw_pcm_runtime_suspend,
@@ -1173,9 +1179,6 @@ static const struct dev_pm_ops hsw_pcm_pm = {
 	.prepare = hsw_pcm_prepare,
 	.complete = hsw_pcm_complete,
 };
-#else
-#define hsw_pcm_pm	NULL
-#endif
 
 static struct platform_driver hsw_pcm_driver = {
 	.driver = {
-- 
2.1.0
