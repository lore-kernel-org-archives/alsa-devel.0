From: "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
Subject: Re: [PATCH v2] ASoC: cs53l30: Add MUTE pin control support via GPIO
Date: Wed, 22 Jun 2016 15:18:21 +0000
Message-ID: <D390164D.14E1A%Paul.Handrigan@cirrus.com>
References: <1466553013-15154-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466553013-15154-1-git-send-email-nicoleotsuka@gmail.com>
Content-Language: en-US
Content-ID: <0D61BF437E426A479D9D2B357529EB5F@ad.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Austin, Brian" <Brian.Austin@cirrus.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>
List-Id: alsa-devel@alsa-project.org



On 6/21/16, 6:50 PM, "Nicolin Chen" <nicoleotsuka@gmail.com> wrote:

>The codec chip has a physical MUTE pin to let users control it via
>GPIO. So this patch add a mute control support to the driver.
>
>Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
>---
>Changelog:
>v1->v2
> * Revise the DT binding part regarding the active state of the mute pin
>
> .../devicetree/bindings/sound/cs53l30.txt          |  4 +++
> sound/soc/codecs/cs53l30.c                         | 30
>++++++++++++++++++++++
> sound/soc/codecs/cs53l30.h                         |  1 +
> 3 files changed, 35 insertions(+)
>
>diff --git a/Documentation/devicetree/bindings/sound/cs53l30.txt
>b/Documentation/devicetree/bindings/sound/cs53l30.txt
>index 18d6b99..4dbfb82 100644
>--- a/Documentation/devicetree/bindings/sound/cs53l30.txt
>+++ b/Documentation/devicetree/bindings/sound/cs53l30.txt
>@@ -13,6 +13,10 @@ Optional properties:
> 
>   - reset-gpios : a GPIO spec for the reset pin.
> 
>+  - mute-gpios : a GPIO spec for the MUTE pin. The active state can be
>either
>+		 GPIO_ACTIVE_HIGH or GPIO_ACTIVE_LOW, which would be handled
>+		 by the driver automatically.
>+
>   - cirrus,micbias-lvl : Set the output voltage level on the MICBIAS Pin.
> 			 0 = Hi-Z
> 			 1 = 1.80 V
>diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
>index 384a3f7..e46b7de 100644
>--- a/sound/soc/codecs/cs53l30.c
>+++ b/sound/soc/codecs/cs53l30.c
>@@ -35,6 +35,7 @@ struct cs53l30_private {
> 	struct regulator_bulk_data	supplies[CS53L30_NUM_SUPPLIES];
> 	struct regmap			*regmap;
> 	struct gpio_desc		*reset_gpio;
>+	struct gpio_desc		*mute_gpio;
> 	struct clk			*mclk;
> 	bool				use_sdout2;
> 	u32				mclk_rate;
>@@ -833,6 +834,16 @@ static int cs53l30_set_dai_tdm_slot(struct
>snd_soc_dai *dai,
> 	return 0;
> }
> 
>+static int cs53l30_mute_stream(struct snd_soc_dai *dai, int mute, int
>stream)
>+{
>+	struct cs53l30_private *priv = snd_soc_codec_get_drvdata(dai->codec);
>+
>+	if (priv->mute_gpio)
>+		gpiod_set_value_cansleep(priv->mute_gpio, mute);
>+
>+	return 0;
>+}
>+
> /* SNDRV_PCM_RATE_KNOT -> 12000, 24000 Hz, limit with constraint list */
> #define CS53L30_RATES (SNDRV_PCM_RATE_8000_48000 | SNDRV_PCM_RATE_KNOT)
> 
>@@ -846,6 +857,7 @@ static const struct snd_soc_dai_ops cs53l30_ops = {
> 	.set_sysclk = cs53l30_set_sysclk,
> 	.set_tristate = cs53l30_set_tristate,
> 	.set_tdm_slot = cs53l30_set_dai_tdm_slot,
>+	.mute_stream = cs53l30_mute_stream,
> };
> 
> static struct snd_soc_dai_driver cs53l30_dai = {
>@@ -990,6 +1002,24 @@ static int cs53l30_i2c_probe(struct i2c_client
>*client,
> 		cs53l30->mclk = NULL;
> 	}
> 
>+	/* Fetch the MUTE control */
>+	cs53l30->mute_gpio = devm_gpiod_get_optional(dev, "mute",
>+						     GPIOD_OUT_HIGH);
>+	if (IS_ERR(cs53l30->mute_gpio)) {
>+		ret = PTR_ERR(cs53l30->mute_gpio);
>+		goto error;
>+	}
>+
>+	if (cs53l30->mute_gpio) {
>+		/* Enable MUTE controls via MUTE pin */
>+		regmap_write(cs53l30->regmap, CS53L30_MUTEP_CTL1,
>+			     CS53L30_MUTEP_CTL1_MUTEALL);
>+		/* Flip the polarity of MUTE pin */
>+		if (gpiod_is_active_low(cs53l30->mute_gpio))
>+			regmap_update_bits(cs53l30->regmap, CS53L30_MUTEP_CTL2,
>+					   CS53L30_MUTE_PIN_POLARITY, 0);
>+	}
>+
> 	if (!of_property_read_u8(np, "cirrus,micbias-lvl", &val))
> 		regmap_update_bits(cs53l30->regmap, CS53L30_MICBIAS_CTL,
> 				   CS53L30_MIC_BIAS_CTRL_MASK, val);
>diff --git a/sound/soc/codecs/cs53l30.h b/sound/soc/codecs/cs53l30.h
>index 0dd4afb..5e39da5 100644
>--- a/sound/soc/codecs/cs53l30.h
>+++ b/sound/soc/codecs/cs53l30.h
>@@ -253,6 +253,7 @@
> #define CS53L30_MUTE_MB_ALL_PDN_MASK	(1 << CS53L30_MUTE_MB_ALL_PDN_SHIFT)
> #define CS53L30_MUTE_MB_ALL_PDN		(1 << CS53L30_MUTE_MB_ALL_PDN_SHIFT)
> 
>+#define CS53L30_MUTEP_CTL1_MUTEALL	(0xdf)
> #define CS53L30_MUTEP_CTL1_DEFAULT	(0)
> 
> /* R32 (0x20) CS53L30_MUTEP_CTL2 - MUTE Pin Control 2 */
>-- 
>2.1.4
Thanks!

Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
>
