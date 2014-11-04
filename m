From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 3/5] ASoC: Intel: mrfld - add shim save
	restore
Date: Tue,  4 Nov 2014 11:01:06 +0530
Message-ID: <1415079068-4979-4-git-send-email-vinod.koul@intel.com>
References: <1415079068-4979-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D8002605E5
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 06:30:39 +0100 (CET)
In-Reply-To: <1415079068-4979-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

In ACPI platform we need to save few registers of Shim on suspend and
restore them on resume, so add handlers to do this

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index 1e9eda2..67c7c29 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -329,6 +329,34 @@ void sst_context_cleanup(struct intel_sst_drv *ctx)
 }
 EXPORT_SYMBOL_GPL(sst_context_cleanup);
 
+static inline void sst_save_shim64(struct intel_sst_drv *ctx,
+			    void __iomem *shim,
+			    struct sst_shim_regs64 *shim_regs)
+{
+	unsigned long irq_flags;
+
+	spin_lock_irqsave(&ctx->ipc_spin_lock, irq_flags);
+
+	shim_regs->imrx = sst_shim_read64(shim, SST_IMRX),
+
+	spin_unlock_irqrestore(&ctx->ipc_spin_lock, irq_flags);
+}
+
+static inline void sst_restore_shim64(struct intel_sst_drv *ctx,
+				      void __iomem *shim,
+				      struct sst_shim_regs64 *shim_regs)
+{
+	unsigned long irq_flags;
+
+	/*
+	 * we only need to restore IMRX for this case, rest will be
+	 * initialize by FW or driver when firmware is loaded
+	 */
+	spin_lock_irqsave(&ctx->ipc_spin_lock, irq_flags);
+	sst_shim_write64(shim, SST_IMRX, shim_regs->imrx),
+	spin_unlock_irqrestore(&ctx->ipc_spin_lock, irq_flags);
+}
+
 void sst_configure_runtime_pm(struct intel_sst_drv *ctx)
 {
 	pm_runtime_set_autosuspend_delay(ctx->dev, SST_SUSPEND_DELAY);
-- 
1.7.0.4
