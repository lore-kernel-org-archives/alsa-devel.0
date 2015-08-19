From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Fix gain settings of FLL in free-run mode" to the asoc tree
Date: Wed, 19 Aug 2015 09:37:46 -0700
Message-ID: <E1ZS6N0-0007ul-Tn@finisterre>
References: <1439996544-21354-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1439996544-21354-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: stable-owner@vger.kernel.org
To: Nikesh Oswal <Nikesh.Oswal@wolfsonmicro.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Fix gain settings of FLL in free-run mode

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

>From 1cf5a330c05ae37a0a98ac7c9800a6f50d5579ec Mon Sep 17 00:00:00 2001
From: Nikesh Oswal <Nikesh.Oswal@wolfsonmicro.com>
Date: Wed, 19 Aug 2015 16:02:24 +0100
Subject: [PATCH] ASoC: arizona: Fix gain settings of FLL in free-run mode

The wrong register was used to set the gain of ref loop, when changing
the FLL output on an active FLL. This patch corrects the offset of the
gain register.

Signed-off-by: Nikesh Oswal <Nikesh.Oswal@wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/arizona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 802e05e..4e5d0a9 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2058,7 +2058,7 @@ static int arizona_enable_fll(struct arizona_fll *fll)
 
 	if (already_enabled) {
 		/* Facilitate smooth refclk across the transition */
-		regmap_update_bits_async(fll->arizona->regmap, fll->base + 0x7,
+		regmap_update_bits_async(fll->arizona->regmap, fll->base + 0x9,
 					 ARIZONA_FLL1_GAIN_MASK, 0);
 		regmap_update_bits_async(fll->arizona->regmap, fll->base + 1,
 					 ARIZONA_FLL1_FREERUN,
-- 
2.5.0
