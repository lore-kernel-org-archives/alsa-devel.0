From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] arm64: dts: renesas: r8a7796: remove unneeded sound
 #address/size-cells
Date: Mon, 25 Feb 2019 09:56:35 +0100
Message-ID: <20190225085635.ztgakkoc42bsal55@verge.net.au>
References: <1550828099-3109-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550828099-3109-1-git-send-email-twischer@de.adit-jv.com>
Sender: linux-kernel-owner@vger.kernel.org
To: twischer@de.adit-jv.com
Cc: patch@alsa-project.org, broonie@kernel.org, kuninori.morimoto.gx@renesas.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jiada Wang <jiada_wang@mentor.com>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 22, 2019 at 10:34:59AM +0100, twischer@de.adit-jv.com wrote:
> From: Jiada Wang <jiada_wang@mentor.com>
> 
> commit 78bc93b3ffb2 ("arm64: dts: renesas: r8a7796: Add address
> properties to rcar_sound port nodes") added missing #address-cells
> and #size-cells for sound ports.
> But, these are based on platform, not on SoC. This patch cleanups it.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

Thanks,

please CC patches for Renesas SoCs to linux-renesas-soc@vger.kernel.org (CCed)
so they appear in my patch queue.

Otherwise, this patch looks fine to me but I will wait to see if there are
other reviews before applying.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts  |  1 +
>  arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts |  1 +
>  arch/arm64/boot/dts/renesas/r8a7796.dtsi            | 11 -----------
>  3 files changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> index b4f9567..2aefa53 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> @@ -68,6 +68,7 @@
>  	ports {
>  		/* rsnd_port0 is on salvator-common */
>  		rsnd_port1: port@1 {
> +			reg = <1>;
>  			rsnd_endpoint1: endpoint {
>  				remote-endpoint = <&dw_hdmi0_snd_in>;
>  
> diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts
> index 8860be6..fa4ef7c 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts
> @@ -69,6 +69,7 @@
>  	ports {
>  		/* rsnd_port0 is on salvator-common */
>  		rsnd_port1: port@1 {
> +			reg = <1>;
>  			rsnd_endpoint1: endpoint {
>  				remote-endpoint = <&dw_hdmi0_snd_in>;
>  
> diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> index 0648d12..cc601d9 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> @@ -2162,17 +2162,6 @@
>  					dma-names = "rx", "tx", "rxu", "txu";
>  				};
>  			};
> -
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				port@0 {
> -					reg = <0>;
> -				};
> -				port@1 {
> -					reg = <1>;
> -				};
> -			};
>  		};
>  
>  		audma0: dma-controller@ec700000 {
> -- 
> 2.7.4
> 
