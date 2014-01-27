From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/7] ASoC: simple-card: simplify the daifmt code
Date: Mon, 27 Jan 2014 19:50:46 +0000
Message-ID: <20140127195046.GW11841@sirena.org.uk>
References: <1390549386-4702-1-git-send-email-Li.Xiubo@freescale.com>
 <1390549386-4702-3-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GdlkuMH+DRYbUHkj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1390549386-4702-3-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com, rob@landley.net, perex@perex.cz, moinejf@free.fr, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--GdlkuMH+DRYbUHkj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 24, 2014 at 03:43:01PM +0800, Xiubo Li wrote:
> In the asoc_simple_card_parse_of() will parse the device node's CPU/CODEC
> DAI commone fmts, and then in asoc_simple_card_sub_parse_of() will parse
> the CPU/CODEC DAI's sub-node fmts, so we can combine the info->daifmt and
> info->set.fmt in asoc_simple_card_sub_parse_of() not while just before
> _set_fmt().

Applied, thanks.

--GdlkuMH+DRYbUHkj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5riSAAoJELSic+t+oim9RiQP/2Yer6UBGBm2QB+DoPtYmM2f
q2sKMAStrklSRBeAV6gfViRp9A8Lu7uC5Gpj9GXAbD9fUaS5p1+PwHokBlyNtja2
M8zZavu8G7Xof+kNK4/pKken+SRkbK3IA5Luk1CwVhpnvFQf4+DMUdUwh5F7i3oY
V0SGH7JnwpfVXeZA7wB9ZPysnJZ3vCwKcwd3J8CDGGIP2gZXfUW4EaLZQl/mtRab
OH4UVMyZqToHPrBtM6grJGvsnRtEDLwVdryMEhcVl1zRll7m3CrTzvdWmh8kLund
nwb7KLezQdqIYDLR26rQW6af7BXrp01/F20zHVXBthEGyFxgFeYymuXOV8fJfRuh
MDjDm1XXwCGnmczksmANufpZ2Kz6l37OLSRh/lhJTlJrecyuSmwKtTV0Bfgze7yi
3FY7xDQyWYH32OrP0C5WrwHnNdLmUOL8kMpcRTyfdqcyo643HJYyQETVaOikcWtu
j+j4KySCdF1mr/3QeRmLyw55v6CXg0PI3Zdusulb8/Hj253Tuoj34oFC9n24z8oO
Wu0e1BunUxhOHAdIE9Jtkx6y22Wm098BeyzRKiiN5dkp3T7Mx4lZckktBe+rzKVh
GmIgCUr4Y9LbU8alV7511UWpQ2hzflSVIDuso+GUN/F8x1rEMKmbR7pGX+HcCrpO
29pLxY2eDhg4JB5TlP1f
=AoO8
-----END PGP SIGNATURE-----

--GdlkuMH+DRYbUHkj--
