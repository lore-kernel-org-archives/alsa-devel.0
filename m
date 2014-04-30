From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: cq93vc: fix cq93vc_get_regmap build error
Date: Wed, 30 Apr 2014 11:06:29 +0200
Message-ID: <4308079.So6q7GrfYB@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

49101a25acd69c "ASoC: cq93vc: Remove the set_cache_io() entirely from
ASoC probe" introduced the cq93vc_get_regmap function that has an
obvious build error referring to the 'codec' variable that is not
declared anywhere"

sound/soc/codecs/cq93vc.c: In function 'cq93vc_get_regmap':
sound/soc/codecs/cq93vc.c:157:34: error: 'codec' undeclared (first use in this function)
  struct davinci_vc *davinci_vc = codec->dev->platform_data;
                                  ^

This changes the code to compile again, presumably in the way it was
intended. Not tested.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Xiubo Li <Li.Xiubo@freescale.com>

diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 5ee48c8..537327c 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -154,7 +154,7 @@ static int cq93vc_remove(struct snd_soc_codec *codec)
 
 static struct regmap *cq93vc_get_regmap(struct device *dev)
 {
-	struct davinci_vc *davinci_vc = codec->dev->platform_data;
+	struct davinci_vc *davinci_vc = dev->platform_data;
 
 	return davinci_vc->regmap;
 }
