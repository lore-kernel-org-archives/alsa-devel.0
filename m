From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v4 7/9] ASoC: atmel-classd: remove aclk
 clock from DT binding
Date: Tue, 25 Jul 2017 17:38:19 +0200
Message-ID: <d78d2769-5e05-b1e7-dec8-9b2c86ee3459@microchip.com>
References: <cover.c8ce78c15296190b2aa5c452c0c4512528e28518.1500968090.git-series.quentin.schulz@free-electrons.com>
 <db5404c2be1d59603dd3770c5f95a065fe4c321f.1500968090.git-series.quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from esa6.microchip.iphmx.com (esa6.microchip.iphmx.com
 [216.71.154.253])
 by alsa0.perex.cz (Postfix) with ESMTP id CC27A267251
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 17:37:39 +0200 (CEST)
In-Reply-To: <db5404c2be1d59603dd3770c5f95a065fe4c321f.1500968090.git-series.quentin.schulz@free-electrons.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>, mturquette@baylibre.com, sboyd@codeaurora.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, alexandre.belloni@free-electrons.com, linux@armlinux.org.uk, boris.brezillon@free-electrons.com, perex@perex.cz, tiwai@suse.com
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, cyrille.pitchen@wedev4u.fr, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 25/07/2017 at 09:37, Quentin Schulz wrote:
> Since gclk (generated-clk) is now able to determine the rate of the
> audio_pll, there is no need for classd to have a direct phandle to the
> audio_pll while already having a phandle to gclk.
> 
> This binding is used by no board in mainline so it is safe to be
> modified.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>  Documentation/devicetree/bindings/sound/atmel-classd.txt |  9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/atmel-classd.txt b/Documentation/devicetree/bindings/sound/atmel-classd.txt
> index 549e701..8985510 100644
> --- a/Documentation/devicetree/bindings/sound/atmel-classd.txt
> +++ b/Documentation/devicetree/bindings/sound/atmel-classd.txt
> @@ -13,13 +13,11 @@ Required properties:
>  	Must be "tx".
>  - clock-names
>  	Tuple listing input clock names.
> -	Required elements: "pclk", "gclk" and "aclk".
> +	Required elements: "pclk" and "gclk".
>  - clocks
>  	Please refer to clock-bindings.txt.
>  - assigned-clocks
>  	Should be <&classd_gclk>.
> -- assigned-clock-parents
> -	Should be <&audio_pll_pmc>.
>  
>  Optional properties:
>  - pinctrl-names, pinctrl-0
> @@ -45,10 +43,9 @@ classd: classd@fc048000 {
>  			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
>  			| AT91_XDMAC_DT_PERID(47))>;
>  		dma-names = "tx";
> -		clocks = <&classd_clk>, <&classd_gclk>, <&audio_pll_pmc>;
> -		clock-names = "pclk", "gclk", "aclk";
> +		clocks = <&classd_clk>, <&classd_gclk>;
> +		clock-names = "pclk", "gclk";
>  		assigned-clocks = <&classd_gclk>;
> -		assigned-clock-parents = <&audio_pll_pmc>;
>  
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_classd_default>;
> 


-- 
Nicolas Ferre
