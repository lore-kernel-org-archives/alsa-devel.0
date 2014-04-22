From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 5/5] ASoC: Remove ASoC level IO tracing
Date: Tue, 22 Apr 2014 13:25:40 +0100
Message-ID: <20140422122540.GY12304@sirena.org.uk>
References: <1398165797-22997-1-git-send-email-lars@metafoo.de>
 <1398165797-22997-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2134029809397183251=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 880102625CF
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 14:25:52 +0200 (CEST)
In-Reply-To: <1398165797-22997-6-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2134029809397183251==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vg2NstDvmsiE62Z7"
Content-Disposition: inline


--vg2NstDvmsiE62Z7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2014 at 01:23:17PM +0200, Lars-Peter Clausen wrote:
> The ASoC framework is in the process of migrating all IO operations to regmap.
> regmap has its own more sophisticated tracing infrastructure for IO operations,
> which means that the ASoC level IO tracing becomes redundant, hence this patch
> removes them. There are still a handful of ASoC drivers left that do not use
> regmap yet, but hopefully the removal of the ASoC IO tracing will be an
> additional incentive to switch to regmap.

Applied, thanks.

--vg2NstDvmsiE62Z7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVl/BAAoJELSic+t+oim9+kEQAIgp3bcIFji/xHizXxLynXf3
YbK1f2BtPWfPOIB3cWIrNvxR3yEx6N9EgpFLAigPgk1nXnvXDF50dkfk8fdwsgQl
naUtnU898SjqlkENAhOXXLq5I32tqC9tXHV0mKcLyx9CtGZLaC8mvu+swKsx1pyY
cutzLEii18X5J9ebdfC00Hw29brkY1YB6CUvEfDFX5jACLdwC4PgRnTGX+HI7qxb
C5uG953culZCD4QbOYDU/ei4PPkWDap1rJUYxw1Hh0c7AUlfmnbbjMlSIlSqa4PT
gqJCpeXQVbfXnQ1LB1u0Ufk8MpICdQaZ5QI+19birXRlX09Ex2P8lJWVkW5Mwto/
+S6m9Z1XqxIPYgNLdncQ66c9CFEYTKli+371aos/L9Lw8WYWkbzJjoAM/Tv7AwK/
XTcBrydnjdlJXzhQOs1TR2FpmmJlrXXMod4o/AwvecVDtzXyYLBoDHbzOairpulA
xg7540ELAZ4ofGBMTRYLpG4CjvUP7RannzQXeK6Sixz4P5oejIPhFiprE88Cwuqg
IoxKdzc8H5DiMWqxcI9BIFmU3Hpib8a1RkcguAo9z0bxsQRCFenub/vljAG5Z8a2
LJ7/dPhK8qqJueALD33Lk87ePE8EuvZVqVOJbHkZKrUsY7dSLwmzWVoncC4SNAPh
L0OMw8dDKwHod6X15+Pg
=z48c
-----END PGP SIGNATURE-----

--vg2NstDvmsiE62Z7--

--===============2134029809397183251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2134029809397183251==--
