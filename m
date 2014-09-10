From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: Set cbj_en for ACPI devices
Date: Wed, 10 Sep 2014 11:00:34 +0100
Message-ID: <20140910100034.GP2601@sirena.org.uk>
References: <1410313233-585-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0960593377239676457=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A2D9226072A
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 12:00:57 +0200 (CEST)
In-Reply-To: <1410313233-585-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============0960593377239676457==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="smGLzx5R1ODwI3sT"
Content-Disposition: inline


--smGLzx5R1ODwI3sT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2014 at 09:40:33AM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> This patch set cbj_en value for ACPI devices.

> +/* list of devices using jack combo mode */
> +static struct rt286_acpi_jack rt286_jack_combo[] =3D {
> +	{ "INT343A", true },
> +	{},
> +};

I'm having a hard time believing that all devices ever used in an ACPI
system will have the board configured like this...

--smGLzx5R1ODwI3sT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUECFCAAoJECTWi3JdVIfQidMH/0dweCURctsiYqi2OmgOCxIw
AeeBNq8cCMly7+dz5GzN3tPeqwb+7nbb7pDXX7L3Wy38LPvrMnX6bH30GOt16xtG
YJGZysYm9vDetx2YOkqNnb0SWqUiwE+0u7cgmxTVnTb3vwgw01tDmRbKgPkaobH3
XVvKsYq6aR0XQdOntG6RrojFEEWhWGMD6Z3cknYR/qh1pv1Dy6vwpVWRcNDrky8x
sZoD6E4JXzyV6OQmJivqCFBpiaFQFIkYTitQYZ5hnkr/u+WRYHRBo3B4xUjRjO24
pqzxxqoTsLFG01qhekZTfTPWi7tyRQlHPZ2311aZWQcFm5RNjvVy1tgk+Rr87jk=
=UvUt
-----END PGP SIGNATURE-----

--smGLzx5R1ODwI3sT--

--===============0960593377239676457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0960593377239676457==--
