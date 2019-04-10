From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] ASoC: fsl_esai: replace fall-through
	with break
Date: Wed, 10 Apr 2019 12:28:13 +0100
Message-ID: <20190410112813.GL6106@sirena.org.uk>
References: <46e9b55edb223894392a90c7cdb6241a43cb9cff.1554864022.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6774683500481764400=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 14479F89616
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 13:28:16 +0200 (CEST)
In-Reply-To: <46e9b55edb223894392a90c7cdb6241a43cb9cff.1554864022.git.shengjiu.wang@nxp.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "gustavo@embeddedor.com" <gustavo@embeddedor.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6774683500481764400==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IuJpT0rwbUevm2bB"
Content-Disposition: inline


--IuJpT0rwbUevm2bB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 10, 2019 at 02:42:45AM +0000, S.j. Wang wrote:
> case ESAI_HCKT_EXTAL and case ESAI_HCKR_EXTAL should be independent of
> each other, so replace fall-through with break.

This doesn't apply against current code, please check and resend.

--IuJpT0rwbUevm2bB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyt00wACgkQJNaLcl1U
h9Ap2gf/fsXIkGithok8vTTKsIpkN7F3/tDXAUWIYdrO/+lBlspwg0g/6AuutiqV
nnmrg9ht56Q//Pz5mzfjvsBK6xoQPJqfy0vIwStg87JcbvH/W2Ov13N51XLLgRtv
iP1ukin4sYDjbxYTcHWWkdL/K4e0cg4fByGAcxFEZjMTf96DTzskOng+G0EnpnVB
cLnBMF+p/OHLXbvgWQHCIlQCmUnpHxUX+gtMNu9lFjYlWHtbQZL0mNVcpoDpF3zO
dbenEFMwWjj7Re1G7pX/ZT/EdlK3KyKqaswiTbLMHzV98JpuGYhWKadtYCLth2JM
AstY9cZP8epOQhG+yE5pPXAUVVGX9g==
=xtq+
-----END PGP SIGNATURE-----

--IuJpT0rwbUevm2bB--

--===============6774683500481764400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6774683500481764400==--
