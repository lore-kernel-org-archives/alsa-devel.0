From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Find uuids for Broxton"
	to the asoc tree
Date: Mon, 30 May 2016 18:39:00 +0100
Message-ID: <E1b7R9Y-0000gg-LZ@debutante>
References: <1464610381-19416-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F6CC2607F7
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2016 19:39:08 +0200 (CEST)
In-Reply-To: <1464610381-19416-8-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Find uuids for Broxton

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

>From 3467a64dded3bcdbff8c3c9db2b1f1af20a9e295 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 30 May 2016 17:43:01 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Find uuids for Broxton

Broxton uses different offset in manifest for parsing module
table. So invoke common parsing utility from broxton using
broxton offset.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 0dd921349663..46235b93e4f8 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -130,6 +130,8 @@ static int sst_transfer_fw_host_dma(struct sst_dsp *ctx)
 	return ret;
 }
 
+#define BXT_ADSP_FW_BIN_HDR_OFFSET 0x2000
+
 static int bxt_load_base_firmware(struct sst_dsp *ctx)
 {
 	struct firmware stripped_fw;
@@ -146,6 +148,9 @@ static int bxt_load_base_firmware(struct sst_dsp *ctx)
 	if (ctx->fw == NULL)
 		goto sst_load_base_firmware_failed;
 
+	ret = snd_skl_parse_uuids(ctx, BXT_ADSP_FW_BIN_HDR_OFFSET);
+	if (ret < 0)
+		goto sst_load_base_firmware_failed;
 
 	stripped_fw.data = ctx->fw->data;
 	stripped_fw.size = ctx->fw->size;
@@ -283,6 +288,7 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 
 	skl->dev = dev;
 	skl_dev.thread_context = skl;
+	INIT_LIST_HEAD(&skl->uuid_list);
 
 	skl->dsp = skl_dsp_ctx_init(dev, &skl_dev, irq);
 	if (!skl->dsp) {
@@ -323,6 +329,7 @@ EXPORT_SYMBOL_GPL(bxt_sst_dsp_init);
 
 void bxt_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx)
 {
+	skl_freeup_uuid_list(ctx);
 	skl_ipc_free(&ctx->ipc);
 	ctx->dsp->cl_dev.ops.cl_cleanup_controller(ctx->dsp);
 
-- 
2.8.1
