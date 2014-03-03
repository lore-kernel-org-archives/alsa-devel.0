From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/19] ASoC: rsnd: run rsnd_path_init()
 when probe() timing
Date: Mon, 3 Mar 2014 10:22:01 +0900
Message-ID: <20140303012201.GH2411@sirena.org.uk>
References: <87d2ib90t9.wl%kuninori.morimoto.gx@gmail.com>
 <871tyr90qe.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4083249720916221146=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 880032654D4
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 02:59:27 +0100 (CET)
In-Reply-To: <871tyr90qe.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============4083249720916221146==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZYOWEO2dMm2Af3e3"
Content-Disposition: inline


--ZYOWEO2dMm2Af3e3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2014 at 10:15:40PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current rsnd SSIU/SSI/SCU/SRU path is set
> when playback/capture starts up.
> But it is meaningless method, since the path is based
> on platform and can be set in probe() timing.
> This patch sets the path on probe() timing.

This is fine but it depends on the set_sysclk() patch.

--ZYOWEO2dMm2Af3e3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE9k2AAoJELSic+t+oim9AzUQAIILAAieaLGpuf0P5TzuVme9
CNXaBHqbY2bOTF3RoX94/QT3VsYNv9zRl5pE60POBKNW8PcaDBaEA37jz/e/aaaH
qXdiaXrytCto5yUd8SlSlF36xXNeDrIvMN2vGS3vX2DPHUjV2qKqIS2yiax3QOT+
ClZkOmutC6epfVHt8fUiCpF35jrgRmqRL12SkwiJstWZ6FEkxESPPqYaugSucy4E
lfOLt3WPvB+HuYwOjmWSaihCM/thNAFAJbu9K8rcUFd51NPTu1gMJCaIVWL9lpgs
Vl08r1i4+FylSOMNxBXUZb9p4uDU88vabmn+5/iV0IOSweGYSv7mNWI9Yr7uW0T4
aQtxxoLWMJANn5emI5N6q2uZvmnqeqxHXfBG5jLFya/bKEczW+uOj8376uYgK09T
HEUbCgS7WOdf4U4xEtVR4PcR+CtqF5ubHi6U0tJvQn1GcB3TYG2N+X18pSLT0jzU
iaVBDp6GrOHuzhrA/b/0KLFeZBqFLGTl2FQiEkXPO3uy8+2iGKmjXVvaeuF6l4oG
1O26TJ4sp30VuzPuT5HCWZuadBFX+xJkInXZnGOVpcVJXj7644UoUV/9vVCEtypq
Wcus4dxCpPUYCp5/FmVb+xsXxDlw+qWxOuLw+0lVhH9FDzbWZWlGU1XHCocRJIZs
dZ5bx+ZJ8LLIBIUyEycN
=CRmR
-----END PGP SIGNATURE-----

--ZYOWEO2dMm2Af3e3--

--===============4083249720916221146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4083249720916221146==--
