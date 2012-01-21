From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/5] ASoC: wm8985: Use standard cache sync
	implementation
Date: Sat, 21 Jan 2012 15:45:25 +0000
Message-ID: <1327160727-1546-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1327160727-1546-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6598910383E
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2012 16:45:33 +0100 (CET)
In-Reply-To: <1327160727-1546-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8985.c |   21 +--------------------
 1 files changed, 1 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index ee3aba3..297119f 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -834,25 +834,6 @@ static int wm8985_set_sysclk(struct snd_soc_dai *dai,
 	return 0;
 }
 
-static void wm8985_sync_cache(struct snd_soc_codec *codec)
-{
-	short i;
-	u16 *cache;
-
-	if (!codec->cache_sync)
-		return;
-	codec->cache_only = 0;
-	/* restore cache */
-	cache = codec->reg_cache;
-	for (i = 0; i < codec->driver->reg_cache_size; i++) {
-		if (i == WM8985_SOFTWARE_RESET
-				|| cache[i] == wm8985_reg_defs[i])
-			continue;
-		snd_soc_write(codec, i, cache[i]);
-	}
-	codec->cache_sync = 0;
-}
-
 static int wm8985_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
@@ -879,7 +860,7 @@ static int wm8985_set_bias_level(struct snd_soc_codec *codec,
 				return ret;
 			}
 
-			wm8985_sync_cache(codec);
+			snd_soc_cache_sync(codec);
 
 			/* enable anti-pop features */
 			snd_soc_update_bits(codec, WM8985_OUT4_TO_ADC,
-- 
1.7.7.3
