From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5677: Avoid duplicate the same test
	in each switch case" to the asoc tree
Date: Wed, 30 Mar 2016 11:07:14 -0700
Message-ID: <E1alKWQ-0006Z9-7k@finisterre>
References: <1459333507.6111.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 77612265026
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 20:07:22 +0200 (CEST)
In-Reply-To: <1459333507.6111.0.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5677: Avoid duplicate the same test in each switch case

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

>From 2dfadff69e8b1da8f8661e9edb131b208cc389b7 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 30 Mar 2016 18:25:07 +0800
Subject: [PATCH] ASoC: rt5677: Avoid duplicate the same test in each switch
 case

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5677.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 33e290b703df..b3f1db5bae4a 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -1241,60 +1241,46 @@ static int rt5677_dmic_use_asrc(struct snd_soc_dapm_widget *source,
 		regmap_read(rt5677->regmap, RT5677_ASRC_5, &asrc_setting);
 		asrc_setting = (asrc_setting & RT5677_AD_STO1_CLK_SEL_MASK) >>
 				RT5677_AD_STO1_CLK_SEL_SFT;
-		if (asrc_setting >= RT5677_CLK_SEL_I2S1_ASRC &&
-			asrc_setting <= RT5677_CLK_SEL_I2S6_ASRC)
-			return 1;
 		break;
 
 	case 10:
 		regmap_read(rt5677->regmap, RT5677_ASRC_5, &asrc_setting);
 		asrc_setting = (asrc_setting & RT5677_AD_STO2_CLK_SEL_MASK) >>
 				RT5677_AD_STO2_CLK_SEL_SFT;
-		if (asrc_setting >= RT5677_CLK_SEL_I2S1_ASRC &&
-			asrc_setting <= RT5677_CLK_SEL_I2S6_ASRC)
-			return 1;
 		break;
 
 	case 9:
 		regmap_read(rt5677->regmap, RT5677_ASRC_5, &asrc_setting);
 		asrc_setting = (asrc_setting & RT5677_AD_STO3_CLK_SEL_MASK) >>
 				RT5677_AD_STO3_CLK_SEL_SFT;
-		if (asrc_setting >= RT5677_CLK_SEL_I2S1_ASRC &&
-			asrc_setting <= RT5677_CLK_SEL_I2S6_ASRC)
-			return 1;
 		break;
 
 	case 8:
 		regmap_read(rt5677->regmap, RT5677_ASRC_5, &asrc_setting);
 		asrc_setting = (asrc_setting & RT5677_AD_STO4_CLK_SEL_MASK) >>
 			RT5677_AD_STO4_CLK_SEL_SFT;
-		if (asrc_setting >= RT5677_CLK_SEL_I2S1_ASRC &&
-			asrc_setting <= RT5677_CLK_SEL_I2S6_ASRC)
-			return 1;
 		break;
 
 	case 7:
 		regmap_read(rt5677->regmap, RT5677_ASRC_6, &asrc_setting);
 		asrc_setting = (asrc_setting & RT5677_AD_MONOL_CLK_SEL_MASK) >>
 			RT5677_AD_MONOL_CLK_SEL_SFT;
-		if (asrc_setting >= RT5677_CLK_SEL_I2S1_ASRC &&
-			asrc_setting <= RT5677_CLK_SEL_I2S6_ASRC)
-			return 1;
 		break;
 
 	case 6:
 		regmap_read(rt5677->regmap, RT5677_ASRC_6, &asrc_setting);
 		asrc_setting = (asrc_setting & RT5677_AD_MONOR_CLK_SEL_MASK) >>
 			RT5677_AD_MONOR_CLK_SEL_SFT;
-		if (asrc_setting >= RT5677_CLK_SEL_I2S1_ASRC &&
-			asrc_setting <= RT5677_CLK_SEL_I2S6_ASRC)
-			return 1;
 		break;
 
 	default:
-		break;
+		return 0;
 	}
 
+	if (asrc_setting >= RT5677_CLK_SEL_I2S1_ASRC &&
+	    asrc_setting <= RT5677_CLK_SEL_I2S6_ASRC)
+		return 1;
+
 	return 0;
 }
 
-- 
2.8.0.rc3
