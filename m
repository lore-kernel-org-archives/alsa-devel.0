From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/8] ASoC: mxs: Setup dma data in DAI probe
Date: Mon, 22 Apr 2013 11:28:39 +0100
Message-ID: <20130422102838.GF30351@opensource.wolfsonmicro.com>
References: <1366478947-9377-1-git-send-email-lars@metafoo.de>
 <1366478947-9377-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4004169519742224018=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 834A326160C
 for <alsa-devel@alsa-project.org>; Mon, 22 Apr 2013 12:28:40 +0200 (CEST)
In-Reply-To: <1366478947-9377-3-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============4004169519742224018==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kbCYTQG2MZjuOjyn"
Content-Disposition: inline


--kbCYTQG2MZjuOjyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 20, 2013 at 07:29:02PM +0200, Lars-Peter Clausen wrote:
> This allows us to access the DAI DMA data when we create the PCM. We'll use
> this when converting mxs to generic DMA engine PCM driver.

Applied, thanks.

--kbCYTQG2MZjuOjyn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRdRDPAAoJELSic+t+oim9UdwP/RcfzlzZU7gjdJHd/ZV17IXv
cNmqSzuhJWLZbV3wM7ucCO3ElU3lc7hH0F6CcNTQPoGfdeYqQjexMjVJC18YKMl1
OrOiqzV6O2BykjhxcEefqLzkDFKhGPWPdPKLIdylVajeXapSry+cHBkKAEZ9mDmH
UVb9UP1VjEMV9KNLk8x/FlXtJQEcPL9Kl/HbgeJwNMgsUy9ulYdJ+LF7mYSFHnPv
SGupb60VYcOdFAktLxJNZo3oK6H42waE3/+y2WeR+c5bNdbRdUvXQUIokKmCJEQO
2MwN6KNdKlaJ6QEdWveNDv0aJfEZ/LyXmZ3wqLncEL54027pkqeemZbtLLVL5hez
ZFDSzRBE1JNtN4KSr+9zpHY9TQMyPxdi6ZGqHKcaQl1yqMslR0eUSr8VLd2J8y+v
mA7vPmUyKvTjN7elsIuRN5PIHA7r0FmLOdhAfCuoZEMwtU6JcSJEPLiL1QQcG104
2rNwm2twGkh4UO/fNyWqnh7wYAE2BnB6oCJEVCYQs0RC/HdgGvYgFnWI8yYUXjN0
iyB/jcJUIyf6r5rjXA+UgXdktMliFnW+sfEQbrEnaXMfHUwaDzovd1Q23KKk6DZV
sA+VkmAkC1YIuWbObmfHqxquOicxeT1xga3EumIBp90GRbTuv2HvcaTTsnxjFb4X
BffABW1l8GbGPN+o8uHt
=EHoP
-----END PGP SIGNATURE-----

--kbCYTQG2MZjuOjyn--

--===============4004169519742224018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4004169519742224018==--
