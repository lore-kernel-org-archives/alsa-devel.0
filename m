From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5682: fix jack type detection issue"
	to the asoc tree
Date: Mon, 18 Mar 2019 14:51:05 +0000 (GMT)
Message-ID: <20190318145105.3ED9D1128874@debutante.sirena.org.uk>
References: <20190318071713.20080-1-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5638BF89722
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2019 15:51:10 +0100 (CET)
In-Reply-To: <20190318071713.20080-1-shumingf@realtek.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Shuming Fan <shumingf@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, hou-hsun.lee@intel.com, hychao@google.com, lijen@google.com, lgirdwood@gmail.com, albertchen@realtek.com, broonie@kernel.org, derek.fang@realtek.com, flove@realtek.com, bard.liao@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5682: fix jack type detection issue

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 675212bfb23394514b7f68ebf3954ba936281ccc Mon Sep 17 00:00:00 2001
From: Shuming Fan <shumingf@realtek.com>
Date: Mon, 18 Mar 2019 15:17:13 +0800
Subject: [PATCH] ASoC: rt5682: fix jack type detection issue

The jack type detection needs the main bias power of analog.
The modification makes sure the main bias power on/off while jack plug/unplug.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5682.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index b7e2e9937e6d..b98974edf6ad 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -915,7 +915,8 @@ static int rt5682_headset_detect(struct snd_soc_component *component,
 	if (jack_insert) {
 
 		snd_soc_component_update_bits(component, RT5682_PWR_ANLG_1,
-			RT5682_PWR_VREF2, RT5682_PWR_VREF2);
+			RT5682_PWR_VREF2 | RT5682_PWR_MB,
+			RT5682_PWR_VREF2 | RT5682_PWR_MB);
 		snd_soc_component_update_bits(component,
 				RT5682_PWR_ANLG_1, RT5682_PWR_FV2, 0);
 		usleep_range(15000, 20000);
@@ -952,7 +953,7 @@ static int rt5682_headset_detect(struct snd_soc_component *component,
 		snd_soc_component_update_bits(component, RT5682_CBJ_CTRL_1,
 			RT5682_TRIG_JD_MASK, RT5682_TRIG_JD_LOW);
 		snd_soc_component_update_bits(component, RT5682_PWR_ANLG_1,
-			RT5682_PWR_VREF2, 0);
+			RT5682_PWR_VREF2 | RT5682_PWR_MB, 0);
 		snd_soc_component_update_bits(component, RT5682_PWR_ANLG_3,
 			RT5682_PWR_CBJ, 0);
 
@@ -2301,16 +2302,13 @@ static int rt5682_set_bias_level(struct snd_soc_component *component,
 	switch (level) {
 	case SND_SOC_BIAS_PREPARE:
 		regmap_update_bits(rt5682->regmap, RT5682_PWR_ANLG_1,
-			RT5682_PWR_MB | RT5682_PWR_BG,
-			RT5682_PWR_MB | RT5682_PWR_BG);
+			RT5682_PWR_BG, RT5682_PWR_BG);
 		regmap_update_bits(rt5682->regmap, RT5682_PWR_DIG_1,
 			RT5682_DIG_GATE_CTRL | RT5682_PWR_LDO,
 			RT5682_DIG_GATE_CTRL | RT5682_PWR_LDO);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		regmap_update_bits(rt5682->regmap, RT5682_PWR_ANLG_1,
-			RT5682_PWR_MB, RT5682_PWR_MB);
 		regmap_update_bits(rt5682->regmap, RT5682_PWR_DIG_1,
 			RT5682_DIG_GATE_CTRL, RT5682_DIG_GATE_CTRL);
 		break;
@@ -2318,7 +2316,7 @@ static int rt5682_set_bias_level(struct snd_soc_component *component,
 		regmap_update_bits(rt5682->regmap, RT5682_PWR_DIG_1,
 			RT5682_DIG_GATE_CTRL | RT5682_PWR_LDO, 0);
 		regmap_update_bits(rt5682->regmap, RT5682_PWR_ANLG_1,
-			RT5682_PWR_MB | RT5682_PWR_BG, 0);
+			RT5682_PWR_BG, 0);
 		break;
 
 	default:
-- 
2.20.1
