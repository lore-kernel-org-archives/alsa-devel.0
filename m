From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bxtn: Remove code loader
	reference in cleanup" to the asoc tree
Date: Tue, 01 Aug 2017 15:16:42 +0100
Message-ID: <E1dcXyU-0008PK-8a@debutante>
References: <20170728104216.26859-2-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 89B1126716A
 for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2017 16:16:51 +0200 (CEST)
In-Reply-To: <20170728104216.26859-2-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dronamraju Santosh P K <santosh.pavan.kumarx.dronamraju@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bxtn: Remove code loader reference in cleanup

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

>From 3fbbcf4dadb6c01d6411bac715a7448f96c3724c Mon Sep 17 00:00:00 2001
From: Dronamraju Santosh P K <santosh.pavan.kumarx.dronamraju@intel.com>
Date: Fri, 28 Jul 2017 16:12:14 +0530
Subject: [PATCH] ASoC: Intel: bxtn: Remove code loader reference in cleanup

Since Broxton does not use code loader DMA, remove code loader cleanup
in its dsp cleanup routine. Remove the iounmap too as it is done in
skl_free_dsp().

Signed-off-by: Dronamraju Santosh P K <santosh.pavan.kumarx.dronamraju@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index cf11b84888b9..08a2c5eb59fa 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -629,11 +629,6 @@ void bxt_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx)
 		release_firmware(ctx->dsp->fw);
 	skl_freeup_uuid_list(ctx);
 	skl_ipc_free(&ctx->ipc);
-	ctx->dsp->cl_dev.ops.cl_cleanup_controller(ctx->dsp);
-
-	if (ctx->dsp->addr.lpe)
-		iounmap(ctx->dsp->addr.lpe);
-
 	ctx->dsp->ops->free(ctx->dsp);
 }
 EXPORT_SYMBOL_GPL(bxt_sst_dsp_cleanup);
-- 
2.13.2
