From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Atom: add terminate entry for dmi_system_id tables" to the asoc tree
Date: Mon, 24 Oct 2016 19:04:57 +0100
Message-ID: <E1byjcH-0001bc-M5@debutante>
References: <1477222869-31970-1-git-send-email-weiyj.lk@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477222869-31970-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jorge Fernandez Monteagudo <jorgefm@cirsa.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Colin Ian King <colin.king@canonical.com>, Sachin Mokashi <sachinx.mokashi@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Atom: add terminate entry for dmi_system_id tables

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

>From 4690481060f3c6b557b01f18319c6382f0fd63ab Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Sun, 23 Oct 2016 11:41:09 +0000
Subject: [PATCH] ASoC: Intel: Atom: add terminate entry for dmi_system_id
 tables

Make sure dmi_system_id tables are NULL terminated.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 4d3184971227..748a0f68fc6c 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -343,6 +343,7 @@ static const struct dmi_system_id cht_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Surface 3"),
 		},
 	},
+	{ }
 };
 
 
-- 
2.8.1
