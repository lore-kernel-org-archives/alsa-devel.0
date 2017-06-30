From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 01/17] mfd: madera: Add register
 definitions for Cirrus Logic Madera codecs
Date: Fri, 30 Jun 2017 13:35:16 +0100
Message-ID: <20170630123516.7rbieeq3x6jnnqgk@sirena.org.uk>
References: <1496415790-19164-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1496415790-19164-2-git-send-email-rf@opensource.wolfsonmicro.com>
 <20170605100707.zqyfyzhlhrpswa2u@dell>
 <1498466018.4826.81.camel@rf-debian.wolfsonmicro.main>
 <20170628192640.lboeddcabjcrvmtw@sirena.org.uk>
 <1498727494.4826.84.camel@rf-debian.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4190936926884701975=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E92512674CF
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 14:35:33 +0200 (CEST)
In-Reply-To: <1498727494.4826.84.camel@rf-debian.wolfsonmicro.main>
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
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, jason@lakedaemon.net, devicetree@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org, tglx@linutronix.de, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============4190936926884701975==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y7t3nwywndlcbyv4"
Content-Disposition: inline


--y7t3nwywndlcbyv4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 29, 2017 at 10:11:34AM +0100, Richard Fitzgerald wrote:

> There are build dependencies between the subsystems but I don't know how
> the maintainers prefer to deal with that - keep the patches as a set or
> cross-merge branches.

It's good to at least have the option to have the code in the subsystem
tree so that any API changes in the subsystem can update the new code.

--y7t3nwywndlcbyv4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllWRYMACgkQJNaLcl1U
h9AeIAf/RtCnC4ptC1wiLv7y0qb3mGFtqFOEe4DouCjIUcsoGydBv0wHEbJcxE+4
Z0VxpYdYhTvpnnS+OtvZk0yjd7s4UrER39WJJBVOoUnVlIHMAHFzU7W634ibWe+7
V/p9fpPrUrJ5z8jutkztEbDc/QY8OC4l7+dUj1TcrDKbli1ln6Nkz3TkjAw7SY1X
2+t0gIZcNRl4EYj3n8aC6PytN4pb2SaCspWdI/4RPK7WiRhMSlFmSJZlQLGgIa/h
rlW6JrLQNoRvXoWVKgyLHdGe3onnTpYRXHbAXIJb9RBkv3dsNT1bU8f57cFPSB99
DMxctG72VvzqmgOu1M7spDiDEaEcIw==
=ev1Z
-----END PGP SIGNATURE-----

--y7t3nwywndlcbyv4--

--===============4190936926884701975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4190936926884701975==--
