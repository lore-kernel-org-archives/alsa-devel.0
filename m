From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] ASoC: rt5677: use 'active low' logic for reset
	pin
Date: Thu, 29 Oct 2015 15:31:59 -0700
Message-ID: <1446157919-27151-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CE4B2651A5
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 23:32:04 +0100 (CET)
Received: by padhk11 with SMTP id hk11so52972435pad.1
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 15:32:03 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: oder_chiou@realtek.com, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

According to the datasheet RESET is active low pin, i.e. system goes to
reset state when pin signal is low.

The previous implementeation was assuming the pin is configured as
'active high' in DTS. Changle the gpio handling code and DTS configuration
to 'active low'.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 Documentation/devicetree/bindings/sound/rt5677.txt | 2 +-
 sound/soc/codecs/rt5677.c                          | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5677.txt b/Documentation/devicetree/bindings/sound/rt5677.txt
index f070789..1b3c13d 100644
--- a/Documentation/devicetree/bindings/sound/rt5677.txt
+++ b/Documentation/devicetree/bindings/sound/rt5677.txt
@@ -18,7 +18,7 @@ Required properties:
 Optional properties:
 
 - realtek,pow-ldo2-gpio : The GPIO that controls the CODEC's POW_LDO2 pin.
-- realtek,reset-gpio : The GPIO that controls the CODEC's RESET pin.
+- realtek,reset-gpio : The GPIO that controls the CODEC's RESET pin. Active low.
 
 - realtek,in1-differential
 - realtek,in2-differential
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index b4cd7e3..f73fd12 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4766,7 +4766,7 @@ static int rt5677_remove(struct snd_soc_codec *codec)
 
 	regmap_write(rt5677->regmap, RT5677_RESET, 0x10ec);
 	gpiod_set_value_cansleep(rt5677->pow_ldo2, 0);
-	gpiod_set_value_cansleep(rt5677->reset_pin, 0);
+	gpiod_set_value_cansleep(rt5677->reset_pin, 1);
 
 	return 0;
 }
@@ -4781,7 +4781,7 @@ static int rt5677_suspend(struct snd_soc_codec *codec)
 		regcache_mark_dirty(rt5677->regmap);
 
 		gpiod_set_value_cansleep(rt5677->pow_ldo2, 0);
-		gpiod_set_value_cansleep(rt5677->reset_pin, 0);
+		gpiod_set_value_cansleep(rt5677->reset_pin, 1);
 	}
 
 	return 0;
@@ -4793,7 +4793,7 @@ static int rt5677_resume(struct snd_soc_codec *codec)
 
 	if (!rt5677->dsp_vad_en) {
 		gpiod_set_value_cansleep(rt5677->pow_ldo2, 1);
-		gpiod_set_value_cansleep(rt5677->reset_pin, 1);
+		gpiod_set_value_cansleep(rt5677->reset_pin, 0);
 		if (rt5677->pow_ldo2 || rt5677->reset_pin)
 			msleep(10);
 
@@ -5138,7 +5138,7 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 	rt5677->reset_pin = devm_gpiod_get_optional(&i2c->dev,
-			"realtek,reset", GPIOD_OUT_HIGH);
+			"realtek,reset", GPIOD_OUT_LOW);
 	if (IS_ERR(rt5677->reset_pin)) {
 		ret = PTR_ERR(rt5677->reset_pin);
 		dev_err(&i2c->dev, "Failed to request RESET: %d\n", ret);
-- 
2.6.0.rc2.230.g3dd15c0
