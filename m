From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/16] regulator: madera-ldo1: LDO1 driver
 for Cirrus Logic Madera codecs
Date: Wed, 5 Apr 2017 14:28:44 +0100
Message-ID: <20170405132844.h4itieglcbzyl3jf@sirena.org.uk>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1491386884-30689-7-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4685258558027622994=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 905A026705F
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 15:29:03 +0200 (CEST)
In-Reply-To: <1491386884-30689-7-git-send-email-rf@opensource.wolfsonmicro.com>
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
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, jason@lakedaemon.net, devicetree@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org, tglx@linutronix.de, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============4685258558027622994==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="74azknti32ogp66j"
Content-Disposition: inline


--74azknti32ogp66j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 05, 2017 at 11:07:54AM +0100, Richard Fitzgerald wrote:
> This patch adds a driver for the internal LDO1 regulator on
> some Cirrus Logic Madera class codecs.

There appear to be only data differences to the existing arizona driver,
is it possible to share the code?

--74azknti32ogp66j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljk8QsACgkQJNaLcl1U
h9BnIQf8DygzO0mcDjqy6rkrjC8MGwrU0WVKZ4V5WpVIaDO62AnyWNPh8coFdO5I
vLjZrMAWJtdx4Uo8eh3LC2sukQAvRiZ0jFnvWTPhbSGu2loOHupiYDxZmzIjpOg5
OyH7ALWVlVmORa7V+QL+RbZnyanfiSvEMSJNPLTpTA7aOqPfYB3b4IF38QF/hoY0
bFmrwtspZY75JMfugmAYhbWzPz9ED9IPUlENdy6nWef/AFWSehtMwmgH/Y992r4t
5MCBxZ2Pvr6UBj5M9YKdQpGqbXsUgOsKpLumIehFwZCwbVIXfXYu56W3l3L+615O
10hGYHzV+bWNQdyqAM2t18tInkJIUQ==
=YIZp
-----END PGP SIGNATURE-----

--74azknti32ogp66j--

--===============4685258558027622994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4685258558027622994==--
