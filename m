From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 2/4] ASoC: cache: Standardise ASoC cache
	messages
Date: Mon, 19 Nov 2012 14:39:13 +0000
Message-ID: <1353335955-5249-2-git-send-email-lrg@ti.com>
References: <1353335955-5249-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BFC1265148
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 15:39:26 +0100 (CET)
In-Reply-To: <1353335955-5249-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Currently ASoC has a mixture of message prefixes e.g. "ASoC", "asoc"
or none and message types e.g. pr_debug or dev_dbg.

Make sure all ASoC core messages use the same "ASoC" prefix and
convert any component device specific messages to use dev_dbg
instead of pr_debug.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-cache.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 9d56f02..e72f554 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -88,7 +88,7 @@ static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
 		ret = snd_soc_write(codec, i, val);
 		if (ret)
 			return ret;
-		dev_dbg(codec->dev, "Synced register %#x, value = %#x\n",
+		dev_dbg(codec->dev, "ASoC: Synced register %#x, value = %#x\n",
 			i, val);
 	}
 	return 0;
@@ -156,7 +156,7 @@ int snd_soc_cache_init(struct snd_soc_codec *codec)
 
 	/* Fall back to flat compression */
 	if (i == ARRAY_SIZE(cache_types)) {
-		dev_warn(codec->dev, "Could not match compress type: %d\n",
+		dev_warn(codec->dev, "ASoC: Could not match compress type: %d\n",
 			 codec->compress_type);
 		i = 0;
 	}
@@ -166,7 +166,7 @@ int snd_soc_cache_init(struct snd_soc_codec *codec)
 
 	if (codec->cache_ops->init) {
 		if (codec->cache_ops->name)
-			dev_dbg(codec->dev, "Initializing %s cache for %s codec\n",
+			dev_dbg(codec->dev, "ASoC: Initializing %s cache for %s codec\n",
 				codec->cache_ops->name, codec->name);
 		return codec->cache_ops->init(codec);
 	}
@@ -181,7 +181,7 @@ int snd_soc_cache_exit(struct snd_soc_codec *codec)
 {
 	if (codec->cache_ops && codec->cache_ops->exit) {
 		if (codec->cache_ops->name)
-			dev_dbg(codec->dev, "Destroying %s cache for %s codec\n",
+			dev_dbg(codec->dev, "ASoC: Destroying %s cache for %s codec\n",
 				codec->cache_ops->name, codec->name);
 		return codec->cache_ops->exit(codec);
 	}
@@ -265,7 +265,7 @@ int snd_soc_cache_sync(struct snd_soc_codec *codec)
 		name = "unknown";
 
 	if (codec->cache_ops->name)
-		dev_dbg(codec->dev, "Syncing %s cache for %s codec\n",
+		dev_dbg(codec->dev, "ASoC: Syncing %s cache for %s codec\n",
 			codec->cache_ops->name, codec->name);
 	trace_snd_soc_cache_sync(codec, name, "start");
 	ret = codec->cache_ops->sync(codec);
-- 
1.7.10.4
