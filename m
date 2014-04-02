From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 2/2] ARM: dts: Append clock bindings for sai2 on VF610
 platform
Date: Wed, 2 Apr 2014 21:03:04 +0800
Message-ID: <20140402130302.GC8558@dragon>
References: <cover.1396432924.git.Guangyu.Chen@freescale.com>
 <d09da3eb629143abd3f61ae037af4ddaf7286a83.1396432924.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d09da3eb629143abd3f61ae037af4ddaf7286a83.1396432924.git.Guangyu.Chen@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org, Li.Xiubo@freescale.com, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, rob@landley.net, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 02, 2014 at 06:10:20PM +0800, Nicolin Chen wrote:
> Since we added fours clock to the DT binding, we should update the current
> SAI dts/dtsi so as not to break their functions.
> 
> Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
> ---
>  arch/arm/boot/dts/vf610.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
> index d31ce1b..9fd0007 100644
> --- a/arch/arm/boot/dts/vf610.dtsi
> +++ b/arch/arm/boot/dts/vf610.dtsi
> @@ -139,8 +139,10 @@
>  				compatible = "fsl,vf610-sai";
>  				reg = <0x40031000 0x1000>;
>  				interrupts = <0 86 0x04>;
> -				clocks = <&clks VF610_CLK_SAI2>;
> -				clock-names = "sai";
> +				clocks = <&clks VF610_CLK_SAI2>,
> +				       <&clks VF610_CLK_SAI2>,
> +				       <&clks 0>, <&clks 0>;

So it seems that SAI on vf610 does work with only one clock.  So the
driver change will break old DTB for vf610?  If that's case, we will
have to need a new compatible for cases where 4 clocks are needed.

Shawn

> +				clock-names = "bus", "mclk1", "mclk2", "mclk3";
>  				status = "disabled";
>  			};
>  
> -- 
> 1.8.4
> 
> 

