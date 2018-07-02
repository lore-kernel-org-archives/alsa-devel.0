From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: simple-card: convert to SPDX
	identifiers
Date: Mon, 2 Jul 2018 10:48:52 +0100
Message-ID: <20180702094852.GA18211@sirena.org.uk>
References: <8736x2f93c.wl-kuninori.morimoto.gx@renesas.com>
 <871scmf929.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5506463557416393858=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E1C89267796
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 04:59:21 +0200 (CEST)
In-Reply-To: <871scmf929.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============5506463557416393858==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 02, 2018 at 06:30:28AM +0000, Kuninori Morimoto wrote:

> +++ b/include/sound/simple_card.h
> @@ -1,12 +1,9 @@
> -/*
> +/* SPDX-License-Identifier: GPL-2.0
> + *
>   * ASoC simple sound card support
>   *

The SPDX identifier needs to be a C++ comment for the tools, and to
maken things look more consistent I prefer that the entire comment get
converted to C++.

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls59QEACgkQJNaLcl1U
h9BwCgf8DXQvw9Z3tz/iKCblotdyBlBmeQZ4FWKt9787qz3qsqYr1pbckrKE+rkg
+UD1xKgVNd9BwjcAzmnioWyaRVNq9eR3fB31rLJIxuszhw9pvWACJYrlp4OwrEsW
TPmKcVv7F8EY4VZjdn+7H3/TNddistlRtxex56eAXEmzqo4j+HHDEODqQvqzEaWA
ASpYqj3FYr6De7lXhvTdNDRm3uGNwa816Ke5EDOBNuoLFwoXygnic6Q7yIVBrb3E
cZOQDkOBmy97f3BnVLawZfzfsVJIFzigjJTLIpGS3FVzw9N6e1X3j/mO0v3WpeU4
R+PjZBh4ZBJ0C/164Lof/ctu71L2Bg==
=2Jz9
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--

--===============5506463557416393858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5506463557416393858==--
