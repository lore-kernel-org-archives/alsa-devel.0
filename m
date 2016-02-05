From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 5/7] ASoC: Intel: Skylake: Allow module
	parameter set after bind
Date: Fri,  5 Feb 2016 12:19:08 +0530
Message-ID: <1454654950-23091-6-git-send-email-vinod.koul@intel.com>
References: <1454654950-23091-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D977266609
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 07:46:16 +0100 (CET)
In-Reply-To: <1454654950-23091-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Some modules require params to be set after the module is bound
to all the pins connected.

The module provider initializes set_param flag for such modules
and we send params after binding. This is done by the function
skl_tplg_set_module_bind_params()

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c       | 72 ++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-tplg-interface.h |  3 +-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 696a8becb803..7803a6f3c014 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -545,6 +545,66 @@ static int skl_tplg_mixer_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+/*
+ * Some modules require params to be set after the module is bound to
+ * all pins connected.
+ *
+ * The module provider initializes set_param flag for such modules and we
+ * send params after binding
+ */
+static int skl_tplg_set_module_bind_params(struct snd_soc_dapm_widget *w,
+			struct skl_module_cfg *mcfg, struct skl_sst *ctx)
+{
+	int i, ret;
+	struct skl_module_cfg *mconfig = w->priv;
+	const struct snd_kcontrol_new *k;
+	struct soc_bytes_ext *sb;
+	struct skl_algo_data *bc;
+	struct skl_specific_cfg *sp_cfg;
+
+	/*
+	 * check all out/in pins are in bind state.
+	 * if so set the module param
+	 */
+	for (i = 0; i < mcfg->max_out_queue; i++) {
+		if (mcfg->m_out_pin[i].pin_state != SKL_PIN_BIND_DONE)
+			return 0;
+	}
+
+	for (i = 0; i < mcfg->max_in_queue; i++) {
+		if (mcfg->m_in_pin[i].pin_state != SKL_PIN_BIND_DONE)
+			return 0;
+	}
+
+	if (mconfig->formats_config.caps_size > 0 &&
+		mconfig->formats_config.set_params == SKL_PARAM_BIND) {
+		sp_cfg = &mconfig->formats_config;
+		ret = skl_set_module_params(ctx, sp_cfg->caps,
+					sp_cfg->caps_size,
+					sp_cfg->param_id, mconfig);
+		if (ret < 0)
+			return ret;
+	}
+
+	for (i = 0; i < w->num_kcontrols; i++) {
+		k = &w->kcontrol_news[i];
+		if (k->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
+			sb = (void *) k->private_value;
+			bc = (struct skl_algo_data *)sb->dobj.private;
+
+			if (bc->set_params == SKL_PARAM_BIND) {
+				ret = skl_set_module_params(ctx,
+						(u32 *)bc->params, bc->max,
+						bc->param_id, mconfig);
+				if (ret < 0)
+					return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int skl_tplg_bind_sinks(struct snd_soc_dapm_widget *w,
 				struct skl *skl,
 				struct snd_soc_dapm_widget *src_w,
@@ -579,11 +639,19 @@ static int skl_tplg_bind_sinks(struct snd_soc_dapm_widget *w,
 			sink = p->sink;
 			sink_mconfig = sink->priv;
 
+			if (src_mconfig->m_state == SKL_MODULE_UNINIT ||
+				sink_mconfig->m_state == SKL_MODULE_UNINIT)
+				continue;
+
 			/* Bind source to sink, mixin is always source */
 			ret = skl_bind_modules(ctx, src_mconfig, sink_mconfig);
 			if (ret)
 				return ret;
 
+			/* set module params after bind */
+			skl_tplg_set_module_bind_params(src_w, src_mconfig, ctx);
+			skl_tplg_set_module_bind_params(sink, sink_mconfig, ctx);
+
 			/* Start sinks pipe first */
 			if (sink_mconfig->pipe->state != SKL_PIPE_STARTED) {
 				if (sink_mconfig->pipe->conn_type !=
@@ -714,6 +782,10 @@ static int skl_tplg_mixer_dapm_post_pmu_event(struct snd_soc_dapm_widget *w,
 		if (ret)
 			return ret;
 
+		/* set module params after bind */
+		skl_tplg_set_module_bind_params(source, src_mconfig, ctx);
+		skl_tplg_set_module_bind_params(sink, sink_mconfig, ctx);
+
 		if (sink_mconfig->pipe->conn_type != SKL_PIPE_CONN_TYPE_FE)
 			ret = skl_run_pipe(ctx, sink_mconfig->pipe);
 	}
diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
index c9ae010b3cc8..1db88a63ac17 100644
--- a/sound/soc/intel/skylake/skl-tplg-interface.h
+++ b/sound/soc/intel/skylake/skl-tplg-interface.h
@@ -144,7 +144,8 @@ enum module_pin_type {
 enum skl_module_param_type {
 	SKL_PARAM_DEFAULT = 0,
 	SKL_PARAM_INIT,
-	SKL_PARAM_SET
+	SKL_PARAM_SET,
+	SKL_PARAM_BIND
 };
 
 struct skl_dfw_module_pin {
-- 
1.9.1
