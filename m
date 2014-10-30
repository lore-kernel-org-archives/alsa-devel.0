From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 8/9] ASoC: Intel: add shim save context and
	restore routines
Date: Thu, 30 Oct 2014 16:21:51 +0530
Message-ID: <1414666312-4657-9-git-send-email-vinod.koul@intel.com>
References: <1414666312-4657-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 009C02654B8
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 12:32:49 +0100 (CET)
In-Reply-To: <1414666312-4657-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>

Some ACPI platform require the driver to save the shim register content and
restore them after resume, so add the routines for these
The APCI patch will use these routines

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index 97c737a..82346a0 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -329,7 +329,49 @@ void sst_configure_runtime_pm(struct intel_sst_drv *ctx)
 	pm_runtime_put_noidle(ctx->dev);
 }
 
+inline void sst_save_shim64(struct intel_sst_drv *ctx,
+			    void __iomem *shim,
+			    struct sst_shim_regs64 *shim_regs)
+{
+	unsigned long irq_flags;
+
+	spin_lock_irqsave(&ctx->ipc_spin_lock, irq_flags);
+
+	shim_regs->csr = sst_shim_read64(shim, SST_CSR),
+	shim_regs->pisr = sst_shim_read64(shim, SST_PISR),
+	shim_regs->pimr = sst_shim_read64(shim, SST_PIMR),
+	shim_regs->isrx = sst_shim_read64(shim, SST_ISRX),
+	shim_regs->isrd = sst_shim_read64(shim, SST_ISRD),
+	shim_regs->imrx = sst_shim_read64(shim, SST_IMRX),
+	shim_regs->imrd = sst_shim_read64(shim, SST_IMRD),
+	shim_regs->ipcx = sst_shim_read64(shim, ctx->ipc_reg.ipcx),
+	shim_regs->ipcd = sst_shim_read64(shim, ctx->ipc_reg.ipcd),
+	shim_regs->isrsc = sst_shim_read64(shim, SST_ISRSC),
+	shim_regs->isrlpesc = sst_shim_read64(shim, SST_ISRLPESC),
+	shim_regs->imrsc = sst_shim_read64(shim, SST_IMRSC),
+	shim_regs->imrlpesc = sst_shim_read64(shim, SST_IMRLPESC),
+	shim_regs->ipcsc = sst_shim_read64(shim, SST_IPCSC),
+	shim_regs->ipclpesc = sst_shim_read64(shim, SST_IPCLPESC),
+	shim_regs->clkctl = sst_shim_read64(shim, SST_CLKCTL),
+	shim_regs->csr2 = sst_shim_read64(shim, SST_CSR2);
+
+	spin_unlock_irqrestore(&ctx->ipc_spin_lock, irq_flags);
+}
 
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
 
 static int intel_sst_runtime_suspend(struct device *dev)
 {
-- 
1.7.0.4
