From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add helper routines to
	handle module params" to the asoc tree
Date: Tue, 01 Dec 2015 22:59:40 +0000
Message-ID: <E1a3ttc-0006AX-5R@debutante>
References: <1448703121-5831-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C5F74266374
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 23:59:45 +0100 (CET)
In-Reply-To: <1448703121-5831-3-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Add helper routines to handle module params

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

>From 9939a9c331ae8b9f859802af352477388b73c700 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Sat, 28 Nov 2015 15:01:47 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add helper routines to handle module
 params

Some DSP modules have user configurable parameters. These
parameters are required by modules in the following scenario
	-  during initialization
	-  after initialization using set parameter

This patch adds helper routine to set module parameters using
large config set IPC message and removes params to be passed as
init module routine.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 16 +++++++++++++++-
 sound/soc/intel/skylake/skl-topology.c |  2 +-
 sound/soc/intel/skylake/skl-topology.h |  6 ++++--
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index d71b58322cc7..30762734d859 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -556,7 +556,7 @@ static void skl_clear_module_state(struct skl_module_pin *mpin, int max,
  * invoke the DSP by sending IPC INIT_INSTANCE using ipc helper
  */
 int skl_init_module(struct skl_sst *ctx,
-			struct skl_module_cfg *mconfig, char *param)
+			struct skl_module_cfg *mconfig)
 {
 	u16 module_config_size = 0;
 	void *param_data = NULL;
@@ -855,3 +855,17 @@ int skl_stop_pipe(struct skl_sst *ctx, struct skl_pipe *pipe)
 
 	return 0;
 }
+
+/* Algo parameter set helper function */
+int skl_set_module_params(struct skl_sst *ctx, u32 *params, int size,
+				u32 param_id, struct skl_module_cfg *mcfg)
+{
+	struct skl_ipc_large_config_msg msg;
+
+	msg.module_id = mcfg->id.module_id;
+	msg.instance_id = mcfg->id.instance_id;
+	msg.param_data_size = size;
+	msg.large_param_id = param_id;
+
+	return skl_ipc_set_large_config(&ctx->ipc, &msg, params);
+}
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index f221c758d601..7a03bea48a9a 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -340,7 +340,7 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 		 * FE/BE params
 		 */
 		skl_tplg_update_module_params(w, ctx);
-		ret = skl_init_module(ctx, mconfig, NULL);
+		ret = skl_init_module(ctx, mconfig);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 57cb7b8dd269..5ba985b36227 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -312,8 +312,7 @@ int skl_delete_pipe(struct skl_sst *ctx, struct skl_pipe *pipe);
 
 int skl_stop_pipe(struct skl_sst *ctx, struct skl_pipe *pipe);
 
-int skl_init_module(struct skl_sst *ctx, struct skl_module_cfg *module_config,
-	char *param);
+int skl_init_module(struct skl_sst *ctx, struct skl_module_cfg *module_config);
 
 int skl_bind_modules(struct skl_sst *ctx, struct skl_module_cfg
 	*src_module, struct skl_module_cfg *dst_module);
@@ -321,5 +320,8 @@ int skl_bind_modules(struct skl_sst *ctx, struct skl_module_cfg
 int skl_unbind_modules(struct skl_sst *ctx, struct skl_module_cfg
 	*src_module, struct skl_module_cfg *dst_module);
 
+int skl_set_module_params(struct skl_sst *ctx, u32 *params, int size,
+			u32 param_id, struct skl_module_cfg *mcfg);
+
 enum skl_bitdepth skl_get_bit_depth(int params);
 #endif
-- 
2.6.2
