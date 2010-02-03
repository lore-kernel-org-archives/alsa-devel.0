From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Add a cache_sync bit to the CODEC
	structure
Date: Wed,  3 Feb 2010 18:05:02 +0000
Message-ID: <1265220302-26589-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1265220302-26589-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C0876103827
	for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2010 19:05:09 +0100 (CET)
In-Reply-To: <1265220302-26589-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Add a bit to the CODEC structure indicating if a cache sync is required.
By default this will be set if a cache only write is done to a soc-cache
register cache.  This allows us to avoid syncing the cache back after
using cache only writes if there were no changes.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

SQUASH CACHE SYNC
---
 include/sound/soc.h   |    1 +
 sound/soc/soc-cache.c |   20 +++++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4e8f14b..e6a6d10 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -424,6 +424,7 @@ struct snd_soc_codec {
 
 	unsigned int idle_bias_off:1; /* Use BIAS_OFF instead of STANDBY */
 	unsigned int cache_only:1;  /* Suppress writes to hardware */
+	unsigned int cache_sync:1; /* Cache needs to be synced to hardware */
 
 	/* dapm */
 	u32 pop_time;
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 84b6916..5869dc3 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -39,8 +39,10 @@ static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
 	if (reg < codec->reg_cache_size)
 		cache[reg] = value;
 
-	if (codec->cache_only)
+	if (codec->cache_only) {
+		codec->cache_sync = 1;
 		return 0;
+	}
 
 	ret = codec->hw_write(codec->control_data, data, 2);
 	if (ret == 2)
@@ -105,8 +107,10 @@ static int snd_soc_7_9_write(struct snd_soc_codec *codec, unsigned int reg,
 	if (reg < codec->reg_cache_size)
 		cache[reg] = value;
 
-	if (codec->cache_only)
+	if (codec->cache_only) {
+		codec->cache_sync = 1;
 		return 0;
+	}
 
 	ret = codec->hw_write(codec->control_data, data, 2);
 	if (ret == 2)
@@ -161,8 +165,10 @@ static int snd_soc_8_8_write(struct snd_soc_codec *codec, unsigned int reg,
 	if (reg < codec->reg_cache_size)
 		cache[reg] = value;
 
-	if (codec->cache_only)
+	if (codec->cache_only) {
+		codec->cache_sync = 1;
 		return 0;
+	}
 
 	if (codec->hw_write(codec->control_data, data, 2) == 2)
 		return 0;
@@ -192,8 +198,10 @@ static int snd_soc_8_16_write(struct snd_soc_codec *codec, unsigned int reg,
 	if (!snd_soc_codec_volatile_register(codec, reg))
 		reg_cache[reg] = value;
 
-	if (codec->cache_only)
+	if (codec->cache_only) {
+		codec->cache_sync = 1;
 		return 0;
+	}
 
 	if (codec->hw_write(codec->control_data, data, 3) == 3)
 		return 0;
@@ -313,8 +321,10 @@ static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
 	if (reg < codec->reg_cache_size)
 		cache[reg] = value;
 
-	if (codec->cache_only)
+	if (codec->cache_only) {
+		codec->cache_sync = 1;
 		return 0;
+	}
 
 	ret = codec->hw_write(codec->control_data, data, 3);
 	if (ret == 3)
-- 
1.6.6
