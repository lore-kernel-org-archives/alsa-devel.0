From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2] ASoC: dmaengine_pcm: support generic
 DMA binding users
Date: Fri, 22 Mar 2013 12:48:00 +0100
Message-ID: <20130322114759.GM22890@opensource.wolfsonmicro.com>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <20130321023858.GD6281@S2101-09.ap.freescale.net>
 <514B21F3.90803@metafoo.de>
 <20130321152206.GA14768@opensource.wolfsonmicro.com>
 <20130322111704.GZ4977@n2100.arm.linux.org.uk>
 <20130322112859.GL22890@opensource.wolfsonmicro.com>
 <514C43B4.1040403@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6677417841929774614=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C2577265177
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 12:48:01 +0100 (CET)
In-Reply-To: <514C43B4.1040403@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6677417841929774614==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yaap9KN+GmBP785v"
Content-Disposition: inline


--yaap9KN+GmBP785v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 22, 2013 at 12:42:44PM +0100, Lars-Peter Clausen wrote:
> On 03/22/2013 12:28 PM, Mark Brown wrote:

> > We need support for both cyclic and non-cyclic devices, one doesn't
> > preclude the other and both kinds of hardware exist.  Cyclic is much
> > more common and generally more desirable but that doesn't mean that
> > hardware designers always provide it.

> The idea was to only have support for the cyclic dmaengine API in the ASoC
> PCM driver and deal with the emulation of cyclic transfers for hardware,
> which does not implement it, at the dmaengine layer.

Perhaps I'm misremembering but I thought there was pushback on that on
the basis that there are few if any other users of cyclic DMA so nobody
else cares or wants to deal with the hassle?  A quick grep seems not to
turn up any other users.

--yaap9KN+GmBP785v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIbBAEBAgAGBQJRTETjAAoJELSic+t+oim9YQAP+KlqKuARchGomzY/XIZGFkHO
QQeQtTWEQ14nAr5fuQU0WFjuDaaypkMUK1iEW27HWvN4pxLRVwWBkyjZxdiaO1Qu
fAHqSWgrCtSwYZRe0BYyjR7M2ZR7GG56KtX76RZiczTRRCINhwc0RwakxbSiwLAl
XVnrjiz2UsReyaW2UxDwAR3pcHRpgyzjgIlX4XOz/r7Gzgy9fht++wbOtKljHLAU
hk/9FdWAE3j8RrQQRcvYRY3QckV1/Jtip31Ua9HeozUqxi06CjVkak6OSRWUrGxi
SpAVwb8gfxHR1iaUVGxmR5DsYZNsIw+c/kMzyFLWuB3YrDb+HZF9/o0cihqeU8rt
tWmrkDzTPPAtau+V/pkJ6v/8fceRxsXw+pOF6AuDHOLEDc59aMKL0FPrja2dU1cI
Cv4bNQxuFUT9ZQAkoLFmqxjLOOBszKyqyqBMwyL2qrXGLUakWrk2rFHa7Hxd/qoa
PBYafp7aNInxoQNpq5V9OtnEPTgMtpeH4PCMTgcN6il8N5zsSpxmuJyO8gqhDbbc
ln6YxM1bAWCZsNXM0RPOOzxgw9A8XXxEU5bZAyZ9HzWXvLw7ND53Hu5y7MPqs1Tv
dCZdW5/CY+43ds5abw2VJrorGQFsI421C3cRnn5gGSof70CawajihPNOHrIYnr3d
Rp8RkI7AXgNlydzV5QY=
=bIzk
-----END PGP SIGNATURE-----

--yaap9KN+GmBP785v--

--===============6677417841929774614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6677417841929774614==--
