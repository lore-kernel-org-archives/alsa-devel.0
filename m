From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Don't use local pointer
	for firmware" to the asoc tree
Date: Mon, 30 May 2016 18:39:16 +0100
Message-ID: <E1b7R9o-0000nO-6N@debutante>
References: <1464610381-19416-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D892D265FFA
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2016 19:39:20 +0200 (CEST)
In-Reply-To: <1464610381-19416-3-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Don't use local pointer for firmware

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

>From fdfa82ee1435dc8ff6b4c82640bd142f2d15edb1 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 30 May 2016 17:42:56 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Don't use local pointer for firmware

We have firmware pointer is driver context, so use that instead
of local pointer.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 965ce40ce752..dd86232eea05 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -132,20 +132,19 @@ static int sst_transfer_fw_host_dma(struct sst_dsp *ctx)
 
 static int bxt_load_base_firmware(struct sst_dsp *ctx)
 {
-	const struct firmware *fw = NULL;
 	struct skl_sst *skl = ctx->thread_context;
 	int ret;
 
-	ret = request_firmware(&fw, ctx->fw_name, ctx->dev);
+	ret = request_firmware(&ctx->fw, ctx->fw_name, ctx->dev);
 	if (ret < 0) {
 		dev_err(ctx->dev, "Request firmware failed %d\n", ret);
 		goto sst_load_base_firmware_failed;
 	}
 
-	ret = sst_bxt_prepare_fw(ctx, fw->data, fw->size);
+	ret = sst_bxt_prepare_fw(ctx, ctx->fw->data, ctx->fw->size);
 	/* Retry Enabling core and ROM load. Retry seemed to help */
 	if (ret < 0) {
-		ret = sst_bxt_prepare_fw(ctx, fw->data, fw->size);
+		ret = sst_bxt_prepare_fw(ctx, ctx->fw->data, ctx->fw->size);
 		if (ret < 0) {
 			dev_err(ctx->dev, "Core En/ROM load fail:%d\n", ret);
 			goto sst_load_base_firmware_failed;
@@ -175,7 +174,7 @@ static int bxt_load_base_firmware(struct sst_dsp *ctx)
 	}
 
 sst_load_base_firmware_failed:
-	release_firmware(fw);
+	release_firmware(ctx->fw);
 	return ret;
 }
 
-- 
2.8.1
