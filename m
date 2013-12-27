From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCHv4 2/4] ARM: dts: Add Freescale SAI ALSA SoC
 Digital Audio Interface node for VF610.
Date: Fri, 27 Dec 2013 16:53:27 +0800
Message-ID: <20131227085322.GA3367@S2101-09.ap.freescale.net>
References: <1387501387-2151-1-git-send-email-Li.Xiubo@freescale.com>
 <1387501387-2151-2-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EA93261A3B
 for <alsa-devel@alsa-project.org>; Fri, 27 Dec 2013 09:53:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1387501387-2151-2-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: Jingchang Lu <b35083@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 20, 2013 at 09:03:05AM +0800, Xiubo Li wrote:
> This patch adds the SAI's edma mux Tx and Rx support.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
>  arch/arm/boot/dts/vf610.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
> index e84d84c..2d6ddd0 100644
> --- a/arch/arm/boot/dts/vf610.dtsi
> +++ b/arch/arm/boot/dts/vf610.dtsi
> @@ -166,6 +166,9 @@
>  				interrupts = <0 86 0x04>;
>  				clocks = <&clks VF610_CLK_SAI2>;
>  				clock-names = "sai";
> +				dma-names = "tx", "rx";
> +				dmas = <&edma0 0 VF610_EDMA_MUXID0_SAI2_TX>,
> +					<&edma0 0 VF610_EDMA_MUXID0_SAI2_RX>;

Where are these VF610_EDMA_MUXID0_* macros defined?  I cannot find them
in my tree.

Shawn

>  				status = "disabled";
>  			};
>  
> -- 
> 1.8.4
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
