From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [v4 08/12] ASoC: Intel: mrfld: add DSP core controls
Date: Mon,  4 Aug 2014 15:15:59 +0530
Message-ID: <1407145563-1303-9-git-send-email-subhransu.s.prusty@intel.com>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 623CF2610A1
 for <alsa-devel@alsa-project.org>; Mon,  4 Aug 2014 12:07:44 +0200 (CEST)
In-Reply-To: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
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

This patch adds core controls like interleavers, SSP BEs, and also logic of sending
pipeline and module commands to the DSP

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/sst-atom-controls.c | 635 +++++++++++++++++++++++++++++++++++-
 sound/soc/intel/sst-atom-controls.h | 309 ++++++++++++++++++
 2 files changed, 943 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-atom-controls.c b/sound/soc/intel/sst-atom-controls.c
index afb59131ec09..5a181b32c247 100644
--- a/sound/soc/intel/sst-atom-controls.c
+++ b/sound/soc/intel/sst-atom-controls.c
@@ -78,6 +78,153 @@ static int sst_fill_and_send_cmd(struct sst_data *drv,
 	return ret;
 }
 
+/*
+ * slot map value is a bitfield where each bit represents a FW channel
+ *
+ *			3 2 1 0		# 0 = codec0, 1 = codec1
+ *			RLRLRLRL	# 3, 4 = reserved
+ *
+ * e.g. slot 0 rx map =	00001100b -> data from slot 0 goes into codec_in1 L,R
+ */
+static u8 sst_ssp_slot_map[SST_MAX_TDM_SLOTS] = {
+	0x1, 0x2, 0x4, 0x8, 0x10, 0x20, 0x40, 0x80, /* default rx map */
+};
+
+/*
+ * channel map value is a bitfield where each bit represents a slot
+ *
+ *			  76543210	# 0 = slot 0, 1 = slot 1
+ *
+ * e.g. codec1_0 tx map = 00000101b -> data from codec_out1_0 goes into slot 0, 2
+ */
+static u8 sst_ssp_channel_map[SST_MAX_TDM_SLOTS] = {
+	0x1, 0x2, 0x4, 0x8, 0x10, 0x20, 0x40, 0x80, /* default tx map */
+};
+
+static void sst_send_slot_map(struct sst_data *drv)
+{
+	struct sst_param_sba_ssp_slot_map cmd;
+
+	pr_debug("Enter: %s\n", __func__);
+
+	SST_FILL_DEFAULT_DESTINATION(cmd.header.dst);
+	cmd.header.command_id = SBA_SET_SSP_SLOT_MAP;
+	cmd.header.length = sizeof(struct sst_param_sba_ssp_slot_map)
+				- sizeof(struct sst_dsp_header);
+
+	cmd.param_id = SBA_SET_SSP_SLOT_MAP;
+	cmd.param_len = sizeof(cmd.rx_slot_map) + sizeof(cmd.tx_slot_map) + sizeof(cmd.ssp_index);
+	cmd.ssp_index = SSP_CODEC;
+
+	memcpy(cmd.rx_slot_map, &sst_ssp_slot_map[0], sizeof(cmd.rx_slot_map));
+	memcpy(cmd.tx_slot_map, &sst_ssp_channel_map[0], sizeof(cmd.tx_slot_map));
+
+	sst_fill_and_send_cmd_unlocked(drv, SST_IPC_IA_SET_PARAMS,
+			SST_FLAG_BLOCKED, SST_TASK_SBA, 0, &cmd,
+			      sizeof(cmd.header) + cmd.header.length);
+}
+
+int sst_slot_enum_info(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_info *uinfo)
+{
+	struct sst_enum *e = (struct sst_enum *)kcontrol->private_value;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = e->max;
+
+	if (uinfo->value.enumerated.item > e->max - 1)
+		uinfo->value.enumerated.item = e->max - 1;
+	strcpy(uinfo->value.enumerated.name,
+		e->texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+/**
+ * sst_slot_get - get the status of the interleaver/deinterleaver control
+ *
+ * Searches the map where the control status is stored, and gets the
+ * channel/slot which is currently set for this enumerated control. Since it is
+ * an enumerated control, there is only one possible value.
+ */
+static int sst_slot_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct sst_enum *e = (void *)kcontrol->private_value;
+	unsigned int ctl_no = e->reg;
+	unsigned int is_tx = e->tx;
+	unsigned int val, mux;
+	u8 *map = is_tx ? sst_ssp_channel_map : sst_ssp_slot_map;
+
+	val = 1 << ctl_no;
+	/* search which slot/channel has this bit set - there should be only one */
+	for (mux = e->max; mux > 0;  mux--)
+		if (map[mux - 1] & val)
+			break;
+
+	ucontrol->value.enumerated.item[0] = mux;
+	pr_debug("%s: %s - %s map = %#x\n", __func__, is_tx ? "tx channel" : "rx slot",
+		 e->texts[mux], mux ? map[mux - 1] : -1);
+	return 0;
+}
+
+/**
+ * sst_slot_put - set the status of interleaver/deinterleaver control
+ *
+ * (de)interleaver controls are defined in opposite sense to be user-friendly
+ *
+ * Instead of the enum value being the value written to the register, it is the
+ * register address; and the kcontrol number (register num) is the value written
+ * to the register. This is so that there can be only one value for each
+ * slot/channel since there is only one control for each slot/channel.
+ *
+ * This means that whenever an enum is set, we need to clear the bit
+ * for that kcontrol_no for all the interleaver OR deinterleaver registers
+ */
+static int sst_slot_put(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_platform *platform =  snd_soc_kcontrol_platform(kcontrol);
+	struct sst_data *drv = snd_soc_platform_get_drvdata(platform);
+	struct sst_enum *e = (void *)kcontrol->private_value;
+	int i;
+	unsigned int ctl_no = e->reg;
+	unsigned int is_tx = e->tx;
+	unsigned int slot_channel_no;
+	unsigned int val, mux;
+	u8 *map;
+
+	mutex_lock(&drv->lock);
+	map = is_tx ? sst_ssp_channel_map : sst_ssp_slot_map;
+
+	val = 1 << ctl_no;
+	mux = ucontrol->value.enumerated.item[0];
+	if (mux > e->max - 1) {
+		mutex_unlock(&drv->lock);
+		return -EINVAL;
+	}
+
+
+	/* first clear all registers of this bit */
+	for (i = 0; i < e->max; i++)
+		map[i] &= ~val;
+
+	if (mux == 0) /* kctl set to 'none' */
+		return 0;
+
+	/* offset by one to take "None" into account */
+	slot_channel_no = mux - 1;
+	map[slot_channel_no] |= val;
+
+	pr_debug("%s: %s %s map = %#x\n", __func__, is_tx ? "tx channel" : "rx slot",
+		 e->texts[mux], map[slot_channel_no]);
+
+	if (e->w && e->w->power)
+		sst_send_slot_map(drv);
+	mutex_unlock(&drv->lock);
+	return 0;
+}
+
 static void sst_send_algo_cmd(struct sst_data *drv,
 			      struct sst_algo_control *bc)
 {
@@ -103,7 +250,28 @@ static void sst_send_algo_cmd(struct sst_data *drv,
 	kfree(cmd);
 }
 
-static int sst_algo_bytes_ctl_info(struct snd_kcontrol *kcontrol,
+/**
+ * sst_find_and_send_pipe_algo - send all the algo parameters for a pipe
+ *
+ * The algos which are in each pipeline are sent to the firmware one by one
+ */
+static void sst_find_and_send_pipe_algo(struct sst_data *drv,
+					const char *pipe, struct sst_ids *ids)
+{
+	struct sst_algo_control *bc;
+	struct sst_module *algo = NULL;
+
+	pr_debug("Enter: %s, widget=%s\n", __func__, pipe);
+
+	list_for_each_entry(algo, &ids->algo_list, node) {
+		bc = (void *)algo->kctl->private_value;
+
+		pr_debug("Found algo control name=%s pipe=%s\n", algo->kctl->id.name, pipe);
+		sst_send_algo_cmd(drv, bc);
+	}
+}
+
+int sst_algo_bytes_ctl_info(struct snd_kcontrol *kcontrol,
 			    struct snd_ctl_elem_info *uinfo)
 {
 	struct sst_algo_control *bc = (void *)kcontrol->private_value;
@@ -287,8 +455,270 @@ static int sst_gain_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static void sst_set_pipe_gain(struct sst_ids *ids, struct sst_data *drv, int mute);
+
+static void sst_send_pipe_module_params(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol)
+{
+	struct snd_soc_platform *platform =  snd_soc_kcontrol_platform(kcontrol);
+	struct sst_data *drv = snd_soc_platform_get_drvdata(platform);
+	struct sst_ids *ids = w->priv;
+
+	sst_find_and_send_pipe_algo(drv, w->name, ids);
+	sst_set_pipe_gain(ids, drv, 0);
+}
+
+static int sst_generic_modules_event(struct snd_soc_dapm_widget *w,
+				     struct snd_kcontrol *k, int event)
+{
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		sst_send_pipe_module_params(w, k);
+	return 0;
+}
+
 static const DECLARE_TLV_DB_SCALE(sst_gain_tlv_common, SST_GAIN_MIN_VALUE * 10, 10, 0);
 
+/* Look up table to convert MIXER SW bit regs to SWM inputs */
+static const uint swm_mixer_input_ids[SST_SWM_INPUT_COUNT] = {
+	[SST_IP_CODEC0]		= SST_SWM_IN_CODEC0,
+	[SST_IP_CODEC1]		= SST_SWM_IN_CODEC1,
+	[SST_IP_LOOP0]		= SST_SWM_IN_SPROT_LOOP,
+	[SST_IP_LOOP1]		= SST_SWM_IN_MEDIA_LOOP1,
+	[SST_IP_LOOP2]		= SST_SWM_IN_MEDIA_LOOP2,
+	[SST_IP_PCM0]		= SST_SWM_IN_PCM0,
+	[SST_IP_PCM1]		= SST_SWM_IN_PCM1,
+	[SST_IP_MEDIA0]		= SST_SWM_IN_MEDIA0,
+	[SST_IP_MEDIA1]		= SST_SWM_IN_MEDIA1,
+	[SST_IP_MEDIA2]		= SST_SWM_IN_MEDIA2,
+	[SST_IP_MEDIA3]		= SST_SWM_IN_MEDIA3,
+};
+static void sst_set_pipe_gain(struct sst_ids *ids, struct sst_data *drv, int mute)
+{
+	struct sst_gain_mixer_control *mc;
+	struct sst_gain_value *gv;
+	struct sst_module *gain = NULL;
+
+	list_for_each_entry(gain, &ids->gain_list, node) {
+		struct snd_kcontrol *kctl = gain->kctl;
+
+		pr_debug("control name=%s\n", kctl->id.name);
+		mc = (void *)kctl->private_value;
+		gv = mc->gain_val;
+
+		sst_send_gain_cmd(drv, gv, mc->task_id,
+				mc->pipe_id | mc->instance_id, mc->module_id, mute);
+	}
+}
+void sst_handle_vb_timer(struct snd_soc_dai *dai, bool enable)
+{
+	struct sst_cmd_generic cmd;
+	struct sst_data *drv = snd_soc_dai_get_drvdata(dai);
+	static int timer_usage;
+
+	if (enable)
+		cmd.header.command_id = SBA_VB_START;
+	else
+		cmd.header.command_id = SBA_IDLE;
+	pr_debug("%s: enable=%u, usage=%d\n", __func__, enable, timer_usage);
+
+	SST_FILL_DEFAULT_DESTINATION(cmd.header.dst);
+	cmd.header.length = 0;
+
+	if (enable)
+		sst->ops->power(sst->dev, true);
+
+	mutex_lock(&drv->lock);
+	if (enable)
+		timer_usage++;
+	else
+		timer_usage--;
+
+	/* Send the command only if this call is the first enable or last
+	 * disable
+	 */
+	if ((enable && (timer_usage == 1)) ||
+	    (!enable && (timer_usage == 0)))
+		sst_fill_and_send_cmd_unlocked(drv, SST_IPC_IA_CMD, SST_FLAG_BLOCKED,
+				      SST_TASK_SBA, 0, &cmd,
+				      sizeof(cmd.header) + cmd.header.length);
+	mutex_unlock(&drv->lock);
+
+	if (!enable)
+		sst->ops->power(sst->dev, false);
+}
+
+/**
+ * sst_ssp_config - contains SSP configuration for media UC
+ */
+static const struct sst_ssp_config sst_ssp_configs = {
+	.ssp_id = SSP_CODEC,
+	.bits_per_slot = 24,
+	.slots = 4,
+	.ssp_mode = SSP_MODE_MASTER,
+	.pcm_mode = SSP_PCM_MODE_NETWORK,
+	.duplex = SSP_DUPLEX,
+	.ssp_protocol = SSP_MODE_PCM,
+	.fs_width = 1,
+	.fs_frequency = SSP_FS_48_KHZ,
+	.active_slot_map = 0xF,
+	.start_delay = 0,
+};
+
+void send_ssp_cmd(struct snd_soc_dai *dai, const char *id, bool enable)
+{
+	struct sst_cmd_sba_hw_set_ssp cmd;
+	struct sst_data *drv = snd_soc_dai_get_drvdata(dai);
+	const struct sst_ssp_config *config;
+
+	pr_err("Enter:%s, enable=%d port_name=%s\n", __func__, enable, id);
+
+	SST_FILL_DEFAULT_DESTINATION(cmd.header.dst);
+	cmd.header.command_id = SBA_HW_SET_SSP;
+	cmd.header.length = sizeof(struct sst_cmd_sba_hw_set_ssp)
+				- sizeof(struct sst_dsp_header);
+
+	config = &sst_ssp_configs;
+	pr_debug("%s: ssp_id: %u\n", __func__, config->ssp_id);
+
+	if (enable)
+		cmd.switch_state = SST_SWITCH_ON;
+	else
+		cmd.switch_state = SST_SWITCH_OFF;
+
+	cmd.selection = config->ssp_id;
+	cmd.nb_bits_per_slots = config->bits_per_slot;
+	cmd.nb_slots = config->slots;
+	cmd.mode = config->ssp_mode | (config->pcm_mode << 1);
+	cmd.duplex = config->duplex;
+	cmd.active_tx_slot_map = config->active_slot_map;
+	cmd.active_rx_slot_map = config->active_slot_map;
+	cmd.frame_sync_frequency = config->fs_frequency;
+	cmd.frame_sync_polarity = SSP_FS_ACTIVE_HIGH;
+	cmd.data_polarity = 1;
+	cmd.frame_sync_width = config->fs_width;
+	cmd.ssp_protocol = config->ssp_protocol;
+	cmd.start_delay = config->start_delay;
+	cmd.reserved1 = cmd.reserved2 = 0xFF;
+
+	sst_fill_and_send_cmd(drv, SST_IPC_IA_CMD, SST_FLAG_BLOCKED,
+				SST_TASK_SBA, 0, &cmd,
+				sizeof(cmd.header) + cmd.header.length);
+}
+
+static int sst_set_be_modules(struct snd_soc_dapm_widget *w,
+			 struct snd_kcontrol *k, int event)
+{
+	struct snd_soc_platform *platform =  snd_soc_kcontrol_platform(k);
+	struct sst_data *drv = snd_soc_platform_get_drvdata(platform);
+
+	pr_debug("Enter: %s, widget=%s\n", __func__, w->name);
+
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		sst_send_slot_map(drv);
+		sst_send_pipe_module_params(w, k);
+	}
+	return 0;
+}
+
+static int sst_set_media_path(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *k, int event)
+{
+	struct sst_cmd_set_media_path cmd;
+	struct snd_soc_platform *platform =  snd_soc_kcontrol_platform(k);
+	struct sst_data *drv = snd_soc_platform_get_drvdata(platform);
+	struct sst_ids *ids = w->priv;
+
+	pr_debug("%s: widget=%s\n", __func__, w->name);
+	pr_debug("%s: task=%u, location=%#x\n", __func__,
+				ids->task_id, ids->location_id);
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		cmd.switch_state = SST_PATH_ON;
+	else
+		cmd.switch_state = SST_PATH_OFF;
+
+	SST_FILL_DESTINATION(2, cmd.header.dst,
+			     ids->location_id, SST_DEFAULT_MODULE_ID);
+
+	/* MMX_SET_MEDIA_PATH == SBA_SET_MEDIA_PATH */
+	cmd.header.command_id = MMX_SET_MEDIA_PATH;
+	cmd.header.length = sizeof(struct sst_cmd_set_media_path)
+				- sizeof(struct sst_dsp_header);
+
+	sst_fill_and_send_cmd(drv, SST_IPC_IA_CMD, SST_FLAG_BLOCKED,
+			      ids->task_id, 0, &cmd,
+			      sizeof(cmd.header) + cmd.header.length);
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		sst_send_pipe_module_params(w, k);
+	return 0;
+}
+
+static int sst_set_media_loop(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+{
+	struct sst_cmd_sba_set_media_loop_map cmd;
+	struct snd_soc_platform *platform =  snd_soc_kcontrol_platform(k);
+	struct sst_data *drv = snd_soc_platform_get_drvdata(platform);
+	struct sst_ids *ids = w->priv;
+
+	pr_debug("Enter:%s, widget=%s\n", __func__, w->name);
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		cmd.switch_state = SST_SWITCH_ON;
+	else
+		cmd.switch_state = SST_SWITCH_OFF;
+
+	SST_FILL_DESTINATION(2, cmd.header.dst,
+			     ids->location_id, SST_DEFAULT_MODULE_ID);
+
+	cmd.header.command_id = SBA_SET_MEDIA_LOOP_MAP;
+	cmd.header.length = sizeof(struct sst_cmd_sba_set_media_loop_map)
+				 - sizeof(struct sst_dsp_header);
+	cmd.param.part.cfg.rate = 2; /* 48khz */
+
+	cmd.param.part.cfg.format = ids->format; /* stereo/Mono */
+	cmd.param.part.cfg.s_length = 1; /* 24bit left justified*/
+	cmd.map = 0; /* Algo sequence: Gain - DRP - FIR - IIR  */
+
+	sst_fill_and_send_cmd(drv, SST_IPC_IA_CMD, SST_FLAG_BLOCKED,
+			      SST_TASK_SBA, 0, &cmd,
+			      sizeof(cmd.header) + cmd.header.length);
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		sst_send_pipe_module_params(w, k);
+	return 0;
+}
+
+static const char * const slot_names[] = {
+	"none",
+	"slot 0", "slot 1", "slot 2", "slot 3",
+	"slot 4", "slot 5", "slot 6", "slot 7", /* not supported by FW */
+};
+
+static const char * const channel_names[] = {
+	"none",
+	"codec_out0_0", "codec_out0_1", "codec_out1_0", "codec_out1_1",
+	"codec_out2_0", "codec_out2_1", "codec_out3_0", "codec_out3_1", /* not supported by FW */
+};
+
+#define SST_INTERLEAVER(xpname, slot_name, slotno) \
+	SST_SSP_SLOT_CTL(xpname, "interleaver", slot_name, slotno, true, \
+			 channel_names, sst_slot_get, sst_slot_put)
+
+#define SST_DEINTERLEAVER(xpname, channel_name, channel_no) \
+	SST_SSP_SLOT_CTL(xpname, "deinterleaver", channel_name, channel_no, false, \
+			 slot_names, sst_slot_get, sst_slot_put)
+
+static const struct snd_kcontrol_new sst_slot_controls[] = {
+	SST_INTERLEAVER("codec_out", "slot 0", 0),
+	SST_INTERLEAVER("codec_out", "slot 1", 1),
+	SST_INTERLEAVER("codec_out", "slot 2", 2),
+	SST_INTERLEAVER("codec_out", "slot 3", 3),
+	SST_DEINTERLEAVER("codec_in", "codec_in0_0", 0),
+	SST_DEINTERLEAVER("codec_in", "codec_in0_1", 1),
+	SST_DEINTERLEAVER("codec_in", "codec_in1_0", 2),
+	SST_DEINTERLEAVER("codec_in", "codec_in1_1", 3),
+};
+
 /* Gain helper with min/max set */
 #define SST_GAIN(name, path_id, task_id, instance, gain_var)				\
 	SST_GAIN_KCONTROLS(name, "gain", SST_GAIN_MIN_VALUE, SST_GAIN_MAX_VALUE,	\
@@ -350,6 +780,204 @@ static const struct snd_kcontrol_new sst_algo_controls[] = {
 
 };
 
+static inline bool is_sst_dapm_widget(struct snd_soc_dapm_widget *w)
+{
+	if ((w->id == snd_soc_dapm_pga) ||
+	    (w->id == snd_soc_dapm_aif_in) ||
+	    (w->id == snd_soc_dapm_aif_out) ||
+	    (w->id == snd_soc_dapm_input) ||
+	    (w->id == snd_soc_dapm_output) ||
+	    (w->id == snd_soc_dapm_mixer))
+		return true;
+	else
+		return false;
+}
+
+/**
+ * sst_send_pipe_gains - send gains for the front-end DAIs
+ *
+ * The gains in the pipes connected to the front-ends are muted/unmuted
+ * automatically via the digital_mute() DAPM callback. This function sends the
+ * gains for the front-end pipes.
+ */
+int sst_send_pipe_gains(struct snd_soc_dai *dai, int stream, int mute)
+{
+	struct sst_data *drv = snd_soc_dai_get_drvdata(dai);
+	struct snd_soc_dapm_widget *w;
+	struct snd_soc_dapm_path *p = NULL;
+
+	pr_debug("%s: enter, dai-name=%s dir=%d\n", __func__, dai->name, stream);
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		pr_debug("Stream name=%s\n", dai->playback_widget->name);
+		w = dai->playback_widget;
+		list_for_each_entry(p, &w->sinks, list_source) {
+			if (p->connected && !p->connected(w, p->sink))
+				continue;
+
+			if (p->connect && p->sink->power && is_sst_dapm_widget(p->sink)) {
+				struct sst_ids *ids = p->sink->priv;
+
+				pr_debug("send gains for widget=%s\n", p->sink->name);
+				sst_set_pipe_gain(ids, drv, mute);
+			}
+		}
+	} else {
+		pr_debug("Stream name=%s\n", dai->capture_widget->name);
+		w = dai->capture_widget;
+		list_for_each_entry(p, &w->sources, list_sink) {
+			if (p->connected && !p->connected(w, p->sink))
+				continue;
+
+			if (p->connect &&  p->source->power && is_sst_dapm_widget(p->source)) {
+				struct sst_ids *ids = p->source->priv;
+
+				pr_debug("send gain for widget=%s\n", p->source->name);
+				sst_set_pipe_gain(ids, drv, mute);
+			}
+		}
+	}
+	return 0;
+}
+
+/**
+ * sst_fill_module_list - populate the list of modules/gains for a pipe
+ *
+ *
+ * Fills the widget pointer in the kcontrol private data, and also fills the
+ * kcontrol pointer in the widget private data.
+ *
+ * Widget pointer is used to send the algo/gain in the .put() handler if the
+ * widget is powerd on.
+ *
+ * Kcontrol pointer is used to send the algo/gain in the widget power ON/OFF
+ * event handler. Each widget (pipe) has multiple algos stored in the algo_list.
+ */
+static int sst_fill_module_list(struct snd_kcontrol *kctl,
+	 struct snd_soc_dapm_widget *w, int type)
+{
+	struct sst_module *module = NULL;
+	struct snd_soc_platform *platform =  snd_soc_kcontrol_platform(kctl);
+	struct sst_ids *ids = w->priv;
+
+	module = devm_kzalloc(platform->dev, sizeof(*module), GFP_KERNEL);
+	if (!module)
+		return -ENOMEM;
+
+	if (type == SST_MODULE_GAIN) {
+		struct sst_gain_mixer_control *mc = (void *)kctl->private_value;
+
+		mc->w = w;
+		module->kctl = kctl;
+		list_add_tail(&module->node, &ids->gain_list);
+	} else if (type == SST_MODULE_ALGO) {
+		struct sst_algo_control *bc = (void *)kctl->private_value;
+
+		bc->w = w;
+		module->kctl = kctl;
+		list_add_tail(&module->node, &ids->algo_list);
+	}
+
+	return 0;
+}
+
+/**
+ * sst_fill_widget_module_info - fill list of gains/algos for the pipe
+ * @widget:	pipe modelled as a DAPM widget
+ *
+ * Fill the list of gains/algos for the widget by looking at all the card
+ * controls and comparing the name of the widget with the first part of control
+ * name. First part of control name contains the pipe name (widget name).
+ */
+static int sst_fill_widget_module_info(struct snd_soc_dapm_widget *w,
+	struct snd_soc_platform *platform)
+{
+	struct snd_kcontrol *kctl;
+	int index, ret = 0;
+	struct snd_card *card = platform->component.card->snd_card;
+	char *idx;
+
+	down_read(&card->controls_rwsem);
+
+	list_for_each_entry(kctl, &card->controls, list) {
+		idx = strstr(kctl->id.name, " ");
+		if (idx == NULL)
+			continue;
+		index  = strlen(kctl->id.name) - strlen(idx);
+		if (strstr(kctl->id.name, "volume") &&
+		    !strncmp(kctl->id.name, w->name, index))
+			ret = sst_fill_module_list(kctl, w, SST_MODULE_GAIN);
+		else if (strstr(kctl->id.name, "params") &&
+			 !strncmp(kctl->id.name, w->name, index))
+			ret = sst_fill_module_list(kctl, w, SST_MODULE_ALGO);
+		else if (strstr(kctl->id.name, "mute") &&
+			 !strncmp(kctl->id.name, w->name, index)) {
+			struct sst_gain_mixer_control *mc = (void *)kctl->private_value;
+
+			mc->w = w;
+		} else if (strstr(kctl->id.name, "interleaver") &&
+			 !strncmp(kctl->id.name, w->name, index)) {
+			struct sst_enum *e = (void *)kctl->private_value;
+
+			e->w = w;
+		} else if (strstr(kctl->id.name, "deinterleaver") &&
+			 !strncmp(kctl->id.name, w->name, index)) {
+
+			struct sst_enum *e = (void *)kctl->private_value;
+
+			e->w = w;
+		}
+		if (ret < 0) {
+			up_read(&card->controls_rwsem);
+			return ret;
+		}
+	}
+	up_read(&card->controls_rwsem);
+	return 0;
+}
+
+/**
+ * sst_fill_linked_widgets - fill the parent pointer for the linked widget
+ */
+static void sst_fill_linked_widgets(struct snd_soc_platform *platform,
+						struct sst_ids *ids)
+{
+	struct snd_soc_dapm_widget *w;
+	unsigned int len = strlen(ids->parent_wname);
+
+	list_for_each_entry(w, &platform->component.card->widgets, list) {
+		if (!strncmp(ids->parent_wname, w->name, len)) {
+			ids->parent_w = w;
+			break;
+		}
+	}
+}
+
+/**
+ * sst_map_modules_to_pipe - fill algo/gains list for all pipes
+ */
+static int sst_map_modules_to_pipe(struct snd_soc_platform *platform)
+{
+	struct snd_soc_dapm_widget *w;
+	int ret = 0;
+
+	list_for_each_entry(w, &platform->component.card->widgets, list) {
+		if (platform && is_sst_dapm_widget(w) && (w->priv)) {
+			struct sst_ids *ids = w->priv;
+
+			pr_debug("widget type=%d name=%s\n", w->id, w->name);
+			INIT_LIST_HEAD(&ids->algo_list);
+			INIT_LIST_HEAD(&ids->gain_list);
+			ret = sst_fill_widget_module_info(w, platform);
+			if (ret < 0)
+				return ret;
+			/* fill linked widgets */
+			if (ids->parent_wname !=  NULL)
+				sst_fill_linked_widgets(platform, ids);
+		}
+	}
+	return 0;
+}
 int sst_dsp_init_v2_dpcm(struct snd_soc_platform *platform)
 {
 	int i, ret = 0;
@@ -373,5 +1001,10 @@ int sst_dsp_init_v2_dpcm(struct snd_soc_platform *platform)
 
 	snd_soc_add_platform_controls(platform, sst_algo_controls,
 			ARRAY_SIZE(sst_algo_controls));
+	snd_soc_add_platform_controls(platform, sst_slot_controls,
+			ARRAY_SIZE(sst_slot_controls));
+
+	ret = sst_map_modules_to_pipe(platform);
+
 	return ret;
 }
diff --git a/sound/soc/intel/sst-atom-controls.h b/sound/soc/intel/sst-atom-controls.h
index 6e2062fda36f..cfbfb1ced27d 100644
--- a/sound/soc/intel/sst-atom-controls.h
+++ b/sound/soc/intel/sst-atom-controls.h
@@ -361,6 +361,38 @@ struct sst_cmd_generic {
 	struct sst_dsp_header header;
 } __packed;
 
+struct swm_input_ids {
+	struct sst_destination_id input_id;
+} __packed;
+
+struct sst_cmd_set_swm {
+	struct sst_dsp_header header;
+	struct sst_destination_id output_id;
+	u16    switch_state;
+	u16    nb_inputs;
+	struct swm_input_ids input[SST_CMD_SWM_MAX_INPUTS];
+} __packed;
+
+struct sst_cmd_set_media_path {
+	struct sst_dsp_header header;
+	u16    switch_state;
+} __packed;
+
+struct pcm_cfg {
+		u8 s_length:2;
+		u8 rate:3;
+		u8 format:3;
+} __packed;
+
+struct sst_cmd_set_speech_path {
+	struct sst_dsp_header header;
+	u16    switch_state;
+	struct {
+		u16 rsvd:8;
+		struct pcm_cfg cfg;
+	} config;
+} __packed;
+
 struct gain_cell {
 	struct sst_destination_id dest;
 	s16 cell_gain_left;
@@ -379,10 +411,166 @@ struct sst_cmd_set_params {
 	u16 command_id;
 	char params[0];
 } __packed;
+
+
+struct sst_cmd_sba_vb_start {
+	struct sst_dsp_header header;
+} __packed;
+
+union sba_media_loop_params {
+	struct {
+		u16 rsvd:8;
+		struct pcm_cfg cfg;
+	} part;
+	u16 full;
+} __packed;
+
+struct sst_cmd_sba_set_media_loop_map {
+	struct	sst_dsp_header header;
+	u16	switch_state;
+	union	sba_media_loop_params param;
+	u16	map;
+} __packed;
+
+struct sst_cmd_tone_stop {
+	struct	sst_dsp_header header;
+	u16	switch_state;
+} __packed;
+
+enum sst_ssp_mode {
+	SSP_MODE_MASTER = 0,
+	SSP_MODE_SLAVE = 1,
+};
+
+enum sst_ssp_pcm_mode {
+	SSP_PCM_MODE_NORMAL = 0,
+	SSP_PCM_MODE_NETWORK = 1,
+};
+
+enum sst_ssp_duplex {
+	SSP_DUPLEX = 0,
+	SSP_RX = 1,
+	SSP_TX = 2,
+};
+
+enum sst_ssp_fs_frequency {
+	SSP_FS_8_KHZ = 0,
+	SSP_FS_16_KHZ = 1,
+	SSP_FS_44_1_KHZ = 2,
+	SSP_FS_48_KHZ = 3,
+};
+
+enum sst_ssp_fs_polarity {
+	SSP_FS_ACTIVE_LOW = 0,
+	SSP_FS_ACTIVE_HIGH = 1,
+};
+
+enum sst_ssp_protocol {
+	SSP_MODE_PCM = 0,
+	SSP_MODE_I2S = 1,
+};
+
+enum sst_ssp_port_id {
+	SSP_MODEM = 0,
+	SSP_BT = 1,
+	SSP_FM = 2,
+	SSP_CODEC = 3,
+};
+
+struct sst_cmd_sba_hw_set_ssp {
+	struct sst_dsp_header header;
+	u16 selection;			/* 0:SSP0(def), 1:SSP1, 2:SSP2 */
+
+	u16 switch_state;
+
+	u16 nb_bits_per_slots:6;        /* 0-32 bits, 24 (def) */
+	u16 nb_slots:4;			/* 0-8: slots per frame  */
+	u16 mode:3;			/* 0:Master, 1: Slave  */
+	u16 duplex:3;
+
+	u16 active_tx_slot_map:8;       /* Bit map, 0:off, 1:on */
+	u16 reserved1:8;
+
+	u16 active_rx_slot_map:8;       /* Bit map 0: Off, 1:On */
+	u16 reserved2:8;
+
+	u16 frame_sync_frequency;
+
+	u16 frame_sync_polarity:8;
+	u16 data_polarity:8;
+
+	u16 frame_sync_width;           /* 1 to N clocks */
+	u16 ssp_protocol:8;
+	u16 start_delay:8;		/* Start delay in terms of clock ticks */
+} __packed;
+
+#define SST_MAX_TDM_SLOTS 8
+
+struct sst_param_sba_ssp_slot_map {
+	struct sst_dsp_header header;
+
+	u16 param_id;
+	u16 param_len;
+	u16 ssp_index;
+
+	u8 rx_slot_map[SST_MAX_TDM_SLOTS];
+	u8 tx_slot_map[SST_MAX_TDM_SLOTS];
+} __packed;
+
+enum {
+	SST_PROBE_EXTRACTOR = 0,
+	SST_PROBE_INJECTOR = 1,
+};
+
 /**** widget defines *****/
 
 #include <sound/soc.h>
 #include <sound/tlv.h>
+
+#define SST_MODULE_GAIN 1
+#define SST_MODULE_ALGO 2
+
+#define SST_FMT_MONO 0
+#define SST_FMT_STEREO 3
+
+/* physical SSP numbers */
+enum {
+	SST_SSP0 = 0,
+	SST_SSP1,
+	SST_SSP2,
+	SST_SSP_LAST = SST_SSP2,
+};
+
+#define SST_NUM_SSPS		(SST_SSP_LAST + 1)	/* physical SSPs */
+#define SST_MAX_SSP_MUX		2			/* single SSP muxed between pipes */
+#define SST_MAX_SSP_DOMAINS	2			/* domains present in each pipe */
+
+struct sst_module {
+	struct snd_kcontrol *kctl;
+	struct list_head node;
+};
+
+struct sst_ssp_config {
+	u8 ssp_id;
+	u8 bits_per_slot;
+	u8 slots;
+	u8 ssp_mode;
+	u8 pcm_mode;
+	u8 duplex;
+	u8 ssp_protocol;
+	u8 fs_frequency;
+	u8 active_slot_map;
+	u8 start_delay;
+	u16 fs_width;
+};
+
+struct sst_ssp_cfg {
+	const u8 ssp_number;
+	const int *mux_shift;
+	const int (*domain_shift)[SST_MAX_SSP_MUX];
+	const struct sst_ssp_config (*ssp_config)[SST_MAX_SSP_MUX][SST_MAX_SSP_DOMAINS];
+};
+
 struct sst_ids {
 	u16 location_id;
 	u16 module_id;
@@ -395,6 +583,102 @@ struct sst_ids {
 	struct list_head gain_list;
 	const struct sst_pcm_format *pcm_fmt;
 };
+
+
+#define SST_AIF_IN(wname, wevent)							\
+{	.id = snd_soc_dapm_aif_in, .name = wname, .sname = NULL,			\
+	.reg = SND_SOC_NOPM, .shift = 0,					\
+	.on_val = 1, .off_val = 0,							\
+	.event = wevent, .event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD,	\
+	.priv = (void *)&(struct sst_ids) { .task_id = 0, .location_id = 0 }		\
+}
+
+#define SST_AIF_OUT(wname, wevent)							\
+{	.id = snd_soc_dapm_aif_out, .name = wname, .sname = NULL,			\
+	.reg = SND_SOC_NOPM, .shift = 0,						\
+	.on_val = 1, .off_val = 0,							\
+	.event = wevent, .event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD,	\
+	.priv = (void *)&(struct sst_ids) { .task_id = 0, .location_id = 0 }		\
+}
+
+#define SST_INPUT(wname, wevent)							\
+{	.id = snd_soc_dapm_input, .name = wname, .sname = NULL,				\
+	.reg = SND_SOC_NOPM, .shift = 0,						\
+	.on_val = 1, .off_val = 0,							\
+	.event = wevent, .event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD,	\
+	.priv = (void *)&(struct sst_ids) { .task_id = 0, .location_id = 0 }		\
+}
+
+#define SST_OUTPUT(wname, wevent)							\
+{	.id = snd_soc_dapm_output, .name = wname, .sname = NULL,			\
+	.reg = SND_SOC_NOPM, .shift = 0,						\
+	.on_val = 1, .off_val = 0,							\
+	.event = wevent, .event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD,	\
+	.priv = (void *)&(struct sst_ids) { .task_id = 0, .location_id = 0 }		\
+}
+
+#define SST_DAPM_OUTPUT(wname, wloc_id, wtask_id, wformat, wevent)                      \
+{	.id = snd_soc_dapm_output, .name = wname, .sname = NULL,                        \
+	.reg = SND_SOC_NOPM, .shift = 0,						\
+	.on_val = 1, .off_val = 0,							\
+	.event = wevent, .event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD,   \
+	.priv = (void *)&(struct sst_ids) { .location_id = wloc_id, .task_id = wtask_id,\
+						.pcm_fmt = wformat, }			\
+}
+
+#define SST_PATH(wname, wtask, wloc_id, wevent, wflags)					\
+{	.id = snd_soc_dapm_pga, .name = wname, .reg = SND_SOC_NOPM, .shift = 0,		\
+	.kcontrol_news = NULL, .num_kcontrols = 0,				\
+	.on_val = 1, .off_val = 0,							\
+	.event = wevent, .event_flags = wflags,						\
+	.priv = (void *)&(struct sst_ids) { .task_id = wtask, .location_id = wloc_id, }	\
+}
+
+#define SST_LINKED_PATH(wname, wtask, wloc_id, linked_wname, wevent, wflags)		\
+{	.id = snd_soc_dapm_pga, .name = wname, .reg = SND_SOC_NOPM, .shift = 0,		\
+	.kcontrol_news = NULL, .num_kcontrols = 0,				\
+	.on_val = 1, .off_val = 0,							\
+	.event = wevent, .event_flags = wflags,						\
+	.priv = (void *)&(struct sst_ids) { .task_id = wtask, .location_id = wloc_id,	\
+					.parent_wname = linked_wname}			\
+}
+
+#define SST_PATH_MEDIA_LOOP(wname, wtask, wloc_id, wformat, wevent, wflags)             \
+{	.id = snd_soc_dapm_pga, .name = wname, .reg = SND_SOC_NOPM, .shift = 0,         \
+	.kcontrol_news = NULL, .num_kcontrols = 0,                         \
+	.event = wevent, .event_flags = wflags,                                         \
+	.priv = (void *)&(struct sst_ids) { .task_id = wtask, .location_id = wloc_id,	\
+					    .format = wformat,}				\
+}
+
+/* output is triggered before input */
+#define SST_PATH_INPUT(name, task_id, loc_id, event)					\
+	SST_PATH(name, task_id, loc_id, event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD)
+
+#define SST_PATH_LINKED_INPUT(name, task_id, loc_id, linked_wname, event)		\
+	SST_LINKED_PATH(name, task_id, loc_id, linked_wname, event,			\
+					SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD)
+
+#define SST_PATH_OUTPUT(name, task_id, loc_id, event)					\
+	SST_PATH(name, task_id, loc_id, event, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD)
+
+#define SST_PATH_LINKED_OUTPUT(name, task_id, loc_id, linked_wname, event)		\
+	SST_LINKED_PATH(name, task_id, loc_id, linked_wname, event,			\
+					SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD)
+
+#define SST_PATH_MEDIA_LOOP_OUTPUT(name, task_id, loc_id, format, event)		\
+	SST_PATH_MEDIA_LOOP(name, task_id, loc_id, format, event, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD)
+
+
+#define SST_SWM_MIXER(wname, wreg, wtask, wloc_id, wcontrols, wevent)			\
+{	.id = snd_soc_dapm_mixer, .name = wname, .reg = SND_SOC_NOPM, .shift = 0,	\
+	.kcontrol_news = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols),\
+	.event = wevent, .event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD |	\
+					SND_SOC_DAPM_POST_REG,				\
+	.priv = (void *)&(struct sst_ids) { .task_id = wtask, .location_id = wloc_id,	\
+					    .reg = wreg }				\
+}
+
 enum sst_gain_kcontrol_type {
 	SST_GAIN_TLV,
 	SST_GAIN_MUTE,
@@ -558,4 +842,29 @@ struct sst_enum {
 	struct snd_soc_dapm_widget *w;
 };
 
+/* only 4 slots/channels supported atm */
+#define SST_SSP_SLOT_ENUM(s_ch_no, is_tx, xtexts) \
+	(struct sst_enum){ .reg = s_ch_no, .tx = is_tx, .max = 4+1, .texts = xtexts, }
+
+#define SST_SLOT_CTL_NAME(xpname, xmname, s_ch_name) \
+	xpname " " xmname " " s_ch_name
+
+#define SST_SSP_SLOT_CTL(xpname, xmname, s_ch_name, s_ch_no, is_tx, xtexts, xget, xput) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = SST_SLOT_CTL_NAME(xpname, xmname, s_ch_name), \
+	.info = sst_slot_enum_info, \
+	.get = xget, .put = xput, \
+	.private_value = (unsigned long)&SST_SSP_SLOT_ENUM(s_ch_no, is_tx, xtexts), \
+}
+
+#define SST_MUX_CTL_NAME(xpname, xinstance) \
+	xpname " " #xinstance
+
+#define SST_SSP_MUX_ENUM(xreg, xshift, xtexts) \
+	(struct soc_enum) SOC_ENUM_DOUBLE(xreg, xshift, xshift, ARRAY_SIZE(xtexts), xtexts)
+
+#define SST_SSP_MUX_CTL(xpname, xinstance, xreg, xshift, xtexts) \
+	SOC_DAPM_ENUM(SST_MUX_CTL_NAME(xpname, xinstance), \
+			  SST_SSP_MUX_ENUM(xreg, xshift, xtexts))
+
 #endif
-- 
1.9.0
