From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: fsi: remove unused irq
Date: Wed, 13 Mar 2013 10:40:24 +0000
Message-ID: <20130313104024.GH25610@opensource.wolfsonmicro.com>
References: <87wqtehgur.wl%kuninori.morimoto.gx@renesas.com>
 <20130312184543.GO19942@opensource.wolfsonmicro.com>
 <87y5dsf7w0.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2443762435565302185=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 588CC265E0A
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 11:40:26 +0100 (CET)
In-Reply-To: <87y5dsf7w0.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2443762435565302185==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4C6bbPZ6c/S1npyF"
Content-Disposition: inline


--4C6bbPZ6c/S1npyF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2013 at 05:41:54PM -0700, Kuninori Morimoto wrote:
> FSI is using devm_request_irq() from
> 1ddd82868cc888e008ed520465c172a6cdddd689
> (ASoC: fsi: use devm_request_irq())
>=20
> master->irq is no longer needed.

Applied, thanks.

--4C6bbPZ6c/S1npyF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQFeSAAoJELSic+t+oim90aMP/jRCMr9EV8k8/52f/E4hXkJE
Prgmcmadg6vre57uN1r+g4unim2BmEnWnxYclXjAnfIZXPTVG0PK7/5UhnTBe+tj
/jVfveAISORcHF5DMHmEWdEY5mQk+80ABqEzg+hZaKtO5yryyuBjJ+RbHG9EFrJY
r+o3KeTYllg9Sk/ggjEjgFBzG5xmMlyvE009bqe/KK5VnL4K9vaXphaKvYYZvvrl
80SmcYvj9jnkknfT9itlRorO3ZKBYF1nDA6IzV+wETbA5uEGn8npgC5As0IKXaWm
Xr7b6aRNdqj8/LYH7nF+YKGFWcCuKzAl8U39zHecgoLRM0xYeM2U4ZvRHHos/SuB
wd7GGhc+bsQoinBwnxLkL0oRLob9MIgPbvf0Isc9nV7OqpeCmXdftEVMsiZxHMS8
Rs3omIly9dG1WwTqk9H01x1aD6wpo7aJl+og+0pe/urkrpxBwNywSADZlv+ZiB4C
4GIP6z85qZAE6tjThQeSGTlq726O8ujq4w6mgbO2ZtwqVaUNpp1JqlExgm4aLN0b
WMh7kRBDmVrv1F9BU91zd8rOM7kASoQYx6GWghRNi2ZZc74wEfrGIKiNQiQVPFsY
VfpO83ilR/0O3GRIOeGfQ9E7sFaBdMejvlFs3x64DmrQr+PfYiKp+AntU87m7AYl
ZnVK4WcJOtYJQbxYhvOE
=f3l0
-----END PGP SIGNATURE-----

--4C6bbPZ6c/S1npyF--

--===============2443762435565302185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2443762435565302185==--
