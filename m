From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] Revert "ASoC: ux500: drop platform DAI assignments"
Date: Mon, 17 Jul 2017 15:51:27 +0100
Message-ID: <20170717145127.ke5o65as35itamaf@sirena.org.uk>
References: <20170712155530.17765-1-johan@kernel.org>
 <20170712155530.17765-2-johan@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vt7ymtdjkujfaxl5"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170712155530.17765-2-johan@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Linus Walleij <linus.walleij@linaro.org>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--vt7ymtdjkujfaxl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 12, 2017 at 05:55:30PM +0200, Johan Hovold wrote:
> This reverts commit f1013cdeeeb9 ("ASoC: ux500: drop platform DAI
> assignments"), which seems to have been based on a misunderstanding and
> prevents the platform driver callbacks from being made (e.g. to
> preallocate DMA memory).

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--vt7ymtdjkujfaxl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllszu4ACgkQJNaLcl1U
h9CuEQf+LfYbqhRyi7dZZ6dtq9ImNadrrwmgcaz4YAkkQm/1kmR2gjhzwxwaHSo2
zb/2o2mF0gI5OT9JerMpMSbm6exvPCiE3s7exofMoXdfyZrfLww5wZNi3LNawDkP
XpyAoKHUXtuntQKfqKqtSri/PkOHgXzyZiXuEp2GITIWRMNhortLsPH96ark/JGT
9iX1RJYCUqPvem3H0x1q3ABNVrz31B7ZujtxcszvmOhyMFdHNhYjKlzmSvYxW9ue
7+eOYBqkI4ar61qw8ZhPqJJgDNn5Zbjc71Q4Npw6Cm3CfA626WjGkLXE4pwh+33P
ABAdplKwsQHuyz9Qh17nW01Q6fgHyA==
=FjyQ
-----END PGP SIGNATURE-----

--vt7ymtdjkujfaxl5--
