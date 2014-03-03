From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/8] ASoC: pxa: mioa701_wm9713: Convert to
 table based DAPM setup
Date: Mon, 3 Mar 2014 11:02:39 +0900
Message-ID: <20140303020239.GR2411@sirena.org.uk>
References: <1393685300-5307-1-git-send-email-lars@metafoo.de>
 <1393685300-5307-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2785624729131186564=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C847265530
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 04:36:19 +0100 (CET)
Received: from z88l218.static.ctm.net ([202.175.88.218] helo=finisterre)
 by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <broonie@sirena.org.uk>)
 id 1WKJfs-0004SP-Km
 for alsa-devel@alsa-project.org; Mon, 03 Mar 2014 03:36:18 +0000
In-Reply-To: <1393685300-5307-6-git-send-email-lars@metafoo.de>
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
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2785624729131186564==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hCenlVgnDQUGHXTR"
Content-Disposition: inline


--hCenlVgnDQUGHXTR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 01, 2014 at 03:48:18PM +0100, Lars-Peter Clausen wrote:
> Use table based setup to register the DAPM widgets and routes. This on one hand
> makes the code a bit cleaner and on the other hand the board level DAPM elements
> get registered in the card's DAPM context rather than in the CODEC's DAPM
> context.

Sorry, got the wrong mail to reply to - applied, thanks.

--hCenlVgnDQUGHXTR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE+K7AAoJELSic+t+oim9ELQQAJpakJcU66yu7hCRsYS/E+Od
t/hFXT26EXgf8etNIzXXESah//H8uQgtIbUNQ3VUHIYY7NHdS4axpSicA2OeulEx
m7RsFj4LEOfRNT59WObZ2Q26BdzYEiO4JLf1GaOxi/cljt5pZg+Zmnn+jKvqvyYR
agVldVHVkZau8pR3RodoUed33qw/0zNyFxnCOk/7FhRTIFPqai3IfD+ySHkcsglc
Dyx2zPKQFMMRReVnIxRm/k6EAffftVrVkmzx/IgaJKjQkc1D/+WFz6QlhCrxIzyy
kM4pZwgl2c4qLOLqtfwrQP3GOIqxuv1kEX7ZAFVmmhO1/sk0rWpXyFoSFHJOe5en
JdpqAuY5RYDHpdWNizVk4f249F+1T5/efdy+mkH3UB/ES5UF6U5TWmk8FrPUBlsb
k+q7+v0Mj0I7WTXwHavZBuIRtz0qBOttuGRo0YBGGRmfTCAvyTHaybwDYD7LrV5M
q0cmwZBMmlmELxFwxLASaCt7FzGMx5PT0IIEeKY2y6D2fXlLtAkwnmGXgjXOx/3h
KyK4kgVRjELYcl55qqU5UAP+VBl/2sJTPsw683bYFpeFyQdVSPrD6Cdiaqut0Frj
wi0Ssk89qH3S4XO6EJCPzk0RwhEu7L1oGAR/r+dt33h2F/I5QzrIyay2Nye8s3qP
ds6rmj/V2gfHk63G4eA2
=epVU
-----END PGP SIGNATURE-----

--hCenlVgnDQUGHXTR--

--===============2785624729131186564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2785624729131186564==--
