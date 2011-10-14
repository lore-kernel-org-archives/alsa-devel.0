From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/3] ASoC: alc5623: Convert codec->hw_read to snd_soc_read
Date: Fri, 14 Oct 2011 09:35:20 +0800
Message-ID: <1318556120.6379.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

codec->hw_read is broken now, let's covert to snd_soc_read.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/alc5623.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index 557b3af..984b14b 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -53,8 +53,10 @@ static void alc5623_fill_cache(struct snd_soc_codec *codec)
 	u16 *cache = codec->reg_cache;
 
 	/* not really efficient ... */
+	codec->cache_bypass = 1;
 	for (i = 0 ; i < codec->driver->reg_cache_size ; i += step)
-		cache[i] = codec->hw_read(codec, i);
+		cache[i] = snd_soc_read(codec, i);
+	codec->cache_bypass = 0;
 }
 
 static inline int alc5623_reset(struct snd_soc_codec *codec)
-- 
1.7.4.1
