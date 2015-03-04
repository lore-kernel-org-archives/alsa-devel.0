From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 11/30] ASoC: omap-abe-twl6040: Register
 jacks at the card level
Date: Wed, 4 Mar 2015 11:47:47 +0200
Message-ID: <54F6D4C3.6060603@ti.com>
References: <1425461626-21103-1-git-send-email-lars@metafoo.de>
 <1425461626-21103-12-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 393F72651EB
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 10:47:54 +0100 (CET)
In-Reply-To: <1425461626-21103-12-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Jie Yang <yang.jie@linux.intel.com>, Yang A Fang <yang.a.fang@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Sean Cross <xobs@kosagi.com>, Dylan Reid <dgreid@chromium.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 03/04/2015 11:33 AM, Lars-Peter Clausen wrote:
> The jacks are card level elements so use snd_soc_card_jack_new() instead =
of
> snd_soc_jack_new() to register them.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> =

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/omap/omap-abe-twl6040.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> =

> diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-=
twl6040.c
> index b9c65f1..0843a68 100644
> --- a/sound/soc/omap/omap-abe-twl6040.c
> +++ b/sound/soc/omap/omap-abe-twl6040.c
> @@ -182,17 +182,17 @@ static int omap_abe_twl6040_init(struct snd_soc_pcm=
_runtime *rtd)
>  =

>  	/* Headset jack detection only if it is supported */
>  	if (priv->jack_detection) {
> -		ret =3D snd_soc_jack_new(codec, "Headset Jack",
> -					SND_JACK_HEADSET, &hs_jack);
> +		ret =3D snd_soc_card_jack_new(rtd->card, "Headset Jack",
> +					    SND_JACK_HEADSET, &hs_jack,
> +					    hs_jack_pins,
> +					    ARRAY_SIZE(hs_jack_pins));
>  		if (ret)
>  			return ret;
>  =

> -		ret =3D snd_soc_jack_add_pins(&hs_jack, ARRAY_SIZE(hs_jack_pins),
> -					hs_jack_pins);
>  		twl6040_hs_jack_detect(codec, &hs_jack, SND_JACK_HEADSET);
>  	}
>  =

> -	return ret;
> +	return 0;
>  }
>  =

>  static const struct snd_soc_dapm_route dmic_audio_map[] =3D {
> =



-- =

P=E9ter
