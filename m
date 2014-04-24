From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 00/18] ASoC: fsl-ssi: Driver cleanup
Date: Thu, 24 Apr 2014 12:44:03 +0100
Message-ID: <20140424114403.GN12304@sirena.org.uk>
References: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0685665661388369124=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E171265253
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 13:44:31 +0200 (CEST)
In-Reply-To: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Alexander Shiyan <shc_work@mail.ru>, Timur Tabi <timur@tabi.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0685665661388369124==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+UcPPJ8XrU2q8Gei"
Content-Disposition: inline


--+UcPPJ8XrU2q8Gei
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 14, 2014 at 03:35:30PM +0200, Markus Pargmann wrote:

> This series is a cleanup of the fsl-ssi driver.

There's been some review comments on this series but only negative ones
and I've not seen any testing reports either.  Are the other patches OK
for people?

> There is no DT binding for regmap yet, as this should be solved in the regmap
> framework first. The current configuration should at least work on the same
> SoCs it was previously used. As soon as we have a common DT binding to set the
> endianess we replace it in this driver.

I'm really not convinced that this is a good idea to be frank - I would
expect devices to still need to be involved to set defaults.

--+UcPPJ8XrU2q8Gei
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTWPkAAAoJELSic+t+oim9OtQP/iKYfCTbYdfHcaAbnL5Tz99i
yhN1re60qsNbCTkhVW7R6WqJj9pY8E0ogM5mNMZgqoCqNFjK2CHRYvkwd/Mb0Yoe
NCNeoWVzVd1K51npI012SeMODtymHwFQbUrLNW2W+YWQfxXttCTVqQD8O3sUFDeg
FopUeMDTzLFOzW5nKzwo8uS1mByK0bBySHqoXprbBFdgDF7S9wI4yqTMsph080+k
UzwZpfGBCtzFKG4X0T2XqFdKWAJ9a9dNgzltBMnAmE8eGz29f+mhKMSHVykSge1h
sd1hWEx98KUi6dSZ1itsVl2RI3RGqhfAPVZPoWvU3sc2QqB3qmrcMj8hGM24y2Ee
eRHGBIe9p5bCSUTvJkXcnubiKlLfPSkihhaqijvN7wMAbbZ3NZLnVYVcaPNMo0Zz
nyIu+miYiNEjj/qk3FeIZLVSf2syh3cW/1GyjpTx4dQFQt5fXqgkUA4KO05kKyV8
WSx4+LL9fw5tuBKjYA1JkI15FmsYeR/wDgoKgNL+zAnFnd3GM+TdrLuk/3pKO4yN
Bb6KXMrfA9gEGTMIgCRQziFXY0kt/KITuILuuMzo8t2EsSuvuIu2xKfmQNlLYI8D
QRhHzxoFKtdQHX84wJ3dNFt20LQ44XToETAzRJqfJCvK8cKcRog7R4XJkciNW+1H
B0Gy+ZIjZCjFSsmSI7aU
=MTcl
-----END PGP SIGNATURE-----

--+UcPPJ8XrU2q8Gei--

--===============0685665661388369124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0685665661388369124==--
