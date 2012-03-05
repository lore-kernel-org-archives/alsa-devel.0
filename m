From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: When closing the port
 select PRCM source for CLKS signal
Date: Mon, 5 Mar 2012 11:58:08 +0000
Message-ID: <20120305115808.GD3224@opensource.wolfsonmicro.com>
References: <1330940332-16188-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6885774413755998398=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AB995103C32
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 12:58:09 +0100 (CET)
In-Reply-To: <1330940332-16188-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6885774413755998398==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xm/fll+QQv+hsKip"
Content-Disposition: inline


--Xm/fll+QQv+hsKip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2012 at 11:38:52AM +0200, Peter Ujfalusi wrote:
> If external source for the CLKS signal selection kept after the port is no
> longer in use the system might refuse to go suspend.
> There is also a chance that the external clock is not running when next
> time the McBSP port is started which can result errors when we try to
> access McBSP registers.
> Reset the CLKS source back to PRCM source unconditionally.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

though it'd be better if the driver could remember and restore the
setting when the device becomes active again so that machine drivers
don't need to.

--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVKpJAAoJEBus8iNuMP3d1ZEP/jULDxCTId1OwsxFPOxcq9fZ
Z4BR/FZiGbLOwwyEvimPK3EGLxPuxN+gCkGX+GkFTgboDYDH6WNAyw1es+aj/CnO
WT+4xyF1hNfMrvMJ9ALISQVDfjbPGzSTOuikju2Dg3pO8MkQlv1DPi0OCD5HF5BP
c7k6aqfiyYC+AuYx9HicahY1JpOTqWrOUmAE9NcKDuPItsSZcXG6ns085125M8bP
7nDIEPAg+4Q7cOco7avlH5Tzci3cJNEpYf2mbU0NXQ51ckMKr9qjF9q1LI44D3E8
rlnSmjlfvpboN+WJpYnaMvHSz66/pLFE2AVDukhwZMI7+BzDNF9xCT0SmKgeBwug
x8whHHlDHlDddOJv8U/sMvoXObd5fmnZlbK6aBKyzbXg1kOUX9bZhhqYudt89sHs
mE2SLxYuOk89H61cNdlTTvl+Kg0O7guufmCkS/nSLHG6tknCUcC2txLwTdvHI5ue
skFFrl2jLGOndxcPHFTbAqA/m0yzUczyaDkgTcVCGtKunnQm/40eHzshh+SnZXC+
5Q8vy0WIxTg+k6an34SBBXkbXd+nznZnw5hf29+ncDjM+9VIgjDwigI2UklXBlRy
TPVJkF2y6v+ifkk7zn+xXW+FEQ0namP5XajvwrRRRqE/vzJYF+R5QTahbdRocioN
c++2u7w8hkuuWx1yAVOC
=RKtt
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--

--===============6885774413755998398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6885774413755998398==--
