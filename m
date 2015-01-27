From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/10] ASoC: sta32x: make sta32x a gpio
 consumer for the reset GPIO
Date: Tue, 27 Jan 2015 17:00:49 +0000
Message-ID: <20150127170049.GW21293@sirena.org.uk>
References: <1421881322-27806-1-git-send-email-niederp@physik.uni-kl.de>
 <1421881322-27806-3-git-send-email-niederp@physik.uni-kl.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5200966229784351206=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D9F7B2608EC
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 18:01:16 +0100 (CET)
In-Reply-To: <1421881322-27806-3-git-send-email-niederp@physik.uni-kl.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, brandau@gmx.de, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5200966229784351206==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4OdJeIrdWB8gmUCp"
Content-Disposition: inline


--4OdJeIrdWB8gmUCp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2015 at 12:01:54AM +0100, Thomas Niederpr=FCm wrote:

> +	/* GPIOs */
> +	sta32x->gpiod_nreset =3D devm_gpiod_get(dev, "reset");
> +	if (IS_ERR(sta32x->gpiod_nreset)) {
> +		ret =3D PTR_ERR(sta32x->gpiod_nreset);
> +		if (ret !=3D -ENOENT && ret !=3D -ENOSYS)
> +			return ret;
> +
> +		sta32x->gpiod_nreset =3D NULL;

I'll apply this but in general this pattern of replacing error pointers
with NULL is a bit suspect - if the way you test for failure is IS_ERR()
then just carry on using IS_ERR() all through the code to check if you
got something valid, it's less likely for GPIOs but most other things
can substitute in dummies and NULL can be a good way of specifying a
dummy.

--4OdJeIrdWB8gmUCp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUx8RAAAoJECTWi3JdVIfQsIoH/3BQIWbZMRPz2r5fzUfQGpMS
ppCy3TkQyN7qRdJadR1dhOp5pfZYQBQ7lr1QRBvtI9meGglR1ElRfhaUpIFlI46J
ZJPE2hgB+vC1wIhMge9xvr1bhPTjCZGhNEpWw3t3gKhhg9OWEzrggmRbExa/n9Sn
/G1TPT4TiVW3RpTDeZnefYrFeoCD5nYcH6weQV4CJTWa0NEFw1sZcP3qk8/MCIdl
GxE5zTtqSxeqL3i293lKzlJYKbw4E8ishBtdHc/N0RSpcPHo+Tc+7MNPELCFBYzD
W7ur0vz20NWdfWl2rzCqvuFozIXRNMEmPiDDpMx7QZ1wZROaqu9Me5lKYLImrLg=
=itni
-----END PGP SIGNATURE-----

--4OdJeIrdWB8gmUCp--

--===============5200966229784351206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5200966229784351206==--
