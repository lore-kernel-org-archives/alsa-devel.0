From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: rt5677: Avoid duplicate the same test in
 each switch case
Date: Wed, 30 Mar 2016 18:25:07 +0800
Message-ID: <1459333507.6111.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id D3F96265DB1
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 12:25:11 +0200 (CEST)
Received: by mail-pa0-f52.google.com with SMTP id fe3so37292904pab.1
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 03:25:11 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/rt5677.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 33e290b..b3f1db5 100644
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
2.1.4
