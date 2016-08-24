From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/9] ASoC: Intel: Skylake: Unload all the
	loadable modules
Date: Wed, 24 Aug 2016 18:03:16 +0530
Message-ID: <1472042001-9582-5-git-send-email-vinod.koul@intel.com>
References: <1472042001-9582-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EF5A2675A0
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2016 14:25:36 +0200 (CEST)
In-Reply-To: <1472042001-9582-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Dharageswari R <dharageswari.r@intel.com>, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Dharageswari R <dharageswari.r@intel.com>

There could be more than one loadable module in a pipeline.
So unload all modules whilst parsing the list.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 6bceab8f0bac..2d475b720963 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -523,6 +523,7 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 static int skl_tplg_unload_pipe_modules(struct skl_sst *ctx,
 	 struct skl_pipe *pipe)
 {
+	int ret;
 	struct skl_pipe_module *w_module = NULL;
 	struct skl_module_cfg *mconfig = NULL;
 
@@ -530,9 +531,12 @@ static int skl_tplg_unload_pipe_modules(struct skl_sst *ctx,
 		mconfig  = w_module->w->priv;
 
 		if (mconfig->is_loadable && ctx->dsp->fw_ops.unload_mod &&
-			mconfig->m_state > SKL_MODULE_UNINIT)
-			return ctx->dsp->fw_ops.unload_mod(ctx->dsp,
+			mconfig->m_state > SKL_MODULE_UNINIT) {
+			ret = ctx->dsp->fw_ops.unload_mod(ctx->dsp,
 						mconfig->id.module_id);
+			if (ret < 0)
+				return -EIO;
+		}
 	}
 
 	/* no modules to unload in this path, so return */
-- 
1.9.1
