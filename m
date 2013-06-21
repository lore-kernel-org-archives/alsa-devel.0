From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 1/3] ASoC: codecs: adau1701: allow
 configuration of PLL mode pins
Date: Fri, 21 Jun 2013 10:16:39 +0530
Message-ID: <51C3DAAF.9060007@st.com>
References: <1371749397-32238-1-git-send-email-zonque@gmail.com>
 <1371749397-32238-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog103.obsmtp.com (eu1sys200aog103.obsmtp.com
 [207.126.144.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AEEB26546E
 for <alsa-devel@alsa-project.org>; Fri, 21 Jun 2013 06:46:54 +0200 (CEST)
In-Reply-To: <1371749397-32238-2-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Daniel,

On 6/20/2013 10:59 PM, Daniel Mack wrote:
> The ADAU1701 has 2 hardware pins to configure the PLL mode in accordance
> to the MCLK-to-LRCLK ratio. These pins have to be stable before the chip
> is released from reset, and a full reset cycle, including a new firmware
> download is needed whenever they change.
>
> This patch adds GPIO properties to the DT bindings of the Codec, and
> implements makes the set_sysclk memorize the configured sysclk.
>
> To avoid excessive reset cycles and firmware downloads, the default
> clock divider can be specified in DT as well. Whenever a ratio change is
> detected in the hw_params callback, the PLL mode lines are updates and a
> full reset cycle is issued.
>
> Signed-off-by: Daniel Mack<zonque@gmail.com>
> ---
>   .../devicetree/bindings/sound/adi,adau1701.txt     |  14 +++
>   sound/soc/codecs/adau1701.c                        | 107 +++++++++++++++++----
>   sound/soc/codecs/adau1701.h                        |   4 +
>   3 files changed, 104 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/adi,adau1701.txt b/Documentation/devicetree/bindings/sound/adi,adau1701.txt
> index 3afeda7..a0d7e92 100644
> --- a/Documentation/devicetree/bindings/sound/adi,adau1701.txt
> +++ b/Documentation/devicetree/bindings/sound/adi,adau1701.txt
> @@ -11,6 +11,19 @@ Optional properties:
>    - reset-gpio: 		A GPIO spec to define which pin is connected to the
>   			chip's !RESET pin. If specified, the driver will
>   			assert a hardware reset at probe time.
> + - adi,pll-clkdiv: 	The PLL clock divider, specifing the ratio between
> +			MCLK and fsclk. The value is used to determine the
> +			correct state of the two mode pins below.
> +			Note that this value can be overridden at runtime
> +			by passing the ADAU1701_CLKDIV_MCLK_LRCLK divider
> +			with ASoC calls. However, the chips needs a full
> +			reset cycle and a new firmware download each time
> +			the configuration changes.
> + - adi,pll-mode-gpios:	An array of two GPIO specs to describe the GPIOs
> +			the ADAU's PLL config pins are connected to.
> +			The state of the pins are set according to the
> +			configured clock divider on ASoC side before the
> +			firmware is loaded.
>
>   Examples:
>
> @@ -19,5 +32,6 @@ Examples:
>   			compatible = "adi,adau1701";
>   			reg =<0x34>;
>   			reset-gpio =<&gpio 23 0>;
> +			adi,pll-mode-gpios =<&gpio 24 0&gpio 25 0>;
>   		};
>   	};
> diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
> index b6b1a77..e6ce4fe 100644
> --- a/sound/soc/codecs/adau1701.c
> +++ b/sound/soc/codecs/adau1701.c
> @@ -91,7 +91,11 @@
>
>   struct adau1701 {
>   	int gpio_nreset;
> +	int gpio_pll_mode0;
> +	int gpio_pll_mode1;

combine in single line.

>   	unsigned int dai_fmt;
> +	unsigned int pll_clkdiv;
> +	unsigned int sysclk;
>   };
>
>   static const struct snd_kcontrol_new adau1701_controls[] = {
> @@ -184,13 +188,37 @@ static unsigned int adau1701_read(struct snd_soc_codec *codec, unsigned int reg)
>   	return value;
>   }
>
> -static void adau1701_reset(struct snd_soc_codec *codec)
> +static void adau1701_reset(struct snd_soc_codec *codec, unsigned int clkdiv)
>   {
>   	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
>
>   	if (!gpio_is_valid(adau1701->gpio_nreset))
>   		return;
>
> +	if (gpio_is_valid(adau1701->gpio_pll_mode0)&&
> +	    gpio_is_valid(adau1701->gpio_pll_mode1)) {
> +		switch (adau1701->pll_clkdiv) {
> +		case 64:

magic number?

> +			gpio_set_value(adau1701->gpio_pll_mode0, 0);
> +			gpio_set_value(adau1701->gpio_pll_mode1, 0);
> +			break;
> +		case 256:
> +			gpio_set_value(adau1701->gpio_pll_mode0, 0);
> +			gpio_set_value(adau1701->gpio_pll_mode1, 1);
> +			break;
> +		case 384:
> +			gpio_set_value(adau1701->gpio_pll_mode0, 1);
> +			gpio_set_value(adau1701->gpio_pll_mode1, 0);
> +			break;
> +		case 512:
> +			gpio_set_value(adau1701->gpio_pll_mode0, 1);
> +			gpio_set_value(adau1701->gpio_pll_mode1, 1);
> +			break;
> +		}
> +	}
> +
> +	adau1701->pll_clkdiv = clkdiv;
> +
>   	gpio_set_value(adau1701->gpio_nreset, 0);
>   	/* minimum reset time is 20ns */
>   	udelay(1);
> @@ -199,24 +227,6 @@ static void adau1701_reset(struct snd_soc_codec *codec)
>   	mdelay(85);
>   }
>
> -static int adau1701_init(struct snd_soc_codec *codec)
> -{
> -	int ret;
> -	struct i2c_client *client = to_i2c_client(codec->dev);
> -
> -	adau1701_reset(codec);
> -
> -	ret = process_sigma_firmware(client, ADAU1701_FIRMWARE);
> -	if (ret) {
> -		dev_warn(codec->dev, "Failed to load firmware\n");
> -		return ret;
> -	}
> -
> -	snd_soc_write(codec, ADAU1701_DACSET, ADAU1701_DACSET_DACINIT);
> -
> -	return 0;
> -}
> -
>   static int adau1701_set_capture_pcm_format(struct snd_soc_codec *codec,
>   		snd_pcm_format_t format)
>   {
> @@ -291,9 +301,22 @@ static int adau1701_hw_params(struct snd_pcm_substream *substream,
>   		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
>   {
>   	struct snd_soc_codec *codec = dai->codec;
> +	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
>   	snd_pcm_format_t format;
>   	unsigned int val;
>
> +	if (adau1701->sysclk) {
> +		unsigned int clkdiv = adau1701->sysclk / params_rate(params);

It will give warning.

Best Regards
Rajeev

> +
> +		/*
> +		 * If the mclk/lrclk ratio changes, the chip needs updated PLL
> +		 * mode GPIO settings, and a full reset cycle, including a new
> +		 * firmware upload.
> +		 */
> +		if (clkdiv != adau1701->pll_clkdiv)
> +			adau1701_reset(codec, clkdiv);
> +	}
> +
>   	switch (params_rate(params)) {
>   	case 192000:
>   		val = ADAU1701_DSPCTRL_SR_192;
> @@ -435,6 +458,7 @@ static int adau1701_set_sysclk(struct snd_soc_codec *codec, int clk_id,
>   	int source, unsigned int freq, int dir)
>   {
>   	unsigned int val;
> +	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
>
>   	switch (clk_id) {
>   	case ADAU1701_CLK_SRC_OSC:
> @@ -448,6 +472,7 @@ static int adau1701_set_sysclk(struct snd_soc_codec *codec, int clk_id,
>   	}
>
>   	snd_soc_update_bits(codec, ADAU1701_OSCIPOW, ADAU1701_OSCIPOW_OPD, val);
> +	adau1701->sysclk = freq;
>
>   	return 0;
>   }
> @@ -495,13 +520,21 @@ MODULE_DEVICE_TABLE(of, adau1701_dt_ids);
>   static int adau1701_probe(struct snd_soc_codec *codec)
>   {
>   	int ret;
> +	struct i2c_client *client = to_i2c_client(codec->dev);
> +	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
>
>   	codec->control_data = to_i2c_client(codec->dev);
>
> -	ret = adau1701_init(codec);
> -	if (ret)
> +	/* initalize with pre-configured pll mode settings */
> +	adau1701_reset(codec, adau1701->pll_clkdiv);
> +
> +	ret = process_sigma_firmware(client, ADAU1701_FIRMWARE);
> +	if (ret) {
> +		dev_warn(codec->dev, "Failed to load firmware\n");
>   		return ret;
> +	}
>
> +	snd_soc_write(codec, ADAU1701_DACSET, ADAU1701_DACSET_DACINIT);
>   	snd_soc_write(codec, ADAU1701_DSPCTRL, ADAU1701_DSPCTRL_CR);
>
>   	return 0;
> @@ -534,6 +567,8 @@ static int adau1701_i2c_probe(struct i2c_client *client,
>   	struct adau1701 *adau1701;
>   	struct device *dev =&client->dev;
>   	int gpio_nreset = -EINVAL;
> +	int gpio_pll_mode0 = -EINVAL;
> +	int gpio_pll_mode1 = -EINVAL;
>   	int ret;
>
>   	adau1701 = devm_kzalloc(dev, sizeof(*adau1701), GFP_KERNEL);
> @@ -544,6 +579,19 @@ static int adau1701_i2c_probe(struct i2c_client *client,
>   		gpio_nreset = of_get_named_gpio(dev->of_node, "reset-gpio", 0);
>   		if (gpio_nreset<  0&&  gpio_nreset != -ENOENT)
>   			return gpio_nreset;
> +
> +		gpio_pll_mode0 = of_get_named_gpio(dev->of_node,
> +						   "adi,pll-mode-gpios", 0);
> +		if (gpio_pll_mode0<  0&&  gpio_pll_mode0 != -ENOENT)
> +			return gpio_pll_mode0;
> +
> +		gpio_pll_mode1 = of_get_named_gpio(dev->of_node,
> +						   "adi,pll-mode-gpios", 1);
> +		if (gpio_pll_mode1<  0&&  gpio_pll_mode1 != -ENOENT)
> +			return gpio_pll_mode1;
> +
> +		of_property_read_u32(dev->of_node, "adi,pll-clkdiv",
> +				&adau1701->pll_clkdiv);
>   	}
>
>   	if (gpio_is_valid(gpio_nreset)) {
> @@ -553,7 +601,24 @@ static int adau1701_i2c_probe(struct i2c_client *client,
>   			return ret;
>   	}
>
> +	if (gpio_is_valid(gpio_pll_mode0)&&
> +	    gpio_is_valid(gpio_pll_mode1)) {
> +		ret = devm_gpio_request_one(dev, gpio_pll_mode0,
> +					    GPIOF_OUT_INIT_LOW,
> +					    "ADAU1701 PLL mode 0");
> +		if (ret<  0)
> +			return ret;
> +
> +		ret = devm_gpio_request_one(dev, gpio_pll_mode1,
> +					    GPIOF_OUT_INIT_LOW,
> +					    "ADAU1701 PLL mode 1");
> +		if (ret<  0)
> +			return ret;
> +	}
> +
>   	adau1701->gpio_nreset = gpio_nreset;
> +	adau1701->gpio_pll_mode0 = gpio_pll_mode0;
> +	adau1701->gpio_pll_mode1 = gpio_pll_mode1;
>
>   	i2c_set_clientdata(client, adau1701);
>   	ret = snd_soc_register_codec(&client->dev,&adau1701_codec_drv,
> diff --git a/sound/soc/codecs/adau1701.h b/sound/soc/codecs/adau1701.h
> index 8d0949a..bdcdddc 100644
> --- a/sound/soc/codecs/adau1701.h
> +++ b/sound/soc/codecs/adau1701.h
> @@ -14,4 +14,8 @@ enum adau1701_clk_src {
>   	ADAU1701_CLK_SRC_MCLK,
>   };
>
> +enum adau1701_clkdiv {
> +	ADAU1701_CLKDIV_MCLK_LRCLK,
> +};
> +
>   #endif
