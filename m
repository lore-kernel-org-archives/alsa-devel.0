From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 5/7] ASoC: fsl-ssi: Use generic DMA
 bindings if possible
Date: Tue, 6 Aug 2013 17:59:43 +0100
Message-ID: <20130806165943.GJ6427@sirena.org.uk>
References: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
 <1374924716-23475-6-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1189399491143719471=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 49C0F2608CF
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 19:00:14 +0200 (CEST)
In-Reply-To: <1374924716-23475-6-git-send-email-mpa@pengutronix.de>
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


--===============1189399491143719471==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7PTD44AewjTsiSV"
Content-Disposition: inline


--C7PTD44AewjTsiSV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 27, 2013 at 01:31:54PM +0200, Markus Pargmann wrote:
> There may be some platforms using fsl-ssi that do not have a DMA driver
> with generic DMA bindings. So this patch adds support for the generic
> DMA bindings, while still accepting the old "fsl,dma-events" property if
> "dmas" is not found.

Applied, thanks.

--C7PTD44AewjTsiSV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSASt8AAoJELSic+t+oim9wT4P/j4pQz7X4zk/DNK7yvVMooLS
EVVynStQ9NA2rLjpiOrk51LSGWv3Vco52qArZsgGlY55nu4TsheIRJioLAhSve2p
io4BkG44FOZj8XhQziPHwofCSeyPpHvHuuTh31lppg1Q0Ivh3Co059ZEPEJfikAN
1gulZOGRF0z1VjB/Zj2I7uoTyO5iAR5v0VuGZEzLyaBdfDy7Jt9j6l/RTKjZ9jHF
5GSpQhF3B7k+WPhEonhLy1g0bB5F8L7Q/my+vCsVOGQfG+d60XK3bCb7/8PGQEyv
JOphr9TyynX0e+EJuKwuSIosUmbBAhPh7SBWKLL2eRbv5BjMxoaCA17DLWtbuQ2M
KGz5p1+qYzGkDWtDu9Y+kGoXbpIh2C12CpO2tOowZ5wWJi61H585uNOxxjm/roJz
5IgvJXxBmIDu6hRt/CzdM2znWMAjm/V2X1s+lbHaR7K4iW/YN/MtXAJFhKIIroQM
JLmHm0f2DSPRop/1sMedhiNlPkiQ6j9x+zJwT1Q2s3GPdYI04DRzd4bSYxk1GXFY
JbDuC15wjennl2NtSCLLY7AUa09leWT6TXzuduQX0qj1O+0eaQUB5SlJ9m4XJfy7
05quJsx0go3c1Bz5ytNbT1oxN5wDnyG0VZJ8h2s6udaaANTWkljaS1pHFfb1Nf1D
Vas78v/c1384jQmkMIPX
=tz5O
-----END PGP SIGNATURE-----

--C7PTD44AewjTsiSV--

--===============1189399491143719471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1189399491143719471==--
