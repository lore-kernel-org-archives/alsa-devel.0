From: jeeja.kp@intel.com
Subject: [PATCH 07/10] ASoC: Intel: Skylake: Create Pipe to
	widget list in soc probe
Date: Fri,  3 Jun 2016 18:29:40 +0530
Message-ID: <1464958783-19344-8-git-send-email-jeeja.kp@intel.com>
References: <1464958783-19344-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id E4C282664DC
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 14:56:35 +0200 (CEST)
In-Reply-To: <1464958783-19344-1-git-send-email-jeeja.kp@intel.com>
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
Cc: patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

We need to Identify the DSP pipe type and based on it being a pass
thru pipeline or not, we need to copy the pipeline params.

Pipe to widget mapping was earlier done in pre PMD widget handler,
but since the pipe type would now be required in hw_params for
bypass pipelines we need to move this to be done during the ASoC
probe of the platform component.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 85 ++++++++++++++--------------------
 1 file changed, 34 insertions(+), 51 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 263c03d..761dfc4 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -379,43 +379,6 @@ static void skl_tplg_update_module_params(struct snd_soc_dapm_widget *w,
 }
 
 /*
- * A pipe can have multiple modules, each of them will be a DAPM widget as
- * well. While managing a pipeline we need to get the list of all the
- * widgets in a pipelines, so this helper - skl_tplg_get_pipe_widget() helps
- * to get the SKL type widgets in that pipeline
- */
-static int skl_tplg_alloc_pipe_widget(struct device *dev,
-	struct snd_soc_dapm_widget *w, struct skl_pipe *pipe)
-{
-	struct skl_module_cfg *src_module = NULL;
-	struct snd_soc_dapm_path *p = NULL;
-	struct skl_pipe_module *p_module = NULL;
-
-	p_module = devm_kzalloc(dev, sizeof(*p_module), GFP_KERNEL);
-	if (!p_module)
-		return -ENOMEM;
-
-	p_module->w = w;
-	list_add_tail(&p_module->node, &pipe->w_list);
-
-	snd_soc_dapm_widget_for_each_sink_path(w, p) {
-		if ((p->sink->priv == NULL)
-				&& (!is_skl_dsp_widget_type(w)))
-			continue;
-
-		if ((p->sink->priv != NULL) && p->connect
-				&& is_skl_dsp_widget_type(p->sink)) {
-
-			src_module = p->sink->priv;
-			if (pipe->ppl_id == src_module->pipe->ppl_id)
-				skl_tplg_alloc_pipe_widget(dev,
-							p->sink, pipe);
-		}
-	}
-	return 0;
-}
-
-/*
  * some modules can have multiple params set from user control and
  * need to be set after module is initialized. If set_param flag is
  * set module params will be done after module is initialised.
@@ -601,20 +564,6 @@ static int skl_tplg_mixer_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
 	skl_tplg_alloc_pipe_mem(skl, mconfig);
 	skl_tplg_alloc_pipe_mcps(skl, mconfig);
 
-	/*
-	 * we create a w_list of all widgets in that pipe. This list is not
-	 * freed on PMD event as widgets within a pipe are static. This
-	 * saves us cycles to get widgets in pipe every time.
-	 *
-	 * So if we have already initialized all the widgets of a pipeline
-	 * we skip, so check for list_empty and create the list if empty
-	 */
-	if (list_empty(&s_pipe->w_list)) {
-		ret = skl_tplg_alloc_pipe_widget(ctx->dev, w, s_pipe);
-		if (ret < 0)
-			return ret;
-	}
-
 	/* Init all pipe modules from source to sink */
 	ret = skl_tplg_init_pipe_modules(skl, s_pipe);
 	if (ret < 0)
@@ -1789,6 +1738,37 @@ static struct snd_soc_tplg_ops skl_tplg_ops  = {
 	.bytes_ext_ops_count = ARRAY_SIZE(skl_tlv_ops),
 };
 
+/*
+ * A pipe can have multiple modules, each of them will be a DAPM widget as
+ * well. While managing a pipeline we need to get the list of all the
+ * widgets in a pipelines, so this helper - skl_tplg_create_pipe_widget_list()
+ * helps to get the SKL type widgets in that pipeline
+ */
+static int skl_tplg_create_pipe_widget_list(struct snd_soc_platform *platform)
+{
+	struct snd_soc_dapm_widget *w;
+	struct skl_module_cfg *mcfg = NULL;
+	struct skl_pipe_module *p_module = NULL;
+	struct skl_pipe *pipe;
+
+	list_for_each_entry(w, &platform->component.card->widgets, list) {
+		if (is_skl_dsp_widget_type(w) && w->priv != NULL) {
+			mcfg = w->priv;
+			pipe = mcfg->pipe;
+
+			p_module = devm_kzalloc(platform->dev,
+						sizeof(*p_module), GFP_KERNEL);
+			if (!p_module)
+				return -ENOMEM;
+
+			p_module->w = w;
+			list_add_tail(&p_module->node, &pipe->w_list);
+		}
+	}
+
+	return 0;
+}
+
 /* This will be read from topology manifest, currently defined here */
 #define SKL_MAX_MCPS 30000000
 #define SKL_FW_MAX_MEM 1000000
@@ -1831,6 +1811,9 @@ int skl_tplg_init(struct snd_soc_platform *platform, struct hdac_ext_bus *ebus)
 	skl->resource.max_mem = SKL_FW_MAX_MEM;
 
 	skl->tplg = fw;
+	ret = skl_tplg_create_pipe_widget_list(platform);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
-- 
2.5.0
