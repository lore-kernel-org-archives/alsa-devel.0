From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: soc-cache: Ignore
	!codec->writable_register() during syncing
Date: Thu, 24 Mar 2011 13:45:19 +0000
Message-ID: <1300974319-14423-3-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1300974319-14423-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8DC05103A27
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2011 14:45:28 +0100 (CET)
In-Reply-To: <1300974319-14423-1-git-send-email-dp@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

When syncing the cache, if the driver has given us a writable_register()
callback, use it to not sync any non-writable registers.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 657889d..0ec8e13 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -889,6 +889,9 @@ static int snd_soc_rbtree_cache_sync(struct snd_soc_codec *codec)
 		rbnode = rb_entry(node, struct snd_soc_rbtree_node, node);
 		if (rbnode->value == rbnode->defval)
 			continue;
+		if (codec->writable_register &&
+		    !codec->writable_register(codec, rbnode->reg))
+			continue;
 		ret = snd_soc_cache_read(codec, rbnode->reg, &val);
 		if (ret)
 			return ret;
@@ -1149,6 +1152,8 @@ static int snd_soc_lzo_cache_sync(struct snd_soc_codec *codec)
 
 	lzo_blocks = codec->reg_cache;
 	for_each_set_bit(i, lzo_blocks[0]->sync_bmp, lzo_blocks[0]->sync_bmp_nbits) {
+		if (codec->writable_register && !codec->writable_register(codec, i))
+			continue;
 		ret = snd_soc_cache_read(codec, i, &val);
 		if (ret)
 			return ret;
@@ -1407,6 +1412,8 @@ static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
 
 	codec_drv = codec->driver;
 	for (i = 0; i < codec_drv->reg_cache_size; ++i) {
+		if (codec->writable_register && !codec->writable_register(codec, i))
+			continue;
 		ret = snd_soc_cache_read(codec, i, &val);
 		if (ret)
 			return ret;
-- 
1.7.4.1
