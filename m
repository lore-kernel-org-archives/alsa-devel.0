From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7213: Allow PLL disable/bypass when using 32KHz sysclk" to the asoc tree
Date: Tue, 10 May 2016 19:48:52 +0100
Message-ID: <E1b0CiC-0006dH-EU@debutante>
References: <4af28c42abc15713e6746ea39d82869f98ddf771.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4af28c42abc15713e6746ea39d82869f98ddf771.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7213: Allow PLL disable/bypass when using 32KHz sysclk

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

>From abc189eadf6c12e60f95030e9c84083175526eaf Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 10 May 2016 16:11:08 +0100
Subject: [PATCH] ASoC: da7213: Allow PLL disable/bypass when using 32KHz
 sysclk

Current checking for PLL 32KHz mode fails in driver code when
bypassing the PLL. This is due to an incorrect check of PLL
source type when 32KHz clock is provided. Removal of this check
resolves the issue.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7213.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index a233fe7f12eb..e5527bc570ae 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1342,7 +1342,7 @@ static int da7213_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	pll_ctrl = 0;
 
 	/* Workout input divider based on MCLK rate */
-	if ((da7213->mclk_rate == 32768) && (source == DA7213_SYSCLK_PLL)) {
+	if (da7213->mclk_rate == 32768) {
 		/* 32KHz PLL Mode */
 		indiv_bits = DA7213_PLL_INDIV_9_TO_18_MHZ;
 		indiv = DA7213_PLL_INDIV_9_TO_18_MHZ_VAL;
-- 
2.8.1
