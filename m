From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: add cs4271 and cs4272 support
Date: Thu, 28 Jan 2016 10:24:08 -0800
Message-ID: <20160128182407.GA23971@Asurada-Nvidia>
References: <1453978355-23620-1-git-send-email-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453978355-23620-1-git-send-email-eu@felipetonello.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Felipe F. Tonello" <eu@felipetonello.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 28, 2016 at 10:52:35AM +0000, Felipe F. Tonello wrote:
> add cs4271 and cs42727 support for fsl-asoc-card
> 
> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
> ---
>  .../devicetree/bindings/sound/imx-audio-cs427x.txt | 47 ++++++++++++++++++++++
>  sound/soc/fsl/Kconfig                              |  4 +-
>  sound/soc/fsl/fsl-asoc-card.c                      |  7 ++++
>  3 files changed, 56 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-cs427x.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/imx-audio-cs427x.txt b/Documentation/devicetree/bindings/sound/imx-audio-cs427x.txt
> new file mode 100644
> index 000000000000..295f60b19418
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/imx-audio-cs427x.txt
> @@ -0,0 +1,47 @@
> +Freescale i.MX audio complex with CS4271 or CS4272 codec

I think it could be better to insert these into the fsl-asoc-card.txt
without those redundant property descriptions. At least it should be
added to the compatible list. And you may add a comment in (...) to
describe that it supports both 4271 and 4272.

> +  - mux-int-port	: The internal port of the i.MX audio muxer (AUDMUX)
> +
> +  - mux-ext-port	: The external port of the i.MX audio muxer
> +
> +Note: The AUDMUX port numbering should start at 1, which is consistent with
> +hardware manual.

These two properties are missing in the fsl-asoc-card binding docs.
So it could be nice to have them as well. But they should be optional
unless SSI is selected as a CPU DAI.

Thanks
Nicolin
