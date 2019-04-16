From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rockchip: Select DMA_PL330 by RK3399
	audio
Date: Tue, 16 Apr 2019 17:37:17 +0100
Message-ID: <20190416163717.GJ4834@sirena.org.uk>
References: <20190414210212.2144-1-alyssa@rosenzweig.io>
 <20190416162735.GI4834@sirena.org.uk>
 <20190416163434.GB17199@rosenzweig.io>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8485183367496144235=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48633F896E2
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2019 18:37:21 +0200 (CEST)
In-Reply-To: <20190416163434.GB17199@rosenzweig.io>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8485183367496144235==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F4+N/OgRSdC8YnqX"
Content-Disposition: inline


--F4+N/OgRSdC8YnqX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 16, 2019 at 09:34:34AM -0700, Alyssa Rosenzweig wrote:

> Independent of this, should PL330 be selecting AMBA then?

No, it's a dependency already.  The problem is selects ignore
dependencies.

--F4+N/OgRSdC8YnqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly2BL0ACgkQJNaLcl1U
h9AaHQf/QMXGbWmLRrHLIBm2kZAdXpYdCckDOm+1yovetxRDHdOaY+TBNkyrCWQv
oCI47mX1fjQUeTsjwMFJmcMvZFKMXDIexw7F7gqymK5rBm83w/4W3Hm8Y8mKw3SF
C9Rd3XzeZCOX0VOgq2akIRVbyRuwRrVi593K70Q5amKV+b6Ahw5GNDwZh9lRxMuJ
Lw2y36kaT+NFak0kjxKXxX/49sxuEM8ZTuMXMEKr4DTdygVwDgUAAeK0jfQBuVaW
7JY/cUVHm87K9tKlI7wc5fpGfLsUIivCimmU7hzm0eCRKYOkJ4GFe2qHsVuEPEAw
rutGjxazs1zw2cj1oX/D0mjcxwP4Xw==
=WcuD
-----END PGP SIGNATURE-----

--F4+N/OgRSdC8YnqX--

--===============8485183367496144235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8485183367496144235==--
