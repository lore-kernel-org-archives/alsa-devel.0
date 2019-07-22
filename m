From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 06/10] ASoC: dt-bindings: Document dl_mask property
Date: Mon, 22 Jul 2019 14:56:49 +0200
Message-ID: <1563800209.2311.10.camel@pengutronix.de>
References: <20190722124833.28757-1-daniel.baluta@nxp.com>
         <20190722124833.28757-7-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722124833.28757-7-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>, broonie@kernel.org
Cc: festevam@gmail.com, perex@perex.cz, tiwai@suse.com, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, timur@kernel.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, shengjiu.wang@nxp.com, angus@akkea.ca, kernel@pengutronix.de, viorel.suman@nxp.com
List-Id: alsa-devel@alsa-project.org

Am Montag, den 22.07.2019, 15:48 +0300 schrieb Daniel Baluta:
> SAI supports up to 8 data lines. This property let the user
> configure how many data lines should be used per transfer
> direction (Tx/Rx).
> 
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-sai.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> index 2e726b983845..59f4d965a5fb 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> @@ -49,6 +49,11 @@ Optional properties:
>  
> >    - big-endian		: Boolean property, required if all the SAI
> >  			  registers are big-endian rather than little-endian.
> > +  - fsl,dl_mask		: list of two integers (bitmask, first for RX, second
> > +			  for TX) representing enabled datalines. Bit 0
> > +			  represents first data line, bit 1 represents second
> > +			  data line and so on. Data line is enabled if
> > +			  corresponding bit is set to 1.

No underscores in property names, please. Also this should document the
default value used by the driver when the property is absent.

Regards,
Lucas
