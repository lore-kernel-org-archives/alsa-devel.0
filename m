From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 4/4] ASoC: add imx-audmix DT binding documentation
Date: Tue, 15 Jan 2019 14:57:55 -0600
Message-ID: <20190115205755.GA4022@bogus>
References: <1546952716-2743-1-git-send-email-viorel.suman@nxp.com>
 <1546952716-2743-5-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1546952716-2743-5-git-send-email-viorel.suman@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 08, 2019 at 01:05:51PM +0000, Viorel Suman wrote:
> Add the DT binding documentation for Audio Mixer
> machine driver.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../devicetree/bindings/sound/imx-audmix.txt       | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audmix.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/imx-audmix.txt b/Documentation/devicetree/bindings/sound/imx-audmix.txt
> new file mode 100644
> index 0000000..6ac1230
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/imx-audmix.txt
> @@ -0,0 +1,24 @@
> +NXP Audio Mixer (AUDMIX) machine driver.
> +
> +Required properties:
> +===================================
> +  - compatible		: Compatible list, contains "fsl,imx-audmix"
> +
> +  - model		: Short audio card description.
> +
> +  - dais		: Must contain a list of phandles to AUDMIX connected
> +			  DAIs. The current implementation requires two phandles
> +			  to SAI interfaces to be provided, the first SAI in the
> +			  list being used to route the AUDMIX output.
> +
> +  - audmix-controller	: Must contain the phandle to the AUDMIX device node.

I don't think you need 2 nodes for this as this one is just a virtual 
device. Just add the dais property to the audmix node.

Rob
