From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5663: Add the function of
	impedance sensing
Date: Fri, 15 Sep 2017 09:30:49 -0700
Message-ID: <20170915163049.brqdeopuhifb7zc7@sirena.org.uk>
References: <1505368256-27250-1-git-send-email-oder_chiou@realtek.com>
 <20170914172800.dst524eo6emmjl3d@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694023C1915@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6261260200983891479=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D246A266B20
 for <alsa-devel@alsa-project.org>; Fri, 15 Sep 2017 18:30:54 +0200 (CEST)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D12694023C1915@RTITMBSV02.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "hychao@google.com" <hychao@google.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Albert Chen <albertchen@realtek.com>, Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>, Bard Liao <bardliao@realtek.com>, "Flove(HsinFu)" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============6261260200983891479==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6nbypdbzsymwhkrn"
Content-Disposition: inline


--6nbypdbzsymwhkrn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 15, 2017 at 02:20:09AM +0000, Oder Chiou wrote:

> Sorry for my poor explanation.

That's OK.

> The impedance table should like the following setting in the DTS.
> 		<   0    300  7  0xffd160  0xffd1c0  0xff8a10  0xff8ab0
> 		  301  65535  4  0xffe470  0xffe470  0xffb8e0  0xffb8e0>
> The first and second column are defined for the impedance range. If the
> detected impedance value is in the range, then the volume value of the third
> column will be set to codec. In our codec design, each volume value should
> compensate different DC offset to avoid the pop sound, and it is also
> different between headphone and headset. In the example, the
> "realtek,impedance_sensing_num" is 2. It means that there are 2 ranges of
> impedance in the impedance sensing function, and it also can be defined the
> device whether can support this function or not.

This stuff looks fairly good, can you put it in the binding document
please?

--6nbypdbzsymwhkrn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlm8ADgACgkQJNaLcl1U
h9C7Ewf9HrM+T9sG4jF99vsWgyn59TQMMZaVhsEXO7UFExNDNy2J7P8zdUM92jYR
D3oheS9l/Syi6o/39klFIoFCvETJxn00bYjsUAyi6mDEJQPPql7ub/3VUOfXIzQl
WpeWSk7T8TolpFchfoMnvwbZ28ajsjlcPEBJSFbcz63nmFjNxUPFNzaxw7P0E1Au
K/rgutWqjJ2X3XDtuII/TeuQ0k68fw9uL+kcpqGbsCHPz11IwoiOGD4U3Bh9Bi6n
xEbCSO8F+xkD7rd8rNePntbzHOvCtTqVN4VNQ29Stn89SwYKgq62u8HEgZzIrZfP
4fgmZcUcS+YhDxefr8W9gn5nU+/U8A==
=RFBa
-----END PGP SIGNATURE-----

--6nbypdbzsymwhkrn--

--===============6261260200983891479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6261260200983891479==--
