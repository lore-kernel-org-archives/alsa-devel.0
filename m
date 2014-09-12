From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: simple-card: tidyup use priv in
	parameter
Date: Fri, 12 Sep 2014 14:59:57 +0100
Message-ID: <20140912135957.GY7960@sirena.org.uk>
References: <871trkytuv.wl%kuninori.morimoto.gx@gmail.com>
 <87zje8xf8d.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8621282257272825986=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DC7F261A5E
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 17:39:13 +0200 (CEST)
In-Reply-To: <87zje8xf8d.wl%kuninori.morimoto.gx@gmail.com>
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


--===============8621282257272825986==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t3Rhqlz/9+3FgEet"
Content-Disposition: inline


--t3Rhqlz/9+3FgEet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2014 at 09:37:57PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> priv has many information about simple-card driver.
> Using it becomes easy to extend feature.
> This patch gets dev from priv as 1st step

Applied, thanks.

--t3Rhqlz/9+3FgEet
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUEvxcAAoJECTWi3JdVIfQXp0H/3FEjbUgf6XVKq8vxzbOHjEd
2YPFnJ/tTFlQDEqpTkaXat1Mh5+VtPyyA6iRVzNtkXAge2OTMDIt59+1CNYeT0VI
7VxQPUzgGa6MbqaAt8NpAlk6jp+MupEP/rS21Hblg+H81dHFz8E1hrVd8bLMq06o
CO5yn33/ABNHpWaqA7z8eDDvNS0VCVbBlPqO+BZiyzGiiW1S3jeNZIjbL6hqkmW3
q5ZvaMghNBLaQujzXIqzHoVcChwSUlRaYNJLO1O7k2XDyIwMDjX9rStBK2Dy+KdA
dPteTuHS5/cX80GA3CRQC+83nsq7R7ztgoxK/Ko0yp5UQV8akOR09vUQh4EwUDs=
=VjrJ
-----END PGP SIGNATURE-----

--t3Rhqlz/9+3FgEet--

--===============8621282257272825986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8621282257272825986==--
