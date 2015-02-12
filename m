From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 07/13] ASoC: Intel: save and restore the CSR
	register
Date: Thu, 12 Feb 2015 09:59:59 +0530
Message-ID: <1423715405-4562-8-git-send-email-vinod.koul@intel.com>
References: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 03DA826509E
 for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2015 05:32:57 +0100 (CET)
In-Reply-To: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The IPC driver saved only IMR register, we need to save the CSR as well, so
add it

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index 8a8d56a146e7..0fb1b0ea164c 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -350,7 +350,9 @@ static inline void sst_save_shim64(struct intel_sst_drv *ctx,
 
 	spin_lock_irqsave(&ctx->ipc_spin_lock, irq_flags);
 
-	shim_regs->imrx = sst_shim_read64(shim, SST_IMRX),
+	shim_regs->imrx = sst_shim_read64(shim, SST_IMRX);
+	shim_regs->csr = sst_shim_read64(shim, SST_CSR);
+
 
 	spin_unlock_irqrestore(&ctx->ipc_spin_lock, irq_flags);
 }
@@ -367,6 +369,7 @@ static inline void sst_restore_shim64(struct intel_sst_drv *ctx,
 	 */
 	spin_lock_irqsave(&ctx->ipc_spin_lock, irq_flags);
 	sst_shim_write64(shim, SST_IMRX, shim_regs->imrx),
+	sst_shim_write64(shim, SST_CSR, shim_regs->csr),
 	spin_unlock_irqrestore(&ctx->ipc_spin_lock, irq_flags);
 }
 
-- 
1.7.9.5
