From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Avoid freeing up of
	unallocated memory/mcps" to the asoc tree
Date: Tue, 07 Jun 2016 14:27:45 +0100
Message-ID: <E1bAH2n-0001hW-7v@debutante>
References: <1464958783-19344-6-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DCA0D26658C
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 15:27:49 +0200 (CEST)
In-Reply-To: <1464958783-19344-6-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dharageswari R <dharageswari.r@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Avoid freeing up of unallocated memory/mcps

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

>From 260eb73aa252d0cbdfe11523d5def9d6d00625d4 Mon Sep 17 00:00:00 2001
From: Dharageswari R <dharageswari.r@intel.com>
Date: Fri, 3 Jun 2016 18:29:38 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Avoid freeing up of unallocated
 memory/mcps

When DSP pipe/module is not initialized successfully, memory/mcps
is not allocated. So check the pipe/module state to avoid freeing
up of unallocated memory/mcps. And allocate resources when pipe/
module is initialized successfully.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 44b62e1d79db..67b1ab501918 100644
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
2.8.1
