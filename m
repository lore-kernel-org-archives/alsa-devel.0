From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 08/18] ASoC: twl4030: Use
	snd_pcm_hw_constraint_single()
Date: Mon, 19 Oct 2015 15:05:14 +0300
Message-ID: <5624DC7A.6070709@ti.com>
References: <1445175573-11784-1-git-send-email-lars@metafoo.de>
 <1445175573-11784-9-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 21F2C26580B
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 14:05:20 +0200 (CEST)
In-Reply-To: <1445175573-11784-9-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Yang A Fang <yang.a.fang@intel.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 10/18/2015 04:39 PM, Lars-Peter Clausen wrote:
> Use the new snd_pcm_hw_constraint_single() helper function instead of
> calling snd_pcm_hw_constraint_minmax() with the same value for min and max
> to install a constraint that limits the possible configuration values to a
> single value. Using snd_pcm_hw_constraint_single() makes the indented
> result clearer and is slightly shorter.
> =

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  sound/soc/codecs/twl4030.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> =

> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index 2713e18..a5a4e9f 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -1612,19 +1612,16 @@ static void twl4030_constraints(struct twl4030_pr=
iv *twl4030,
>  		return;
>  =

>  	/* Set the constraints according to the already configured stream */
> -	snd_pcm_hw_constraint_minmax(slv_substream->runtime,
> +	snd_pcm_hw_constraint_single(slv_substream->runtime,
>  				SNDRV_PCM_HW_PARAM_RATE,
> -				twl4030->rate,
>  				twl4030->rate);
>  =

> -	snd_pcm_hw_constraint_minmax(slv_substream->runtime,
> +	snd_pcm_hw_constraint_single(slv_substream->runtime,
>  				SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
> -				twl4030->sample_bits,
>  				twl4030->sample_bits);
>  =

> -	snd_pcm_hw_constraint_minmax(slv_substream->runtime,
> +	snd_pcm_hw_constraint_single(slv_substream->runtime,
>  				SNDRV_PCM_HW_PARAM_CHANNELS,
> -				twl4030->channels,
>  				twl4030->channels);
>  }
>  =

> @@ -1669,9 +1666,9 @@ static int twl4030_startup(struct snd_pcm_substream=
 *substream,
>  			/* In option2 4 channel is not supported, set the
>  			 * constraint for the first stream for channels, the
>  			 * second stream will 'inherit' this cosntraint */
> -			snd_pcm_hw_constraint_minmax(substream->runtime,
> +			snd_pcm_hw_constraint_single(substream->runtime,
>  						     SNDRV_PCM_HW_PARAM_CHANNELS,
> -						     2, 2);
> +						     2);
>  		}
>  		twl4030->master_substream =3D substream;
>  	}
> =



-- =

P=E9ter
