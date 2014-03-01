From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: wm8753: Remove superfluous
	'codec->cache_sync = 1'
Date: Sat,  1 Mar 2014 13:46:44 +0100
Message-ID: <1393678004-17427-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-185.synserver.de
 [212.40.185.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E32E26531F
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 13:46:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The wm8763 driver uses regmap for IO which means that codec->cache_sync is not
used. The line was added in commit d3398ff ('ASoC: Convert WM8753 to direct
regmap API usage'). Presumably this was meant to be regcache_mark_dirty(), but
since we already call regcache_mark_dirty() in the core when suspending the
CODEC it is safe to just remove the line.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8753.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index be85da9..a02e76c 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1440,7 +1440,6 @@ static void wm8753_work(struct work_struct *work)
 static int wm8753_suspend(struct snd_soc_codec *codec)
 {
 	wm8753_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	codec->cache_sync = 1;
 	return 0;
 }
 
-- 
1.8.0
