From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add ak4613 support
Date: Mon, 14 Sep 2015 19:45:39 +0100
Message-ID: <20150914184539.GH12027@sirena.org.uk>
References: <87h9n2ok2d.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6961225954022746686=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FB552605FF
 for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2015 20:45:46 +0200 (CEST)
In-Reply-To: <87h9n2ok2d.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6961225954022746686==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="diIVIIxrmKUYJTDK"
Content-Disposition: inline


--diIVIIxrmKUYJTDK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2015 at 06:42:45AM +0000, Kuninori Morimoto wrote:

This looks basically good, a few minor comments below but nothing major:

> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -319,6 +319,10 @@ config SND_SOC_AK4535
>  config SND_SOC_AK4554
>  	tristate "AKM AK4554 CODEC"
> =20
> +config SND_SOC_AK4613
> +	tristate "AKM AK4613 CODEC"
> +	depends on I2C
> +
>  config SND_SOC_AK4641
>  	tristate
> =20

You should also add this to SND_SOC_ALL_CODECS.

> +static inline void ak4613_write(struct snd_soc_codec *codec, unsigned in=
t reg,
> +				unsigned int val)
> +{
> +	struct device *dev =3D codec->dev;
> +
> +	dev_dbg(dev, "reg %02x w %02x\n", reg, val);
> +	snd_soc_write(codec, reg, val);
> +}

Please just use snd_soc_write() natively - there's a lot of trace
support in regmap already which really should be adequate.  If it's not
then we need to review and improve that rather than open coding in
drivers.

> +	spin_lock_irqsave(&priv->lock, flags);
> +	if ((NO_FMT   =3D=3D priv->fmt_ctrl) ||

Can this spinlock just be a mutex?

> +static int ak4613_resume(struct snd_soc_codec *codec)
> +{
> +	struct regmap *regmap =3D dev_get_regmap(codec->dev, NULL);
> +
> +	regcache_mark_dirty(regmap);
> +	regcache_sync(regmap);

You should really check errors here.

--diIVIIxrmKUYJTDK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV9xXSAAoJECTWi3JdVIfQA8AH/iJD+r38+JQPrgWVTNLUIxUq
84iU2GH/hIX0cGScix7t/isIbiGsLu7f+kvozyzkSpeGZGSa980WaBWPcZBpMk5Y
zxKOwgKhKooVmFZGaoRv4j5Dgxe7ABpScr7BTpoX5JGVKQwbP94AqWjY/zz3eHUM
Y212/FMhy7MOSHr8I9c6jr6kqBbzDOB1vM0D4DkjNIMM+E+8FLv78G5qxA+zXPBR
WZFYz34/1DKcw4lftGXGts+1h3yk25NkHGCaA2j5htmy0pcYA988QFB5pnmoh9Hq
RkwDl5RWbNROygdD0CHSYB8af0ffESRh+y1CLL735IgoKCQj70vtwvEP9RxTM4o=
=TD0H
-----END PGP SIGNATURE-----

--diIVIIxrmKUYJTDK--

--===============6961225954022746686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6961225954022746686==--
