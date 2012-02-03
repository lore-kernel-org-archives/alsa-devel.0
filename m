From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 19/19] ASoC: fsi: Add DMAEngine support
Date: Fri, 3 Feb 2012 14:14:40 +0000
Message-ID: <20120203141440.GR3151@opensource.wolfsonmicro.com>
References: <871uqcjo9i.wl%kuninori.morimoto.gx@renesas.com>
	<87aa50i971.wl%kuninori.morimoto.gx@renesas.com>
	<20120203134850.GM3151@opensource.wolfsonmicro.com>
	<4F2BE998.4020903@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7291547118371262427=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 75F6211CDFF
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2012 15:14:43 +0100 (CET)
In-Reply-To: <4F2BE998.4020903@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Vinod Koul <vinod.koul@linux.intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, Ralf Baechle <ralf@linux-mips.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


--===============7291547118371262427==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U5J2I87mWnf1KeOw"
Content-Disposition: inline


--U5J2I87mWnf1KeOw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 03, 2012 at 03:05:12PM +0100, Lars-Peter Clausen wrote:

> Yes, I was faced with the task of writing yet another dmaengine based ASoC
> PCM driver last week. At first I thought it might be a good idea to come up
> with a common ASoC PCM driver which could be used by all platforms using DMA
> engine. Unfortunately this turned out to be not feasible due to how
> dmaengine works. Each dmaengine driver has it's custom API for configuring
> the DMA controller. :/

That doesn't sound insurmountible - you need a callback to allow the
individual drivers to set the parameters but hopefully the data flow is
more generic?  There will probably be some other setup type stuff that
needs doing.

> The other ASoC platforms using dmaengine for their PCM driver (including the
> one in this patch series) don't have this function implemented and so the
> PCM drivers manually have to setup the cyclic SG lists. So while we could
> add a common set up functions for this to ASoC or ALSA I think the better
> place for this is in the dmaengine framework and implement
> device_prep_dma_cyclic for those drivers which don't do yet.

That seems like a good plan, that way other users of cyclic DMA will
also benefit.

--U5J2I87mWnf1KeOw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPK+vJAAoJEBus8iNuMP3d4mwP/0MpyrqYJKYV4gIYy8RCbBYA
65O+2S9vyUp3ml95C8jNc/ivbKrQc4EBCdQiE2j/nHTKQBax+msOl12+YUZGk7qr
7B1PMiw9riaElU1BpDSfJhQCNjaf8/pAQIOehmoTwP+fWif7F9uHNJ65eHMQ9V8w
S/MvgZq8E1iNxqMtvLRH4OB7MFwSL+ldRFh2RBUV8bg24TRZORv4bBY70rNmjQwY
S0akxhFcBe90/mp1YbAtQ8sPx0ZJek+mdON+Su352RDNf7VUBLRqOy4rwmbYT04G
cwzDFGNZQPnZ3Dqyo908t8AFiqTb8nLd4YXG/cSFR1ByXbk8sTOfvtaTV7C0LNqW
c/wv/9M5fxKcW8Yz0g8GQpoPS9KhpHtHqZdeiour4JPGk34mcFiSGCUiCZBDCOlg
CKokMLoUaofZyjzvHS136lV195T4YDrvy7aQKIOznEqD14BA0v9xfljN9+ISYqpB
QoAUcKXS/ovI90hZgE09iyQAPMbZDVjqB0vLu3SpEVh6tT9I5Dnk9D2KZrE/39vI
h10DhbtuqJPBORMZYTSvemRkC30Bc8DXjStJ2LeKYBTDBNwS+Q1rJtOwLv+/QEVf
qMV50nT/4w/wzI+dE1vsxAjw0XCuZqquKgKymH1ytRg3+MQEj/EA5F+51+Z1tx2Z
ZAW289MPNduH4UBs7iWX
=uhg/
-----END PGP SIGNATURE-----

--U5J2I87mWnf1KeOw--

--===============7291547118371262427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7291547118371262427==--
