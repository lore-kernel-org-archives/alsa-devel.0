From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: wm_adsp: Add code_probe and
 codec_remove stubs
Date: Tue, 9 Jun 2015 17:55:55 +0100
Message-ID: <20150609165555.GG14071@sirena.org.uk>
References: <1433863017-25349-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <20150609160043.GD14071@sirena.org.uk>
 <20150609161356.GB27675@opensource.wolfsonmicro.com>
 <20150609162045.GF14071@sirena.org.uk>
 <20150609164329.GC27675@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8496593922889814331=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 218D22606C2
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 18:56:07 +0200 (CEST)
In-Reply-To: <20150609164329.GC27675@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============8496593922889814331==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="686YKZy5Vj8ja+ka"
Content-Disposition: inline


--686YKZy5Vj8ja+ka
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2015 at 05:43:29PM +0100, Richard Fitzgerald wrote:

> We can certainly look at factoring out that control creation once we have
> a probe function in wm_adsp to put them in. Which is what this patch creates.

Well, please do that then!

--686YKZy5Vj8ja+ka
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVdxqaAAoJECTWi3JdVIfQIUsH/jryGoSi3QReMQV22VsYyizS
OaEJvgQHGiH1tncMy8RM9+wpdjU/KGlG3jz/G/gennn3c48yPApw8TN+LH+Rv0c4
/Kjqn+4NgDt36gIVhIGXV6swRhcHJre2L8Xp4BE0ypAhG9ZvpU6Fe21Ltp4ZNjdr
AW3jUAH77jkKEsJK2iErihAr584jfLU9y2UROEwD0vtCqDFG4yYzhZqL1cqrRRmr
EThALRg9126cVia/H+70zT2VD65P/ZCktuoNEwriOD68likrF0oKQ0JNwbB0XSDo
SerAhlQV9h1q6/rJHz/PezRs9OICnu1ESgUGj6LX6eXsG2zA7B3ISxtz9j5ik60=
=UV4Y
-----END PGP SIGNATURE-----

--686YKZy5Vj8ja+ka--

--===============8496593922889814331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8496593922889814331==--
