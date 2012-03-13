From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 09/11] ASoC: fsl: remove the fatal error
 checking on codec-handle
Date: Tue, 13 Mar 2012 23:46:39 +0000
Message-ID: <20120313234638.GY3177@opensource.wolfsonmicro.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
	<4F591B8D.8090705@freescale.com>
	<20120309013216.GH2499@S2101-09.ap.freescale.net>
	<4F5FD706.8040209@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4229194535374517000=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 34A1F103AC1
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 00:46:47 +0100 (CET)
In-Reply-To: <4F5FD706.8040209@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4229194535374517000==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dZJOqldIUwtPuZvk"
Content-Disposition: inline


--dZJOqldIUwtPuZvk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 13, 2012 at 06:23:50PM -0500, Timur Tabi wrote:

> sound {
> 	compatible = "fsl,imx51-babbage-sgtl5000",
> 		     "fsl,imx-audio-sgtl5000";
> 	model = "imx51-babbage-sgtl5000";
> 	ssi-controller = <&ssi1>;
> 	audio-codec = <&sgtl5000>;
> 	mux-int-port = <1>;
> 	mux-ext-port = <3>;
> };

> How does this handle multiple SSIs, each connected to its own codec?

With this card those would just be separate CODECs.  This is a binding
for a simple card.

> And where's the binding for the DMA controller?

The DMA controller is transparently instantiated on Tegra systems, there
really isn't a meaningfully separate DMA controller - the I2S controller
specifies the signal to use.  Currently the card takes care of the ASoC
level driver stuff but it really should be done by the I2S controller.

> I honestly don't see how this is an improvement over what I came up with.

The biggest improvement is that the SoC binding knows nothing about the
card binding at all, cards are completely separate and are free to
define any binding they choose using any number of on-SoC and off-SoC
devices.

--dZJOqldIUwtPuZvk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPX9xSAAoJEBus8iNuMP3dVD8P/RORLn07T1oXWQI3gu4ihBz9
2pVKaLSJKP0I1PvYB6FwAZReaD6USpW+YxVe5SQ6189dIBbmV5LFJeGg9qRARr2/
f02j7nQ1LcIDftuQBg2SVm/EeEdAXiTDB1TDLO6csyR8ePmm58/yvhT/ExfluMaI
bUGAsd3+FjF/e8N8jZwfHBx1ywW9lZSEg1D/g/s+yW7AZIdnfhe7FT4/9tuNY5nA
wOFM3LNfhIP5AiKdrVTYDVNqnLR/tM/10lJeFMya8xAHa7Wb1JccvXC7TxbbPC0z
NU81Y4bTH7henRGQ9LnTu8VpL6y5TTmIvMVnZTWm93MjeE7lIdHS6pm/ZA+2LhGB
27ok55dTx34shrfaAoO9lWoiOIZFX5ogsZE9i8FOTJZ3wgnzsJq8kMoVXYYjnnsu
ueVF+qShMWiZCPG6AjQhWe8QRH4z7dmBvj2Xt8HVZaVa3OVpLzbM4bt6BsdB5Zer
q3s2W5JH8wvm5K+gbwNlUsplPjk/dYJCogLH9L7Jm11pHPk8mNRzs+ApoLRKmDhy
Ku5cPgcQrhpaCBPPA33AAP7xQDvwld7MrWNbh8lTDeFmFCf5nYn5sPEMo2RmWxyQ
nIT5yv6Rv+OZo1hkTpsMkN98BFszypZXP2FQG49cLQf3GpkppHZu1M1hdHJgxgIH
kiqTqUf1SGFGqxUNxnAT
=VZIt
-----END PGP SIGNATURE-----

--dZJOqldIUwtPuZvk--

--===============4229194535374517000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4229194535374517000==--
