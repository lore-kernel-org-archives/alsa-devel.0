From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] ASoC: Intel: sst: Remove unused function sst_restore_shim64()
Date: Mon, 22 May 2017 17:12:58 -0700
Message-ID: <20170523001258.81618-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: alsa-devel@alsa-project.org

Looks like the function has never been used since it was added by commit
b0d94acd634a ("ASoC: Intel: mrfld - add shim save restore"). Removing it
fixes the following warning when building with clang:

sound/soc/intel/atom/sst/sst.c:360:20: error: unused function
    'sst_restore_shim64' [-Werror,-Wunused-function]

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 sound/soc/intel/atom/sst/sst.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index f9ba71315e33..fb608d3a90c8 100644
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
2.13.0.303.g4ebf302169-goog
