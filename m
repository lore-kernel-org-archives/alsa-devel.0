From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v2] ASoC: Intel: add a status for runtime
	suspend/resume
Date: Thu,  5 Feb 2015 22:42:31 +0800
Message-ID: <1423147351-1976-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D1476264EFA
 for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2015 15:40:52 +0100 (CET)
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

For runtime suspend/resume, it is some different with suspend/resume,
e.g. codec power supply won't be switch off, codec jack detection
still working(to wake up system from Jack event), won't call call
snd_soc_suspend/resume, etc.

So here, we add a platform PM status, HSW_PM_STATE_RTD3, to make
the status more clear, when in idle, it will enter this status, to
transfer from HSW_PM_STATE_RTD3 to HSW_PM_STATE_D3, we will do those
extra jobs, and vice versa for resuming.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-haswell-pcm.c | 70 ++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index ad7f4a5..edf8eaf 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -119,8 +119,9 @@ struct hsw_pcm_data {
 };
 
 enum hsw_pm_state {
-	HSW_PM_STATE_D3 = 0,
-	HSW_PM_STATE_D0 = 1,
+	HSW_PM_STATE_D0 = 0,
+	HSW_PM_STATE_RTD3 = 1,
+	HSW_PM_STATE_D3 = 2,
 };
 
 /* private data for the driver */
@@ -1035,12 +1036,12 @@ static int hsw_pcm_runtime_suspend(struct device *dev)
 	struct hsw_priv_data *pdata = dev_get_drvdata(dev);
 	struct sst_hsw *hsw = pdata->hsw;
 
-	if (pdata->pm_state == HSW_PM_STATE_D3)
+	if (pdata->pm_state >= HSW_PM_STATE_RTD3)
 		return 0;
 
 	sst_hsw_dsp_runtime_suspend(hsw);
 	sst_hsw_dsp_runtime_sleep(hsw);
-	pdata->pm_state = HSW_PM_STATE_D3;
+	pdata->pm_state = HSW_PM_STATE_RTD3;
 
 	return 0;
 }
@@ -1051,7 +1052,7 @@ static int hsw_pcm_runtime_resume(struct device *dev)
 	struct sst_hsw *hsw = pdata->hsw;
 	int ret;
 
-	if (pdata->pm_state == HSW_PM_STATE_D0)
+	if (pdata->pm_state != HSW_PM_STATE_RTD3)
 		return 0;
 
 	ret = sst_hsw_dsp_load(hsw);
@@ -1091,7 +1092,7 @@ static void hsw_pcm_complete(struct device *dev)
 	struct hsw_pcm_data *pcm_data;
 	int i, err;
 
-	if (pdata->pm_state == HSW_PM_STATE_D0)
+	if (pdata->pm_state != HSW_PM_STATE_D3)
 		return;
 
 	err = sst_hsw_dsp_load(hsw);
@@ -1139,41 +1140,42 @@ static int hsw_pcm_prepare(struct device *dev)
 
 	if (pdata->pm_state == HSW_PM_STATE_D3)
 		return 0;
-	/* suspend all active streams */
-	for (i = 0; i < ARRAY_SIZE(mod_map); i++) {
-		pcm_data = &pdata->pcm[mod_map[i].dai_id][mod_map[i].stream];
+	else if (pdata->pm_state == HSW_PM_STATE_D0){
+		/* suspend all active streams */
+		for (i = 0; i < ARRAY_SIZE(mod_map); i++) {
+			pcm_data = &pdata->pcm[mod_map[i].dai_id][mod_map[i].stream];
+
+			if (!pcm_data->substream)
+				continue;
+			dev_dbg(dev, "suspending pcm %d\n", i);
+			snd_pcm_suspend_all(pcm_data->hsw_pcm);
+
+			/* We need to wait until the DSP FW stops the streams */
+			msleep(2);
+		}
 
-		if (!pcm_data->substream)
-			continue;
-		dev_dbg(dev, "suspending pcm %d\n", i);
-		snd_pcm_suspend_all(pcm_data->hsw_pcm);
+		/* preserve persistent memory */
+		for (i = 0; i < ARRAY_SIZE(mod_map); i++) {
+			pcm_data = &pdata->pcm[mod_map[i].dai_id][mod_map[i].stream];
+
+			if (!pcm_data->substream)
+				continue;
 
-		/* We need to wait until the DSP FW stops the streams */
-		msleep(2);
+			dev_dbg(dev, "saving context pcm %d\n", i);
+			err = sst_module_runtime_save(pcm_data->runtime,
+				&pcm_data->context);
+			if (err < 0)
+				dev_err(dev, "failed to save context for PCM %d\n", i);
+		}
+		/* enter D3 state and stall */
+		sst_hsw_dsp_runtime_suspend(hsw);
+		/* put the DSP to sleep */
+		sst_hsw_dsp_runtime_sleep(hsw);
 	}
 
 	snd_soc_suspend(pdata->soc_card->dev);
 	snd_soc_poweroff(pdata->soc_card->dev);
 
-	/* enter D3 state and stall */
-	sst_hsw_dsp_runtime_suspend(hsw);
-
-	/* preserve persistent memory */
-	for (i = 0; i < ARRAY_SIZE(mod_map); i++) {
-		pcm_data = &pdata->pcm[mod_map[i].dai_id][mod_map[i].stream];
-
-		if (!pcm_data->substream)
-			continue;
-
-		dev_dbg(dev, "saving context pcm %d\n", i);
-		err = sst_module_runtime_save(pcm_data->runtime,
-			&pcm_data->context);
-		if (err < 0)
-			dev_err(dev, "failed to save context for PCM %d\n", i);
-	}
-
-	/* put the DSP to sleep */
-	sst_hsw_dsp_runtime_sleep(hsw);
 	pdata->pm_state = HSW_PM_STATE_D3;
 
 	return 0;
-- 
1.9.1
