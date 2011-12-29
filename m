From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/7] ASoC: Use standard cache sync for WM8978
Date: Thu, 29 Dec 2011 11:49:13 +0000
Message-ID: <1325159355-31686-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1325159355-31686-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A3A981037EE
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 12:49:26 +0100 (CET)
In-Reply-To: <1325159355-31686-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Saves a bit of code and supports further refactoring.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8978.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 051f5d0..0ab339c 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -891,16 +891,9 @@ static int wm8978_suspend(struct snd_soc_codec *codec)
 static int wm8978_resume(struct snd_soc_codec *codec)
 {
 	struct wm8978_priv *wm8978 = snd_soc_codec_get_drvdata(codec);
-	int i;
-	u16 *cache = codec->reg_cache;
 
 	/* Sync reg_cache with the hardware */
-	for (i = 0; i < ARRAY_SIZE(wm8978_reg); i++) {
-		if (i == WM8978_RESET)
-			continue;
-		if (cache[i] != wm8978_reg[i])
-			snd_soc_write(codec, i, cache[i]);
-	}
+	snd_soc_cache_sync(codec);
 
 	wm8978_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-- 
1.7.7.3
