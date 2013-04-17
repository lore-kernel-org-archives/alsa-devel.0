From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 00/15] ASoC: fsl-ssi: ac97-slave support
Date: Wed, 17 Apr 2013 15:12:03 +0100
Message-ID: <20130417141202.GT13687@opensource.wolfsonmicro.com>
References: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2666238072846941336=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 316F726164D
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 16:12:16 +0200 (CEST)
In-Reply-To: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2666238072846941336==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vru7fAags9pVPvn5"
Content-Disposition: inline


--vru7fAags9pVPvn5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 14, 2013 at 01:42:44PM +0200, Markus Pargmann wrote:

> This series adds DT support for phycore-ac97. It is now based on the pcm dma
> cleanups from Lars. Beside ac97 support, the series adds fsl-ssi imx-pcm-fiq
> and generic DMA binding handling.

I've now merged the core and i.MX bits of that into topic/dma so if you
could check what actually went in and then respin?

--vru7fAags9pVPvn5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRbq2pAAoJELSic+t+oim9XmsP/RSyi11LHCB4mbopWBVJyszQ
IyaDSskNDqfwbAt3+F9rTM1Ybt2AVU3Dad1kZSHG4YrI7Tn8scFY6Y1MIQaXuEc6
2n3Wrer2wIJVSq55q+W5ZU2laYbT7TDZlVPrEyWC8D173d4xSYJaNtkExO5GLyO3
8AqgTSFyOEdeVHJteU2Eol+vAlwFXNgFHByY3U1mEXUV4gIeRJSz91PQf3ffTlKr
Ne+lssgSV69aL8Yx230S8xVIUaExJYpfoiNT9NysTU5J7egMXEuPRaABtd77/hpD
LJiBatkh3HeVEJLk2LYlS7PcAzdltXUDn5q50Ex06llabT6rGRGG1lR1BNKGv1Mx
C4RruceWfdGDY+njSU/2RoazDdpg4wEGQZUx6IHYnL7DTMpJ9JrCEKuRR9ZNu+XB
gQnhDPkompuWJRxIwRhofnloEtglolXWeVESK3v80PWBP4lniYLuraFkwnbJ1RCQ
Xf80915VL4iqqg5VzR+dgNsBGCJFTIAyngAev6Vk4+05Vl+92dbIR6lxSwg1X90i
MfQouHOvX1BCJ5uxRji0cQ4rVvCTos+xrdj0/+ss6VWoQYJm88I9K5ndWi/MfgRy
BgwnC7h9rFtBDsuxWyf+akSHlKbD/GR8FNy1GVeopey49yyOBPIjK+DlI91mGxfX
ScfDikEMieexzhk4GdOo
=Q8X7
-----END PGP SIGNATURE-----

--vru7fAags9pVPvn5--

--===============2666238072846941336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2666238072846941336==--
