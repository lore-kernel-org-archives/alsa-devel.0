From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: adau: Factor out shared PLL
	configuration code
Date: Thu, 9 Jun 2016 18:41:22 +0100
Message-ID: <20160609174122.GB7510@sirena.org.uk>
References: <1465493946-32594-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8062985682743810250=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 071BE26070C
 for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2016 19:41:35 +0200 (CEST)
In-Reply-To: <1465493946-32594-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8062985682743810250==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f5gZUSgn1tH7xO87"
Content-Disposition: inline


--f5gZUSgn1tH7xO87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 09, 2016 at 07:39:06PM +0200, Lars-Peter Clausen wrote:
> Multiple devices from the ADAU family share the same PLL structure and
> configuration register layout. Introduce a new helper module that can be
> used to calculated the PLL configuration registers based on a specified
> input frequency and the desired output frequency of the PLL.

Sounds like we may be heading towards an MFD with a clock driver here?

--f5gZUSgn1tH7xO87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXWapBAAoJECTWi3JdVIfQ+WoH/236ZHxndbRzQ0T4dInOepFG
qnVoDZJHoFGWRruLtVaSjYU94w5oxh3VH4AGjU2xn2Vg+SvuCUO0wIzzck69afI5
vyJXqqAF3PqA2zokKi46XOLHodMyjbbT2a1n5O06I+OPISVBxTNYdU+Em/kI3+p0
M66FP/fY8029ZBS51/oqDGhexrjr5vZiJnVSo/XhezUew0UchfDLnw5Mqnkr3ifc
X3uP78+arQ2xxXb6xQf/XYX/5UILlqvk6jh5wgoobOlfoItT00Wbp1vSSgVlbJr0
j+1HUQ/W/tR1ciuKwuCZDa/53uTCn7oRyiwDEIluyC410/cQ5mUkvmJCvnJTOfk=
=dm7l
-----END PGP SIGNATURE-----

--f5gZUSgn1tH7xO87--

--===============8062985682743810250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8062985682743810250==--
