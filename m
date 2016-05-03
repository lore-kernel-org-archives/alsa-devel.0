From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 6/7] ARM: DTS: da850: Add McBSP0 and McBSP1
Date: Tue, 3 May 2016 18:54:09 +0530
Message-ID: <5728A679.7050304@ti.com>
References: <1461327617-11435-1-git-send-email-petr@barix.com>
 <1461327617-11435-7-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461327617-11435-7-git-send-email-petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Friday 22 April 2016 05:50 PM, Petr Kulhavy wrote:
> Add SoC nodes for McBSP0 and McBSP1 as well as the corresponding pinmux
> configurations.
> 
> Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
> ---
> v1: initial
> v2: add missing TC channel in dmas properties (for compatibility with the new EDMA3 binding)
>     remove "-audio" postfix from the compatible string
> v3: no change
> v4: no change
> 
>  arch/arm/boot/dts/da850.dtsi | 45 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 5996e765e59c..708d48e1b6d1 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -148,7 +148,24 @@
>  					0xc 0x88888888 0xffffffff
>  				>;
>  			};
> -
> +			mcbsp0_pins: pinmux_mcbsp0_pins {
> +				pinctrl-single,bits = <
> +					/* PINMUX2:
> +					* CLKS0, DX0, DR0, FSX0
> +					* FSR0, CLKX0, CLKR0
> +					*/
> +					0x8 0x02222220 0xfffffff0
> +				>;
> +			};
> +			mcbsp1_pins: pinmux_mcbsp1_pins {
> +				pinctrl-single,bits = <
> +					/* PINMUX1:
> +					* CLKS1, DX1, DR1, FSX1,
> +					* FSR1, CLKX1, CLKR1
> +					*/
> +					0x4 0x22222220 0xfffffff0
> +				>;
> +			};
>  		};
>  		edma0: edma@01c00000 {
>  			compatible = "ti,edma3-tpcc";
> @@ -335,6 +352,32 @@
>  				<&edma0 0 1>;
>  			dma-names = "tx", "rx";
>  		};
> +
> +		mcbsp0: mcbsp@1d10000 {
> +			compatible = "ti,da850-mcbsp";
> +			reg =	<0x00110000 0x1000>,
> +				<0x00310000 0x1000>;

The node name should be sound@110000

sound because use of generic names is preferred (I know the mcasp has
got this wrong). And the unit address after the @ should match the reg
property. I would also lose the unnecessary 0s in the reg address.

Thanks,
Sekhar

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
