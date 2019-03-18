From: <shumingf@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5682: fix jack type detection issue
Date: Mon, 18 Mar 2019 15:17:13 +0800
Message-ID: <20190318071713.20080-1-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48028F80792
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2019 08:17:30 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, hou-hsun.lee@intel.com, hychao@google.com, lijen@google.com, albertchen@realtek.com, derek.fang@realtek.com, bard.liao@intel.com, Shuming Fan <shumingf@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Shuming Fan <shumingf@realtek.com>

The jack type detection needs the main bias power of analog.
The modification makes sure the main bias power on/off while jack plug/unplug.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
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
2.21.0
