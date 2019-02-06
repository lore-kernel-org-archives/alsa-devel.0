From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6] ASoC: codecs: Add jz4725b-codec driver
Date: Wed, 6 Feb 2019 18:12:39 +0000
Message-ID: <20190206181239.GG17630@sirena.org.uk>
References: <20190205031108.26171-1-paul@crapouillou.net>
 <20190205031108.26171-6-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2640063707906792064=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BEB726792A
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2019 19:12:41 +0100 (CET)
In-Reply-To: <20190205031108.26171-6-paul@crapouillou.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============2640063707906792064==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aYDVKSzuImP48n7V"
Content-Disposition: inline


--aYDVKSzuImP48n7V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 05, 2019 at 12:11:08AM -0300, Paul Cercueil wrote:

> --- /dev/null
> +++ b/sound/soc/codecs/jz4725b.c
> @@ -0,0 +1,599 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * JZ4725B CODEC driver

Same comment for the headers here.  Otherwise this looks good so I'll
apply, please send an incremental patch for this.

--aYDVKSzuImP48n7V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxbI5YACgkQJNaLcl1U
h9CURgf8Dehf5vAADGzm1GJerBtsOudWhj1kUeXepRUC5ifgU6/kiw2kJkeJzy0y
BKvvQz343uPdCR5bNmXDq4qGHccrLRdPHYASj+p1v7GjvN7NOBbyQttzIxgQ2lFD
gG8a0DEpm79gBAaFygl3QPIsF7EGRPbpxNQBH5cZ3ZM0EitFIOPTACJ3B+QeFJT1
9ntC1mGtMDmO/ULC+uiLdJCyRzIaAEZ5tKzawMqhOMdNdQt92Y6lYm7GKNPdS/EO
reIi01FUNtsqjp10OOn2knan/h0RosOX7HZTxrJUl0ueZ8qmxW5ysJ47rOwgoTmA
jKkBumtdLNpZBBZuXF2xjvhbJH/hEA==
=k7ew
-----END PGP SIGNATURE-----

--aYDVKSzuImP48n7V--

--===============2640063707906792064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2640063707906792064==--
