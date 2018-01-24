From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: rt5514-spi: Check the validity of drvdata pointer
 on resume" to the asoc tree
Date: Wed, 24 Jan 2018 15:47:35 +0000
Message-ID: <20180124154735.GG9366@sirena.org.uk>
References: <20171216011230.107527-1-briannorris@chromium.org>
 <E1eeN5q-0004lO-5c@debutante>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Wtrm9ATX0sn6fFKv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1eeN5q-0004lO-5c@debutante>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: stable@vger.kernel.org, Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Brian Norris <briannorris@chromium.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--Wtrm9ATX0sn6fFKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 03:36:06PM +0000, Mark Brown wrote:
> The patch
>=20
>    ASoC: rt5514-spi: Check the validity of drvdata pointer on resume
>=20
> has been applied to the asoc tree at
>=20
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git=20

Dropped again - this was fixed with "ASoC: rt5514-spi: only enable wakeup
when fully initialized" which was already in Linus' tree.  Dunno if that
was part of why it went AWOL, I wouldn't have thought so as I usually
send a "this didn't apply" mail.  No idea what happened.

--Wtrm9ATX0sn6fFKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpoqpcACgkQJNaLcl1U
h9BnLgf/SNRRPbqrc8GnDyClJWIHArOdr/qLYnJDKML8zbj38A+QigEBVMBMett4
RhAgnG/xPxMh3JhrwyV0PnUCHci1l8tktopj5MpExjVF6MGrKQJAt0DIXamtuyRw
LF66XWPu9hx42ntGGLnHCfo7CsHUxedI4wpJnpNw0VMpNxJjfOLhay5OZZkX4yVZ
k9RT6UFuVSrXUK0d3xbVEOmIIrlSNIICzDYH9KW7+FkRxCB/G1b+RXiYS1v7B/+K
c0gt8+LKnK2inHwzGJVyCAorEKi5elMXByU6lVA56F63xgEHdr4im8LrRz/aPRgA
kyKueywLmv1tD5XcbuYm+77XygbGKw==
=rw+p
-----END PGP SIGNATURE-----

--Wtrm9ATX0sn6fFKv--
