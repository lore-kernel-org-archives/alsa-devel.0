From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: WM8962: mark cache_dirty flag after software
 reset in pm_resume
Date: Tue, 6 Oct 2015 11:59:07 +0100
Message-ID: <20151006105907.GM12635@sirena.org.uk>
References: <1444115215-4388-1-git-send-email-jiada_wang@mentor.com>
 <1444115215-4388-2-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5H9Hz1/zx6zDf/+6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444115215-4388-2-git-send-email-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--5H9Hz1/zx6zDf/+6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 06, 2015 at 04:06:54PM +0900, Jiada Wang wrote:

> +	/* All registers have been reset to default value without calling
> +	 * to regmap interface, even if reset fails, some registers
> +	 * maybe in intermediate status, so we need to mark regmap
> +	 * cache_dirty flag.
> +	 */
> +	regcache_mark_dirty(wm8962->regmap);

This is a standard thing that applies to almost all devices, there
should be no need for such an extensive comment (which would normally
flag up that there's something weird and surprising going on).

--5H9Hz1/zx6zDf/+6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWE6l7AAoJECTWi3JdVIfQaK8H/3T/21Wzr7bprCo11JF9kEWl
aVYmljhvX7tOUktTpaLvf+JW1ZsvF75fj+9OfISNcB+Emz+f6tFEFmOujt5Y91Wu
KrEPqOrmQonPwaGosdtJbyeNa6USp6469dRGwOWQ6sghnp+2z/H2mfcXEut0tHgX
A1PTgBW65O1HUUwcPSijPpzOoHd6rI1AIWrEHCY46Hp2CmAAAtO/cvz3rmXuv6++
uCL9hQuSqTZFwoIqedg9HvnmiHSc+KRC58Ktkn3RXR/jf4KnHpB8CrOJsYBDfmG0
4Iisb4eH7C7Rh06BW3GLISOYRkhz+8PnvNmUO/6jyJ5PYSejLI+sOaHtb30ugh0=
=jMzS
-----END PGP SIGNATURE-----

--5H9Hz1/zx6zDf/+6--
