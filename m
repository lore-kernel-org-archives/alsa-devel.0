From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Do not ignore errors
 in aic31xx_device_init()
Date: Fri, 25 Jul 2014 19:00:46 +0100
Message-ID: <20140725180046.GI17528@sirena.org.uk>
References: <1406283174-32271-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5223458475890832187=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C0ED2608C9
 for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2014 20:00:53 +0200 (CEST)
In-Reply-To: <1406283174-32271-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5223458475890832187==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZZTOI0WqqOZ0yWqI"
Content-Disposition: inline


--ZZTOI0WqqOZ0yWqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 25, 2014 at 01:12:54PM +0300, Peter Ujfalusi wrote:
> We need to return the error codes from aic31xx_device_init() and return
> from the i2c_probe with the error code.

Applied, thanks.

> Would it be possible to get this patch into 3.16?

I've got rather too many patches queued up already that ought to have
gone in but didn't get sent yet so it's questionable if anything can go
in at this point, we've hopefully got at most one more spin before
release.  I've added a stable tag to it so if it doesn't make it then
it'll appear in a point release.

--ZZTOI0WqqOZ0yWqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT0ptLAAoJELSic+t+oim9NzYQAJexSGYyGmPzYmEZB1CF5h5/
uGFea/XubzFJP8dvdDl13UMdwZinwHB9u6piy+Do6udYCwsOtMRaAevtlShZRDyH
4OAcXmAEJVV1LORiivx2A6LHnZR9val8+CPfH7QHUuz6cUTEiMld4glqxTUh41uM
txSm0HHLv9jXvyRvlGguSYtgOjZ8lNUefLkCHWTc4GEWqvkT2vZ5RQjN6U2cPTnG
kj+Z/cqw2oLEOHp9RK/dHzSQqgUPOxCqz3USgKCT8yzWFwm6eSlhiQ68q9h9m4jn
5XfLcP7jL+ghbCLFpg7rnYJY9au98+fEcUXT2NiGJdxixT/fgB3/CjgC0tbf19Ti
KaaqlhSmA68k+0fwRctDyy20SpcVS0clqojcrhFIzptNFvSYhy3Qs7FnKDXd5MI/
4RlgXtiVpptlFnf5NumNIlhaUwRuZl/oloEO5JhIyePeenM4sTKPAAyJr9pcW9GC
dkX+HV8rBrr+lvsmLunwiz5t66/nFCvM8Jjz/HzXfYXhmtNYj/nOVLvYwUiPHgaY
9BkA1GOKkFvP0rmY9G+mPQwgdGbFxRRYnpbTs5MbYJD0TlqiC0IgQ46H2Z1we2Mq
eQFteFWeTn2xbKTB2S68lcjmIntMC/HS7YjmIRzp+aYB5DAO6kIRF8DrfXnH8T53
xB5YcVRP/JBqxxqbKYwe
=6uIN
-----END PGP SIGNATURE-----

--ZZTOI0WqqOZ0yWqI--

--===============5223458475890832187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5223458475890832187==--
