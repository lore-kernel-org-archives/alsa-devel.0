From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx6: remove wrong spdif
	rxtx2 clock
Date: Mon, 16 Jun 2014 10:27:15 +0800
Message-ID: <20140616022713.GA21550@MrMyself>
References: <1402875585-29025-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0184.outbound.protection.outlook.com [207.46.163.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B36F2652E9
 for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2014 04:44:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1402875585-29025-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 16, 2014 at 02:39:44AM +0300, Anssi Hannula wrote:
> The rxtx2 clock of i.MX6 S/PDIF is currently set to "asrc" clock.
> However, according to SoC documentation, rxtx2 is connected to
> ASRC_EXT_CLK, a different external clock.
> 
> Testing on Cubox-i system seems to confirm that: when fsl_spdif is
> forced to select rxtx2 as input clock, audio playback fails with an I/O
> error.
> 
> Set rxtx2 to the dummy clock by default to prevent fsl_spdif from
> selecting it.
> 
> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
> Cc: Nicolin Chen <Guangyu.Chen@freescale.com>
> Cc: Mark Brown <broonie@kernel.org>

Acked, thank you!

P.S. We might also revive rxtx5 (SYSCLK) since the driver now has the
capability to derive clock from it.

> ---
> 
> This one seems clear enough.
> 
>  arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index ce0599134a69..3aef9a2f5fda 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -181,7 +181,7 @@
>  					       <&sdma 15 18 0>;
>  					dma-names = "rx", "tx";
>  					clocks = <&clks 197>, <&clks 3>,
> -						 <&clks 197>, <&clks 107>,
> +						 <&clks 197>, <&clks 0>,
>  						 <&clks 0>,   <&clks 118>,
>  						 <&clks 0>,  <&clks 139>,
>  						 <&clks 0>;
> -- 
> 1.8.4.5
> 
