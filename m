From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt1308: Add RT1308 amplifier driver
Date: Wed, 15 May 2019 17:14:29 +0100
Message-ID: <20190515161429.GH5613@sirena.org.uk>
References: <20190416153510.GE4834@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B8280116192E@RTITMBSVM07.realtek.com.tw>
 <20190417150518.GB5703@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B828011660AC@RTITEXDAG02.realtek.com.tw>
 <20190508064537.GN14916@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B82805B1144E@RTITMBSVM07.realtek.com.tw>
 <20190512080621.GH21483@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B82805B13EE2@RTITMBSVM07.realtek.com.tw>
 <20190513145608.GA5168@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B82805B14BFF@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1243662398697945326=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1FE6BF8078F
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2019 18:14:40 +0200 (CEST)
In-Reply-To: <BC6F7617C38F3E4E8CA887E07B35B82805B14BFF@RTITMBSVM07.realtek.com.tw>
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


--===============1243662398697945326==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fmEUq8M7S0s+Fl0V"
Content-Disposition: inline


--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2019 at 11:10:58AM +0000, Derek [=E6=96=B9=E5=BE=B7=E7=BE=
=A9] wrote:

> I could remove comment for the limit setting in register patch/init list
> to avoid users or integrators have any expectation.
> And also there will not be any support at all the driver according to the
> limit setting.

It's better to have a comment than not have one, I think I'd be happier
if I understood what was actually being limited here - that might make
it clear why it's not system specific which is what's concerning me.

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzcOuQACgkQJNaLcl1U
h9DWAwf/ciMiFcz1L/yJG1WiGBUz97OFAkA6T4gEaKXBPFk6Eeqq3p+EZOBivc3e
he+ivbc5nDda/iSLN4bbgGKfTxoOImo4XL8CrXoI/1FzOl+N0IuvdSgiL9eXfr2V
9jMGOeEmxKarAxKhqg2vupkZNpYfUT54YxsQ571cYc6ekRTjMUTCvi0xMNwguwx3
J/UOIe8I8DcPDCWxz4veJS+vTXfr89n7PlGqA9MJgeZR6OjV1yHrkyYWKcAY8l3B
hzwGcR7A85DLTXvXo6FIHBD/gY68nJY1h2oTvnguUCYXJc2CX820YDiTaY3zjlk+
YRHPX/aVzIgLnl7M+zBoQlCG3wrYpg==
=U5Xu
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--

--===============1243662398697945326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1243662398697945326==--
