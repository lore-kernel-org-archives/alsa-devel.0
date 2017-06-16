From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: intel: Use kvzalloc() for suspend buffers
Date: Fri, 16 Jun 2017 11:20:29 +0200
Message-ID: <20170616092029.13645-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 25BF92674CE
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 11:20:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Intel SST driver allocates lots of pages at suspend for saving the
firmware states, and this may occasionally lead to the allocation
error due to the high order, ending up with the suspend failure.

Use kvzalloc() so that it can fall back to vmalloc() gracefully.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/intel/atom/sst/sst.c | 22 +++++++++++-----------
 sound/soc/intel/atom/sst/sst.h |  8 ++++----
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index f9ba71315e33..b4aa5b6f79d9 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -499,23 +499,23 @@ static int intel_sst_suspend(struct device *dev)
 	fw_save = kzalloc(sizeof(*fw_save), GFP_KERNEL);
 	if (!fw_save)
 		return -ENOMEM;
-	fw_save->iram = kzalloc(ctx->iram_end - ctx->iram_base, GFP_KERNEL);
+	fw_save->iram = kvzalloc(ctx->iram_end - ctx->iram_base, GFP_KERNEL);
 	if (!fw_save->iram) {
 		ret = -ENOMEM;
 		goto iram;
 	}
-	fw_save->dram = kzalloc(ctx->dram_end - ctx->dram_base, GFP_KERNEL);
+	fw_save->dram = kvzalloc(ctx->dram_end - ctx->dram_base, GFP_KERNEL);
 	if (!fw_save->dram) {
 		ret = -ENOMEM;
 		goto dram;
 	}
-	fw_save->sram = kzalloc(SST_MAILBOX_SIZE, GFP_KERNEL);
+	fw_save->sram = kvzalloc(SST_MAILBOX_SIZE, GFP_KERNEL);
 	if (!fw_save->sram) {
 		ret = -ENOMEM;
 		goto sram;
 	}
 
-	fw_save->ddr = kzalloc(ctx->ddr_end - ctx->ddr_base, GFP_KERNEL);
+	fw_save->ddr = kvzalloc(ctx->ddr_end - ctx->ddr_base, GFP_KERNEL);
 	if (!fw_save->ddr) {
 		ret = -ENOMEM;
 		goto ddr;
@@ -530,11 +530,11 @@ static int intel_sst_suspend(struct device *dev)
 	ctx->ops->reset(ctx);
 	return 0;
 ddr:
-	kfree(fw_save->sram);
+	kvfree(fw_save->sram);
 sram:
-	kfree(fw_save->dram);
+	kvfree(fw_save->dram);
 dram:
-	kfree(fw_save->iram);
+	kvfree(fw_save->iram);
 iram:
 	kfree(fw_save);
 	return ret;
@@ -562,10 +562,10 @@ static int intel_sst_resume(struct device *dev)
 	memcpy32_toio(ctx->mailbox, fw_save->sram, SST_MAILBOX_SIZE);
 	memcpy32_toio(ctx->ddr, fw_save->ddr, ctx->ddr_end - ctx->ddr_base);
 
-	kfree(fw_save->sram);
-	kfree(fw_save->dram);
-	kfree(fw_save->iram);
-	kfree(fw_save->ddr);
+	kvfree(fw_save->sram);
+	kvfree(fw_save->dram);
+	kvfree(fw_save->iram);
+	kvfree(fw_save->ddr);
 	kfree(fw_save);
 
 	block = sst_create_block(ctx, 0, FW_DWNL_ID);
diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
index 5c9a51cc77aa..2ac1aa8e13d1 100644
--- a/sound/soc/intel/atom/sst/sst.h
+++ b/sound/soc/intel/atom/sst/sst.h
@@ -338,10 +338,10 @@ struct sst_shim_regs64 {
 };
 
 struct sst_fw_save {
-	void *iram;
-	void *dram;
-	void *sram;
-	void *ddr;
+	void *iram;	/* allocated via kvmalloc() */
+	void *dram;	/* allocated via kvmalloc() */
+	void *sram;	/* allocated via kvmalloc() */
+	void *ddr;	/* allocated via kvmalloc() */
 };
 
 /**
-- 
2.13.1
