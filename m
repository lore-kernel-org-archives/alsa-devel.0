From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8955: Fix a typo in 'wm8995_pll_factors()' function name" to the asoc tree
Date: Wed, 24 Jul 2019 20:17:52 +0100 (BST)
Message-ID: <20190724191752.8368A27429A0@ypsilon.sirena.org.uk>
References: <20190724052632.30476-1-christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190724052632.30476-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>, gustavo@embeddedor.com, kernel-janitors@vger.kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, patches@opensource.cirrus.com, perex@perex.cz, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8955: Fix a typo in 'wm8995_pll_factors()' function name

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From e8758a5ed2783c417be1f5aab5af9fe4be60956f Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Wed, 24 Jul 2019 07:26:32 +0200
Subject: [PATCH] ASoC: wm8955: Fix a typo in 'wm8995_pll_factors()' function
 name

This should be 'wm8955_pll_factors()' instead.
Fix it and use it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20190724052632.30476-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8955.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index 66a5f1827aa9..9c7e2892c8cb 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -140,7 +140,7 @@ struct pll_factors {
  * to allow rounding later */
 #define FIXED_FLL_SIZE ((1 << 22) * 10)
 
-static int wm8995_pll_factors(struct device *dev,
+static int wm8955_pll_factors(struct device *dev,
 			      int Fref, int Fout, struct pll_factors *pll)
 {
 	u64 Kpart;
@@ -279,7 +279,7 @@ static int wm8955_configure_clocking(struct snd_soc_component *component)
 
 		/* Use the last divider configuration we saw for the
 		 * sample rate. */
-		ret = wm8995_pll_factors(component->dev, wm8955->mclk_rate,
+		ret = wm8955_pll_factors(component->dev, wm8955->mclk_rate,
 					 clock_cfgs[sr].mclk, &pll);
 		if (ret != 0) {
 			dev_err(component->dev,
-- 
2.20.1
