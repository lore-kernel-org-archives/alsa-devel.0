From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: ak4642: Enable cache usage to fix crashes on resume
Date: Thu, 19 May 2016 09:33:15 +0300
Message-ID: <52f206d4-ea9d-0cfc-613a-c625298cb9b2@ti.com>
References: <1463593762-31871-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1463593762-31871-1-git-send-email-broonie@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 05/18/16 20:49, Mark Brown wrote:
> The ak4642 driver is using a regmap cache sync to restore the
> configuration of the chip on resume but (as Peter observed) does not
> actually define a register cache which means that the resume is never
> going to work and we trigger asserts in regmap.  Fix this by enabling
> caching.

Should the ak4642 implement the suspend callback and:

static int ak4642_suspend(struct snd_soc_codec *codec)
{
	struct regmap *regmap =3D dev_get_regmap(codec->dev, NULL);

	regcache_cache_only(regmap, true);
	regcache_mark_dirty(regmap);
	return 0;
}

static int ak4642_resume(struct snd_soc_codec *codec)
{
	struct regmap *regmap =3D dev_get_regmap(codec->dev, NULL);

	regcache_cache_only(regmap, false);
	regcache_sync(regmap);
	return 0;
}

I know it is highly unlikely that anything is going to be written to th=
e chip
while the board is suspended. Probably the suspend and changing the cac=
he only
is not needed, but in this way things look a bit more complete?

>=20
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  sound/soc/codecs/ak4642.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
> index 1ee8506c06c7..4d8b9e49e8d6 100644
> --- a/sound/soc/codecs/ak4642.c
> +++ b/sound/soc/codecs/ak4642.c
> @@ -560,6 +560,7 @@ static const struct regmap_config ak4642_regmap =3D=
 {
>  	.max_register		=3D FIL1_3,
>  	.reg_defaults		=3D ak4642_reg,
>  	.num_reg_defaults	=3D NUM_AK4642_REG_DEFAULTS,
> +	.cache_type		=3D REGCACHE_RBTREE,
>  };
> =20
>  static const struct regmap_config ak4643_regmap =3D {
> @@ -568,6 +569,7 @@ static const struct regmap_config ak4643_regmap =3D=
 {
>  	.max_register		=3D SPK_MS,
>  	.reg_defaults		=3D ak4643_reg,
>  	.num_reg_defaults	=3D ARRAY_SIZE(ak4643_reg),
> +	.cache_type		=3D REGCACHE_RBTREE,
>  };
> =20
>  static const struct regmap_config ak4648_regmap =3D {
> @@ -576,6 +578,7 @@ static const struct regmap_config ak4648_regmap =3D=
 {
>  	.max_register		=3D EQ_FBEQE,
>  	.reg_defaults		=3D ak4648_reg,
>  	.num_reg_defaults	=3D ARRAY_SIZE(ak4648_reg),
> +	.cache_type		=3D REGCACHE_RBTREE,
>  };
> =20
>  static const struct ak4642_drvdata ak4642_drvdata =3D {
>=20


--=20
P=E9ter
