From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 4/7] ASoC: dt-bindings: Document dl-mask property
Date: Mon, 29 Jul 2019 13:15:09 -0700
Message-ID: <20190729201508.GB20594@Asurada-Nvidia.nvidia.com>
References: <20190728192429.1514-1-daniel.baluta@nxp.com>
 <20190728192429.1514-5-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190728192429.1514-5-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: broonie@kernel.org, l.stach@pengutronix.de, mihai.serban@gmail.com, alsa-devel@alsa-project.org, viorel.suman@nxp.com, timur@kernel.org, shengjiu.wang@nxp.com, angus@akkea.ca, tiwai@suse.com, linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jul 28, 2019 at 10:24:26PM +0300, Daniel Baluta wrote:
> SAI supports up to 8 data lines. This property let the user
> configure how many data lines should be used per transfer
> direction (Tx/Rx).

This sounds a bit less persuasive to me as we are adding a
DT property that's used to describe a hardware connections
and it would be probably better to mention that the mapping
between the mask and the data lines could be more flexible
than consecutive active data lines as you said previously.

> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-sai.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> index 2e726b983845..2b38036a4883 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> @@ -49,6 +49,13 @@ Optional properties:
>  
>    - big-endian		: Boolean property, required if all the SAI
>  			  registers are big-endian rather than little-endian.
> +  - fsl,dl-mask		: list of two integers (bitmask, first for RX, second

I am leaving this naming to DT maintainer.

> +			  for TX) representing enabled datalines. Bit 0
> +			  represents first data line, bit 1 represents second
> +			  data line and so on. Data line is enabled if
> +			  corresponding bit is set to 1. By default, if property
> +			  not present, only dataline 0 is enabled for both
> +			  directions.

To make this patch more convincing, could we add an example
as well in the Example section of this binding file? Like:
	/* RX data lines 0/1 and TX data lines 0/2 are connected */
	fsl,dl-mask = <0x3 0x5>;
