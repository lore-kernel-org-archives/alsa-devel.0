From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/4] ASoC: imx-sgtl5000: Let the code
 clock be a mandatory binding
Date: Wed, 1 May 2013 17:53:01 +0100
Message-ID: <20130501165301.GT26160@sirena.org.uk>
References: <1366815286-31820-1-git-send-email-festevam@gmail.com>
 <1366815286-31820-2-git-send-email-festevam@gmail.com>
 <20130425051654.GB1389@S2101-09.ap.freescale.net>
 <20130425110127.GR5019@opensource.wolfsonmicro.com>
 <20130425143522.GA7504@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3316853659466925827=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 34E73260309
 for <alsa-devel@alsa-project.org>; Wed,  1 May 2013 18:53:26 +0200 (CEST)
In-Reply-To: <20130425143522.GA7504@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============3316853659466925827==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VZEZlOQeSr/zV9d3"
Content-Disposition: inline


--VZEZlOQeSr/zV9d3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 25, 2013 at 10:35:24PM +0800, Shawn Guo wrote:
> On Thu, Apr 25, 2013 at 12:01:27PM +0100, Mark Brown wrote:
> > On Thu, Apr 25, 2013 at 01:16:55PM +0800, Shawn Guo wrote:
> > > On Wed, Apr 24, 2013 at 11:54:44AM -0300, Fabio Estevam wrote:

> > > > - Rebased against Shawn's tree and remove mx53qsb clock fix, as it was already
> > > > applied on Shawn's tree

> > > It seems that you expect the patch to go via my tree?  In that case, I
> > > need Mark's ACK.

> > Well, it's a bit late for ARM changes to go in so I guess it'll be
> > sorted out after the merge window anyway and can be applied to the
> > ASoC tree after that?

> Even worse.  The dependant patches in my tree are 3.11 material.

Oh, that's distressing - I guess there's more than just the fix
mentioned above?  Would it be possible for you to provide a branch I can
pull into my tree for v3.11?  My workflow is easier if I don't have to
worry about having potential collisions with other trees.  If it'd be
too inconvenient for you then I can cope but it'd be nice.

--VZEZlOQeSr/zV9d3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRgUhqAAoJELSic+t+oim9aroP/jVYk8tgRdTy0bjKycrS2+rS
Wg3cPeauQsAVeFhhCBaxlmwoeLcq0fSouMm7Kvbh68E64AxE97fOoq0EJjJ0A6Kr
ptKfDYs0YwxkWZWYPM7hX8o0CcyH3BoadnGgtJht4KlSWQ6iPsq0dbuEX9Fq8Fhe
7/xX7I214p4LxqvPfGPgZY9Rfb895l/99rNTGN3Fzyei7hA7f+YBkx8Ctr60jgmo
hHQirIVAmO1KT1rXEmFcOy4T8OXn5/OgnIYGAsZa/nCbW36U4GKIpdxUl1kCKFcj
6U8ABqveFsMdJwxE9yGIkE/aknOqZ6mL24QkYGEuL1CGLLUPqPqTBHjJHYFxp0yI
RttJImtKwFx15VBqoqZ7Ip7cNfe6Ck0dPD1MpcFzwYm3e6vHdw4JkpT06uccUMk5
eOepmYr4/SvAZWpwvrN8qmub2+3FYomIIw9LQPrhU4BiseB5Oe4wu4wcgS73rGNO
62yFBDXYRjw1kZNcJc/rixm7figGnfqVSIAqYGmZW5ol+mFw6adEO865co+GefpM
aYowRxRiNExWbAYRXiIDjt2j+nugws+nFEld5hLLMYh3sin++4Ylx3DRz01LCP0a
y19CFd/ub2otfpcExkBRF242KZdkvEWlA5zRBALIZFhV12n0fMYLeZi0JCcp7+pw
mpMhxY6iQPUGG4qq1rq6
=rndz
-----END PGP SIGNATURE-----

--VZEZlOQeSr/zV9d3--

--===============3316853659466925827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3316853659466925827==--
