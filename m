From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/9] ASoC: Intel: move the lock and wq
	initialization to routine
Date: Thu, 30 Oct 2014 16:21:46 +0530
Message-ID: <1414666312-4657-4-git-send-email-vinod.koul@intel.com>
References: <1414666312-4657-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C7CA265307
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 12:32:37 +0100 (CET)
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

This will be used by APCI code as well, so moving to common routine helps

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index 253b917..7c9c65a 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -222,6 +222,14 @@ static int sst_workqueue_init(struct intel_sst_drv *ctx)
 	return 0;
 }
 
+static void sst_init_locks(struct intel_sst_drv *ctx)
+{
+	mutex_init(&ctx->sst_lock);
+	spin_lock_init(&ctx->rx_msg_lock);
+	spin_lock_init(&ctx->ipc_spin_lock);
+	spin_lock_init(&ctx->block_lock);
+}
+
 /*
 * intel_sst_probe - PCI probe function
 *
@@ -259,7 +267,7 @@ static int intel_sst_probe(struct pci_dev *pci,
 		return -EINVAL;
 
 	ops = sst_drv_ctx->ops;
-	mutex_init(&sst_drv_ctx->sst_lock);
+	sst_init_locks(sst_drv_ctx);
 
 	/* pvt_id 0 reserved for async messages */
 	sst_drv_ctx->pvt_id = 1;
@@ -270,10 +278,6 @@ static int intel_sst_probe(struct pci_dev *pci,
 	sst_drv_ctx->use_dma = 0;
 	sst_drv_ctx->use_lli = 0;
 
-	spin_lock_init(&sst_drv_ctx->ipc_spin_lock);
-	spin_lock_init(&sst_drv_ctx->block_lock);
-	spin_lock_init(&sst_drv_ctx->rx_msg_lock);
-
 	if (sst_workqueue_init(sst_drv_ctx))
 		return -EINVAL;
 
-- 
1.7.0.4
