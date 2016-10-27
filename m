From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5670: increse LDO power
Date: Thu, 27 Oct 2016 13:21:54 +0800
Message-ID: <1477545714-26188-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E77D26664F
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 07:22:23 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Inrecse LDO power for better performance.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 6caac92..12d3bc1 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2618,7 +2618,7 @@ static int rt5670_set_bias_level(struct snd_soc_codec *codec,
 				RT5670_OSW_L_DIS | RT5670_OSW_R_DIS);
 			snd_soc_update_bits(codec, RT5670_DIG_MISC, 0x1, 0x1);
 			snd_soc_update_bits(codec, RT5670_PWR_ANLG1,
-				RT5670_LDO_SEL_MASK, 0x3);
+				RT5670_LDO_SEL_MASK, 0x5);
 		}
 		break;
 	case SND_SOC_BIAS_STANDBY:
@@ -2626,7 +2626,7 @@ static int rt5670_set_bias_level(struct snd_soc_codec *codec,
 				RT5670_PWR_VREF1 | RT5670_PWR_VREF2 |
 				RT5670_PWR_FV1 | RT5670_PWR_FV2, 0);
 		snd_soc_update_bits(codec, RT5670_PWR_ANLG1,
-				RT5670_LDO_SEL_MASK, 0x1);
+				RT5670_LDO_SEL_MASK, 0x3);
 		break;
 	case SND_SOC_BIAS_OFF:
 		if (rt5670->pdata.jd_mode)
-- 
1.8.1.1.439.g50a6b54
