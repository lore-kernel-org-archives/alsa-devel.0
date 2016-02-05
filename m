From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adau17x1: Cache writes when core clock
	is disabled" to the asoc tree
Date: Fri, 05 Feb 2016 13:35:19 +0000
Message-ID: <E1aRgXf-00013N-OH@finisterre>
References: <1454594719-17270-1-git-send-email-andire@axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0686259588232831498=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 70AFC260644
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 14:35:42 +0100 (CET)
In-Reply-To: <1454594719-17270-1-git-send-email-andire@axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============0686259588232831498==
Content-Type: text/plain

The patch

   ASoC: adau17x1: Cache writes when core clock is disabled

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

>From 27d6e7d1c96c9f51379e0feb972fec26029098bc Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andreas.irestal@axis.com>
Date: Thu, 4 Feb 2016 15:05:19 +0100
Subject: [PATCH] ASoC: adau17x1: Cache writes when core clock is disabled
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In some configurations, the dai registers get written before the bias
level is changed in the codec driver. This leads to a situation where
an initial write to the serial port register gets ignored, and future
writes may as well, since regmap thinks that the codec already holds the
value. More specifically, configuring the codec as i2s master would in
fact result in the codec running as slave, a situation where no i2s
clocks are generated and hence no data is transferred.

This change makes sure that regmap only caches writes when the core
clock is disabled, and syncs regmap whenever enabling the core clock
again.

Signed-off-by: Andreas Irestål <andire@axis.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1761.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index 2f12477..e7136b1 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -456,13 +456,17 @@ static int adau1761_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
+		regcache_cache_only(adau->regmap, false);
 		regmap_update_bits(adau->regmap, ADAU17X1_CLOCK_CONTROL,
 			ADAU17X1_CLOCK_CONTROL_SYSCLK_EN,
 			ADAU17X1_CLOCK_CONTROL_SYSCLK_EN);
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF)
+			regcache_sync(adau->regmap);
 		break;
 	case SND_SOC_BIAS_OFF:
 		regmap_update_bits(adau->regmap, ADAU17X1_CLOCK_CONTROL,
 			ADAU17X1_CLOCK_CONTROL_SYSCLK_EN, 0);
+		regcache_cache_only(adau->regmap, true);
 		break;
 
 	}
@@ -783,6 +787,10 @@ int adau1761_probe(struct device *dev, struct regmap *regmap,
 	if (ret)
 		return ret;
 
+	/* Enable cache only mode as we could miss writes before bias level
+	 * reaches standby and the core clock is enabled */
+	regcache_cache_only(regmap, true);
+
 	return snd_soc_register_codec(dev, &adau1761_codec_driver, dai_drv, 1);
 }
 EXPORT_SYMBOL_GPL(adau1761_probe);
-- 
2.6.4


--===============0686259588232831498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0686259588232831498==--
