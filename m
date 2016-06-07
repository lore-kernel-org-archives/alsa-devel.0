From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Create Pipe to widget
	list in soc probe" to the asoc tree
Date: Tue, 07 Jun 2016 14:27:39 +0100
Message-ID: <E1bAH2h-0001fa-0x@debutante>
References: <1464958783-19344-8-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ECE502614E3
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 15:27:44 +0200 (CEST)
In-Reply-To: <1464958783-19344-8-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Create Pipe to widget list in soc probe

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

>From 287af4f9f2679fd897e492338e4729c68f0c4a17 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 3 Jun 2016 18:29:40 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Create Pipe to widget list in soc probe

We need to Identify the DSP pipe type and based on it being a pass
thru pipeline or not, we need to copy the pipeline params.

Pipe to widget mapping was earlier done in pre PMD widget handler,
but since the pipe type would now be required in hw_params for
bypass pipelines we need to move this to be done during the ASoC
probe of the platform component.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 85 ++++++++++++++--------------------
 1 file changed, 34 insertions(+), 51 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 263c03df9a2a..761dfc4ec017 100644
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
2.8.1
