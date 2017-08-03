From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add dsp cores
	management" to the asoc tree
Date: Thu, 03 Aug 2017 17:30:19 +0100
Message-ID: <E1ddJ0t-0002Xr-Ql@debutante>
References: <20170802162120.8935-4-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0106D267418
 for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2017 18:30:30 +0200 (CEST)
In-Reply-To: <20170802162120.8935-4-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add dsp cores management

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

>From 4147a6e59a5c0b9cb0eeaa3e1f39fd9da491f35a Mon Sep 17 00:00:00 2001
From: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Date: Wed, 2 Aug 2017 21:51:14 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add dsp cores management

This patch adds support to manage additional cores on a demand basis.
For instance, if module is set to run on certain core, the particular
core is powered up in module init. The same is again powered down in
module unload.

Signed-off-by: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.13.2
