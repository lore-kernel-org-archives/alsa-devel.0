From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mxs: mxs-saif: Fix the
 playback/record capabilities
Date: Mon, 3 Jun 2013 10:20:28 +0100
Message-ID: <20130603092028.GD31367@sirena.org.uk>
References: <1370191092-1773-1-git-send-email-festevam@gmail.com>
 <51ABA36D.8020802@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8269973164654308752=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DDCDC261A55
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 11:20:33 +0200 (CEST)
In-Reply-To: <51ABA36D.8020802@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: marex@denx.de, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8269973164654308752==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Content-Disposition: inline


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 02, 2013 at 09:56:29PM +0200, Lars-Peter Clausen wrote:

> Not sure if this is the right approach, there is no limitation on either
> saif0 or saif1 that it can only be used for capture or playback. Some
> systems may use saif1 as playback and saif0 as capture, or both as playback
> and so on...

Is there a limitation on the CODEC side or does the CODEC side have a
single bidirectional interface?

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRrF/ZAAoJELSic+t+oim9k84P/iqZTBmCDltQPIKc0ja+PbYF
XO86QA324r3ieFcG01ledKQ8gUqK4yf/PhaDT0n0eMi3K0oeRuq6oRnylE/afBwk
LKYDtGxWDfL+ZW6V6U8HmfxCDiE7b5KmIGSw9jAMYCG7GbIIMZD8ZZ0ZVXA4lWp0
xcRW+1lJWnKnrSpD3vvgELGaKDApZLRyakNa8d9jOm70UKCD/uNzBAK72H9YQlc0
bRtkkC5h0mVZyDaFRavj4domYof18eDcY/Fx2hIn9CqE6a2Su2NM53kt2GbyxAiv
YXfF9AovSfBdVQ4DmajKjtemmbVJoeVKSHiEnkQYDROFUcObPIBTbkAjkutYzuPt
U5wLJJ6wxCS8HCfJCqn28xMdNcWYHH/MQxPbbagnqMMgWVC7gb9rZBUmXffj1kOv
Mfi/x5HF4gXjv8j14vh1GH2J5KC2AkgxA1hqFEA8LAs3xYbV2v+LvKeOWoUkhN2t
i9fyAetHZKoJkCf4IvqndHm8Cf4Bu53fysUnKjhOmKA/8siAxtTyP/5K6RaASKfO
y5K5T3Hx1/3xsKCKOB7Fusz6s9NfcWu6tW3Ks2DNVpBxnMV+Ljg6qLXmAaClObaD
hMD0wb0KgfXreGiOG7T3KyZntCy159oj9fFCIJMAtyIOYKwPtpPMDxUCNjGiu+l8
RyQeE8S2+v3jYC4Yfgh4
=qO1b
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--

--===============8269973164654308752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8269973164654308752==--
