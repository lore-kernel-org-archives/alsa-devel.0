From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: no dapm match for AMIC
Date: Tue, 4 Nov 2014 11:51:49 +0000
Message-ID: <20141104115149.GO3815@sirena.org.uk>
References: <CAOMZO5BUx+mhhELKJw5S8jBMJGHP5wMW5A0kwNAScbOmHMvbUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6332197033032724274=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D25E02605EC
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 12:53:03 +0100 (CET)
In-Reply-To: <CAOMZO5BUx+mhhELKJw5S8jBMJGHP5wMW5A0kwNAScbOmHMvbUQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============6332197033032724274==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="15+E349fsei051WC"
Content-Disposition: inline


--15+E349fsei051WC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2014 at 09:48:25AM -0200, Fabio Estevam wrote:

> I am running linux-next 20141104 on a imx6q-sabresd board and noticed
> the following error messages:

> [    2.145602] imx-wm8962 sound: wm8962 <-> 202c000.ssi mapping ok
> [    2.151654] imx-wm8962 sound: Connecting non-supply widget to
> supply widget is not supported (AMIC -> MICBIAS)
> [    2.161710] imx-wm8962 sound: ASoC: no dapm match for AMIC -->
> (null) --> MICBIAS
> [    2.169258] imx-wm8962 sound: ASoC: Failed to add route AMIC ->
> direct -> MICBIAS

> What would be the correct way to fix them?

At a guess you've got the route between the microphone and the bias for
it reversed; it's hard to tell without knowing anything about the
hardware.

--15+E349fsei051WC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWL3VAAoJECTWi3JdVIfQES4IAIbNGsNqFlhhCeqoSVum7fIE
DWnlrH9jVJp5brMD8B+UzQtNDuNp9VuEjFvReQz4p7e4ppqtCVRx359HZ4Twf7uc
rEEUoxbfzMXb2h43+LADw1m5cbnzViANRExv42LoIVIZNi6jX67F97BoXGrQjTlY
PzXS2oW7m+tIKkXnCShMeSheB12ioQGBeYwdLroUqcmi7/7njDeLc4ZUC8gsDnBN
0ekzBGnPkH975LTVYEL4Gbh6M6AMqnh+i61fQEKXTuWE+zZ4AmkqpK1MmpvNWmk6
yyLAz4++9Mr/lJvwdAt2IMQtQDu5nVhmtWxVbMW9o5Ntloq+1E04gnujOKiIk1k=
=arSm
-----END PGP SIGNATURE-----

--15+E349fsei051WC--

--===============6332197033032724274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6332197033032724274==--
