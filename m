From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 3/9] ASoC: Intel: Skylake: Add dsp cores
	management
Date: Wed,  2 Aug 2017 21:51:14 +0530
Message-ID: <20170802162120.8935-4-guneshwor.o.singh@intel.com>
References: <20170802162120.8935-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 71DDE267351
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 18:25:31 +0200 (CEST)
In-Reply-To: <20170802162120.8935-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>

This patch adds support to manage additional cores on a demand basis.
For instance, if module is set to run on certain core, the particular
core is powered up in module init. The same is again powered down in
module unload.

Signed-off-by: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 8c3ce08f366d..350d2387f737 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -596,24 +596,35 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 		if (mconfig->id.pvt_id < 0)
 			return ret;
 		skl_tplg_set_module_init_data(w);
+
+		ret = skl_dsp_get_core(ctx->dsp, mconfig->core_id);
+		if (ret < 0) {
+			dev_err(ctx->dev, "Failed to wake up core %d ret=%d\n",
+						mconfig->core_id, ret);
+			return ret;
+		}
+
 		ret = skl_init_module(ctx, mconfig);
 		if (ret < 0) {
 			skl_put_pvt_id(ctx, uuid_mod, &mconfig->id.pvt_id);
-			return ret;
+			goto err;
 		}
 		skl_tplg_alloc_pipe_mcps(skl, mconfig);
 		ret = skl_tplg_set_module_params(w, ctx);
 		if (ret < 0)
-			return ret;
+			goto err;
 	}
 
 	return 0;
+err:
+	skl_dsp_put_core(ctx->dsp, mconfig->core_id);
+	return ret;
 }
 
 static int skl_tplg_unload_pipe_modules(struct skl_sst *ctx,
 	 struct skl_pipe *pipe)
 {
-	int ret;
+	int ret = 0;
 	struct skl_pipe_module *w_module = NULL;
 	struct skl_module_cfg *mconfig = NULL;
 
@@ -630,10 +641,17 @@ static int skl_tplg_unload_pipe_modules(struct skl_sst *ctx,
 				return -EIO;
 		}
 		skl_put_pvt_id(ctx, uuid_mod, &mconfig->id.pvt_id);
+
+		ret = skl_dsp_put_core(ctx->dsp, mconfig->core_id);
+		if (ret < 0) {
+			/* don't return; continue with other modules */
+			dev_err(ctx->dev, "Failed to sleep core %d ret=%d\n",
+				mconfig->core_id, ret);
+		}
 	}
 
 	/* no modules to unload in this path, so return */
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.13.0
