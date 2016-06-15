From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: Do not disable regulators in SND_SOC_BIAS_OFF" to the asoc tree
Date: Wed, 15 Jun 2016 15:38:22 +0100
Message-ID: <E1bDBxW-0006uF-QB@finisterre>
References: <20160606231453.19377-6-clemens.gruber@pqgruber.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160606231453.19377-6-clemens.gruber@pqgruber.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Nelson <eric@nelint.com>
Cc: Clemens Gruber <clemens.gruber@pqgruber.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.orgClemens Gruber <clemens.gruber@pqgruber.com>Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sgtl5000: Do not disable regulators in SND_SOC_BIAS_OFF

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

>From 8419caa7270291e26f8b34b12b29680586c85d30 Mon Sep 17 00:00:00 2001
From: Eric Nelson <eric@nelint.com>
Date: Tue, 7 Jun 2016 01:14:52 +0200
Subject: [PATCH] ASoC: sgtl5000: Do not disable regulators in SND_SOC_BIAS_OFF

Disabling the SGTL5000 through regulators would certainly save more
power than simply disabling the reference voltages as described in the
data sheet, but won't properly restore things on resume.

This driver does not support active regulators. So we simply disable the
reference bias currents.

Signed-off-by: Eric Nelson <eric@nelint.com>
Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 0916bb46ccf2..39a178a88b36 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -761,42 +761,17 @@ static int sgtl5000_pcm_hw_params(struct snd_pcm_substream *substream,
 static int sgtl5000_set_bias_level(struct snd_soc_codec *codec,
 				   enum snd_soc_bias_level level)
 {
-	int ret;
-	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
-
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
-		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
-			ret = regulator_bulk_enable(
-						sgtl5000->num_supplies,
-						sgtl5000->supplies);
-			if (ret)
-				return ret;
-			udelay(10);
-
-			regcache_cache_only(sgtl5000->regmap, false);
-
-			ret = regcache_sync(sgtl5000->regmap);
-			if (ret != 0) {
-				dev_err(codec->dev,
-					"Failed to restore cache: %d\n", ret);
-
-				regcache_cache_only(sgtl5000->regmap, true);
-				regulator_bulk_disable(sgtl5000->num_supplies,
-						       sgtl5000->supplies);
-
-				return ret;
-			}
-		}
-
+		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
+				    SGTL5000_REFTOP_POWERUP,
+				    SGTL5000_REFTOP_POWERUP);
 		break;
 	case SND_SOC_BIAS_OFF:
-		regcache_cache_only(sgtl5000->regmap, true);
-		regulator_bulk_disable(sgtl5000->num_supplies,
-				       sgtl5000->supplies);
+		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
+				    SGTL5000_REFTOP_POWERUP, 0);
 		break;
 	}
 
-- 
2.8.1
