From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5100: Mark register cache as dirty
	when regulators are disabled
Date: Wed, 25 Jan 2012 21:27:54 +0000
Message-ID: <1327526874-2015-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C141524338
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 22:27:55 +0100 (CET)
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

Otherwise we won't resync later.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 51b281b..273093f 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -1376,6 +1376,7 @@ static int wm5100_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_OFF:
 		regcache_cache_only(wm5100->regmap, true);
+		regcache_mark_dirty(wm5100->regmap);
 		for (i = 0; i < ARRAY_SIZE(wm5100->adsp1); i++)
 			wm_adsp1_reinit(wm5100->adsp1[i]);
 		regcache_cache_only(wm5100->regmap, true);
-- 
1.7.9.rc1
