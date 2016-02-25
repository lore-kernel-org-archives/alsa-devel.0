From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: arizona: Make logging of FLL calculations clearer
Date: Thu, 25 Feb 2016 10:53:47 +0900
Message-ID: <20160225015347.GV18327@sirena.org.uk>
References: <1456236992-32028-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <20160224040832.GQ18327@sirena.org.uk>
 <56CDEAD4.1050405@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qTa+0zXUvx+FOrJg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56CDEAD4.1050405@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--qTa+0zXUvx+FOrJg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 24, 2016 at 05:39:32PM +0000, Richard Fitzgerald wrote:
> On 24/02/16 04:08, Mark Brown wrote:

> >I think that stuff was originally based on the way the datasheets quote
> >things:

> >>-	arizona_fll_dbg(fll, "FRATIO=%x(%d) OUTDIV=%x REFCLK_DIV=%x\n",
> >the hex(decimal) but there is certainly very familiar from some of
> >those.

> Indeed, and it was fine on the first codec. Now we've got various revisions
> of the FLL with some fields having different meanings, human error started
> to creep into interpreting the debug.

I'm not saying it's a bad idea to change it, just pointing out where
it's likely to have come from (and the fact that the way the datasheets
were writing this was always a bit weird).

--qTa+0zXUvx+FOrJg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWzl6qAAoJECTWi3JdVIfQ85QH/AlrBT7qqTh5okIT28J/QLbV
4DSLGefYwCvO2SipFHWgcK2/x5TNnP70HXYPu1nW0CeYCte5S85ypFwi4Zdx8WIY
Zaa6hbo5ARFML/7kL8EAHlUwkGbLUbmJTOPgH3FGLxYvCcKlIOFBvn8SnQdZiYIh
hnIbxxNdA19ivPJng7jeSVRVoiVJgPArxKC0x0m4/P8mGr4idP7jU5tAxd0ZQ+xP
lt54IUeUmvLjD27ovoJttOkyPH8MMnubtSFiLQz9LxWPoQVyZ0rJnurOQZtO9tJS
wTqhdgeWEgsZ/fovn+iBRQ49DwiCXlkSmjSL2zegmpAdryP4OJoKyAZ8phTtqpo=
=lh5q
-----END PGP SIGNATURE-----

--qTa+0zXUvx+FOrJg--
