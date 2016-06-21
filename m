From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 3/3] ASoC: Intel: Skylake: Support
	multi-core in Broxton
Date: Tue, 21 Jun 2016 10:17:43 +0530
Message-ID: <1466484463-9129-4-git-send-email-vinod.koul@intel.com>
References: <1466484463-9129-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id EE72526584E
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2016 06:41:05 +0200 (CEST)
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

Add multicore DSP support in Broxton DSP operations.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c | 144 +++++++++++++++++++++++++++-----------
 1 file changed, 103 insertions(+), 41 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index c3dc1c4f1fad..f53868956f39 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -37,11 +37,19 @@
 
 #define BXT_ADSP_SRAM1_BASE	0xA0000
 
+#define BXT_INSTANCE_ID 0
+#define BXT_BASE_FW_MODULE_ID 0
+
 static unsigned int bxt_get_errorcode(struct sst_dsp *ctx)
 {
 	 return sst_dsp_shim_read(ctx, BXT_ADSP_ERROR_CODE);
 }
 
+/*
+ * First boot sequence has some extra steps. Core 0 waits for power
+ * status on core 1, so power up core 1 also momentarily, keep it in
+ * reset/stall and then turn it off
+ */
 static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
 			const void *fwdata, u32 fwsize)
 {
@@ -49,7 +57,7 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
 	u32 reg;
 
 	stream_tag = ctx->dsp_ops.prepare(ctx->dev, 0x40, fwsize, &ctx->dmab);
-	if (stream_tag < 0) {
+	if (stream_tag <= 0) {
 		dev_err(ctx->dev, "Failed to prepare DMA FW loading err: %x\n",
 				stream_tag);
 		return stream_tag;
@@ -58,16 +66,19 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
 	ctx->dsp_ops.stream_tag = stream_tag;
 	memcpy(ctx->dmab.area, fwdata, fwsize);
 
-	ret = skl_dsp_core_power_up(ctx, SKL_DSP_CORE0_MASK);
+	/* Step 1: Power up core 0 and core1 */
+	ret = skl_dsp_core_power_up(ctx, SKL_DSP_CORE0_MASK |
+				SKL_DSP_CORE_MASK(1));
 	if (ret < 0) {
-		dev_err(ctx->dev, "Boot dsp core failed ret: %d\n", ret);
+		dev_err(ctx->dev, "dsp core0/1 power up failed\n");
 		goto base_fw_load_failed;
 	}
 
-	/* Purge FW request */
+	/* Step 2: Purge FW request */
 	sst_dsp_shim_write(ctx, SKL_ADSP_REG_HIPCI, SKL_ADSP_REG_HIPCI_BUSY |
 				(BXT_IPC_PURGE_FW | ((stream_tag - 1) << 9)));
 
+	/* Step 3: Unset core0 reset state & unstall/run core0 */
 	ret = skl_dsp_start_core(ctx, SKL_DSP_CORE0_MASK);
 	if (ret < 0) {
 		dev_err(ctx->dev, "Start dsp core failed ret: %d\n", ret);
@@ -75,6 +86,7 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
 		goto base_fw_load_failed;
 	}
 
+	/* Step 4: Wait for DONE Bit */
 	for (i = BXT_INIT_TIMEOUT; i > 0; --i) {
 		reg = sst_dsp_shim_read(ctx, SKL_ADSP_REG_HIPCIE);
 
@@ -94,10 +106,18 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
 				SKL_ADSP_REG_HIPCIE_DONE);
 	}
 
-	/* enable Interrupt */
+	/* Step 5: power down core1 */
+	ret = skl_dsp_core_power_down(ctx, SKL_DSP_CORE_MASK(1));
+	if (ret < 0) {
+		dev_err(ctx->dev, "dsp core1 power down failed\n");
+		goto base_fw_load_failed;
+	}
+
+	/* Step 6: Enable Interrupt */
 	skl_ipc_int_enable(ctx);
 	skl_ipc_op_int_enable(ctx);
 
+	/* Step 7: Wait for ROM init */
 	for (i = BXT_INIT_TIMEOUT; i > 0; --i) {
 		if (SKL_FW_INIT ==
 				(sst_dsp_shim_read(ctx, BXT_ADSP_FW_STATUS) &
@@ -194,7 +214,6 @@ static int bxt_load_base_firmware(struct sst_dsp *ctx)
 			skl_dsp_disable_core(ctx, SKL_DSP_CORE0_MASK);
 			ret = -EIO;
 		} else {
-			skl_dsp_set_state_locked(ctx, SKL_DSP_RUNNING);
 			ret = 0;
 			skl->fw_loaded = true;
 		}
@@ -209,67 +228,110 @@ static int bxt_set_dsp_D0(struct sst_dsp *ctx, unsigned int core_id)
 {
 	struct skl_sst *skl = ctx->thread_context;
 	int ret;
-
-	skl->boot_complete = false;
+	struct skl_ipc_dxstate_info dx;
+	unsigned int core_mask = SKL_DSP_CORE_MASK(core_id);
 
 	if (skl->fw_loaded == false) {
-		dev_dbg(ctx->dev, "Re-loading fw\n");
 		ret = bxt_load_base_firmware(ctx);
 		if (ret < 0)
 			dev_err(ctx->dev, "reload fw failed: %d\n", ret);
 		return ret;
 	}
 
-	ret = skl_dsp_enable_core(ctx, SKL_DSP_CORE0_MASK);
-	if (ret < 0) {
-		dev_err(ctx->dev, "enable dsp core failed ret: %d\n", ret);
-		return ret;
+	/* If core 0 is being turned on, turn on core 1 as well */
+	if (core_id == SKL_DSP_CORE0_ID)
+		ret = skl_dsp_core_power_up(ctx, core_mask |
+				SKL_DSP_CORE_MASK(1));
+	else
+		ret = skl_dsp_core_power_up(ctx, core_mask);
+
+	if (ret < 0)
+		goto err;
+
+	if (core_id == SKL_DSP_CORE0_ID) {
+
+		/*
+		 * Enable interrupt after SPA is set and before
+		 * DSP is unstalled
+		 */
+		skl_ipc_int_enable(ctx);
+		skl_ipc_op_int_enable(ctx);
+		skl->boot_complete = false;
 	}
 
-	/* enable interrupt */
-	skl_ipc_int_enable(ctx);
-	skl_ipc_op_int_enable(ctx);
+	ret = skl_dsp_start_core(ctx, core_mask);
+	if (ret < 0)
+		goto err;
 
-	ret = wait_event_timeout(skl->boot_wait, skl->boot_complete,
-					msecs_to_jiffies(SKL_IPC_BOOT_MSECS));
-	if (ret == 0) {
-		dev_err(ctx->dev, "ipc: error DSP boot timeout\n");
-		dev_err(ctx->dev, "Error code=0x%x: FW status=0x%x\n",
-			sst_dsp_shim_read(ctx, BXT_ADSP_ERROR_CODE),
-			sst_dsp_shim_read(ctx, BXT_ADSP_FW_STATUS));
-		return -EIO;
+	if (core_id == SKL_DSP_CORE0_ID) {
+		ret = wait_event_timeout(skl->boot_wait,
+				skl->boot_complete,
+				msecs_to_jiffies(SKL_IPC_BOOT_MSECS));
+
+	/* If core 1 was turned on for booting core 0, turn it off */
+		skl_dsp_core_power_down(ctx, SKL_DSP_CORE_MASK(1));
+		if (ret == 0) {
+			dev_err(ctx->dev, "%s: DSP boot timeout\n", __func__);
+			dev_err(ctx->dev, "Error code=0x%x: FW status=0x%x\n",
+				sst_dsp_shim_read(ctx, BXT_ADSP_ERROR_CODE),
+				sst_dsp_shim_read(ctx, BXT_ADSP_FW_STATUS));
+			dev_err(ctx->dev, "Failed to set core0 to D0 state\n");
+			ret = -EIO;
+			goto err;
+		}
+	}
+
+	/* Tell FW if additional core in now On */
+
+	if (core_id != SKL_DSP_CORE0_ID) {
+		dx.core_mask = core_mask;
+		dx.dx_mask = core_mask;
+
+		ret = skl_ipc_set_dx(&skl->ipc, BXT_INSTANCE_ID,
+					BXT_BASE_FW_MODULE_ID, &dx);
+		if (ret < 0) {
+			dev_err(ctx->dev, "IPC set_dx for core %d fail: %d\n",
+								core_id, ret);
+			goto err;
+		}
 	}
 
-	skl_dsp_set_state_locked(ctx, SKL_DSP_RUNNING);
+	skl->cores.state[core_id] = SKL_DSP_RUNNING;
 	return 0;
+err:
+	if (core_id == SKL_DSP_CORE0_ID)
+		core_mask |= SKL_DSP_CORE_MASK(1);
+	skl_dsp_disable_core(ctx, core_mask);
+
+	return ret;
 }
 
 static int bxt_set_dsp_D3(struct sst_dsp *ctx, unsigned int core_id)
 {
+	int ret;
 	struct skl_ipc_dxstate_info dx;
 	struct skl_sst *skl = ctx->thread_context;
-	int ret = 0;
-
-	if (!is_skl_dsp_running(ctx))
-		return ret;
+	unsigned int core_mask = SKL_DSP_CORE_MASK(core_id);
 
-	dx.core_mask = SKL_DSP_CORE0_MASK;
+	dx.core_mask = core_mask;
 	dx.dx_mask = SKL_IPC_D3_MASK;
 
-	ret = skl_ipc_set_dx(&skl->ipc, SKL_INSTANCE_ID,
-				SKL_BASE_FW_MODULE_ID, &dx);
-	if (ret < 0) {
-		dev_err(ctx->dev, "Failed to set DSP to D3 state: %d\n", ret);
-		return ret;
-	}
+	dev_dbg(ctx->dev, "core mask=%x dx_mask=%x\n",
+			dx.core_mask, dx.dx_mask);
 
-	ret = skl_dsp_disable_core(ctx, SKL_DSP_CORE0_MASK);
+	ret = skl_ipc_set_dx(&skl->ipc, BXT_INSTANCE_ID,
+				BXT_BASE_FW_MODULE_ID, &dx);
+	if (ret < 0)
+		dev_err(ctx->dev,
+		"Failed to set DSP to D3:core id = %d;Continue reset\n",
+		core_id);
+
+	ret = skl_dsp_disable_core(ctx, core_mask);
 	if (ret < 0) {
-		dev_err(ctx->dev, "disbale dsp core failed: %d\n", ret);
-		ret = -EIO;
+		dev_err(ctx->dev, "Failed to disable core %d", ret);
+		return ret;
 	}
-
-	skl_dsp_set_state_locked(ctx, SKL_DSP_RESET);
+	skl->cores.state[core_id] = SKL_DSP_RESET;
 	return 0;
 }
 
-- 
1.9.1
