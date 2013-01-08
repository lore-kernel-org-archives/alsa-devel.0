From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: mxs-saif: Use a signed integer
	for error value
Date: Tue, 8 Jan 2013 17:59:02 +0000
Message-ID: <20130108175902.GY4544@opensource.wolfsonmicro.com>
References: <1357649104-8219-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7480252721488975166=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 42B5426523D
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 18:59:04 +0100 (CET)
In-Reply-To: <1357649104-8219-1-git-send-email-fabio.estevam@freescale.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7480252721488975166==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w+MAdceOglSEzbpc"
Content-Disposition: inline


--w+MAdceOglSEzbpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 08, 2013 at 10:45:04AM -0200, Fabio Estevam wrote:
> saif->id and saif->master_id are unsigned, so they can not be negative.
>=20
> Fix the following warning when building with W=3D1 option:

Applied, thanks.

--w+MAdceOglSEzbpc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ7F5YAAoJELSic+t+oim9T1sP/2xZES2rKxWYyfBxZmV97gKm
VSDZTa+LmImK7SzTaBriDvNsS5WnzHnD71xSf8jiUmLtXCPuUtKsa4K+01naxEVl
b8bEEog9OKqccWIoxXDi+g3B/2JzQ+zbfdjPJEO+5x7yMVW4dNUFdZ4Mdbqc/v/k
kiLqjTzhAxdzFFHEdan9NuqqQYkVy9zctksbd2S5AlBZS4hVxIm/B9ss6A4R0LiG
XBHWeH1BGNNuoYrU9G298ylCoDGdbYiuYQ+rMcjDmRmXKU0er9pp8L2xcDoeqhiw
ikqIOlYlDv3LIRfHwW/sLm5XB9fKkeBimkjm9OZuTPfG4IImyu9Kcq8eAWbbsPJ/
Fsz+2ld7d2W5QW+mTvV6HSs0IacfutwMniR1ud1PBvgm5QIR48GtCEmYV8+VqHct
Y9h5VjUnZE8F1IeKE0wlX/y7jJzrV4Mesl4Yn0YXYWf4Wp8H3mR8Nj9RiHExZ1yl
1Hg4pWGwdd6wBTxe1mVjLyO35CjoFkDeMhp8PyTHTEkmZdioctlEDcNDXw6TG41h
NSNaleS76sG3N2z8lJrORjRsceLNs7ZDZpFo1ZyvG7TklnQrxys9A82THVqf/DOP
5r27V3KgYuKAfjOVWNB3uStP4ly0BzbZ8YP26hgJx3ip7MduckLunRouD8h3ef77
W41rvFmzGQg+QxEeh30l
=OdvX
-----END PGP SIGNATURE-----

--w+MAdceOglSEzbpc--

--===============7480252721488975166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7480252721488975166==--
