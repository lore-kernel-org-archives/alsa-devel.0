From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 04/12] ASoC: omap-abe-twl6040: Register
 machine level DMIC DAPM routes with the card
Date: Thu, 13 Mar 2014 12:06:42 +0200
Message-ID: <53218332.5050200@ti.com>
References: <1394634460-15889-1-git-send-email-lars@metafoo.de>
 <1394634460-15889-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A87826513F
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 11:06:48 +0100 (CET)
In-Reply-To: <1394634460-15889-5-git-send-email-lars@metafoo.de>
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

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> =

> ---
> Changes since v1:
> 	* Only register DMIC DAPM routes with the card, do not join the two rout=
es
> 	  tables into one.
> ---
>  sound/soc/omap/omap-abe-twl6040.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> =

> diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-=
twl6040.c
> index ebb1390..024dafc 100644
> --- a/sound/soc/omap/omap-abe-twl6040.c
> +++ b/sound/soc/omap/omap-abe-twl6040.c
> @@ -203,8 +203,7 @@ static const struct snd_soc_dapm_route dmic_audio_map=
[] =3D {
>  =

>  static int omap_abe_dmic_init(struct snd_soc_pcm_runtime *rtd)
>  {
> -	struct snd_soc_codec *codec =3D rtd->codec;
> -	struct snd_soc_dapm_context *dapm =3D &codec->dapm;
> +	struct snd_soc_dapm_context *dapm =3D &rtd->card->dapm;
>  =

>  	return snd_soc_dapm_add_routes(dapm, dmic_audio_map,
>  				ARRAY_SIZE(dmic_audio_map));
> =



-- =

P=E9ter
