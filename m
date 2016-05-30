From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Strip manifest for
	Skylake platform" to the asoc tree
Date: Mon, 30 May 2016 18:39:13 +0100
Message-ID: <E1b7R9l-0000mX-2S@debutante>
References: <1464610381-19416-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CB832607F7
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2016 19:39:17 +0200 (CEST)
In-Reply-To: <1464610381-19416-4-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Strip manifest for Skylake platform

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

>From cd63655e8025eb9839b8aaf503e14f89da9d4f9e Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 30 May 2016 17:42:57 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Strip manifest for Skylake platform

Future firmware updates may comes with extended manifest so invoke
skl_dsp_strip_extended_manifest() to check and strip

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 13ec8d53b526..be2c42b815b7 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -72,6 +72,7 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 {
 	int ret = 0, i;
 	struct skl_sst *skl = ctx->thread_context;
+	struct firmware stripped_fw;
 	u32 reg;
 
 	skl->boot_complete = false;
@@ -86,6 +87,12 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 		}
 	}
 
+	/* check for extended manifest */
+	stripped_fw.data = ctx->fw->data;
+	stripped_fw.size = ctx->fw->size;
+
+	skl_dsp_strip_extended_manifest(&stripped_fw);
+
 	ret = skl_dsp_boot(ctx);
 	if (ret < 0) {
 		dev_err(ctx->dev, "Boot dsp core failed ret: %d", ret);
@@ -119,7 +126,7 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 		goto transfer_firmware_failed;
 	}
 
-	ret = skl_transfer_firmware(ctx, ctx->fw->data, ctx->fw->size);
+	ret = skl_transfer_firmware(ctx, stripped_fw.data, stripped_fw.size);
 	if (ret < 0) {
 		dev_err(ctx->dev, "Transfer firmware failed%d\n", ret);
 		goto transfer_firmware_failed;
-- 
2.8.1
