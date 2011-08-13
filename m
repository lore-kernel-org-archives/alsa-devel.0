From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: soc-cache: Remove unneeded codec_drv pointer
 variable in snd_soc_flat_cache_init
Date: Sat, 13 Aug 2011 21:12:01 +0800
Message-ID: <1313241121.12301.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Since commit d779fce5d79525d66269c8f6e430e1515d697f3d
"ASoC: soc-cache: Ensure flat compression uses a copy of the defaults cache",
the codec_drv pointer variable is not used any more.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/soc-cache.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index d9f8ade..c17d012 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -868,10 +868,6 @@ static int snd_soc_flat_cache_exit(struct snd_soc_codec *codec)
 
 static int snd_soc_flat_cache_init(struct snd_soc_codec *codec)
 {
-	const struct snd_soc_codec_driver *codec_drv;
-
-	codec_drv = codec->driver;
-
 	if (codec->reg_def_copy)
 		codec->reg_cache = kmemdup(codec->reg_def_copy,
 					   codec->reg_size, GFP_KERNEL);
-- 
1.7.4.1
