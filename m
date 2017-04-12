From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add support for
	deferred DSP module bind" to the asoc tree
Date: Wed, 12 Apr 2017 17:00:19 +0100
Message-ID: <E1cyKgt-000626-FI@debutante>
References: <1490275926-2270-12-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B49F266FA9
 for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2017 18:00:37 +0200 (CEST)
In-Reply-To: <1490275926-2270-12-git-send-email-jeeja.kp@intel.com>
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
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add support for deferred DSP module bind

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

>From b8c722ddd548186db3f62e64f727af4db1cf9517 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 24 Mar 2017 23:10:34 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add support for deferred DSP module
 bind

Module at the end of DSP pipeline that needs to be connected to a module
in another pipeline are represented as a PGA(leaf node) and in PGA event
handler these modules are bound/unbounded. Modules other than PGA leaf
can be connected directly or via switch to a module in another pipeline.
Example: reference path.

To support the deferred DSP module bind, following changes are done:
o When the path is enabled, the destination module that needs to be
bound may not be initialized. If the module is not initialized, add
these modules in a deferred bind list.
o When the destination module is initialized, check for these modules
in deferred bind list. If found, bind them.
o When the destination module is deleted, Unbind the modules.
o When the source module is deleted, remove the entry from the deferred
bind list.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c      |  12 ++++
 sound/soc/intel/skylake/skl-topology.c | 109 ++++++++++++++++++++++++++++++++-
 sound/soc/intel/skylake/skl-topology.h |   6 ++
 sound/soc/intel/skylake/skl.h          |   1 +
 4 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 1823197c15c8..600faad19bd4 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1300,6 +1300,7 @@ int skl_platform_register(struct device *dev)
 	struct skl *skl = ebus_to_skl(ebus);
 
 	INIT_LIST_HEAD(&skl->ppl_list);
+	INIT_LIST_HEAD(&skl->bind_list);
 
 	ret = snd_soc_register_platform(dev, &skl_platform_drv);
 	if (ret) {
@@ -1320,6 +1321,17 @@ int skl_platform_register(struct device *dev)
 
 int skl_platform_unregister(struct device *dev)
 {
+	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
+	struct skl *skl = ebus_to_skl(ebus);
+	struct skl_module_deferred_bind *modules;
+
+	if (!list_empty(&skl->bind_list)) {
+		list_for_each_entry(modules, &skl->bind_list, node) {
+			list_del(&modules->node);
+			kfree(modules);
+		}
+	}
+
 	snd_soc_unregister_component(dev);
 	snd_soc_unregister_platform(dev);
 	return 0;
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index e960d9f761b9..7f285176a074 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -638,8 +638,9 @@ static int skl_tplg_mixer_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
 	struct skl_module_cfg *mconfig = w->priv;
 	struct skl_pipe_module *w_module;
 	struct skl_pipe *s_pipe = mconfig->pipe;
-	struct skl_module_cfg *src_module = NULL, *dst_module;
+	struct skl_module_cfg *src_module = NULL, *dst_module, *module;
 	struct skl_sst *ctx = skl->skl_sst;
+	struct skl_module_deferred_bind *modules;
 
 	/* check resource available */
 	if (!skl_is_pipe_mcps_avail(skl, mconfig))
@@ -680,6 +681,22 @@ static int skl_tplg_mixer_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
 		src_module = dst_module;
 	}
 
+	/*
+	 * When the destination module is initialized, check for these modules
+	 * in deferred bind list. If found, bind them.
+	 */
+	list_for_each_entry(w_module, &s_pipe->w_list, node) {
+		if (list_empty(&skl->bind_list))
+			break;
+
+		list_for_each_entry(modules, &skl->bind_list, node) {
+			module = w_module->w->priv;
+			if (modules->dst == module)
+				skl_bind_modules(ctx, modules->src,
+							modules->dst);
+		}
+	}
+
 	return 0;
 }
 
@@ -776,6 +793,44 @@ static int skl_tplg_set_module_bind_params(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+
+static int skl_tplg_module_add_deferred_bind(struct skl *skl,
+	struct skl_module_cfg *src, struct skl_module_cfg *dst)
+{
+	struct skl_module_deferred_bind *m_list, *modules;
+	int i;
+
+	/* only supported for module with static pin connection */
+	for (i = 0; i < dst->max_in_queue; i++) {
+		struct skl_module_pin *pin = &dst->m_in_pin[i];
+
+		if (pin->is_dynamic)
+			continue;
+
+		if ((pin->id.module_id  == src->id.module_id) &&
+			(pin->id.instance_id  == src->id.instance_id)) {
+
+			if (!list_empty(&skl->bind_list)) {
+				list_for_each_entry(modules, &skl->bind_list, node) {
+					if (modules->src == src && modules->dst == dst)
+						return 0;
+				}
+			}
+
+			m_list = kzalloc(sizeof(*m_list), GFP_KERNEL);
+			if (!m_list)
+				return -ENOMEM;
+
+			m_list->src = src;
+			m_list->dst = dst;
+
+			list_add(&m_list->node, &skl->bind_list);
+		}
+	}
+
+	return 0;
+}
+
 static int skl_tplg_bind_sinks(struct snd_soc_dapm_widget *w,
 				struct skl *skl,
 				struct snd_soc_dapm_widget *src_w,
@@ -810,6 +865,28 @@ static int skl_tplg_bind_sinks(struct snd_soc_dapm_widget *w,
 			sink = p->sink;
 			sink_mconfig = sink->priv;
 
+			/*
+			 * Modules other than PGA leaf can be connected
+			 * directly or via switch to a module in another
+			 * pipeline. EX: reference path
+			 * when the path is enabled, the dst module that needs
+			 * to be bound may not be initialized. if the module is
+			 * not initialized, add these modules in the deferred
+			 * bind list and when the dst module is initialised,
+			 * bind this module to the dst_module in deferred list.
+			 */
+			if (((src_mconfig->m_state == SKL_MODULE_INIT_DONE)
+				&& (sink_mconfig->m_state == SKL_MODULE_UNINIT))) {
+
+				ret = skl_tplg_module_add_deferred_bind(skl,
+						src_mconfig, sink_mconfig);
+
+				if (ret < 0)
+					return ret;
+
+			}
+
+
 			if (src_mconfig->m_state == SKL_MODULE_UNINIT ||
 				sink_mconfig->m_state == SKL_MODULE_UNINIT)
 				continue;
@@ -1014,6 +1091,7 @@ static int skl_tplg_mixer_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 	struct skl_module_cfg *src_module = NULL, *dst_module;
 	struct skl_sst *ctx = skl->skl_sst;
 	struct skl_pipe *s_pipe = mconfig->pipe;
+	struct skl_module_deferred_bind *modules;
 
 	if (s_pipe->state == SKL_PIPE_INVALID)
 		return -EINVAL;
@@ -1022,6 +1100,35 @@ static int skl_tplg_mixer_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 	skl_tplg_free_pipe_mem(skl, mconfig);
 
 	list_for_each_entry(w_module, &s_pipe->w_list, node) {
+		if (list_empty(&skl->bind_list))
+			break;
+
+		src_module = w_module->w->priv;
+
+		list_for_each_entry(modules, &skl->bind_list, node) {
+			/*
+			 * When the destination module is deleted, Unbind the
+			 * modules from deferred bind list.
+			 */
+			if (modules->dst == src_module) {
+				skl_unbind_modules(ctx, modules->src,
+						modules->dst);
+			}
+
+			/*
+			 * When the source module is deleted, remove this entry
+			 * from the deferred bind list.
+			 */
+			if (modules->src == src_module) {
+				list_del(&modules->node);
+				modules->src = NULL;
+				modules->dst = NULL;
+				kfree(modules);
+			}
+		}
+	}
+
+	list_for_each_entry(w_module, &s_pipe->w_list, node) {
 		dst_module = w_module->w->priv;
 
 		if (mconfig->m_state >= SKL_MODULE_INIT_DONE)
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 8536d03a7778..cc64d6bdb4f6 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -336,6 +336,12 @@ struct skl_pipeline {
 	struct list_head node;
 };
 
+struct skl_module_deferred_bind {
+	struct skl_module_cfg *src;
+	struct skl_module_cfg *dst;
+	struct list_head node;
+};
+
 static inline struct skl *get_skl_ctx(struct device *dev)
 {
 	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index bbef77d2b917..5b3fa4b91691 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -77,6 +77,7 @@ struct skl {
 
 	struct skl_dsp_resource resource;
 	struct list_head ppl_list;
+	struct list_head bind_list;
 
 	const char *fw_name;
 	char tplg_name[64];
-- 
2.11.0
