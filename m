From: han.lu@intel.com
Subject: [PATCH v3 3/3] ASoC: Intel: add kcontrol to set
	parameter to sound effect module waves
Date: Thu, 12 Mar 2015 13:53:02 +0800
Message-ID: <1426139582-7245-4-git-send-email-han.lu@intel.com>
References: <1426139582-7245-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 073A226055F
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 06:53:58 +0100 (CET)
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

Each kcontrol command includes a line of parameters up to 128 bytes.
kcontrol command to set param:
    cset "name='Waves Set Param' <0x01,0xff,...>"
or
    cset-bin-file "name='Waves Set Param' <path/to/binary/config/file>"

The parameter lines are stored in a buffer array, so can be read back from
buffer rather than from DSP, and be relaunched to DSP when resume from RTD3.
The buffer size is 160 parameter lines.
kcontrol command to reset the buffer:
    cset "name='Waves Set Param' 0xff"

alsa-lib v1.0.29 or commit 6ea14c36 and f47480af are required to support the
kcontrol commands.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 15b811f..699099c 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -341,6 +341,11 @@ struct sst_hsw {
 	/* flags bit field to track module state when resume from RTD3,
 	 * each bit represent state (enabled/disabled) of single module */
 	u32 enabled_modules_rtd3;
+
+	/* buffer to store parameter lines */
+	u32 param_idx_w;	/* write index */
+	u32 param_idx_r;	/* read index */
+	u8 param_buf[WAVES_PARAM_LINES][WAVES_PARAM_COUNT];
 };
 
 #define CREATE_TRACE_POINTS
@@ -2005,6 +2010,62 @@ bool sst_hsw_is_module_enabled_rtd3(struct sst_hsw *hsw, u32 module_id)
 	return hsw->enabled_modules_rtd3 & (1 << module_id);
 }
 
+void sst_hsw_reset_param_buf(struct sst_hsw *hsw)
+{
+	hsw->param_idx_w = 0;
+	hsw->param_idx_r = 0;
+	memset((void *)hsw->param_buf, 0, sizeof(hsw->param_buf));
+}
+
+int sst_hsw_store_param_line(struct sst_hsw *hsw, u8 *buf)
+{
+	/* save line to the first available position of param buffer */
+	if (hsw->param_idx_w > WAVES_PARAM_LINES - 1) {
+		dev_warn(hsw->dev, "warning: param buffer overflow!\n");
+		return -EPERM;
+	}
+	memcpy(hsw->param_buf[hsw->param_idx_w], buf, WAVES_PARAM_COUNT);
+	hsw->param_idx_w++;
+	return 0;
+}
+
+int sst_hsw_load_param_line(struct sst_hsw *hsw, u8 *buf)
+{
+	u8 id = 0;
+
+	/* read the first matching line from param buffer */
+	while (hsw->param_idx_r < WAVES_PARAM_LINES) {
+		id = hsw->param_buf[hsw->param_idx_r][0];
+		hsw->param_idx_r++;
+		if (buf[0] == id) {
+			memcpy(buf, hsw->param_buf[hsw->param_idx_r],
+				WAVES_PARAM_COUNT);
+			break;
+		}
+	}
+	if (hsw->param_idx_r > WAVES_PARAM_LINES - 1) {
+		dev_dbg(hsw->dev, "end of buffer, roll to the beginning\n");
+		hsw->param_idx_r = 0;
+		return 0;
+	}
+	return 0;
+}
+
+int sst_hsw_launch_param_buf(struct sst_hsw *hsw)
+{
+	int ret, idx;
+
+	/* put all param lines to DSP through ipc */
+	for (idx = 0; idx < hsw->param_idx_w; idx++) {
+		ret = sst_hsw_module_set_param(hsw,
+			SST_HSW_MODULE_WAVES, 0, hsw->param_buf[idx][0],
+			WAVES_PARAM_COUNT, hsw->param_buf[idx]);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
 int sst_hsw_module_load(struct sst_hsw *hsw,
 	u32 module_id, u32 instance_id, char *name)
 {
@@ -2304,6 +2365,9 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 	if (ret < 0)
 		goto boot_err;
 
+	/* init param buffer */
+	sst_hsw_reset_param_buf(hsw);
+
 	/* wait for DSP boot completion */
 	sst_dsp_boot(hsw->dsp);
 	ret = wait_event_timeout(hsw->boot_wait, hsw->boot_complete,
diff --git a/sound/soc/intel/sst-haswell-ipc.h b/sound/soc/intel/sst-haswell-ipc.h
index 16bec43..06d71ae 100644
--- a/sound/soc/intel/sst-haswell-ipc.h
+++ b/sound/soc/intel/sst-haswell-ipc.h
@@ -38,6 +38,8 @@
 #define SST_HSW_MAX_INFO_SIZE		64
 #define SST_HSW_BUILD_HASH_LENGTH	40
 #define SST_HSW_IPC_MAX_SHORT_PARAMETER_SIZE	500
+#define WAVES_PARAM_COUNT		128
+#define WAVES_PARAM_LINES		160
 
 struct sst_hsw;
 struct sst_hsw_stream;
@@ -503,6 +505,10 @@ bool sst_hsw_is_module_active(struct sst_hsw *hsw, u32 module_id);
 void sst_hsw_set_module_enabled_rtd3(struct sst_hsw *hsw, u32 module_id);
 void sst_hsw_set_module_disabled_rtd3(struct sst_hsw *hsw, u32 module_id);
 bool sst_hsw_is_module_enabled_rtd3(struct sst_hsw *hsw, u32 module_id);
+void sst_hsw_reset_param_buf(struct sst_hsw *hsw);
+int sst_hsw_store_param_line(struct sst_hsw *hsw, u8 *buf);
+int sst_hsw_load_param_line(struct sst_hsw *hsw, u8 *buf);
+int sst_hsw_launch_param_buf(struct sst_hsw *hsw);
 
 int sst_hsw_module_load(struct sst_hsw *hsw,
 	u32 module_id, u32 instance_id, char *name);
diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index b3de87a..b40ec74 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -366,6 +366,49 @@ static int hsw_waves_switch_put(struct snd_kcontrol *kcontrol,
 	return ret;
 }
 
+static int hsw_waves_param_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_platform *platform = snd_soc_kcontrol_platform(kcontrol);
+	struct hsw_priv_data *pdata = snd_soc_platform_get_drvdata(platform);
+	struct sst_hsw *hsw = pdata->hsw;
+
+	/* return a matching line from param buffer */
+	return sst_hsw_load_param_line(hsw, ucontrol->value.bytes.data);
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
+	/* clear param buffer and reset buffer index */
+	if (param_id == 0xFF) {
+		sst_hsw_reset_param_buf(hsw);
+		return 0;
+	}
+
+	/* store params into buffer */
+	ret = sst_hsw_store_param_line(hsw, ucontrol->value.bytes.data);
+	if (ret < 0)
+		return ret;
+
+	if (sst_hsw_is_module_loaded(hsw, id)) {
+		if (!sst_hsw_is_module_active(hsw, id))
+			return 0;
+
+		ret = sst_hsw_module_set_param(hsw, id, 0, param_id,
+				param_size, ucontrol->value.bytes.data);
+	}
+	return ret;
+}
+
 /* TLV used by both global and stream volumes */
 static const DECLARE_TLV_DB_SCALE(hsw_vol_tlv, -9000, 300, 1);
 
@@ -390,6 +433,9 @@ static const struct snd_kcontrol_new hsw_volume_controls[] = {
 	/* enable/disable module waves */
 	SOC_SINGLE_BOOL_EXT("Waves Switch", 0,
 		hsw_waves_switch_get, hsw_waves_switch_put),
+	/* set parameters to module waves */
+	SND_SOC_BYTES_EXT("Waves Set Param", WAVES_PARAM_COUNT,
+		hsw_waves_param_get, hsw_waves_param_put),
 };
 
 /* Create DMA buffer page table for DSP */
@@ -1220,6 +1266,10 @@ static int hsw_pcm_runtime_resume(struct device *dev)
 		ret = sst_hsw_module_enable(hsw, SST_HSW_MODULE_WAVES, 0);
 		if (ret < 0)
 			return ret;
+		/* put parameters from buffer to dsp */
+		ret = sst_hsw_launch_param_buf(hsw);
+		if (ret < 0)
+			return ret;
 		/* unset flag */
 		sst_hsw_set_module_disabled_rtd3(hsw, SST_HSW_MODULE_WAVES);
 	}
-- 
1.9.1
