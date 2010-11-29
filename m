From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-cache: Add error checking in the
	*_cache_sync functions
Date: Mon, 29 Nov 2010 10:24:54 +0000
Message-ID: <1291026294-31869-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9ED08244FB
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 11:24:56 +0100 (CET)
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

Ensure that we report any errors encountered during reads/writes
in the cache syncing functions.

Remove redundant newline in the source code.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |   28 +++++++++++++++++++++-------
 1 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 6c0589e..e5b1888 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -792,7 +792,6 @@ static struct snd_soc_rbtree_node *snd_soc_rbtree_lookup(
 	return NULL;
 }
 
-
 static int snd_soc_rbtree_insert(struct rb_root *root,
 				 struct snd_soc_rbtree_node *rbnode)
 {
@@ -826,14 +825,19 @@ static int snd_soc_rbtree_cache_sync(struct snd_soc_codec *codec)
 	struct rb_node *node;
 	struct snd_soc_rbtree_node *rbnode;
 	unsigned int val;
+	int ret;
 
 	rbtree_ctx = codec->reg_cache;
 	for (node = rb_first(&rbtree_ctx->root); node; node = rb_next(node)) {
 		rbnode = rb_entry(node, struct snd_soc_rbtree_node, node);
 		if (rbnode->value == rbnode->defval)
 			continue;
-		snd_soc_cache_read(codec, rbnode->reg, &val);
-		snd_soc_write(codec, rbnode->reg, val);
+		ret = snd_soc_cache_read(codec, rbnode->reg, &val);
+		if (ret)
+			return ret;
+		ret = snd_soc_write(codec, rbnode->reg, val);
+		if (ret)
+			return ret;
 		dev_dbg(codec->dev, "Synced register %#x, value = %#x\n",
 			rbnode->reg, val);
 	}
@@ -1110,11 +1114,16 @@ static int snd_soc_lzo_cache_sync(struct snd_soc_codec *codec)
 	struct snd_soc_lzo_ctx **lzo_blocks;
 	unsigned int val;
 	int i;
+	int ret;
 
 	lzo_blocks = codec->reg_cache;
 	for_each_set_bit(i, lzo_blocks[0]->sync_bmp, lzo_blocks[0]->sync_bmp_nbits) {
-		snd_soc_cache_read(codec, i, &val);
-		snd_soc_write(codec, i, val);
+		ret = snd_soc_cache_read(codec, i, &val);
+		if (ret)
+			return ret;
+		ret = snd_soc_write(codec, i, val);
+		if (ret)
+			return ret;
 		dev_dbg(codec->dev, "Synced register %#x, value = %#x\n",
 			i, val);
 	}
@@ -1390,12 +1399,15 @@ err_tofree:
 static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
 {
 	int i;
+	int ret;
 	struct snd_soc_codec_driver *codec_drv;
 	unsigned int val;
 
 	codec_drv = codec->driver;
 	for (i = 0; i < codec_drv->reg_cache_size; ++i) {
-		snd_soc_cache_read(codec, i, &val);
+		ret = snd_soc_cache_read(codec, i, &val);
+		if (ret)
+			return ret;
 		if (codec_drv->reg_cache_default) {
 			switch (codec_drv->reg_word_size) {
 			case 1: {
@@ -1418,7 +1430,9 @@ static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
 				BUG();
 			}
 		}
-		snd_soc_write(codec, i, val);
+		ret = snd_soc_write(codec, i, val);
+		if (ret)
+			return ret;
 		dev_dbg(codec->dev, "Synced register %#x, value = %#x\n",
 			i, val);
 	}
-- 
1.7.3.2
