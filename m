From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: rt5677: Remove NULL test for desc before
 gpiod_set_value_cansleep call
Date: Thu, 23 Jul 2015 23:32:04 +0800
Message-ID: <1437665524.20606.8.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
 [209.85.192.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 70EDC261A8C
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 17:32:10 +0200 (CEST)
Received: by pdjr16 with SMTP id r16so161605027pdj.3
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 08:32:09 -0700 (PDT)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

It's safe to call gpiod_set_value_cansleep() with NULL desc.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/rt5677.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 016db7d..8d70911 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4763,10 +4763,8 @@ static int rt5677_remove(struct snd_soc_codec *codec)
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
 	regmap_write(rt5677->regmap, RT5677_RESET, 0x10ec);
-	if (rt5677->pow_ldo2)
-		gpiod_set_value_cansleep(rt5677->pow_ldo2, 0);
-	if (rt5677->reset_pin)
-		gpiod_set_value_cansleep(rt5677->reset_pin, 0);
+	gpiod_set_value_cansleep(rt5677->pow_ldo2, 0);
+	gpiod_set_value_cansleep(rt5677->reset_pin, 0);
 
 	return 0;
 }
@@ -4780,10 +4778,8 @@ static int rt5677_suspend(struct snd_soc_codec *codec)
 		regcache_cache_only(rt5677->regmap, true);
 		regcache_mark_dirty(rt5677->regmap);
 
-		if (rt5677->pow_ldo2)
-			gpiod_set_value_cansleep(rt5677->pow_ldo2, 0);
-		if (rt5677->reset_pin)
-			gpiod_set_value_cansleep(rt5677->reset_pin, 0);
+		gpiod_set_value_cansleep(rt5677->pow_ldo2, 0);
+		gpiod_set_value_cansleep(rt5677->reset_pin, 0);
 	}
 
 	return 0;
@@ -4794,10 +4790,8 @@ static int rt5677_resume(struct snd_soc_codec *codec)
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
 	if (!rt5677->dsp_vad_en) {
-		if (rt5677->pow_ldo2)
-			gpiod_set_value_cansleep(rt5677->pow_ldo2, 1);
-		if (rt5677->reset_pin)
-			gpiod_set_value_cansleep(rt5677->reset_pin, 1);
+		gpiod_set_value_cansleep(rt5677->pow_ldo2, 1);
+		gpiod_set_value_cansleep(rt5677->reset_pin, 1);
 		if (rt5677->pow_ldo2 || rt5677->reset_pin)
 			msleep(10);
 
-- 
2.1.0
