From: han.lu@intel.com
Subject: [PATCH 7/8] ASoC: Intel: add kcontrol to set parameter
	to sound effect module waves
Date: Mon,  2 Mar 2015 15:36:17 +0800
Message-ID: <1425281778-17513-7-git-send-email-han.lu@intel.com>
References: <1425281778-17513-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 7782A26058C
 for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2015 08:38:19 +0100 (CET)
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

Each kcontrol command includes a line of parameters up to 128 bytes.
kcontrol command to set param:
    cset "name='Waves Set Param' <0x01,0xff,...>"
or
    cset-bin-file "name='Waves Set Param' <path/to/binary/config/file>"
alsa-lib commit 6ea14c36 and f47480af are required for listed format.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/soc/intel/sst-haswell-ipc.h b/sound/soc/intel/sst-haswell-ipc.h
index 16bec43..737f206 100644
--- a/sound/soc/intel/sst-haswell-ipc.h
+++ b/sound/soc/intel/sst-haswell-ipc.h
@@ -38,6 +38,7 @@
 #define SST_HSW_MAX_INFO_SIZE		64
 #define SST_HSW_BUILD_HASH_LENGTH	40
 #define SST_HSW_IPC_MAX_SHORT_PARAMETER_SIZE	500
+#define WAVES_PARAM_COUNT		128
 
 struct sst_hsw;
 struct sst_hsw_stream;
diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index f82560f..e69b364 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -366,6 +366,33 @@ static int hsw_waves_switch_put(struct snd_kcontrol *kcontrol,
 	return ret;
 }
 
+static int hsw_waves_param_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	/* keep an empty function here to match alsa-lib calling */
+	return 0;
+}
+
+static int hsw_waves_param_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_platform *platform = snd_soc_kcontrol_platform(kcontrol);
+	struct hsw_priv_data *pdata = snd_soc_platform_get_drvdata(platform);
+	struct sst_hsw *hsw = pdata->hsw;
+	int ret;
+	enum sst_hsw_module_id id = SST_HSW_MODULE_WAVES;
+	int param_id = ucontrol->value.bytes.data[0];
+	int param_size = WAVES_PARAM_COUNT;
+
+	if (sst_hsw_is_module_loaded(hsw, id)) {
+		if (!sst_hsw_is_module_active(hsw, id))
+			return 0;
+		ret = sst_hsw_module_set_param(hsw, id, 0, param_id,
+				param_size, ucontrol->value.bytes.data);
+	}
+	return ret;
+}
+
 /* TLV used by both global and stream volumes */
 static const DECLARE_TLV_DB_SCALE(hsw_vol_tlv, -9000, 300, 1);
 
@@ -390,6 +417,9 @@ static const struct snd_kcontrol_new hsw_volume_controls[] = {
 	/* enable/disable module waves */
 	SOC_SINGLE_BOOL_EXT("Waves Switch", 0,
 		hsw_waves_switch_get, hsw_waves_switch_put),
+	/* set parameters to module waves */
+	SND_SOC_BYTES_EXT("Waves Set Param", WAVES_PARAM_COUNT,
+		hsw_waves_param_get, hsw_waves_param_put),
 };
 
 /* Create DMA buffer page table for DSP */
-- 
1.9.1
