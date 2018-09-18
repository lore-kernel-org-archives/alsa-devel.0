From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound: soc: rt5677-spi: Drop unused GPIO
	include
Date: Tue, 18 Sep 2018 12:49:50 -0700
Message-ID: <20180918194950.GV2471@sirena.org.uk>
References: <20180918191157.16996-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5280651767284503631=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BFAA426788E
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 21:49:53 +0200 (CEST)
In-Reply-To: <20180918191157.16996-1-linus.walleij@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5280651767284503631==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FZIkiClxIZ9JeWSb"
Content-Disposition: inline


--FZIkiClxIZ9JeWSb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 18, 2018 at 12:11:57PM -0700, Linus Walleij wrote:
> This SPI driver does not use the legacy GPIO header so
> just delete it.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--FZIkiClxIZ9JeWSb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluhVt0ACgkQJNaLcl1U
h9BZTAf+L0cCQuih2hwfY/L6JHmbTvXWRC5TZf6CjeNM4C8AvtEwMwVCgaPJXoce
W0qfh/MEM/hO5JFflv1PJ0p+qIgHCARrfSM21ZcXGE7/bQ5oCdEgtaMwqsulXQ0G
2sSTLLRWwlqCXwI6vPiQ6Oyudhg5Mgv6Ez/yz3GKe2VYaaj+p5PNCLHJmjMcCiBy
uEYAF3Q/veo7K2z5Y6UpUGTpkyftpcxxh7tiLtFoG93YLRe9CBXj3POqVC56xgQz
WyznC0wTgvHYaH+nBr6fUg+KiS0GeyIrujQvM7NrkRVmHk9j2vMjdcRPSAyTJYas
FcyxKWgpZBhFkDL5tkCHlNVC9odWVg==
=EiD0
-----END PGP SIGNATURE-----

--FZIkiClxIZ9JeWSb--

--===============5280651767284503631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5280651767284503631==--
