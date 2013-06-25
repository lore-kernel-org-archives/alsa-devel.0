From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Tegra and i.MX are mutually exclusive
Date: Tue, 25 Jun 2013 10:26:12 +0100
Message-ID: <20130625092612.GX27646@sirena.org.uk>
References: <5967649.DUvDfofhX4@wuerfel>
 <51C93A62.1050702@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5376930129321819097=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C9BE26520A
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2013 11:26:17 +0200 (CEST)
In-Reply-To: <51C93A62.1050702@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5376930129321819097==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qy9NDBoEzxL7V3MP"
Content-Disposition: inline


--qy9NDBoEzxL7V3MP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 25, 2013 at 08:36:18AM +0200, Lars-Peter Clausen wrote:

> It's just the ac97 drivers that are mutually exclusive. I'm not sure whether
> it makes sense to make the whole platforms mutually exclusive for this.

I agree, this is excessive and seems to rather defeat the point of
having multi-platform in the first place.  It makes it impossible to
build the sound drivers multi-platform all for the sake of a bus which
is used by approximately nothing these days (hence the lack of love the
code has had).

> Also this is not limited to tegra and imx. As more platforms are converted
> to multiplatform ARM the same issue will pop up for other platforms as well.
> I don't think your solution will scale really well for multiple platforms.
> The best solution would of course be to make AC97 work properly with
> multiple AC97 drivers. But maybe we can get away with a 'choice' Kconfig
> entry which allows you to select which platforms AC97 driver you want to build.

It should be easy enough to refactor so that we assign the ops pointer
when the driver is loaded instead of at link time which isn't solving
the issue but makes it better.  I'll send some patches.

--qy9NDBoEzxL7V3MP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyWIxAAoJELSic+t+oim9ALQP/j4qkWKmvEmxXsgeeKennPVD
NasS+TIHqnqdMKej1DOBb+geHtYC5ykZxLiajfEcE/Q7vm2gmrCBlkZyZZXbg00/
OwmgUjC93lH8uSV0xPkahPonZJTyub3G9fQ5R7wI1t1v19qZfqbzqjhcPUEghMsI
pCW2+/gMikhj0qzrhLp9MwnzACh8AU7QygSjDw4OV8iAIXAG2A20pgP0Rg7Ld54F
qxf2zBx6sF3knC80NuLVpDpMBFBRE9PjFmEjMpmq0EK0sVJSjUN3y+wr703ccklO
D7LxHd2DvdNyuitBSNQv7t8bO4NOg33U5+x/IdOqmajJ2bB8p+Qjtu8lwhsukT+m
1RryMPxLqowj1oVr+VnLDAExPPNBXwwlX2dA1wFNUXpEBMx8DZ2tP1yPh6Gbhq+b
V7XKNFfsi2gQBJjXHVHb0LrefUKBOTYIXbaE0RL7z56Dw4VXD0bF6b+K/S1lR0Ra
DROn9VvZEyVBuuXHQpH4Jj2Ak5P2MryTjOMk09EEyL0lsgmzpT/3JSoxljsStkba
P42O9+TsB7RMUXMuxcdHsjlJ5jgD+XAkbqkZnfUsGCe5fDDmrVEyRAxmXcjmTIfC
qszFVk2u6i6AyePzhA5+051V4E1/s0+e8svEUThZ+xVHm8qLa+EWSLlwopkMSspV
HY0fvDwj0GdZqWQE77+M
=CgMf
-----END PGP SIGNATURE-----

--qy9NDBoEzxL7V3MP--

--===============5376930129321819097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5376930129321819097==--
