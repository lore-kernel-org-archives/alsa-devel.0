From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFT v3 2/3] ASoC: core: Add one dai_get_widget
 helper instead of two rtd based ones
Date: Thu, 24 Apr 2014 13:25:31 +0100
Message-ID: <20140424122531.GU12304@sirena.org.uk>
References: <1398340906-5017-1-git-send-email-bcousson@baylibre.com>
 <1398340906-5017-3-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3807104962819301251=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EB9E265272
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 14:25:45 +0200 (CEST)
In-Reply-To: <1398340906-5017-3-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: misael.lopez@ti.com, lars@metafoo.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3807104962819301251==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+TJZ5BijLXVTLFft"
Content-Disposition: inline


--+TJZ5BijLXVTLFft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 24, 2014 at 02:01:45PM +0200, Benoit Cousson wrote:
> Replace rtd_get_codec_widget() and rtd_get_cpu_widget() by a simple
> dai_get_widget() in preparation for DAI-multicodec support, per Lars
> suggestion.

Applied, thanks.

--+TJZ5BijLXVTLFft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTWQK4AAoJELSic+t+oim9gNwP/jF75UGTUNK+S/NiFeFQc64Q
Q9BDlGrXpCuNRFlvLigIEGSBG9PGW/G5gbn0PSxCUhR2DNQubagX9xwZPa1a1kzT
NR6X+pJ2DqK3wRkIi6BjLU6v2oCCl9yGrpcifc+A7EZL5BvTgaqnzWY0iwr3++uQ
6Ti5qmkhmezdPk5IRyTSG1zyk32IFsoHarlw7CQIU48VAkFip4+DpFLPS4UrDpXT
KneCa1eu/Tw+a5hFiHAq+UR1N5d7a0wS1yoPpwwwt2a5fZJ9inzh2LEuusi05jF4
xuYdIOhGfih4ZSnvxn/K1JoH2bLVMhlX0Nj1NB7jn9pfzn6EhCt/wu+Jnubu/D/Y
C+ssN8pyisaNR5CvgBIGJtXPB+M4fO5d+cxpzpIorcXHik63BRnelZPfWks2N2Z0
da7/EfdOG5pjOxPVRnHmB0ws4uPYTb+lxAoaKeTgT6t68Q7XcleHDkQUwUC+LgtL
QVnmOc0/uM9+F9fpK5+Pk5/D4KY4PQYWWYzKg9pQszrTTDtfVZqoVLkk2yq1YKrn
9ipTUy7V0P1lHBmciqJsNv6f8y8Sd2tb/rixCKXijDJC79ijXXu+4zYM4Dsoj85S
CbPU9X3BFN8IprY/T8uLa+E4KYBz+GLFaq7zkVYlba1guobxCBZ7geR22s5my8Ys
jWYk/OOrnKEYtJRLX6CG
=AuMh
-----END PGP SIGNATURE-----

--+TJZ5BijLXVTLFft--

--===============3807104962819301251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3807104962819301251==--
