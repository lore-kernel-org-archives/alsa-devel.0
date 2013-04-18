From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [RFC 2/4] ASoC: imx-sgtl5000: Let the code clock
 be a mandatory binding
Date: Thu, 18 Apr 2013 11:36:17 +0800
Message-ID: <20130418033616.GD20563@S2101-09.ap.freescale.net>
References: <1366242921-16376-1-git-send-email-festevam@gmail.com>
 <1366242921-16376-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 98B48265DD4
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 05:36:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1366242921-16376-2-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, matt@genesi-usa.com, mfuzzey@gmail.com, broonie@kernel.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 17, 2013 at 08:55:19PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Currently passing a codec clock is optional.
> 
> Make the codec clock to be a required binding in order to simplify codec clock 
> handling in imx-sgtl5000.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Mark/Shawn/Sascha,
> 
> I am marking this one as RFC because I don't have mx51babbage nor mx53qsb handy
> to test it.

It works on imx53-qsb but doe not on imx5q-babbage.  That clk_26M is not
registered to clock framework as a clk provider.

Shawn

> 
> Will test on these platforms when I have a chance, but just wanted to share
> it now and maybe get some feedback first.
> 
>  arch/arm/boot/dts/imx51-babbage.dts |   13 ++++++++++++-
>  arch/arm/boot/dts/imx53-qsb.dts     |    1 +
>  arch/arm/mach-imx/mach-imx53.c      |   16 ----------------
>  sound/soc/fsl/imx-sgtl5000.c        |   18 ++++++------------
>  4 files changed, 19 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
> index 6dd9486..5318d26 100644
> --- a/arch/arm/boot/dts/imx51-babbage.dts
> +++ b/arch/arm/boot/dts/imx51-babbage.dts
> @@ -61,6 +61,16 @@
>  		mux-int-port = <2>;
>  		mux-ext-port = <3>;
>  	};
> +
> +	clocks {
> +		clk_26M: clock {
> +			compatible = "fixed-clock";
> +			reg=<0>;
> +			#clock-cells = <0>;
> +			clock-frequency = <26000000>;
> +			gpios = <&gpio4 26 1>;
> +		};
> +	};
>  };
>  
>  &esdhc1 {
> @@ -229,6 +239,7 @@
>  				MX51_PAD_EIM_A27__GPIO2_21   0x5
>  				MX51_PAD_CSPI1_SS0__GPIO4_24 0x85
>  				MX51_PAD_CSPI1_SS1__GPIO4_25 0x85
> +				MX51_PAD_CSPI1_RDY__GPIO4_26 0x80000000
>  			>;
>  		};
>  	};
> @@ -255,7 +266,7 @@
>  	sgtl5000: codec@0a {
>  		compatible = "fsl,sgtl5000";
>  		reg = <0x0a>;
> -		clock-frequency = <26000000>;
> +		clocks = <&clk_26M>;
>  		VDDA-supply = <&vdig_reg>;
>  		VDDIO-supply = <&vvideo_reg>;
>  	};
> diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
> index 160d1bc..27e56e0 100644
> --- a/arch/arm/boot/dts/imx53-qsb.dts
> +++ b/arch/arm/boot/dts/imx53-qsb.dts
> @@ -145,6 +145,7 @@
>  	sgtl5000: codec@0a {
>  		compatible = "fsl,sgtl5000";
>  		reg = <0x0a>;
> +		clocks = <&clks 150>;
>  		VDDA-supply = <&reg_3p2v>;
>  		VDDIO-supply = <&reg_3p2v>;
>  	};
> diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
> index f579c61..8d47571 100644
> --- a/arch/arm/mach-imx/mach-imx53.c
> +++ b/arch/arm/mach-imx/mach-imx53.c
> @@ -23,24 +23,8 @@
>  #include "common.h"
>  #include "mx53.h"
>  
> -static void __init imx53_qsb_init(void)
> -{
> -	struct clk *clk;
> -
> -	clk = clk_get_sys(NULL, "ssi_ext1");
> -	if (IS_ERR(clk)) {
> -		pr_err("failed to get clk ssi_ext1\n");
> -		return;
> -	}
> -
> -	clk_register_clkdev(clk, NULL, "0-000a");
> -}
> -
>  static void __init imx53_dt_init(void)
>  {
> -	if (of_machine_is_compatible("fsl,imx53-qsb"))
> -		imx53_qsb_init();
> -
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  }
>  
> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index 88fc02c..9c286e6 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -130,20 +130,14 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  
>  	data->codec_clk = clk_get(&codec_dev->dev, NULL);
>  	if (IS_ERR(data->codec_clk)) {
> -		/* assuming clock enabled by default */
> -		data->codec_clk = NULL;
> -		ret = of_property_read_u32(codec_np, "clock-frequency",
> -					&data->clk_frequency);
> -		if (ret) {
> -			dev_err(&codec_dev->dev,
> -				"clock-frequency missing or invalid\n");
> -			goto fail;
> -		}
> -	} else {
> -		data->clk_frequency = clk_get_rate(data->codec_clk);
> -		clk_prepare_enable(data->codec_clk);
> +		ret = PTR_ERR(data->codec_clk);
> +		dev_err(&codec_dev->dev, "could not get codec clk: %d\n", ret);
> +		goto fail;
>  	}
>  
> +	data->clk_frequency = clk_get_rate(data->codec_clk);
> +	clk_prepare_enable(data->codec_clk);
> +
>  	data->dai.name = "HiFi";
>  	data->dai.stream_name = "HiFi";
>  	data->dai.codec_dai_name = "sgtl5000";
> -- 
> 1.7.9.5
> 
