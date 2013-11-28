From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/6] ASoC: spear: Use
	devm_snd_dmaengine_pcm_register
Date: Thu, 28 Nov 2013 13:36:31 +0000
Message-ID: <20131128133631.GH27568@sirena.org.uk>
References: <1385625037-24973-1-git-send-email-lars@metafoo.de>
 <1385625037-24973-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6501433124900929559=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E85C265300
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 14:36:47 +0100 (CET)
In-Reply-To: <1385625037-24973-5-git-send-email-lars@metafoo.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, Florian Meier <florian.meier@koalo.de>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============6501433124900929559==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3ecMC0kzqsE2ddMN"
Content-Disposition: inline


--3ecMC0kzqsE2ddMN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 28, 2013 at 08:50:36AM +0100, Lars-Peter Clausen wrote:
> Makes the code slightly shorter.

Applied, thanks.

--3ecMC0kzqsE2ddMN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSl0bcAAoJELSic+t+oim9hygP/0qzXBlbAvhBl+I4hhWlA9/g
DjEdw3mOL4kooP9iMFUFQnLWuTmIUEpg/K3dUoTQrPtYJ3biy3FOL9zNRx7TnBSC
KJSqMw5/qCvg4iR0HBzcisJox4Ji03iZWkDUnFbmDGT8cJSAmhgmtAdVsEdX/RCn
gjar2t6Cr/n8R4E/c4F4Vg2xWffGGWf0GKOpS+8EeCFe0aNiPXmOwjJFgU4FSBs1
tUTnprWTyiAitC+dmxc447HtzYpegg39KGujkp3hZOK1Jp+1yAuiOtDQMoLFtMBO
lmRr59S0t9dIRHUi1wLsbzrfyzPh8V7wRQup1O2OC6+v2tdfGqGaaYmX+kTn90y8
bnUO5TE79AWKjIiZypJexJiRgUsjl1xP4nNHgsVtw3L1XnpgVb//8IrMzs+AatbU
WMPF3Igyd98qmXtZREQME9FzrBGyYgVJob+LC9SQdiMGrJmAZCvgRgMHwaht3LmT
MRuCjHh/4EaVWwyqpcAmRHjZpRXVBr/IeDK4B52PnPxdY4pkedTTawSR23PjgRne
HBtWWleZljuY6yVfInnv1FBzKIEXpe+Lnjcv2J+Dipw01fBILdig6Fay9dm3Dn4i
4ZEgpgMMmD0+HlwqtnkJReVcbpRL02gKSobJWPjW2qRzgr5rPnSgdT2oHYM9hxIS
xH5xKN7aN7nZicbJk/6H
=Y/hh
-----END PGP SIGNATURE-----

--3ecMC0kzqsE2ddMN--

--===============6501433124900929559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6501433124900929559==--
