From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5640: Move cache sync() to resume()
Date: Thu, 27 Mar 2014 15:55:47 +0800
Message-ID: <1395906947-27211-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4498726517E
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 08:55:58 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch fixes the defect in case of resume which doesn't sync the cache.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5640.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 0061ae6..0883c8a 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1890,11 +1890,9 @@ static int rt5640_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 static int rt5640_set_bias_level(struct snd_soc_codec *codec,
 			enum snd_soc_bias_level level)
 {
-	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
 	switch (level) {
 	case SND_SOC_BIAS_STANDBY:
 		if (SND_SOC_BIAS_OFF == codec->dapm.bias_level) {
-			regcache_cache_only(rt5640->regmap, false);
 			snd_soc_update_bits(codec, RT5640_PWR_ANLG1,
 				RT5640_PWR_VREF1 | RT5640_PWR_MB |
 				RT5640_PWR_BG | RT5640_PWR_VREF2,
@@ -1904,7 +1902,6 @@ static int rt5640_set_bias_level(struct snd_soc_codec *codec,
 			snd_soc_update_bits(codec, RT5640_PWR_ANLG1,
 				RT5640_PWR_FV1 | RT5640_PWR_FV2,
 				RT5640_PWR_FV1 | RT5640_PWR_FV2);
-			regcache_sync(rt5640->regmap);
 			snd_soc_update_bits(codec, RT5640_DUMMY1,
 						0x0301, 0x0301);
 			snd_soc_update_bits(codec, RT5640_MICBIAS,
@@ -1979,6 +1976,9 @@ static int rt5640_resume(struct snd_soc_codec *codec)
 		msleep(400);
 	}
 
+	regcache_cache_only(rt5640->regmap, false);
+	regcache_sync(rt5640->regmap);
+
 	return 0;
 }
 #else
-- 
1.8.1.1.439.g50a6b54
