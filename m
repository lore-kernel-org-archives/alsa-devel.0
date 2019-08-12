From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ti: davinci-mcasp: Protect hw_params
 callback against race
Date: Mon, 12 Aug 2019 12:13:33 +0100
Message-ID: <20190812111332.GH4592@sirena.co.uk>
References: <20190812095304.19030-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3775704410407984283=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D140F8015B
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 13:13:34 +0200 (CEST)
In-Reply-To: <20190812095304.19030-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, jsarha@ti.com, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org


--===============3775704410407984283==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Content-Disposition: inline


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 12:53:04PM +0300, Peter Ujfalusi wrote:
> If the playback and capture of the same McASP is connected to different
> dai link (non duplex PCM links, like with pcm3168a codec) then there is
> a high probability of race between the two direction leaving McASP in a
> confused state.
>=20
> Protect the hw_params() with a mutex to make sure that this is not
> happening.

This feels like something we might want to consider moving up to the
core, though not every device is going to need it I guess it should be
safe to do there.

--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1RSdwACgkQJNaLcl1U
h9DA+gf/bMC64Dq2nCK79Dd1Sy4iBc3VB10pEy2bk+IuXac7Cvy6M+Mm5p1Vj2FE
yNhh1y/8K2RUHgahrXqC1zXAHqpQ9r+HAaqIwJEStE5aaDmWEUdkCYe7ACxe3i7g
ZqMdzX5jlM30+uaKNceo/GuzZlsqFUv/1Kgo6zm5AiDZWDf72DSGePMFu0QY9Vtn
tffPUx+lDzo6fRGZYHVVoCwChtw4td0GJ7VclATNFh2nJfT636Y/WKSnuiEXUM09
f2JEp14d0k0kG3WjCtcvHiEPGsD1phd75widA7AzR1PIa6jR9FJGCR4UckbFd+Lo
S9RcHHOied+m6iy7QMMxdau0TnTuKQ==
=yHpV
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--

--===============3775704410407984283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3775704410407984283==--
