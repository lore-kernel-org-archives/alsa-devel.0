From: han.lu@intel.com
Subject: [PATCH 5/8] ASoC: Intel: track module state on RTD3
Date: Mon,  2 Mar 2015 15:36:15 +0800
Message-ID: <1425281778-17513-5-git-send-email-han.lu@intel.com>
References: <1425281778-17513-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id F16FF26059C
 for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2015 08:38:14 +0100 (CET)
In-Reply-To: <1425281778-17513-1-git-send-email-han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Track module state over suspend so it's state can be restored on resume.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 2c15da2..d6ccb46 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -337,6 +337,10 @@ struct sst_hsw {
 
 	/* FW log stream */
 	struct sst_hsw_log_stream log_stream;
+
+	/* flags bit field to track module state when resume from RTD3,
+	 * each bit represent state (enabled/disabled) of single module */
+	u32 enabled_modules_rtd3;
 };
 
 #define CREATE_TRACE_POINTS
@@ -1986,6 +1990,21 @@ bool sst_hsw_is_module_active(struct sst_hsw *hsw, u32 module_id)
 		return false;
 }
 
+void sst_hsw_set_module_enabled_rtd3(struct sst_hsw *hsw, u32 module_id)
+{
+	hsw->enabled_modules_rtd3 |= (1 << module_id);
+}
+
+void sst_hsw_set_module_disabled_rtd3(struct sst_hsw *hsw, u32 module_id)
+{
+	hsw->enabled_modules_rtd3 &= ~(1 << module_id);
+}
+
+bool sst_hsw_is_module_enabled_rtd3(struct sst_hsw *hsw, u32 module_id)
+{
+	return hsw->enabled_modules_rtd3 & (1 << module_id);
+}
+
 int sst_hsw_module_load(struct sst_hsw *hsw,
 	u32 module_id, u32 instance_id, char *name)
 {
diff --git a/sound/soc/intel/sst-haswell-ipc.h b/sound/soc/intel/sst-haswell-ipc.h
index 30c65b2..48290a1 100644
--- a/sound/soc/intel/sst-haswell-ipc.h
+++ b/sound/soc/intel/sst-haswell-ipc.h
@@ -477,6 +477,9 @@ struct sst_dsp *sst_hsw_get_dsp(struct sst_hsw *hsw);
 void sst_hsw_init_module_state(struct sst_hsw *hsw);
 bool sst_hsw_is_module_loaded(struct sst_hsw *hsw, u32 module_id);
 bool sst_hsw_is_module_active(struct sst_hsw *hsw, u32 module_id);
+void sst_hsw_set_module_enabled_rtd3(struct sst_hsw *hsw, u32 module_id);
+void sst_hsw_set_module_disabled_rtd3(struct sst_hsw *hsw, u32 module_id);
+bool sst_hsw_is_module_enabled_rtd3(struct sst_hsw *hsw, u32 module_id);
 
 int sst_hsw_module_load(struct sst_hsw *hsw,
 	u32 module_id, u32 instance_id, char *name);
diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 3d10acc..f82560f 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -326,7 +326,9 @@ static int hsw_waves_switch_get(struct snd_kcontrol *kcontrol,
 	struct sst_hsw *hsw = pdata->hsw;
 	enum sst_hsw_module_id id = SST_HSW_MODULE_WAVES;
 
-	ucontrol->value.integer.value[0] = sst_hsw_is_module_active(hsw, id);
+	ucontrol->value.integer.value[0] =
+		(sst_hsw_is_module_active(hsw, id) ||
+		sst_hsw_is_module_enabled_rtd3(hsw, id));
 	return 0;
 }
 
@@ -349,6 +351,16 @@ static int hsw_waves_switch_put(struct snd_kcontrol *kcontrol,
 			ret = sst_hsw_module_enable(hsw, id, 0);
 		else
 			ret = sst_hsw_module_disable(hsw, id, 0);
+	} else {
+		/* on RTD3, module is unloaded */
+		if (switch_on == sst_hsw_is_module_enabled_rtd3(hsw, id))
+			return 0;
+
+		/* set flag for track */
+		if (switch_on)
+			sst_hsw_set_module_enabled_rtd3(hsw, id);
+		else
+			sst_hsw_set_module_disabled_rtd3(hsw, id);
 	}
 
 	return ret;
@@ -1157,10 +1169,18 @@ static int hsw_pcm_runtime_suspend(struct device *dev)
 {
 	struct hsw_priv_data *pdata = dev_get_drvdata(dev);
 	struct sst_hsw *hsw = pdata->hsw;
+	int ret;
 
 	if (pdata->pm_state >= HSW_PM_STATE_RTD3)
 		return 0;
 
+	/* fw modules will be unloaded on RTD3, set flag to trace */
+	if (sst_hsw_is_module_active(hsw, SST_HSW_MODULE_WAVES)) {
+		ret = sst_hsw_module_disable(hsw, SST_HSW_MODULE_WAVES, 0);
+		if (ret < 0)
+			return ret;
+		sst_hsw_set_module_enabled_rtd3(hsw, SST_HSW_MODULE_WAVES);
+	}
 	sst_hsw_dsp_runtime_suspend(hsw);
 	sst_hsw_dsp_runtime_sleep(hsw);
 	pdata->pm_state = HSW_PM_STATE_RTD3;
@@ -1195,6 +1215,15 @@ static int hsw_pcm_runtime_resume(struct device *dev)
 	else if (ret == 1) /* no action required */
 		return 0;
 
+	/* check flag when resume */
+	if (sst_hsw_is_module_enabled_rtd3(hsw, SST_HSW_MODULE_WAVES)) {
+		ret = sst_hsw_module_enable(hsw, SST_HSW_MODULE_WAVES, 0);
+		if (ret < 0)
+			return ret;
+		/* unset flag */
+		sst_hsw_set_module_disabled_rtd3(hsw, SST_HSW_MODULE_WAVES);
+	}
+
 	pdata->pm_state = HSW_PM_STATE_D0;
 	return ret;
 }
-- 
1.9.1
