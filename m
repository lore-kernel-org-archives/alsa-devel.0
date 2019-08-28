From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt1011: ADCDAT pin config
	modification
Date: Wed, 28 Aug 2019 14:20:55 +0100
Message-ID: <20190828132055.GJ4298@sirena.co.uk>
References: <20190826090120.1937-1-shumingf@realtek.com>
 <20190828104938.GF4298@sirena.co.uk>
 <10317AB43303BA4884D7AF9C2EBCFF4002BE5727@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2860059883289927343=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2BCF4F89799
 for <alsa-devel@alsa-project.org>; Wed, 28 Aug 2019 15:21:02 +0200 (CEST)
In-Reply-To: <10317AB43303BA4884D7AF9C2EBCFF4002BE5727@RTITMBSVM07.realtek.com.tw>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "cychiang@google.com" <cychiang@google.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>, "sathya.prakash.m.r@intel.com" <sathya.prakash.m.r@intel.com>, "Flove(HsinFu)" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============2860059883289927343==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z8yxTSU1mh2gsre7"
Content-Disposition: inline


--Z8yxTSU1mh2gsre7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 11:01:21AM +0000, Shuming [=E8=8C=83=E6=9B=B8=E9=8A=
=98] wrote:

> > > ADCDAT pin config sets to output mode in default.
> > > And the driver creates the kcontrol to control ADCDAT pin configurati=
on.

> > Why would this change at runtime?  I'd expect this to be controlled by =
the
> > machine driver or a DT property.

> It will not change at runtime in the normal case.=20
> I think we may use it to test the feedback signal in factory mode.

So really this is setting up a loopback for testing?

--Z8yxTSU1mh2gsre7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1mf7YACgkQJNaLcl1U
h9AAUQgAg5xHDGKt0DtfDS8tjGMoAByXdpxEe61RBJPMNK98EIXTfiwKCU/Wdc3N
YFuhedwoV7rztRcJ/uPLoQPzxbMGOqNeEYf4NQDTSl4i23m9WwXxqd4wW9alD35k
AZRup6xUJ4rgle7hstf2EmyQgxCoyZdX9xsY1gg6oAwUddp3RfO9X5ARWKJ0l302
iP4TWnpQOUkigIwEgTBqvDSQRF3hwsW+C6elmVfzH17wf3sjGxctqosIGAaqWlhK
u4Qu8z1roX5xI4vxi3XSDoJipu2+gOn4zTmJP2aEIGSvsnuV9I7d62gqnVe/BV3Z
GPcKEuWPOtGnuGbijBcI2h2upr0Fsg==
=mpI1
-----END PGP SIGNATURE-----

--Z8yxTSU1mh2gsre7--

--===============2860059883289927343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2860059883289927343==--
