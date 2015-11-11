From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/9] ASoC: Intel: Skylake: Fix cleanup of dma
	buffer
Date: Thu, 12 Nov 2015 00:16:44 +0530
Message-ID: <1447267609-27816-5-git-send-email-vinod.koul@intel.com>
References: <1447267609-27816-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 740162606A5
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 19:43:41 +0100 (CET)
In-Reply-To: <1447267609-27816-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

During firmware download, dma buffers are allocated in prepare
and never freed on clean up. This patch frees the allocated dma
buffer in cldma controller clean up.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-cldma.c | 5 +++++
 sound/soc/intel/skylake/skl-sst.c       | 9 +++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-cldma.c b/sound/soc/intel/skylake/skl-sst-cldma.c
index 44748ba98da2..f62dc339a1ce 100644
--- a/sound/soc/intel/skylake/skl-sst-cldma.c
+++ b/sound/soc/intel/skylake/skl-sst-cldma.c
@@ -137,6 +137,11 @@ static void skl_cldma_cleanup(struct sst_dsp  *ctx)
 
 	sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_CBL, 0);
 	sst_dsp_shim_write(ctx, SKL_ADSP_REG_CL_SD_LVI, 0);
+
+	if (&ctx->cl_dev.dmab_data)
+		ctx->dsp_ops.free_dma_buf(ctx->dev, &ctx->cl_dev.dmab_data);
+	if (&ctx->cl_dev.dmab_bdl)
+	ctx->dsp_ops.free_dma_buf(ctx->dev, &ctx->cl_dev.dmab_bdl);
 }
 
 static int skl_cldma_wait_interruptible(struct sst_dsp *ctx)
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 0c5039f2bd09..36dfc326d1fa 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -115,7 +115,7 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 		dev_err(ctx->dev,
 			"Timeout waiting for ROM init done, reg:0x%x\n", reg);
 		ret = -EIO;
-		goto skl_load_base_firmware_failed;
+		goto transfer_firmware_failed;
 	}
 
 	ret = skl_transfer_firmware(ctx, ctx->fw->data, ctx->fw->size);
@@ -128,15 +128,17 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 		if (ret == 0) {
 			dev_err(ctx->dev, "DSP boot failed, FW Ready timed-out\n");
 			ret = -EIO;
-			goto skl_load_base_firmware_failed;
+			goto transfer_firmware_failed;
 		}
 
 		dev_dbg(ctx->dev, "Download firmware successful%d\n", ret);
 		skl_dsp_set_state_locked(ctx, SKL_DSP_RUNNING);
 	}
 	return 0;
-
+transfer_firmware_failed:
+	ctx->cl_dev.ops.cl_cleanup_controller(ctx);
 skl_load_base_firmware_failed:
+	ctx->cl_dev.ops.cl_cleanup_controller(ctx);
 	skl_dsp_disable_core(ctx);
 	release_firmware(ctx->fw);
 	ctx->fw = NULL;
@@ -277,7 +279,6 @@ EXPORT_SYMBOL_GPL(skl_sst_dsp_init);
 void skl_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx)
 {
 	skl_ipc_free(&ctx->ipc);
-	ctx->dsp->cl_dev.ops.cl_cleanup_controller(ctx->dsp);
 	ctx->dsp->ops->free(ctx->dsp);
 }
 EXPORT_SYMBOL_GPL(skl_sst_dsp_cleanup);
-- 
1.9.1
