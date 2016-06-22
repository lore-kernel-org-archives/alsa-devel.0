From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Support multi-core in
	Skylake" to the asoc tree
Date: Wed, 22 Jun 2016 16:28:15 +0100
Message-ID: <E1bFk4d-0002Bo-9q@debutante>
References: <1466431812-9046-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CFB3266CF7
 for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2016 17:28:22 +0200 (CEST)
In-Reply-To: <1466431812-9046-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jayachandran B <jayachandran.b@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Support multi-core in Skylake

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 40a166039a84da15a6d01a7a997398eb4a0d3c1e Mon Sep 17 00:00:00 2001
From: Jayachandran B <jayachandran.b@intel.com>
Date: Tue, 21 Jun 2016 10:17:42 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Support multi-core in Skylake

Add multicore DSP support in Skylake DSP operations.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.8.1
