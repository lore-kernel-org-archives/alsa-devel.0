From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] drm: sti: fix prototypes after API change
Date: Mon, 4 Jul 2016 15:22:30 +0200
Message-ID: <20160704132230.GD6247@sirena.org.uk>
References: <20160704131651.1083630-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1BXV+/FYeXhtv2WT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160704131651.1083630-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Airlie <airlied@linux.ie>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, kernel@stlinux.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: alsa-devel@alsa-project.org


--1BXV+/FYeXhtv2WT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 04, 2016 at 03:16:51PM +0200, Arnd Bergmann wrote:

> This follows the API change, adding the extra function arguments.
> I suppose we want this to be part of the ASoC merge in linux-next
> for now too.

I sent a pull request for the API change to the DRM people which might
be easier given that it's a single commit topic branch rather than the
whole of DRM.

--1BXV+/FYeXhtv2WT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXemMVAAoJECTWi3JdVIfQeZEH/1eFEXLji3DpkpZWBRoCbVBA
sKL8YcqjMAeHPrEenvXHN1vetWydS6hRLzBzuFOYdL9/lnxl71i5BIopcyG/PoS0
y1La8JEuNZ9xYuvIYjTUbUjtxHxXdqRym/3dhHqy0vZcQJ6kQraiJ+hQjlJNmnfO
yTZrgrufqW+kZckf6hIVn175pxYuDgpIPSqE3ruA0T91nUpGUpYowbQpvkYTKS+3
3pDLn9+lywiYwnd5BC+OJKX+T8SePxiPZfOnVaErfh9onAVOjMu42QEHUJz7Wjvc
OPFWt/X4MI0TJno/Z4f+4QGlV8w8iLDtUKmNDoYZ8RF8j0vpyyiNt+utZ8jfbWk=
=sMCX
-----END PGP SIGNATURE-----

--1BXV+/FYeXhtv2WT--
