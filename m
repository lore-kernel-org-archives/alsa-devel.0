From: Mark Brown <broonie@kernel.org>
Subject: Re: Question on compress offload framework memory
 corruption
Date: Thu, 19 Dec 2013 10:55:08 +0000
Message-ID: <20131219105508.GV31886@sirena.org.uk>
References: <63ac7c9c1f4ac8d8ef0ed9587fd1cf5f.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9217353619426976874=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EB138265350
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 11:55:12 +0100 (CET)
In-Reply-To: <63ac7c9c1f4ac8d8ef0ed9587fd1cf5f.squirrel@www.codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gsantosh@codeaurora.org
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, "Clemens Ladisch   lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9217353619426976874==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s0H35NU0PUc8VBh+"
Content-Disposition: inline


--s0H35NU0PUc8VBh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2013 at 01:17:51PM -0000, gsantosh@codeaurora.org wrote:
> Hi,
>=20
> I have following questions in the compressed offload framework API.
>=20
> static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
> 					struct snd_compr_params *params)
> {
> ...
> 	hw_params =3D kzalloc(sizeof(*hw_params), GFP_KERNEL);
> 	if (hw_params =3D=3D NULL)
> 		return -ENOMEM;
> /*1st question is, what is the use of above allocated memory I do not see
> this being used in this function*/

The code you're quoting there isn't in mainline.  I've also added Vinod
to the CCs, you probably want to include him in any discussion of the
compressed API.

--s0H35NU0PUc8VBh+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSstCIAAoJELSic+t+oim9hpAQAJLV3nP7czWS8Ejv37QMKn88
kOLfZSbLA3Cqdca+pCITDpO87OCkEP7cJNRlO51gR29jXwalZyh19aClVAux7Cew
6ipy6OLH3L/cLCwbUOhLaHAe7nQGrtfcF+4CuBxwYf44ULJrFhWUqlFz6snV2tKW
ZqXA1yGMJ0F6rBphHrRY7EeeMqxXbM/XSr1gPMgHQefjBNbw1Aqsiq9K+MoCmtHs
Nod71yxjIpw0HvbxVJDhIAto6hpMe74F51cZv7Zy0BLqA84m3wj9GsOxJ7tEXwDD
FkHjQXTXzgI5I21ncc7sg7QgpwP+T69TX/9dIDeiLI1rX/e6kBjkIHQrccmaxo8v
XHFo0q7iWnf4gX9vTwc0mqjiMxA0sSOUTUC70TU/dSXD5e41BZ3GMd2QfsFzaSWe
g5rQtUNbSvXxjFViBXZ5+Sb+H35hV2I+1BZHsvWmQeogaF6sN+M5bNhJJNdGnaFh
c7NqGnCaPgKeQkpLAWm0lH+IbUQsQouzCcCcWQATDjtpqTatkF7fIqfBozs/0sLn
3B4HJ/c7+R7qdhJpCHnSukJRizooMvTVPj7rDOX79Boq7+yZvdUErTTjOvhClOrz
KKJJ4e2XphhcvzZIlbpwAMT1lGcLwu4rFf5aygU3MLLc9KcLiBy8rp5RAuroPyrT
h1sV7sjVt6spYth8rnXV
=dIXC
-----END PGP SIGNATURE-----

--s0H35NU0PUc8VBh+--

--===============9217353619426976874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9217353619426976874==--
