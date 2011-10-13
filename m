From: Axel Lin <axel.lin@gmail.com>
Subject: [RFC][PATCH] ASoC: Suppress restore of default register values for
 lzo cache sync
Date: Thu, 13 Oct 2011 17:28:33 +0800
Message-ID: <1318498113.2857.16.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Currently we do suppress restore of default register values for rbtree
and flat cache sync.
A couple users use this trick to avoid writing reset register while resume.
Thus make lzo cache sync suppress restore of default register values,
so we have consistent behavior for all types of cache sync.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/soc-cache.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 9077aa4..eb3c016 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -555,16 +555,22 @@ static inline int snd_soc_lzo_get_blksize(struct snd_soc_codec *codec)
 static int snd_soc_lzo_cache_sync(struct snd_soc_codec *codec)
 {
 	struct snd_soc_lzo_ctx **lzo_blocks;
-	unsigned int val;
+	unsigned int val, def;
+	unsigned int word_size;
 	int i;
 	int ret;
 
 	lzo_blocks = codec->reg_cache;
+	word_size = codec->driver->reg_word_size;
 	for_each_set_bit(i, lzo_blocks[0]->sync_bmp, lzo_blocks[0]->sync_bmp_nbits) {
 		WARN_ON(!snd_soc_codec_writable_register(codec, i));
 		ret = snd_soc_cache_read(codec, i, &val);
 		if (ret)
 			return ret;
+		def = snd_soc_get_cache_val(codec->reg_def_copy, i, word_size);
+		if (val == def)
+			continue;
+
 		codec->cache_bypass = 1;
 		ret = snd_soc_write(codec, i, val);
 		codec->cache_bypass = 0;
-- 
1.7.4.1
