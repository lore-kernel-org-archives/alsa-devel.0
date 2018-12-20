From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC 1/2] ASoC: micfil: Add bindings for MICFIL DAI
Date: Thu, 20 Dec 2018 13:56:35 -0600
Message-ID: <20181220195635.GA22978@bogus>
References: <1544433661-32496-1-git-send-email-cosmin.samoila@nxp.com>
 <1544433661-32496-2-git-send-email-cosmin.samoila@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it1-f193.google.com (mail-it1-f193.google.com
 [209.85.166.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C18ED2678D4
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2018 20:56:38 +0100 (CET)
Received: by mail-it1-f193.google.com with SMTP id g85so3798926ita.3
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2018 11:56:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1544433661-32496-2-git-send-email-cosmin.samoila@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cosmin Samoila <cosmin.samoila@nxp.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "gabrielcsmo@gmail.com" <gabrielcsmo@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 10, 2018 at 09:21:14AM +0000, Cosmin Samoila wrote:
> Document the bindings for MICFIL DAI.
> 
> Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,micfil.txt       | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,micfil.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,micfil.txt b/Documentation/devicetree/bindings/sound/fsl,micfil.txt
> new file mode 100644
> index 0000000..2aa4526
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,micfil.txt
> @@ -0,0 +1,38 @@
> +NXP MICFIL Digital Audio Interface (MICFIL).
> +
> +The MICFIL digital interface provides a 16-bit audio signal from a PDM
> +microphone bitstream in a configurable output sampling rate.
> +
> +Required properties:
> +
> +  - compatible		: Compatible list, contains "fsl,imx8mm-micfil"
> +
> +  - reg			: Offset and length of the register set for the device.
> +
> +  - interrupts		: Contains the micfil interrupts.
> +
> +  - clocks		: Must contain an entry for each entry in clock-names.
> +
> +  - clock-names		: Must include the "ipg_clk" for register access and
> +			  "ipg_clk_app" for internal micfil clock.
> +
> +  - dmas		: Generic dma devicetree binding as described in
> +			  Documentation/devicetree/bindings/dma/dma.txt.
> +
> +  - dma-names		: One "rx" dma must be configured.

You don't need -names when there is only one.

> +
> +Example:
> +micfil: micfil@30080000 {
> +	compatible = "fsl,imx8mm-micfil";
> +	reg = <0x0 0x30080000 0x0 0x10000>;
> +	interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&clk IMX8MM_CLK_PDM_IPG>,
> +		 <&clk IMX8MM_CLK_PDM_ROOT>;
> +	clock-names = "ipg_clk", "ipg_clk_app";
> +	dmas = <&sdma2 24 26 0x80000000>;
> +	dma-names = "rx";
> +	status = "disabled";

Don't show status in examples.

> +};
> -- 
> 2.7.4
> 
