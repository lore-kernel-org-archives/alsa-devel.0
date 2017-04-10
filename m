From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/16] regulator: madera-ldo1: LDO1 driver
 for Cirrus Logic Madera codecs
Date: Mon, 10 Apr 2017 19:11:36 +0100
Message-ID: <20170410181136.btpvcat2ijwiebvm@sirena.org.uk>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1491386884-30689-7-git-send-email-rf@opensource.wolfsonmicro.com>
 <20170410174917.dlklrvw2sraeq6xs@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4968519706016280375=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 22A3A266BA4
 for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2017 20:11:52 +0200 (CEST)
In-Reply-To: <20170410174917.dlklrvw2sraeq6xs@rob-hp-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, jason@lakedaemon.net, devicetree@vger.kernel.org, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, tglx@linutronix.de, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============4968519706016280375==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="das4mthlaskxrm4z"
Content-Disposition: inline


--das4mthlaskxrm4z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2017 at 12:49:17PM -0500, Rob Herring wrote:

> Same question as Mark. Should this share bindings with arizona? The=20
> arizona one looks a bit strange, so not sure we'd want to just copy it.

In what way?  Other than the -gpios stuff (which would just be a trivial
thing if we wanted to change it)?

--das4mthlaskxrm4z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljrytcACgkQJNaLcl1U
h9A3Zwf+JoYcQYsJD+gK2QagQdwPn67smNNulnEVG6GJHwMp7lGnzmMnW+rTdZ5k
yaTnO86CNszc1Wvr/Pobgpo81tI5SPev2enfkm+ruRlutrcVeD44sHeqJoLbzFUW
YbtnlxPCeqibclQgyX8rR+PJV5jQgwZ//SUP9/WOzwHKqDidolypHf3vYjijgpqr
4GElojg6Q/zn1Vtiv4qNt8iHM3oT9NR3HpbUXSMb+XHSeGnAO8kW5Ej388p2Ui0d
29POatFKt92efpWKX+Cq+PEuyxbfXkJiN0xTYc00Nbv0Sozo8hnnyWIYS+EH0/KD
HfDiqem8f9/etfuUkQ7qqWOym8rvbg==
=XiLU
-----END PGP SIGNATURE-----

--das4mthlaskxrm4z--

--===============4968519706016280375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4968519706016280375==--
