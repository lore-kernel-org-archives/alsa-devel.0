From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Correct the runtime
	handler behaviour" to the asoc tree
Date: Fri, 09 Oct 2015 12:21:27 +0100
Message-ID: <E1ZkVjr-0006aQ-Ee@finisterre>
References: <1444377711-9720-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A71DC265158
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 13:21:45 +0200 (CEST)
In-Reply-To: <1444377711-9720-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Correct the runtime handler behaviour

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

>From 84c9e2836aa7c87b19a24de091c7e7cf16124645 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 9 Oct 2015 09:01:50 +0100
Subject: [PATCH] ASoC: Intel: Skylake: Correct the runtime handler behaviour

On runtime pm resume, we need to download the firmware, also on
suspend we need to ensure all the interrupts from controller and
DSP are disabled.

Also since we download the firmware on resume, we don't need to do
so on init, so remove that bit

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/sst-dsp-priv.h |  1 +
 sound/soc/intel/skylake/skl-sst-ipc.c | 12 ++++++++
 sound/soc/intel/skylake/skl-sst-ipc.h |  1 +
 sound/soc/intel/skylake/skl-sst.c     | 56 +++++++++++++++++++----------------
 4 files changed, 44 insertions(+), 26 deletions(-)

diff --git a/sound/soc/intel/common/sst-dsp-priv.h b/sound/soc/intel/common/sst-dsp-priv.h
index cbd568e..2151652 100644
--- a/sound/soc/intel/common/sst-dsp-priv.h
+++ b/sound/soc/intel/common/sst-dsp-priv.h
@@ -314,6 +314,7 @@ struct sst_dsp {
 	int sst_state;
 	struct skl_cl_dev cl_dev;
 	u32 intr_status;
+	const struct firmware *fw;
 };
 
 /* Size optimised DRAM/IRAM memcpy */
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 937a0a3..3345ea0 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -464,6 +464,18 @@ void skl_ipc_op_int_enable(struct sst_dsp *ctx)
 		SKL_ADSP_REG_HIPCCTL_BUSY, SKL_ADSP_REG_HIPCCTL_BUSY);
 }
 
+void skl_ipc_op_int_disable(struct sst_dsp *ctx)
+{
+	/* disable IPC DONE interrupt */
+	sst_dsp_shim_update_bits_unlocked(ctx, SKL_ADSP_REG_HIPCCTL,
+					SKL_ADSP_REG_HIPCCTL_DONE, 0);
+
+	/* Disable IPC BUSY interrupt */
+	sst_dsp_shim_update_bits_unlocked(ctx, SKL_ADSP_REG_HIPCCTL,
+					SKL_ADSP_REG_HIPCCTL_BUSY, 0);
+
+}
+
 bool skl_ipc_int_status(struct sst_dsp *ctx)
 {
 	return sst_dsp_shim_read_unlocked(ctx,
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index 9f5f672..f1a154e 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -116,6 +116,7 @@ int skl_ipc_set_large_config(struct sst_generic_ipc *ipc,
 
 void skl_ipc_int_enable(struct sst_dsp *dsp);
 void skl_ipc_op_int_enable(struct sst_dsp *ctx);
+void skl_ipc_op_int_disable(struct sst_dsp *ctx);
 void skl_ipc_int_disable(struct sst_dsp *dsp);
 
 bool skl_ipc_int_status(struct sst_dsp *dsp);
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index c18ea51..3b83dc9 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -70,15 +70,31 @@ static int skl_transfer_firmware(struct sst_dsp *ctx,
 static int skl_load_base_firmware(struct sst_dsp *ctx)
 {
 	int ret = 0, i;
-	const struct firmware *fw = NULL;
 	struct skl_sst *skl = ctx->thread_context;
 	u32 reg;
 
-	ret = request_firmware(&fw, "dsp_fw_release.bin", ctx->dev);
+	skl->boot_complete = false;
+	init_waitqueue_head(&skl->boot_wait);
+
+	if (ctx->fw == NULL) {
+		ret = request_firmware(&ctx->fw, "dsp_fw_release.bin", ctx->dev);
+		if (ret < 0) {
+			dev_err(ctx->dev, "Request firmware failed %d\n", ret);
+			skl_dsp_disable_core(ctx);
+			return -EIO;
+		}
+	}
+
+	ret = skl_dsp_boot(ctx);
 	if (ret < 0) {
-		dev_err(ctx->dev, "Request firmware failed %d\n", ret);
-		skl_dsp_disable_core(ctx);
-		return -EIO;
+		dev_err(ctx->dev, "Boot dsp core failed ret: %d", ret);
+		goto skl_load_base_firmware_failed;
+	}
+
+	ret = skl_cldma_prepare(ctx);
+	if (ret < 0) {
+		dev_err(ctx->dev, "CL dma prepare failed : %d", ret);
+		goto skl_load_base_firmware_failed;
 	}
 
 	/* enable Interrupt */
@@ -102,7 +118,7 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 		goto skl_load_base_firmware_failed;
 	}
 
-	ret = skl_transfer_firmware(ctx, fw->data, fw->size);
+	ret = skl_transfer_firmware(ctx, ctx->fw->data, ctx->fw->size);
 	if (ret < 0) {
 		dev_err(ctx->dev, "Transfer firmware failed%d\n", ret);
 		goto skl_load_base_firmware_failed;
@@ -118,13 +134,12 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 		dev_dbg(ctx->dev, "Download firmware successful%d\n", ret);
 		skl_dsp_set_state_locked(ctx, SKL_DSP_RUNNING);
 	}
-	release_firmware(fw);
-
 	return 0;
 
 skl_load_base_firmware_failed:
 	skl_dsp_disable_core(ctx);
-	release_firmware(fw);
+	release_firmware(ctx->fw);
+	ctx->fw = NULL;
 	return ret;
 }
 
@@ -172,6 +187,12 @@ static int skl_set_dsp_D3(struct sst_dsp *ctx)
 	}
 	skl_dsp_set_state_locked(ctx, SKL_DSP_RESET);
 
+	/* disable Interrupt */
+	ctx->cl_dev.ops.cl_cleanup_controller(ctx);
+	skl_cldma_int_disable(ctx);
+	skl_ipc_op_int_disable(ctx);
+	skl_ipc_int_disable(ctx);
+
 	return ret;
 }
 
@@ -235,22 +256,6 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	if (ret)
 		return ret;
 
-	skl->boot_complete = false;
-	init_waitqueue_head(&skl->boot_wait);
-
-	ret = skl_dsp_boot(sst);
-	if (ret < 0) {
-		dev_err(skl->dev, "Boot dsp core failed ret: %d", ret);
-		goto free_ipc;
-	}
-
-	ret = skl_cldma_prepare(sst);
-	if (ret < 0) {
-		dev_err(dev, "CL dma prepare failed : %d", ret);
-		goto free_ipc;
-	}
-
-
 	ret = sst->fw_ops.load_fw(sst);
 	if (ret < 0) {
 		dev_err(dev, "Load base fw failed : %d", ret);
@@ -262,7 +267,6 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 
 	return 0;
 
-free_ipc:
 	skl_ipc_free(&skl->ipc);
 	return ret;
 }
-- 
2.5.0
