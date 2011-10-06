From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 03/11] ASoC: wm8731: Convert to snd_soc_write
Date: Fri, 07 Oct 2011 07:47:57 +0800
Message-ID: <1317944877.5579.7.camel@phoenix>
References: <1317944619.5579.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EB61103B12
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 01:48:05 +0200 (CEST)
Received: by ggnf2 with SMTP id f2so2609727ggn.38
	for <alsa-devel@alsa-project.org>; Thu, 06 Oct 2011 16:48:04 -0700 (PDT)
In-Reply-To: <1317944619.5579.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Richard Purdie <rpurdie@rpsys.net>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Convert codec->hw_write to snd_soc_write

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8731.c |   35 ++++++++++++++++++++++-------------
 1 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index f76b6fc..853aed1 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -423,13 +423,31 @@ static int wm8731_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+static void wm8731_sync_cache(struct snd_soc_codec *codec)
+{
+	short i;
+	u16 *cache;
+
+	if (!codec->cache_sync)
+		return;
+	codec->cache_only = 0;
+	codec->cache_bypass = 1;
+	/* restore cache */
+	cache = codec->reg_cache;
+	for (i = 0; i < codec->driver->reg_cache_size; i++) {
+		if (i == WM8731_RESET || cache[i] == wm8731_reg[i])
+			continue;
+		snd_soc_write(codec, i, cache[i]);
+	}
+	codec->cache_bypass = 0;
+	codec->cache_sync = 0;
+}
+
 static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
 	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
-	int i, ret;
-	u8 data[2];
-	u16 *cache = codec->reg_cache;
+	int ret;
 	u16 reg;
 
 	switch (level) {
@@ -444,16 +462,7 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 			if (ret != 0)
 				return ret;
 
-			/* Sync reg_cache with the hardware */
-			for (i = 0; i < ARRAY_SIZE(wm8731_reg); i++) {
-				if (cache[i] == wm8731_reg[i])
-					continue;
-
-				data[0] = (i << 1) | ((cache[i] >> 8)
-						      & 0x0001);
-				data[1] = cache[i] & 0x00ff;
-				codec->hw_write(codec->control_data, data, 2);
-			}
+			wm8731_sync_cache(codec);
 		}
 
 		/* Clear PWROFF, gate CLKOUT, everything else as-is */
-- 
1.7.4.1
