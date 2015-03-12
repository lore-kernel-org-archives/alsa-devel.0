From: han.lu@intel.com
Subject: [PATCH v3 1/3] ASoC: Intel: add kcontrol to
	enable/disable sound effect module waves
Date: Thu, 12 Mar 2015 13:53:00 +0800
Message-ID: <1426139582-7245-2-git-send-email-han.lu@intel.com>
References: <1426139582-7245-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 44EA4265529
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 06:53:55 +0100 (CET)
In-Reply-To: <1426139582-7245-1-git-send-email-han.lu@intel.com>
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

Add kcontrol to enable/disable module waves. IPC is valid only when module
is loaded. Also track module state over suspend so it's state can be restored
on resume.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index df22cc3..980df59 100644
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
index a604cc4..b3de87a 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -318,6 +318,54 @@ static int hsw_volume_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int hsw_waves_switch_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_platform *platform = snd_soc_kcontrol_platform(kcontrol);
+	struct hsw_priv_data *pdata = snd_soc_platform_get_drvdata(platform);
+	struct sst_hsw *hsw = pdata->hsw;
+	enum sst_hsw_module_id id = SST_HSW_MODULE_WAVES;
+
+	ucontrol->value.integer.value[0] =
+		(sst_hsw_is_module_active(hsw, id) ||
+		sst_hsw_is_module_enabled_rtd3(hsw, id));
+	return 0;
+}
+
+static int hsw_waves_switch_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_platform *platform = snd_soc_kcontrol_platform(kcontrol);
+	struct hsw_priv_data *pdata = snd_soc_platform_get_drvdata(platform);
+	struct sst_hsw *hsw = pdata->hsw;
+	int ret = 0;
+	enum sst_hsw_module_id id = SST_HSW_MODULE_WAVES;
+	bool switch_on = (bool)ucontrol->value.integer.value[0];
+
+	/* if module is in RAM on the DSP, apply user settings to module through
+	 * ipc. If module is not in RAM on the DSP, store user setting for
+	 * track */
+	if (sst_hsw_is_module_loaded(hsw, id)) {
+		if (switch_on == sst_hsw_is_module_active(hsw, id))
+			return 0;
+
+		if (switch_on)
+			ret = sst_hsw_module_enable(hsw, id, 0);
+		else
+			ret = sst_hsw_module_disable(hsw, id, 0);
+	} else {
+		if (switch_on == sst_hsw_is_module_enabled_rtd3(hsw, id))
+			return 0;
+
+		if (switch_on)
+			sst_hsw_set_module_enabled_rtd3(hsw, id);
+		else
+			sst_hsw_set_module_disabled_rtd3(hsw, id);
+	}
+
+	return ret;
+}
+
 /* TLV used by both global and stream volumes */
 static const DECLARE_TLV_DB_SCALE(hsw_vol_tlv, -9000, 300, 1);
 
@@ -339,6 +387,9 @@ static const struct snd_kcontrol_new hsw_volume_controls[] = {
 	SOC_DOUBLE_EXT_TLV("Mic Capture Volume", 4, 0, 8,
 		ARRAY_SIZE(volume_map) - 1, 0,
 		hsw_stream_volume_get, hsw_stream_volume_put, hsw_vol_tlv),
+	/* enable/disable module waves */
+	SOC_SINGLE_BOOL_EXT("Waves Switch", 0,
+		hsw_waves_switch_get, hsw_waves_switch_put),
 };
 
 /* Create DMA buffer page table for DSP */
@@ -1118,10 +1169,18 @@ static int hsw_pcm_runtime_suspend(struct device *dev)
 {
 	struct hsw_priv_data *pdata = dev_get_drvdata(dev);
 	struct sst_hsw *hsw = pdata->hsw;
+	int ret;
 
 	if (pdata->pm_state >= HSW_PM_STATE_RTD3)
 		return 0;
 
+	/* fw modules will be unloaded on RTD3, set flag to track */
+	if (sst_hsw_is_module_active(hsw, SST_HSW_MODULE_WAVES)) {
+		ret = sst_hsw_module_disable(hsw, SST_HSW_MODULE_WAVES, 0);
+		if (ret < 0)
+			return ret;
+		sst_hsw_set_module_enabled_rtd3(hsw, SST_HSW_MODULE_WAVES);
+	}
 	sst_hsw_dsp_runtime_suspend(hsw);
 	sst_hsw_dsp_runtime_sleep(hsw);
 	pdata->pm_state = HSW_PM_STATE_RTD3;
@@ -1156,6 +1215,15 @@ static int hsw_pcm_runtime_resume(struct device *dev)
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
