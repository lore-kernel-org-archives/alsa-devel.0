From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 06/13] ASoC: Intel: Skylake: Add module
	configuration helpers
Date: Fri,  7 Aug 2015 23:52:22 +0530
Message-ID: <1438971749-874-7-git-send-email-subhransu.s.prusty@intel.com>
References: <1438971749-874-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A1E0B265055
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 20:23:23 +0200 (CEST)
In-Reply-To: <1438971749-874-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

A module's parameter needs to be updated if there is a src or updown mixer
or a converter in the pipeline. The helper function here updates the module
parameter based on FE/BE hw_params if fixup/conversion is required.

Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 124 +++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index abd1c16..ede2825 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -27,6 +27,10 @@
 #include "skl.h"
 #include "skl-tplg-interface.h"
 
+#define SKL_CH_FIXUP_MASK		(1 << 0)
+#define SKL_RATE_FIXUP_MASK		(1 << 1)
+#define SKL_FMT_FIXUP_MASK		(1 << 2)
+
 /*
  * SKL DSP driver modelling uses only few DAPM widgets so for rest we will
  * ignore. This helpers checks if the SKL driver handles this widget type
@@ -112,6 +116,124 @@ static bool skl_tplg_is_pipe_mcps_available(struct skl *skl,
 	return true;
 }
 
+static void skl_dump_mconfig(struct skl_sst *ctx,
+					struct skl_module_cfg *mcfg)
+{
+	dev_dbg(ctx->dev, "Dumping config\n");
+	dev_dbg(ctx->dev, "Input Format:\n");
+	dev_dbg(ctx->dev, "channels = %d\n", mcfg->in_fmt.channels);
+	dev_dbg(ctx->dev, "s_freq = %d\n", mcfg->in_fmt.s_freq);
+	dev_dbg(ctx->dev, "ch_cfg = %d\n", mcfg->in_fmt.ch_cfg);
+	dev_dbg(ctx->dev, "valid bit depth = %d\n", mcfg->in_fmt.valid_bit_depth);
+	dev_dbg(ctx->dev, "Output Format:\n");
+	dev_dbg(ctx->dev, "channels = %d\n", mcfg->out_fmt.channels);
+	dev_dbg(ctx->dev, "s_freq = %d\n", mcfg->out_fmt.s_freq);
+	dev_dbg(ctx->dev, "valid bit depth = %d\n", mcfg->out_fmt.valid_bit_depth);
+	dev_dbg(ctx->dev, "ch_cfg = %d\n", mcfg->out_fmt.ch_cfg);
+}
+
+static void skl_tplg_update_params(struct skl_module_fmt *fmt,
+			struct skl_pipe_params *params, int fixup)
+{
+	if (fixup & SKL_RATE_FIXUP_MASK)
+		fmt->s_freq = params->s_freq;
+	if (fixup & SKL_CH_FIXUP_MASK)
+		fmt->channels = params->ch;
+	if (fixup & SKL_FMT_FIXUP_MASK)
+		fmt->valid_bit_depth = params->s_fmt;
+}
+
+/*
+ * A pipeline may have modules which impact the pcm parameters, like SRC,
+ * channel converter, format converter.
+ * We need to calculate the output params by applying the 'fixup'
+ * Topology will tell driver which type of fixup is to be applied by
+ * supplying the fixup mask, so based on that we calculate the output
+ *
+ * Now In FE the pcm hw_params is source/target format. Same is applicable
+ * for BE with its hw_params invoked.
+ * here based on FE, BE pipeline and direction we calculate the input and
+ * outfix and then apply that for a module
+ */
+static void skl_tplg_update_params_fixup(struct skl_module_cfg *m_cfg,
+		struct skl_pipe_params *params, bool is_fe) { int in_fixup,
+	out_fixup; struct skl_module_fmt *in_fmt, *out_fmt;
+
+	in_fmt = &m_cfg->in_fmt;
+	out_fmt = &m_cfg->out_fmt;
+
+	if (params->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (is_fe) {
+			in_fixup = m_cfg->params_fixup;
+			out_fixup = (~m_cfg->converter) & m_cfg->params_fixup;
+		} else {
+			out_fixup = m_cfg->params_fixup;
+			in_fixup = (~m_cfg->converter) & m_cfg->params_fixup;
+		}
+	} else {
+		if (is_fe) {
+			out_fixup = m_cfg->params_fixup;
+			in_fixup = (~m_cfg->converter) & m_cfg->params_fixup;
+		} else {
+			in_fixup = m_cfg->params_fixup;
+			out_fixup = (~m_cfg->converter) & m_cfg->params_fixup;
+		}
+	}
+
+	skl_tplg_update_params(in_fmt, params, in_fixup);
+	skl_tplg_update_params(out_fmt, params, out_fixup);
+}
+
+/*
+ * A module needs input and output buffers, which are dependent upon pcm
+ * params, so once we have calculate params, we need buffer calculation as
+ * well.
+ */
+static void skl_tplg_update_buffer_size(struct skl_sst *ctx,
+				struct skl_module_cfg *mcfg)
+{
+	int multiplier = 1;
+
+	if (mcfg->m_type == SKL_MODULE_TYPE_SRCINT)
+		multiplier = 5;
+
+	mcfg->ibs = (mcfg->in_fmt.s_freq / 1000) *
+				(mcfg->in_fmt.channels) *
+				(mcfg->in_fmt.bit_depth >> 3) *
+				multiplier;
+
+	mcfg->obs = (mcfg->out_fmt.s_freq / 1000) *
+				(mcfg->out_fmt.channels) *
+				(mcfg->out_fmt.bit_depth >> 3) *
+				multiplier;
+}
+
+static void skl_tplg_update_module_params(struct snd_soc_dapm_widget *w,
+							struct skl_sst *ctx)
+{
+	struct skl_module_cfg *m_cfg = w->priv;
+	struct skl_pipe_params *params = m_cfg->pipe->p_params;
+	int p_conn_type = m_cfg->pipe->conn_type;
+	bool is_fe;
+
+	if (!m_cfg->params_fixup)
+		return;
+
+	dev_dbg(ctx->dev, "Mconfig for widget=%s BEFORE updation\n", w->name);
+	skl_dump_mconfig(ctx, m_cfg);
+
+	if (p_conn_type == SKL_PIPE_CONN_TYPE_FE)
+		is_fe = true;
+	else
+		is_fe = false;
+
+	skl_tplg_update_params_fixup(m_cfg, params, is_fe);
+	skl_tplg_update_buffer_size(ctx, m_cfg);
+
+	dev_dbg(ctx->dev, "Mconfig for widget=%s AFTER updation\n", w->name);
+	skl_dump_mconfig(ctx, m_cfg);
+}
+
 /*
  * A pipe can have multiple modules each of the will be a DAPM widget as
  * well. While managing a pipeline we need to get the list of all the
@@ -174,6 +296,8 @@ static int skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 		if (!skl_tplg_is_pipe_mcps_available(skl, mconfig))
 			return -ENOMEM;
 
+		/* apply fix/conversion to module params based on FE/BE params*/
+		skl_tplg_update_module_params(w, ctx);
 		ret = skl_init_module(ctx, mconfig, NULL);
 		if (ret < 0)
 			return ret;
-- 
2.4.3
