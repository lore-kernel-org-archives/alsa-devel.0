From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 07/12] ASoC: davinci-evm: Register
 machine level DAPM elements with the card
Date: Thu, 13 Mar 2014 12:07:41 +0200
Message-ID: <5321836D.7030901@ti.com>
References: <1394634460-15889-1-git-send-email-lars@metafoo.de>
 <1394634460-15889-8-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 023F826516B
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 11:07:46 +0100 (CET)
In-Reply-To: <1394634460-15889-8-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Ryan Mallon <rmallon@gmail.com>, Vinod Koul <vinod.koul@intel.com>, =?ISO-8859-1?Q?Daniel_Gl=F6ckner?= <daniel-gl@gmx.net>, Benoit Cousson <bcousson@baylibre.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 03/12/2014 04:27 PM, Lars-Peter Clausen wrote:
> Machine level DAPM widgets and routes should be registered in the card's =
DAPM
> context, rather than in the CODEC's context.
> =

> While we are at it also drop the snd_soc_dapm_enable_pin() calls, since p=
ins are
> enabled by default and also turn the snd_soc_dapm_disable_pin() calls into
> snd_soc_dapm_nc_pin() calls for unconnected pins.
> =

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
> Changes since v1:
> 	* Remove snd_soc_dapm_enable_pin() calls
> 	* Change snd_soc_dapm_disable_pin() calles into snd_soc_dapm_nc_pin()
> ---
>  sound/soc/davinci/davinci-evm.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> =

> diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-=
evm.c
> index 70ff377..9c296f7 100644
> --- a/sound/soc/davinci/davinci-evm.c
> +++ b/sound/soc/davinci/davinci-evm.c
> @@ -95,35 +95,29 @@ static const struct snd_soc_dapm_route audio_map[] =
=3D {
>  /* Logic for a aic3x as connected on a davinci-evm */
>  static int evm_aic3x_init(struct snd_soc_pcm_runtime *rtd)
>  {
> +	struct snd_soc_card *card =3D rtd->card;
>  	struct snd_soc_codec *codec =3D rtd->codec;
> -	struct snd_soc_dapm_context *dapm =3D &codec->dapm;
>  	struct device_node *np =3D codec->card->dev->of_node;
>  	int ret;
>  =

>  	/* Add davinci-evm specific widgets */
> -	snd_soc_dapm_new_controls(dapm, aic3x_dapm_widgets,
> +	snd_soc_dapm_new_controls(&card->dapm, aic3x_dapm_widgets,
>  				  ARRAY_SIZE(aic3x_dapm_widgets));
>  =

>  	if (np) {
> -		ret =3D snd_soc_of_parse_audio_routing(codec->card,
> -							"ti,audio-routing");
> +		ret =3D snd_soc_of_parse_audio_routing(card, "ti,audio-routing");
>  		if (ret)
>  			return ret;
>  	} else {
>  		/* Set up davinci-evm specific audio path audio_map */
> -		snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
> +		snd_soc_dapm_add_routes(&card->dapm, audio_map,
> +					ARRAY_SIZE(audio_map));
>  	}
>  =

>  	/* not connected */
> -	snd_soc_dapm_disable_pin(dapm, "MONO_LOUT");
> -	snd_soc_dapm_disable_pin(dapm, "HPLCOM");
> -	snd_soc_dapm_disable_pin(dapm, "HPRCOM");
> -
> -	/* always connected */
> -	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
> -	snd_soc_dapm_enable_pin(dapm, "Line Out");
> -	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
> -	snd_soc_dapm_enable_pin(dapm, "Line In");
> +	snd_soc_dapm_nc_pin(&codec->dapm, "MONO_LOUT");
> +	snd_soc_dapm_nc_pin(&codec->dapm, "HPLCOM");
> +	snd_soc_dapm_nc_pin(&codec->dapm, "HPRCOM");
>  =

>  	return 0;
>  }
> =



-- =

P=E9ter
