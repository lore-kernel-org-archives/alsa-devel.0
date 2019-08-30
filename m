From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt1011: ADCDAT pin config
	modification
Date: Fri, 30 Aug 2019 13:53:21 +0100
Message-ID: <20190830125321.GF5182@sirena.co.uk>
References: <20190826090120.1937-1-shumingf@realtek.com>
 <20190828104938.GF4298@sirena.co.uk>
 <10317AB43303BA4884D7AF9C2EBCFF4002BE5727@RTITMBSVM07.realtek.com.tw>
 <20190828132055.GJ4298@sirena.co.uk>
 <10317AB43303BA4884D7AF9C2EBCFF4002BE6083@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4170512778534190113=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F33C4F800E7
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 14:53:25 +0200 (CEST)
In-Reply-To: <10317AB43303BA4884D7AF9C2EBCFF4002BE6083@RTITMBSVM07.realtek.com.tw>
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


--===============4170512778534190113==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2019 at 05:54:00AM +0000, Shuming [=E8=8C=83=E6=9B=B8=E9=8A=
=98] wrote:

> > So really this is setting up a loopback for testing?

> We would not like to change ADCDAT pin to input mode in normal case.
> That's why the driver enables ADCDAT pin to the output mode in default.
> The rt1011 supports the feedback signal which could be playback data or I=
/V data, etc.
> If the system wants the AEC reference data, rt1011 could feedback the pla=
yback data.

> The product could connect 2/4/6/8 rt1011 chips on the same I2S bus.
> In a test or debug mode, we could toggle ADCDAT pin to input mode that al=
so
> helps HW engineer check the slot of feedback signal for each rt1011.

I think this needs more than just a straight userspace control on one
device, these use cases make sense but they'll need to be configured
over multiple chips simultaneously otherwise there's some possibility of
hardware damage (eg, if two chips try to drive the signal at the same
time).  If this really can be usefully varied at runtime then the driver
bit of this should probably be an API that the machine driver can call,
the machine driver can then expose a control that sets all the chips
involved up together.

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1pHEAACgkQJNaLcl1U
h9DD+Qf/ZTC6o5tnYajPcCGVYiHvdv33N3XUZHUDq0C1Z/u5tqV5ZBqqQLQ+yPpm
0CRv7X6cQDtpDgIahdj17+R+4QVQA9A9Fte2YWQ/VD4w/63hlDNE6pEdTT5k4ZaV
vMfkkfJ3vQMkO0bqv2R5Cb3OGXJHvJH6uB0wQK3uTNb6K16PdLRQCmai/m2hB8St
k3bJZeKd4LgtRukI893JVIwl+P+nk7mrVGGQCKDH6xP5huQe8olnYTVgcka/R0CK
zeBpywRO6ELtcFXFOUf1jD1/18Vm7nEkUZ554byj13iU88cTAp22s8Zy6hdvaGO5
XsGJWsxAOa3VnJPDTNShdXb5n79z7A==
=6gjn
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--

--===============4170512778534190113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4170512778534190113==--
