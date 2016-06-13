From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: adau: Factor out shared PLL
	configuration code
Date: Mon, 13 Jun 2016 09:56:23 +0100
Message-ID: <20160613085623.GC2282@sirena.org.uk>
References: <1465493946-32594-1-git-send-email-lars@metafoo.de>
 <20160609174122.GB7510@sirena.org.uk> <5759B82E.5040801@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5016258815772935273=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 224632619D7
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 10:56:37 +0200 (CEST)
In-Reply-To: <5759B82E.5040801@metafoo.de>
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


--===============5016258815772935273==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CPaaJmjEtnx7DmsZ"
Content-Disposition: inline


--CPaaJmjEtnx7DmsZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 09, 2016 at 08:40:46PM +0200, Lars-Peter Clausen wrote:
> On 06/09/2016 07:41 PM, Mark Brown wrote:
> > On Thu, Jun 09, 2016 at 07:39:06PM +0200, Lars-Peter Clausen wrote:
> >> Multiple devices from the ADAU family share the same PLL structure and
> >> configuration register layout. Introduce a new helper module that can be
> >> used to calculated the PLL configuration registers based on a specified
> >> input frequency and the desired output frequency of the PLL.

> > Sounds like we may be heading towards an MFD with a clock driver here?

> Not at the moment, the PLL outputs are only used internally so it makes
> no sense to expose it through the CCF at the moment. The questions on
> IRC were more about how to replace the input clock configuration, which
> is currently done through the set_sysclk callbacks, with the CCF.

This was independant of the IRC discussion - it's just the pattern that
you're describing here.

--CPaaJmjEtnx7DmsZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXXnU2AAoJECTWi3JdVIfQYtgH/jP50C7IjGEv84tSfeka6V81
xyRnpjcBS5oLpYwrNqFfpm8RiJVsahEIfTTvdaf20MqbzLEfvzwW8GKIR+sX8JGC
HyUjbGHIRUF6FdI8jGNK9BQfFctuzhmzG2ZaQ3bZIi31ONOKJyqubrnpPEFYLZa5
lJoOw+KkEhKgbGmY2MdNdYvB9d0Pg5sOmrUJ5SmXgKpP40N4+igQOQaeDMx6ziO7
C9btklyX1Ojm3KLEURZGUYQ55Hini2ISFPFQcPOWznUc+9Y31o9caMNZ7+nBWBXy
y/Spzy3FIn3R5qUdF4je05jnLEWiJSvKn5RzFmVd6rRCgzo9zYFf+Wn2AzMU+XM=
=1pOP
-----END PGP SIGNATURE-----

--CPaaJmjEtnx7DmsZ--

--===============5016258815772935273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5016258815772935273==--
