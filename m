From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: Samsung: Fix build on
	multiplatform
Date: Thu, 27 Mar 2014 11:14:32 +0000
Message-ID: <20140327111432.GI30768@sirena.org.uk>
References: <1395907197-12637-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9019341435924724103=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 19B562652DA
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 12:14:52 +0100 (CET)
In-Reply-To: <1395907197-12637-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============9019341435924724103==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X+nYw8KZ/oNxZ8JS"
Content-Disposition: inline


--X+nYw8KZ/oNxZ8JS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 27, 2014 at 01:29:57PM +0530, Sachin Kamat wrote:
> PCM and S/PDIF drivers referenced mach headers for a trivial
> data structure. This caused build errors on multiplatform builds
> as machine headers are not accessible from driver files. Move the data
> structure definition to the driver header and remove the dependency.
> While at it rename the structure to avoid multiple definition errors
> as the same structure is also used by the platform code.

Applied, thanks.

--X+nYw8KZ/oNxZ8JS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNAgVAAoJELSic+t+oim9AloP/jvGxVOBfwgeAhz/sW9auTMd
lJbhg2aDMXNmJBdCEAA4KqtTED8L74dx+v2i+8qNzPvd3DjFr//1zApx7QrRcTLk
NDBXL9hgY7XaZFXFxMPWvaCQAQjtXS8xRmvSm6X1xVJwWD+z55taNtsvnOHEhtNj
mpabIsKNcs4uemYjNoDUofJIquszROASBYgycf1yehP2FfaUjKKGUW8aFXLDi4/L
VVvGhKl2usg+TBCq6rwrOsUs/lh05WND1rYNvbn2Ef7o68HOLNwmkCkh5G1Dimi8
BwhwiIQi/n6CRkzkILpUwvotrNOTOybGj7lfLkk6Igk9IkG4B/MKbk6J8JLt4HXs
eqVjIRowSe3foBsPo0A2wm845EBQHhBMlriqWyU/4DrA4iGWKaK501+7sFZBBqRK
jsdoG93zA0oyd7XAy5wA22ofmmxgJXurv6fRukNTRxOywZGw/IPctAKXcno0n+Yl
YXIobL7BywQl0vdv2TfnZzng5zrfjaYR0PIc2t0alLPogi9LLP4mgtvvu4CjmrWM
lt8OqBUEsGH3ybZlxSRFI2K6RGfCpmUlK707WUlK6RzCpc9VGrESLOBzi7vghxMK
SFlTx4rezVAlYGBrGXtd1o1eWnBIxlfZFIGEaOMiGUySSNmNHEtYbKnaLKAzed5Z
5TmgvVHru4+rm8ui9rvi
=2cse
-----END PGP SIGNATURE-----

--X+nYw8KZ/oNxZ8JS--

--===============9019341435924724103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9019341435924724103==--
