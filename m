From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Extend range of supported
	sample	rates for CS4271 CODEC.
Date: Mon, 7 Mar 2011 10:36:38 +0000
Message-ID: <20110307103633.GA1829@sirena.org.uk>
References: <1299286504.27359.100.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A0EF10384F
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 11:54:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1299286504.27359.100.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander Sverdlin <subaparts@yandex.ru>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 05, 2011 at 03:55:04AM +0300, Alexander Sverdlin wrote:
> From: Alexander Sverdlin <subaparts@yandex.ru>
> 
> Extend range of supported sample rates for CS4271 CODEC.
> 
> Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>

As I've previously reminded you please *always* CC maintainers on
patches.  Patches not sent to the maintainers are very likely to get
missed.  This is also covered in SubmittingPatches.  CCing Liam in on
this one, there's a whole bunch of others.

> ---
>  sound/soc/codecs/cs4271.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
> index 1791796..e5cc4da 100644
> --- a/sound/soc/codecs/cs4271.c
> +++ b/sound/soc/codecs/cs4271.c
> @@ -33,6 +33,7 @@
>  #define CS4271_PCM_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
>  			    SNDRV_PCM_FMTBIT_S24_LE | \
>  			    SNDRV_PCM_FMTBIT_S32_LE)
> +#define CS4271_PCM_RATES SNDRV_PCM_RATE_8000_192000
>  
>  /*
>   * CS4271 registers
> @@ -392,14 +393,14 @@ static struct snd_soc_dai_driver cs4271_dai = {
>  		.stream_name	= "Playback",
>  		.channels_min	= 2,
>  		.channels_max	= 2,
> -		.rates		= SNDRV_PCM_RATE_8000_96000,
> +		.rates		= CS4271_PCM_RATES,
>  		.formats	= CS4271_PCM_FORMATS,
>  	},
>  	.capture = {
>  		.stream_name	= "Capture",
>  		.channels_min	= 2,
>  		.channels_max	= 2,
> -		.rates		= SNDRV_PCM_RATE_8000_96000,
> +		.rates		= CS4271_PCM_RATES,
>  		.formats	= CS4271_PCM_FORMATS,
>  	},
>  	.ops = &cs4271_dai_ops,
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
