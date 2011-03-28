From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: soc-cache: Warn on syncing any
	non-writable registers
Date: Mon, 28 Mar 2011 11:39:15 +0100
Message-ID: <1301308755-18313-2-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1301308755-18313-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 556F8103964
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Mar 2011 12:39:17 +0200 (CEST)
In-Reply-To: <1301308755-18313-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@ti.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

When syncing the cache, if the driver has given us a writable_register()
callback, use it to check if we are syncing a non-writable register
and if so warn the user.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 22c0b95..22b0990 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -661,6 +661,8 @@ static int snd_soc_rbtree_cache_sync(struct snd_soc_codec *codec)
 		rbnode = rb_entry(node, struct snd_soc_rbtree_node, node);
 		if (rbnode->value == rbnode->defval)
 			continue;
+		WARN_ON(codec->writable_register &&
+			codec->writable_register(codec, rbnode->reg));
 		ret = snd_soc_cache_read(codec, rbnode->reg, &val);
 		if (ret)
 			return ret;
@@ -921,6 +923,8 @@ static int snd_soc_lzo_cache_sync(struct snd_soc_codec *codec)
 
 	lzo_blocks = codec->reg_cache;
 	for_each_set_bit(i, lzo_blocks[0]->sync_bmp, lzo_blocks[0]->sync_bmp_nbits) {
+		WARN_ON(codec->writable_register &&
+			codec->writable_register(codec, i));
 		ret = snd_soc_cache_read(codec, i, &val);
 		if (ret)
 			return ret;
@@ -1179,6 +1183,8 @@ static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
 
 	codec_drv = codec->driver;
 	for (i = 0; i < codec_drv->reg_cache_size; ++i) {
+		WARN_ON(codec->writable_register &&
+			codec->writable_register(codec, i));
 		ret = snd_soc_cache_read(codec, i, &val);
 		if (ret)
 			return ret;
-- 
1.7.4.1
