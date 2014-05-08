From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 4/4] ASoC: rt5645: Correct the cache sync
	function
Date: Thu, 8 May 2014 14:47:37 +0800
Message-ID: <1399531657-31793-4-git-send-email-oder_chiou@realtek.com>
References: <1399531657-31793-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 89DEC2654CD
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 08:47:51 +0200 (CEST)
In-Reply-To: <1399531657-31793-1-git-send-email-oder_chiou@realtek.com>
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
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch corrects the cache sync function

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 4be9000..6db6f81 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2235,7 +2235,7 @@ static int rt5645_resume(struct snd_soc_codec *codec)
 	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
 
 	regcache_cache_only(rt5645->regmap, false);
-	snd_soc_cache_sync(codec);
+	regcache_sync(rt5645->regmap);
 
 	return 0;
 }
-- 
1.8.1.1.439.g50a6b54
