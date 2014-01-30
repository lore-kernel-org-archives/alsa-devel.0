From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: fsl: imx-sgtl5000: Use
	devm_clk_get
Date: Thu, 30 Jan 2014 11:41:30 +0000
Message-ID: <20140130114130.GL22609@sirena.org.uk>
References: <1391075238-20292-1-git-send-email-p.zabel@pengutronix.de>
 <1391075238-20292-2-git-send-email-p.zabel@pengutronix.de>
 <20140130102539.GB5189@MrMyself>
 <1391078535.4921.5.camel@pizza.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1025125388911932447=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D28E265363
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 12:41:39 +0100 (CET)
In-Reply-To: <1391078535.4921.5.camel@pizza.hi.pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============1025125388911932447==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MsEL38XAg4rx1uDx"
Content-Disposition: inline


--MsEL38XAg4rx1uDx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 30, 2014 at 11:42:15AM +0100, Philipp Zabel wrote:

> thanks, I got it the wrong way around. Instead I'll have to replace the
> devm_clk_get in the ssm2603 with clk_get/put.

What would be better would be to move it to the bus probe rather than
the ASoC level probe.

--MsEL38XAg4rx1uDx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS6jpnAAoJELSic+t+oim9xzsP+gPA2W4kDD18/Qd6UUcX0Srd
97ScV5AVHnuNvNKFhAqyb3d1vPkx+RCQ9I/3MK0mjoCmslVja/vb5xe6opHtEH+i
l2y0sf1A8jtKKUDdbU+Xe51k6mMgQ8UJXUtu3UlI+rn3wlXcOseVEJFSWsSbqO2r
lXtrGpTCXXK9Y14jpzvv3E81OwqdbW7/iEgmARN2PXj+FcpP6PTNVx+9hq82Ej47
aGnzsWC9TMxFHZSpX9qv+shHucikNWwfTvg+vVvHXYQVtXOtdHyCm0Axmf8i5ZdD
W+GqQSfQNQtLMKCyljECZB/Hrr+VZJt6SBfnkHE4kE+3CDi21ep7MkkzkOW+JBf+
E1ULS4H6+lw/+AHfuc9I/FX/ySrEFCiMPqMZRySo/ZRiCpdID3uldSD3FD+9yIxS
bdn3hFDY3GMBAO96edWSoKZfrg3W2GvCePJiLNr0nUwSImAdCz2jV2AdUOvapKJu
j5U8didecjWfj1BhXRe4zHpG9a2pHfey/j5GFrKBPirT4VkxxITRg0v2W5sAkI+i
P1Cxdxr2yT0kY/1UcAaXUjdhC2P7fN7gVkXZp8SEvE1Ou/5F4UYgkqtvBqMWfVNv
ckV+RIjQY92j9BdE4LZXzagYmQyDkbPIzj/nymoK2BeZMynAGLjS3Wo57zNi7Dvv
K+eKM2iKqWQMb9Xd9QPL
=zvow
-----END PGP SIGNATURE-----

--MsEL38XAg4rx1uDx--

--===============1025125388911932447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1025125388911932447==--
