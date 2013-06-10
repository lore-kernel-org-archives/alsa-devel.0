From: Mark Brown <broonie@kernel.org>
Subject: Re: Codec driver gets probed prior to the machine
	driver
Date: Mon, 10 Jun 2013 10:14:36 +0100
Message-ID: <20130610091436.GF31367@sirena.org.uk>
References: <CAOMZO5BzaAmt0BNXvSw+a18QorOBmEjGwaA5PoQ_D6mVb6QiUw@mail.gmail.com>
 <51B49B79.2040007@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3811353988640233000=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 01D7E2608D3
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 11:14:42 +0200 (CEST)
In-Reply-To: <51B49B79.2040007@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org


--===============3811353988640233000==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="THRyzaXkjSsfugGc"
Content-Disposition: inline


--THRyzaXkjSsfugGc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 09, 2013 at 05:12:57PM +0200, Lars-Peter Clausen wrote:
> On 06/09/2013 04:50 PM, Fabio Estevam wrote:

> > The reading of the chip ID fails because at this point in time there is no
> > codec clock, which is turned on by imx-sgtl5000.

> This sounds as if the CODEC driver should enable the CODEC clock and not the
> machine driver.

Well, probably both.  Remember that we don't actually have a standard
clock API, even the generic clock API is not available on most
platforms.  Though frankly I'm getting fed up enough with this to just
start using the API and getting platforms that haven't provided one to
deal with the issue since otherwise I'm getting very little traction.

--THRyzaXkjSsfugGc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRtZj4AAoJELSic+t+oim9iWwP/jIZnqg6NV2ATMB4egqHUvvE
wF1DzhlHkEmvoY2Ui9GYYMyXuWYrpKRjJlone2OXohRhjz3PqRZ2dMSaPp5ezeJF
Wy3hUhVeModCBPdFygQdENRJm1qQy7fkbasGlwIplZzIUnXw6aPpBj+dv3imx2MY
mP0FmWI8lRRoBw+vS2jQJFPuTckBtXxb+spXfRCyJvqC0dl4T2UZj4DimF6KKqZa
WKfKH0Tu6FpxZmEQcltQf/8xplsRVYrv9Z5dN9YurVwhy9EIPSfIZimmtB2+sZNX
hm5AzB55e3NeJ2xX7zyU5sjUYvxjHZLD0IWFHRUf70G2CcgcVjlaqygkzO7zBM2V
XxoBu4Nr217cf216WIelcii0DaNp+RNWiVYjk+hwArp2C6yi20qrRQK+44fNd3q8
400RTfiQXAY4N4Ng2CN+ibCPa8fS/SHSr8KbKrA4qHqTI5wdGsaKEb3b2pfFEEyH
r5qMfdgLRW5EoG5EyG+lbGx4ToHC5URAr86eBgR9hCeyrPn1sbfmiFpuN4A5pTb7
Pjd5KTVn7da/RziUcK536AWjbDoXDlS3EHqkjyjtdSFTjuyniVPLZ8jdmdatpTjf
fFY0dMxDFSmx7wejlfoELGxEe0UhU662ZR4YPvbry1kC7Vjyn6TwXcySx8p/16AP
jmtCcje7jUTQm2gldRKw
=qjNX
-----END PGP SIGNATURE-----

--THRyzaXkjSsfugGc--

--===============3811353988640233000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3811353988640233000==--
