From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 2/3] ASoC: Intel: Skylake: Support
	multi-core in Skylake
Date: Tue, 21 Jun 2016 10:17:42 +0530
Message-ID: <1466484463-9129-3-git-send-email-vinod.koul@intel.com>
References: <1466484463-9129-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 118F3265823
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2016 06:41:03 +0200 (CEST)
In-Reply-To: <1466484463-9129-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jayachandran B <jayachandran.b@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jayachandran B <jayachandran.b@intel.com>

Add multicore DSP support in Skylake DSP operations.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst.c | 77 ++++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 29 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index ecaca94d2a96..588f899ceb65 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -150,7 +150,6 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 		}
 
 		dev_dbg(ctx->dev, "Download firmware successful%d\n", ret);
-		skl_dsp_set_state_locked(ctx, SKL_DSP_RUNNING);
 		skl->fw_loaded = true;
 	}
 	return 0;
@@ -166,14 +165,41 @@ skl_load_base_firmware_failed:
 static int skl_set_dsp_D0(struct sst_dsp *ctx, unsigned int core_id)
 {
 	int ret;
+	struct skl_ipc_dxstate_info dx;
+	struct skl_sst *skl = ctx->thread_context;
+	unsigned int core_mask = SKL_DSP_CORE_MASK(core_id);
 
-	ret = skl_load_base_firmware(ctx);
-	if (ret < 0) {
-		dev_err(ctx->dev, "unable to load firmware\n");
-		return ret;
+	/* If core0 is being turned on, we need to load the FW */
+	if (core_id == SKL_DSP_CORE0_ID) {
+		ret = skl_load_base_firmware(ctx);
+		if (ret < 0) {
+			dev_err(ctx->dev, "unable to load firmware\n");
+			return ret;
+		}
+	}
+
+	/*
+	 * If any core other than core 0 is being moved to D0, enable the
+	 * core and send the set dx IPC for the core.
+	 */
+	if (core_id != SKL_DSP_CORE0_ID) {
+		ret = skl_dsp_enable_core(ctx, core_mask);
+		if (ret < 0)
+			return ret;
+
+		dx.core_mask = core_mask;
+		dx.dx_mask = core_mask;
+
+		ret = skl_ipc_set_dx(&skl->ipc, SKL_INSTANCE_ID,
+					SKL_BASE_FW_MODULE_ID, &dx);
+		if (ret < 0) {
+			dev_err(ctx->dev, "Failed to set dsp to D0:core id= %d\n",
+					core_id);
+			skl_dsp_disable_core(ctx, core_mask);
+		}
 	}
 
-	skl_dsp_set_state_locked(ctx, SKL_DSP_RUNNING);
+	skl->cores.state[core_id] = SKL_DSP_RUNNING;
 
 	return ret;
 }
@@ -183,35 +209,28 @@ static int skl_set_dsp_D3(struct sst_dsp *ctx, unsigned int core_id)
 	int ret;
 	struct skl_ipc_dxstate_info dx;
 	struct skl_sst *skl = ctx->thread_context;
+	unsigned int core_mask = SKL_DSP_CORE_MASK(core_id);
 
-	dev_dbg(ctx->dev, "In %s:\n", __func__);
-	mutex_lock(&ctx->mutex);
-	if (!is_skl_dsp_running(ctx)) {
-		mutex_unlock(&ctx->mutex);
-		return 0;
-	}
-	mutex_unlock(&ctx->mutex);
-
-	dx.core_mask = SKL_DSP_CORE0_MASK;
+	dx.core_mask = core_mask;
 	dx.dx_mask = SKL_IPC_D3_MASK;
+
 	ret = skl_ipc_set_dx(&skl->ipc, SKL_INSTANCE_ID, SKL_BASE_FW_MODULE_ID, &dx);
 	if (ret < 0)
-		dev_err(ctx->dev,
-			"D3 request to FW failed, continuing reset: %d", ret);
-
-	/* disable Interrupt */
-	ctx->cl_dev.ops.cl_cleanup_controller(ctx);
-	skl_cldma_int_disable(ctx);
-	skl_ipc_op_int_disable(ctx);
-	skl_ipc_int_disable(ctx);
-
-	ret = skl_dsp_disable_core(ctx, core_id);
-	if (ret < 0) {
-		dev_err(ctx->dev, "disable dsp core failed ret: %d\n", ret);
-		ret = -EIO;
+		dev_err(ctx->dev, "set Dx core %d fail: %d\n", core_id, ret);
+
+	if (core_id == SKL_DSP_CORE0_ID) {
+		/* disable Interrupt */
+		ctx->cl_dev.ops.cl_cleanup_controller(ctx);
+		skl_cldma_int_disable(ctx);
+		skl_ipc_op_int_disable(ctx);
+		skl_ipc_int_disable(ctx);
 	}
-	skl_dsp_set_state_locked(ctx, SKL_DSP_RESET);
 
+	ret = skl_dsp_disable_core(ctx, core_mask);
+	if (ret < 0)
+		return ret;
+
+	skl->cores.state[core_id] = SKL_DSP_RESET;
 	return ret;
 }
 
-- 
1.9.1
