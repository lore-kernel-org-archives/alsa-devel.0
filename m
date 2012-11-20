From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Resend v6 PATCH 2/2] ASoC: atmel-ssc: add pinctrl consumer
Date: Tue, 20 Nov 2012 19:27:38 +0900
Message-ID: <20121120102712.GF10560@opensource.wolfsonmicro.com>
References: <1353045837-19474-1-git-send-email-voice.shen@atmel.com>
 <1353045837-19474-2-git-send-email-voice.shen@atmel.com>
 <20121116061250.GP4387@opensource.wolfsonmicro.com>
 <50A5DE4E.80206@atmel.com>
 <20121116064113.GQ4387@opensource.wolfsonmicro.com>
 <50A5E44D.6040501@atmel.com>
 <50AB4DEA.3090100@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VRRZwUeiQeu7kZYj"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50AB4DEA.3090100@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--VRRZwUeiQeu7kZYj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 20, 2012 at 05:31:22PM +0800, Bo Shen wrote:

> >based on ASoC tree? And the upper go into pinctrl tree?
> >---<8---
> >ssc0: ssc@fffbc000 {
> >     compatible = "atmel,at91rm9200-ssc";
> >         reg = <0xfffbc000 0x4000>;
> >         interrupts = <14 4 5>;
> >+        pinctrl-names = "default";
> >+        pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
> >         status = "disable";
> >};
> >--->8---

> Any suggestion for this? what should I do with this patch for next?

Send it to pinctrl and we'll deal with the add/add.

--VRRZwUeiQeu7kZYj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQq1sHAAoJELSic+t+oim9/i0P/3W3jjOR3W5mpBFNmUwfpqfc
g0lZvI1fDvFknlG8dSdXZvkW0GE0/PyjXWsukmyIaX4fGMHOcxsmKmL41sgbBGEx
BwKia4I90Qh2R8AP1cpZhwPgkiMQOo45PaVz0i78OJFBhWlRFhYrN7tgx4DD89hW
ZcMX0ZWrOgyb6pR/sWzcFeNY0JFERxyjKHeXIGIkTcvZVdxWO/Sh9NZ6VG+idzVa
cagEyV0mhApfJnwt7+9eNL2u/8jBjGLPtd7Baaz1LiNan3RnNs7/c0px6NTOoLql
Ig1O7OF9v8MqLi4MvNGR3TLApjv9aBu3O9ZsB9D0jrVHr8fNZawHBWsG1Nk0hClf
0BR778p/SFexg6uh2wAEc7CE58PY80mg+pQb2C7MWs3sc5126Y4Z3kdliybtcHMo
XCb86X07b4Rgen4VSVLvnc4evLtHe4lufURIXMwI7bmJG9JFHu7PZLr0HAz3b32w
HH0vnBfGx7fwsqmqBv/TvmnzxtzlFcGqHZ3f9jwwsKHk9jWAoAOm1d8iHUzLsCPN
E+rU3uDwsL6s6vUh6olM+ZP+a/2+6/RUKlZuYpDwX0IiQsP1CqtpEQWiJrgpOz0n
r1/mYrVCOhc7Jt7o6D4OK1skiafJUAvJZG31kzSTNQtMvS9m16Tyg7PDy1RXMiwv
8vTHLmDo0lLuLUfvQnwB
=idoa
-----END PGP SIGNATURE-----

--VRRZwUeiQeu7kZYj--
