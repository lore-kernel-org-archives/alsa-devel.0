From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix fw reload failure"
	to the asoc tree
Date: Thu, 14 Jul 2016 17:32:27 +0100
Message-ID: <E1bNjYp-0001Zd-Lg@debutante>
References: <1468467325-10118-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E63A266709
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 18:32:32 +0200 (CEST)
In-Reply-To: <1468467325-10118-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix fw reload failure

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

>From c78722676e92dd434de35c7569d6c3f25879621b Mon Sep 17 00:00:00 2001
From: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Date: Thu, 14 Jul 2016 09:05:25 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix fw reload failure

FW reload had two issues:
 - We need to disable the core 0 on when fw fails
 - Before loading firmware mark boot flag as false

This patch fixes these two

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 9c3750f49c21..16e2ed97d71a 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -139,7 +139,7 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
 base_fw_load_failed:
 	ctx->dsp_ops.cleanup(ctx->dev, &ctx->dmab, stream_tag);
 	skl_dsp_core_power_down(ctx, SKL_DSP_CORE_MASK(1));
-	skl_dsp_disable_core(ctx, SKL_DSP_CORE_MASK(1));
+	skl_dsp_disable_core(ctx, SKL_DSP_CORE0_MASK);
 	return ret;
 }
 
@@ -232,6 +232,7 @@ static int bxt_set_dsp_D0(struct sst_dsp *ctx, unsigned int core_id)
 	unsigned int core_mask = SKL_DSP_CORE_MASK(core_id);
 
 	if (skl->fw_loaded == false) {
+		skl->boot_complete = false;
 		ret = bxt_load_base_firmware(ctx);
 		if (ret < 0)
 			dev_err(ctx->dev, "reload fw failed: %d\n", ret);
-- 
2.8.1
