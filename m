From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/8] ASoC: wm8996: Mark the CODEC as cache only
	when powering off on boot
Date: Mon, 11 Jun 2012 19:55:36 +0800
Message-ID: <1339415740-2376-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1339415740-2376-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 882D010427E
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 13:56:17 +0200 (CEST)
In-Reply-To: <1339415740-2376-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Otherwise we might try to write to a powered off device.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index f1bf664..eec7166 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2659,8 +2659,6 @@ static int wm8996_probe(struct snd_soc_codec *codec)
 		}
 	}
 
-	regcache_cache_only(codec->control_data, true);
-
 	/* Apply platform data settings */
 	snd_soc_update_bits(codec, WM8996_LINE_INPUT_CONTROL,
 			    WM8996_INL_MODE_MASK | WM8996_INR_MODE_MASK,
@@ -3033,6 +3031,7 @@ static __devinit int wm8996_i2c_probe(struct i2c_client *i2c,
 		goto err_regmap;
 	}
 
+	regcache_cache_only(wm8996->regmap, true);
 	regulator_bulk_disable(ARRAY_SIZE(wm8996->supplies), wm8996->supplies);
 
 	wm8996_init_gpio(wm8996);
-- 
1.7.10
