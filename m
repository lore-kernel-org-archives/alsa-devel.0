From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V4 3/3] ASoC: fsl_asrc: Unify the supported input and
 output rate
Date: Fri, 19 Apr 2019 11:28:13 -0700
Message-ID: <20190419182812.GC1136@Asurada-Nvidia.nvidia.com>
References: <cover.1555669068.git.shengjiu.wang@nxp.com>
 <b450010bb24e18e01b78d32067d6efdb572a9cc4.1555669068.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b450010bb24e18e01b78d32067d6efdb572a9cc4.1555669068.git.shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 19, 2019 at 10:23:56AM +0000, S.j. Wang wrote:
> Unify the supported input and output rate, add the
> 12kHz/24kHz/128kHz to the support list
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 2c4bbc3499db..0d06e738264a 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -27,13 +27,14 @@
>  	dev_dbg(&asrc_priv->pdev->dev, "Pair %c: " fmt, 'A' + index, ##__VA_ARGS__)
>  
>  /* Corresponding to process_option */
> -static int supported_input_rate[] = {
> -	5512, 8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 88200,
> -	96000, 176400, 192000,
> +static unsigned int supported_asrc_rate[] = {
> +	5512, 8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000,
> +	64000, 88200, 96000, 128000, 176400, 192000,
>  };
>  
> -static int supported_asrc_rate[] = {
> -	8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 88200, 96000, 176400, 192000,
> +static struct snd_pcm_hw_constraint_list fsl_asrc_rate_constraints = {
> +	.count = ARRAY_SIZE(supported_asrc_rate),
> +	.list = supported_asrc_rate,
>  };
>  
>  /**
> @@ -293,11 +294,11 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  	ideal = config->inclk == INCLK_NONE;
>  
>  	/* Validate input and output sample rates */
> -	for (in = 0; in < ARRAY_SIZE(supported_input_rate); in++)
> -		if (inrate == supported_input_rate[in])
> +	for (in = 0; in < ARRAY_SIZE(supported_asrc_rate); in++)
> +		if (inrate == supported_asrc_rate[in])
>  			break;

Not sure if we still need it upon having hw_constraint. Maybe m2m
needs it?
