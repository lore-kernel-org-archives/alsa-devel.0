From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: soc-cache: Remove unneeded codec_drv pointer
 variable in snd_soc_lzo_get_blksize
Date: Sat, 13 Aug 2011 21:27:16 +0800
Message-ID: <1313242036.12301.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Since commit aea170a099793abcd0e6de46b947458073204241
"ASoC: soc-cache: Add reg_size as a member to snd_soc_codec",
the codec_drv pointer variable is not used in snd_soc_lzo_get_blksize.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/soc-cache.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index c17d012..fdfd488 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -548,9 +548,6 @@ static inline int snd_soc_lzo_get_blkpos(struct snd_soc_codec *codec,
 
 static inline int snd_soc_lzo_get_blksize(struct snd_soc_codec *codec)
 {
-	const struct snd_soc_codec_driver *codec_drv;
-
-	codec_drv = codec->driver;
 	return DIV_ROUND_UP(codec->reg_size, snd_soc_lzo_block_count());
 }
 
-- 
1.7.4.1
