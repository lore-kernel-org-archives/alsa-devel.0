From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Use private instance id
	of modules in IPC" to the asoc tree
Date: Sat, 24 Sep 2016 22:58:40 -0700
Message-ID: <E1bo2SW-00031T-7E@finisterre>
References: <1472042001-9582-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 420912665B0
 for <alsa-devel@alsa-project.org>; Sun, 25 Sep 2016 07:58:57 +0200 (CEST)
In-Reply-To: <1472042001-9582-7-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Use private instance id of modules in IPC

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

>From ef2a352cfb2a536ae8718065b43702a97f9fba9f Mon Sep 17 00:00:00 2001
From: Dharageswari R <dharageswari.r@intel.com>
Date: Thu, 22 Sep 2016 14:00:38 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Use private instance id of modules in
 IPC

Use private id's of module instances that are generated during
init_module for the IPC messages to DSP. These id's are freed
up during delete pipeline.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c  | 22 ++++++++++++----------
 sound/soc/intel/skylake/skl-sst-utils.c |  2 +-
 sound/soc/intel/skylake/skl-topology.c  | 10 +++++++---
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 8eb5ba2dae3a..ac0c58e170c3 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -787,6 +787,7 @@ static int skl_alloc_queue(struct skl_module_pin *mpin,
 				mpin[i].in_use = true;
 				mpin[i].id.module_id = id.module_id;
 				mpin[i].id.instance_id = id.instance_id;
+				mpin[i].id.pvt_id = id.pvt_id;
 				mpin[i].tgt_mcfg = tgt_cfg;
 				return i;
 			}
@@ -810,6 +811,7 @@ static void skl_free_queue(struct skl_module_pin *mpin, int q_index)
 		mpin[q_index].in_use = false;
 		mpin[q_index].id.module_id = 0;
 		mpin[q_index].id.instance_id = 0;
+		mpin[q_index].id.pvt_id = 0;
 	}
 	mpin[q_index].pin_state = SKL_PIN_UNBIND;
 	mpin[q_index].tgt_mcfg = NULL;
@@ -850,7 +852,7 @@ int skl_init_module(struct skl_sst *ctx,
 	struct skl_ipc_init_instance_msg msg;
 
 	dev_dbg(ctx->dev, "%s: module_id = %d instance=%d\n", __func__,
-		 mconfig->id.module_id, mconfig->id.instance_id);
+		 mconfig->id.module_id, mconfig->id.pvt_id);
 
 	if (mconfig->pipe->state != SKL_PIPE_CREATED) {
 		dev_err(ctx->dev, "Pipe not created state= %d pipe_id= %d\n",
@@ -866,7 +868,7 @@ int skl_init_module(struct skl_sst *ctx,
 	}
 
 	msg.module_id = mconfig->id.module_id;
-	msg.instance_id = mconfig->id.instance_id;
+	msg.instance_id = mconfig->id.pvt_id;
 	msg.ppl_instance_id = mconfig->pipe->ppl_id;
 	msg.param_data_size = module_config_size;
 	msg.core_id = mconfig->core_id;
@@ -887,9 +889,9 @@ static void skl_dump_bind_info(struct skl_sst *ctx, struct skl_module_cfg
 	*src_module, struct skl_module_cfg *dst_module)
 {
 	dev_dbg(ctx->dev, "%s: src module_id = %d  src_instance=%d\n",
-		__func__, src_module->id.module_id, src_module->id.instance_id);
+		__func__, src_module->id.module_id, src_module->id.pvt_id);
 	dev_dbg(ctx->dev, "%s: dst_module=%d dst_instacne=%d\n", __func__,
-		 dst_module->id.module_id, dst_module->id.instance_id);
+		 dst_module->id.module_id, dst_module->id.pvt_id);
 
 	dev_dbg(ctx->dev, "src_module state = %d dst module state = %d\n",
 		src_module->m_state, dst_module->m_state);
@@ -936,9 +938,9 @@ int skl_unbind_modules(struct skl_sst *ctx,
 		return 0;
 
 	msg.module_id = src_mcfg->id.module_id;
-	msg.instance_id = src_mcfg->id.instance_id;
+	msg.instance_id = src_mcfg->id.pvt_id;
 	msg.dst_module_id = dst_mcfg->id.module_id;
-	msg.dst_instance_id = dst_mcfg->id.instance_id;
+	msg.dst_instance_id = dst_mcfg->id.pvt_id;
 	msg.bind = false;
 
 	ret = skl_ipc_bind_unbind(&ctx->ipc, &msg);
@@ -997,9 +999,9 @@ int skl_bind_modules(struct skl_sst *ctx,
 			 msg.src_queue, msg.dst_queue);
 
 	msg.module_id = src_mcfg->id.module_id;
-	msg.instance_id = src_mcfg->id.instance_id;
+	msg.instance_id = src_mcfg->id.pvt_id;
 	msg.dst_module_id = dst_mcfg->id.module_id;
-	msg.dst_instance_id = dst_mcfg->id.instance_id;
+	msg.dst_instance_id = dst_mcfg->id.pvt_id;
 	msg.bind = true;
 
 	ret = skl_ipc_bind_unbind(&ctx->ipc, &msg);
@@ -1177,7 +1179,7 @@ int skl_set_module_params(struct skl_sst *ctx, u32 *params, int size,
 	struct skl_ipc_large_config_msg msg;
 
 	msg.module_id = mcfg->id.module_id;
-	msg.instance_id = mcfg->id.instance_id;
+	msg.instance_id = mcfg->id.pvt_id;
 	msg.param_data_size = size;
 	msg.large_param_id = param_id;
 
@@ -1190,7 +1192,7 @@ int skl_get_module_params(struct skl_sst *ctx, u32 *params, int size,
 	struct skl_ipc_large_config_msg msg;
 
 	msg.module_id = mcfg->id.module_id;
-	msg.instance_id = mcfg->id.instance_id;
+	msg.instance_id = mcfg->id.pvt_id;
 	msg.param_data_size = size;
 	msg.large_param_id = param_id;
 
diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 5f1c203a448e..876b9e04e880 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -136,7 +136,7 @@ int snd_skl_get_module_info(struct skl_sst *ctx,
 EXPORT_SYMBOL_GPL(snd_skl_get_module_info);
 
 static inline int skl_getid_32(struct uuid_module *module, u64 *val,
-					int word1_mask, int word2_mask)
+				int word1_mask, int word2_mask)
 {
 	int index, max_inst, pvt_id;
 	u32 mask_val;
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 2d475b720963..b6fc374f38b5 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -505,12 +505,15 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 		 * FE/BE params
 		 */
 		skl_tplg_update_module_params(w, ctx);
-
+		mconfig->id.pvt_id = skl_get_pvt_id(ctx, mconfig);
+		if (mconfig->id.pvt_id < 0)
+			return ret;
 		skl_tplg_set_module_init_data(w);
 		ret = skl_init_module(ctx, mconfig);
-		if (ret < 0)
+		if (ret < 0) {
+			skl_put_pvt_id(ctx, mconfig);
 			return ret;
-
+		}
 		skl_tplg_alloc_pipe_mcps(skl, mconfig);
 		ret = skl_tplg_set_module_params(w, ctx);
 		if (ret < 0)
@@ -537,6 +540,7 @@ static int skl_tplg_unload_pipe_modules(struct skl_sst *ctx,
 			if (ret < 0)
 				return -EIO;
 		}
+		skl_put_pvt_id(ctx, mconfig);
 	}
 
 	/* no modules to unload in this path, so return */
-- 
2.9.3
