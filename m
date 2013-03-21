From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2] ASoC: dmaengine_pcm: support generic
 DMA binding users
Date: Thu, 21 Mar 2013 16:22:06 +0100
Message-ID: <20130321152206.GA14768@opensource.wolfsonmicro.com>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <20130321023858.GD6281@S2101-09.ap.freescale.net>
 <514B21F3.90803@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1982774341175304900=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3A07326512B
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2013 16:22:09 +0100 (CET)
In-Reply-To: <514B21F3.90803@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1982774341175304900==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 21, 2013 at 04:06:27PM +0100, Lars-Peter Clausen wrote:

> Hm, I only saw this series today would have been good to be on Cc. I've been
> working on something very similar. My series goes a bit further though, it
> implements an (almost generic) dmaengine based PCM driver using the of
> bindings. So you need almost no platform code. The only things that are
> platform specific at the moment is the pcm_hardware struct, but I'd like to
> replace that in the future with something that queries the pcm hardware
> parameter like max_period from the DMA engine driver. And another bit that is
> still driver specific is a callback that fills the dma_slave_config struct.

FWIW it might be worth looking at the one rmk wrote but has never wanted
to submit for whatever reason.

> In my series the channels are requested at probe time, so it is possible to
> handle -EPROBE_DEFER properly and also we can allocate the audio buffers with
> the dma device instead of the sound device, so stupid hacks like

>     card->dev->dma_mask = &dma_mask;
>     card->dev->coherent_dma_mask = DMA_BIT_MASK(32);

> anymore. I'll try to post the series tomorrow.

This is the main thing his code has got that the library hasn't, it's
certainly the only issue he keeps mentioning.

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRSyWWAAoJELSic+t+oim9mDwP/3iuPJDiBz9vgyBoog4SWfoD
Zm2llDFwRlrJ8IHz1hYrXvODWG0RBEmI4Zvn530GPwyShVx2jRrip6PZ+C0bV1uT
adfYX6+mgWzXLgKObOrXubBUj9AxNsyVgotERkZ7ZakTzh6BGJXoEXQhu9tT7Wph
UZXkkD6jn21mSxmIIIIJhOysH2Jc0I0nO0/F0H8aZK6OXjtI/f04NSToqP7teN5X
VPvIW3TmcpZnrYKyE7NyezW2ovVDKmliMgSUidkCM/JljrZQ515awSaCbZfn31AU
wHW78zbyIJ0GEo8CYAmJrfn8RCyIrhHDJTi0BfV4e4w2/ssgDIXgjO2eF5t8emXv
7EuYWP4BFEvNBJBICNo2K2JoeG6jGWrIsyJbwAmCYNZ5CPBwZQ1c9O5c2W7akrV3
Nf3B3GJVKWfmgIk1miMqs3qkDeQJ/uoMf37w4KVB0ydnG/2IuH0Ls1nRGrBuG4ed
BIMQFiraqwcKM2RBohqFAFCTrzGKvtcEaQdo916QmrNiSZeifKzhueSCruecm+3l
08VFQh8v87vrqnfT/wA8MYdb4XyviCMvydpA29YvgkXjrs9mbkkCZ7bri0d1f1tw
iNIu2pXUtLWxh2B20ee5WIuNGkPV1lA6ggckPojH/htiLJ4HxoR/PIKx4STjP4rp
9xzlRv8Tll9JlH/i2Snq
=a4M7
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--

--===============1982774341175304900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1982774341175304900==--
