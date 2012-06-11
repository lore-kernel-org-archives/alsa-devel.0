From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/5] ASoC: wm8904: Fix GPIO and MICBIAS
	initialisation for regmap conversion
Date: Mon, 11 Jun 2012 13:10:43 +0800
Message-ID: <1339391447-8721-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E820D1041DA
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 07:11:31 +0200 (CEST)
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

We no longer have a flat ASoC cache so can't peer directly into the array
any more but should instead use the register I/O functions to update the
cache.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8904.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 560a9a47..461c58a 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2084,7 +2084,6 @@ static int wm8904_probe(struct snd_soc_codec *codec)
 {
 	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
 	struct wm8904_pdata *pdata = wm8904->pdata;
-	u16 *reg_cache = codec->reg_cache;
 	int ret, i;
 
 	codec->cache_sync = 1;
@@ -2180,14 +2179,18 @@ static int wm8904_probe(struct snd_soc_codec *codec)
 			if (!pdata->gpio_cfg[i])
 				continue;
 
-			reg_cache[WM8904_GPIO_CONTROL_1 + i]
-				= pdata->gpio_cfg[i] & 0xffff;
+			regmap_update_bits(wm8904->regmap,
+					   WM8904_GPIO_CONTROL_1 + i,
+					   0xffff,
+					   pdata->gpio_cfg[i]);
 		}
 
 		/* Zero is the default value for these anyway */
 		for (i = 0; i < WM8904_MIC_REGS; i++)
-			reg_cache[WM8904_MIC_BIAS_CONTROL_0 + i]
-				= pdata->mic_cfg[i];
+			regmap_update_bits(wm8904->regmap,
+					   WM8904_MIC_BIAS_CONTROL_0 + i,
+					   0xffff,
+					   pdata->mic_cfg[i]);
 	}
 
 	/* Set Class W by default - this will be managed by the Class
-- 
1.7.10
