From: Boris BREZILLON <b.brezillon.dev@gmail.com>
Subject: Re: [RFC v2 PATCH] ASoC: wm8904: add CCF support
Date: Tue, 25 Mar 2014 12:59:21 +0100
Message-ID: <53316F99.6080709@gmail.com>
References: <1395741416-23981-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <1395741416-23981-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>, Mark Brown <broonie@kernel.org>
Cc: nicolas.ferre@atmel.com, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Bo,

Le 25/03/2014 10:56, Bo Shen a =E9crit :
> Enable WM8904 to support common clock framework.
>    - Now it supports use SoC provided clock or external oscillator
>      as MCLK.
>
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---
>   Documentation/devicetree/bindings/sound/wm8904.txt | 48 +++++++++++=
+++++++++++
>   sound/soc/codecs/wm8904.c                          | 17 ++++++++
>   2 files changed, 65 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/wm8904.t=
xt
>
> diff --git a/Documentation/devicetree/bindings/sound/wm8904.txt b/Doc=
umentation/devicetree/bindings/sound/wm8904.txt
> new file mode 100644
> index 0000000..bcf4aa0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/wm8904.txt
> @@ -0,0 +1,48 @@
> +WM8904 audio CODEC
> +
> +This device supports I2C only.
> +
> +Required properties:
> +  - compatible: "wlf,wm8904"
> +  - reg: the I2C address of the device.
> +  - clocks and clock-names: reference to
> +    <Documentation/devicetree/bindings/clock/clock-bindings.txt>
> +
> +Pins on the device (for linking into audio routes):
> +
> +  * IN1L
> +  * IN1R
> +  * IN2L
> +  * IN2R
> +  * IN3L
> +  * IN3R
> +  * HPOUTL
> +  * HPOUTR
> +  * LINEOUTL
> +  * LINEOUTR
> +  * MICBIAS
> +
> +Examples:
> +
> +1. Using SoC provided clock as mclk:
> +codec: wm8904@1a {
> +	compatible =3D "wlf,wm8904";
> +	reg =3D <0x1a>;
> +	clocks =3D <&pck0>;
> +	clock-names =3D "mclk";
> +};


> +
> +2. Using external oscillator as mclk:
> +codec: wm8904@1a {
> +	compatible =3D "wlf,wm8904";
> +	reg =3D <0x1a>;
> +
> +	wm8904_osc {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		#clock-frequency =3D <12000000>;
> +	}
> +
> +	clocks =3D <&wm8904_osc>;
> +	clock-names =3D "mclk";
> +};

I think there is a misunderstanding here (and it certainly comes from m=
y
explanations during our last talk :)): both cases should be handled the=
 same
way because an external oscillator is no more or less than an external =
clk
(we don't care how this clk is generated).

I suggested to put the osc node inside the wm8904 one but I thought you=
 were
trying to represent the internal 12MHz clk generated when using the fll=
 free
running mode.

> diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
> index 49c35c3..4db6a26 100644
> --- a/sound/soc/codecs/wm8904.c
> +++ b/sound/soc/codecs/wm8904.c
> @@ -11,6 +11,7 @@
>    * published by the Free Software Foundation.
>    */
>  =20
> +#include <linux/clk.h>
>   #include <linux/module.h>
>   #include <linux/moduleparam.h>
>   #include <linux/init.h>
> @@ -49,6 +50,7 @@ static const char *wm8904_supply_names[WM8904_NUM_S=
UPPLIES] =3D {
>   /* codec private data */
>   struct wm8904_priv {
>   	struct regmap *regmap;
> +	struct clk *mclk;
>  =20
>   	enum wm8904_type devtype;
>  =20
> @@ -1828,6 +1830,9 @@ static int wm8904_set_bias_level(struct snd_soc=
_codec *codec,
>  =20
>   	switch (level) {
>   	case SND_SOC_BIAS_ON:
> +		if (IS_ENABLED(CONFIG_COMMON_CLK))
> +			if (wm8904->mclk)
> +				clk_prepare_enable(wm8904->mclk);
>   		break;
>  =20
>   	case SND_SOC_BIAS_PREPARE:
> @@ -1894,6 +1899,9 @@ static int wm8904_set_bias_level(struct snd_soc=
_codec *codec,
>  =20
>   		regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies),
>   				       wm8904->supplies);
> +		if (IS_ENABLED(CONFIG_COMMON_CLK))
> +			if (wm8904->mclk)
> +				clk_disable_unprepare(wm8904->mclk);
>   		break;
>   	}
>   	codec->dapm.bias_level =3D level;
> @@ -2139,6 +2147,15 @@ static int wm8904_i2c_probe(struct i2c_client =
*i2c,
>   		return ret;
>   	}
>  =20
> +	if (IS_ENABLED(CONFIG_COMMON_CLK)) {
> +		wm8904->mclk =3D devm_clk_get(&i2c->dev, "mclk");
> +		if (IS_ERR(wm8904->mclk)) {
> +			dev_err(&i2c->dev, "Failed to get MCLK\n");
> +			ret =3D PTR_ERR(wm8904->mclk);
> +			goto err_enable;
> +		}
> +	}
> +
>   	ret =3D regmap_read(wm8904->regmap, WM8904_SW_RESET_AND_ID, &val);
>   	if (ret < 0) {
>   		dev_err(&i2c->dev, "Failed to read ID register: %d\n", ret);

--
To unsubscribe from this list: send the line "unsubscribe linux-sound" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
