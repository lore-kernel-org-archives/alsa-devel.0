From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/3] ASoC: omap-abe-twl6040: No need to
 register DMIC routes seperatly
Date: Mon, 10 Mar 2014 10:13:27 +0200
Message-ID: <531D7427.5020006@ti.com>
References: <1394302616-15991-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EC0D264F29
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 09:13:33 +0100 (CET)
In-Reply-To: <1394302616-15991-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Grazvydas Ignotas <notasas@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 03/08/2014 08:16 PM, Lars-Peter Clausen wrote:
> When using table based DAPM setup there is no need to register DAPM eleme=
nts for
> different sub-components separately. The widgets will be registered befor=
e the
> first sub-component is initialized, the routes are only added after the l=
ast
> sub-component has been initialized, meaning everything will be available =
when it
> is needed.

The reason why we add the DMIC routes in the way we do is that not all boar=
ds
have DMIC in use. PandaBoards does not have DMIC while SDP/Blaze have. On
PandaBoard we do not register the dmic dai link so the widgets are not going
to be added and also the dmic DAI and codec will be not loaded on PandaBoar=
ds.
I think this will cause some warning because of missing "DMic" widget?

-- =

P=E9ter

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/omap/omap-abe-twl6040.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
> =

> diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-=
twl6040.c
> index ebb1390..5011bfa 100644
> --- a/sound/soc/omap/omap-abe-twl6040.c
> +++ b/sound/soc/omap/omap-abe-twl6040.c
> @@ -163,6 +163,10 @@ static const struct snd_soc_dapm_route audio_map[] =
=3D {
>  =

>  	{"AFML", NULL, "Line In"},
>  	{"AFMR", NULL, "Line In"},
> +
> +	/* DMIC routing */
> +	{"DMic", NULL, "Digital Mic"},
> +	{"Digital Mic", NULL, "Digital Mic1 Bias"},
>  };
>  =

>  static int omap_abe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
> @@ -196,20 +200,6 @@ static int omap_abe_twl6040_init(struct snd_soc_pcm_=
runtime *rtd)
>  	return ret;
>  }
>  =

> -static const struct snd_soc_dapm_route dmic_audio_map[] =3D {
> -	{"DMic", NULL, "Digital Mic"},
> -	{"Digital Mic", NULL, "Digital Mic1 Bias"},
> -};
> -
> -static int omap_abe_dmic_init(struct snd_soc_pcm_runtime *rtd)
> -{
> -	struct snd_soc_codec *codec =3D rtd->codec;
> -	struct snd_soc_dapm_context *dapm =3D &codec->dapm;
> -
> -	return snd_soc_dapm_add_routes(dapm, dmic_audio_map,
> -				ARRAY_SIZE(dmic_audio_map));
> -}
> -
>  /* Digital audio interface glue - connects codec <--> CPU */
>  static struct snd_soc_dai_link abe_twl6040_dai_links[] =3D {
>  	{
> @@ -229,7 +219,6 @@ static struct snd_soc_dai_link abe_twl6040_dai_links[=
] =3D {
>  		.codec_dai_name =3D "dmic-hifi",
>  		.platform_name =3D "omap-pcm-audio",
>  		.codec_name =3D "dmic-codec",
> -		.init =3D omap_abe_dmic_init,
>  		.ops =3D &omap_abe_dmic_ops,
>  	},
>  };
> =
