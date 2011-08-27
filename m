From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] ASoC: Fix register cache sync
	register_writable WARN_ONs
Date: Sat, 27 Aug 2011 18:24:13 +0200
Message-ID: <1314462254-11717-2-git-send-email-lars@metafoo.de>
References: <1314462254-11717-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-092.synserver.de (smtp-out-093.synserver.de
	[212.40.185.93]) by alsa0.perex.cz (Postfix) with SMTP id 79968247EE
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Aug 2011 18:25:09 +0200 (CEST)
In-Reply-To: <1314462254-11717-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Currently the condition for these WARN_ONs is reversed and they are placed
before the actual check whether we are going to write to that register. So if
the codec implements the register_writable callback we'll get a warning for each
writable register when syncing the register cache.

While we are at it change the check to use snd_soc_codec_writable_register
instead of open-coding it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-cache.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index fdfd488..143c705 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -203,14 +203,14 @@ static int snd_soc_rbtree_cache_sync(struct snd_soc_codec *codec)
 		rbnode = rb_entry(node, struct snd_soc_rbtree_node, node);
 		for (i = 0; i < rbnode->blklen; ++i) {
 			regtmp = rbnode->base_reg + i;
-			WARN_ON(codec->writable_register &&
-				codec->writable_register(codec, regtmp));
 			val = snd_soc_rbtree_get_register(rbnode, i);
 			def = snd_soc_get_cache_val(codec->reg_def_copy, i,
 						    rbnode->word_size);
 			if (val == def)
 				continue;
 
+			WARN_ON(!snd_soc_codec_writable_register(codec, regtmp));
+
 			codec->cache_bypass = 1;
 			ret = snd_soc_write(codec, regtmp, val);
 			codec->cache_bypass = 0;
@@ -560,8 +560,7 @@ static int snd_soc_lzo_cache_sync(struct snd_soc_codec *codec)
 
 	lzo_blocks = codec->reg_cache;
 	for_each_set_bit(i, lzo_blocks[0]->sync_bmp, lzo_blocks[0]->sync_bmp_nbits) {
-		WARN_ON(codec->writable_register &&
-			codec->writable_register(codec, i));
+		WARN_ON(!snd_soc_codec_writable_register(codec, i));
 		ret = snd_soc_cache_read(codec, i, &val);
 		if (ret)
 			return ret;
@@ -820,8 +819,6 @@ static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
 
 	codec_drv = codec->driver;
 	for (i = 0; i < codec_drv->reg_cache_size; ++i) {
-		WARN_ON(codec->writable_register &&
-			codec->writable_register(codec, i));
 		ret = snd_soc_cache_read(codec, i, &val);
 		if (ret)
 			return ret;
@@ -829,6 +826,9 @@ static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
 			if (snd_soc_get_cache_val(codec->reg_def_copy,
 						  i, codec_drv->reg_word_size) == val)
 				continue;
+
+		WARN_ON(!snd_soc_codec_writable_register(codec, i));
+
 		ret = snd_soc_write(codec, i, val);
 		if (ret)
 			return ret;
-- 
1.7.2.5
