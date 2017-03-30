From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bxtn: fix spelling mistake: "Timout" -> "Timeout"" to the asoc tree
Date: Thu, 30 Mar 2017 22:23:06 +0100
Message-ID: <E1cthX8-0008Bl-JD@debutante>
References: <20170330100934.19887-1-colin.king@canonical.com>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170330100934.19887-1-colin.king@canonical.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Jayachandran B <jayachandran.b@intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, Ramesh Babu <ramesh.babu@intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bxtn: fix spelling mistake: "Timout" -> "Timeout"

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

>From 5f75b19ef99054736aa80b70dbdf2f7a86a22007 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 30 Mar 2017 11:09:34 +0100
Subject: [PATCH] ASoC: Intel: bxtn: fix spelling mistake: "Timout" ->
 "Timeout"

trivial fix to spelling mistake in dev_err error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 600d95891996..268bdaec8042 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -171,7 +171,7 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
 					SKL_ADSP_REG_HIPCIE_DONE,
 					BXT_INIT_TIMEOUT, "HIPCIE Done");
 	if (ret < 0) {
-		dev_err(ctx->dev, "Timout for Purge Request%d\n", ret);
+		dev_err(ctx->dev, "Timeout for Purge Request%d\n", ret);
 		goto base_fw_load_failed;
 	}
 
-- 
2.11.0

