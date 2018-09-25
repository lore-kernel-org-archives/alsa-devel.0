From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] ASoC: max98088: Add master clock
	handling
Date: Tue, 25 Sep 2018 10:17:42 -0700
Message-ID: <20180925171742.GR20825@sirena.org.uk>
References: <20180925142352.24106-1-m.felsch@pengutronix.de>
 <20180925142352.24106-5-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7561775081676585360=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 52AB1267892
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2018 19:17:44 +0200 (CEST)
In-Reply-To: <20180925142352.24106-5-m.felsch@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, robh+dt@kernel.org, kernel@pengutronix.de, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Tushar Behera <tushar.behera@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============7561775081676585360==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ECF1u7dKBoUGhe3"
Content-Disposition: inline


--4ECF1u7dKBoUGhe3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 25, 2018 at 04:23:51PM +0200, Marco Felsch wrote:
> From: Andreas F=E4rber <afaerber@suse.de>
>=20
> If master clock is provided through device tree, then update
> the master clock frequency during set_sysclk.

This changelog suggests that the clock is optional...

> +	if (!IS_ERR(max98088->mclk)) {
> +		freq =3D clk_round_rate(max98088->mclk, freq);
> +		clk_set_rate(max98088->mclk, freq);
> +	}

=2E..as does much of the code (note BTw that this ignores errors setting
the clock)...

> +	max98088->mclk =3D devm_clk_get(&i2c->dev, "mclk");
> +	if (IS_ERR(max98088->mclk)) {
> +		if (PTR_ERR(max98088->mclk) =3D=3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		dev_err(&i2c->dev, "Invalid MCLK\n");
> +		return -EINVAL;
> +	}
> +

=2E..but the probe function makes it mandatory (and also throws away the
error code from clk_get() if it's not -EPROBE_DEFER).  Is this the best
choice?  It seems inconsistent anyway.

--4ECF1u7dKBoUGhe3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluqbbIACgkQJNaLcl1U
h9A7Cgf9HkpNDssCKNN1+YTvbfJBBBD8AJ4uBE75FPYe2WlviwNiXbyWpwejClYf
8ofteB7IwaG/lm6nHRKDHX+jvtSPkrecaqZk+Hx7Um+PXRtGGumePva+LQ3UPtda
+O6z/x4Xp/UV3ZYRY0SqZiCT6BXtq4LW2dt2v4LD0J1NY7cDZhIFoz8DQf3OQUzP
CEZy5JCnBi51tZvO9XOJC9R3ONv5W7masBOO2E2Dm2Z4RBevaweS6gqkfCOh+1lD
ye/mhT7F7uxvrupVxUwyzJwCpN20hB6VxgFLsZzkbHLB6KoUDgaC1193mlK2yIGy
4vhnqrMLIW0aUyhv7tZTiRYcPmnHaA==
=1tlo
-----END PGP SIGNATURE-----

--4ECF1u7dKBoUGhe3--

--===============7561775081676585360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7561775081676585360==--
