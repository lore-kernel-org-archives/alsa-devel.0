From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/8] ASoC: uniphier: add support for UniPhier AIO driver
Date: Wed, 6 Dec 2017 12:58:17 +0000
Message-ID: <20171206125817.GF1827@finisterre>
References: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
 <20171122114321.29196-6-suzuki.katsuhiro@socionext.com>
 <20171204183934.rd4vin22ktukwpip@sirena.org.uk>
 <002b01d36d84$51d80aa0$f5881fe0$@socionext.com>
 <20171205121440.GC11658@finisterre>
 <004801d36e57$ea1940d0$be4bc270$@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <004801d36e57$ea1940d0$be4bc270$@socionext.com>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Katsuhiro Suzuki <suzuki.katsuhiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?B?WWFtYWRhLCBNYXNhaGlyby/lsbHnlLAg55yf5byY?= <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Masami Hiramatsu <masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 06, 2017 at 03:03:18PM +0900, Katsuhiro Suzuki wrote:

> > I'd expect this code to be structured more like a library - have a
> > driver that handles the specific IPs then have it call into a shared
> > block of code that does the generic bits.  Though in this case the
> > device specific bit looks like a couple of tiny data tables so I'm not
> > sure it's worth making it conditional or separate at all.

> Sorry... I agree your opinion, but I can't imagine the detail.

> I think my driver has structure as follows (ex. startup):
>   DAI: uniphier_aio_startup()@aio-core.c
>   Lib: uniphier_aio_init()@aio-regctrl.c
>   SoC specific: uniphier_aio_ld11_spec@aio-ld11.c

> Am I wrong? Would you mean split the functions in aio-regctl.[ch] to other
> kernel module? I wonder if you could tell me the example from existing
> drivers. I'll try to fix my driver like as it.

One example is how all the drivers that use the generic dmaengine code
instantiate their DMA drivers, or how all the drivers for CODECs that
have both I2C and SPIi control interfaces instantiate - given that the
device specific code here seems to be mostly data tables that's probably
the closest thing.

> > At least.  I do think we need to get to the bottom of how flexible the
> > hardware is first though.

> Yes, indeed. This hardware is more flexible and complex, but now I (and our
> company) don't use it. Of course, I don't want to hide some features of this
> hardware from ALSA people. I should try to upstream all features in the future,
> I think.

My main concern here is to make sure that when you decide you need to
use the more complex hardware that this can be done without too much
pain to existing machines (and that they can benefit from as much of the
enhanced functionality as is possible).

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlon6WgACgkQJNaLcl1U
h9A75Af/fUUzsc00AbNuEqe8kV4QvfNXQGpLJ8MUhpjtu6i0Hjb7lt26FfNk+r6N
OLtmRJJPO4QE2Qn3GVKYjx8aTnr/Moc+7BqGBiEKjuPjPmpLRfVfsZvPXrGORGGj
tOuDpignf3zSPZRQTrCtpBoIV3JFTOcJkFjvGI33yGN9qSUCJuoh2qbz6agOrJQG
Ggjs1Al5DdK/i7W1ZEfIH3sS45Gevc6p64jJ778Os6QLDzmeQneMtsNnA10NU+AV
pW3oXtJUSsag1hRwwM4ABvv4pHjS1y181rO+LM5AAz9ZAPf7Ta5NuPEaWFHSw8n+
tsoO/q5vsF5FI16GYDFpcoDoPCM3jg==
=x264
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
