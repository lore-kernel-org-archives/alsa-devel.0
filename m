From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v6 07/10] ASoC: Intel: mrfld: add the DSP DAPM
	widgets
Date: Tue,  9 Sep 2014 15:11:30 +0530
Message-ID: <1410255693-6958-8-git-send-email-subhransu.s.prusty@intel.com>
References: <1410255693-6958-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F8C826510B
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 12:04:29 +0200 (CEST)
In-Reply-To: <1410255693-6958-1-git-send-email-subhransu.s.prusty@intel.com>
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

This patch adds all DAPM widgets and the event handlers for DSP expect the
mixers. Since we are still discussing mixer update and is dependent upon
component series

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/sst-atom-controls.c | 230 +++++++++++++++++++++++++++++++++++-
 sound/soc/intel/sst-mfld-platform.h |   4 +
 2 files changed, 233 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-atom-controls.c b/sound/soc/intel/sst-atom-controls.c
index 3be9ab1..7b01e04 100644
--- a/sound/soc/intel/sst-atom-controls.c
+++ b/sound/soc/intel/sst-atom-controls.c
@@ -492,8 +492,43 @@ static const uint swm_mixer_input_ids[SST_SWM_INPUT_COUNT] = {
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
+static int fill_swm_input(struct snd_soc_component *cmpnt,
+		struct swm_input_ids *swm_input, unsigned int reg)
+{
+	uint i, is_set, nb_inputs = 0;
+	u16 input_loc_id;
+
+	dev_dbg(cmpnt->dev, "reg: %#x\n", reg);
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
+		dev_dbg(cmpnt->dev, "input id: %#x, nb_inputs: %d\n",
+				input_loc_id, nb_inputs);
+
+		if (nb_inputs == SST_CMD_SWM_MAX_INPUTS) {
+			dev_warn(cmpnt->dev, "SET_SWM cmd max inputs reached");
+			break;
+		}
+	}
+	return nb_inputs;
+}
+
 static void sst_set_pipe_gain(struct sst_ids *ids,
-			struct sst_data *drv, int mute)
+		struct sst_data *drv, int mute)
 {
 	struct sst_gain_mixer_control *mc;
 	struct sst_gain_value *gv;
@@ -510,6 +545,114 @@ static void sst_set_pipe_gain(struct sst_ids *ids,
 			mc->pipe_id | mc->instance_id, mc->module_id, mute);
 	}
 }
+
+static int sst_swm_mixer_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+{
+	struct sst_cmd_set_swm cmd;
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct sst_data *drv = snd_soc_component_get_drvdata(cmpnt);
+	struct sst_ids *ids = w->priv;
+	bool set_mixer = false;
+	struct soc_mixer_control *mc;
+	int val = 0;
+	int i = 0;
+
+	dev_dbg(cmpnt->dev, "widget = %s\n", w->name);
+	/*
+	 * Identify which mixer input is on and send the bitmap of the
+	 * inputs as an IPC to the DSP.
+	 */
+	for (i = 0; i < w->num_kcontrols; i++) {
+		if (dapm_kcontrol_get_value(w->kcontrols[i])) {
+			mc = (struct soc_mixer_control *)(w->kcontrols[i])->private_value;
+			val |= 1 << mc->shift;
+		}
+	}
+	dev_dbg(cmpnt->dev, "val = %#x\n", val);
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
+	/*MMX_SET_SWM == SBA_SET_SWM*/
+	cmd.header.command_id = SBA_SET_SWM;
+
+	SST_FILL_DESTINATION(2, cmd.output_id,
+			     ids->location_id, SST_DEFAULT_MODULE_ID);
+	cmd.nb_inputs =	fill_swm_input(cmpnt, &cmd.input[0], val);
+	cmd.header.length = offsetof(struct sst_cmd_set_swm, input)
+				- sizeof(struct sst_dsp_header)
+				+ (cmd.nb_inputs * sizeof(cmd.input[0]));
+
+	sst_fill_and_send_cmd(drv, SST_IPC_IA_CMD, SST_FLAG_BLOCKED,
+			      ids->task_id, 0, &cmd,
+			      sizeof(cmd.header) + cmd.header.length);
+	return 0;
+}
+
+/*SBA mixers - 16 inputs*/
+#define SST_SBA_DECLARE_MIX_CONTROLS(kctl_name)						\
+	static const struct snd_kcontrol_new kctl_name[] = {				\
+		SOC_DAPM_SINGLE("codec_in0", SND_SOC_NOPM, SST_IP_CODEC0, 1, 0),	\
+		SOC_DAPM_SINGLE("codec_in1", SND_SOC_NOPM, SST_IP_CODEC1, 1, 0),	\
+		SOC_DAPM_SINGLE("sprot_loop_in", SND_SOC_NOPM, SST_IP_LOOP0, 1, 0),	\
+		SOC_DAPM_SINGLE("media_loop1_in", SND_SOC_NOPM, SST_IP_LOOP1, 1, 0),	\
+		SOC_DAPM_SINGLE("media_loop2_in", SND_SOC_NOPM, SST_IP_LOOP2, 1, 0),	\
+		SOC_DAPM_SINGLE("pcm0_in", SND_SOC_NOPM, SST_IP_PCM0, 1, 0),		\
+		SOC_DAPM_SINGLE("pcm1_in", SND_SOC_NOPM, SST_IP_PCM1, 1, 0),		\
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
+#define SST_MMX_DECLARE_MIX_CONTROLS(kctl_name)			\
+	static const struct snd_kcontrol_new kctl_name[] = {			\
+		SOC_DAPM_SINGLE("media0_in", SND_SOC_NOPM, SST_IP_MEDIA0, 1, 0),	\
+		SOC_DAPM_SINGLE("media1_in", SND_SOC_NOPM, SST_IP_MEDIA1, 1, 0),	\
+		SOC_DAPM_SINGLE("media2_in", SND_SOC_NOPM, SST_IP_MEDIA2, 1, 0),	\
+		SOC_DAPM_SINGLE("media3_in", SND_SOC_NOPM, SST_IP_MEDIA3, 1, 0),	\
+	}
+
+SST_MMX_DECLARE_MIX_CONTROLS(sst_mix_media0_controls);
+SST_MMX_DECLARE_MIX_CONTROLS(sst_mix_media1_controls);
+
+/*18 SBA mixers*/
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_pcm0_controls);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_pcm1_controls);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_pcm2_controls);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_sprot_l0_controls);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_media_l1_controls);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_media_l2_controls);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_voip_controls);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_codec0_controls);
+SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_codec1_controls);
+
 void sst_handle_vb_timer(struct snd_soc_dai *dai, bool enable)
 {
 	struct sst_cmd_generic cmd;
@@ -690,6 +833,83 @@ static int sst_set_media_loop(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static const struct snd_soc_dapm_widget sst_dapm_widgets[] = {
+	SST_AIF_IN("codec_in0", sst_set_be_modules),
+	SST_AIF_IN("codec_in1", sst_set_be_modules),
+	SST_AIF_OUT("codec_out0", sst_set_be_modules),
+	SST_AIF_OUT("codec_out1", sst_set_be_modules),
+
+	/*Media Paths*/
+	/*MediaX IN paths are set via ALLOC, so no SET_MEDIA_PATH command*/
+	SST_PATH_INPUT("media0_in", SST_TASK_MMX, SST_SWM_IN_MEDIA0, sst_generic_modules_event),
+	SST_PATH_INPUT("media1_in", SST_TASK_MMX, SST_SWM_IN_MEDIA1, NULL),
+	SST_PATH_INPUT("media2_in", SST_TASK_MMX, SST_SWM_IN_MEDIA2, sst_set_media_path),
+	SST_PATH_INPUT("media3_in", SST_TASK_MMX, SST_SWM_IN_MEDIA3, NULL),
+	SST_PATH_OUTPUT("media0_out", SST_TASK_MMX, SST_SWM_OUT_MEDIA0, sst_set_media_path),
+	SST_PATH_OUTPUT("media1_out", SST_TASK_MMX, SST_SWM_OUT_MEDIA1, sst_set_media_path),
+
+	/*SBA PCM Paths*/
+	SST_PATH_INPUT("pcm0_in", SST_TASK_SBA, SST_SWM_IN_PCM0, sst_set_media_path),
+	SST_PATH_INPUT("pcm1_in", SST_TASK_SBA, SST_SWM_IN_PCM1, sst_set_media_path),
+	SST_PATH_OUTPUT("pcm0_out", SST_TASK_SBA, SST_SWM_OUT_PCM0, sst_set_media_path),
+	SST_PATH_OUTPUT("pcm1_out", SST_TASK_SBA, SST_SWM_OUT_PCM1, sst_set_media_path),
+	SST_PATH_OUTPUT("pcm2_out", SST_TASK_SBA, SST_SWM_OUT_PCM2, sst_set_media_path),
+
+	/*SBA Loops*/
+	SST_PATH_INPUT("sprot_loop_in", SST_TASK_SBA, SST_SWM_IN_SPROT_LOOP, NULL),
+	SST_PATH_INPUT("media_loop1_in", SST_TASK_SBA, SST_SWM_IN_MEDIA_LOOP1, NULL),
+	SST_PATH_INPUT("media_loop2_in", SST_TASK_SBA, SST_SWM_IN_MEDIA_LOOP2, NULL),
+	SST_PATH_MEDIA_LOOP_OUTPUT("sprot_loop_out", SST_TASK_SBA, SST_SWM_OUT_SPROT_LOOP, SST_FMT_MONO, sst_set_media_loop),
+	SST_PATH_MEDIA_LOOP_OUTPUT("media_loop1_out", SST_TASK_SBA, SST_SWM_OUT_MEDIA_LOOP1, SST_FMT_MONO, sst_set_media_loop),
+	SST_PATH_MEDIA_LOOP_OUTPUT("media_loop2_out", SST_TASK_SBA, SST_SWM_OUT_MEDIA_LOOP2, SST_FMT_STEREO, sst_set_media_loop),
+
+	/*Media Mixers*/
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
@@ -1006,6 +1226,8 @@ static int sst_map_modules_to_pipe(struct snd_soc_platform *platform)
 int sst_dsp_init_v2_dpcm(struct snd_soc_platform *platform)
 {
 	int i, ret = 0;
+	struct snd_soc_dapm_context *dapm =
+			snd_soc_component_get_dapm(&platform->component);
 	struct sst_data *drv = snd_soc_platform_get_drvdata(platform);
 
 	drv->byte_stream = devm_kzalloc(platform->dev,
@@ -1013,6 +1235,12 @@ int sst_dsp_init_v2_dpcm(struct snd_soc_platform *platform)
 	if (!drv->byte_stream)
 		return -ENOMEM;
 
+	snd_soc_dapm_new_controls(dapm, sst_dapm_widgets,
+			ARRAY_SIZE(sst_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, intercon,
+			ARRAY_SIZE(intercon));
+	snd_soc_dapm_new_widgets(dapm->card);
+
 	for (i = 0; i < SST_NUM_GAINS; i++) {
 		sst_gains[i].mute = SST_GAIN_MUTE_DEFAULT;
 		sst_gains[i].l_gain = SST_GAIN_VOLUME_DEFAULT;
diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index bf2b6d4..c16d489 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -153,6 +153,10 @@ struct sst_device {
 struct sst_data;
 
 int sst_dsp_init_v2_dpcm(struct snd_soc_platform *platform);
+int sst_send_pipe_gains(struct snd_soc_dai *dai, int stream, int mute);
+void send_ssp_cmd(struct snd_soc_dai *dai, const char *id, bool enable);
+void sst_handle_vb_timer(struct snd_soc_dai *dai, bool enable);
+
 void sst_set_stream_status(struct sst_runtime_stream *stream, int state);
 int sst_fill_stream_params(void *substream, const struct sst_data *ctx,
 			   struct snd_sst_params *str_params, bool is_compress);
-- 
1.9.0
