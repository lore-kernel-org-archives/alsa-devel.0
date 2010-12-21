From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Make LZO cache compression optional
Date: Tue, 21 Dec 2010 17:20:17 +0000
Message-ID: <1292952017-8232-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 027CF1039F7
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 18:20:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Make LZO cache compression optional as it pulls in the kernel wide LZO
implementation and rbtree compression is generally more efficient for
typical register maps, especially in terms of CPU performance.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/Kconfig     |   17 +++++++++++++++--
 sound/soc/soc-cache.c |    4 ++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 21a5465..a3efc52 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -4,8 +4,6 @@
 
 menuconfig SND_SOC
 	tristate "ALSA for SoC audio support"
-	select LZO_COMPRESS
-	select LZO_DECOMPRESS
 	select SND_PCM
 	select AC97_BUS if SND_SOC_AC97_BUS
 	select SND_JACK if INPUT=y || INPUT=SND
@@ -22,6 +20,21 @@ menuconfig SND_SOC
 
 if SND_SOC
 
+config SND_SOC_CACHE_LZO
+	bool "Support LZO compression for register caches"
+	select LZO_COMPRESS
+	select LZO_DECOMPRESS
+	---help---
+	   Select this to enable LZO compression for register caches.
+	   This will allow machine or CODEC drivers to compress register
+	   caches in memory, reducing the memory consumption at the
+	   expense of performance.  If this is not present and is used
+	   the system will fall back to uncompressed caches.
+
+	   Usually it is safe to disable this option, where cache
+	   compression in used the rbtree option will typically perform
+	   better.
+
 config SND_SOC_AC97_BUS
 	bool
 
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index d78e5b7..6b95ae7 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -988,6 +988,7 @@ static int snd_soc_rbtree_cache_init(struct snd_soc_codec *codec)
 	return 0;
 }
 
+#ifdef CONFIG_SND_SOC_CACHE_LZO
 struct snd_soc_lzo_ctx {
 	void *wmem;
 	void *dst;
@@ -1399,6 +1400,7 @@ err_tofree:
 	}
 	return ret;
 }
+#endif
 
 static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
 {
@@ -1541,6 +1543,7 @@ static const struct snd_soc_cache_ops cache_types[] = {
 		.write = snd_soc_flat_cache_write,
 		.sync = snd_soc_flat_cache_sync
 	},
+#ifdef CONFIG_SND_SOC_CACHE_LZO
 	{
 		.id = SND_SOC_LZO_COMPRESSION,
 		.name = "LZO",
@@ -1550,6 +1553,7 @@ static const struct snd_soc_cache_ops cache_types[] = {
 		.write = snd_soc_lzo_cache_write,
 		.sync = snd_soc_lzo_cache_sync
 	},
+#endif
 	{
 		.id = SND_SOC_RBTREE_COMPRESSION,
 		.name = "rbtree",
-- 
1.7.2.3
