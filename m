From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: fsl_asrc: Propagate the real
	error code
Date: Fri, 19 Aug 2016 15:19:47 +0100
Message-ID: <20160819141947.GA22076@sirena.org.uk>
References: <1471613461-21654-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7641007934618145760=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 41310266FD8
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 16:19:57 +0200 (CEST)
In-Reply-To: <1471613461-21654-1-git-send-email-fabio.estevam@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, festevam@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7641007934618145760==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 19, 2016 at 10:30:59AM -0300, Fabio Estevam wrote:
> Instead of returning -EINVAL on error, return the real error code.

I seem to be missing patch 2/3 for some reason?

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXtxWCAAoJECTWi3JdVIfQupYH/2ojr0IXuMuN61iwIM2s016d
lZIWAxGP3o6ElWlfFWaEAJM7VZHqDCJ3M4Hu9Xn2KxRhajT6vqZGoTfBeKB3onN0
FZ2eSTKLFSoLs42Vq97nrzESHR1vxHcBF3yfDgm6KERh9vqi5JpxCFp3NPGiMHAj
yLievJ0lvaubN8LnBf3LJupMsQFV/Lo0WXlz52R0/pTBQJS9Ec9lx8YvOUfSxlWB
ZxkS71/4Exlb81U5xWEZMq9b6BbopNBVjjOUXJarS0rFDf50tBINqFA2We0SQ0hH
2MOBOSPfLlAX9/7vWp0M7JkQlWMWLoEpo70jFuNPvDQt/wEjD84mGq4E5b/wFMM=
=fgPR
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--

--===============7641007934618145760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7641007934618145760==--
