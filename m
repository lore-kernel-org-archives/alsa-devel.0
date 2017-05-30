From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] gpiolib: remove unused variable 'i'
Date: Tue, 30 May 2017 11:58:11 +0100
Message-ID: <20170530105811.xaoomponlr2rwn4i@sirena.org.uk>
References: <20170530094420.31076-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="adkal7m3tdfwgpuj"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170530094420.31076-1-colin.king@canonical.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--adkal7m3tdfwgpuj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2017 at 10:44:20AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Fixes smatch warning: unused variable 'i' [-Wunused-variable]
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpio/gpiolib.c                   | 2 --
>  sound/soc/generic/audio-graph-scu-card.c | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)

You've got two unrelated patches in one here (as a quick review of your
CC list would probably have warned you...).

--adkal7m3tdfwgpuj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlktUEIACgkQJNaLcl1U
h9A7HAf+N61UcMIRkZPvA34C/heON7p/wbFTpqW9FcJFDGPUkbl7EuTzzi5d8ZyT
FhTl4c1ie8c8hMLiWmEqBnYGw6gQtpdMuJuPjPkMgqaJwA1l624b0Vee4yEsh4Iw
/UejxhqyHMrDn7NGYnHn7xx7klRbJlQKRn+Q3VBps7o6XspXN3BHCuFtWiigCsgj
MtOCKLbX3FQIgwLBLrglV6QbM9sIzb9tv970I4wLGSH2XNhp41iCfH3khJwLbVbY
Jt2gSdXDTz9DKY/1gKauEZUcrNS+ZmOEfgpGoEGKG7J439an7e60yJDUuhrjlTEq
RaMXK4576xYo8sRNt1R6YAtlZMIAtQ==
=mjkL
-----END PGP SIGNATURE-----

--adkal7m3tdfwgpuj--
