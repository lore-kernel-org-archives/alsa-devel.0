From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-cache: Add optional cache name
	member to snd_soc_cache_ops
Date: Mon,  6 Dec 2010 09:51:57 +0000
Message-ID: <1291629117-29517-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 80D30103817
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 10:51:59 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Added an optional name member to snd_soc_cache_ops to enable more
sensible diagnostic messages during cache init, exit and sync.

Remove redundant newline in source code.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/soc.h   |    1 +
 sound/soc/soc-cache.c |   18 ++++++++++++++++--
 sound/soc/soc-core.c  |    3 ---
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0eea08e..cabc450 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -437,6 +437,7 @@ struct snd_soc_ops {
 
 /* SoC cache ops */
 struct snd_soc_cache_ops {
+	const char *name;
 	enum snd_soc_compress_type id;
 	int (*init)(struct snd_soc_codec *codec);
 	int (*exit)(struct snd_soc_codec *codec);
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index ff2bc8b..678fd75 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -1533,6 +1533,7 @@ static int snd_soc_flat_cache_init(struct snd_soc_codec *codec)
 static const struct snd_soc_cache_ops cache_types[] = {
 	{
 		.id = SND_SOC_FLAT_COMPRESSION,
+		.name = "flat",
 		.init = snd_soc_flat_cache_init,
 		.exit = snd_soc_flat_cache_exit,
 		.read = snd_soc_flat_cache_read,
@@ -1541,6 +1542,7 @@ static const struct snd_soc_cache_ops cache_types[] = {
 	},
 	{
 		.id = SND_SOC_LZO_COMPRESSION,
+		.name = "LZO",
 		.init = snd_soc_lzo_cache_init,
 		.exit = snd_soc_lzo_cache_exit,
 		.read = snd_soc_lzo_cache_read,
@@ -1549,6 +1551,7 @@ static const struct snd_soc_cache_ops cache_types[] = {
 	},
 	{
 		.id = SND_SOC_RBTREE_COMPRESSION,
+		.name = "rbtree",
 		.init = snd_soc_rbtree_cache_init,
 		.exit = snd_soc_rbtree_cache_exit,
 		.read = snd_soc_rbtree_cache_read,
@@ -1573,8 +1576,12 @@ int snd_soc_cache_init(struct snd_soc_codec *codec)
 	mutex_init(&codec->cache_rw_mutex);
 	codec->cache_ops = &cache_types[i];
 
-	if (codec->cache_ops->init)
+	if (codec->cache_ops->init) {
+		if (codec->cache_ops->name)
+			dev_dbg(codec->dev, "Initializing %s cache for %s codec\n",
+				codec->cache_ops->name, codec->name);
 		return codec->cache_ops->init(codec);
+	}
 	return -EINVAL;
 }
 
@@ -1584,8 +1591,12 @@ int snd_soc_cache_init(struct snd_soc_codec *codec)
  */
 int snd_soc_cache_exit(struct snd_soc_codec *codec)
 {
-	if (codec->cache_ops && codec->cache_ops->exit)
+	if (codec->cache_ops && codec->cache_ops->exit) {
+		if (codec->cache_ops->name)
+			dev_dbg(codec->dev, "Destroying %s cache for %s codec\n",
+				codec->cache_ops->name, codec->name);
 		return codec->cache_ops->exit(codec);
+	}
 	return -EINVAL;
 }
 
@@ -1657,6 +1668,9 @@ int snd_soc_cache_sync(struct snd_soc_codec *codec)
 	}
 
 	if (codec->cache_ops && codec->cache_ops->sync) {
+		if (codec->cache_ops->name)
+			dev_dbg(codec->dev, "Syncing %s cache for %s codec\n",
+				codec->cache_ops->name, codec->name);
 		ret = codec->cache_ops->sync(codec);
 		if (!ret)
 			codec->cache_sync = 0;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 78a0101..880ef4b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1741,8 +1741,6 @@ static int snd_soc_init_codec_cache(struct snd_soc_codec *codec,
 	/* override the compress_type if necessary */
 	if (compress_type && codec->compress_type != compress_type)
 		codec->compress_type = compress_type;
-	dev_dbg(codec->dev, "Cache compress_type for %s is %d\n",
-		codec->name, codec->compress_type);
 	ret = snd_soc_cache_init(codec);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache compression type: %d\n",
@@ -1753,7 +1751,6 @@ static int snd_soc_init_codec_cache(struct snd_soc_codec *codec,
 	return 0;
 }
 
-
 static void snd_soc_instantiate_card(struct snd_soc_card *card)
 {
 	struct platform_device *pdev = to_platform_device(card->dev);
-- 
1.7.3.2
