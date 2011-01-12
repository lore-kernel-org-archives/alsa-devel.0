From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-cache: Ensure flat compression uses
	a copy of the defaults cache
Date: Wed, 12 Jan 2011 10:22:28 +0000
Message-ID: <1294827748-27755-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 44007244DA
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 11:22:31 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

With the addition of the cache fallback functionality, it is necessary
to ensure that if the register defaults cache was marked as __devinitconst
and the LZO compression is not compiled in the kernel, the fallback to
flat compression will still use a copy of the defaults cache.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index b0d86cc..2f1d596 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -1400,8 +1400,8 @@ static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
 		ret = snd_soc_cache_read(codec, i, &val);
 		if (ret)
 			return ret;
-		if (codec_drv->reg_cache_default)
-			if (snd_soc_get_cache_val(codec_drv->reg_cache_default,
+		if (codec->reg_def_copy)
+			if (snd_soc_get_cache_val(codec->reg_def_copy,
 						  i, codec_drv->reg_word_size) == val)
 				continue;
 		ret = snd_soc_write(codec, i, val);
@@ -1446,16 +1446,8 @@ static int snd_soc_flat_cache_init(struct snd_soc_codec *codec)
 	codec_drv = codec->driver;
 	reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
 
-	/*
-	 * for flat compression, we don't need to keep a copy of the
-	 * original defaults register cache as it will definitely not
-	 * be marked as __devinitconst
-	 */
-	kfree(codec->reg_def_copy);
-	codec->reg_def_copy = NULL;
-
-	if (codec_drv->reg_cache_default)
-		codec->reg_cache = kmemdup(codec_drv->reg_cache_default,
+	if (codec->reg_def_copy)
+		codec->reg_cache = kmemdup(codec->reg_def_copy,
 					   reg_size, GFP_KERNEL);
 	else
 		codec->reg_cache = kzalloc(reg_size, GFP_KERNEL);
-- 
1.7.3.5
