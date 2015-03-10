From: han.lu@intel.com
Subject: [PATCH v2 4/8] ASoC: Intel: add kcontrol to
	enable/disable sound effect module waves
Date: Tue, 10 Mar 2015 10:41:23 +0800
Message-ID: <1425955287-29661-4-git-send-email-han.lu@intel.com>
References: <1425955287-29661-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D30642617B5
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 03:41:51 +0100 (CET)
In-Reply-To: <1425955287-29661-1-git-send-email-han.lu@intel.com>
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
is loaded.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index a604cc4..3d10acc 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -318,6 +318,42 @@ static int hsw_volume_get(struct snd_kcontrol *kcontrol,
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
+	ucontrol->value.integer.value[0] = sst_hsw_is_module_active(hsw, id);
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
+	if (sst_hsw_is_module_loaded(hsw, id)) {
+		if (switch_on == sst_hsw_is_module_active(hsw, id))
+			return 0;
+
+		/* ipc is valid only when module is loaded */
+		if (switch_on)
+			ret = sst_hsw_module_enable(hsw, id, 0);
+		else
+			ret = sst_hsw_module_disable(hsw, id, 0);
+	}
+
+	return ret;
+}
+
 /* TLV used by both global and stream volumes */
 static const DECLARE_TLV_DB_SCALE(hsw_vol_tlv, -9000, 300, 1);
 
@@ -339,6 +375,9 @@ static const struct snd_kcontrol_new hsw_volume_controls[] = {
 	SOC_DOUBLE_EXT_TLV("Mic Capture Volume", 4, 0, 8,
 		ARRAY_SIZE(volume_map) - 1, 0,
 		hsw_stream_volume_get, hsw_stream_volume_put, hsw_vol_tlv),
+	/* enable/disable module waves */
+	SOC_SINGLE_BOOL_EXT("Waves Switch", 0,
+		hsw_waves_switch_get, hsw_waves_switch_put),
 };
 
 /* Create DMA buffer page table for DSP */
-- 
1.9.1
