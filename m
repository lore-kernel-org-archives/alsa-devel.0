From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: soc-core: Remove unneeded
	error check
Date: Mon, 7 Aug 2017 12:31:20 +0100
Message-ID: <20170807113120.itpstwa3y4i3zqlm@sirena.org.uk>
References: <1502075814-23766-1-git-send-email-festevam@gmail.com>
 <1502075814-23766-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0302423265994809222=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 02F282669F6
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 13:31:26 +0200 (CEST)
In-Reply-To: <1502075814-23766-2-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0302423265994809222==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2drm6du2bgso44tb"
Content-Disposition: inline


--2drm6du2bgso44tb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 07, 2017 at 12:16:54AM -0300, Fabio Estevam wrote:

> "A NULL return value indicates that something went
> wrong.  If ERR_PTR(-ENODEV) is returned, that is an indication that the
> kernel has been built without debugfs support and none of the functions
> described below will work."

> As snd_soc_debugfs_init() is only defined when CONFIG_DEBUG_FS=y,
> there is no possibility for debugfs_create_dir() returning an error,
> so remove the unneeded error check.

Removing the error handling means that if in future it does start
returning errors we'll ignore them - it's not like the error handling is
getting in the way or otherwise causing problems, removing it isn't
making things better.

--2drm6du2bgso44tb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmIT4cACgkQJNaLcl1U
h9BHDQf/UWTNiJ3xtPZVUkCRWYmKTsjkRWUtaenJ+CRccBT6EFDtd6pBkUcl+gUo
JDcpekBDbPbzKjIaad387EVEfYvG1nM+S0EAeDsbOJXaSsm1nM+79JbTsc05Ck9A
gQxHKyvMpXgHYLMQ1bkYMIVz+H4EmCgl4sbC0EqYu8dpgGKkPWrLHYa5EQ4QGnvg
uSmdHeoT4T2tDFViL2kEZIQx7Du/xZSwKCVZwvqcB2JG7uW247bnQ1LPN7Etu/wY
OJLr4T54iFnA/icPmBhgiUY+12CDclAMJwHCUGUw0Vh2GhRfnMbVVD2pSx28NwPf
6A7ZKqH0ngCKKQIEd7PhQrfG5mgjmQ==
=rTAa
-----END PGP SIGNATURE-----

--2drm6du2bgso44tb--

--===============0302423265994809222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0302423265994809222==--
