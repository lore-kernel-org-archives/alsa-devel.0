From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix a shift wrapping bug" to the asoc tree
Date: Wed, 26 Oct 2016 11:15:42 +0100
Message-ID: <E1bzLFG-0004S1-KS@debutante>
References: <20161013085548.GK16198@mwanda>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20161013085548.GK16198@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Kranthi G <gudishax.kranthikumar@intel.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Dharageswari R <dharageswari.r@intel.com>, alsa-devel@alsa-project.orgVinod Koul <vinod.koul@intel.com>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Ramesh Babu <ramesh.babu@intel.com>, Colin Ian King <colin.king@canonical.com>Mark Brown <broonie@kernel.org>, Shreyas NC <shreyas.nc@intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix a shift wrapping bug

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

>From c8eabf821cac120afb78ca251b07cbf520406a7e Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 13 Oct 2016 11:55:48 +0300
Subject: [PATCH] ASoC: Intel: Skylake: Fix a shift wrapping bug

"*val" is a u64.  It definitely looks like we intend to use the high 32
bits as well.

Fixes: 700a9a63f9c1 ("ASoC: Intel: Skylake: Add module instance id generation APIs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Tested-by: Kranthi G <gudishax.kranthikumar@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 8dc03039b311..ea162fbf68e5 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -179,7 +179,7 @@ static inline int skl_getid_32(struct uuid_module *module, u64 *val,
 		index = ffz(mask_val);
 		pvt_id = index + word1_mask + word2_mask;
 		if (pvt_id <= (max_inst - 1)) {
-			*val |= 1 << (index + word1_mask);
+			*val |= 1ULL << (index + word1_mask);
 			return pvt_id;
 		}
 	}
-- 
2.8.1

