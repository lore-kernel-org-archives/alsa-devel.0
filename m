From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: sgtl5000: Convert mic bias to a
	supply widget
Date: Thu, 29 Mar 2012 11:56:46 +0100
Message-ID: <20120329105646.GB3668@opensource.wolfsonmicro.com>
References: <1332964426-8480-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20120329052410.GA19506@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6140410199565041569=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 539B91043AB
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 12:56:56 +0200 (CEST)
In-Reply-To: <20120329052410.GA19506@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Zeng Zhaoming <zengzm.kernel@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6140410199565041569==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 29, 2012 at 01:24:13PM +0800, Shawn Guo wrote:
> On Wed, Mar 28, 2012 at 08:53:45PM +0100, Mark Brown wrote:

> > -	SND_SOC_DAPM_MICBIAS_E("Mic Bias", SGTL5000_CHIP_MIC_CTRL, 8, 0,
> > -				mic_bias_event,
> > -				SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
> > +	SND_SOC_DAPM_SUPPLY("Mic Bias", SGTL5000_CHIP_MIC_CTRL, 8, 0,
> > +			    mic_bias_event,
> > +			    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),

> It breaks my capture testing.

Well, any capture testing that uses mic bias shouldn't work in mainline
anyway - there's no hookup in the machine driver.

> I'm not sure these two macros are equivalent, since they have different
> .id assignment.  To quickly confirm the problem, I have the capture
> back to work with the following change.

You'll need to change the hookup in your machine to adapt to the change
of widget type - see the previous conversions that have been done in git
history for examples.  No device tree bindings should be using old style
mic bias hookups.

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPdD/iAAoJEBus8iNuMP3d/0kP/0DjVW8ZxZrh6itfeGOzn7MV
TXj/O7YP1EuWR+9JkDaWxcY3f3ccwYBXRS7facVUA8IPgJ3nExK0/lgL0A5vbAYF
7FU+ZUnW+yRL5+Ajkm8xYamr8YPG/00cAnNozecrHADQqSsexDkBZRakfZ0AKAja
gyzO3qLxi8ra/OTlbw9/LWOiHyovmMYa44J7oVIKCDRQ7JWSKcUZMjVk+4NE11qZ
ajcgKznPcOacHb58iygtX+Aem3XfQYIOKrPCbc7qJLFNdl787uToFJtQyUdUILBe
IvZMQYptxw0MJ1ESGbgE+f6T2hkV5ug1KDorXls5eHMKbXv3KD3FbjJbXGnvyeUn
qcaAPSTtwIq8phQEBW57QORiecOAOiApzQs29jI1xiaQErfPnsdMUOGpAj0T2tsK
XSNRKP+em9/5tqBOQU2xtwyeOeOBQYukD+j/Z1pISZwq0eVmS0OeS912CLnnFwoc
kuFPjVfyGD2GNNmwYZZX6571PufYf7hWH1LEV2jmeC/3aw2IcU8vXegrns10+ytB
KjKw/NsoNuNnJT4a1FFAbb6nMPsGBEeprDp3JcmHYWoj2W0qKF7UMTkZd/bS/xZ1
vOkbktvB1e5tKZ9BakaMUWGEt9xCsspsSzMVwXXOqZ5KRWUHOyKbXSThL/KP5Aa+
gl7pdvkHDReMfYkxu85K
=E/dz
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--

--===============6140410199565041569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6140410199565041569==--
