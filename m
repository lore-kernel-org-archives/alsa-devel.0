From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: sgtl5000: Fix suspend/resume
Date: Fri, 16 Feb 2018 11:52:10 +0000
Message-ID: <20180216115210.GE5886@sirena.org.uk>
References: <1518719809-14987-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0643171680580811365=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C0CDC267C4D
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 12:52:11 +0100 (CET)
In-Reply-To: <1518719809-14987-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, eric@nelint.com, alsa-devel@alsa-project.org, max.krummenacher@toradex.com
List-Id: alsa-devel@alsa-project.org


--===============0643171680580811365==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xA/XKXTdy9G3iaIz"
Content-Disposition: inline


--xA/XKXTdy9G3iaIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 15, 2018 at 04:36:49PM -0200, Fabio Estevam wrote:

> If this gets applied into next, then I can generate the
> fixes for the 4.9 and 4.14 stable versions later.

We should probably also send this to v4.16 - could you please rebase
against Linus' tree and then I'll merge it up to -next?

--xA/XKXTdy9G3iaIz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqGxekACgkQJNaLcl1U
h9B99Qf+Own7YdyGzhSsfBoVH5mBvjbsZFxrCrYhAeGXSXo57SCM+yv/wiNMhq8G
i+6NxU+5PdE8p5dRGZkhXtowRi7QFOFVrwd199YnxGaGfXjpo8gmm9FDJ6LR6TyH
vQN+ERAVzW2xWYfQAt7L6cjVDO2CMCdgYVadDL3x5MZgMK+p/pTLO4UnsCrhwXdV
IT7SxgTJjveGqeDLeBBFv0gDl0wFpD+8LICmguAN/H493jHdUhp/g/UKvThkL3C8
AF2fhKzwQ+mdns4eC0jwJj2JHhn2WQdpzAQUnoP3+aO21zlIncFRe1UW+40TUYUC
uHL3CZ0yWcM3EP57ktOoq5YpKq4KLw==
=BE05
-----END PGP SIGNATURE-----

--xA/XKXTdy9G3iaIz--

--===============0643171680580811365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0643171680580811365==--
