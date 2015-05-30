From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH 4/4] ASoC: Intel: handle haswell pcm suspend
	including runtime modules freeing
Date: Sat, 30 May 2015 22:33:59 +0800
Message-ID: <1432996439-8052-5-git-send-email-yang.jie@intel.com>
References: <1432996439-8052-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AF422606C2
 for <alsa-devel@alsa-project.org>; Sat, 30 May 2015 16:30:00 +0200 (CEST)
In-Reply-To: <1432996439-8052-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

It needs free pcm runtime modules before unloading firmware, here
add hsw_pcm_suspend() to handle this procedure:
suspends firmware ==> frees runtime modules ==> unloads firmware.

This fixes the broadwell module unload failed issue.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/haswell/sst-haswell-pcm.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-pcm.c b/sound/soc/intel/haswell/sst-haswell-pcm.c
index f97fa5a..e593e7a 100644
--- a/sound/soc/intel/haswell/sst-haswell-pcm.c
+++ b/sound/soc/intel/haswell/sst-haswell-pcm.c
@@ -1209,6 +1209,20 @@ static int hsw_pcm_runtime_idle(struct device *dev)
 	return 0;
 }
 
+static int hsw_pcm_suspend(struct device *dev)
+{
+	struct hsw_priv_data *pdata = dev_get_drvdata(dev);
+	struct sst_hsw *hsw = pdata->hsw;
+
+	/* enter D3 state and stall */
+	sst_hsw_dsp_runtime_suspend(hsw);
+	/* free all runtime modules */
+	hsw_pcm_free_modules(pdata);
+	/* put the DSP to sleep, fw unloaded after runtime modules freed */
+	sst_hsw_dsp_runtime_sleep(hsw);
+	return 0;
+}
+
 static int hsw_pcm_runtime_suspend(struct device *dev)
 {
 	struct hsw_priv_data *pdata = dev_get_drvdata(dev);
@@ -1225,8 +1239,7 @@ static int hsw_pcm_runtime_suspend(struct device *dev)
 			return ret;
 		sst_hsw_set_module_enabled_rtd3(hsw, SST_HSW_MODULE_WAVES);
 	}
-	sst_hsw_dsp_runtime_suspend(hsw);
-	sst_hsw_dsp_runtime_sleep(hsw);
+	hsw_pcm_suspend(dev);
 	pdata->pm_state = HSW_PM_STATE_RTD3;
 
 	return 0;
@@ -1366,10 +1379,7 @@ static int hsw_pcm_prepare(struct device *dev)
 			if (err < 0)
 				dev_err(dev, "failed to save context for PCM %d\n", i);
 		}
-		/* enter D3 state and stall */
-		sst_hsw_dsp_runtime_suspend(hsw);
-		/* put the DSP to sleep */
-		sst_hsw_dsp_runtime_sleep(hsw);
+		hsw_pcm_suspend(dev);
 	}
 
 	snd_soc_suspend(pdata->soc_card->dev);
-- 
1.9.1
