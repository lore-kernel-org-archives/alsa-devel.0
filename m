From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: Add resource managed
 snd_dmaengine_pcm_register()
Date: Thu, 28 Nov 2013 13:36:10 +0000
Message-ID: <20131128133610.GG27568@sirena.org.uk>
References: <1385625037-24973-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0472071604421813614=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C7AAD2651A0
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 14:36:33 +0100 (CET)
In-Reply-To: <1385625037-24973-1-git-send-email-lars@metafoo.de>
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


--===============0472071604421813614==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VACxsDaSTfeluoxK"
Content-Disposition: inline


--VACxsDaSTfeluoxK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 28, 2013 at 08:50:32AM +0100, Lars-Peter Clausen wrote:
> For many drivers using the generic dmaengine PCM driver one of the few (or the
> only) things left to do in the drivers remove function is to unregister the PCM

Applied, thanks.

--VACxsDaSTfeluoxK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSl0bGAAoJELSic+t+oim9JkEP/i5g9KGhyOSOaoAAwikXa8yQ
H8zKsenoIx4UJxiIc/JQizDdwMQ0gRENK64FO3He/kObn3c7vUHgnH21ArX896qR
ocwddyCWlvd8Y7ksQlvQfGhMeNRVfNmVZCXaA+ssSEnn6JtNRtENAtLP3p3v1OOn
Wm+ToyguTYQn8jjlb96vo8d4Xr27xD94eP4DmQ8HFfBMXzu+iXgqsafMQsLa5zOK
AWF+CVaPvI+lgxBe7cG8RNWDTh+2L3Oyj4krnkoMhJE0ZA+qvqMGtt7c8CTSIp85
JuOGQe3aav4f6ZZHIo5V1XULnAxPGbTL9shb7Og6lvqtK4qnvhm/23I/1U3hFoKX
mgCYnerNm7Lg45zneOU2on4gHN5bz2aygpq5JzLmlzb4ACtRY+RiHcPs7RtxOd5/
lt6ioJOJMdLg+uaMG4ySN1T5+HbKUdYnT2f0EHOUJVCMoI6hMlF2GFu1/T2az29p
zFjUWvoyu7yGpZI6uRIBXGENtmbOBHoekcpQyKEnb2KDKvRp2mcEFxIKAOBrpwME
5170mYqhAbv1ghe/Txd7pATMoiPKBfYLS+rkQXNH/dOXGpajAgVjU1GDP3YeWf6A
qRlm/1JtoRm4Weo0YUDWY79PZiyHP3zgDfoF7xO7d0oXb+oks3iiH3iyDGrxAAQV
jkugLD88itG+eeRSLHcW
=RSKu
-----END PGP SIGNATURE-----

--VACxsDaSTfeluoxK--

--===============0472071604421813614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0472071604421813614==--
