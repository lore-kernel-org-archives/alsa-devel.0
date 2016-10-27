From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5670: increse LDO power" to the asoc
	tree
Date: Thu, 27 Oct 2016 17:47:30 +0100
Message-ID: <E1bznpy-0007gP-40@debutante>
References: <1477545714-26188-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 512422669DD
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 18:47:40 +0200 (CEST)
In-Reply-To: <1477545714-26188-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5670: increse LDO power

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

>From c8c6f0d81de67198522e3f31142986c27d3cba81 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Thu, 27 Oct 2016 13:21:54 +0800
Subject: [PATCH] ASoC: rt5670: increse LDO power

Inrecse LDO power for better performance.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5670.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 6caac92143d4..12d3bc14a558 100644
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
2.8.1
