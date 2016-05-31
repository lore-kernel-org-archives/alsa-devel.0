From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: ak4642: Implement suspend callback
Date: Tue, 31 May 2016 13:35:48 +0300
Message-ID: <fee23cb9-67ff-6c00-ba82-8b41621bdd03@ti.com>
References: <20160531101430.14396-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [198.47.19.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 83875266716
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 12:35:53 +0200 (CEST)
In-Reply-To: <20160531101430.14396-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

Mark,

On 05/31/16 13:14, Peter Ujfalusi wrote:
> Add the suspend callback to accompany the existing resume operation.
> With the suspend/resume callbacks the regmap (regcache) state handling can
> follow the recommended sequence.

Please ignore this patch. I have sent v2 which will take the suspend callba=
ck
into use.

-- =

P=E9ter

> =

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  sound/soc/codecs/ak4642.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> =

> diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
> index 4d8b9e49e8d6..ca9e82568b3c 100644
> --- a/sound/soc/codecs/ak4642.c
> +++ b/sound/soc/codecs/ak4642.c
> @@ -523,15 +523,23 @@ static struct snd_soc_dai_driver ak4642_dai =3D {
>  	.symmetric_rates =3D 1,
>  };
>  =

> -static int ak4642_resume(struct snd_soc_codec *codec)
> +static int ak4642_suspend(struct snd_soc_codec *codec)
>  {
>  	struct regmap *regmap =3D dev_get_regmap(codec->dev, NULL);
>  =

> +	regcache_cache_only(regmap, true);
>  	regcache_mark_dirty(regmap);
> -	regcache_sync(regmap);
>  	return 0;
>  }
>  =

> +static int ak4642_resume(struct snd_soc_codec *codec)
> +{
> +	struct regmap *regmap =3D dev_get_regmap(codec->dev, NULL);
> +
> +	regcache_cache_only(regmap, false);
> +	regcache_sync(regmap);
> +	return 0;
> +}
>  static int ak4642_probe(struct snd_soc_codec *codec)
>  {
>  	struct ak4642_priv *priv =3D snd_soc_codec_get_drvdata(codec);
> =
