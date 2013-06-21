From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/3] ASoC: codecs: adau1701: allow
 configuration of PLL mode pins
Date: Fri, 21 Jun 2013 09:23:44 +0200
Message-ID: <51C3FF80.1020300@metafoo.de>
References: <1371749397-32238-1-git-send-email-zonque@gmail.com>
 <1371749397-32238-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-182.synserver.de (smtp-out-182.synserver.de
 [212.40.185.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DC1C2654C7
 for <alsa-devel@alsa-project.org>; Fri, 21 Jun 2013 09:23:31 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 06/20/2013 07:29 PM, Daniel Mack wrote:
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
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  .../devicetree/bindings/sound/adi,adau1701.txt     |  14 +++
>  sound/soc/codecs/adau1701.c                        | 107 +++++++++++++++++----
>  sound/soc/codecs/adau1701.h                        |   4 +
>  3 files changed, 104 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/adi,adau1701.txt b/Documentation/devicetree/bindings/sound/adi,adau1701.txt
> index 3afeda7..a0d7e92 100644
> --- a/Documentation/devicetree/bindings/sound/adi,adau1701.txt
> +++ b/Documentation/devicetree/bindings/sound/adi,adau1701.txt
> @@ -11,6 +11,19 @@ Optional properties:
>   - reset-gpio: 		A GPIO spec to define which pin is connected to the
>  			chip's !RESET pin. If specified, the driver will
>  			assert a hardware reset at probe time.
> + - adi,pll-clkdiv: 	The PLL clock divider, specifing the ratio between
> +			MCLK and fsclk. The value is used to determine the
> +			correct state of the two mode pins below.
> +			Note that this value can be overridden at runtime
> +			by passing the ADAU1701_CLKDIV_MCLK_LRCLK divider
> +			with ASoC calls. However, the chips needs a full
> +			reset cycle and a new firmware download each time
> +			the configuration changes.

Considering that this is now done all automatically at runtime, do we
actually still need this property?

> + - adi,pll-mode-gpios:	An array of two GPIO specs to describe the GPIOs
> +			the ADAU's PLL config pins are connected to.
> +			The state of the pins are set according to the
> +			configured clock divider on ASoC side before the
> +			firmware is loaded.
>  
>  Examples:
>  
> @@ -19,5 +32,6 @@ Examples:
>  			compatible = "adi,adau1701";
>  			reg = <0x34>;
>  			reset-gpio = <&gpio 23 0>;
> +			adi,pll-mode-gpios = <&gpio 24 0 &gpio 25 0>;
>  		};
>  	};
> diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
> index b6b1a77..e6ce4fe 100644
> --- a/sound/soc/codecs/adau1701.c
> +++ b/sound/soc/codecs/adau1701.c
> @@ -91,7 +91,11 @@
>  
>  struct adau1701 {
>  	int gpio_nreset;
> +	int gpio_pll_mode0;
> +	int gpio_pll_mode1;

I would have made this an array, but I guess either solution is fine.

>  	unsigned int dai_fmt;
> +	unsigned int pll_clkdiv;
> +	unsigned int sysclk;
>  };
>  
>  static const struct snd_kcontrol_new adau1701_controls[] = {
> @@ -184,13 +188,37 @@ static unsigned int adau1701_read(struct snd_soc_codec *codec, unsigned int reg)
>  	return value;
>  }
>  
> -static void adau1701_reset(struct snd_soc_codec *codec)
> +static void adau1701_reset(struct snd_soc_codec *codec, unsigned int clkdiv)
>  {
>  	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
>  
>  	if (!gpio_is_valid(adau1701->gpio_nreset))
>  		return;
>  
> +	if (gpio_is_valid(adau1701->gpio_pll_mode0) &&
> +	    gpio_is_valid(adau1701->gpio_pll_mode1)) {
> +		switch (adau1701->pll_clkdiv) {

Considering that adau1701->pll_clkdiv is only assigned below this should
either be clkdiv, or the assigment should be moved up.

> +		case 64:
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
>  	gpio_set_value(adau1701->gpio_nreset, 0);
>  	/* minimum reset time is 20ns */
>  	udelay(1);
> @@ -199,24 +227,6 @@ static void adau1701_reset(struct snd_soc_codec *codec)
>  	mdelay(85);
}
[...]
> diff --git a/sound/soc/codecs/adau1701.h b/sound/soc/codecs/adau1701.h
> index 8d0949a..bdcdddc 100644
> --- a/sound/soc/codecs/adau1701.h
> +++ b/sound/soc/codecs/adau1701.h
> @@ -14,4 +14,8 @@ enum adau1701_clk_src {
>  	ADAU1701_CLK_SRC_MCLK,
>  };
>  
> +enum adau1701_clkdiv {
> +	ADAU1701_CLKDIV_MCLK_LRCLK,
> +};
> +

This is unused now.

>  #endif
