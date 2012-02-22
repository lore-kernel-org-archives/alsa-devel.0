From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 1/7] ASoC: imx-ssi: Set dma data early
Date: Wed, 22 Feb 2012 13:22:22 +0000
Message-ID: <20120222132222.GE7340@opensource.wolfsonmicro.com>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1224760192696847109=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 17D17103F31
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 14:22:25 +0100 (CET)
In-Reply-To: <1329904151-5927-2-git-send-email-lars@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, Mika Westerberg <mika.westerberg@iki.fi>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1224760192696847109==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7CZp05NP8/gJM8Cl"
Content-Disposition: inline


--7CZp05NP8/gJM8Cl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 22, 2012 at 10:49:05AM +0100, Lars-Peter Clausen wrote:
> Move the call to snd_soc_dai_set_dma_data from the hw_params callback to the
> startup callback. This allows us to use the dma data in the pcm driver's open
> callback.

Applied, thanks.

--7CZp05NP8/gJM8Cl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPROwDAAoJEBus8iNuMP3dAMQP/jE1EDJi3iakjNVsG3V1ZCxH
azWLMsSOWs8rHWAYIIWBESpEZm+MjJXeAeIgGprMr+Is591FaDqxsRio2MH7N7GL
/2k63Y3mkoJl/ct5CAhx3bN/8tg11VyT1Tzlcqb4r8Xic9hxjcGUiM50UozN3ht0
ufaxuHEOzNCjM4SuUW752ZooimKu4miuZMQv2Yr7mfRjHBdE+OP+FuEFlSRbdCVC
m1Y5xHLvsNj1734cbuQoGZPIgt4A6fSKQihJaYlRnGcgTmpWs11EMYhnCsecbXZA
6Umeu/xePArQJE2afvdIYWr5ogJunAVIJBgK8TPDjB8AUeXkMLOCphhhGHm7kvC3
xPlWta4JBcTTqMizGDVUlQ5A526a9kNF9eYZpjHDWVZS3X1A9ePVLHBkw4EtYPU+
EEgxvU+uDecN2uRbVMFJ7MVSqLnrAetUIKH2eoRxOlEGI95G42ooiA+x3aXRA8uG
GyNZXFJdmylcwntZIxuy7tV+g+IjkcRy9vAvLJFkHg1KsZLiTQbSpkeXUODd9pNK
P70bAkoOM4toJZQAxMthj/CWEvCOsyLfTU+LMRsgLfs/jD/qWQJi2CPIyK7RQhQ/
hVhMSnnbAIX7V1sUlzMuxNLeQAbZTCJTwSanjufLVqTd4GFepZVY6yBuEy48RZgJ
JUncjNjrMV+MI0lU9jLm
=C2Wn
-----END PGP SIGNATURE-----

--7CZp05NP8/gJM8Cl--

--===============1224760192696847109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1224760192696847109==--
