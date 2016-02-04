From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix pipe memory
	allocation leak" to the asoc tree
Date: Thu, 04 Feb 2016 12:16:15 +0000
Message-ID: <E1aRIpb-0001EA-Cn@debutante>
References: <1454502594-21700-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2081D261B28
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2016 13:16:21 +0100 (CET)
In-Reply-To: <1454502594-21700-5-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Dharageswari.R" <dharageswari.r@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix pipe memory allocation leak

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

>From 9ba8ffef9635c11102bc42d0f2d0a4213de273d5 Mon Sep 17 00:00:00 2001
From: "Dharageswari.R" <dharageswari.r@intel.com>
Date: Wed, 3 Feb 2016 17:59:47 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix pipe memory allocation leak

We check and allocate pipeline resources in one shot. That causes
leaks if module creation fails later as that is not freed.

So split the resource allocation into two, first check if
resources are available and then add the resources upon
successful creation. So two new functions are added for checking
and current functions are re-purposed to only add the resources
for memory and MCPS.

Signed-off-by: Dharageswari.R <dharageswari.r@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 42 +++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 86d5323e9184..efe001162204 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -54,12 +54,9 @@ static int is_skl_dsp_widget_type(struct snd_soc_dapm_widget *w)
 
 /*
  * Each pipelines needs memory to be allocated. Check if we have free memory
- * from available pool. Then only add this to pool
- * This is freed when pipe is deleted
- * Note: DSP does actual memory management we only keep track for complete
- * pool
+ * from available pool.
  */
-static bool skl_tplg_alloc_pipe_mem(struct skl *skl,
+static bool skl_is_pipe_mem_avail(struct skl *skl,
 				struct skl_module_cfg *mconfig)
 {
 	struct skl_sst *ctx = skl->skl_sst;
@@ -74,10 +71,20 @@ static bool skl_tplg_alloc_pipe_mem(struct skl *skl,
 				"exceeds ppl memory available %d mem %d\n",
 				skl->resource.max_mem, skl->resource.mem);
 		return false;
+	} else {
+		return true;
 	}
+}
 
+/*
+ * Add the mem to the mem pool. This is freed when pipe is deleted.
+ * Note: DSP does actual memory management we only keep track for complete
+ * pool
+ */
+static void skl_tplg_alloc_pipe_mem(struct skl *skl,
+				struct skl_module_cfg *mconfig)
+{
 	skl->resource.mem += mconfig->pipe->memory_pages;
-	return true;
 }
 
 /*
@@ -85,10 +92,10 @@ static bool skl_tplg_alloc_pipe_mem(struct skl *skl,
  * quantified in MCPS (Million Clocks Per Second) required for module/pipe
  *
  * Each pipelines needs mcps to be allocated. Check if we have mcps for this
- * pipe. This adds the mcps to driver counter
- * This is removed on pipeline delete
+ * pipe.
  */
-static bool skl_tplg_alloc_pipe_mcps(struct skl *skl,
+
+static bool skl_is_pipe_mcps_avail(struct skl *skl,
 				struct skl_module_cfg *mconfig)
 {
 	struct skl_sst *ctx = skl->skl_sst;
@@ -101,10 +108,15 @@ static bool skl_tplg_alloc_pipe_mcps(struct skl *skl,
 			"exceeds ppl mcps available %d > mem %d\n",
 			skl->resource.max_mcps, skl->resource.mcps);
 		return false;
+	} else {
+		return true;
 	}
+}
 
+static void skl_tplg_alloc_pipe_mcps(struct skl *skl,
+				struct skl_module_cfg *mconfig)
+{
 	skl->resource.mcps += mconfig->mcps;
-	return true;
 }
 
 /*
@@ -411,7 +423,7 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 		mconfig = w->priv;
 
 		/* check resource available */
-		if (!skl_tplg_alloc_pipe_mcps(skl, mconfig))
+		if (!skl_is_pipe_mcps_avail(skl, mconfig))
 			return -ENOMEM;
 
 		if (mconfig->is_loadable && ctx->dsp->fw_ops.load_mod) {
@@ -435,6 +447,7 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 		ret = skl_tplg_set_module_params(w, ctx);
 		if (ret < 0)
 			return ret;
+		skl_tplg_alloc_pipe_mcps(skl, mconfig);
 	}
 
 	return 0;
@@ -477,10 +490,10 @@ static int skl_tplg_mixer_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
 	struct skl_sst *ctx = skl->skl_sst;
 
 	/* check resource available */
-	if (!skl_tplg_alloc_pipe_mcps(skl, mconfig))
+	if (!skl_is_pipe_mcps_avail(skl, mconfig))
 		return -EBUSY;
 
-	if (!skl_tplg_alloc_pipe_mem(skl, mconfig))
+	if (!skl_is_pipe_mem_avail(skl, mconfig))
 		return -ENOMEM;
 
 	/*
@@ -526,6 +539,9 @@ static int skl_tplg_mixer_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
 		src_module = dst_module;
 	}
 
+	skl_tplg_alloc_pipe_mem(skl, mconfig);
+	skl_tplg_alloc_pipe_mcps(skl, mconfig);
+
 	return 0;
 }
 
-- 
2.7.0.rc3
