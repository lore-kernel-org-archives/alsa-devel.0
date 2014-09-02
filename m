From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v5 05/12] ASoC: Intel: mrfld: add the gain
	controls
Date: Tue,  2 Sep 2014 18:06:00 +0530
Message-ID: <1409661367-19047-6-git-send-email-subhransu.s.prusty@intel.com>
References: <1409661367-19047-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DE5F2654E8
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 14:58:38 +0200 (CEST)
In-Reply-To: <1409661367-19047-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

The DSP has various gain modules in the path,
add these as ALSA gain controls

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/sst-atom-controls.c | 173 +++++++++++++++++++++++++++++++++++-
 sound/soc/intel/sst-atom-controls.h | 119 +++++++++++++++++++++++++
 2 files changed, 291 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-atom-controls.c b/sound/soc/intel/sst-atom-controls.c
index c11712d..5d7120f 100644
--- a/sound/soc/intel/sst-atom-controls.c
+++ b/sound/soc/intel/sst-atom-controls.c
@@ -175,6 +175,166 @@ static int sst_algo_control_set(struct snd_kcontrol *kcontrol,
 	return ret;
 }
 
+static int sst_gain_ctl_info(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	struct sst_gain_mixer_control *mc = (void *)kcontrol->private_value;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = mc->stereo ? 2 : 1;
+	uinfo->value.integer.min = mc->min;
+	uinfo->value.integer.max = mc->max;
+	return 0;
+}
+
+/**
+ * sst_send_gain_cmd - send the gain algorithm IPC to the FW
+ * @gv:		the stored value of gain (also contains rampduration)
+ * @mute:	flag that indicates whether this was called from the
+ *		digital_mute callback or directly. If called from the
+ *		digital_mute callback, module will be muted/unmuted based on this
+ *		flag. The flag is always 0 if called directly.
+ *
+ * The user-set gain value is sent only if the user-controllable 'mute' control
+ * is OFF (indicated by gv->mute). Otherwise, the mute value (MIN value) is
+ * sent.
+ */
+static void sst_send_gain_cmd(struct sst_data *drv, struct sst_gain_value *gv,
+			      u16 task_id, u16 loc_id, u16 module_id, int mute)
+{
+	struct sst_cmd_set_gain_dual cmd;
+
+	dev_dbg(&drv->pdev->dev, "Enter\n");
+
+	cmd.header.command_id = MMX_SET_GAIN;
+	SST_FILL_DEFAULT_DESTINATION(cmd.header.dst);
+	cmd.gain_cell_num = 1;
+
+	if (mute || gv->mute) {
+		cmd.cell_gains[0].cell_gain_left = SST_GAIN_MIN_VALUE;
+		cmd.cell_gains[0].cell_gain_right = SST_GAIN_MIN_VALUE;
+	} else {
+		cmd.cell_gains[0].cell_gain_left = gv->l_gain;
+		cmd.cell_gains[0].cell_gain_right = gv->r_gain;
+	}
+	SST_FILL_DESTINATION(2, cmd.cell_gains[0].dest,
+			     loc_id, module_id);
+	cmd.cell_gains[0].gain_time_constant = gv->ramp_duration;
+
+	cmd.header.length = sizeof(struct sst_cmd_set_gain_dual)
+				- sizeof(struct sst_dsp_header);
+
+	sst_fill_and_send_cmd_unlocked(drv, SST_IPC_IA_SET_PARAMS,
+				SST_FLAG_BLOCKED, task_id, 0, &cmd,
+			      sizeof(cmd.header) + cmd.header.length);
+}
+
+static int sst_gain_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct sst_gain_mixer_control *mc = (void *)kcontrol->private_value;
+	struct sst_gain_value *gv = mc->gain_val;
+
+	switch (mc->type) {
+	case SST_GAIN_TLV:
+		ucontrol->value.integer.value[0] = gv->l_gain;
+		ucontrol->value.integer.value[1] = gv->r_gain;
+		break;
+	case SST_GAIN_MUTE:
+		ucontrol->value.integer.value[0] = gv->mute ? 1 : 0;
+		break;
+	case SST_GAIN_RAMP_DURATION:
+		ucontrol->value.integer.value[0] = gv->ramp_duration;
+		break;
+	default:
+		dev_err(component->dev, "Invalid Input- gain type:%d\n",
+				mc->type);
+		return -EINVAL;
+	};
+	return 0;
+}
+
+static int sst_gain_put(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_platform *platform =  snd_soc_kcontrol_platform(kcontrol);
+	struct sst_data *drv = snd_soc_platform_get_drvdata(platform);
+	struct sst_gain_mixer_control *mc = (void *)kcontrol->private_value;
+	struct sst_gain_value *gv = mc->gain_val;
+
+	mutex_lock(&drv->lock);
+	switch (mc->type) {
+	case SST_GAIN_TLV:
+		gv->l_gain = ucontrol->value.integer.value[0];
+		gv->r_gain = ucontrol->value.integer.value[1];
+		dev_dbg(platform->dev, "%s: Volume %d, %d\n",
+				mc->pname, gv->l_gain, gv->r_gain);
+		break;
+	case SST_GAIN_MUTE:
+		gv->mute = !!ucontrol->value.integer.value[0];
+		dev_dbg(platform->dev, "%s: Mute %d\n", mc->pname, gv->mute);
+		break;
+	case SST_GAIN_RAMP_DURATION:
+		gv->ramp_duration = ucontrol->value.integer.value[0];
+		dev_dbg(platform->dev, "%s: RampDuration %d\n",
+					mc->pname, gv->ramp_duration);
+		break;
+	default:
+		mutex_unlock(&drv->lock);
+		dev_err(platform->dev, "Invalid Input- gain type:%d\n",
+				mc->type);
+		return -EINVAL;
+	};
+
+	if (mc->w && mc->w->power)
+		sst_send_gain_cmd(drv, gv, mc->task_id,
+				mc->pipe_id | mc->instance_id, mc->module_id, 0);
+	mutex_unlock(&drv->lock);
+	return 0;
+}
+
+static const DECLARE_TLV_DB_SCALE(sst_gain_tlv_common, SST_GAIN_MIN_VALUE * 10, 10, 0);
+
+/*Gain helper with min/max set*/
+#define SST_GAIN(name, path_id, task_id, instance, gain_var)				\
+	SST_GAIN_KCONTROLS(name, "gain", SST_GAIN_MIN_VALUE, SST_GAIN_MAX_VALUE,	\
+		SST_GAIN_TC_MIN, SST_GAIN_TC_MAX,					\
+		sst_gain_get, sst_gain_put,						\
+		SST_MODULE_ID_GAIN_CELL, path_id, instance, task_id,			\
+		sst_gain_tlv_common, gain_var)
+
+#define SST_VOLUME(name, path_id, task_id, instance, gain_var)				\
+	SST_GAIN_KCONTROLS(name, "volume", SST_GAIN_MIN_VALUE, SST_GAIN_MAX_VALUE,	\
+		SST_GAIN_TC_MIN, SST_GAIN_TC_MAX,					\
+		sst_gain_get, sst_gain_put,						\
+		SST_MODULE_ID_VOLUME, path_id, instance, task_id,			\
+		sst_gain_tlv_common, gain_var)
+
+#define SST_NUM_GAINS 36
+static struct sst_gain_value sst_gains[SST_NUM_GAINS];
+
+static const struct snd_kcontrol_new sst_gain_controls[] = {
+	SST_GAIN("media0_in", SST_PATH_INDEX_MEDIA0_IN, SST_TASK_MMX, 0, &sst_gains[0]),
+	SST_GAIN("media1_in", SST_PATH_INDEX_MEDIA1_IN, SST_TASK_MMX, 0, &sst_gains[1]),
+	SST_GAIN("media2_in", SST_PATH_INDEX_MEDIA2_IN, SST_TASK_MMX, 0, &sst_gains[2]),
+	SST_GAIN("media3_in", SST_PATH_INDEX_MEDIA3_IN, SST_TASK_MMX, 0, &sst_gains[3]),
+
+	SST_GAIN("pcm0_in", SST_PATH_INDEX_PCM0_IN, SST_TASK_SBA, 0, &sst_gains[4]),
+	SST_GAIN("pcm1_in", SST_PATH_INDEX_PCM1_IN, SST_TASK_SBA, 0, &sst_gains[5]),
+	SST_GAIN("pcm1_out", SST_PATH_INDEX_PCM1_OUT, SST_TASK_SBA, 0, &sst_gains[7]),
+	SST_GAIN("pcm2_out", SST_PATH_INDEX_PCM2_OUT, SST_TASK_SBA, 0, &sst_gains[8]),
+
+	SST_GAIN("codec_in0", SST_PATH_INDEX_CODEC_IN0, SST_TASK_SBA, 0, &sst_gains[20]),
+	SST_GAIN("codec_in1", SST_PATH_INDEX_CODEC_IN1, SST_TASK_SBA, 0, &sst_gains[21]),
+	SST_GAIN("codec_out0", SST_PATH_INDEX_CODEC_OUT0, SST_TASK_SBA, 0, &sst_gains[22]),
+	SST_GAIN("codec_out1", SST_PATH_INDEX_CODEC_OUT1, SST_TASK_SBA, 0, &sst_gains[23]),
+	SST_GAIN("media_loop1_out", SST_PATH_INDEX_MEDIA_LOOP1_OUT, SST_TASK_SBA, 0, &sst_gains[30]),
+	SST_GAIN("media_loop2_out", SST_PATH_INDEX_MEDIA_LOOP2_OUT, SST_TASK_SBA, 0, &sst_gains[31]),
+	SST_GAIN("sprot_loop_out", SST_PATH_INDEX_SPROT_LOOP_OUT, SST_TASK_SBA, 0, &sst_gains[32]),
+	SST_VOLUME("media0_in", SST_PATH_INDEX_MEDIA0_IN, SST_TASK_MMX, 0, &sst_gains[33]),
+};
+
 static const struct snd_kcontrol_new sst_algo_controls[] = {
 	SST_ALGO_KCONTROL_BYTES("media_loop1_out", "fir", 272, SST_MODULE_ID_FIR_24,
 		 SST_PATH_INDEX_MEDIA_LOOP1_OUT, 0, SST_TASK_SBA, SBA_VB_SET_FIR),
@@ -199,7 +359,7 @@ static const struct snd_kcontrol_new sst_algo_controls[] = {
 
 int sst_dsp_init_v2_dpcm(struct snd_soc_platform *platform)
 {
-	int ret = 0;
+	int i, ret = 0;
 	struct sst_data *drv = snd_soc_platform_get_drvdata(platform);
 
 	drv->byte_stream = devm_kzalloc(platform->dev,
@@ -207,6 +367,17 @@ int sst_dsp_init_v2_dpcm(struct snd_soc_platform *platform)
 	if (!drv->byte_stream)
 		return -ENOMEM;
 
+
+	for (i = 0; i < SST_NUM_GAINS; i++) {
+		sst_gains[i].mute = SST_GAIN_MUTE_DEFAULT;
+		sst_gains[i].l_gain = SST_GAIN_VOLUME_DEFAULT;
+		sst_gains[i].r_gain = SST_GAIN_VOLUME_DEFAULT;
+		sst_gains[i].ramp_duration = SST_GAIN_RAMP_DURATION_DEFAULT;
+	}
+
+	snd_soc_add_platform_controls(platform, sst_gain_controls,
+			ARRAY_SIZE(sst_gain_controls));
+
 	snd_soc_add_platform_controls(platform, sst_algo_controls,
 			ARRAY_SIZE(sst_algo_controls));
 	return ret;
diff --git a/sound/soc/intel/sst-atom-controls.h b/sound/soc/intel/sst-atom-controls.h
index 7007010..6431c1a 100644
--- a/sound/soc/intel/sst-atom-controls.h
+++ b/sound/soc/intel/sst-atom-controls.h
@@ -360,16 +360,135 @@ struct sst_dsp_header {
 struct sst_cmd_generic {
 	struct sst_dsp_header header;
 } __packed;
+
+struct gain_cell {
+	struct sst_destination_id dest;
+	s16 cell_gain_left;
+	s16 cell_gain_right;
+	u16 gain_time_constant;
+} __packed;
+
+#define NUM_GAIN_CELLS 1
+struct sst_cmd_set_gain_dual {
+	struct sst_dsp_header header;
+	u16    gain_cell_num;
+	struct gain_cell cell_gains[NUM_GAIN_CELLS];
+} __packed;
 struct sst_cmd_set_params {
 	struct sst_destination_id dst;
 	u16 command_id;
 	char params[0];
 } __packed;
+/**** widget defines *****/
+
+#include <sound/soc.h>
+#include <sound/tlv.h>
+struct sst_ids {
+	u16 location_id;
+	u16 module_id;
+	u8  task_id;
+	u8  format;
+	u8  reg;
+	const char *parent_wname;
+	struct snd_soc_dapm_widget *parent_w;
+	struct list_head algo_list;
+	struct list_head gain_list;
+	const struct sst_pcm_format *pcm_fmt;
+};
+enum sst_gain_kcontrol_type {
+	SST_GAIN_TLV,
+	SST_GAIN_MUTE,
+	SST_GAIN_RAMP_DURATION,
+};
+
+struct sst_gain_mixer_control {
+	bool stereo;
+	enum sst_gain_kcontrol_type type;
+	struct sst_gain_value *gain_val;
+	int max;
+	int min;
+	u16 instance_id;
+	u16 module_id;
+	u16 pipe_id;
+	u16 task_id;
+	char pname[44];
+	struct snd_soc_dapm_widget *w;
+};
+
+struct sst_gain_value {
+	u16 ramp_duration;
+	s16 l_gain;
+	s16 r_gain;
+	bool mute;
+};
+#define SST_GAIN_VOLUME_DEFAULT		(-1440)
+#define SST_GAIN_RAMP_DURATION_DEFAULT	5 /* timeconstant */
+#define SST_GAIN_MUTE_DEFAULT		true
+
+#define SST_GAIN_KCONTROL_TLV(xname, xhandler_get, xhandler_put, \
+			      xmod, xpipe, xinstance, xtask, tlv_array, xgain_val, \
+			      xmin, xmax, xpname) \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
+		  SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.tlv.p = (tlv_array), \
+	.info = sst_gain_ctl_info,\
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = (unsigned long)&(struct sst_gain_mixer_control) \
+	{ .stereo = true, .max = xmax, .min = xmin, .type = SST_GAIN_TLV, \
+	  .module_id = xmod, .pipe_id = xpipe, .task_id = xtask,\
+	  .instance_id = xinstance, .gain_val = xgain_val, .pname = xpname}
+
+#define SST_GAIN_KCONTROL_INT(xname, xhandler_get, xhandler_put, \
+			      xmod, xpipe, xinstance, xtask, xtype, xgain_val, \
+			      xmin, xmax, xpname) \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = sst_gain_ctl_info, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = (unsigned long)&(struct sst_gain_mixer_control) \
+	{ .stereo = false, .max = xmax, .min = xmin, .type = xtype, \
+	  .module_id = xmod, .pipe_id = xpipe, .task_id = xtask,\
+	  .instance_id = xinstance, .gain_val = xgain_val, .pname =  xpname}
+
+#define SST_GAIN_KCONTROL_BOOL(xname, xhandler_get, xhandler_put,\
+			       xmod, xpipe, xinstance, xtask, xgain_val, xpname) \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_bool_ext, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = (unsigned long)&(struct sst_gain_mixer_control) \
+	{ .stereo = false, .type = SST_GAIN_MUTE, \
+	  .module_id = xmod, .pipe_id = xpipe, .task_id = xtask,\
+	  .instance_id = xinstance, .gain_val = xgain_val, .pname = xpname}
 #define SST_CONTROL_NAME(xpname, xmname, xinstance, xtype) \
 	xpname " " xmname " " #xinstance " " xtype
 
 #define SST_COMBO_CONTROL_NAME(xpname, xmname, xinstance, xtype, xsubmodule) \
 	xpname " " xmname " " #xinstance " " xtype " " xsubmodule
+
+/*
+ * 3 Controls for each Gain module
+ * e.g.	- pcm0_in gain 0 volume
+ *	- pcm0_in gain 0 rampduration
+ *	- pcm0_in gain 0 mute
+ */
+#define SST_GAIN_KCONTROLS(xpname, xmname, xmin_gain, xmax_gain, xmin_tc, xmax_tc, \
+			   xhandler_get, xhandler_put, \
+			   xmod, xpipe, xinstance, xtask, tlv_array, xgain_val) \
+	{ SST_GAIN_KCONTROL_INT(SST_CONTROL_NAME(xpname, xmname, xinstance, "rampduration"), \
+		xhandler_get, xhandler_put, xmod, xpipe, xinstance, xtask, SST_GAIN_RAMP_DURATION, \
+		xgain_val, xmin_tc, xmax_tc, xpname) }, \
+	{ SST_GAIN_KCONTROL_BOOL(SST_CONTROL_NAME(xpname, xmname, xinstance, "mute"), \
+		xhandler_get, xhandler_put, xmod, xpipe, xinstance, xtask, \
+		xgain_val, xpname) } ,\
+	{ SST_GAIN_KCONTROL_TLV(SST_CONTROL_NAME(xpname, xmname, xinstance, "volume"), \
+		xhandler_get, xhandler_put, xmod, xpipe, xinstance, xtask, tlv_array, \
+		xgain_val, xmin_gain, xmax_gain, xpname) }
+
+#define SST_GAIN_TC_MIN		5
+#define SST_GAIN_TC_MAX		5000
+#define SST_GAIN_MIN_VALUE	-1440 /* in 0.1 DB units */
+#define SST_GAIN_MAX_VALUE	360
+
 enum sst_algo_kcontrol_type {
 	SST_ALGO_PARAMS,
 	SST_ALGO_BYPASS,
-- 
1.9.0
