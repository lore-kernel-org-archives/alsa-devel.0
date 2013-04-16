From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/17] ASoC: Towards a generic dmaengine
	PCM driver
Date: Tue, 16 Apr 2013 16:33:36 +0100
Message-ID: <20130416153335.GK26958@opensource.wolfsonmicro.com>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9218194246023101048=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B04A32610A6
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 17:33:37 +0200 (CEST)
In-Reply-To: <1366046404-8759-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============9218194246023101048==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VJJoKLVEFXdmHQwR"
Content-Disposition: inline


--VJJoKLVEFXdmHQwR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2013 at 07:19:47PM +0200, Lars-Peter Clausen wrote:

> This series adds a (almost) generic dmaengine PCM driver for ASoC. The tegra,
> spear, omap, imx, mxs, ep93xx and ux500 platforms are converted to use the
> generic driver instead of their own custom implementation. The driver builds on
> top of the dmaengine PCM library and adds the missing bits. The driver was

This all looks pretty good modulo testing and so on.

>  * The size of the pre-allocated audio buffer. All platforms seem use different
>    sizes and since some of them might be sensitive to changes to the buffer
>    size this series keeps the original size for now. But we should probably try
>    to decide on a sane default for this and maybe allow ASoC board drivers to
>    overwrite it somehow.

Or the platform for that matter of course.

> The driver uses snd_pcm_lib_preallocate_pages to preallocate the memory buffer.
> snd_pcm_lib_preallocate_pages internally uses dma_alloc_coherent, while most of
> the platforms converted in this series use dma_alloc_writecombine. Laxman
> Dewangan submitted a patch[1] a couple of months ago to add support for
> dma_alloc_writecombine to snd_pcm_lib_preallocate_pages, I always thought the
> patch had been merged, but it looks like I was mistaken. So if there are
> concerns about performance regression due to using coherent instead of
> writecombine mappings we'll have to postpone converting these platforms until
> Laxman's patch has been merged.

Can you resend that to Takashi, it sounds like if it's not been merged
it's probably due to it getting dropped rather than any great objection?

--VJJoKLVEFXdmHQwR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRbW70AAoJELSic+t+oim9t+4P/jUbcVLbaQtXA/RuRLXE4bYp
7abrJ5LDLGVmAbIxqH9hGyO6H4wylFgUJ05zzFXijef1Sg8NYt7091U4xXJiujyY
pEmu2hNoMOL2RInTiNKGLRJWgYzB9w07R0n61Waj2krBKP8oYy/cSyj9cuK5x+sU
hOzJq9xkOHbce9t3DTLOlMkGm9zizcbgtRbldJpwQTmoYiXQeyUoju0AOxpHRyWf
aSyEIeHUwa5t906BHbs4pkX+q0ZFEE02UIXFgpNTrgv1uU5A0IbBRFM5nsWnXA9I
M3lCuX0QCb5zm7G5qmrDyHPbpqxheowBVy+pUC9ndBlLuoc1Hk2varnpkcbwYcof
seKpN93THrgzP0c68TB/bFFvLm7L4+0oCSk38KVegTlCzb3L9+cK3S5k+YBuSU9g
4qaDzWmfYSihL0j3JO2KxM2WxRkiAk3UeFnOQ/V1znx8Rvv7uedpZnmN1yaAs6O+
2wvVPQv9jzMrnAVlnPK1Te16tkHTmSfEpEUU3iz+/adAi4swzlZJjf6z2m9O8RSH
Ct0u+rplC7aVGSZ0buAANliiUOcPcfcjnYY8HkjLDelgEn6HfE/Kar2J6raS5lCb
2WnmkhuA8hj/T4ZmKVokcqb7Pmkma+AYOGud2EjKXfj6HXo6UVThnuAjibzFA2Uh
oQehHbmIBhvAGa0jAom8
=PoRP
-----END PGP SIGNATURE-----

--VJJoKLVEFXdmHQwR--

--===============9218194246023101048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9218194246023101048==--
