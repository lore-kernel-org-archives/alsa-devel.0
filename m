From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cirrus: tlv320aic23 needs I2C
Date: Sat, 21 Feb 2015 18:36:34 +0900
Message-ID: <20150221093634.GK6236@finisterre.sirena.org.uk>
References: <5891241.bLtA2KsrYg@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6585383607230979735=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C596260638
 for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2015 10:37:26 +0100 (CET)
In-Reply-To: <5891241.bLtA2KsrYg@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Ryan Mallon <rmallon@gmail.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6585383607230979735==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5dNcufZ4prhark0F"
Content-Disposition: inline


--5dNcufZ4prhark0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 18, 2015 at 09:43:13PM +0100, Arnd Bergmann wrote:
> The tlv320aic23 codec is selected by the ep93xx snapper platform,
> which are missing a dependency on I2C, and that can result in this
> build error, as found during randconfig builds:

Applied, thanks.

--5dNcufZ4prhark0F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU6FGhAAoJECTWi3JdVIfQ2jwH/j0JH5yI3Ui+6Yb3ID2dIHf4
xpSO0q5eDi/lGS3bNpdYKA2T7xlPF7Jqtf36YImUGhSqiOnEQVzy7J/zB8AgAkZA
zPRo4AGSXBopPI0SY4ymWglAUhxFRkulJP/Or+JyoHUrrErmiLRzY2Iqx5pCGQ+w
B2z86ABLvbXhhzMtd2wStTGGNCB3hWood2OD5AmcY+qMPkLJe/EnLsJfiU1d//xo
8wXFSiRY/hVlqiazuS0mHtJrMYI9XYm1QHDM+LadEOCFS9cNJ8Wmwds2VegjQ74F
tHOyElws2tpRDZP1AoXgJz71UB2Doz+BuXilc+lw3r6FMVs4YCVW+HB9D9YSwlU=
=rlOK
-----END PGP SIGNATURE-----

--5dNcufZ4prhark0F--

--===============6585383607230979735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6585383607230979735==--
