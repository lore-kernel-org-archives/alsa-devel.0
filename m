From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: add in missing loop counter to avoid infinite loop" to the asoc tree
Date: Mon, 10 Jul 2017 19:42:11 +0100
Message-ID: <E1dUddL-0000E0-M0@debutante>
References: <20170710152045.28898-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170710152045.28898-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: add in missing loop counter to avoid infinite loop

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

>From 6afb505c23e91a7c566705f1dd60228704501778 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Mon, 10 Jul 2017 16:20:45 +0100
Subject: [PATCH] ASoC: rt5663: add in missing loop counter to avoid infinite
 loop

The loop counter 'count' is missing an increment, so we could end up
with an infinite loop.  Add in a pre-increment to count to fix this.

Detected by CoverityScan, CID#1450120 ("Logically Dead Code")

Fixes: 1a425dbf1a10 ("ASoC: rt5663: Update the calibration funciton")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 82edbcf39caa..5b3c50c641d8 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3044,7 +3044,7 @@ static void rt5663_calibrate(struct rt5663_priv *rt5663)
 		else
 			break;
 
-		if (count > 200)
+		if (++count > 200)
 			break;
 	}
 
-- 
2.13.2
