From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix the NULL pointer
	exception in dsp_clean up" to the asoc tree
Date: Mon, 02 May 2016 12:03:42 +0100
Message-ID: <E1axBde-0001Yp-NN@debutante>
References: <1461849329-20364-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C4B72605F1
 for <alsa-devel@alsa-project.org>; Mon,  2 May 2016 13:03:47 +0200 (CEST)
In-Reply-To: <1461849329-20364-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, "Dharageswari.R" <dharageswari.r@intel.com>, Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix the NULL pointer exception in dsp_clean up

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

>From 95536d8c29985167e745ff0d8c7cd7dcf4318e6b Mon Sep 17 00:00:00 2001
From: "Dharageswari.R" <dharageswari.r@intel.com>
Date: Thu, 28 Apr 2016 18:45:25 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix the NULL pointer exception in
 dsp_clean up

If request firmware fails at init, the code loader DMA allocation
can be NULL, so check for boot complete before freeing up these
resources

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-dsp.c | 2 --
 sound/soc/intel/skylake/skl-sst.c     | 4 ++++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 2962ef22fc84..13c19855ee1a 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -336,8 +336,6 @@ void skl_dsp_free(struct sst_dsp *dsp)
 	skl_ipc_int_disable(dsp);
 
 	free_irq(dsp->irq, dsp);
-	dsp->cl_dev.ops.cl_cleanup_controller(dsp);
-	skl_cldma_int_disable(dsp);
 	skl_ipc_op_int_disable(dsp);
 	skl_ipc_int_disable(dsp);
 
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index bec4a7c486fd..13ec8d53b526 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -454,6 +454,10 @@ void skl_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx)
 	skl_clear_module_table(ctx->dsp);
 	skl_ipc_free(&ctx->ipc);
 	ctx->dsp->ops->free(ctx->dsp);
+	if (ctx->boot_complete) {
+		ctx->dsp->cl_dev.ops.cl_cleanup_controller(ctx->dsp);
+		skl_cldma_int_disable(ctx->dsp);
+	}
 }
 EXPORT_SYMBOL_GPL(skl_sst_dsp_cleanup);
 
-- 
2.8.1
