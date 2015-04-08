From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: Remove custom
 fsl_ssi_debugfs_create/remove()
Date: Wed, 8 Apr 2015 17:59:46 +0100
Message-ID: <20150408165946.GC6023@sirena.org.uk>
References: <1428512062-17229-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2872495618327643293=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D91F1265375
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 19:00:16 +0200 (CEST)
In-Reply-To: <1428512062-17229-1-git-send-email-festevam@gmail.com>
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============2872495618327643293==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FkEFdId2WpBqWH91"
Content-Disposition: inline


--FkEFdId2WpBqWH91
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2015 at 01:54:22PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Since commit 81c7cfd1b22a0 ("ASoC: Move debugfs registration to the
> component level") ASoC core code deals with registering debugfs, so we
> should remove the custom fsl_ssi_debugfs_create/remove() to avoid the
> following warning:

So this sounds like an issue but...

> -int fsl_ssi_debugfs_create(struct fsl_ssi_dbg *ssi_dbg, struct device *d=
ev)
> -{
> -	ssi_dbg->dbg_dir =3D debugfs_create_dir(dev_name(dev), NULL);
> -	if (!ssi_dbg->dbg_dir)
> -		return -ENOMEM;
> -
> -	ssi_dbg->dbg_stats =3D debugfs_create_file("stats", S_IRUGO,
> -			ssi_dbg->dbg_dir, ssi_dbg, &fsl_ssi_stats_ops);
> -	if (!ssi_dbg->dbg_stats) {
> -		debugfs_remove(ssi_dbg->dbg_dir);
> -		return -ENOMEM;
> -	}
> -
> -	return 0;
> -}

=2E..shouldn't this just be removing the creation of the directory, not
the stats file that was being put inside it?

--FkEFdId2WpBqWH91
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJV6CAAoJECTWi3JdVIfQDt8H/1ts9VtYflueUslbEC8ZEeeg
AXmeZ19XTnZ6nqnSiSZ5WdxytblLxHxFFja3I8xHNwsGb4Z1bwvh6wnizpGdiPrB
76aDFGuq+GNEnyASoe3FtKM/rpE5bZIhnrVz2rgl+9iVeB+yfIFluua5HIEOrSPK
U3hqOTxJsEM8fFls3VgBbVNA3x9QaPSIqZmgjpa5EBklwZzK47CLzH2e8SzzAC5P
zBhL2wE/zQjJj2MJBvyrh9rxhIos4sMp0S1VztAayzigE7B5BcH5GYls6oXqUhjy
jY9hgOz63GhS89JDIWGWnPfMnp2IwAeZQ3+v5Iu6VO+g+X+FsD6pyEhEvLrClgY=
=h8nS
-----END PGP SIGNATURE-----

--FkEFdId2WpBqWH91--

--===============2872495618327643293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2872495618327643293==--
