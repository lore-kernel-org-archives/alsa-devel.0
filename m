From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: use regmap_mmio instead of
 original regmap bus
Date: Tue, 29 Jul 2014 13:07:24 +0100
Message-ID: <20140729120724.GT17528@sirena.org.uk>
References: <87r414obt2.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6519480275600467982=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 63E6B2651B8
 for <alsa-devel@alsa-project.org>; Tue, 29 Jul 2014 14:07:35 +0200 (CEST)
In-Reply-To: <87r414obt2.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>
List-Id: alsa-devel@alsa-project.org


--===============6519480275600467982==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zLaDioFsM0hUAvZz"
Content-Disposition: inline


--zLaDioFsM0hUAvZz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2014 at 12:37:31AM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current rsnd driver is using regmap and regmap_field.
> It used original regmap bus which is
> single regmap instance for multi register mapping.
> This patch modifies it to use regmap_mmio bus,
> and tidyuped probe method

Applied, thanks.

--zLaDioFsM0hUAvZz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT1455AAoJELSic+t+oim930gP/1tNk7sWtUb/U7NhLlHpz5JV
K6kMRNEz3yXYK7cFLFfBIUOYJk4lmVHtrZxUFONu7IgAWG/3Dhue9Bp+3wqoA33m
TsBHJM8cKE/zuumt35mLWGjp8JA61OABgVCHZeUCAavxmVB5byaNSMiQGKyKzR3e
D1w8eNO2HEwcvdKap5RW0fBP6ysw56Yt3NfV+lFy9YjwjOEK+Hp3/TZ2HBq4U6AZ
eFRfGXgQ3aAGOYo1f3KcoLpv3zs5P2SE8+VD66x/0jB4xuP8Sju1BU8xNWQxJdZ/
PoOdz1XJE5UZLW6/ayMydizuu9cDCYocsOO7xV+HA+Kueu+dNuml4R6izyF1ocH0
QkfK9fNRaNWCTbutvseInNh4N4JuBvY/luCDkFDK9bv5mX5vG+qseFcEH+BwyYUn
/TalDHqVwg3gYa8DyjVBX+E5Cq1xwcBgl3ROMXtkP+QfXXB8wLGNoZmG9aUdffru
Y98JXDielOUMKtb4kbnS9ndEW+djDKMoQxSK7+Wk4tCKSnDBwwhFCKXxc/v0K9+W
7KPnZQtcq6/EJz7gT3ECTENBRT5xXLbR8O/YhwunsQAEAAyDbwaJ/yKyWaOfT8WI
G3mclFKEMgntq3qdwUMyJLZ4/4ulYakqbAIcRwJz+yhXGONm14Tq4iOHT2vFKL8l
WzAYuGxxACyNoEPHxL89
=XwNx
-----END PGP SIGNATURE-----

--zLaDioFsM0hUAvZz--

--===============6519480275600467982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6519480275600467982==--
