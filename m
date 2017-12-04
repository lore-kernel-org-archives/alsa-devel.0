From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/8] ASoC: uniphier: add support for
	UniPhier EVEA codec
Date: Mon, 4 Dec 2017 18:20:27 +0000
Message-ID: <20171204182027.2k5uw5og65h6ac7w@sirena.org.uk>
References: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
 <20171122114321.29196-5-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6660583542156104889=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 230CA266BBC
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 19:20:30 +0100 (CET)
In-Reply-To: <20171122114321.29196-5-suzuki.katsuhiro@socionext.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6660583542156104889==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nyhrygpahjuvk5i3"
Content-Disposition: inline


--nyhrygpahjuvk5i3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 22, 2017 at 08:43:17PM +0900, Katsuhiro Suzuki wrote:

> +++ b/sound/soc/uniphier/evea.c
> @@ -0,0 +1,567 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Socionext UniPhier EVEA ADC/DAC codec driver.
> + *
> + * Copyright (c) 2016-2017 Socionext Inc.

Make the entire comment a C++ comment, don't mix and match like this -
it's ugly.  Otherwise this looks good so I'll apply it, please send a
followup patch fixing this (and I guess the same thing will apply to
other files).

--nyhrygpahjuvk5i3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlolkeoACgkQJNaLcl1U
h9Dscwf/Zkc6wTXtO4duJEj9ORsWnc6KgJLeM/l8IGaIA1iTubdl0CS0y9ktnsLL
ODP6xGXKUsrcwVqMALu0g+Kql4RTLlWjjNmsB5em2DjMyMjCdKTaeymxZOYItK/M
Jev3uPsOH7bFqNvcVFF7kInneSvrD6ghAGtqvP8GFZ4CfDZVc73cwYX1wsDacMs0
++KNZFjcm25UZquJ0wOeiWv62PxKIlotZiqNixFbLJ3ogxD5RoNRz2X/b+XJn5fb
7uYQ9YpfRnsjvF7gthXM3R/SbN5YikekGfk/9EzMTkWskLL6KKhPcf3zSuO0FEZX
NMM+CDLJ8UAEFdQFTgkbpUIiEvglWg==
=HKyp
-----END PGP SIGNATURE-----

--nyhrygpahjuvk5i3--

--===============6660583542156104889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6660583542156104889==--
