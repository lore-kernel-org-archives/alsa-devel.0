From: Mark Brown <broonie@kernel.org>
Subject: Applied "sound: soc: codecs: mt6358: change return type of mt6358_codec_init_reg" to the asoc tree
Date: Mon, 22 Jul 2019 13:22:08 +0100 (BST)
Message-ID: <20190722122208.845DB2740463@ypsilon.sirena.org.uk>
References: <20190709182543.GA6611@hari-Inspiron-1545>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190709182543.GA6611@hari-Inspiron-1545>
Sender: linux-kernel-owner@vger.kernel.org
To: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Shunli Wang <shunli.wang@mediatek.com>, Takashi Iwai <tiwai@suse.com>, Tzung-Bi Shih <tzungbi@google.com>
List-Id: alsa-devel@alsa-project.org

The patch

   sound: soc: codecs: mt6358: change return type of mt6358_codec_init_reg

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

>From 1d3dd532883be6167da5df6117efd6d4e8790456 Mon Sep 17 00:00:00 2001
From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Date: Tue, 9 Jul 2019 23:55:43 +0530
Subject: [PATCH] sound: soc: codecs: mt6358: change return type of
 mt6358_codec_init_reg

As mt6358_codec_init_reg function always returns 0 , change return type
from int to void.

fixes below issue reported by coccicheck
sound/soc/codecs/mt6358.c:2260:5-8: Unneeded variable: "ret". Return "0"
on line 2289

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Acked-by: Tzung-Bi Shih <tzungbi@google.com>
Link: https://lore.kernel.org/r/20190709182543.GA6611@hari-Inspiron-1545
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/mt6358.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/mt6358.c b/sound/soc/codecs/mt6358.c
index 50b3fc5457ea..c17250aab2d0 100644
--- a/sound/soc/codecs/mt6358.c
+++ b/sound/soc/codecs/mt6358.c
@@ -2255,10 +2255,8 @@ static struct snd_soc_dai_driver mt6358_dai_driver[] = {
 	},
 };
 
-static int mt6358_codec_init_reg(struct mt6358_priv *priv)
+static void mt6358_codec_init_reg(struct mt6358_priv *priv)
 {
-	int ret = 0;
-
 	/* Disable HeadphoneL/HeadphoneR short circuit protection */
 	regmap_update_bits(priv->regmap, MT6358_AUDDEC_ANA_CON0,
 			   RG_AUDHPLSCDISABLE_VAUDP15_MASK_SFT,
@@ -2285,8 +2283,6 @@ static int mt6358_codec_init_reg(struct mt6358_priv *priv)
 	/* set gpio */
 	playback_gpio_reset(priv);
 	capture_gpio_reset(priv);
-
-	return ret;
 }
 
 static int mt6358_codec_probe(struct snd_soc_component *cmpnt)
-- 
2.20.1
