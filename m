From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch V7 03/10] ASoC: qcom: Document Storm bindings
Date: Fri, 6 Mar 2015 11:18:45 +0000
Message-ID: <20150306111845.GF21293@sirena.org.uk>
References: <1425428519-12224-1-git-send-email-kwestfie@codeaurora.org>
 <1425428519-12224-4-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WJ5rdQZ/YyRv8SXp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425428519-12224-4-git-send-email-kwestfie@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--WJ5rdQZ/YyRv8SXp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2015 at 04:21:52PM -0800, Kenneth Westfield wrote:

> +Required properties:
> +
> +- compatible	: "google,storm"

I'm not convinced about this compatible - it's the name of the entire
machine from the looks of it which means it'll collide with any other
similar machine driver type things needed on the board.  Adding an
-audio or something on the end of the name should cover it unless anyone
has any other bright ideas.

Ideally we'd be able to load drivers off the machine identifier that we
already have but nobody seems to want to do that so...

--WJ5rdQZ/YyRv8SXp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+Y0VAAoJECTWi3JdVIfQUxQH/2eJc6OwgDRp5wTlRBNRKo9S
JKMztK2h8tGDr7Jdo3pxk/dUYi8FjCxHZLwOqDivW3tka5mo17iv7UjyfELuFSY6
OznudCjHjHsU6+8OH6/aphw0acwKOcYsnF3q67UD3vj+PvmUCcq8ZXwUhqJHCXoi
5KUQYWSuGjGBd7s1rVP2Ya7Kdvq0txpeRpNvV44yrRy18++8B2NuffgnNzc/a1cr
2ZnAolzTzAj4H/+G63v6bUZ7KDrVGDOA1KMOPa2qa/dTt0y1fut/xuymBmqgii+S
idSLw9GUxxbyAoeAtvefmkIsCQ8PRQ8NEUxz9zzD256kcm43L6ltANpL7iglAng=
=wOqt
-----END PGP SIGNATURE-----

--WJ5rdQZ/YyRv8SXp--
