From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/5] ASoC: Intel: Skylake: Fix the NULL pointer
	exception in dsp_clean up
Date: Thu, 28 Apr 2016 18:45:25 +0530
Message-ID: <1461849329-20364-2-git-send-email-vinod.koul@intel.com>
References: <1461849329-20364-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A90F2667CB
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 15:10:42 +0200 (CEST)
In-Reply-To: <1461849329-20364-1-git-send-email-vinod.koul@intel.com>
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
Cc: "Dharageswari.R" <dharageswari.r@intel.com>, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Dharageswari.R" <dharageswari.r@intel.com>

If request firmware fails at init, the code loader DMA allocation
can be NULL, so check for boot complete before freeing up these
resources

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-dsp.c | 2 --
 sound/soc/intel/skylake/skl-sst.c     | 4 ++++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 2962ef22fc84..13c19855ee1a 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -336,8 +336,6 @@ void skl_dsp_free(struct sst_dsp *dsp)
 	skl_ipc_int_disable(dsp);
 
 	free_irq(dsp->irq, dsp);
-	dsp->cl_dev.ops.cl_cleanup_controller(dsp);
-	skl_cldma_int_disable(dsp);
 	skl_ipc_op_int_disable(dsp);
 	skl_ipc_int_disable(dsp);
 
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index df7964fd09c3..db3a45ee102b 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -463,6 +463,10 @@ void skl_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx)
 	skl_clear_module_table(ctx->dsp);
 	skl_ipc_free(&ctx->ipc);
 	ctx->dsp->ops->free(ctx->dsp);
+	if (ctx->boot_complete) {
+		ctx->dsp->cl_dev.ops.cl_cleanup_controller(ctx->dsp);
+		skl_cldma_int_disable(ctx->dsp);
+	}
 }
 EXPORT_SYMBOL_GPL(skl_sst_dsp_cleanup);
 
-- 
1.9.1
