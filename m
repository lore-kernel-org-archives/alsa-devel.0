From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 06/10] ASoC: dt-bindings: Document dl_mask property
Date: Wed, 24 Jul 2019 16:13:43 -0700
Message-ID: <20190724231342.GB6859@Asurada-Nvidia.nvidia.com>
References: <20190722124833.28757-1-daniel.baluta@nxp.com>
 <20190722124833.28757-7-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190722124833.28757-7-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: broonie@kernel.org, festevam@gmail.com, perex@perex.cz, tiwai@suse.com, Xiubo.Lee@gmail.com, timur@kernel.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, shengjiu.wang@nxp.com, angus@akkea.ca, kernel@pengutronix.de, l.stach@pengutronix.de, viorel.suman@nxp.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 22, 2019 at 03:48:29PM +0300, Daniel Baluta wrote:
> SAI supports up to 8 data lines. This property let the user
> configure how many data lines should be used per transfer
> direction (Tx/Rx).
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-sai.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> index 2e726b983845..59f4d965a5fb 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> @@ -49,6 +49,11 @@ Optional properties:

> +  - fsl,dl_mask		: list of two integers (bitmask, first for RX, second

Not quite in favor of the naming here; And this patch should
be sent to the devicetree maillist and add DT maintainers --
they would give some good naming advice.

>From my point of view, I feel, since data lines are enabled
consecutively, probably it'd be clear just to have something
like "fsl,num-datalines = <2 2>", corresponding to "dl_mask
= <0x3 0x3>". I believe there're examples in the existing DT
bindings, so let's see how others suggest.

> +			  for TX) representing enabled datalines. Bit 0
> +			  represents first data line, bit 1 represents second
> +			  data line and so on. Data line is enabled if
> +			  corresponding bit is set to 1.

Would be better to mention: "as a default use case, if this
property is absent, only the first data line will be enabled
for both TX and RX", since it's an optional property.

And one more extension(?) of it could be what if there's no
data line being physically connected for one direction, for
example "dl_mask = <0x0 0x1>", indicating that SAI enables
one single TX line only, so driver would disable RX feature.
What do you think?
