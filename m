From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas571x: remove improper PDN signal
	usage in set_bias_level" to the asoc tree
Date: Wed, 05 Oct 2016 17:21:51 +0200
Message-ID: <E1bro11-0004im-5r@finisterre>
References: <1475505650-8572-4-git-send-email-brain@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A8EED261740
 for <alsa-devel@alsa-project.org>; Wed,  5 Oct 2016 17:22:07 +0200 (CEST)
In-Reply-To: <1475505650-8572-4-git-send-email-brain@jikos.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <brain@jikos.cz>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas571x: remove improper PDN signal usage in set_bias_level

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

>From 8b0678dc914271e9ad4317fe82555ead92ce1cb9 Mon Sep 17 00:00:00 2001
From: Petr Kulhavy <brain@jikos.cz>
Date: Mon, 3 Oct 2016 16:40:48 +0200
Subject: [PATCH] ASoC: tas571x: remove improper PDN signal usage in
 set_bias_level

The set_bias_level toggles the PDN signal when entering
SND_SOC_BIAS_STANDBY and SND_SOC_BIAS_OFF. However this has no effect and
actually breaks things down (tested with TAS5717) due to the following
reasons:

1) holding down PDN does not save power but holding down RST does
2) now hard mute via register 0x5 is implemented and therefore it is no
   longer needed to toggle PDN to enter all channel shut down
3) in order to leave PDN it is required to toggle the RST signal (see
   TAS5721 datasheet), which was not implemented
4) toggling PDN as implemented actually mutes PWMs and there is no audio
   output (tested on TAS5717)

For these reasons remove the PDN signal toggling and just initialize it to
inactive in probe().

Signed-off-by: Petr Kulhavy <brain@jikos.cz>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas571x.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index 512b9e663e89..810369f687d7 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -341,20 +341,9 @@ static int tas571x_set_bias_level(struct snd_soc_codec *codec,
 					return ret;
 				}
 			}
-
-			gpiod_set_value(priv->pdn_gpio, 0);
-			usleep_range(5000, 6000);
-
-			regcache_cache_only(priv->regmap, false);
-			ret = regcache_sync(priv->regmap);
-			if (ret)
-				return ret;
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
-		regcache_cache_only(priv->regmap, true);
-		gpiod_set_value(priv->pdn_gpio, 1);
-
 		if (!IS_ERR(priv->mclk))
 			clk_disable_unprepare(priv->mclk);
 		break;
@@ -771,9 +760,6 @@ static int tas571x_i2c_probe(struct i2c_client *client,
 			return ret;
 	}
 
-	regcache_cache_only(priv->regmap, true);
-	gpiod_set_value(priv->pdn_gpio, 1);
-
 	return snd_soc_register_codec(&client->dev, &priv->codec_driver,
 				      &tas571x_dai, 1);
 }
-- 
2.9.3
