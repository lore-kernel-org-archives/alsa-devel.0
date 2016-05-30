From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Strip manifest for
	Broxton platform" to the asoc tree
Date: Mon, 30 May 2016 18:39:09 +0100
Message-ID: <E1b7R9h-0000lO-VO@debutante>
References: <1464610381-19416-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BAEA265CB5
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2016 19:39:15 +0200 (CEST)
In-Reply-To: <1464610381-19416-5-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Ramesh Babu <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Strip manifest for Broxton platform

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

>From bf242d19d5549d52374f5026ad11ddd793fbd8fb Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 30 May 2016 17:42:58 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Strip manifest for Broxton platform

Broxton firmrware comes with extended manifest so invoke
skl_dsp_strip_extended_manifest() to check and strip

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index dd86232eea05..0dd921349663 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -132,6 +132,7 @@ static int sst_transfer_fw_host_dma(struct sst_dsp *ctx)
 
 static int bxt_load_base_firmware(struct sst_dsp *ctx)
 {
+	struct firmware stripped_fw;
 	struct skl_sst *skl = ctx->thread_context;
 	int ret;
 
@@ -141,10 +142,19 @@ static int bxt_load_base_firmware(struct sst_dsp *ctx)
 		goto sst_load_base_firmware_failed;
 	}
 
-	ret = sst_bxt_prepare_fw(ctx, ctx->fw->data, ctx->fw->size);
+	/* check for extended manifest */
+	if (ctx->fw == NULL)
+		goto sst_load_base_firmware_failed;
+
+
+	stripped_fw.data = ctx->fw->data;
+	stripped_fw.size = ctx->fw->size;
+	skl_dsp_strip_extended_manifest(&stripped_fw);
+
+	ret = sst_bxt_prepare_fw(ctx, stripped_fw.data, stripped_fw.size);
 	/* Retry Enabling core and ROM load. Retry seemed to help */
 	if (ret < 0) {
-		ret = sst_bxt_prepare_fw(ctx, ctx->fw->data, ctx->fw->size);
+		ret = sst_bxt_prepare_fw(ctx, stripped_fw.data, stripped_fw.size);
 		if (ret < 0) {
 			dev_err(ctx->dev, "Core En/ROM load fail:%d\n", ret);
 			goto sst_load_base_firmware_failed;
-- 
2.8.1
