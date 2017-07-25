From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v4 2/9] dt-bindings: clk: at91: add audio
 plls to the compatible list
Date: Tue, 25 Jul 2017 17:45:05 +0200
Message-ID: <edbdb328-7684-3087-79ec-63fcc9ff1b37@microchip.com>
References: <cover.c8ce78c15296190b2aa5c452c0c4512528e28518.1500968090.git-series.quentin.schulz@free-electrons.com>
 <ab59b9d6b4bcd3a26672ce83e379f49c551eb9ba.1500968090.git-series.quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from esa1.microchip.iphmx.com (esa1.microchip.iphmx.com
 [68.232.147.91])
 by alsa0.perex.cz (Postfix) with ESMTP id 841B1266CFE
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 17:44:25 +0200 (CEST)
In-Reply-To: <ab59b9d6b4bcd3a26672ce83e379f49c551eb9ba.1500968090.git-series.quentin.schulz@free-electrons.com>
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
> This new clock driver set allows to have a fractional divided clock that
> would generate a precise clock particularly suitable for audio
> applications.
> 
> The main audio pll clock has two children clocks: one that is connected
> to the PMC, the other that can directly drive a pad. As these two routes
> have different enable bits and different dividers and divider formulas,
> they are handled by two different drivers.
> 
> This adds the audio plls (frac, pad and pmc) to the compatible list of
> at91 clocks in DT binding.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>  Documentation/devicetree/bindings/clock/at91-clock.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
> index 5f3ad65..51c259a 100644
> --- a/Documentation/devicetree/bindings/clock/at91-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
> @@ -81,6 +81,16 @@ Required properties:
>  	"atmel,sama5d2-clk-generated":
>  		at91 generated clock
>  
> +	"atmel,sama5d2-clk-audio-pll-frac":
> +		at91 audio fractional pll
> +
> +	"atmel,sama5d2-clk-audio-pll-pad":
> +		at91 audio pll CLK_AUDIO output pin
> +
> +	"atmel,sama5d2-clk-audio-pll-pmc"
> +		at91 audio pll output on AUDIOPLLCLK that feeds the PMC
> +		and can be used by peripheral clock or generic clock
> +
>  Required properties for SCKC node:
>  - reg : defines the IO memory reserved for the SCKC.
>  - #size-cells : shall be 0 (reg is used to encode clk id).
> 


-- 
Nicolas Ferre
