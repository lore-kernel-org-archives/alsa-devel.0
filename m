From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Fix mono
Date: Wed, 30 Jan 2013 10:11:45 +0800
Message-ID: <20130130021143.GC4945@opensource.wolfsonmicro.com>
References: <1359134360-25482-1-git-send-email-benoit.thebaudeau@advansee.com>
 <20130126085512.GC30594@opensource.wolfsonmicro.com>
 <1343658253.242147.1359209821129.JavaMail.root@advansee.com>
 <20130127025844.GC4650@opensource.wolfsonmicro.com>
 <1064296906.226931.1359407020092.JavaMail.root@advansee.com>
 <20130129020128.GE4748@opensource.wolfsonmicro.com>
 <832331151.478537.1359492018900.JavaMail.root@advansee.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6325495395304410142=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 59AAD2616C7
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2013 03:11:52 +0100 (CET)
In-Reply-To: <832331151.478537.1359492018900.JavaMail.root@advansee.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit.thebaudeau@advansee.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6325495395304410142==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2013 at 09:40:18PM +0100, Beno=EEt Th=E9baudeau wrote:
> On Tuesday, January 29, 2013 3:01:32 AM, Mark Brown wrote:

> > Why are you having to call this in the first place?

> For I=B2S, because the reference manual of the i.MX25 says that SSI.STCCR=
=2EDC
> should be set to 1 (i.e. 2 channels) in this mode. This also allowed to t=
est
> several settings for mono.

> For DSP modes, because stereo doesn't work without this call (right chann=
el
> missing).

So why does the driver not just do this automatically?

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRCIFTAAoJELSic+t+oim94PUP/ie7Nm+DbApbwzLXw2CHng6W
0iaP3kP1Al2/yVoUu4XfLS/P01zzmmqLRCuQS0UoJo9lNnE1BpnUikHTyfrm+0w+
yfLGgvUbPBMb15djCJrWkrDN6LUhe8JUtayszpkrdDtq9LYSd7BkU5um6JkvjUHa
+G590cS/Fg5d8Cw2v+6vka9+sqhjpkshOnEkSykpYny8bQVXj05nAW1yzdxz3j1X
6RG8G67utakFjpLRsQY0wOjce1DxK4Sj2l7ecTLwBsFZbtw6ZVegHiMoHhWsJvza
66zPvZxBNx5fri6UAzOenrdVNhjVnbjoCnJ7WArxc3NNkOWqZz+WsuYf5LRSzSZM
Ws5KEJ1euPnLLx2Hdx9q8mn1ivJ9Ux1Li8dk/CJ7uJN6naMBkvZSF8N6HzP/3gXU
9m5jNAyDdZyJbzhnFl7rtffsyQg/KLMP4SG/4gODXfB6N7l5ZE1uxAXFgRtyeJ1f
q+ooeuqMOS4wSJB5r6AbwHRwnE8TqXt18hJBg2WZ+JPrSgwK699pnqN/gT5g5oZU
+wNVoJR5s1OODszMPlHtoVPtE6z9M3U57uonXEY5DAEH9Dxhnd6DnJrO1dkMFBej
W9iVcalFfeoeRAkkU/p9b+hDEg/LO43mPfOu7tQFvy0dXw2dThn2569XBKnwMeug
oXPBcxHB6BsKO78nO+H4
=L6CG
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--

--===============6325495395304410142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6325495395304410142==--
