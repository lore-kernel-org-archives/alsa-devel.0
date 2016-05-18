From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH v2 1/1] ASoC: core: Do not print an actual
 error when deferring probe
Date: Wed, 18 May 2016 17:10:04 +0200
Message-ID: <alpine.DEB.2.02.1605181708570.17593@lnxricardw1.se.axis.com>
References: <1463584020-6085-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 1587326058D
 for <alsa-devel@alsa-project.org>; Wed, 18 May 2016 17:10:12 +0200 (CEST)
In-Reply-To: <1463584020-6085-1-git-send-email-alexander.stein@systec-electronic.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Wed, 18 May 2016, Alexander Stein wrote:

> In case there is no DAI (yet), do not print an error, this might happen
> a lot of times. Print a notice instead.
> =

> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
> Changes in v2:
> * Add addional change in soc_bind_aux_dev()

Acked-by: Ricard Wanderlof <ricardw@axis.com>

/Ricard

> =

>  sound/soc/soc-core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> =

> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index d2e62b15..ce5f835 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1001,7 +1001,7 @@ static int soc_bind_dai_link(struct snd_soc_card *c=
ard,
>  	cpu_dai_component.dai_name =3D dai_link->cpu_dai_name;
>  	rtd->cpu_dai =3D snd_soc_find_dai(&cpu_dai_component);
>  	if (!rtd->cpu_dai) {
> -		dev_err(card->dev, "ASoC: CPU DAI %s not registered\n",
> +		dev_notice(card->dev, "ASoC: CPU DAI %s not registered\n",
>  			dai_link->cpu_dai_name);
>  		goto _err_defer;
>  	}
> @@ -1013,7 +1013,7 @@ static int soc_bind_dai_link(struct snd_soc_card *c=
ard,
>  	for (i =3D 0; i < rtd->num_codecs; i++) {
>  		codec_dais[i] =3D snd_soc_find_dai(&codecs[i]);
>  		if (!codec_dais[i]) {
> -			dev_err(card->dev, "ASoC: CODEC DAI %s not registered\n",
> +			dev_notice(card->dev, "ASoC: CODEC DAI %s not registered\n",
>  				codecs[i].dai_name);
>  			goto _err_defer;
>  		}
> @@ -1042,7 +1042,7 @@ static int soc_bind_dai_link(struct snd_soc_card *c=
ard,
>  		rtd->platform =3D platform;
>  	}
>  	if (!rtd->platform) {
> -		dev_err(card->dev, "ASoC: platform %s not registered\n",
> +		dev_notice(card->dev, "ASoC: platform %s not registered\n",
>  			dai_link->platform_name);
>  		return -EPROBE_DEFER;
>  	}
> @@ -1698,7 +1698,7 @@ static int soc_bind_aux_dev(struct snd_soc_card *ca=
rd, int num)
>  	return 0;
>  =

>  err_defer:
> -	dev_err(card->dev, "ASoC: %s not registered\n", name);
> +	dev_notice(card->dev, "ASoC: %s not registered\n", name);
>  	return -EPROBE_DEFER;
>  }
>  =

> -- =

> 2.7.3
> =

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> =


-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
