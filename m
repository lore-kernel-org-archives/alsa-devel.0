From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: ux500: Drop pinctrl sleep support
Date: Wed, 8 May 2013 15:49:58 +0100
Message-ID: <20130508144958.GT7478@sirena.org.uk>
References: <1367997261-32048-1-git-send-email-fabio.baltieri@linaro.org>
 <1367997261-32048-4-git-send-email-fabio.baltieri@linaro.org>
 <20130508105124.GA7478@sirena.org.uk>
 <20130508114216.GB29130@balto.lan>
 <20130508123225.GK7478@sirena.org.uk>
 <20130508131020.GA30503@balto.lan>
 <20130508135413.GR7478@sirena.org.uk>
 <20130508141723.GA12155@balto.lan>
 <20130508142734.GB12155@balto.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UefMXxAhg/xpzpuf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130508142734.GB12155@balto.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>
List-Id: alsa-devel@alsa-project.org


--UefMXxAhg/xpzpuf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2013 at 04:27:34PM +0200, Fabio Baltieri wrote:
> On Wed, May 08, 2013 at 04:17:23PM +0200, Fabio Baltieri wrote:

> > Ok, what I'm trying to say is that the codec used in this platform
> > should be able to handle sleep modes without requiring any
> > reconfiguration of the digital interface on the SoC side.  In support of
> > this the fact that the STE fork of the driver does not do that, and the
> > same goes for all other ASoC drivers currently in mainline.

> And by the way, if the current code is *really* setting the digital
> audio bus pins in hi-z mode (without any pull-up/down/keeper) as it
> claims, this is not just usless, it's plain wrong.  The bus should never
> be left floating on both sides, right?

Probably not, no.

--UefMXxAhg/xpzpuf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRimYTAAoJELSic+t+oim9y1sP/RDu1K9C8E3OJ2I36H1+H8Dv
TDRqkZr0PjtF+mLOHIhRwYg3UIohsei8aYkFQA/qHkjqF8FeYL6Z3SJIkV7UHXcl
mRm1zHBHFgY5mjKOLEt8xfgn8h38T02jikHrsGEZ0TpfdwehNqQ4GIAzyPnIofzW
/jCCmtF1twlQu1w2/taE75kDEAmT0iT3XKKWmBeEPfy3FE6373Q4UZ3TjhEgxH0q
XGeqN+IBN2rjjNkBVhOQh+AnOATUzJbgTK/zCO3GYect+ccsFDFttHUwedvMdbh8
EOdnR6e+RdqaOIcoy7pVt1ymoefYGtH5qBXH4jRDKoKUAfPGqUNvtsOonWV44Wyq
LHT7GVZCLBRdf5TyfquTsceMEOdLwyZnfZeVPMWmc7m1wLdr/XBXK01bjoCS0/VB
XWpxuYaJbvjUzWI3mc9SsY7s20riHsX7PH4lrPDLiHZRWwoaYCexcFhuOggcAHuP
07iAENhcJfIA3bU5PMDU5e76WkZZ9YWeM+mODsXaFGLy5Ba26w9vvxAhq7NfBuRW
w/RLQHJ49iYMkB9ezvgOl2Em58mK/yACGVZvKneoOWhp0JM7niGd6+nmkL4Uwolq
8JOuG6xe2Y++dGrrMbmgDxhHa/B4+fAbH++2VNI3ZSCicEYlI/2r5vltMuB4xhTG
ZXDQUMzwXdOGJ/sClpqB
=4miH
-----END PGP SIGNATURE-----

--UefMXxAhg/xpzpuf--
