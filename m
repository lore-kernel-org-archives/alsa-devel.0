From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 17/17] ASoC: fsl: add imx-sgtl5000
	machine driver
Date: Mon, 5 Mar 2012 20:44:56 +0000
Message-ID: <20120305204456.GC3224@opensource.wolfsonmicro.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<1330957865-19085-18-git-send-email-shawn.guo@linaro.org>
	<20120305174232.GA3852@pengutronix.de>
	<CAKGA1bn7y8xQn-o=8CZj5nwcvaBvHwxqM0Q2wzFAwJsSgi1sfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3804465847099746145=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E6EDA104437
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 21:44:58 +0100 (CET)
In-Reply-To: <CAKGA1bn7y8xQn-o=8CZj5nwcvaBvHwxqM0Q2wzFAwJsSgi1sfA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============3804465847099746145==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fblc08uBQ7kpPybH"
Content-Disposition: inline


--fblc08uBQ7kpPybH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2012 at 12:09:13PM -0600, Matt Sealey wrote:
> There is in the BSP but the BSP driver is trying to be way too fancy
> with I2S settings on the imx-ssi driver you wrote (it works well for
> AC97, but for SSI in I2S slave mode there are so many hacks upon hacks
> "they" have presented, it'd never mainline)

I'm really having a very hard time comprehending this paragraph, and
indeed much of the rest of your mail.  The lack of any context isn't
helping here...  There is what exactly in the BSP?

> codec config. In theory the playback and capture should be serialized
> by the driver, though, right? It wouldn't be possible to be a slave to

That would be *really* bad, simultaneous playback and record is very
widely used.

> the codec if it had to run the clock two different rates at the same
> time.. app1 sends a sample buffer, codec does dma, app2 requests
> capture buffer, codec does dma, they can't happen at the same time,
> maybe we are missing an important mutex or spinlock here that would
> enforce this and stop the configuration changing mid-stream.. I'm far
> from the ALSA expert though)

If the hardware has constraints on the sample rates the driver should be
telling the application about this.  For the very common case where you
need the same rate for playback and record there's framework support for
doing this, the relevant driver just needs to set the symmetric_rates
flag and the core will do everything.  Note that the ALSA APIs are racy
here.

--fblc08uBQ7kpPybH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVSXBAAoJEBus8iNuMP3dzcAP/1hCFdB4qxgZsVi75CHPKAyi
d+9XvqROPDakqQM4QYMU5P+JfPFXUZqB0pgTYefwBIV+HaW8YG7pEySlBdsvs9uB
sN95T4XmUsiBUcIEw5/X0Pcwe3hyWTmIxauqK0omhQLTIrCyucu0t24FppGKSCTA
wDNqZRJqhNIHFo3nQAA4uDAb9HRccJYSVMIfXinieFnNVHOiJFzLLGgtHvDaOa6z
zSIRHr81uXKMM5ovI4DyAG4oCGBqG41UoqQzjG55leggOcnC2rYz557kfhKee1qF
FbmuZnxNOkoyoD3aiS8fVNX1CM4qDCH8jtQPRiaRBPGUoy2Y9x7AjDlb8anALFFT
IFZyfmqjw+o0tdEutk6BzqbLYFpbpjS6muFWtx9hk1vahAMxdiyHWgUOMHX/7weM
fxMd4FG65G/8cnyq/114CWAuMDCZ9MJbWpkaS7lLJ9GpMYmaVG9marf1RwHWFyhK
dYuHJAszh3gKfUdRL8lCdXXjqypS6CVuNFg+WfcgciKAO0yolpj2AAg/NHS5vdLq
vj/u0plHekCCPLcetrVciCeBpjcMBl3xZ2Vw2YTSoIDx7Es+3IOBRtO6ILZcjO+q
KT5nHEjH4Vsy4Le82Gt+8mGrr12+ldTVH+g5kp8165SpUy1epKPJ11+UL9Whp/8E
UrNPSx0Kb2qBxb7hynTY
=OZKk
-----END PGP SIGNATURE-----

--fblc08uBQ7kpPybH--

--===============3804465847099746145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3804465847099746145==--
