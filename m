From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Remove ASoC level register cache
	sync
Date: Tue, 31 Jan 2012 14:57:31 +0000
Message-ID: <1328021851-3431-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 17D21103819
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 15:57:35 +0100 (CET)
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

Now we've switched over to regmap the ASoC level cache sync will be
ineffectual and potentially harmful as there is no longer an ASoC level
cache.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index ae05e29..ca2db79 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2736,11 +2736,6 @@ static int wm8994_resume(struct snd_soc_codec *codec)
 		codec->cache_only = 0;
 	}
 
-	/* Restore the registers */
-	ret = snd_soc_cache_sync(codec);
-	if (ret != 0)
-		dev_err(codec->dev, "Failed to sync cache: %d\n", ret);
-
 	wm8994_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	for (i = 0; i < ARRAY_SIZE(wm8994->fll); i++) {
-- 
1.7.9.rc1
