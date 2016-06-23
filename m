From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: cs53l30: Add MUTE pin control support via GPIO" to the asoc tree
Date: Thu, 23 Jun 2016 11:36:22 +0100
Message-ID: <E1bG1zi-0001hA-Iz@debutante>
References: <1466553013-15154-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1466553013-15154-1-git-send-email-nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Paul Handrigan <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.orgPaul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs53l30: Add MUTE pin control support via GPIO

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

>From 05f33bc5d6df03426e631cea5d1a8568d43ab07f Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Tue, 21 Jun 2016 16:50:13 -0700
Subject: [PATCH] ASoC: cs53l30: Add MUTE pin control support via GPIO

The codec chip has a physical MUTE pin to let users control it via
GPIO. So this patch add a mute control support to the driver.

Signed-off-by: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Paul Handrigan <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/sound/cs53l30.txt          |  4 +++
 sound/soc/codecs/cs53l30.c                         | 30 ++++++++++++++++++++++
 sound/soc/codecs/cs53l30.h                         |  1 +
 3 files changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cs53l30.txt b/Documentation/devicetree/bindings/sound/cs53l30.txt
index 18d6b99e0a2d..4dbfb8274cd9 100644
--- a/Documentation/devicetree/bindings/sound/cs53l30.txt
+++ b/Documentation/devicetree/bindings/sound/cs53l30.txt
@@ -13,6 +13,10 @@ Optional properties:
 
   - reset-gpios : a GPIO spec for the reset pin.
 
+  - mute-gpios : a GPIO spec for the MUTE pin. The active state can be either
+		 GPIO_ACTIVE_HIGH or GPIO_ACTIVE_LOW, which would be handled
+		 by the driver automatically.
+
   - cirrus,micbias-lvl : Set the output voltage level on the MICBIAS Pin.
 			 0 = Hi-Z
 			 1 = 1.80 V
diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index b0a64a19a045..5988b5c672fe 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -35,6 +35,7 @@ struct cs53l30_private {
 	struct regulator_bulk_data	supplies[CS53L30_NUM_SUPPLIES];
 	struct regmap			*regmap;
 	struct gpio_desc		*reset_gpio;
+	struct gpio_desc		*mute_gpio;
 	struct clk			*mclk;
 	bool				use_sdout2;
 	u32				mclk_rate;
@@ -833,6 +834,16 @@ static int cs53l30_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	return 0;
 }
 
+static int cs53l30_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
+{
+	struct cs53l30_private *priv = snd_soc_codec_get_drvdata(dai->codec);
+
+	if (priv->mute_gpio)
+		gpiod_set_value_cansleep(priv->mute_gpio, mute);
+
+	return 0;
+}
+
 /* SNDRV_PCM_RATE_KNOT -> 12000, 24000 Hz, limit with constraint list */
 #define CS53L30_RATES (SNDRV_PCM_RATE_8000_48000 | SNDRV_PCM_RATE_KNOT)
 
@@ -846,6 +857,7 @@ static const struct snd_soc_dai_ops cs53l30_ops = {
 	.set_sysclk = cs53l30_set_sysclk,
 	.set_tristate = cs53l30_set_tristate,
 	.set_tdm_slot = cs53l30_set_dai_tdm_slot,
+	.mute_stream = cs53l30_mute_stream,
 };
 
 static struct snd_soc_dai_driver cs53l30_dai = {
@@ -991,6 +1003,24 @@ static int cs53l30_i2c_probe(struct i2c_client *client,
 		cs53l30->mclk = NULL;
 	}
 
+	/* Fetch the MUTE control */
+	cs53l30->mute_gpio = devm_gpiod_get_optional(dev, "mute",
+						     GPIOD_OUT_HIGH);
+	if (IS_ERR(cs53l30->mute_gpio)) {
+		ret = PTR_ERR(cs53l30->mute_gpio);
+		goto error;
+	}
+
+	if (cs53l30->mute_gpio) {
+		/* Enable MUTE controls via MUTE pin */
+		regmap_write(cs53l30->regmap, CS53L30_MUTEP_CTL1,
+			     CS53L30_MUTEP_CTL1_MUTEALL);
+		/* Flip the polarity of MUTE pin */
+		if (gpiod_is_active_low(cs53l30->mute_gpio))
+			regmap_update_bits(cs53l30->regmap, CS53L30_MUTEP_CTL2,
+					   CS53L30_MUTE_PIN_POLARITY, 0);
+	}
+
 	if (!of_property_read_u8(np, "cirrus,micbias-lvl", &val))
 		regmap_update_bits(cs53l30->regmap, CS53L30_MICBIAS_CTL,
 				   CS53L30_MIC_BIAS_CTRL_MASK, val);
diff --git a/sound/soc/codecs/cs53l30.h b/sound/soc/codecs/cs53l30.h
index 0dd4afbb5c64..5e39da568749 100644
--- a/sound/soc/codecs/cs53l30.h
+++ b/sound/soc/codecs/cs53l30.h
@@ -253,6 +253,7 @@
 #define CS53L30_MUTE_MB_ALL_PDN_MASK	(1 << CS53L30_MUTE_MB_ALL_PDN_SHIFT)
 #define CS53L30_MUTE_MB_ALL_PDN		(1 << CS53L30_MUTE_MB_ALL_PDN_SHIFT)
 
+#define CS53L30_MUTEP_CTL1_MUTEALL	(0xdf)
 #define CS53L30_MUTEP_CTL1_DEFAULT	(0)
 
 /* R32 (0x20) CS53L30_MUTEP_CTL2 - MUTE Pin Control 2 */
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
