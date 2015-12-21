From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_asrc: add support for 8-30kHz
 output sample rate
Date: Sun, 20 Dec 2015 23:25:10 -0800
Message-ID: <20151221072510.GB3524@Asurada-CZ80>
References: <7ff4f7a6d8b3927664f6350232f46c81d6c6be80.1450429119.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 76B98261552
 for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2015 08:25:14 +0100 (CET)
Received: by mail-pa0-f51.google.com with SMTP id q3so74830751pav.3
 for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2015 23:25:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7ff4f7a6d8b3927664f6350232f46c81d6c6be80.1450429119.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 18, 2015 at 05:00:09PM +0800, Zidan Wang wrote:
> Add 8kHz, 11.025kHz, 16kHz, 22.05kHz output sample rate support.
> 
> According referance menual, "Limited support for the case when
> output sampling rates is between 8kHz and 30kHz. The limitation
> is the supported ratio (Fsin/Fsout) range as between 1/24 to 8."
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you

> ---
> v1->v2:
> 1. fix indentation issue.
> 
>  sound/soc/fsl/fsl_asrc.c | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index d964016..bd32c30 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -31,21 +31,21 @@
>  	dev_dbg(&asrc_priv->pdev->dev, "Pair %c: " fmt, 'A' + index, ##__VA_ARGS__)
>  
>  /* Sample rates are aligned with that defined in pcm.h file */
> -static const u8 process_option[][8][2] = {
> -	/* 32kHz 44.1kHz 48kHz   64kHz   88.2kHz 96kHz   176kHz  192kHz */
> -	{{0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 5512Hz */
> -	{{0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 8kHz */
> -	{{0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 11025Hz */
> -	{{0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 16kHz */
> -	{{0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 22050Hz */
> -	{{0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0},},	/* 32kHz */
> -	{{0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0},},	/* 44.1kHz */
> -	{{0, 2}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0},},	/* 48kHz */
> -	{{1, 2}, {0, 2}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0},},	/* 64kHz */
> -	{{1, 2}, {1, 2}, {1, 2}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1},},	/* 88.2kHz */
> -	{{1, 2}, {1, 2}, {1, 2}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1},},	/* 96kHz */
> -	{{2, 2}, {2, 2}, {2, 2}, {2, 1}, {2, 1}, {2, 1}, {2, 1}, {2, 1},},	/* 176kHz */
> -	{{2, 2}, {2, 2}, {2, 2}, {2, 1}, {2, 1}, {2, 1}, {2, 1}, {2, 1},},	/* 192kHz */
> +static const u8 process_option[][12][2] = {
> +	/* 8kHz 11.025kHz 16kHz 22.05kHz 32kHz 44.1kHz 48kHz   64kHz   88.2kHz 96kHz   176kHz  192kHz */
> +	{{0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 5512Hz */
> +	{{0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 8kHz */
> +	{{0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 11025Hz */
> +	{{1, 2}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 16kHz */
> +	{{1, 2}, {1, 2}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},},	/* 22050Hz */
> +	{{1, 2}, {2, 1}, {2, 1}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0}, {0, 0},},	/* 32kHz */
> +	{{2, 2}, {2, 2}, {2, 1}, {2, 1}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0},},	/* 44.1kHz */
> +	{{2, 2}, {2, 2}, {2, 1}, {2, 1}, {0, 2}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0}, {0, 0},},	/* 48kHz */
> +	{{2, 2}, {2, 2}, {2, 2}, {2, 1}, {1, 2}, {0, 2}, {0, 2}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 0},},	/* 64kHz */
> +	{{2, 2}, {2, 2}, {2, 2}, {2, 2}, {1, 2}, {1, 2}, {1, 2}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1},},	/* 88.2kHz */
> +	{{2, 2}, {2, 2}, {2, 2}, {2, 2}, {1, 2}, {1, 2}, {1, 2}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1},},	/* 96kHz */
> +	{{2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 1}, {2, 1}, {2, 1}, {2, 1}, {2, 1},},	/* 176kHz */
> +	{{2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 2}, {2, 1}, {2, 1}, {2, 1}, {2, 1}, {2, 1},},	/* 192kHz */
>  };
>  
>  /* Corresponding to process_option */
> @@ -55,7 +55,7 @@ static int supported_input_rate[] = {
>  };
>  
>  static int supported_asrc_rate[] = {
> -	32000, 44100, 48000, 64000, 88200, 96000, 176400, 192000,
> +	8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 88200, 96000, 176400, 192000,
>  };
>  
>  /**
> @@ -287,6 +287,13 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  		return -EINVAL;
>  	}
>  
> +	if ((outrate > 8000 && outrate < 30000) &&
> +	    (outrate/inrate > 24 || inrate/outrate > 8)) {
> +		pair_err("exceed supported ratio range [1/24, 8] for \
> +				inrate/outrate: %d/%d\n", inrate, outrate);
> +		return -EINVAL;
> +	}
> +
>  	/* Validate input and output clock sources */
>  	clk_index[IN] = clk_map[IN][config->inclk];
>  	clk_index[OUT] = clk_map[OUT][config->outclk];
> -- 
> 1.9.1
> 
