From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: wm8985: Refactor set_pll code to
 avoid gcc warnings
Date: Thu, 27 Dec 2012 16:49:57 +0000
Message-ID: <20121227164956.GE5005@opensource.wolfsonmicro.com>
References: <1356371738-15997-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2272170862898766944=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7D97F264EBF
 for <alsa-devel@alsa-project.org>; Thu, 27 Dec 2012 17:49:58 +0100 (CET)
In-Reply-To: <1356371738-15997-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2272170862898766944==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Content-Disposition: inline


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 24, 2012 at 03:55:37PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Refactor set_pll code to avoid the following warnings:

Applied, thanks.  Though if you could report the flow analysis bug
against GCC that'd probably be more useful...

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ3HwpAAoJELSic+t+oim9jOsP/jsF0HhPaHvnUjD9L7GsuQq4
eEjaNQutZ1pxhfu/46KZv2B6JlAODperZdGvYM3HN0SVApabWnvO05x66/JWTIYZ
o3qR5OLh1cAXRAPpucUNRGwDzEVyMMqGrz/D7kKPpAFtKqz77eUD1bLRJaWLqkCG
/ycZnn/Fh8egrNsmvdQm+/40AWmBQ0Fy7DWBUak7rRC4JFKWCj7DLIBI4XZPTMg4
TvJrcC8r+YptWpjjWICZ0tMnmTTJe40G25GwG5Ojjcq/l3DnCulKYY44v2YDRC7d
XMnNnNTfCdu3y3wK2V/hIK2bETQ2Iwiz31XW0NucrPm5mxQ96YhtDtRkSlVFNhck
GbhTzx/mAoeya3z9cJK+Mi7kAHTcOc5ZWldShllx59AOL+Qv6rPohx8FVAyABQNo
Cok8HtrO99wh1e5tYax1fAJbAuWjlnyQfMmzOKxk3hXqoSlwPdWqjFWBKmEubeA+
+JZEP2qxkvGyQ6oV1JHUbGsF+IqcO3x3+OliqscJyWs2mwAEollZ3oVyP2nEIZKt
XxUQ5wUS8hOihUfCJ37W+O6+rKSnIeRwSrbVWlSz5/HXyTYlUbiQFtFWddwKHbFs
bIp+UqTerdgWF5obYmFEKNe5JDXV4WS49O9E2azEJt6VtD/C2/8ff9zXIeu/xqJs
XnXycPNGCa3SHkdf+eSv
=krsW
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--

--===============2272170862898766944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2272170862898766944==--
