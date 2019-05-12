From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt1308: Add RT1308 amplifier driver
Date: Sun, 12 May 2019 17:06:21 +0900
Message-ID: <20190512080621.GH21483@sirena.org.uk>
References: <20190416022246.10121-1-derek.fang@realtek.com>
 <20190416153510.GE4834@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B8280116192E@RTITMBSVM07.realtek.com.tw>
 <20190417150518.GB5703@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B828011660AC@RTITEXDAG02.realtek.com.tw>
 <20190508064537.GN14916@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B82805B1144E@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4697363309510714797=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 304A1F896CB
 for <alsa-devel@alsa-project.org>; Sun, 12 May 2019 19:05:44 +0200 (CEST)
In-Reply-To: <BC6F7617C38F3E4E8CA887E07B35B82805B1144E@RTITMBSVM07.realtek.com.tw>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Albert Chen <albertchen@realtek.com>, "bard.liao@intel.com" <bard.liao@intel.com>, Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>, "Flove(HsinFu)" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============4697363309510714797==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zq44+AAfm4giZpo5"
Content-Disposition: inline


--zq44+AAfm4giZpo5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2019 at 01:17:54PM +0000, Derek [=E6=96=B9=E5=BE=B7=E7=BE=
=A9] wrote:

> > The maximum volume can be limited with snd_soc_limit_volume() but if the
> >  limit is for the speaker then that's machine dependent anyway.

> The maximum volume setting is temporarily not machine dependent.
> It avoids harming if any machine doesn't set the limit volume.

I'm confused about what this limit is - is it just some arbatrary limit
imposed in case some board has problems or is it an actual limit that
comes from the chip?  If it's a "just in case" limit then the board
should be the one doing the limiting, yes people can break things but
it's difficult to get decision like that done sensibly in the CODEC
driver in a way that works for everything and the general expectation is
that this is all for use by system integrators rather than end users.

--zq44+AAfm4giZpo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzX0/0ACgkQJNaLcl1U
h9CW9gf/dGgxm0Ei1luubjgk7yVXL/o4X6YxUmpuqM1XohgzC9RyjgR9lJ1Uybfq
TtzaF1Ebi3TBvcKsd7V9fgkJ+k+a1giGPFjYK7YjQnMXYzfQKEYgfzpJS2zz8kJL
GkyVJmSIVcwEO9I6uHZMsYaC0/NZAxakPxxCy4yCV4XSetzFllE4kU8HvDBHggf2
MaO7lvAYp6RTyGCNq7WAWUBKWyUF/W2/e2KbAdhQRL0Hs/YvvBYU3tLC4coUPeDD
EzfMVQqZNqnxnfmE31BDB5I3DeXoIb05tjMZJuTgKf4xXpPIO/KB0Y/MMchYE0Pb
lD/ESimbo9iI8dyd0ctbE7FphJuzig==
=rbXA
-----END PGP SIGNATURE-----

--zq44+AAfm4giZpo5--

--===============4697363309510714797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4697363309510714797==--
