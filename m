From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [RFC PATCH] ASoC: fsl_sai: Enable data lines based on input
 channels
Date: Tue, 13 Aug 2019 18:39:16 -0700
Message-ID: <20190814013916.GB13398@Asurada-Nvidia.nvidia.com>
References: <20190811195545.32606-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190811195545.32606-1-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, tiwai@suse.com, alsa-devel@alsa-project.org, festevam@gmail.com
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 11, 2019 at 10:55:45PM +0300, Daniel Baluta wrote:
> An audio data frame consists of a number of slots one for each
> channel. In the case of I2S there are 2 data slots / frame.
> 
> The maximum number of SAI slots / frame is configurable at
> IP integration time. This affects the width of Mask Register.
> SAI supports up to 32 slots per frame.
> 
> The number of datalines is also configurable (up to 8 datalines)
> and affects TCE/RCE and the number of data/FIFO registers.
> 
> The number of needed data lines (pins) is computed as follows:
> 
> * pins = channels / slots.
> 
> This can be computed in hw_params function so lets move TRCE bits
> seting from startup to hw_params.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 34 +++++++++++++---------------------
>  sound/soc/fsl/fsl_sai.h |  2 +-
>  2 files changed, 14 insertions(+), 22 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 69cf3678c859..b70032c82fe2 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c

> @@ -480,13 +483,17 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,

> -	regmap_write(sai->regmap, FSL_SAI_xMR(tx), ~0UL - ((1 << channels) - 1));
> +	regmap_write(sai->regmap, FSL_SAI_xMR(tx), ~0UL - ((1 << slots) - 1));

Would this break mono channel audio?

>  static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)

> @@ -881,6 +872,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	sai->pdev = pdev;
> +

Seemly unnecessary
