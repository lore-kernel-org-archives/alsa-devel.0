From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: alc5632: fix uninit var in
	alc5632_probe()
Date: Tue, 1 Apr 2014 12:40:05 +0100
Message-ID: <20140401114005.GM2269@sirena.org.uk>
References: <1396290324-6334-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1746172829203279476=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0819F2652B9
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 13:40:23 +0200 (CEST)
In-Reply-To: <1396290324-6334-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1746172829203279476==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hsRx9nTMbkea5ZWm"
Content-Disposition: inline


--hsRx9nTMbkea5ZWm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2014 at 12:25:24PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> alc5632_probe() returns ret, yet it is not initialized or set anywhere.
> This ends up causing the function to appear to fail, and audio not to
> work on the Toshiba AC100, with my compiler at least.

Applied, thanks.

--hsRx9nTMbkea5ZWm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOqWSAAoJELSic+t+oim9tKUP/0XjmTcrS+XKCMEXzaIO+YRK
GoKiHN2U+BaNzid3GkGy1ntI0WYK/0iYUkwfZC3dIdzYHQafD4/w/RZ47xAo104z
pF5muj9vC3Zv6kcdnU/VHmVeU2k3MIbT9RDuHz0Ky3nMHpv5Z7uPpJLV4HNb/u6C
5f8Mj0zLO3DE4KF2Yqi44gJPHLZkE9N9eevul518GOB3287inupiDyv/RnFN6gF5
JlkuiePPOmBF2YTaVdPPchVU9x7ORgXf0UleOYOgx6er+xwL9mt9I+tbRqe6bxdT
3c4xohe1wzlLrLEV+xIH5hIbbYZ7Cc7dW59iKdSmdgORknFlmL/hoXGDnOTnBEAy
q9c2Y92AilMarDrJhr/XzlYXYcBcHb7rdLte9E7CTDyl8ZaSi5krT1TFTqYhWmyv
y3EZs+mU3LGeTgktLN+JPDkzaFNnuhAsMaHa7NpMW5jcDlcmWK+Wc/2QImQxNPlV
hZxd/0sQFCyFiQ5GRxc6HrogyUoz16mcfEhu8F6FzocYYOo6RIUENRD86IelVF9i
aVVaijnEZZNMrJ2kg0j7YHwV7BjO7aeXmFINtFdqbHKnuOUmXZiUcuyrMGhIiugW
tsKfdcdX++fmPtpWawf4VXOO9FcsPAdssbzRBbyFIO+4Bmp8mNMI1gdtPtUuZ5HV
/F2851Ks2oDs25Xi29uw
=gF0b
-----END PGP SIGNATURE-----

--hsRx9nTMbkea5ZWm--

--===============1746172829203279476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1746172829203279476==--
