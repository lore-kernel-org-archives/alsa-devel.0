From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Find uuids for Skylake"
	to the asoc tree
Date: Mon, 30 May 2016 18:39:03 +0100
Message-ID: <E1b7R9b-0000hb-Pr@debutante>
References: <1464610381-19416-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AECF0265AEC
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2016 19:39:08 +0200 (CEST)
In-Reply-To: <1464610381-19416-7-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Find uuids for Skylake

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

>From 06711051d2e02f54a3ba4c2c0f4ce096f45437b1 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 30 May 2016 17:43:00 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Find uuids for Skylake

SKylake uses different offset in manifest for parsing module
table. So invoke common parsing utility from skylake using
skylake offset.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index be2c42b815b7..6021fa6ed80d 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -68,6 +68,8 @@ static int skl_transfer_firmware(struct sst_dsp *ctx,
 	return ret;
 }
 
+#define SKL_ADSP_FW_BIN_HDR_OFFSET 0x284
+
 static int skl_load_base_firmware(struct sst_dsp *ctx)
 {
 	int ret = 0, i;
@@ -85,6 +87,16 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 			skl_dsp_disable_core(ctx);
 			return -EIO;
 		}
+
+	}
+
+	ret = snd_skl_parse_uuids(ctx, SKL_ADSP_FW_BIN_HDR_OFFSET);
+	if (ret < 0) {
+		dev_err(ctx->dev,
+				"UUID parsing err: %d\n", ret);
+		release_firmware(ctx->fw);
+		skl_dsp_disable_core(ctx);
+		return ret;
 	}
 
 	/* check for extended manifest */
@@ -416,6 +428,7 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 
 	skl->dev = dev;
 	skl_dev.thread_context = skl;
+	INIT_LIST_HEAD(&skl->uuid_list);
 
 	skl->dsp = skl_dsp_ctx_init(dev, &skl_dev, irq);
 	if (!skl->dsp) {
@@ -459,6 +472,7 @@ EXPORT_SYMBOL_GPL(skl_sst_dsp_init);
 void skl_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx)
 {
 	skl_clear_module_table(ctx->dsp);
+	skl_freeup_uuid_list(ctx);
 	skl_ipc_free(&ctx->ipc);
 	ctx->dsp->ops->free(ctx->dsp);
 	if (ctx->boot_complete) {
-- 
2.8.1
