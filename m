From: Mark Brown <broonie@kernel.org>
Subject: Applied "- filename :
	ASoC-rt5677-use-active-low-logic-for-reset-pin.patch
Date: Fri, 30 Oct 2015 10:43:26 +0900
Message-ID: <E1Zryj0-0008Ty-CB@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AC649265917
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 02:43:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

- name          : ASoC: rt5677: use 'active low' logic for reset pin" to the asoc tree
In-Reply-To:  <1446157919-27151-1-git-send-email-anatol.pomozov@gmail.com>

The patch

   - filename      : ASoC-rt5677-use-active-low-logic-for-reset-pin.patch
- name          : ASoC: rt5677: use 'active low' logic for reset pin

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7f7d276ef2f76f781d9867653d22ee96fc86edf2 Mon Sep 17 00:00:00 2001
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Thu, 29 Oct 2015 15:31:59 -0700
Subject: [PATCH] ASoC: rt5677: use 'active low' logic for reset pin

According to the datasheet RESET is active low pin, i.e. system goes to
reset state when pin signal is low.

The previous implementeation was assuming the pin is configured as
'active high' in DTS. Changle the gpio handling code and DTS configuration
to 'active low'.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.6.1
