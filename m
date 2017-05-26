From: Douglas Anderson <dianders@chromium.org>
Subject: [RFC PATCH] ASoC: Intel: sst: Delete sst_save_shim64();
	saved regs are never used
Date: Fri, 26 May 2017 09:34:24 -0700
Message-ID: <20170526163424.2853-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f178.google.com (mail-pf0-f178.google.com
 [209.85.192.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 60F212668C9
 for <alsa-devel@alsa-project.org>; Fri, 26 May 2017 18:35:02 +0200 (CEST)
Received: by mail-pf0-f178.google.com with SMTP id n23so16134344pfb.2
 for <alsa-devel@alsa-project.org>; Fri, 26 May 2017 09:35:01 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Douglas Anderson <dianders@chromium.org>, lgirdwood@gmail.com, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, tiwai@suse.com, mka@chromium.org, colin.king@canonical.com, o-takashi@sakamocchi.jp, sebastien.guiriec@intel.com
List-Id: alsa-devel@alsa-project.org

In commit 9a075265c6dc ("ASoC: Intel: sst: Remove unused function
sst_restore_shim64()"), we deleted the sst_restore_shim64() since it
was never used.  ...but a quick look at the code shows that we should
also be able to remove the sst_save_shim64() function and the
structure members we were storing data in.

Note that the saving code (and the comments talking about how
important it is to do the save) has been around since
commit 336cfbb05edf ("ASoC: Intel: mrfld- add ACPI module").

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This problem was found only by code inspection and only compile
tested.  Hence, RFC.

 sound/soc/intel/atom/sst/sst.c | 19 -------------------
 sound/soc/intel/atom/sst/sst.h |  2 --
 2 files changed, 21 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index 2d43b8693c0c..5ee92257ca85 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -382,21 +382,6 @@ void sst_context_cleanup(struct intel_sst_drv *ctx)
 }
 EXPORT_SYMBOL_GPL(sst_context_cleanup);
 
-static inline void sst_save_shim64(struct intel_sst_drv *ctx,
-			    void __iomem *shim,
-			    struct sst_shim_regs64 *shim_regs)
-{
-	unsigned long irq_flags;
-
-	spin_lock_irqsave(&ctx->ipc_spin_lock, irq_flags);
-
-	shim_regs->imrx = sst_shim_read64(shim, SST_IMRX);
-	shim_regs->csr = sst_shim_read64(shim, SST_CSR);
-
-
-	spin_unlock_irqrestore(&ctx->ipc_spin_lock, irq_flags);
-}
-
 void sst_configure_runtime_pm(struct intel_sst_drv *ctx)
 {
 	pm_runtime_set_autosuspend_delay(ctx->dev, SST_SUSPEND_DELAY);
@@ -416,8 +401,6 @@ void sst_configure_runtime_pm(struct intel_sst_drv *ctx)
 		pm_runtime_set_active(ctx->dev);
 	else
 		pm_runtime_put_noidle(ctx->dev);
-
-	sst_save_shim64(ctx, ctx->shim, ctx->shim_regs64);
 }
 EXPORT_SYMBOL_GPL(sst_configure_runtime_pm);
 
@@ -441,8 +424,6 @@ static int intel_sst_runtime_suspend(struct device *dev)
 	flush_workqueue(ctx->post_msg_wq);
 
 	ctx->ops->reset(ctx);
-	/* save the shim registers because PMC doesn't save state */
-	sst_save_shim64(ctx, ctx->shim, ctx->shim_regs64);
 
 	return ret;
 }
diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
index 5c9a51cc77aa..d8cac09e8997 100644
--- a/sound/soc/intel/atom/sst/sst.h
+++ b/sound/soc/intel/atom/sst/sst.h
@@ -318,12 +318,10 @@ struct sst_ipc_reg {
 };
 
 struct sst_shim_regs64 {
-	u64 csr;
 	u64 pisr;
 	u64 pimr;
 	u64 isrx;
 	u64 isrd;
-	u64 imrx;
 	u64 imrd;
 	u64 ipcx;
 	u64 ipcd;
-- 
2.13.0.219.gdb65acc882-goog
