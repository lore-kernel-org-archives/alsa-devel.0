From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Parse UUIDs once" to
	the asoc tree
Date: Mon, 01 Aug 2016 18:07:13 +0100
Message-ID: <E1bUGgL-0006NI-GG@debutante>
References: <1469536610-27606-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C0E82660B3
 for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2016 19:07:20 +0200 (CEST)
In-Reply-To: <1469536610-27606-8-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Parse UUIDs once

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

>From c6703d023a4f380345a361f30b0af221e2dd0bd1 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 26 Jul 2016 18:06:45 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Parse UUIDs once

The firmware manifest contains UUIDs which needs to be passed only once.

So use the newly introduced is_first_boot flag to distinguish and parse
these only once.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 6e9c634cf84f..064fc7ee3d88 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -88,13 +88,15 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 		}
 	}
 
-	ret = snd_skl_parse_uuids(ctx, ctx->fw, SKL_ADSP_FW_BIN_HDR_OFFSET, 0);
-	if (ret < 0) {
-		dev_err(ctx->dev,
-				"UUID parsing err: %d\n", ret);
-		release_firmware(ctx->fw);
-		skl_dsp_disable_core(ctx, SKL_DSP_CORE0_MASK);
-		return ret;
+	/* prase uuids on first boot */
+	if (skl->is_first_boot) {
+		ret = snd_skl_parse_uuids(ctx, ctx->fw, SKL_ADSP_FW_BIN_HDR_OFFSET, 0);
+		if (ret < 0) {
+			dev_err(ctx->dev, "UUID parsing err: %d\n", ret);
+			release_firmware(ctx->fw);
+			skl_dsp_disable_core(ctx, SKL_DSP_CORE0_MASK);
+			return ret;
+		}
 	}
 
 	/* check for extended manifest */
-- 
2.8.1
