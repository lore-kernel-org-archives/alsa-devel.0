From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: byt/hsw: Add missing
 kthread_stop to error/cleanup path
Date: Sun, 1 Jun 2014 11:45:05 +0100
Message-ID: <20140601104505.GX5099@sirena.org.uk>
References: <1401436349-19202-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4836126197863793911=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C21E0261A49
 for <alsa-devel@alsa-project.org>; Sun,  1 Jun 2014 12:45:15 +0200 (CEST)
In-Reply-To: <1401436349-19202-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Imre Deak <imre.deak@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4836126197863793911==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yBbBYFH0ZHvzMoI/"
Content-Disposition: inline


--yBbBYFH0ZHvzMoI/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2014 at 10:52:29AM +0300, Jarkko Nikula wrote:
> From: Imre Deak <imre.deak@intel.com>
>=20
> Baytrail and Haswell SST IPC don't stop the kernel thread in error and
> cleanup path thus leaving orphan kernel thread behind in such a case.

Applied, thanks.

--yBbBYFH0ZHvzMoI/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTiwQtAAoJELSic+t+oim9vBEQAIhgdokOwQxN2GQbOS2rQWTr
fk/73w6LKE9N8Cy5wAl2PFGXVnMmw4BzbiPUwv7b0u4Cg6C4xKobnmUzXx9SKy3V
thijNQVZB5FKWqkSCta+hccIV4ERZS5YBofdkX6EKZFupeCqN1c/fn68cM8/Wmpu
JGJlRROxfMHVrH38b83cQuKWalD658BaPxwn8JJGHcW1wGnWP9iuOXHzCdxnWktj
lAsb4kjBy9ixItZN5JLEUEXHr34G+SdCDISBQflhbiC6eNs4DTUWSUM5ScV2iCOZ
aljKlHvP++tykByVo2kUEWHXqLG+jURPAAEBL8ovxXnl9H2uVCVEN0C9cqR1i/vJ
sVybEoshBxBiMZ88j8OoBKe8mlQ18G3ydl76aaPCmY7gg1CN/mSgVt5k+v2aqXae
Xqfz6eMz3OikPyrr6/D+lzfHdDQrs80pmzicqdDBNy8s/PDLfpKpES5Kxcb6lAk5
qwxMNjNz6K4wcs3aO9onjM2PBhN8OG+I1v+sdBLPCGgAnuedGbm3VVTAz9QTVKQh
thqDNgklpOtu8eM2UhjiBmz0BvlacsmUi2cCTSAW2shWq7kSooP2J3/1wdqZVigl
MlvbJ/fQAGIt5schc4lQz+o9L7eOWeyuVWV3GHwMN7s+Y8AgzxZuzynmpixusek0
URLi2uRzfxCrdu6zd0pO
=CZyc
-----END PGP SIGNATURE-----

--yBbBYFH0ZHvzMoI/--

--===============4836126197863793911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4836126197863793911==--
