From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: sgtl5000: Fix driver probe after
	reset
Date: Fri, 10 May 2013 10:09:19 +0100
Message-ID: <20130510090919.GH3200@sirena.org.uk>
References: <1368045961-31213-1-git-send-email-festevam@gmail.com>
 <20130509100052.GC7478@sirena.org.uk>
 <CAKGA1b=nHcw4bBDgU-9X-0-+b9J58vi_Az-_h+4ptNEvEC4OpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0861231738567918681=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 99E2C2610D7
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 11:09:37 +0200 (CEST)
In-Reply-To: <CAKGA1b=nHcw4bBDgU-9X-0-+b9J58vi_Az-_h+4ptNEvEC4OpA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Eric Nelson <eric.nelson@boundarydevices.com>, "troy.kisky" <troy.kisky@boundarydevices.com>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0861231738567918681==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GBDnBH7+ZvLx8QD4"
Content-Disposition: inline


--GBDnBH7+ZvLx8QD4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 09, 2013 at 12:08:38PM -0500, Matt Sealey wrote:

> match a reset chip powered on for the first time. What we should
> actually be doing is dumping these into the chip as the first thing we
> do at probe, and then they DO become the reasonable defaults.

Yes, this is eactly what I keep saying :/

> The fix is keep using cache/regmaps or whatever, but it definitely
> would be an absolute requirement to reset the codec manually by
> putting in all the right register values before using the cache, which

You don't need to disable the cache at any point.

--GBDnBH7+ZvLx8QD4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRjLktAAoJELSic+t+oim9NekQAJ5NifNjj5X7pThAfO+SeE5F
5l3oNq+OLiPPokQq7rt8I5cGoZhsY+PxDzQdlgfZYHkytkP1FH3aEPkaKU0nptgN
nGSXKU4N/u4IE+6p+b+nrkcIjfKjKlg9eL8Lacw887d/qgktYF0e/6WN+uJNCCES
Evq47AGLNmK7toR9LV8nwY9hsZ7RV5TSHCLEFEzM+NO1ppRWN7llpgx7RTIefdzy
TOHLH0ybDycRu//q4OUhUk2K+RpymybWy4uzCKgx6dU4szj5j1gmyB6zn4tayDEh
antPIwYfXYmT5/FNy1sD8+PJ7ODy0/ULqbjVDzHyna1SnfOCB3OwHLvKx7BWat0p
XF0BdFVJMrCzAtr6DFU6h7TZd9ZuWQaW3kVsRqFhECJT5PT3Z5uREUY9Xl34rVyI
vwaimjcZS/eJldLONS8WJ+ZguFd/OKzuNTNB0SEaV6rE6FOPiBukbRRtGnB2awTW
PjC4D4YCipJ79Fiwa1w9C4Iw2Urw+0DRHQpG4ex7Wq+FzygUGh0qfgcohXu7KEPw
r1VBNTncYBMJGDMbm20gDkrLVzp2H+DI3cEsugvTfH9emFWFNhVds2LNBF1B/IQn
UGnWcLdWhXgdjQBff+LSFOq4ztRLicTZCPD7+8Txm7FujpIez8Q57WiwMw/1dJGu
U9ObTQUnbWmjQa7QIG6u
=AMRJ
-----END PGP SIGNATURE-----

--GBDnBH7+ZvLx8QD4--

--===============0861231738567918681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0861231738567918681==--
