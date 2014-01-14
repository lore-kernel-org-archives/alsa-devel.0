From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/5] ASoC: pcm: Properly initialize
	hw->rate_max
Date: Tue, 14 Jan 2014 20:42:58 +0000
Message-ID: <20140114204258.GY15567@sirena.org.uk>
References: <1389432284-6792-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1581371889592114341=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E1BB2264FD1
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 21:43:05 +0100 (CET)
In-Reply-To: <1389432284-6792-1-git-send-email-lars@metafoo.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1581371889592114341==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="72btQdUC6twB1rwh"
Content-Disposition: inline


--72btQdUC6twB1rwh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 11, 2014 at 10:24:40AM +0100, Lars-Peter Clausen wrote:
> If none of the components (CODEC or CPU DAI) sets a maximum sample rate we'll
> end up with the rate_max field of the runtime hardware set to 0.  (Note that it

Applied all, thanks.

--72btQdUC6twB1rwh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1aFPAAoJELSic+t+oim9MlUP/RFVNdX6CPJUSVsW45PWYHy2
evfvuD60f10WtObKzIyDf5BL9Jruncd2p8mHKc2UMVBsEXPb8Bl/XLfpkVOEXVPI
i9OeJUo0cfy8wT/H47QpfuCkDmn0rza2dGfABKdHElqblnVRx+56X1kii80U3uB3
YiWO55WlV0bCz3cmzvnUCmKSoYaxwX3loZ1obNOqXz7A+OYbXCucvOUc4ztQK+KA
/okFEOtFg+07tmyFZ4Ddus3ovUgYedPfgeaoNyBGY4Qmh9gzUsaAkZCVHFThJbsi
DxD6AQUAU+DIGYDFFGLeHlAR2xSom2mMDtjeBcvfZsiXuJVqzULrJcXhhlrbu8+d
/V2TNIpJnVonkVJuF3+r5yHyOL8eC/S6Q4Oj4Ct0iKdh9aP+VlHV1kYnvuNb9neD
mVvKBrIICZMDoMDkgGu5hx0bU9PbS5PT9OVYtSPMt1jTLyCTWcInZePv25C8HXpr
ycT3QGqxLs14kr12xq39pT3Nc3ohJGVbcmVX8Trb+qr7ZnTlQ8x3pB4OYk/u/v1T
ey6Ntd/QYrk++yAFB7V4HmHDi9cKDYASmNjvd2gJ/d8QW70lSsTIUDElcshqZ0hB
Ot0vL5ZP2DKUeUWELMwyAL0cdoLQkYFpggAhbjwOASg03urHBdRWO6Bzp/8sfamn
nXDqarWn4ahrfiB6PPoJ
=YL5J
-----END PGP SIGNATURE-----

--72btQdUC6twB1rwh--

--===============1581371889592114341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1581371889592114341==--
