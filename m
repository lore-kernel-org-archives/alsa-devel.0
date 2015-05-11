From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: fsl: fsl_dma: Use true/false for
	boolean init
Date: Mon, 11 May 2015 16:14:33 +0100
Message-ID: <20150511151433.GG3458@sirena.org.uk>
References: <1431186353-7331-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4922804182273558602=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 78ACA2615F7
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 17:14:43 +0200 (CEST)
In-Reply-To: <1431186353-7331-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============4922804182273558602==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aYDVKSzuImP48n7V"
Content-Disposition: inline


--aYDVKSzuImP48n7V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 09, 2015 at 12:45:52PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Bool initializations should use true and false.  Bool tests don't need
> comparisons.  Based on contributions from Joe Perches, Rusty Russell
> and Bruce W Allan.

Applied both, thanks.

--aYDVKSzuImP48n7V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUMdYAAoJECTWi3JdVIfQ98EH/3RmDhG3bfEKJ9AbU0Fcrulo
H6ul/D8PvMHz4QpjcQRsH4CTG75cMs5lRMift3MUf7Wqj9IW4rkFeTnlZQqk9HA+
2emiA1Mf8El82wWGE1lM8trCRsdd9/1nnCIgMwAOV8rmjeoTzFKBQ5JTmFgG2nVk
hY3CeUnHnn7E0X6K453mKG5I00NONRYOy6HC3XHEEKPYE43BVz3KvUqnDaoupV61
KfIFNa28DGrZFNGd9zj0TmGgJmzZflmhCX5gF/2EKqFQVKNPqxOQehUBdCPVM65e
UHyxVcQ41a2a3P/rwqC1h6/fh1nWs/uBbXhEkW8HA6yyyorb16JUk1mGkZqrpdo=
=EHyq
-----END PGP SIGNATURE-----

--aYDVKSzuImP48n7V--

--===============4922804182273558602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4922804182273558602==--
