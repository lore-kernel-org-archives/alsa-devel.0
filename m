From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rockchip: Select DMA_PL330 by RK3399
	audio
Date: Tue, 16 Apr 2019 17:27:35 +0100
Message-ID: <20190416162735.GI4834@sirena.org.uk>
References: <20190414210212.2144-1-alyssa@rosenzweig.io>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6333624106899294032=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D67A3F896E2
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2019 18:27:40 +0200 (CEST)
In-Reply-To: <20190414210212.2144-1-alyssa@rosenzweig.io>
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


--===============6333624106899294032==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rCb8EA+9TsBVtA92"
Content-Disposition: inline


--rCb8EA+9TsBVtA92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 14, 2019 at 02:02:12PM -0700, Alyssa Rosenzweig wrote:
> Without the appropriate DMA controller selected, the RK3399 audio
> drivers compile but fail immediately. Accordingly, selecting the RK3399
> audio without the corresponding PL330 controller is an invalid
> configuration. Prevent errors (otherwise forcing the driver to unload at
> runtime)  by an appropriate `select` directive in the Kconfig.

This breaks the build as it enables CONFIG_PL330 but that depends on
AMBA which isn't selected so we end up with:

ld: drivers/dma/pl330.o: in function `pl330_driver_init':
pl330.c:(.init.text+0x8): undefined reference to `amba_driver_register'
ld: drivers/dma/pl330.o: in function `pl330_driver_exit':
pl330.c:(.exit.text+0x8): undefined reference to `amba_driver_unregister'
make: *** [Makefile:1029: vmlinux] Error 1

in my test configs.

--rCb8EA+9TsBVtA92
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly2AncACgkQJNaLcl1U
h9Dy7gf/X/zWP2wVe8pN6N+wdZXeihoh9hWhvrv76tXugzt39qnQyd+vjK7Qj6P9
YVB5fGNU8fYqFdWPpSpNDKyJYVyHyu5lRqJMsrq4NlEZiDTPVKUY77hVOpOnCdxc
TGSkuXZ1YrSym5shJOozh0WjfSpmfod9jaz8kVYcdZ/BpLAbFoK6nvjExT9FgqfU
fMZ882Oa0YKkvkn8jHk0RggGtg276lpr/RjvxbbwiAgM3/MiVmzjg1We+Q7tOjED
iTTlV7zS4efo9R2zUagyuD2mOZZ3OSe0Q/w+OAaJDk0LhXTvsnsWrkRyhiLRavrb
MkSdhem4xHS7Eq11z2Y9VLV3BvOdFA==
=7L4S
-----END PGP SIGNATURE-----

--rCb8EA+9TsBVtA92--

--===============6333624106899294032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6333624106899294032==--
