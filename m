From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: Add resource managed
 snd_dmaengine_pcm_register()
Date: Mon, 25 Nov 2013 17:19:22 +0000
Message-ID: <20131125171922.GO14725@sirena.org.uk>
References: <1385299262-24304-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2379147518707043358=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 048C2261B08
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2013 18:19:51 +0100 (CET)
In-Reply-To: <1385299262-24304-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, Bo Shen <voice.shen@atmel.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============2379147518707043358==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GACvPnKyN03uhzyl"
Content-Disposition: inline


--GACvPnKyN03uhzyl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 24, 2013 at 02:20:57PM +0100, Lars-Peter Clausen wrote:

> ---
>  include/sound/dmaengine_pcm.h         |  4 ++++
>  sound/soc/soc-generic-dmaengine-pcm.c | 36 +++++++++++++++++++++++++++++++++++

Please put the code in soc-devres.c.  Otherwise this looks good, thanks!

--GACvPnKyN03uhzyl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSk4aXAAoJELSic+t+oim93ZcQAJfsbhHYsCSlUDbHxhD+WYxT
tlNCvJRl6yyKONBJ2Sv14fSVkdhjofew0O7X/mFELUPv5jjwHB6liJx741aWmk2E
jMh15zrfC5O9XIlp4EnWGh8wRgB4kvDcDeOBjTM/Qdny9XCNo/rg2e57F0aTych4
qOmzQV1RSR+jXm376QKh1/qi1cvALnvRavG6gSUWjTxt1c2i/jTs0GJA4LF9q9cY
3Gw0uIZ8hD2gv8z739lWMfhSGTi4IOV49HqaUpHetTO+MDYMs3EvcqzxNq55LpTR
Y1tGJepx61pj06bbWzadbkIHRnWVKhQC0V2VYWoidcwYEz4siFmh4EwTYG5151nv
aZxE1fVf6Sg9HkburzC8bRgOmm/ETAnNhYsK2SHrY7XUGPNoprHF73kRbPCuRj2V
8rYWvNKzagDcBIqctL9+0DOx+/ppQdjwHc2muvLoaS0secYMvsBNzWQmwBVEv8f9
Fv8j7Sj3Yb6qgFQepad/lvDWvFWW4mnHATdzkEEbXe11QjlKmDkNm6ukDD+Obdb4
S1kXJJwbIzXdV/1FaXqN0pZkOBh9LMj1TkNjFh7+SPcgQU89yJKJIDjNVj9LSyE2
vTqm7eywZ/7riqo+c7VzgHfS0SDVS9TMdJ/YQ9kyVNCAhTjF8QdafM+pjNPLlPiG
unCJydBnyKFROIGNM0EQ
=fNpn
-----END PGP SIGNATURE-----

--GACvPnKyN03uhzyl--

--===============2379147518707043358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2379147518707043358==--
