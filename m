From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: remove second duplicated assignment to pointer 'res'" to the asoc tree
Date: Wed, 17 Jan 2018 11:24:01 +0000
Message-ID: <E1eblp3-0003i2-8z@debutante>
References: <20180117101708.11698-1-colin.king@canonical.com>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20180117101708.11698-1-colin.king@canonical.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: remove second duplicated assignment to pointer 'res'

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From fb2fcaeaad504ae9dad26f7b26a8ea840d00535f Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 17 Jan 2018 10:17:08 +0000
Subject: [PATCH] ASoC: Intel: remove second duplicated assignment to pointer
 'res'

The second assignment to res is identical to the previous assignment
so it is redundant and can be removed.

Cleans up clang warning:
sound/soc/intel/skylake/skl-topology.c:191:25: warning: Value stored to
'res' during its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 28bc16a8e09a..73af6e19ebbd 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -190,7 +190,6 @@ skl_tplg_free_pipe_mcps(struct skl *skl, struct skl_module_cfg *mconfig)
 	u8 res_idx = mconfig->res_idx;
 	struct skl_module_res *res = &mconfig->module->resources[res_idx];
 
-	res = &mconfig->module->resources[res_idx];
 	skl->resource.mcps -= res->cps;
 }
 
-- 
2.15.1

