From: han.lu@intel.com
Subject: [PATCH 8/8] ASoC: Intel: enable parameter restore for
	sound effect module waves
Date: Mon,  2 Mar 2015 15:36:18 +0800
Message-ID: <1425281778-17513-8-git-send-email-han.lu@intel.com>
References: <1425281778-17513-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 821092605C7
 for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2015 08:38:21 +0100 (CET)
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

The parameters in DSP will lost on RTD3. To fix this, store parameter lines
in a buffer, and put the buffer content to DSP when resume from RTD3. The
size of buffer is 160 parameter lines.
And add kcontrol command to reset the buffer:
    cset "name='Waves Set Param' 0xff"

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 7dda402..df19d6c 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -341,6 +341,10 @@ struct sst_hsw {
 	/* flags bit field to track module state when resume from RTD3,
 	 * each bit represent state (enabled/disabled) of single module */
 	u32 enabled_modules_rtd3;
+
+	/* buffer to store parameter lines */
+	u32 param_idx;
+	u8 param_buf[WAVES_PARAM_LINES][WAVES_PARAM_COUNT];
 };
 
 #define CREATE_TRACE_POINTS
@@ -2005,6 +2009,37 @@ bool sst_hsw_is_module_enabled_rtd3(struct sst_hsw *hsw, u32 module_id)
 	return hsw->enabled_modules_rtd3 & (1 << module_id);
 }
 
+void sst_hsw_reset_param_buf(struct sst_hsw *hsw)
+{
+	hsw->param_idx = 0;
+	memset((void *)hsw->param_buf, 0, sizeof(hsw->param_buf));
+}
+
+int sst_hsw_store_param_line(struct sst_hsw *hsw, u8 *buf)
+{
+	if (hsw->param_idx > WAVES_PARAM_LINES - 1) {
+		dev_warn(hsw->dev, "warning: param buffer overflow!\n");
+		return 0;
+	}
+	memcpy(hsw->param_buf[hsw->param_idx], buf, WAVES_PARAM_COUNT);
+	hsw->param_idx++;
+	return 0;
+}
+
+int sst_hsw_launch_param_buf(struct sst_hsw *hsw)
+{
+	int ret, idx;
+
+	for (idx = 0; idx < hsw->param_idx; idx++) {
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
@@ -2305,6 +2340,9 @@ int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata)
 	if (ret < 0)
 		goto boot_err;
 
+	/* init param buffer */
+	sst_hsw_reset_param_buf(hsw);
+
 	/* wait for DSP boot completion */
 	sst_dsp_boot(hsw->dsp);
 	ret = wait_event_timeout(hsw->boot_wait, hsw->boot_complete,
diff --git a/sound/soc/intel/sst-haswell-ipc.h b/sound/soc/intel/sst-haswell-ipc.h
index 737f206..52fdea0 100644
--- a/sound/soc/intel/sst-haswell-ipc.h
+++ b/sound/soc/intel/sst-haswell-ipc.h
@@ -39,6 +39,7 @@
 #define SST_HSW_BUILD_HASH_LENGTH	40
 #define SST_HSW_IPC_MAX_SHORT_PARAMETER_SIZE	500
 #define WAVES_PARAM_COUNT		128
+#define WAVES_PARAM_LINES		160
 
 struct sst_hsw;
 struct sst_hsw_stream;
@@ -504,6 +505,9 @@ bool sst_hsw_is_module_active(struct sst_hsw *hsw, u32 module_id);
 void sst_hsw_set_module_enabled_rtd3(struct sst_hsw *hsw, u32 module_id);
 void sst_hsw_set_module_disabled_rtd3(struct sst_hsw *hsw, u32 module_id);
 bool sst_hsw_is_module_enabled_rtd3(struct sst_hsw *hsw, u32 module_id);
+void sst_hsw_reset_param_buf(struct sst_hsw *hsw);
+int sst_hsw_store_param_line(struct sst_hsw *hsw, u8 *buf);
+int sst_hsw_launch_param_buf(struct sst_hsw *hsw);
 
 int sst_hsw_module_load(struct sst_hsw *hsw,
 	u32 module_id, u32 instance_id, char *name);
diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index e69b364..4ba684b 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -384,6 +384,17 @@ static int hsw_waves_param_put(struct snd_kcontrol *kcontrol,
 	int param_id = ucontrol->value.bytes.data[0];
 	int param_size = WAVES_PARAM_COUNT;
 
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
 	if (sst_hsw_is_module_loaded(hsw, id)) {
 		if (!sst_hsw_is_module_active(hsw, id))
 			return 0;
@@ -1250,6 +1261,10 @@ static int hsw_pcm_runtime_resume(struct device *dev)
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
