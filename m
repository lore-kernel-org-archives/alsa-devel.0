From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: Remove selects of regmap buses
Date: Mon, 20 Jun 2016 16:44:46 +0100
Message-ID: <20160620154446.GV26099@sirena.org.uk>
References: <1466168669-13140-1-git-send-email-broonie@kernel.org>
 <5765882E.1020809@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4300118884494026811=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AFEE2654B7
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 17:45:00 +0200 (CEST)
In-Reply-To: <5765882E.1020809@metafoo.de>
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


--===============4300118884494026811==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mmR5Tf+WJGm+vTLg"
Content-Disposition: inline


--mmR5Tf+WJGm+vTLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 18, 2016 at 07:43:10PM +0200, Lars-Peter Clausen wrote:
> On 06/17/2016 03:04 PM, Mark Brown wrote:

> > We used to have code wrapping the regmap I2C and SPI buses as part of
> > the conversion of ASoC drivers from using the ASoC level I/O to the
> > regmap level I/O.  Since all drivers have now been converted and the
> > core code removed we can remove the per-bus selects and instead just
> > select the regmap core.

> I think there is a fair amount of CODEC drivers that don't yet select
> REGMAP_{SPI,I2C} even though they use it. Merging this as is would break
> them I'd assume.

Yes, that's why I've not actually applied this yet.

--mmR5Tf+WJGm+vTLg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXaA9tAAoJECTWi3JdVIfQX8cH/RVlZMDlq6wGnsuIWsW4tysN
BIlUrUEX+vHIkSMQGP/7nvxYcCm1EpbIKdfXUHpbopwTsKbU8rH0G2wUPfi1QeFW
5mGy4wqeZ3UFhYFZuTkwl24Z3aEvrUJrWbsyzQVPyd+Tc00EOp9WrHbgVVw7vM8e
a2X015DB+MPxrxN/TdWqRXL/41bhixUdn8wjxYo5k1YNMhifunuzv8hxxkXxUWiy
H1GVc2Gc8owRfKwZJcFE6P2D6TveyPV7dGJnUwXaNsX0OuFmgzC84RS0j8a2i6mh
n3QVMzq898tIdevHuFzt0NwgPqBE6T9YnMoZdtxOUxCCTt/06U4c+oPHeudgPZA=
=94hO
-----END PGP SIGNATURE-----

--mmR5Tf+WJGm+vTLg--

--===============4300118884494026811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4300118884494026811==--
