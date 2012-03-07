From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 4/7] ASoC: Add dmaengine PCM helper functions
Date: Wed, 7 Mar 2012 11:42:18 +0000
Message-ID: <20120307114217.GD3107@opensource.wolfsonmicro.com>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-5-git-send-email-lars@metafoo.de>
	<20120302135959.GG3230@opensource.wolfsonmicro.com>
	<4F54B1F2.70508@metafoo.de>
	<20120305124141.GJ3224@opensource.wolfsonmicro.com>
	<87zkbtnt31.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2310419658705085509=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AC1471045C4
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 12:42:19 +0100 (CET)
In-Reply-To: <87zkbtnt31.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Vinod Koul <vinod.koul@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Mika Westerberg <mika.westerberg@iki.fi>, alsa-devel@alsa-project.org, Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2310419658705085509==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u5E4XgoOPWr4PD9E"
Content-Disposition: inline


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 06, 2012 at 04:38:30PM -0800, Kuninori Morimoto wrote:

> And yes, it doesn't use cyclic dma transfer since I don't know how to use it :)

> I forgot detail, but I used sound/soc/sh/siu_pcm.c and sound/soc/txx9/txx9aclc.c
> as sample code when I created FSI DMAEngine support.

> If ASoC layer supports dmaengine helper functions, I can switch to it by my incremental patch.

OK, great - if the hardware supports cyclic mode then I guess the best
thing is to enable that in dmaengine then switch over to using the new
library once that's merged (unless someone comes along and implements
cyclic emulation support first).

--u5E4XgoOPWr4PD9E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV0mTAAoJEBus8iNuMP3dygsP/ibZYOmIQA5e/YTxpS7HDPiu
pqrkwPPeVlooyDwmsb8GJZ5dO857F6M/AkrGXHUfHB4mmuCCswzNjFWi96R5Sms6
aSGID0AvHirlKU5gIuvcIj3ZA3XTdxIDXhJzit/trgtBk/gBhP3DXOpQL+RIrNCR
/zv71QXKunay8YGhHMaDeVpLgkVhe9xKYuexFjioQZ2x4Qe3p9r5CzsH6W+f/lbf
D71CxT3NqoHZhPnE8xx0+iWlDnO2chRk64I2oXIG4oGHSunWBhvObqJjW+0NW76a
6xTTQWRGYcMwX1MknGzd/rXdK+QaSHSd6kuuNu24HtijBsopbl08WLPj9Zj5vzv+
8QE6tNJ/nBvhIcv8NqYZqvhrdjvIbKgrex1PUie7qubB23GaS3zIurOJD0AOzzsm
fGBMNq/ZTISLfDLGEWrG95N6qQBRPMC3P2gusSjO73V9DmqmUIlSij1d936X4Zq0
2S2WvUMxYSTyir6XnO8Hlblrchre3xWJLw+vHxkIVCc56kxHD6nVZ2SRL+NDPejw
M+MFq0XzUoWq1Yk6BfDfER5MBwKF7mMR6I+nd90SUdb09vFAJukCNZ+JplHVp3Zu
e22gXLdjQ8iJU3cFSCdHU92qgJwS3YvnQ1NtqQOiofHoi25u3125wwd9n2uVYfp/
JwkBgU2TfcpDlBqFg1BF
=tivR
-----END PGP SIGNATURE-----

--u5E4XgoOPWr4PD9E--

--===============2310419658705085509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2310419658705085509==--
