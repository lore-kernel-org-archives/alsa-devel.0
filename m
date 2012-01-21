From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/5] ASoC: wm8985 Don't directly reference the
	cache data structure
Date: Sat, 21 Jan 2012 15:45:26 +0000
Message-ID: <1327160727-1546-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1327160727-1546-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6B5C210389A
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2012 16:45:33 +0100 (CET)
In-Reply-To: <1327160727-1546-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

In preparation for conversion to regmap.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8985.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index 297119f..bbe19b2 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -946,7 +946,6 @@ static int wm8985_probe(struct snd_soc_codec *codec)
 	size_t i;
 	struct wm8985_priv *wm8985;
 	int ret;
-	u16 *cache;
 
 	wm8985 = snd_soc_codec_get_drvdata(codec);
 
@@ -979,13 +978,13 @@ static int wm8985_probe(struct snd_soc_codec *codec)
 		goto err_reg_enable;
 	}
 
-	cache = codec->reg_cache;
 	/* latch volume update bits */
 	for (i = 0; i < ARRAY_SIZE(volume_update_regs); ++i)
-		cache[volume_update_regs[i]] |= 0x100;
+		snd_soc_update_bits(codec, volume_update_regs[i],
+				    0x100, 0x100);
 	/* enable BIASCUT */
-	cache[WM8985_BIAS_CTRL] |= WM8985_BIASCUT;
-	codec->cache_sync = 1;
+	snd_soc_update_bits(codec, WM8985_BIAS_CTRL, WM8985_BIASCUT,
+			    WM8985_BIASCUT);
 
 	wm8985_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	return 0;
-- 
1.7.7.3
