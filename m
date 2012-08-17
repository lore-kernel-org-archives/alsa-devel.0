From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] ASoC: Davinci: pcm: Add device tree
	bindings
Date: Fri, 17 Aug 2012 23:31:24 +0100
Message-ID: <20120817223122.GA21445@opensource.wolfsonmicro.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-4-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3150895413801385594=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DBB5926618B
 for <alsa-devel@alsa-project.org>; Sat, 18 Aug 2012 00:01:39 +0200 (CEST)
In-Reply-To: <1344948125-5649-4-git-send-email-gururaja.hebbar@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: alsa-devel@alsa-project.org, sudhakar.raj@ti.com, tony@atomide.com, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, peter.ujfalusi@ti.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3150895413801385594==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 14, 2012 at 06:12:03PM +0530, Hebbar, Gururaja wrote:
> Device tree support for Davinci/OMAP2+ pcm driver.

This looks like it's a device which maps a shared DMA controller in the
SoC core into ASoC rather than actual hardware.  Such devices are
usually instantiated automatically from the DAI rather than being
represented in the device tree since they are a Linux internal thing
really - the Tegra and Freescale drivers provide examples of how this
sort of thing can be done.

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLsYvAAoJEFJkBDiqVpZ4sS4QALMO1nb9g20kTiJ6ZjWQCGYX
jYtzMvLM1OoNdNUwpzCZ4vi5vxbx+Td//Py59sKwKA3IXcHw+MSCyC+G7NYTle58
Ot170pSO2xU068GEZWFigLEOw8f/SPzJkA/3sttfdF3Px/GuyL/uo7sKVPAtitGC
X1jdiiCn2BcJu6UUoM7+T6tJm2Vy8aHF4e4bDbd0VX045coO/FFuviffLeGoewT5
0gSaVnTEFKCiBNumiqwIL+LiuWT+7V/CV7exvnfB1oaBABBIt1roSOHZcO3M5KZS
TSx4wazOLyyx6LjSqBK+Oz5DZf7CzF6dgpu4yznaMO8iDcGBG59wxlq5Q1XUVf7S
dZxUDylUS18R+/hrzCLE7BdjaIlZrdL9jppukKY3ftL/lHsxKB4eVVgS5h7IChDo
J9XLEyrveIhWeb8VjJPsszLNuSphXySZwO3o0vbmJ/dbgcBClN6ZSkygofCfL36V
RrLKJZP0xm6C+aMBym9homd6M4k/GHx35FIPocsxd3MWe9y9uSliHjhdOhCLY/xP
yGpSF2D834PIeo4bhv1nrbJGzaciaKcm4K+G8xFwR1y2bkdV1C2OyI5ZhJz5nL0K
VkcuX94TItpuJQithe1raHbDG3ZlvrgYn5x9y5b4hslJUfHA35eWfCpBK6lMJ+z7
U35Uqnx8LLs9hrpuf32Q
=Ap4d
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--

--===============3150895413801385594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3150895413801385594==--
