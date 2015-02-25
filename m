From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5677: Keep the ldo2 power while
	"Voice Wake Up" used in the suspend mode
Date: Wed, 25 Feb 2015 17:36:14 +0800
Message-ID: <1424856974-18763-2-git-send-email-oder_chiou@realtek.com>
References: <1424856974-18763-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 13C522605EE
 for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2015 10:36:26 +0100 (CET)
In-Reply-To: <1424856974-18763-1-git-send-email-oder_chiou@realtek.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, bardliao@realtek.com, alsa-devel@alsa-project.org, john.lin@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch keeps the ldo2 power while the DSP function of "Voice Wake Up" used
in the suspend mode.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index f87c929..c2a6e40 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4513,10 +4513,10 @@ static int rt5677_suspend(struct snd_soc_codec *codec)
 	if (!rt5677->dsp_vad_en) {
 		regcache_cache_only(rt5677->regmap, true);
 		regcache_mark_dirty(rt5677->regmap);
-	}
 
-	if (gpio_is_valid(rt5677->pow_ldo2))
-		gpio_set_value_cansleep(rt5677->pow_ldo2, 0);
+		if (gpio_is_valid(rt5677->pow_ldo2))
+			gpio_set_value_cansleep(rt5677->pow_ldo2, 0);
+	}
 
 	return 0;
 }
@@ -4525,12 +4525,12 @@ static int rt5677_resume(struct snd_soc_codec *codec)
 {
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
-	if (gpio_is_valid(rt5677->pow_ldo2)) {
-		gpio_set_value_cansleep(rt5677->pow_ldo2, 1);
-		msleep(10);
-	}
-
 	if (!rt5677->dsp_vad_en) {
+		if (gpio_is_valid(rt5677->pow_ldo2)) {
+			gpio_set_value_cansleep(rt5677->pow_ldo2, 1);
+			msleep(10);
+		}
+
 		regcache_cache_only(rt5677->regmap, false);
 		regcache_sync(rt5677->regmap);
 	}
-- 
1.8.1.1.439.g50a6b54
