From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 10/13] ASoC: Intel: add pm support in sst ipc
	driver
Date: Thu, 12 Feb 2015 10:00:02 +0530
Message-ID: <1423715405-4562-11-git-send-email-vinod.koul@intel.com>
References: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id DE61C265134
 for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2015 05:32:58 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This adds support for system pm support. We need to save the dsp memory
which gets lost on suspend and restore that on resume

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst.c |  128 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/intel/sst/sst.h |    9 ++++
 2 files changed, 137 insertions(+)

diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index ea85789641f2..6f39f4d4e326 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -419,6 +419,83 @@ static int intel_sst_runtime_suspend(struct device *dev)
 	return ret;
 }
 
+static int intel_sst_suspend(struct device *dev)
+{
+	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+	struct sst_fw_save *fw_save;
+	int i, ret = 0;
+
+	/* check first if we are already in SW reset */
+	if (ctx->sst_state == SST_RESET)
+		return 0;
+
+	/*
+	 * check if any stream is active and running
+	 * they should already by suspend by soc_suspend
+	 */
+	for (i = 1; i <= ctx->info.max_streams; i++) {
+		struct stream_info *stream = &ctx->streams[i];
+
+		if (stream->status == STREAM_RUNNING) {
+			dev_err(dev, "stream %d is running, cant susupend, abort\n", i);
+			return -EBUSY;
+		}
+	}
+	synchronize_irq(ctx->irq_num);
+	flush_workqueue(ctx->post_msg_wq);
+
+	/* Move the SST state to Reset */
+	sst_set_fw_state_locked(ctx, SST_RESET);
+
+	/* tell DSP we are suspending */
+	if (ctx->ops->save_dsp_context(ctx))
+		return -EBUSY;
+
+	/* save the memories */
+	fw_save = kzalloc(sizeof(*fw_save), GFP_KERNEL);
+	if (!fw_save)
+		return -ENOMEM;
+	fw_save->iram = kzalloc(ctx->iram_end - ctx->iram_base, GFP_KERNEL);
+	if (!fw_save->iram) {
+		ret = -ENOMEM;
+		goto iram;
+	}
+	fw_save->dram = kzalloc(ctx->dram_end - ctx->dram_base, GFP_KERNEL);
+	if (!fw_save->dram) {
+		ret = -ENOMEM;
+		goto dram;
+	}
+	fw_save->sram = kzalloc(SST_MAILBOX_SIZE, GFP_KERNEL);
+	if (!fw_save->sram) {
+		ret = -ENOMEM;
+		goto sram;
+	}
+
+	fw_save->ddr = kzalloc(ctx->ddr_end - ctx->ddr_base, GFP_KERNEL);
+	if (!fw_save->ddr) {
+		ret = -ENOMEM;
+		goto ddr;
+	}
+
+	memcpy32_fromio(fw_save->iram, ctx->iram, ctx->iram_end - ctx->iram_base);
+	memcpy32_fromio(fw_save->dram, ctx->dram, ctx->dram_end - ctx->dram_base);
+	memcpy32_fromio(fw_save->sram, ctx->mailbox, SST_MAILBOX_SIZE);
+	memcpy32_fromio(fw_save->ddr, ctx->ddr, ctx->ddr_end - ctx->ddr_base);
+
+	ctx->fw_save = fw_save;
+	ctx->ops->reset(ctx);
+	return 0;
+ddr:
+	kfree(fw_save->sram);
+sram:
+	kfree(fw_save->dram);
+dram:
+	kfree(fw_save->iram);
+iram:
+	kfree(fw_save);
+	return ret;
+}
+
 static int intel_sst_runtime_resume(struct device *dev)
 {
 	int ret = 0;
@@ -434,7 +511,58 @@ static int intel_sst_runtime_resume(struct device *dev)
 	return ret;
 }
 
+static int intel_sst_resume(struct device *dev)
+{
+	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+	struct sst_fw_save *fw_save = ctx->fw_save;
+	int ret = 0;
+	struct sst_block *block;
+
+	if (!fw_save)
+		return intel_sst_runtime_resume(dev);
+
+	sst_set_fw_state_locked(ctx, SST_FW_LOADING);
+
+	/* we have to restore the memory saved */
+	ctx->ops->reset(ctx);
+
+	ctx->fw_save = NULL;
+
+	memcpy32_toio(ctx->iram, fw_save->iram, ctx->iram_end - ctx->iram_base);
+	memcpy32_toio(ctx->dram, fw_save->dram, ctx->dram_end - ctx->dram_base);
+	memcpy32_toio(ctx->mailbox, fw_save->sram, SST_MAILBOX_SIZE);
+	memcpy32_toio(ctx->ddr, fw_save->ddr, ctx->ddr_end - ctx->ddr_base);
+
+	kfree(fw_save->sram);
+	kfree(fw_save->dram);
+	kfree(fw_save->iram);
+	kfree(fw_save->ddr);
+	kfree(fw_save);
+
+	block = sst_create_block(ctx, 0, FW_DWNL_ID);
+	if (block == NULL)
+		return -ENOMEM;
+
+
+	/* start and wait for ack */
+	ctx->ops->start(ctx);
+	ret = sst_wait_timeout(ctx, block);
+	if (ret) {
+		dev_err(ctx->dev, "fw download failed %d\n", ret);
+		/* FW download failed due to timeout */
+		ret = -EBUSY;
+
+	} else {
+		sst_set_fw_state_locked(ctx, SST_FW_RUNNING);
+	}
+
+	sst_free_block(ctx, block);
+	return ret;
+}
+
 const struct dev_pm_ops intel_sst_pm = {
+	.suspend = intel_sst_suspend,
+	.resume = intel_sst_resume,
 	.runtime_suspend = intel_sst_runtime_suspend,
 	.runtime_resume = intel_sst_runtime_resume,
 };
diff --git a/sound/soc/intel/sst/sst.h b/sound/soc/intel/sst/sst.h
index 9fea01401e65..7b3eac426571 100644
--- a/sound/soc/intel/sst/sst.h
+++ b/sound/soc/intel/sst/sst.h
@@ -336,6 +336,13 @@ struct sst_shim_regs64 {
 	u64 csr2;
 };
 
+struct sst_fw_save {
+	void *iram;
+	void *dram;
+	void *sram;
+	void *ddr;
+};
+
 /**
  * struct intel_sst_drv - driver ops
  *
@@ -427,6 +434,8 @@ struct intel_sst_drv {
 	 * persistent till worker thread gets called
 	 */
 	char firmware_name[20];
+
+	struct sst_fw_save	*fw_save;
 };
 
 /* misc definitions */
-- 
1.7.9.5
