From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 2/2] ARM: dts: Append clock bindings for sai2 on VF610
 platform
Date: Wed, 9 Apr 2014 16:11:38 +0800
Message-ID: <20140409081137.GD28420@dragon>
References: <cover.1396605772.git.Guangyu.Chen@freescale.com>
 <08ba57a2fdce1a404a6bcb61e21e25509fcd6b30.1396605772.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <08ba57a2fdce1a404a6bcb61e21e25509fcd6b30.1396605772.git.Guangyu.Chen@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org, Li.Xiubo@freescale.com, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, rob@landley.net, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 04, 2014 at 06:08:13PM +0800, Nicolin Chen wrote:
> Since we added fours clock to the DT binding, we should update the current
> SAI dts/dtsi so as not to break their functions.

For the record, you're asking my ACK to have the dts change go via sound
tree for not breaking vf610 function on the sound branch,  while
ignoring the fact that the existing DTB will break with the new kernel
anyway.

I'm not completely happy with the approach, but considering that the
existing binding is incorrect, I'm fine with it as long as people agree
to go this way.

Shawn

> 
> Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
> Tested-by: Xiubo Li <Li.Xiubo@freescale.com>
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
> +				clock-names = "bus", "mclk1", "mclk2", "mclk3";
>  				status = "disabled";
>  			};
>  
> -- 
> 1.8.4
> 
> 

