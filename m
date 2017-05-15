From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7213: Fix incorrect usage of bitwise '&' operator for SRM check" to the asoc tree
Date: Mon, 15 May 2017 17:02:49 +0900
Message-ID: <E1dAAxt-0002Rk-GB@finisterre>
References: <20170503151553.AC3FE3FB6C@swsrvapps-01.diasemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170503151553.AC3FE3FB6C@swsrvapps-01.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Support Opensource <support.opensource@diasemi.com>, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7213: Fix incorrect usage of bitwise '&' operator for SRM check

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

>From 14f814fbedd749992476bb365b454b2170b3b225 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Wed, 3 May 2017 16:15:53 +0100
Subject: [PATCH] ASoC: da7213: Fix incorrect usage of bitwise '&' operator for
 SRM check

In the SRM lock check section of code the '&' bitwise operator is
used as part of checking lock status. Functionally the code works
as intended, but the conditional statement is a boolean comparison
so should really use '&&' logical operator instead. This commit
rectifies this discrepancy.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7213.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 6dd7578f0bb8..024d83fa6a7f 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -772,7 +772,7 @@ static int da7213_dai_event(struct snd_soc_dapm_widget *w,
 				++i;
 				msleep(50);
 			}
-		} while ((i < DA7213_SRM_CHECK_RETRIES) & (!srm_lock));
+		} while ((i < DA7213_SRM_CHECK_RETRIES) && (!srm_lock));
 
 		if (!srm_lock)
 			dev_warn(codec->dev, "SRM failed to lock\n");
-- 
2.11.0
