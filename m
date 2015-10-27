From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: use module_pin info for
	unbind" to the asoc tree
Date: Tue, 27 Oct 2015 13:49:20 +0900
Message-ID: <E1ZqwCG-0004ud-Ms@finisterre>
References: <1445905380-18167-9-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B4A22657F8
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 05:49:32 +0100 (CET)
In-Reply-To: <1445905380-18167-9-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: use module_pin info for unbind

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

>From 3cda69f8bdb726a3b253369f20418e29d92829a3 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 27 Oct 2015 09:22:51 +0900
Subject: [PATCH] ASoC: Intel: Skylake: use module_pin info for unbind

in_pin and out_pin list for a module has the information about
the module that are bound together. So we can directly look at
pin information of module for binding and unbind.

As a result the preinitialized dapm_path_last we had is removed
and code and memory optimzed.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c      |   1 -
 sound/soc/intel/skylake/skl-topology.c | 108 +++++++++++----------------------
 sound/soc/intel/skylake/skl-topology.h |   5 --
 sound/soc/intel/skylake/skl.h          |   1 -
 4 files changed, 34 insertions(+), 81 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 1242bea..1a9cd00 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -938,7 +938,6 @@ int skl_platform_register(struct device *dev)
 	struct skl *skl = ebus_to_skl(ebus);
 
 	INIT_LIST_HEAD(&skl->ppl_list);
-	INIT_LIST_HEAD(&skl->dapm_path_list);
 
 	ret = snd_soc_register_platform(dev, &skl_platform_drv);
 	if (ret) {
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index e8258d4..abbf8e7 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -411,7 +411,6 @@ static int skl_tplg_pga_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
 							struct skl *skl)
 {
 	struct snd_soc_dapm_path *p;
-	struct skl_dapm_path_list *path_list;
 	struct snd_soc_dapm_widget *source, *sink;
 	struct skl_module_cfg *src_mconfig, *sink_mconfig;
 	struct skl_sst *ctx = skl->skl_sst;
@@ -455,16 +454,6 @@ static int skl_tplg_pga_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
 				if (ret)
 					return ret;
 			}
-
-			path_list = kzalloc(
-					sizeof(struct skl_dapm_path_list),
-					GFP_KERNEL);
-			if (path_list == NULL)
-				return -ENOMEM;
-
-			/* Add connected path to one global list */
-			path_list->dapm_path = p;
-			list_add_tail(&path_list->node, &skl->dapm_path_list);
 			break;
 		}
 	}
@@ -552,54 +541,37 @@ static int skl_tplg_mixer_dapm_post_pmu_event(struct snd_soc_dapm_widget *w,
 static int skl_tplg_mixer_dapm_pre_pmd_event(struct snd_soc_dapm_widget *w,
 							struct skl *skl)
 {
-	struct snd_soc_dapm_widget *source, *sink;
 	struct skl_module_cfg *src_mconfig, *sink_mconfig;
-	int ret = 0, path_found = 0;
-	struct skl_dapm_path_list *path_list, *tmp_list;
+	int ret = 0, i;
 	struct skl_sst *ctx = skl->skl_sst;
 
-	sink = w;
-	sink_mconfig = sink->priv;
+	sink_mconfig = w->priv;
 
 	/* Stop the pipe */
 	ret = skl_stop_pipe(ctx, sink_mconfig->pipe);
 	if (ret)
 		return ret;
 
-	/*
-	 * This list, dapm_path_list handling here does not need any locks
-	 * as we are under dapm lock while handling widget events.
-	 * List can be manipulated safely only under dapm widgets handler
-	 * routines
-	 */
-	list_for_each_entry_safe(path_list, tmp_list,
-				&skl->dapm_path_list, node) {
-		if (path_list->dapm_path->sink == sink) {
-			dev_dbg(ctx->dev, "Path found = %s\n",
-					path_list->dapm_path->name);
-			source = path_list->dapm_path->source;
-			src_mconfig = source->priv;
-			path_found = 1;
+	for (i = 0; i < sink_mconfig->max_in_queue; i++) {
+		if (sink_mconfig->m_in_pin[i].pin_state == SKL_PIN_BIND_DONE) {
+			src_mconfig = sink_mconfig->m_in_pin[i].tgt_mcfg;
+			if (!src_mconfig)
+				continue;
+			/*
+			 * If path_found == 1, that means pmd for source
+			 * pipe has not occurred, source is connected to
+			 * some other sink. so its responsibility of sink
+			 * to unbind itself from source.
+			 */
+			ret = skl_stop_pipe(ctx, src_mconfig->pipe);
+			if (ret < 0)
+				return ret;
 
-			list_del(&path_list->node);
-			kfree(path_list);
-			break;
+			ret = skl_unbind_modules(ctx,
+						src_mconfig, sink_mconfig);
 		}
 	}
 
-	/*
-	 * If path_found == 1, that means pmd for source pipe has
-	 * not occurred, source is connected to some other sink.
-	 * so its responsibility of sink to unbind itself from source.
-	 */
-	if (path_found) {
-		ret = skl_stop_pipe(ctx, src_mconfig->pipe);
-		if (ret < 0)
-			return ret;
-
-		ret = skl_unbind_modules(ctx, src_mconfig, sink_mconfig);
-	}
-
 	return ret;
 }
 
@@ -653,14 +625,11 @@ static int skl_tplg_mixer_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 static int skl_tplg_pga_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 								struct skl *skl)
 {
-	struct snd_soc_dapm_widget *source, *sink;
 	struct skl_module_cfg *src_mconfig, *sink_mconfig;
-	int ret = 0, path_found = 0;
-	struct skl_dapm_path_list *path_list, *tmp_path_list;
+	int ret = 0, i;
 	struct skl_sst *ctx = skl->skl_sst;
 
-	source = w;
-	src_mconfig = source->priv;
+	src_mconfig = w->priv;
 
 	skl_tplg_free_pipe_mcps(skl, src_mconfig);
 	/* Stop the pipe since this is a mixin module */
@@ -668,32 +637,23 @@ static int skl_tplg_pga_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 	if (ret)
 		return ret;
 
-	list_for_each_entry_safe(path_list, tmp_path_list, &skl->dapm_path_list, node) {
-		if (path_list->dapm_path->source == source) {
-			dev_dbg(ctx->dev, "Path found = %s\n",
-					path_list->dapm_path->name);
-			sink = path_list->dapm_path->sink;
-			sink_mconfig = sink->priv;
-			path_found = 1;
-
-			list_del(&path_list->node);
-			kfree(path_list);
-			break;
+	for (i = 0; i < src_mconfig->max_out_queue; i++) {
+		if (src_mconfig->m_out_pin[i].pin_state == SKL_PIN_BIND_DONE) {
+			sink_mconfig = src_mconfig->m_out_pin[i].tgt_mcfg;
+			if (!sink_mconfig)
+				continue;
+			/*
+			 * This is a connecter and if path is found that means
+			 * unbind between source and sink has not happened yet
+			 */
+			ret = skl_stop_pipe(ctx, sink_mconfig->pipe);
+			if (ret < 0)
+				return ret;
+			ret = skl_unbind_modules(ctx, src_mconfig,
+							sink_mconfig);
 		}
 	}
 
-	/*
-	 * This is a connector and if path is found that means
-	 * unbind between source and sink has not happened yet
-	 */
-	if (path_found) {
-		ret = skl_stop_pipe(ctx, src_mconfig->pipe);
-		if (ret < 0)
-			return ret;
-
-		ret = skl_unbind_modules(ctx, src_mconfig, sink_mconfig);
-	}
-
 	return ret;
 }
 
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index cd87683..1b35cb6 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -280,11 +280,6 @@ struct skl_pipeline {
 	struct list_head node;
 };
 
-struct skl_dapm_path_list {
-	struct snd_soc_dapm_path *dapm_path;
-	struct list_head node;
-};
-
 static inline struct skl *get_skl_ctx(struct device *dev)
 {
 	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index dd2e79a..f803ebb 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -67,7 +67,6 @@ struct skl {
 
 	struct skl_dsp_resource resource;
 	struct list_head ppl_list;
-	struct list_head dapm_path_list;
 };
 
 #define skl_to_ebus(s)	(&(s)->ebus)
-- 
2.6.1
