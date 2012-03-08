From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Correct clock muxing for
 CLKR/FSR signals
Date: Thu, 8 Mar 2012 12:03:03 +0000
Message-ID: <20120308120302.GK3638@opensource.wolfsonmicro.com>
References: <1331206772-19716-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6742876729653367826=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1D6C710BA43
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 13:03:04 +0100 (CET)
In-Reply-To: <1331206772-19716-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============6742876729653367826==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2OzUYMsT4j3Kc+NU"
Content-Disposition: inline


--2OzUYMsT4j3Kc+NU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 08, 2012 at 01:39:32PM +0200, Peter Ujfalusi wrote:
> Remove the no longer valid check for McBSP1 regarding to signal mux
> selection (on OMAP4 McBSP4 has 6 pin setup).
> Only clear the srgr2, pcr0 register configuration if the requested clock
> configuration will actually going to touch it. In this way we can avoid
> issues if the CLKR/FSR mux has been configured after the clock selection.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--2OzUYMsT4j3Kc+NU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWJ/wAAoJEBus8iNuMP3dizsP/R+xMtBpgPxwH+uuXm9/25IT
668r5UEpqygELA9dKVATazWOXozQyELiHybeZg7pcxlOxao99gohvER6mHZBhN2E
b+7emgIP0eSztsSN+Q4uvLthbQuDimZh0cm7C/jxSLWEms6qMABFWdVx4rjNhswS
gDDX9dQEVn19/QbRf1d7cNOV8EVJVb8oLz/kkqklqr1x3minwe0rLrevTXjqGo8b
t6oiTupJE1orwoehqKwJOrEkPBmtgemknygacdti51G9CZ2TnLu+l6oDjrEFZKue
wTFFKq2NE/5LajTmx7sKr4PIH0jMF4bNM6CftqHdg5HPo8IPighONr9rXqtQLvI2
kQxFY9/QOhmh+XuZdxAQBCVqmDEI1iqZKOUEx0PoDjGBYH3M7EZ6pvb7sbZw482/
Vc28AmxsK0fIAskJd+TztodoHJAmDvjK0Cyjx/1udBu2/9poD3TxvvPK6rKYqKZK
ckjXENK/nCZC9iHyQmYCEA9lSUyusA8mnpo0zohDvfR2932mnuTlC7m7KijZD9N9
K4riEDhEeQGujz9GyeusMjG0h352UtI16AO3CFICOiP38KKZVCOaC/viaNRTwf2p
iD1pxneONsGbkUmNKgnewMcC6HjOFsj4BVN8ytOPgkvV/yGegNCxWhOM0ERSO6JY
MU7qdFiEqwRNoEOj0A2Z
=rLAi
-----END PGP SIGNATURE-----

--2OzUYMsT4j3Kc+NU--

--===============6742876729653367826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6742876729653367826==--
