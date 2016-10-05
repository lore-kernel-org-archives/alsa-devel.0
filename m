From: Petr Kulhavy <brain@jikos.cz>
Subject: [PATCH v2 2/4] ASoC: tas571x: remove improper PDN
	signal usage in set_bias_level
Date: Wed,  5 Oct 2016 15:51:05 +0200
Message-ID: <1475675467-5575-3-git-send-email-brain@jikos.cz>
References: <1475675467-5575-1-git-send-email-brain@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep23.mx.upcmail.net (fep23.mx.upcmail.net [62.179.121.43])
 by alsa0.perex.cz (Postfix) with ESMTP id B62E62665E5
 for <alsa-devel@alsa-project.org>; Wed,  5 Oct 2016 15:51:21 +0200 (CEST)
Received: from edge03.upcmail.net ([192.168.13.238]) by viefep23-int.chello.at
 (InterMail vM.8.01.05.21 201-2260-151-156-20141103) with ESMTP
 id <20161005135121.LSRK12996.viefep23-int.chello.at@edge03.upcmail.net>
 for <alsa-devel@alsa-project.org>; Wed, 5 Oct 2016 15:51:21 +0200
In-Reply-To: <1475675467-5575-1-git-send-email-brain@jikos.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, Petr Kulhavy <brain@jikos.cz>
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/codecs/tas571x.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index 4d61357..a8a3279 100644
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
2.7.4
