From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 08/13] ASoC: Intel: reset the DSP while
	suspending
Date: Thu, 12 Feb 2015 10:00:00 +0530
Message-ID: <1423715405-4562-9-git-send-email-vinod.koul@intel.com>
References: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7189026513A
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

The manual recommends that we reset the DSP when we suspend so add that in
runtime suspend handler

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index 0fb1b0ea164c..ea85789641f2 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -412,6 +412,7 @@ static int intel_sst_runtime_suspend(struct device *dev)
 	synchronize_irq(ctx->irq_num);
 	flush_workqueue(ctx->post_msg_wq);
 
+	ctx->ops->reset(ctx);
 	/* save the shim registers because PMC doesn't save state */
 	sst_save_shim64(ctx, ctx->shim, ctx->shim_regs64);
 
-- 
1.7.9.5
