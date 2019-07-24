From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 08/10] ASoC: dt-bindings: Document fcomb_mode property
Date: Wed, 24 Jul 2019 16:22:09 -0700
Message-ID: <20190724232209.GC6859@Asurada-Nvidia.nvidia.com>
References: <20190722124833.28757-1-daniel.baluta@nxp.com>
 <20190722124833.28757-9-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190722124833.28757-9-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: broonie@kernel.org, festevam@gmail.com, perex@perex.cz, tiwai@suse.com, Xiubo.Lee@gmail.com, timur@kernel.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, shengjiu.wang@nxp.com, angus@akkea.ca, kernel@pengutronix.de, l.stach@pengutronix.de, viorel.suman@nxp.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 22, 2019 at 03:48:31PM +0300, Daniel Baluta wrote:
> This allows combining multiple-data-line FIFOs into a
> single-data-line FIFO.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-sai.txt | 4 ++++

This should be sent to devicetree mail-list also.

>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> index 59f4d965a5fb..ca27afd840ba 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> @@ -54,6 +54,10 @@ Optional properties:
>  			  represents first data line, bit 1 represents second
>  			  data line and so on. Data line is enabled if
>  			  corresponding bit is set to 1.
> +  - fsl,fcomb_mode	: list of two integers (first for RX, second for TX)
> +			  representing FIFO combine mode. Possible values for
> +			  combined mode are: 0 - disabled, 1 - Rx/Tx from shift
> +			  registers, 2 - Rx/Tx by software, 3 - both.

Looks like a software configuration to me, instead of a device
property. Is this configurable by user case, or hard-coded by
SoC/hardware design?
