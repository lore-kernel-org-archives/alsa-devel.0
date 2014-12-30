From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: fsl_spdif: Use dev_name() for
 registering the irq
Date: Tue, 30 Dec 2014 11:27:19 +0000
Message-ID: <20141230112719.GK11764@sirena.org.uk>
References: <1419904356-6865-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7915692573700822361=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BCE10260609
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 12:27:24 +0100 (CET)
In-Reply-To: <1419904356-6865-1-git-send-email-festevam@gmail.com>
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


--===============7915692573700822361==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y83kbF1Jug0wPj8W"
Content-Disposition: inline


--Y83kbF1Jug0wPj8W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2014 at 11:52:35PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> The 'name' array is currently stored inside the fsl_spdif_priv private st=
ructure
> only for registering the interrupt name.

Applied both, thanks.

--Y83kbF1Jug0wPj8W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUoowWAAoJECTWi3JdVIfQW+wH/3BmVqZjUAV2Z5jAVO3ypVBQ
xPynByC+c6Sea8TyZnD3Hkm+7Qh6h9MA6aCP+T5dMfmQO+a3/zWy151JE6xrfAuj
K6J2cyiYIV/mBuLbEZbzqGxXEZCGvF25NkINy5wb66jwVtdvzCRrFRRrbHxPUxTU
Kil6NMOhgXgMqeUyljvxyaEps6UXLBisVcb1NayBISye03z2+PjqyY6ApGT4dgXv
WVXgArnLfxcX3BIp5pvLXyZxJawDDAkAg2GuzAluQTFjR/mkNdk10YIjbeJ8UQF6
dzF+DX3HX8DwF/UTuk0pw00A/UZrzVbagQdbSgROrzd9snOZWIYxjP+B4cL0OLI=
=f8MP
-----END PGP SIGNATURE-----

--Y83kbF1Jug0wPj8W--

--===============7915692573700822361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7915692573700822361==--
