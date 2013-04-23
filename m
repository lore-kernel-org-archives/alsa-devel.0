From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: generic-dmaengine-pcm: call
 dma_request_slave_channel()
Date: Tue, 23 Apr 2013 11:35:15 +0100
Message-ID: <20130423103514.GF5019@opensource.wolfsonmicro.com>
References: <1366639044-27695-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6673395113162045110=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 03E13264EFF
 for <alsa-devel@alsa-project.org>; Tue, 23 Apr 2013 12:35:16 +0200 (CEST)
In-Reply-To: <1366639044-27695-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============6673395113162045110==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4f28nU6agdXSinmL"
Content-Disposition: inline


--4f28nU6agdXSinmL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 22, 2013 at 09:57:24PM +0800, Shawn Guo wrote:
> dma_request_slave_channel() is a more appropriate API for dmaengine
> clients that adopt generic DMA bindings to call.  Let's use it instead
> of of_dma_request_slave_channel() to save <linux/of_dma.h> include.

Applied, thanks.

--4f28nU6agdXSinmL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRdmPcAAoJELSic+t+oim9kMkP/29lqx10zkLlgDEJwni06Cs5
ZTCCPDNjCRvrcxu2f0N8aKZG+aBCHywwzxsvG6LBol5oZZJjR2J9+Iv4mAmSICll
LTtvF42H4vWtQQalOCTGzG2ePDY+ctsk8bC9YyIJZbjonOthIQx6G9MVQPv5ADUr
q4YSn2ilU+fPGkl1sGdUwrIxbT5glPMrDQd2+zD6SP1U7FLk5cd8VOWpnA9tQ2lf
C+2CE6rse/p8kdKdXo2v96aF2z8Z4QIBp4Ge3t6kwo6+5AcwVfbvUM6Jwo02HCAA
4YxRHcn8Voo5P3GgiIvADroxYzL7wyaoOjl/cNVmGBIrghxeASX82zhi1N2nVTR5
K9aRtrgQ83Et+UFBgbUSrA+uMvRMtWXeQABHP/Phs/m8plOa+U6AOwYT07ucUqzN
8++fTv1D8xPHvaHBTCTwRk9MctOViWjh5psdLkVy71vFoe+IVLurhihAhV2prkGq
JgQlur8fTqkwX3srs4nhjjeUwKzZdXGW1qj/ILgcroe2B57MCnlcg5t76aXSYY9D
F2PFNrrT+z1PiCfYE6lewDdyoPqM/KEXkPECLIidZ/42RZ2Hfw4d431n4zs0nSks
jzb3/7CTKgDyNL8ApnRwdqKjW2Byt8DdukCBNhzIWWutr17r5Y5CtdNfhH8fY/73
pzqcugjIcTuCxleBYMq4
=Y+1Q
-----END PGP SIGNATURE-----

--4f28nU6agdXSinmL--

--===============6673395113162045110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6673395113162045110==--
