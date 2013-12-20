From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCHv4 2/4] ARM: dts: Add Freescale SAI ALSA SoC
 Digital Audio Interface node for VF610.
Date: Fri, 20 Dec 2013 11:30:33 +0000
Message-ID: <96d8b47fd8c14c11a1cd12d5810177ca@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1387501387-2151-1-git-send-email-Li.Xiubo@freescale.com>
 <1387501387-2151-2-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0181.outbound.protection.outlook.com [207.46.163.181])
 by alsa0.perex.cz (Postfix) with ESMTP id DDFF22655BC
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 12:30:37 +0100 (CET)
In-Reply-To: <1387501387-2151-2-git-send-email-Li.Xiubo@freescale.com>
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
To: "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, Jingchang Lu <jingchang.lu@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi,

  Could someone help review and merge this DTS patch please ?

  Thanks very much!

Best Regards,
Xiubo



> Subject: [PATCHv4 2/4] ARM: dts: Add Freescale SAI ALSA SoC Digital Audio
> Interface node for VF610.
> 
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
> 
