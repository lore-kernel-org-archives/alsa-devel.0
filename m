From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] ASoC: fsl: eukrea-tlv320: Delete
 unneeded test before of_node_put
Date: Tue, 7 Oct 2014 20:01:31 +0100
Message-ID: <20141007190131.GC4609@sirena.org.uk>
References: <1412706598-18796-1-git-send-email-fabio.estevam@freescale.com>
 <1412706598-18796-3-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1039293746280162638=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 27F5226044D
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 21:01:43 +0200 (CEST)
In-Reply-To: <1412706598-18796-3-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1039293746280162638==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xYEba/cIt2nZJmCG"
Content-Disposition: inline


--xYEba/cIt2nZJmCG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 03:29:57PM -0300, Fabio Estevam wrote:
> of_node_put() supports NULL as its argument, so the initial test is not
> necessary.

Applied, thanks.

--xYEba/cIt2nZJmCG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNDiKAAoJECTWi3JdVIfQwlIH/2XhUvu+QSx6HiMP++7CnB6u
LkSkuzJnp9sl28bSM0OIqAxam6+kVkcO4qzEuVESCylqQusgvWNiogaew3HSgNeB
cXyCN/PL+hHgG+ac+JJ1m7vQrhn0DjHtlXZ1aYm/gZAs+7sIR2TdSRSRdp5BglgM
xjKzgoyivUdYzX0KRguoJhS4CyxB0V9jNvfmMZU//5wAmFYoiodM0a2JCirpG8Mw
c+VFxz6xo01VSF62mrd25KCdCR5raMX5iSmC1V9u1GJjKJQwxG61GWLZhlz3IfZY
XAdqhGvdG85SHY2AaOxkim405GDCvapY0BN7J6AfHAOwjJ9+p+8qPz9+lP7BTgg=
=pOcH
-----END PGP SIGNATURE-----

--xYEba/cIt2nZJmCG--

--===============1039293746280162638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1039293746280162638==--
