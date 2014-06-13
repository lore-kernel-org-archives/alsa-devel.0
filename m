From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 13/19] ASoC: Intel: mrfld: add bytes control
	for modules
Date: Fri, 13 Jun 2014 18:04:02 +0530
Message-ID: <1402662848-24534-14-git-send-email-vinod.koul@intel.com>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1691D264EFA
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 14:33:12 +0200 (CEST)
In-Reply-To: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This patch add support for various modules like eq etc for mrfld DSP. All these
moduels will be exposed to usermode as bytes controls.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-atom-controls.c |  172 +++++++++++++++++++++++++++++++++++
 sound/soc/intel/sst-atom-controls.h |  129 ++++++++++++++++++++++++++
 2 files changed, 301 insertions(+), 0 deletions(-)

diff --git a/sound/soc/intel/sst-atom-controls.c b/sound/soc/intel/sst-atom-controls.c
index f710888..c72d3aa 100644
--- a/sound/soc/intel/sst-atom-controls.c
+++ b/sound/soc/intel/sst-atom-controls.c
@@ -66,6 +66,176 @@ unsigned int sst_reg_write(struct sst_data *drv, unsigned int reg,
 	return val;
 }
 
+static inline void sst_fill_byte_control(char *param,
+					 u8 ipc_msg, u8 block,
+					 u8 task_id, u8 pipe_id,
+					 u16 len, void *cmd_data)
+{
+
+	struct snd_sst_bytes_v2 *byte_data = (struct snd_sst_bytes_v2 *)param;
+	byte_data->type = SST_CMD_BYTES_SET;
+	byte_data->ipc_msg = ipc_msg;
+	byte_data->block = block;
+	byte_data->task_id = task_id;
+	byte_data->pipe_id = pipe_id;
+
+	if (len > SST_MAX_BIN_BYTES - sizeof(*byte_data)) {
+		pr_err("%s: command length too big (%u)", __func__, len);
+		len = SST_MAX_BIN_BYTES - sizeof(*byte_data);
+		WARN_ON(1); /* this happens only if code is wrong */
+	}
+	byte_data->len = len;
+	memcpy(byte_data->bytes, cmd_data, len);
+	print_hex_dump_bytes("writing to lpe: ", DUMP_PREFIX_OFFSET,
+			     byte_data, len + sizeof(*byte_data));
+}
+
+static int sst_fill_and_send_cmd_unlocked(struct sst_data *drv,
+				 u8 ipc_msg, u8 block, u8 task_id, u8 pipe_id,
+				 void *cmd_data, u16 len)
+{
+	sst_fill_byte_control(drv->byte_stream, ipc_msg, block, task_id, pipe_id,
+			      len, cmd_data);
+	return sst->ops->set_generic_params(SST_SET_BYTE_STREAM,
+						drv->byte_stream);
+}
+
+/**
+ * sst_fill_and_send_cmd - generate the IPC message and send it to the FW
+ * @ipc_msg:	type of IPC (CMD, SET_PARAMS, GET_PARAMS)
+ * @cmd_data:	the IPC payload
+ */
+static int sst_fill_and_send_cmd(struct sst_data *drv,
+				 u8 ipc_msg, u8 block, u8 task_id, u8 pipe_id,
+				 void *cmd_data, u16 len)
+{
+	int ret;
+
+	mutex_lock(&drv->lock);
+	ret = sst_fill_and_send_cmd_unlocked(drv, ipc_msg, block, task_id, pipe_id,
+					     cmd_data, len);
+	mutex_unlock(&drv->lock);
+
+	return ret;
+}
+
+static void sst_send_algo_cmd(struct sst_data *drv,
+			      struct sst_algo_control *bc)
+{
+	int len;
+	struct sst_cmd_set_params *cmd;
+
+	if (bc->params == NULL)
+		return;
+
+	/* bc->max includes sizeof algos + length field */
+	len = sizeof(cmd->dst) + sizeof(cmd->command_id) + bc->max;
+
+	cmd = kzalloc(len, GFP_KERNEL);
+	if (cmd == NULL) {
+		pr_err("Failed to send cmd, kzalloc failed\n");
+		return;
+	}
+
+	SST_FILL_DESTINATION(2, cmd->dst, bc->pipe_id, bc->module_id);
+	cmd->command_id = bc->cmd_id;
+	memcpy(cmd->params, bc->params, bc->max);
+
+	sst_fill_and_send_cmd(drv, SST_IPC_IA_SET_PARAMS, SST_FLAG_BLOCKED,
+			      bc->task_id, 0, cmd, len);
+	kfree(cmd);
+}
+
+static int sst_algo_bytes_ctl_info(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_info *uinfo)
+{
+	struct sst_algo_control *bc = (void *)kcontrol->private_value;
+	struct snd_soc_platform *platform = snd_kcontrol_chip(kcontrol);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	uinfo->count = bc->max;
+
+	/* allocate space to cache the algo parameters in the driver */
+	if (bc->params == NULL) {
+		bc->params = devm_kzalloc(platform->dev, bc->max, GFP_KERNEL);
+		if (bc->params == NULL) {
+			pr_err("kzalloc failed\n");
+			return -ENOMEM;
+		}
+	}
+	return 0;
+}
+
+static int sst_algo_control_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct sst_algo_control *bc = (void *)kcontrol->private_value;
+
+	switch (bc->type) {
+	case SST_ALGO_PARAMS:
+		if (bc->params)
+			memcpy(ucontrol->value.bytes.data, bc->params, bc->max);
+		break;
+	case SST_ALGO_BYPASS:
+		ucontrol->value.integer.value[0] = bc->bypass ? 1 : 0;
+		pr_debug("%s: bypass  %d\n", __func__, bc->bypass);
+		break;
+	default:
+		pr_err("Invalid Input- algo type:%d\n", bc->type);
+		return -EINVAL;
+
+	}
+	return 0;
+}
+
+static int sst_algo_control_set(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_platform *platform = snd_kcontrol_chip(kcontrol);
+	struct sst_data *drv = snd_soc_platform_get_drvdata(platform);
+	struct sst_algo_control *bc = (void *)kcontrol->private_value;
+
+	pr_debug("in %s control_name=%s\n", __func__, kcontrol->id.name);
+	switch (bc->type) {
+	case SST_ALGO_PARAMS:
+		if (bc->params)
+			memcpy(bc->params, ucontrol->value.bytes.data, bc->max);
+		break;
+	case SST_ALGO_BYPASS:
+		bc->bypass = !!ucontrol->value.integer.value[0];
+		break;
+	default:
+		pr_err("Invalid Input- algo type:%ld\n", ucontrol->value.integer.value[0]);
+		return -EINVAL;
+	}
+	/*if pipe is enabled, need to send the algo params from here */
+	if (bc->w && bc->w->power)
+		sst_send_algo_cmd(drv, bc);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new sst_algo_controls[] = {
+	SST_ALGO_KCONTROL_BYTES("media_loop1_out", "fir", 272, SST_MODULE_ID_FIR_24,
+		 SST_PATH_INDEX_MEDIA_LOOP1_OUT, 0, SST_TASK_SBA, SBA_VB_SET_FIR),
+	SST_ALGO_KCONTROL_BYTES("media_loop1_out", "iir", 300, SST_MODULE_ID_IIR_24,
+		SST_PATH_INDEX_MEDIA_LOOP1_OUT, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
+	SST_ALGO_KCONTROL_BYTES("media_loop1_out", "mdrp", 286, SST_MODULE_ID_MDRP,
+		SST_PATH_INDEX_MEDIA_LOOP1_OUT, 0, SST_TASK_SBA, SBA_SET_MDRP),
+	SST_ALGO_KCONTROL_BYTES("media_loop2_out", "fir", 272, SST_MODULE_ID_FIR_24,
+		SST_PATH_INDEX_MEDIA_LOOP2_OUT, 0, SST_TASK_SBA, SBA_VB_SET_FIR),
+	SST_ALGO_KCONTROL_BYTES("media_loop2_out", "iir", 300, SST_MODULE_ID_IIR_24,
+		SST_PATH_INDEX_MEDIA_LOOP2_OUT, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
+	SST_ALGO_KCONTROL_BYTES("media_loop2_out", "mdrp", 286, SST_MODULE_ID_MDRP,
+		SST_PATH_INDEX_MEDIA_LOOP2_OUT, 0, SST_TASK_SBA, SBA_SET_MDRP),
+	SST_ALGO_KCONTROL_BYTES("sprot_loop_out", "lpro", 192, SST_MODULE_ID_SPROT,
+		SST_PATH_INDEX_SPROT_LOOP_OUT, 0, SST_TASK_SBA, SBA_VB_LPRO),
+	SST_ALGO_KCONTROL_BYTES("codec_in0", "dcr", 52, SST_MODULE_ID_FILT_DCR,
+		SST_PATH_INDEX_CODEC_IN0, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
+	SST_ALGO_KCONTROL_BYTES("codec_in1", "dcr", 52, SST_MODULE_ID_FILT_DCR,
+		SST_PATH_INDEX_CODEC_IN1, 0, SST_TASK_SBA, SBA_VB_SET_IIR),
+
+};
 
 int sst_dsp_init_v2_dpcm(struct snd_soc_platform *platform)
 {
@@ -86,5 +256,7 @@ int sst_dsp_init_v2_dpcm(struct snd_soc_platform *platform)
 		return -ENOMEM;
 	}
 
+	snd_soc_add_platform_controls(platform, sst_algo_controls,
+			ARRAY_SIZE(sst_algo_controls));
 	return ret;
 }
diff --git a/sound/soc/intel/sst-atom-controls.h b/sound/soc/intel/sst-atom-controls.h
index 8c35946..448fdff 100644
--- a/sound/soc/intel/sst-atom-controls.h
+++ b/sound/soc/intel/sst-atom-controls.h
@@ -345,4 +345,133 @@ enum sst_swm_state {
 	SST_SWM_ON = 3,
 };
 
+#define SST_FILL_LOCATION_IDS(dst, cell_idx, pipe_id)		do {	\
+		dst.location_id.p.cell_nbr_idx = (cell_idx);		\
+		dst.location_id.p.path_id = (pipe_id);			\
+	} while (0)
+#define SST_FILL_LOCATION_ID(dst, loc_id)				(\
+	dst.location_id.f = (loc_id))
+#define SST_FILL_MODULE_ID(dst, mod_id)					(\
+	dst.module_id = (mod_id))
+
+#define SST_FILL_DESTINATION1(dst, id)				do {	\
+		SST_FILL_LOCATION_ID(dst, (id) & 0xFFFF);		\
+		SST_FILL_MODULE_ID(dst, ((id) & 0xFFFF0000) >> 16);	\
+	} while (0)
+#define SST_FILL_DESTINATION2(dst, loc_id, mod_id)		do {	\
+		SST_FILL_LOCATION_ID(dst, loc_id);			\
+		SST_FILL_MODULE_ID(dst, mod_id);			\
+	} while (0)
+#define SST_FILL_DESTINATION3(dst, cell_idx, path_id, mod_id)	do {	\
+		SST_FILL_LOCATION_IDS(dst, cell_idx, path_id);		\
+		SST_FILL_MODULE_ID(dst, mod_id);			\
+	} while (0)
+
+#define SST_FILL_DESTINATION(level, dst, ...)				\
+	SST_FILL_DESTINATION##level(dst, __VA_ARGS__)
+#define SST_FILL_DEFAULT_DESTINATION(dst)				\
+	SST_FILL_DESTINATION(2, dst, SST_DEFAULT_LOCATION_ID, SST_DEFAULT_MODULE_ID)
+
+struct sst_destination_id {
+	union sst_location_id {
+		struct {
+			u8 cell_nbr_idx;	/* module index */
+			u8 path_id;		/* pipe_id */
+		} __packed	p;		/* part */
+		u16		f;		/* full */
+	} __packed location_id;
+	u16	   module_id;
+} __packed;
+struct sst_dsp_header {
+	struct sst_destination_id dst;
+	u16 command_id;
+	u16 length;
+} __packed;
+
+/*
+ *
+ * Common Commands
+ *
+ */
+struct sst_cmd_generic {
+	struct sst_dsp_header header;
+} __packed;
+struct sst_cmd_set_params {
+	struct sst_destination_id dst;
+	u16 command_id;
+	char params[0];
+} __packed;
+#define SST_CONTROL_NAME(xpname, xmname, xinstance, xtype) \
+	xpname " " xmname " " #xinstance " " xtype
+
+#define SST_COMBO_CONTROL_NAME(xpname, xmname, xinstance, xtype, xsubmodule) \
+	xpname " " xmname " " #xinstance " " xtype " " xsubmodule
+enum sst_algo_kcontrol_type {
+	SST_ALGO_PARAMS,
+	SST_ALGO_BYPASS,
+};
+
+struct sst_algo_control {
+	enum sst_algo_kcontrol_type type;
+	int max;
+	u16 module_id;
+	u16 pipe_id;
+	u16 task_id;
+	u16 cmd_id;
+	bool bypass;
+	unsigned char *params;
+	struct snd_soc_dapm_widget *w;
+};
+
+/* size of the control = size of params + size of length field */
+#define SST_ALGO_CTL_VALUE(xcount, xtype, xpipe, xmod, xtask, xcmd)			\
+	(struct sst_algo_control){							\
+		.max = xcount + sizeof(u16), .type = xtype, .module_id = xmod,			\
+		.pipe_id = xpipe, .task_id = xtask, .cmd_id = xcmd,			\
+	}
+
+#define SST_ALGO_KCONTROL(xname, xcount, xmod, xpipe,					\
+			  xtask, xcmd, xtype, xinfo, xget, xput)			\
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,						\
+	.name =  xname,									\
+	.info = xinfo, .get = xget, .put = xput,					\
+	.private_value = (unsigned long)&						\
+			SST_ALGO_CTL_VALUE(xcount, xtype, xpipe,			\
+					   xmod, xtask, xcmd),				\
+}
+
+#define SST_ALGO_KCONTROL_BYTES(xpname, xmname, xcount, xmod,				\
+				xpipe, xinstance, xtask, xcmd)				\
+	SST_ALGO_KCONTROL(SST_CONTROL_NAME(xpname, xmname, xinstance, "params"),	\
+			  xcount, xmod, xpipe, xtask, xcmd, SST_ALGO_PARAMS,		\
+			  sst_algo_bytes_ctl_info,					\
+			  sst_algo_control_get, sst_algo_control_set)
+
+#define SST_ALGO_KCONTROL_BOOL(xpname, xmname, xmod, xpipe, xinstance, xtask)		\
+	SST_ALGO_KCONTROL(SST_CONTROL_NAME(xpname, xmname, xinstance, "bypass"),	\
+			  0, xmod, xpipe, xtask, 0, SST_ALGO_BYPASS,			\
+			  snd_soc_info_bool_ext,					\
+			  sst_algo_control_get, sst_algo_control_set)
+
+#define SST_ALGO_BYPASS_PARAMS(xpname, xmname, xcount, xmod, xpipe,			\
+				xinstance, xtask, xcmd)					\
+	SST_ALGO_KCONTROL_BOOL(xpname, xmname, xmod, xpipe, xinstance, xtask),		\
+	SST_ALGO_KCONTROL_BYTES(xpname, xmname, xcount, xmod, xpipe, xinstance, xtask, xcmd)
+
+#define SST_COMBO_ALGO_KCONTROL_BYTES(xpname, xmname, xsubmod, xcount, xmod,		\
+				      xpipe, xinstance, xtask, xcmd)			\
+	SST_ALGO_KCONTROL(SST_COMBO_CONTROL_NAME(xpname, xmname, xinstance, "params",	\
+						 xsubmod),				\
+			  xcount, xmod, xpipe, xtask, xcmd, SST_ALGO_PARAMS,		\
+			  sst_algo_bytes_ctl_info,					\
+			  sst_algo_control_get, sst_algo_control_set)
+
+
+struct sst_enum {
+	bool tx;
+	unsigned short reg;
+	unsigned int max;
+	const char * const *texts;
+	struct snd_soc_dapm_widget *w;
+};
 #endif
-- 
1.7.0.4
