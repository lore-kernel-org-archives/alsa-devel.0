From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tas2552: Return proper error for
	probe error paths
Date: Fri, 25 Jul 2014 18:54:14 +0100
Message-ID: <20140725175414.GG17528@sirena.org.uk>
References: <1406104941.666.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5878306033626946282=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BE912608C9
 for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2014 19:54:20 +0200 (CEST)
In-Reply-To: <1406104941.666.0.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Dan Murphy <dmurphy@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5878306033626946282==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="onT/iYtSweZVW9zT"
Content-Disposition: inline


--onT/iYtSweZVW9zT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 23, 2014 at 04:42:21PM +0800, Axel Lin wrote:
> Return error if devm_regulator_bulk_get() or snd_soc_register_codec() fails.

Applied, thanks.

--onT/iYtSweZVW9zT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT0pnDAAoJELSic+t+oim9aI8P/Axbzn9Arzh55j7uew2PmBMs
2P9cPosuz9XkI8fOWTT6igE0Gm3AwgiaimtivY6uLJkGsJIl77kSL5TsxOi6W7g3
DUzCMZL1/aklSAAue3CTcHWOSAX3Dr+c5hQTfK+ALdU2OUQ6kPD/nMFnsodt4RRm
PW4yL5ELp7pPA1GDnkDQ8SHCsJDtuabJOpSReBxk1arR9AD466M3hdmFj91uXFhL
GI6kWQrFoKapc9NMFpM5h/1aGFkYXF6iN2CliYkvSr6vZS0/Jn7VcIIe0tabPYpD
QmtUdQsqTLuCkCkk1mVNuj86+qO/LM6gmCHsVfRXM18eTyG0KHeVrkJr+gwHdqs3
9clTYj+JLfaIgsRb/0tU5K5hu5kffoUj3jeEkFJ+EWaBAiMH6bFIQtQs4sK1vXMN
2Yg/p6TDVUimMFTy+naHKSSn9FtfHQI+ctaUF6Y6L8SZSWP620w+2P5WisvazzSP
MWX3Hp+7OroIiUnfPak66gD38Ccq0LmsNEdVe8tnP7TmtZyY/maVpg/TJHmDz/LG
06q1sn/Ae4aTaJTiF4sHQv8oFeuKxc/9SukdZ/W4u26JmpfiGsn4sJFCW3D3/xok
dFAGxGiYCT6wA4w9biirrCDnAnp9JbhqYmqMNsY2/aG80N2dljcBDPKJPy71WNCe
NHPNIVRo+VX2fB4KXGwU
=MXQZ
-----END PGP SIGNATURE-----

--onT/iYtSweZVW9zT--

--===============5878306033626946282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5878306033626946282==--
