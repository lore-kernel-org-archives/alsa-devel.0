From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/8] ASoC: Use standard register cache sync in
	wm8993
Date: Wed, 14 Dec 2011 17:00:52 +0800
Message-ID: <1323853254-9020-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1323853254-9020-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E5F3E243A8
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 10:01:08 +0100 (CET)
In-Reply-To: <1323853254-9020-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8993.c |   24 +-----------------------
 1 files changed, 1 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index b966f69..2835e7d 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -934,28 +934,6 @@ static const struct snd_soc_dapm_route routes[] = {
 	{ "Right Headphone Mux", "DAC", "DACR" },
 };
 
-static void wm8993_cache_restore(struct snd_soc_codec *codec)
-{
-	u16 *cache = codec->reg_cache;
-	int i;
-
-	if (!codec->cache_sync)
-		return;
-
-	/* Reenable hardware writes */
-	codec->cache_only = 0;
-
-	/* Restore the register settings */
-	for (i = 1; i < WM8993_MAX_REGISTER; i++) {
-		if (cache[i] == wm8993_reg_defaults[i])
-			continue;
-		snd_soc_write(codec, i, cache[i]);
-	}
-
-	/* We're in sync again */
-	codec->cache_sync = 0;
-}
-
 static int wm8993_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
@@ -979,7 +957,7 @@ static int wm8993_set_bias_level(struct snd_soc_codec *codec,
 			if (ret != 0)
 				return ret;
 
-			wm8993_cache_restore(codec);
+			snd_soc_cache_sync(codec);
 
 			/* Tune DC servo configuration */
 			snd_soc_write(codec, 0x44, 3);
-- 
1.7.7.3
