From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: remove status, it is shadowing status of a higher scope" to the asoc tree
Date: Sat, 24 Sep 2016 22:57:58 -0700
Message-ID: <E1bo2Rq-0002nW-SZ@finisterre>
References: <20160909090929.27845-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160909090929.27845-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Jorge Fernandez Monteagudo <jorgefm@cirsa.com>, Sachin Mokashi <sachinx.mokashi@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: remove status, it is shadowing status of a higher scope

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

>From dc995069c675af71a2ecf2ade0995df084da3e2e Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 9 Sep 2016 10:09:29 +0100
Subject: [PATCH] ASoC: Intel: remove status, it is shadowing status of a
 higher scope

The second declaration of status is shadowing the status of a higher
scope.  This uninitialized status results in garbage being returned
by the !x86_match_cpu(cpu_ids) || !iosf_mbi_available() return exit
path.  Fix this by removing the extraneous second declaration of
status.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 9718e8249224..ba5c0d71720a 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -249,7 +249,6 @@ static int is_byt_cr(struct device *dev, bool *bytcr)
 			{ X86_VENDOR_INTEL, 6, 55 }, /* Valleyview, Bay Trail */
 			{}
 		};
-		int status;
 		u32 bios_status;
 
 		if (!x86_match_cpu(cpu_ids) || !iosf_mbi_available()) {
-- 
2.9.3
