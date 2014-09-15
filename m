From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rockchip-i2s: dt: fix an error in the example
Date: Mon, 15 Sep 2014 09:45:50 -0700
Message-ID: <20140915164550.GV7960@sirena.org.uk>
References: <1410570281-23681-1-git-send-email-jay.xu@rock-chips.com>
 <1410665999-16718-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kUw25p3LpPv7dNi6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410665999-16718-1-git-send-email-jay.xu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jianqun <jay.xu@rock-chips.com>
Cc: heiko@sntech.de, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, huangtao@rock-chips.com, cf@rock-chips.com
List-Id: alsa-devel@alsa-project.org


--kUw25p3LpPv7dNi6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2014 at 11:39:59AM +0800, Jianqun wrote:
> Reference to RK3288 TRM, fix an error in the example by swap "tx" and "rx=
".
>=20
> Table 10-1 DMAC_BUS Request Mapping Table
> Req number	Source	Polarity
> 0		I2S tx	High level
> 1		I2S rx	High level
>=20
> Tested on RK3288 board.
>=20
> Signed-off-by: Jianqun <jay.xu@rock-chips.com>
> ---
> change since v1:
> - modify patch's changelog as Mark's suggestion

No, the patch has already been applied.  Once a patch has been applied
don't resend it, it can't be re-applied.  In this case the advice about
the changelog was something you should bear in mind for future
changelogs.

--kUw25p3LpPv7dNi6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUFxe+AAoJECTWi3JdVIfQHBsH/0Bd3gC6FkXjlEGXhp28nNCE
x0nmOypVyGISktCZ2gCe/3f5TFsNh6le9oRQBI+PJjeoNG0E87gD4OBAmHDZcUOn
tfi2maUwoc4/5YWLqWTnxkoftppHh+Xqpwj05nnJfBAXu+yZ6sGsQbX2YpsAcHRW
rGWroauzL4W6R5DZdADoIfKeFiv+DaTC6lb/J6KITuxQCiikz+vtaIk3v8GJ9bNl
5pvgqVUlKBW1O9AL/bWCkKdEkpjzpcIpHxkYdJKKeA5SDj0aAto0lKp311lkwcAK
tW4Gp2o+G4hDVN0Gv7tZuEuglzz1TWPAZ+99GeSRl8kXRkkUiGKzzG6FwLjQ0aY=
=1Ikx
-----END PGP SIGNATURE-----

--kUw25p3LpPv7dNi6--
