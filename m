From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/23] ASoC: atmel: atmel-pcm:dma.c: use
 devm_snd_dmaengine_pcm_register()
Date: Thu, 27 Jun 2019 12:38:54 +0100
Message-ID: <20190627113854.GD5379@sirena.org.uk>
References: <8736jvkcy1.wl-kuninori.morimoto.gx@renesas.com>
 <871rzfkcxb.wl-kuninori.morimoto.gx@renesas.com>
 <20190627094316.35057063@xxx>
 <e6327e0c-a657-4fe5-4513-562835783eb0@microchip.com>
 <87woh7h1zf.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4581573701875354191=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 30446F89678
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 13:38:55 +0200 (CEST)
In-Reply-To: <87woh7h1zf.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Codrin.Ciubotariu@microchip.com, alsa-devel@alsa-project.org, amadeuszx.slawinski@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============4581573701875354191==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fXStkuK2IQBfcDe+"
Content-Disposition: inline


--fXStkuK2IQBfcDe+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 27, 2019 at 05:24:37PM +0900, Kuninori Morimoto wrote:

> I'm asking it to Mark now.
> pattern1 is I will post v2 which cares empty function.
> pattern2 is I will post "remove empty function" patch set.

Removing the empty functions immediately is probably best.

--fXStkuK2IQBfcDe+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0Uqs0ACgkQJNaLcl1U
h9DDPgf/ebk4NrkkklKvyewn+pyJmAxjkEjs+xbwNG6QnTCbpRE6HVWdwAvC56qe
6AAvt2FrZIsfm93Fxp+64iRlxsafPisq9a43pbQw490Iq2z62ITwyJQI66YHCfoU
+OrWsUnDOMHCr8E5iswnNuboQvaKaGtU+acUKwS8KDUUEX4K++p3T0pP0FfIKt+Y
FrSug9VLd00QQBFWqTKZnU5d34bsEY24NiNeFwp7NTDobsPxbdLeSiBgqIWRGWKH
lB5w5sGwGczBPA7H/mEaM/JmyEQRu7Roq0DM9FhciC3njU73pC7dN9xCkcruNeAW
J3g1cqS7cXQNeua3KG3Ta8+fvQYp5A==
=4Po1
-----END PGP SIGNATURE-----

--fXStkuK2IQBfcDe+--

--===============4581573701875354191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4581573701875354191==--
