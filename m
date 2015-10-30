From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 12/17] ASoC: Intel: Skylake: Add multiple
	pin formats
Date: Fri, 30 Oct 2015 11:08:31 +0900
Message-ID: <E1Zrz7H-0001B0-U1@finisterre>
References: <1445905380-18167-13-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FE2E265917
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 03:08:36 +0100 (CET)
In-Reply-To: <1445905380-18167-13-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hardik T Shah <hardik.t.shah@intel.com>, Omair M Abdullah <omair.m.abdullah@intel.com>, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add multiple pin formats

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 40766afbe721515846e74cd5f0273c7e515f2c9c Mon Sep 17 00:00:00 2001
From: Hardik T Shah <hardik.t.shah@intel.com>
Date: Tue, 27 Oct 2015 09:22:55 +0900
Subject: [PATCH] ASoC: Intel: Skylake: Add multiple pin formats

The module pin formats are considered homogeneous, but some
modules can have different pcm formats on different pins, like
reference signal for a module.

This patch add support for configuration of each pin of module
and allows us to specify if pins and homogeneous or heterogeneous

Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Omair M Abdullah <omair.m.abdullah@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c       |  8 +--
 sound/soc/intel/skylake/skl-topology.c       | 90 ++++++++++++++++------------
 sound/soc/intel/skylake/skl-topology.h       | 12 +++-
 sound/soc/intel/skylake/skl-tplg-interface.h | 18 +++++-
 4 files changed, 83 insertions(+), 45 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index ee05958..07d3bf4 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -280,7 +280,7 @@ static void skl_set_base_module_format(struct skl_sst *ctx,
 			struct skl_module_cfg *mconfig,
 			struct skl_base_cfg *base_cfg)
 {
-	struct skl_module_fmt *format = &mconfig->in_fmt;
+	struct skl_module_fmt *format = &mconfig->in_fmt[0];
 
 	base_cfg->audio_fmt.number_of_channels = (u8)format->channels;
 
@@ -399,7 +399,7 @@ static void skl_setup_out_format(struct skl_sst *ctx,
 			struct skl_module_cfg *mconfig,
 			struct skl_audio_data_format *out_fmt)
 {
-	struct skl_module_fmt *format = &mconfig->out_fmt;
+	struct skl_module_fmt *format = &mconfig->out_fmt[0];
 
 	out_fmt->number_of_channels = (u8)format->channels;
 	out_fmt->s_freq = format->s_freq;
@@ -423,7 +423,7 @@ static void skl_set_src_format(struct skl_sst *ctx,
 			struct skl_module_cfg *mconfig,
 			struct skl_src_module_cfg *src_mconfig)
 {
-	struct skl_module_fmt *fmt = &mconfig->out_fmt;
+	struct skl_module_fmt *fmt = &mconfig->out_fmt[0];
 
 	skl_set_base_module_format(ctx, mconfig,
 		(struct skl_base_cfg *)src_mconfig);
@@ -440,7 +440,7 @@ static void skl_set_updown_mixer_format(struct skl_sst *ctx,
 			struct skl_module_cfg *mconfig,
 			struct skl_up_down_mixer_cfg *mixer_mconfig)
 {
-	struct skl_module_fmt *fmt = &mconfig->out_fmt;
+	struct skl_module_fmt *fmt = &mconfig->out_fmt[0];
 	int i = 0;
 
 	skl_set_base_module_format(ctx,	mconfig,
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 7311cd3..37e5c4f 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -129,17 +129,15 @@ static void skl_dump_mconfig(struct skl_sst *ctx,
 {
 	dev_dbg(ctx->dev, "Dumping config\n");
 	dev_dbg(ctx->dev, "Input Format:\n");
-	dev_dbg(ctx->dev, "channels = %d\n", mcfg->in_fmt.channels);
-	dev_dbg(ctx->dev, "s_freq = %d\n", mcfg->in_fmt.s_freq);
-	dev_dbg(ctx->dev, "ch_cfg = %d\n", mcfg->in_fmt.ch_cfg);
-	dev_dbg(ctx->dev, "valid bit depth = %d\n",
-			mcfg->in_fmt.valid_bit_depth);
+	dev_dbg(ctx->dev, "channels = %d\n", mcfg->in_fmt[0].channels);
+	dev_dbg(ctx->dev, "s_freq = %d\n", mcfg->in_fmt[0].s_freq);
+	dev_dbg(ctx->dev, "ch_cfg = %d\n", mcfg->in_fmt[0].ch_cfg);
+	dev_dbg(ctx->dev, "valid bit depth = %d\n", mcfg->in_fmt[0].valid_bit_depth);
 	dev_dbg(ctx->dev, "Output Format:\n");
-	dev_dbg(ctx->dev, "channels = %d\n", mcfg->out_fmt.channels);
-	dev_dbg(ctx->dev, "s_freq = %d\n", mcfg->out_fmt.s_freq);
-	dev_dbg(ctx->dev, "valid bit depth = %d\n",
-			mcfg->out_fmt.valid_bit_depth);
-	dev_dbg(ctx->dev, "ch_cfg = %d\n", mcfg->out_fmt.ch_cfg);
+	dev_dbg(ctx->dev, "channels = %d\n", mcfg->out_fmt[0].channels);
+	dev_dbg(ctx->dev, "s_freq = %d\n", mcfg->out_fmt[0].s_freq);
+	dev_dbg(ctx->dev, "valid bit depth = %d\n", mcfg->out_fmt[0].valid_bit_depth);
+	dev_dbg(ctx->dev, "ch_cfg = %d\n", mcfg->out_fmt[0].ch_cfg);
 }
 
 static void skl_tplg_update_params(struct skl_module_fmt *fmt,
@@ -171,8 +169,9 @@ static void skl_tplg_update_params_fixup(struct skl_module_cfg *m_cfg,
 	int in_fixup, out_fixup;
 	struct skl_module_fmt *in_fmt, *out_fmt;
 
-	in_fmt = &m_cfg->in_fmt;
-	out_fmt = &m_cfg->out_fmt;
+	/* Fixups will be applied to pin 0 only */
+	in_fmt = &m_cfg->in_fmt[0];
+	out_fmt = &m_cfg->out_fmt[0];
 
 	if (params->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		if (is_fe) {
@@ -209,18 +208,25 @@ static void skl_tplg_update_buffer_size(struct skl_sst *ctx,
 				struct skl_module_cfg *mcfg)
 {
 	int multiplier = 1;
+	struct skl_module_fmt *in_fmt, *out_fmt;
+
+
+	/* Since fixups is applied to pin 0 only, ibs, obs needs
+	 * change for pin 0 only
+	 */
+	in_fmt = &mcfg->in_fmt[0];
+	out_fmt = &mcfg->out_fmt[0];
 
 	if (mcfg->m_type == SKL_MODULE_TYPE_SRCINT)
 		multiplier = 5;
-
-	mcfg->ibs = (mcfg->in_fmt.s_freq / 1000) *
-				(mcfg->in_fmt.channels) *
-				(mcfg->in_fmt.bit_depth >> 3) *
+	mcfg->ibs = (in_fmt->s_freq / 1000) *
+				(mcfg->in_fmt->channels) *
+				(mcfg->in_fmt->bit_depth >> 3) *
 				multiplier;
 
-	mcfg->obs = (mcfg->out_fmt.s_freq / 1000) *
-				(mcfg->out_fmt.channels) *
-				(mcfg->out_fmt.bit_depth >> 3) *
+	mcfg->obs = (mcfg->out_fmt->s_freq / 1000) *
+				(mcfg->out_fmt->channels) *
+				(mcfg->out_fmt->bit_depth >> 3) *
 				multiplier;
 }
 
@@ -786,9 +792,9 @@ int skl_tplg_update_pipe_params(struct device *dev,
 	memcpy(pipe->p_params, params, sizeof(*params));
 
 	if (params->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		format = &mconfig->in_fmt;
+		format = &mconfig->in_fmt[0];
 	else
-		format = &mconfig->out_fmt;
+		format = &mconfig->out_fmt[0];
 
 	/* set the hw_params */
 	format->s_freq = params->s_freq;
@@ -1083,6 +1089,24 @@ static struct skl_pipe *skl_tplg_add_pipe(struct device *dev,
 	return ppl->pipe;
 }
 
+static void skl_tplg_fill_fmt(struct skl_module_fmt *dst_fmt,
+				struct skl_dfw_module_fmt *src_fmt,
+				int pins)
+{
+	int i;
+
+	for (i = 0; i < pins; i++) {
+		dst_fmt[i].channels  = src_fmt[i].channels;
+		dst_fmt[i].s_freq = src_fmt[i].freq;
+		dst_fmt[i].bit_depth = src_fmt[i].bit_depth;
+		dst_fmt[i].valid_bit_depth = src_fmt[i].valid_bit_depth;
+		dst_fmt[i].ch_cfg = src_fmt[i].ch_cfg;
+		dst_fmt[i].ch_map = src_fmt[i].ch_map;
+		dst_fmt[i].interleaving_style = src_fmt[i].interleaving_style;
+		dst_fmt[i].sample_type = src_fmt[i].sample_type;
+	}
+}
+
 /*
  * Topology core widget load callback
  *
@@ -1121,18 +1145,11 @@ static int skl_tplg_widget_load(struct snd_soc_component *cmpnt,
 	mconfig->max_in_queue = dfw_config->max_in_queue;
 	mconfig->max_out_queue = dfw_config->max_out_queue;
 	mconfig->is_loadable = dfw_config->is_loadable;
-	mconfig->in_fmt.channels = dfw_config->in_fmt.channels;
-	mconfig->in_fmt.s_freq = dfw_config->in_fmt.freq;
-	mconfig->in_fmt.bit_depth = dfw_config->in_fmt.bit_depth;
-	mconfig->in_fmt.valid_bit_depth =
-				dfw_config->in_fmt.valid_bit_depth;
-	mconfig->in_fmt.ch_cfg = dfw_config->in_fmt.ch_cfg;
-	mconfig->out_fmt.channels = dfw_config->out_fmt.channels;
-	mconfig->out_fmt.s_freq = dfw_config->out_fmt.freq;
-	mconfig->out_fmt.bit_depth = dfw_config->out_fmt.bit_depth;
-	mconfig->out_fmt.valid_bit_depth =
-				dfw_config->out_fmt.valid_bit_depth;
-	mconfig->out_fmt.ch_cfg = dfw_config->out_fmt.ch_cfg;
+	skl_tplg_fill_fmt(mconfig->in_fmt, dfw_config->in_fmt,
+						MODULE_MAX_IN_PINS);
+	skl_tplg_fill_fmt(mconfig->out_fmt, dfw_config->out_fmt,
+						MODULE_MAX_OUT_PINS);
+
 	mconfig->params_fixup = dfw_config->params_fixup;
 	mconfig->converter = dfw_config->converter;
 	mconfig->m_type = dfw_config->module_type;
@@ -1147,10 +1164,9 @@ static int skl_tplg_widget_load(struct snd_soc_component *cmpnt,
 	mconfig->time_slot = dfw_config->time_slot;
 	mconfig->formats_config.caps_size = dfw_config->caps.caps_size;
 
-	mconfig->m_in_pin = devm_kzalloc(bus->dev,
-				(mconfig->max_in_queue) *
-					sizeof(*mconfig->m_in_pin),
-				GFP_KERNEL);
+	mconfig->m_in_pin = devm_kzalloc(bus->dev, (mconfig->max_in_queue) *
+						sizeof(*mconfig->m_in_pin),
+						GFP_KERNEL);
 	if (!mconfig->m_in_pin)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 1b35cb6..3b63450 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -36,6 +36,9 @@
 /* Maximum number of coefficients up down mixer module */
 #define UP_DOWN_MIXER_MAX_COEFF		6
 
+#define MODULE_MAX_IN_PINS	8
+#define MODULE_MAX_OUT_PINS	8
+
 enum skl_channel_index {
 	SKL_CHANNEL_LEFT = 0,
 	SKL_CHANNEL_RIGHT = 1,
@@ -178,6 +181,9 @@ struct skl_module_fmt {
 	u32 bit_depth;
 	u32 valid_bit_depth;
 	u32 ch_cfg;
+	u32 interleaving_style;
+	u32 sample_type;
+	u32 ch_map;
 };
 
 struct skl_module_cfg;
@@ -247,8 +253,10 @@ enum skl_module_state {
 
 struct skl_module_cfg {
 	struct skl_module_inst_id id;
-	struct skl_module_fmt in_fmt;
-	struct skl_module_fmt out_fmt;
+	bool homogenous_inputs;
+	bool homogenous_outputs;
+	struct skl_module_fmt in_fmt[MODULE_MAX_IN_PINS];
+	struct skl_module_fmt out_fmt[MODULE_MAX_OUT_PINS];
 	u8 max_in_queue;
 	u8 max_out_queue;
 	u8 in_queue_mask;
diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
index 2bc396d..7bd9af7 100644
--- a/sound/soc/intel/skylake/skl-tplg-interface.h
+++ b/sound/soc/intel/skylake/skl-tplg-interface.h
@@ -110,6 +110,17 @@ enum skl_dev_type {
 	SKL_DEVICE_NONE
 };
 
+enum module_pin_type {
+	/* All pins of the module takes same PCM inputs or outputs
+	* e.g. mixout
+	*/
+	SKL_PIN_TYPE_HOMOGENEOUS,
+	/* All pins of the module takes different PCM inputs or outputs
+	* e.g mux
+	*/
+	SKL_PIN_TYPE_HETEROGENEOUS,
+};
+
 struct skl_dfw_module_pin {
 	u16 module_id;
 	u16 instance_id;
@@ -121,6 +132,9 @@ struct skl_dfw_module_fmt {
 	u32 bit_depth;
 	u32 valid_bit_depth;
 	u32 ch_cfg;
+	u32 interleaving_style;
+	u32 sample_type;
+	u32 ch_map;
 } __packed;
 
 struct skl_dfw_module_caps {
@@ -156,8 +170,8 @@ struct skl_dfw_module {
 	u8 is_dynamic_in_pin;
 	u8 is_dynamic_out_pin;
 	struct skl_dfw_pipe pipe;
-	struct skl_dfw_module_fmt in_fmt;
-	struct skl_dfw_module_fmt out_fmt;
+	struct skl_dfw_module_fmt in_fmt[MAX_IN_QUEUE];
+	struct skl_dfw_module_fmt out_fmt[MAX_OUT_QUEUE];
 	struct skl_dfw_module_pin in_pin[MAX_IN_QUEUE];
 	struct skl_dfw_module_pin out_pin[MAX_OUT_QUEUE];
 	struct skl_dfw_module_caps caps;
-- 
2.6.1
