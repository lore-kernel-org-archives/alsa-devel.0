From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] Revert "ASoC: rockchip: i2s: remove unused variables"
Date: Wed, 4 May 2016 16:10:28 +0100
Message-ID: <20160504151028.GW6292@sirena.org.uk>
References: <1462373686-21794-1-git-send-email-john@metanate.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lGQpFNrcSq0Rb43w"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462373686-21794-1-git-send-email-john@metanate.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Keeping <john@metanate.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Enric Balletbo Serra <eballetbo@gmail.com>
List-Id: alsa-devel@alsa-project.org


--lGQpFNrcSq0Rb43w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 04, 2016 at 03:54:45PM +0100, John Keeping wrote:
> This reverts commit 5938448b99275cba95167c3f9d39ca9225fdad38.
>=20
> It turns out that the commit that made these variables unused is wrong
> so we're about to revert it.  Bring back the variables in prepration.

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.

--lGQpFNrcSq0Rb43w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXKhDiAAoJECTWi3JdVIfQkJwH/iqYqPaoDB0D/aVvZB5qk3pl
VlGveRZqO6f3hVzabVRGBSoh+eiHVbbTIhSIu/FyXhQp1eNmxCbsz3ntO9v6sR0K
mDQ6hRsFm7hZ926QHLkbvPFWBGtM/k+Vw5CmJyMXO1kQVdI9V03FauJJ3zpXbBbO
YKY80Zt7Z8eZlapxOGTxChLuuj4dQXBsWCo3mpUjm9UmWEzbusWqfP2Dvn7y2WdL
xu791e+UYkIlZxZsCJ5aOT3ddF9hEaflkju4TYXGwdybesHlSeB4WpRVUAnnazpU
ad0xtODIp999HCB7Pldcj66bbgc7q7JD12rGbtG7V9kjIAlvwPFflx7e45VRCQE=
=jPVt
-----END PGP SIGNATURE-----

--lGQpFNrcSq0Rb43w--
