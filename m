From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: rt5645: Use devm_gpiod_get_optional for
	hp-detect
Date: Fri, 12 Jun 2015 17:19:15 +0800
Message-ID: <1434100755.7458.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 495BF266723
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 11:19:20 +0200 (CEST)
Received: by pabqy3 with SMTP id qy3so19520920pab.3
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 02:19:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Since hp-detect is optional, use devm_gpiod_get_optional instead.
In additional, it should return error if devm_gpiod_get_optional fails.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/rt5645.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 7d04b1a..04d9ff8 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3255,11 +3255,12 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		}
 	}
 
-	rt5645->gpiod_hp_det = devm_gpiod_get(&i2c->dev, "hp-detect", GPIOD_IN);
+	rt5645->gpiod_hp_det = devm_gpiod_get_optional(&i2c->dev, "hp-detect",
+						       GPIOD_IN);
 
 	if (IS_ERR(rt5645->gpiod_hp_det)) {
-		rt5645->gpiod_hp_det = NULL;
 		dev_err(&i2c->dev, "failed to initialize gpiod\n");
+		return PTR_ERR(rt5645->gpiod_hp_det);
 	}
 
 	rt5645->regmap = devm_regmap_init_i2c(i2c, &rt5645_regmap);
-- 
2.1.0
