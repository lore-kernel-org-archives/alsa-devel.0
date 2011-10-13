From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: sta32x: Set reg_cache_default to sta32x_regs
Date: Thu, 13 Oct 2011 14:40:08 +0800
Message-ID: <1318488008.2857.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Johannes Stezenbach <js@sig21.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/sta32x.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 5c7def3..754b3ff 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -756,10 +756,6 @@ static int sta32x_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	/* read reg reset values into cache */
-	for (i = 0; i < STA32X_REGISTER_COUNT; i++)
-		snd_soc_cache_write(codec, i, sta32x_regs[i]);
-
 	/* preserve reset values of reserved register bits */
 	snd_soc_cache_write(codec, STA32X_CONFC,
 			    codec->hw_read(codec, STA32X_CONFC));
@@ -837,6 +833,7 @@ static const struct snd_soc_codec_driver sta32x_codec = {
 	.resume =		sta32x_resume,
 	.reg_cache_size =	STA32X_REGISTER_COUNT,
 	.reg_word_size =	sizeof(u8),
+	.reg_cache_default =	sta32x_regs,
 	.volatile_register =	sta32x_reg_is_volatile,
 	.set_bias_level =	sta32x_set_bias_level,
 	.controls =		sta32x_snd_controls,
-- 
1.7.4.1
