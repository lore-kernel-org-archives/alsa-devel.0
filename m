From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: Use kvzalloc() for suspend
	buffers" to the asoc tree
Date: Fri, 16 Jun 2017 18:50:34 +0100
Message-ID: <E1dLvOE-0005mb-Ju@debutante>
References: <20170616092029.13645-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A985266D57
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 19:51:15 +0200 (CEST)
In-Reply-To: <20170616092029.13645-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: Use kvzalloc() for suspend buffers

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

>From 75bd90860a1f6d4671403f5b7beb9c4430ca9750 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Fri, 16 Jun 2017 11:20:29 +0200
Subject: [PATCH] ASoC: intel: Use kvzalloc() for suspend buffers

Intel SST driver allocates lots of pages at suspend for saving the
firmware states, and this may occasionally lead to the allocation
error due to the high order, ending up with the suspend failure.

Use kvzalloc() so that it can fall back to vmalloc() gracefully.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst.c | 22 +++++++++++-----------
 sound/soc/intel/atom/sst/sst.h |  8 ++++----
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index 5ee92257ca85..8afdff457579 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -464,23 +464,23 @@ static int intel_sst_suspend(struct device *dev)
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
@@ -495,11 +495,11 @@ static int intel_sst_suspend(struct device *dev)
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
@@ -527,10 +527,10 @@ static int intel_sst_resume(struct device *dev)
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
index 1693befa455a..e02e2b4cc08f 100644
--- a/sound/soc/intel/atom/sst/sst.h
+++ b/sound/soc/intel/atom/sst/sst.h
@@ -318,10 +318,10 @@ struct sst_ipc_reg {
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
2.11.0
