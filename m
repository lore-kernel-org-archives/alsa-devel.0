From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/5] ASoC: wm8904: Fix cache only management
Date: Mon, 11 Jun 2012 13:10:44 +0800
Message-ID: <1339391447-8721-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1339391447-8721-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 05EDB1040AD
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 07:11:21 +0200 (CEST)
In-Reply-To: <1339391447-8721-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We should be using the regmap API consistently for all the cache only
configuration and we should be going cache only before we power down
the supplies.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8904.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 461c58a..5417b11 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -1863,6 +1863,7 @@ static int wm8904_set_bias_level(struct snd_soc_codec *codec,
 				return ret;
 			}
 
+			regcache_cache_only(wm8904->regmap, false);
 			regcache_sync(wm8904->regmap);
 
 			/* Enable bias */
@@ -1899,14 +1900,8 @@ static int wm8904_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_update_bits(codec, WM8904_BIAS_CONTROL_0,
 				    WM8904_BIAS_ENA, 0);
 
-#ifdef CONFIG_REGULATOR
-		/* Post 2.6.34 we will be able to get a callback when
-		 * the regulators are disabled which we can use but
-		 * for now just assume that the power will be cut if
-		 * the regulator API is in use.
-		 */
-		codec->cache_sync = 1;
-#endif
+		regcache_cache_only(wm8904->regmap, true);
+		regcache_mark_dirty(wm8904->regmap);
 
 		regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies),
 				       wm8904->supplies);
@@ -2086,7 +2081,6 @@ static int wm8904_probe(struct snd_soc_codec *codec)
 	struct wm8904_pdata *pdata = wm8904->pdata;
 	int ret, i;
 
-	codec->cache_sync = 1;
 	codec->control_data = wm8904->regmap;
 
 	switch (wm8904->devtype) {
@@ -2149,6 +2143,7 @@ static int wm8904_probe(struct snd_soc_codec *codec)
 		goto err_enable;
 	}
 
+	regcache_cache_only(wm8904->regmap, true);
 	/* Change some default settings - latch VU and enable ZC */
 	snd_soc_update_bits(codec, WM8904_ADC_DIGITAL_VOLUME_LEFT,
 			    WM8904_ADC_VU, WM8904_ADC_VU);
-- 
1.7.10
