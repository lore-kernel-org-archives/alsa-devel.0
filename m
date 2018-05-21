From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: skylake: fix spelling mistake: "Homogenous" -> "Homogeneous"" to the asoc tree
Date: Mon, 21 May 2018 16:50:39 +0100
Message-ID: <E1fKn55-0007We-Ju@debutante>
References: <20180521093548.18491-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180521093548.18491-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: skylake: fix spelling mistake: "Homogenous" -> "Homogeneous"

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

>From 7608102ee610cb4a65b38a4e1319e22c7ebeb04b Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Mon, 21 May 2018 10:35:48 +0100
Subject: [PATCH] ASoC: intel: skylake: fix spelling mistake: "Homogenous" ->
 "Homogeneous"

Trivial fix to spelling mistake in snprintf literal string

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
index a016455a6ddb..302b40e63e6c 100644
--- a/sound/soc/intel/skylake/skl-debug.c
+++ b/sound/soc/intel/skylake/skl-debug.c
@@ -142,8 +142,8 @@ static ssize_t module_read(struct file *file, char __user *user_buf,
 			mconfig->max_out_queue, ret, false);
 
 	ret += snprintf(buf + ret, MOD_BUF - ret,
-			"Other:\n\tDomain %d\n\tHomogenous Input %s\n\t"
-			"Homogenous Output %s\n\tIn Queue Mask %d\n\t"
+			"Other:\n\tDomain %d\n\tHomogeneous Input %s\n\t"
+			"Homogeneous Output %s\n\tIn Queue Mask %d\n\t"
 			"Out Queue Mask %d\n\tDMA ID %d\n\tMem Pages %d\n\t"
 			"Module Type %d\n\tModule State %d\n",
 			mconfig->domain,
-- 
2.17.0
