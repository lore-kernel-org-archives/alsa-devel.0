From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: fix type in debug message" to the asoc tree
Date: Mon, 17 Jul 2017 17:06:24 +0100
Message-ID: <E1dX8XQ-00056s-Vv@debutante>
References: <20170713230406.15854-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170713230406.15854-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, Dharageswari R <dharageswari.r@intel.com>, G Kranthi <gudishax.kranthikumar@intel.com>, Jayachandran B <jayachandran.b@intel.com>, Ramesh Babu <ramesh.babu@intel.com>, GuruprasadX Pawse <guruprasadx.pawse@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: fix type in debug message

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

>From d5c6d43b3d94e7bf421ec2aaf21b4b7c79fa1850 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 14 Jul 2017 00:04:06 +0100
Subject: [PATCH] ASoC: Intel: Skylake: fix type in debug message

Trivial fix to typo in debug message, dst_instacne should be
dst_instance

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index fb2f1f603f3c..c5b4e0a9946c 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -950,7 +950,7 @@ static void skl_dump_bind_info(struct skl_sst *ctx, struct skl_module_cfg
 {
 	dev_dbg(ctx->dev, "%s: src module_id = %d  src_instance=%d\n",
 		__func__, src_module->id.module_id, src_module->id.pvt_id);
-	dev_dbg(ctx->dev, "%s: dst_module=%d dst_instacne=%d\n", __func__,
+	dev_dbg(ctx->dev, "%s: dst_module=%d dst_instance=%d\n", __func__,
 		 dst_module->id.module_id, dst_module->id.pvt_id);
 
 	dev_dbg(ctx->dev, "src_module state = %d dst module state = %d\n",
-- 
2.13.2
