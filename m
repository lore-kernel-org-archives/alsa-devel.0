From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix for unloading
	module only when it is loaded" to the asoc tree
Date: Tue, 29 Mar 2016 00:38:52 -0700
Message-ID: <E1akoEm-0007Dw-JZ@finisterre>
References: <1459183291-16395-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 968DE2615F7
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 09:39:08 +0200 (CEST)
In-Reply-To: <1459183291-16395-1-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix for unloading module only when it is loaded

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

>From d643678b9a4e432a574b2ec601216afd720c69b6 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Mon, 28 Mar 2016 22:11:30 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix for unloading module only when it
 is loaded

Module needs to be unloaded only when it is loaded successfully.
To fix this, first correct the module state sequence and set module
state to LOADED if module is loaded successfully.
When unloading the module check if module state is not in UNINIT,
then unload it.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 5 ++++-
 sound/soc/intel/skylake/skl-topology.h | 8 ++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 545b4e77b8aa..3f393cbe1bfe 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -490,6 +490,8 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 				mconfig->id.module_id, mconfig->guid);
 			if (ret < 0)
 				return ret;
+
+			mconfig->m_state = SKL_MODULE_LOADED;
 		}
 
 		/* update blob if blob is null for be with default value */
@@ -524,7 +526,8 @@ static int skl_tplg_unload_pipe_modules(struct skl_sst *ctx,
 	list_for_each_entry(w_module, &pipe->w_list, node) {
 		mconfig  = w_module->w->priv;
 
-		if (mconfig->is_loadable && ctx->dsp->fw_ops.unload_mod)
+		if (mconfig->is_loadable && ctx->dsp->fw_ops.unload_mod &&
+			mconfig->m_state > SKL_MODULE_UNINIT)
 			return ctx->dsp->fw_ops.unload_mod(ctx->dsp,
 						mconfig->id.module_id);
 	}
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index de3c401284d9..d2d923002d5c 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -274,10 +274,10 @@ struct skl_pipe {
 
 enum skl_module_state {
 	SKL_MODULE_UNINIT = 0,
-	SKL_MODULE_INIT_DONE = 1,
-	SKL_MODULE_LOADED = 2,
-	SKL_MODULE_UNLOADED = 3,
-	SKL_MODULE_BIND_DONE = 4
+	SKL_MODULE_LOADED = 1,
+	SKL_MODULE_INIT_DONE = 2,
+	SKL_MODULE_BIND_DONE = 3,
+	SKL_MODULE_UNLOADED = 4,
 };
 
 struct skl_module_cfg {
-- 
2.8.0.rc3
