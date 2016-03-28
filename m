From: jeeja.kp@intel.com
Subject: [PATCH 1/2] ASoC: Intel: Skylake: Fix for unloading
	module only when it is loaded
Date: Mon, 28 Mar 2016 22:11:30 +0530
Message-ID: <1459183291-16395-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B16E2619D7
 for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2016 05:13:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, vinod.koul@intel.com, patches.audio@intel.com
Cc: Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Module needs to be unloaded only when it is loaded successfully.
To fix this, first correct the module state sequence and set module
state to LOADED if module is loaded successfully.
When unloading the module check if module state is not in UNINIT,
then unload it.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 5 ++++-
 sound/soc/intel/skylake/skl-topology.h | 8 ++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 545b4e7..3f393cb 100644
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
index de3c401..d2d9230 100644
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
2.5.0
