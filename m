From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: sun4i-i2s: Fix the MCLK and BCLK dividers on
 newer SoCs" to the asoc tree
Date: Tue, 27 Aug 2019 11:46:15 +0100
Message-ID: <20190827104615.GZ23391@sirena.co.uk>
References: <0e5b4abf06cd3202354315201c6af44caeb20236.1566242458.git-series.maxime.ripard@bootlin.com>
 <20190820174105.96899274314F@ypsilon.sirena.org.uk>
 <CAGb2v64vzcZbXqfW27cgobpQ-AXQjb2zanqotAR0ezw+6KCdpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lIC76ItX9S6XOZ/S"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v64vzcZbXqfW27cgobpQ-AXQjb2zanqotAR0ezw+6KCdpw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Maxime Ripard <mripard@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Marcus Cooper <codekipper@gmail.com>
List-Id: alsa-devel@alsa-project.org


--lIC76ItX9S6XOZ/S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 27, 2019 at 05:25:21PM +0800, Chen-Yu Tsai wrote:

> > From: Marcus Cooper <codekipper@gmail.com>

> The authorship of this patch looks to be wrong. Maybe it's a tooling issue.
> I imagine it might have happened if Maxime created the patches using
> `git format-patch` with his @bootlin.com address, then sent them with his
> @kernel.org address, and `git send-email` swapped out the "From:" header
> and prepended it to the body.

No idea.  In any case it's kind of hard to fix at this point
since there's a merge in the way.  This is why I like using
branches for things but Linus doesn't :/

> Either way the "From:" line looks odd in the commit log.

This is what git format-patch does when sending stuff via e-mail
if the author is different from the sender, it uses that to
override things.

--lIC76ItX9S6XOZ/S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1lCfYACgkQJNaLcl1U
h9Di7ggAgNoZ8rQn7YvVm4cejhwJBcdMuUs1+pBMAGoZh58gwfOMXjpmjeBhjc/F
tSA0tLaf56ov+6K+icWnoYNv3uAMWBA1jimgQTS/ZOPTnfNPQ94/StKIHQKDxj+U
o4MwOkNdSc/ilIGdzRYa9mbTszAjTcB8zylCWd8ONcxTM8RxADVVlVSNXinS7ZnI
cslI9umNwU7+S8WoO7Q5gdk0cOHWmEjW12kgv6LsT6GyLrdlY08Nylb+uaLX+cQP
Tfoym0mSqCbh5/yCHO5tffAuvsMTUdWw+Pid75EkdaY/u4zmnn0+4D5n64a/wfmi
o2fP8Rqk1GMMBWKc42wqfjqulKd53A==
=onS9
-----END PGP SIGNATURE-----

--lIC76ItX9S6XOZ/S--
