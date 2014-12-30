From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_esai: Use dev_name() for
	registering the irq
Date: Tue, 30 Dec 2014 11:24:30 +0000
Message-ID: <20141230112430.GI11764@sirena.org.uk>
References: <1419890246-21985-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8534426292058779063=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3372D260606
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 12:24:38 +0100 (CET)
In-Reply-To: <1419890246-21985-1-git-send-email-festevam@gmail.com>
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8534426292058779063==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HECHSKL9QsOKTVdc"
Content-Disposition: inline


--HECHSKL9QsOKTVdc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2014 at 07:57:26PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> The 'name' array is currently stored inside the fsl_esai private structur=
e only
> for registering the interrupt name.

applied, thanks.

--HECHSKL9QsOKTVdc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUoottAAoJECTWi3JdVIfQ0UkH/iCJi+QSqOf6V0m5UjvgKR/y
7ilEfM57Qqb5tWa0hFCd1vjrnSL40aoYTCL2wkS1wY/R6ApZ5443OO61v/0Fmcmm
4Oflzd/VsadaXCqt/XX1zri2tu+Z+CxwbkFbMJ9eBoi4AYNWFwK7ZN1OsMZmknH8
GQdc8l/GF585fH90Rik+xH6DMpGSf54jObAs2tKhAKTb39ILPVpFktMbvuDzHdey
zwtxJXZxiaX81rqwAyN5SZyIJWbNFYl0YjmfttZBn9WihELbRC0A+OOXUA2B7fBx
+vZWn5Stpm965hvrS9Re+ptt1TkPyqhJbyO331G2pRJ4OfxTMVz26JohVq12Ur0=
=I16z
-----END PGP SIGNATURE-----

--HECHSKL9QsOKTVdc--

--===============8534426292058779063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8534426292058779063==--
