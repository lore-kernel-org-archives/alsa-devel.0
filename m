From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sst: Remove unused function sst_restore_shim64()" to the asoc tree
Date: Wed, 24 May 2017 18:41:57 +0100
Message-ID: <E1dDaIH-0002qW-M4@debutante>
References: <20170523001258.81618-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170523001258.81618-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: sst: Remove unused function sst_restore_shim64()

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

>From 9a075265c6dc040e2946d21f4f9d082495bd5460 Mon Sep 17 00:00:00 2001
From: Matthias Kaehlcke <mka@chromium.org>
Date: Mon, 22 May 2017 17:12:58 -0700
Subject: [PATCH] ASoC: Intel: sst: Remove unused function sst_restore_shim64()

Looks like the function has never been used since it was added by commit
b0d94acd634a ("ASoC: Intel: mrfld - add shim save restore"). Removing it
fixes the following warning when building with clang:

sound/soc/intel/atom/sst/sst.c:360:20: error: unused function
    'sst_restore_shim64' [-Werror,-Wunused-function]

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index d97556a3772c..2d43b8693c0c 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -397,22 +397,6 @@ static inline void sst_save_shim64(struct intel_sst_drv *ctx,
 	spin_unlock_irqrestore(&ctx->ipc_spin_lock, irq_flags);
 }
 
-static inline void sst_restore_shim64(struct intel_sst_drv *ctx,
-				      void __iomem *shim,
-				      struct sst_shim_regs64 *shim_regs)
-{
-	unsigned long irq_flags;
-
-	/*
-	 * we only need to restore IMRX for this case, rest will be
-	 * initialize by FW or driver when firmware is loaded
-	 */
-	spin_lock_irqsave(&ctx->ipc_spin_lock, irq_flags);
-	sst_shim_write64(shim, SST_IMRX, shim_regs->imrx);
-	sst_shim_write64(shim, SST_CSR, shim_regs->csr);
-	spin_unlock_irqrestore(&ctx->ipc_spin_lock, irq_flags);
-}
-
 void sst_configure_runtime_pm(struct intel_sst_drv *ctx)
 {
 	pm_runtime_set_autosuspend_delay(ctx->dev, SST_SUSPEND_DELAY);
-- 
2.11.0
