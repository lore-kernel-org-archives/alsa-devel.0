From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC PATCH] ASoC: omap-mcbsp: Add support for
 highter rate up to 384000
Date: Mon, 12 Aug 2013 18:36:16 +0300
Message-ID: <520900F0.9080600@ti.com>
References: <20130807182841.GA7823@panicking> <5203782D.1080008@ti.com>
 <20130808110410.GA11288@panicking> <52047B9F.7040607@ti.com>
 <20130810075325.GA12316@panicking>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BBB5264F3D
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2013 17:35:35 +0200 (CEST)
In-Reply-To: <20130810075325.GA12316@panicking>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 08/10/2013 10:53 AM, Michael Trimarchi wrote:
> I found some time but I can't not test this patch now ;) too far from
> my office. The idea is to check with MAX_BCLK. There are two points
> that should cover slave and master mode. Is it the right direction?
> BTW Do you think that is better to have at soc level as a new constraint?

I would not bother with the bclk check for now. We did not had issues so far
and 48MHz is quite high anyways for our users so far.

> =

> Michael
> =

> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index 7483efb..ea95ad2 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -39,7 +39,9 @@
>  #include "mcbsp.h"
>  #include "omap-mcbsp.h"
>  =

> -#define OMAP_MCBSP_RATES	(SNDRV_PCM_RATE_8000_96000)
> +#define OMAP_MCBSP_MAX_BCLK	48000000
> +#define OMAP_MCBSP_RATES	(SNDRV_PCM_RATE_8000_192000 |		\
> +				 SNDRV_PCM_RATE_KNOT)
>  =

>  #define OMAP_MCBSP_SOC_SINGLE_S16_EXT(xname, xmin, xmax, \
>  	xhandler_get, xhandler_put) \
> @@ -225,10 +227,14 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_=
substream *substream,
>  	struct omap_mcbsp *mcbsp =3D snd_soc_dai_get_drvdata(cpu_dai);
>  	struct omap_mcbsp_reg_cfg *regs =3D &mcbsp->cfg_regs;
>  	struct snd_dmaengine_dai_dma_data *dma_data;
> -	int wlen, channels, wpf;
> +	int wlen, channels, wpf, bclk;
>  	int pkt_size =3D 0;
>  	unsigned int format, div, framesize, master;
>  =

> +	bclk =3D snd_soc_params_to_bclk(params);
> +	if (bclk < 0 || bclk > OMAP_MCBSP_MAX_BCLK)
> +		return -EINVAL;
> +
>  	dma_data =3D snd_soc_dai_get_dma_data(cpu_dai, substream);
>  	channels =3D params_channels(params);
>  =

> @@ -326,7 +332,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_su=
bstream *substream,
>  	/* In McBSP master modes, FRAME (i.e. sample rate) is generated
>  	 * by _counting_ BCLKs. Calculate frame size in BCLKs */
>  	master =3D mcbsp->fmt & SND_SOC_DAIFMT_MASTER_MASK;
> -	if (master =3D=3D	SND_SOC_DAIFMT_CBS_CFS) {
> +	if (master =3D=3D SND_SOC_DAIFMT_CBS_CFS) {
>  		div =3D mcbsp->clk_div ? mcbsp->clk_div : 1;
>  		framesize =3D (mcbsp->in_freq / div) / params_rate(params);
>  =

> @@ -500,6 +506,9 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_s=
oc_dai *cpu_dai,
>  			return -EBUSY;
>  	}
>  =

> +	if (freq > OMAP_MCBSP_MAX_BCLK)
> +		return -EINVAL;
> +
>  	mcbsp->in_freq =3D freq;
>  	regs->srgr2 &=3D ~CLKSM;
>  	regs->pcr0 &=3D ~SCLKME;
>>
>>>
>>> Michael
>>>
>>>>>  	},
>>>>>  	.capture =3D {
>>>>>  		.channels_min =3D 1,
>>>>>  		.channels_max =3D 16,
>>>>>  		.rates =3D OMAP_MCBSP_RATES,
>>>>> +		.rate_min =3D 8000,
>>>>> +		.rate_max =3D 384000,
>>>>
>>>> Same here, do not set these.
>>>>
>>>>>  		.formats =3D SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
>>>>>  	},
>>>>>  	.ops =3D &mcbsp_dai_ops,
>>>>>
>>>>
>>>>
>>>> -- =

>>>> P=E9ter
>>>
>>
>>
>> -- =

>> P=E9ter


-- =

P=E9ter
