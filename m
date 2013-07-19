From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: wm8962: Do not call
 configure_bclk() inside wm8962_set_dai_sysclk()
Date: Fri, 19 Jul 2013 18:46:11 +0100
Message-ID: <20130719174611.GR9858@sirena.org.uk>
References: <1374240141-27359-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5197140137293622347=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 99E89265766
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 19:46:14 +0200 (CEST)
In-Reply-To: <1374240141-27359-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, b42378@freescale.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============5197140137293622347==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IUSVF+LtaR4kWxuH"
Content-Disposition: inline


--IUSVF+LtaR4kWxuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2013 at 10:22:21AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Currently after playing any audio file, we get the following error messag=
e:

Applied, thanks.

--IUSVF+LtaR4kWxuH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR6XtgAAoJELSic+t+oim9NMYP/3KobiM9xj2g1jlrCsPMNUcN
Z4vfC5duk0lkJoDhfzksexaWAqKSy8rPByELqnKnV0hpnS9mTQ+AC6Wcjn3RTN85
pVd3/os2zLBvtUKLBefI6Nk8gOXWf10U306Mzi5RkgX6f3mkSihvotb9WwI+THXA
oaJeF1KPRfwj9rRql0JMDMjSlGBYQeyfqIN+AwstbSs3Znk3yCrFg8U9VgGKMnkR
TkqTC7BZa294aRykC+GaK/VU7vTAVBkVqXGrcHYvb60Vtml1KG+d2yNXVjtcBXaW
xXmH6+VWl3ivClDeCMcHeBdn7kmlXV0MCyyRtBPN6CEbMjc1tqAYqU/mJR2gd17x
sHpu7nuD4go5qBMLx/KsFsnEklu2GQii6RIN5CkAFnuF8r8hbNeTuOS0FKI20diY
ZZrna4u8GrDFpATB/OmJxsX5+5McKiHvmaDkiNXueXFnANtCu22I8zRuXud2Dxk3
d/u/QICXt0RuZU7vxyWnM3H2kP0h5MPbNu02hx8VBxhEAwojZEZC7Z+6HzWLp1MP
DRW5Vxkl51NX5UVasDz6QmXGrW3KtjhMBNjJmy2Tco/IX51T3BtAV5vmlkQiaZjL
6q6pYrtkWdn7edcUHrdbROE2ZIxux8KlzXmwlIi3zZb3Lqfmtv1xhur/pntonlxA
jjGoukbSwEhlZGmQKspU
=oLaZ
-----END PGP SIGNATURE-----

--IUSVF+LtaR4kWxuH--

--===============5197140137293622347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5197140137293622347==--
