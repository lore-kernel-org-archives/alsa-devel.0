From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: fsi: Deletion of unnecessary checks before the
 function call "clk_disable"
Date: Wed, 3 Dec 2014 18:29:18 +0000
Message-ID: <20141203182918.GH7712@sirena.org.uk>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <547DC19B.5080302@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4A79KfPqnT9qCbac"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <547DC19B.5080302@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: alsa-devel@alsa-project.org


--4A79KfPqnT9qCbac
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2014 at 02:41:47PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 2 Dec 2014 14:34:30 +0100
>=20
> The clk_disable() function tests whether its argument is NULL and then
> returns immediately. Thus the test around the call is not needed.

Applied, thanks.

--4A79KfPqnT9qCbac
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUf1Z9AAoJECTWi3JdVIfQuJwH/ikDBQtMU7vue/j0KBYF+E5D
ETRJtPZTvAqYxBT2qAQ21xW/gtrP+HKNrkHIVm8+z/cWIl8+u1Tc1cHP+M/5FxPf
ezb0c1Eu/W7GgY/86+n8o/p/DzkMadUKCwmj3aD2/WyPZMHEtNnRQqahixaC8LJB
45+0ETFvnmseetn2kn4qcZiDTwrrndaF+ILKmflhktRKs7YMSz30nPV0bJu7Navo
+bIRQhwJHMBkvrtOxQNYbGV+Ag+OSGni7TbkLbsqp8xkA1FownW3mcxMKjdDm0M4
YRaIyM9nRUYPF2O8t9o4MHxFTWXNYOJeqVnY2MUZf2h+3Ni/MQcAslLyxJOVQhM=
=oX5d
-----END PGP SIGNATURE-----

--4A79KfPqnT9qCbac--
