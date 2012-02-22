From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 4/7] ASoC: Add dmaengine PCM helper functions
Date: Wed, 22 Feb 2012 13:21:08 +0000
Message-ID: <20120222132107.GD7340@opensource.wolfsonmicro.com>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3376287758337415046=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2C7C6103EF2
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 14:21:10 +0100 (CET)
In-Reply-To: <1329904151-5927-5-git-send-email-lars@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mika Westerberg <mika.westerberg@iki.fi>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3376287758337415046==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sXc4Kmr5FA7axrvy"
Content-Disposition: inline


--sXc4Kmr5FA7axrvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 22, 2012 at 10:49:08AM +0100, Lars-Peter Clausen wrote:
> This patch adds a set of functions which are intended to be used when
> implementing a dmaengine based sound PCM driver.

Looks good - if you need to resend then:

> + * Note that this function will use private_data field of the substream's
> + * runtime. So it is not availabe to your pcm driver implementation. If you need
> + * to keep additional data attached to a substream use
> + * snd_dmaeinge_pcm_{set,get}_data.

there's a typo here but no need to resend just for that.

I'd like to see some review from both Morimoto-san as we should convert
fsi over to this too, Vinod I guess you're also pretty much happy given
your comments on the previous version?

For the non-cyclic DMAs the idea of emulating at the dmaengine layer
does seem very sensible but if that's hard then having the code at the
ASoC level and pushing it down later seems fine.  We do have several
platforms with non-cyclic DMA so it's a general need.

--sXc4Kmr5FA7axrvy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPROu0AAoJEBus8iNuMP3dBkkP/RTtzUnSpDa6wxhwREAPqfHo
emQ15BK8pGL3CzlWKZF2kt5Q8u3258YuDM3bTeRAkgPEeNafBbP+t44o5GAxlnzr
ctmssA8MgfqipaugUR/ViUSN9IWBz6g2VHCaK4Z7ZYHGGluV5EHgJKAAKNrVKZTe
O2JPf0WuBYWtpt9/UMohbq++BikauJ07gsDXBjeGq9USZpDLHH2xpV2jXeHGGsNU
c/gGuCTTae7mjHr6u38XrML6FHjcoMycZif6EBedVs3fDJrhAP820pleW4BZFq1O
89KO1aHVHzsj8ErxPsTnoIQyHYdN4kJSvVNzgUzQINZ26ULVFHG+TAXHptFbpjl3
GItwRSXAcRCTrFrAi44uWMFxTr/S5gb3cLrqDw1ptJ/PRMXQ2Hh2ZN0BpiDwO2U/
XqHuIQjyAMWK0SBun69X0T6jbemULY4dibe42EnTGjiHtQXlaKR8kCHB7//C8Ngc
Dt817nJqv4hAtW9I5z7DvyBtDApJcyPtToWUrjvd2jwYFMnvoqjdA6MsYSuAlRXP
e3bCxOl2sl8E8iHTMwghw8Zs6T3k3DU+rvv+YKxRcmrLYd6gzJ5knF6EyrRLL6us
Qu0bkvVeoIeTT2VRr+vQC1yNStWgE5Z8Khu5W075gC1DU0tZnq9k7BbmowAfErcY
1aoTBbp4S0i6/xO2jWan
=Tw5E
-----END PGP SIGNATURE-----

--sXc4Kmr5FA7axrvy--

--===============3376287758337415046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3376287758337415046==--
