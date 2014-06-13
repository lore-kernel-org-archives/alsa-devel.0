From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 17/19] ASoC: InteL;
	mrfld: add the DSP DAPM widgets
Date: Fri, 13 Jun 2014 18:04:06 +0530
Message-ID: <1402662848-24534-18-git-send-email-vinod.koul@intel.com>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E9E2261A38
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 14:33:23 +0200 (CEST)
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

This patchs adds all DAPM widgets and the event handlers for DSP expect the
mixers. Since we are still discussing mixer update and is dependent upon
component series

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-atom-controls.c |  237 +++++++++++++++++++++++++++++++++++
 sound/soc/intel/sst-mfld-platform.h |    4 +
 2 files changed, 241 insertions(+), 0 deletions(-)

diff --git a/sound/soc/intel/sst-atom-controls.c b/sound/soc/intel/sst-atom-controls.c
index 2938105..2e733f8 100644
--- a/sound/soc/intel/sst-atom-controls.c
+++ b/sound/soc/intel/sst-atom-controls.c
@@ -528,6 +528,161 @@ static const uint swm_mixer_input_ids[SST_SWM_INPUT_COUNT] = {
 	[SST_IP_MEDIA2]		= SST_SWM_IN_MEDIA2,
 	[SST_IP_MEDIA3]		= SST_SWM_IN_MEDIA3,
 };
+
+/**
+ * fill_swm_input - fill in the SWM input ids given the register
+ *
+ * The register value is a bit-field inicated which mixer inputs are ON. Use the
+ * lookup table to get the input-id and fill it in the structure.
+ */
+static int fill_swm_input(struct swm_input_ids *swm_input, unsigned int reg)
+{
+	uint i, is_set, nb_inputs = 0;
+	u16 input_loc_id;
+
+	pr_debug("%s: reg: %#x\n", __func__, reg);
+	for (i = 0; i < SST_SWM_INPUT_COUNT; i++) {
+		is_set = reg & BIT(i);
+		if (!is_set)
+			continue;
+
+		input_loc_id = swm_mixer_input_ids[i];
+		SST_FILL_DESTINATION(2, swm_input->input_id,
+				     input_loc_id, SST_DEFAULT_MODULE_ID);
+		nb_inputs++;
+		swm_input++;
+		pr_debug("input id: %#x, nb_inputs: %d\n", input_loc_id, nb_inputs);
+
+		if (nb_inputs == SST_CMD_SWM_MAX_INPUTS) {
+			pr_warn("%s: SET_SWM cmd max inputs reached", __func__);
+			break;
+		}
+	}
+	return nb_inputs;
+}
+
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
+
+static int sst_swm_mixer_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+{
+	struct sst_cmd_set_swm cmd;
+	struct sst_data *drv = snd_soc_platform_get_drvdata(w->platform);
+	struct sst_ids *ids = w->priv;
+	bool set_mixer = false;
+	int val = drv->widget[ids->reg];
+
+	pr_debug("%s: widget = %s\n", __func__, w->name);
+	pr_debug("%s: reg[%d] = %#x\n", __func__, ids->reg, val);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+	case SND_SOC_DAPM_POST_PMD:
+		set_mixer = true;
+		break;
+	case SND_SOC_DAPM_POST_REG:
+		if (w->power)
+			set_mixer = true;
+		break;
+	default:
+		set_mixer = false;
+	}
+
+	if (set_mixer == false)
+		return 0;
+
+	if (SND_SOC_DAPM_EVENT_ON(event) ||
+	    event == SND_SOC_DAPM_POST_REG)
+		cmd.switch_state = SST_SWM_ON;
+	else
+		cmd.switch_state = SST_SWM_OFF;
+
+	SST_FILL_DEFAULT_DESTINATION(cmd.header.dst);
+	/* MMX_SET_SWM == SBA_SET_SWM */
+	cmd.header.command_id = SBA_SET_SWM;
+
+	SST_FILL_DESTINATION(2, cmd.output_id,
+			     ids->location_id, SST_DEFAULT_MODULE_ID);
+	cmd.nb_inputs =	fill_swm_input(&cmd.input[0], val);
+	cmd.header.length = offsetof(struct sst_cmd_set_swm, input) - sizeof(struct sst_dsp_header)
+				+ (cmd.nb_inputs * sizeof(cmd.input[0]));
+
+	sst_fill_and_send_cmd(drv, SST_IPC_IA_CMD, SST_FLAG_BLOCKED,
+			      ids->task_id, 0, &cmd,
+			      sizeof(cmd.header) + cmd.header.length);
+	return 0;
+}
+
+/* SBA mixers - 16 inputs */
+#define SST_SBA_DECLARE_MIX_CONTROLS(kctl_name, mixer_reg)			\
+	static const struct snd_kcontrol_new kctl_name[] = {			\
+		SOC_SINGLE_EXT("codec_in0", mixer_reg, SST_IP_CODEC0, 1, 0,	\
+				sst_mix_get, sst_mix_put),			\
+		SOC_SINGLE_EXT("codec_in1", mixer_reg, SST_IP_CODEC1, 1, 0,	\
+				sst_mix_get, sst_mix_put),			\
+		SOC_SINGLE_EXT("sprot_loop_in", mixer_reg, SST_IP_LOOP0, 1, 0,	\
+				sst_mix_get, sst_mix_put),			\
+		SOC_SINGLE_EXT("media_loop1_in", mixer_reg, SST_IP_LOOP1, 1, 0,	\
+				sst_mix_get, sst_mix_put),			\
+		SOC_SINGLE_EXT("media_loop2_in", mixer_reg, SST_IP_LOOP2, 1, 0,	\
+				sst_mix_get, sst_mix_put),			\
+		SOC_SINGLE_EXT("pcm0_in", mixer_reg, SST_IP_PCM0, 1, 0,		\
+				sst_mix_get, sst_mix_put),			\
+		SOC_SINGLE_EXT("pcm1_in", mixer_reg, SST_IP_PCM1, 1, 0,		\
+				sst_mix_get, sst_mix_put),			\
+	}
+
+#define SST_SBA_MIXER_GRAPH_MAP(mix_name)			\
+	{ mix_name, "codec_in0",	"codec_in0" },		\
+	{ mix_name, "codec_in1",	"codec_in1" },		\
+	{ mix_name, "sprot_loop_in",	"sprot_loop_in" },	\
+	{ mix_name, "media_loop1_in",	"media_loop1_in" },	\
+	{ mix_name, "media_loop2_in",	"media_loop2_in" },	\
+	{ mix_name, "pcm0_in",		"pcm0_in" },		\
+	{ mix_name, "pcm1_in",		"pcm1_in" }
+
+#define SST_MMX_DECLARE_MIX_CONTROLS(kctl_name, mixer_reg)			\
+	static const struct snd_kcontrol_new kctl_name[] = {			\
+		SOC_SINGLE_EXT("media0_in", mixer_reg, SST_IP_MEDIA0, 1, 0,	\
+				sst_mix_get, sst_mix_put),			\
+		SOC_SINGLE_EXT("media1_in", mixer_reg, SST_IP_MEDIA1, 1, 0,	\
+				sst_mix_get, sst_mix_put),			\
+		SOC_SINGLE_EXT("media2_in", mixer_reg, SST_IP_MEDIA2, 1, 0,	\
+				sst_mix_get, sst_mix_put),			\
+		SOC_SINGLE_EXT("media3_in", mixer_reg, SST_IP_MEDIA3, 1, 0,	\
+				sst_mix_get, sst_mix_put),			\
+	}
+
+SST_MMX_DECLARE_MIX_CONTROLS(sst_mix_media0_controls, SST_MIX_MEDIA0);
+SST_MMX_DECLARE_MIX_CONTROLS(sst_mix_media1_controls, SST_MIX_MEDIA1);
+
+/* 18 SBA mixers */
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_pcm0_controls, SST_MIX_PCM0);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_pcm1_controls, SST_MIX_PCM1);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_pcm2_controls, SST_MIX_PCM2);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_sprot_l0_controls, SST_MIX_LOOP0);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_media_l1_controls, SST_MIX_LOOP1);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_media_l2_controls, SST_MIX_LOOP2);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_voip_controls, SST_MIX_VOIP);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_codec0_controls, SST_MIX_CODEC0);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_codec1_controls, SST_MIX_CODEC1);
+
 void sst_handle_vb_timer(struct snd_soc_platform *p, bool enable)
 {
 	struct sst_cmd_generic cmd;
@@ -751,6 +906,83 @@ static int sst_set_media_loop(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static const struct snd_soc_dapm_widget sst_dapm_widgets[] = {
+	SST_AIF_IN("codec_in0", sst_set_be_modules),
+	SST_AIF_IN("codec_in1", sst_set_be_modules),
+	SST_AIF_OUT("codec_out0", sst_set_be_modules),
+	SST_AIF_OUT("codec_out1", sst_set_be_modules),
+
+	/* Media Paths */
+	/* MediaX IN paths are set via ALLOC, so no SET_MEDIA_PATH command */
+	SST_PATH_INPUT("media0_in", SST_TASK_MMX, SST_SWM_IN_MEDIA0, sst_generic_modules_event),
+	SST_PATH_INPUT("media1_in", SST_TASK_MMX, SST_SWM_IN_MEDIA1, NULL),
+	SST_PATH_INPUT("media2_in", SST_TASK_MMX, SST_SWM_IN_MEDIA2, sst_set_media_path),
+	SST_PATH_INPUT("media3_in", SST_TASK_MMX, SST_SWM_IN_MEDIA3, NULL),
+	SST_PATH_OUTPUT("media0_out", SST_TASK_MMX, SST_SWM_OUT_MEDIA0, sst_set_media_path),
+	SST_PATH_OUTPUT("media1_out", SST_TASK_MMX, SST_SWM_OUT_MEDIA1, sst_set_media_path),
+
+	/* SBA PCM Paths */
+	SST_PATH_INPUT("pcm0_in", SST_TASK_SBA, SST_SWM_IN_PCM0, sst_set_media_path),
+	SST_PATH_INPUT("pcm1_in", SST_TASK_SBA, SST_SWM_IN_PCM1, sst_set_media_path),
+	SST_PATH_OUTPUT("pcm0_out", SST_TASK_SBA, SST_SWM_OUT_PCM0, sst_set_media_path),
+	SST_PATH_OUTPUT("pcm1_out", SST_TASK_SBA, SST_SWM_OUT_PCM1, sst_set_media_path),
+	SST_PATH_OUTPUT("pcm2_out", SST_TASK_SBA, SST_SWM_OUT_PCM2, sst_set_media_path),
+
+	/* SBA Loops */
+	SST_PATH_INPUT("sprot_loop_in", SST_TASK_SBA, SST_SWM_IN_SPROT_LOOP, NULL),
+	SST_PATH_INPUT("media_loop1_in", SST_TASK_SBA, SST_SWM_IN_MEDIA_LOOP1, NULL),
+	SST_PATH_INPUT("media_loop2_in", SST_TASK_SBA, SST_SWM_IN_MEDIA_LOOP2, NULL),
+	SST_PATH_MEDIA_LOOP_OUTPUT("sprot_loop_out", SST_TASK_SBA, SST_SWM_OUT_SPROT_LOOP, SST_FMT_MONO, sst_set_media_loop),
+	SST_PATH_MEDIA_LOOP_OUTPUT("media_loop1_out", SST_TASK_SBA, SST_SWM_OUT_MEDIA_LOOP1, SST_FMT_MONO, sst_set_media_loop),
+	SST_PATH_MEDIA_LOOP_OUTPUT("media_loop2_out", SST_TASK_SBA, SST_SWM_OUT_MEDIA_LOOP2, SST_FMT_STEREO, sst_set_media_loop),
+
+	/* Media Mixers */
+};
+
+static const struct snd_soc_dapm_route intercon[] = {
+	{"media0_in", NULL, "Compress Playback"},
+	{"media1_in", NULL, "Headset Playback"},
+	{"media2_in", NULL, "pcm0_out"},
+
+	{"media0_out mix 0", "media0_in", "media0_in"},
+	{"media0_out mix 0", "media1_in", "media1_in"},
+	{"media0_out mix 0", "media2_in", "media2_in"},
+	{"media0_out mix 0", "media3_in", "media3_in"},
+	{"media1_out mix 0", "media0_in", "media0_in"},
+	{"media1_out mix 0", "media1_in", "media1_in"},
+	{"media1_out mix 0", "media2_in", "media2_in"},
+	{"media1_out mix 0", "media3_in", "media3_in"},
+
+	{"media0_out", NULL, "media0_out mix 0"},
+	{"media1_out", NULL, "media1_out mix 0"},
+	{"pcm0_in", NULL, "media0_out"},
+	{"pcm1_in", NULL, "media1_out"},
+
+	{"Headset Capture", NULL, "pcm1_out"},
+	{"Headset Capture", NULL, "pcm2_out"},
+	{"pcm0_out", NULL, "pcm0_out mix 0"},
+	SST_SBA_MIXER_GRAPH_MAP("pcm0_out mix 0"),
+	{"pcm1_out", NULL, "pcm1_out mix 0"},
+	SST_SBA_MIXER_GRAPH_MAP("pcm1_out mix 0"),
+	{"pcm2_out", NULL, "pcm2_out mix 0"},
+	SST_SBA_MIXER_GRAPH_MAP("pcm2_out mix 0"),
+
+	{"media_loop1_in", NULL, "media_loop1_out"},
+	{"media_loop1_out", NULL, "media_loop1_out mix 0"},
+	SST_SBA_MIXER_GRAPH_MAP("media_loop1_out mix 0"),
+	{"media_loop2_in", NULL, "media_loop2_out"},
+	{"media_loop2_out", NULL, "media_loop2_out mix 0"},
+	SST_SBA_MIXER_GRAPH_MAP("media_loop2_out mix 0"),
+	{"sprot_loop_in", NULL, "sprot_loop_out"},
+	{"sprot_loop_out", NULL, "sprot_loop_out mix 0"},
+	SST_SBA_MIXER_GRAPH_MAP("sprot_loop_out mix 0"),
+
+	{"codec_out0", NULL, "codec_out0 mix 0"},
+	SST_SBA_MIXER_GRAPH_MAP("codec_out0 mix 0"),
+	{"codec_out1", NULL, "codec_out1 mix 0"},
+	SST_SBA_MIXER_GRAPH_MAP("codec_out1 mix 0"),
+
+};
 static const char * const slot_names[] = {
 	"none",
 	"slot 0", "slot 1", "slot 2", "slot 3",
@@ -1060,6 +1292,11 @@ int sst_dsp_init_v2_dpcm(struct snd_soc_platform *platform)
 		return -ENOMEM;
 	}
 
+	snd_soc_dapm_new_controls(&platform->dapm, sst_dapm_widgets,
+			ARRAY_SIZE(sst_dapm_widgets));
+	snd_soc_dapm_add_routes(&platform->dapm, intercon,
+			ARRAY_SIZE(intercon));
+	snd_soc_dapm_new_widgets(platform->dapm.card);
 
 	for (i = 0; i < SST_NUM_GAINS; i++) {
 		sst_gains[i].mute = SST_GAIN_MUTE_DEFAULT;
diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index 4acdd32..fee03df 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -158,6 +158,10 @@ struct sst_device {
 struct sst_data;
 
 int sst_dsp_init_v2_dpcm(struct snd_soc_platform *platform);
+int sst_send_pipe_gains(struct snd_soc_dai *dai, int stream, int mute);
+void send_ssp_cmd(struct snd_soc_platform *platform, const char *id, bool enable);
+void sst_handle_vb_timer(struct snd_soc_platform *platform, bool enable);
+
 unsigned int sst_soc_read(struct snd_soc_platform *platform, unsigned int reg);
 int sst_soc_write(struct snd_soc_platform *platform, unsigned int reg, unsigned int val);
 unsigned int sst_reg_read(struct sst_data *sst, unsigned int reg,
-- 
1.7.0.4
