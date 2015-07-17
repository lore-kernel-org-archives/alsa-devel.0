From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] ASoC: rt5677: handle reset_pin logical state
	correctly
Date: Fri, 17 Jul 2015 10:38:56 -0700
Message-ID: <1437154736-15320-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
 [209.85.192.170])
 by alsa0.perex.cz (Postfix) with ESMTP id DA59026062C
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 19:39:42 +0200 (CEST)
Received: by pdjr16 with SMTP id r16so65848253pdj.3
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 10:39:41 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: oder_chiou@realtek.com, broonie@kernel.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

According to the datasheet RESET is active low pin, i.e. system goes to reset
state when pin is low.

Handle logic state correctly - set reset_pin to logical 0 at boot time, and
set it to logical 1 when we need to reset the chip.

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
index 3b46b35..433652f 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4766,7 +4766,7 @@ static int rt5677_remove(struct snd_soc_codec *codec)
 	if (rt5677->pow_ldo2)
 		gpiod_set_value_cansleep(rt5677->pow_ldo2, 0);
 	if (rt5677->reset_pin)
-		gpiod_set_value_cansleep(rt5677->reset_pin, 0);
+		gpiod_set_value_cansleep(rt5677->reset_pin, 1);
 
 	return 0;
 }
@@ -4783,7 +4783,7 @@ static int rt5677_suspend(struct snd_soc_codec *codec)
 		if (rt5677->pow_ldo2)
 			gpiod_set_value_cansleep(rt5677->pow_ldo2, 0);
 		if (rt5677->reset_pin)
-			gpiod_set_value_cansleep(rt5677->reset_pin, 0);
+			gpiod_set_value_cansleep(rt5677->reset_pin, 1);
 	}
 
 	return 0;
@@ -4797,7 +4797,7 @@ static int rt5677_resume(struct snd_soc_codec *codec)
 		if (rt5677->pow_ldo2)
 			gpiod_set_value_cansleep(rt5677->pow_ldo2, 1);
 		if (rt5677->reset_pin)
-			gpiod_set_value_cansleep(rt5677->reset_pin, 1);
+			gpiod_set_value_cansleep(rt5677->reset_pin, 0);
 		if (rt5677->pow_ldo2 || rt5677->reset_pin)
 			msleep(10);
 
@@ -5142,7 +5142,7 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 		rt5677->pow_ldo2 = 0;
 	}
 	rt5677->reset_pin = devm_gpiod_get_optional(&i2c->dev,
-			"realtek,reset", GPIOD_OUT_HIGH);
+			"realtek,reset", GPIOD_OUT_LOW);
 	if (IS_ERR(rt5677->reset_pin)) {
 		ret = PTR_ERR(rt5677->reset_pin);
 		dev_err(&i2c->dev, "Failed to request RESET: %d\n", ret);
-- 
2.4.3.573.g4eafbef
