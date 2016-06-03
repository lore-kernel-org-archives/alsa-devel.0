From: jeeja.kp@intel.com
Subject: [PATCH 05/10] ASoC: Intel: Skylake: Avoid freeing up
	of unallocated memory/mcps
Date: Fri,  3 Jun 2016 18:29:38 +0530
Message-ID: <1464958783-19344-6-git-send-email-jeeja.kp@intel.com>
References: <1464958783-19344-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id E532E265DFE
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 14:56:34 +0200 (CEST)
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
Cc: Dharageswari R <dharageswari.r@intel.com>, patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Dharageswari R <dharageswari.r@intel.com>

When DSP pipe/module is not initialized successfully, memory/mcps
is not allocated. So check the pipe/module state to avoid freeing
up of unallocated memory/mcps. And allocate resources when pipe/
module is initialized successfully.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 44b62e1..67b1ab5 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -514,8 +514,6 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 		if (!skl_is_pipe_mcps_avail(skl, mconfig))
 			return -ENOMEM;
 
-		skl_tplg_alloc_pipe_mcps(skl, mconfig);
-
 		if (mconfig->is_loadable && ctx->dsp->fw_ops.load_mod) {
 			ret = ctx->dsp->fw_ops.load_mod(ctx->dsp,
 				mconfig->id.module_id, mconfig->guid);
@@ -539,6 +537,7 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 		if (ret < 0)
 			return ret;
 
+		skl_tplg_alloc_pipe_mcps(skl, mconfig);
 		ret = skl_tplg_set_module_params(w, ctx);
 		if (ret < 0)
 			return ret;
@@ -591,9 +590,6 @@ static int skl_tplg_mixer_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
 	if (!skl_is_pipe_mem_avail(skl, mconfig))
 		return -ENOMEM;
 
-	skl_tplg_alloc_pipe_mem(skl, mconfig);
-	skl_tplg_alloc_pipe_mcps(skl, mconfig);
-
 	/*
 	 * Create a list of modules for pipe.
 	 * This list contains modules from source to sink
@@ -602,6 +598,9 @@ static int skl_tplg_mixer_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
 	if (ret < 0)
 		return ret;
 
+	skl_tplg_alloc_pipe_mem(skl, mconfig);
+	skl_tplg_alloc_pipe_mcps(skl, mconfig);
+
 	/*
 	 * we create a w_list of all widgets in that pipe. This list is not
 	 * freed on PMD event as widgets within a pipe are static. This
@@ -949,13 +948,17 @@ static int skl_tplg_mixer_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 	struct skl_pipe *s_pipe = mconfig->pipe;
 	int ret = 0;
 
+	if (s_pipe->state == SKL_PIPE_INVALID)
+		return -EINVAL;
+
 	skl_tplg_free_pipe_mcps(skl, mconfig);
 	skl_tplg_free_pipe_mem(skl, mconfig);
 
 	list_for_each_entry(w_module, &s_pipe->w_list, node) {
 		dst_module = w_module->w->priv;
 
-		skl_tplg_free_pipe_mcps(skl, dst_module);
+		if (mconfig->m_state >= SKL_MODULE_INIT_DONE)
+			skl_tplg_free_pipe_mcps(skl, dst_module);
 		if (src_module == NULL) {
 			src_module = dst_module;
 			continue;
-- 
2.5.0
