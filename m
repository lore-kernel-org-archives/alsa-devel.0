From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8960: Let wm8960 codec driver
 manage its own MCLK
Date: Wed, 3 Dec 2014 12:41:24 +0000
Message-ID: <20141203124124.GW7712@sirena.org.uk>
References: <1417604438-28362-1-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9141780484170945062=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 331F426044E
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 13:41:49 +0100 (CET)
In-Reply-To: <1417604438-28362-1-git-send-email-b50113@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <b50113@freescale.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Li.Xiubo@freescale.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============9141780484170945062==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GP4Le6z6inNsfFpS"
Content-Disposition: inline


--GP4Le6z6inNsfFpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2014 at 07:00:38PM +0800, Zidan Wang wrote:

>  #include <sound/core.h>
> @@ -988,6 +990,8 @@ static void wm8960_set_pdata_from_of(struct i2c_clien=
t *i2c,
> =20
>  	if (of_property_read_bool(np, "wlf,shared-lrclk"))
>  		pdata->shared_lrclk =3D true;
> +
> +	pdata->mclk =3D devm_clk_get(&i2c->dev, NULL);

This isn't platform data then...  we also need to check the return code
here and handle at least probe deferral.

> +    /* Mark the mclk pointer to NULL if no mclk assigned */
> +	if (IS_ERR(wm8960->pdata.mclk)) {

Indentation is wrong for the comment here.

> +		/* But do not ignore the request for probe defer */
> +		if (PTR_ERR(wm8960->pdata.mclk) =3D=3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		wm8960->pdata.mclk =3D NULL;
> +	}

OK, so we are trying to handle probe deferral - but this should be next
to the clk_get().

> +	if (wm8960->pdata.mclk) {
> +		ret =3D clk_prepare_enable(wm8960->pdata.mclk);

Just continue to use !IS_ERR() - NULL is a valid clock.

> +static int wm8960_runtime_suspend(struct device *dev)
> +{
> +	struct wm8960_priv *wm8960 =3D dev_get_drvdata(dev);
> +
> +	/* Power down PLL to save power */
> +	regmap_update_bits(wm8960->regmap, WM8960_POWER2, 0x1, 0);

This isn't undone by the resume.

--GP4Le6z6inNsfFpS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfwTzAAoJECTWi3JdVIfQz7sH/jfmau9pbKLeuJLayh4Ejnvs
zvFcixhIk2fkZupvvnM4w4Ffcpv+pi+xmzLDQsOomDaN6dNaSLqa28x7EyM7li2u
ggtNnDrwDVg1Ypddx9TURseJTtAlwAE1sWjHnoPMttRqjvwsUzbUeZ3gWYgvZNG6
Huva8NJxoz9i/+OQpfBO+UqtK9esYrKQ6FdgpYuTIc2oLduJAv34HBiL+7r7sBhI
P+Iqw4iJL9TED21mCMqbN2lAk8qxP5XtUidtxBgOcItqye/b4uM7cezYzegMHJ8L
oqWYqI5+Pio5KvCaGpIDOeisjjS14269ci6Er9w4GHA7p5g+hyjpVTJutFVNC0s=
=2prM
-----END PGP SIGNATURE-----

--GP4Le6z6inNsfFpS--

--===============9141780484170945062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9141780484170945062==--
