From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6] ASoC: jz4740: Remove redundant
	platform_set_drvdata()
Date: Fri, 3 May 2013 10:40:07 +0100
Message-ID: <20130503094007.GM4945@sirena.org.uk>
References: <1367572164-19523-1-git-send-email-sachin.kamat@linaro.org>
 <1367572164-19523-6-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0264798841146720520=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 472B72616A0
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2013 11:40:18 +0200 (CEST)
In-Reply-To: <1367572164-19523-6-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============0264798841146720520==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3FyYKcuUbgqNYeqV"
Content-Disposition: inline


--3FyYKcuUbgqNYeqV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 03, 2013 at 02:39:24PM +0530, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.

Applied, thanks.

--3FyYKcuUbgqNYeqV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRg4X0AAoJELSic+t+oim99dwP/jAfVnKzoGzdpgBiE8CXr3kw
XhKiWzSAEyYMtWLQ+2h55HobcP2xnmkrOhn2HwTVBdQ0myL6bClD4Q7ACvXU9mCO
GtunBLIxqSvA227FIauEemWoMHI3yrLfEGE1zErDbQO/OgnAZPxR930dIJXwdFVG
vvR+nU709byUn2Bqja6EkZSg8sL7RY53hY9aQn1XpzurbtPkB+sAoZx8lk8YjWjU
JPUtnHxOKOPcNxBlp58qeJ9/pFgar7Cayw0u1JAn4PKf4V5Ol4Yn4kEoSIfVgAij
jAvIspplEMwuUFwRT7uiSvK0cpxlDfNIfdK36I/ZGdP8XVnHHT0hzZy6p/Tl4wpc
h2nxBdxy9L4NU43Xx7mTPDCYTIzl5xuMuXeJXE4K1/zN098iPaip4cRerYimDWi3
Iu6cJluBh7vaqv3NctraG3W6PZmrv7nHhbBVI10/LPpDLqGiez06DHgJJfC06Ksu
xDJE8XvxEhkFs1oGV8jin1FV5wamocZ1TcEx/Y9vY0hBAsdK/quKBkB7u3EeWktK
E7y1QEp3Huvp5VHHlzVzehusl6hZdd4K7qng39kb3WK2zGlRTaZ/3Ijpir5vAgTj
Z4j+IZybWClAsUttQIE1LnUtuWzvxbqXJaCa2+anczFRwsaiJF8R0cOn1QeWHZoF
BMTtuaYHaDmhcqodkQHM
=Ce/o
-----END PGP SIGNATURE-----

--3FyYKcuUbgqNYeqV--

--===============0264798841146720520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0264798841146720520==--
