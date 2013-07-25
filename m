From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: Set sdma peripheral type
	directly
Date: Thu, 25 Jul 2013 20:11:48 +0100
Message-ID: <20130725191148.GP9858@sirena.org.uk>
References: <1374745301-29508-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4073202823465751613=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A68E265652
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 21:11:55 +0200 (CEST)
In-Reply-To: <1374745301-29508-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============4073202823465751613==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/iFx7UFBKvQAxELg"
Content-Disposition: inline


--/iFx7UFBKvQAxELg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2013 at 05:41:41PM +0800, Nicolin Chen wrote:
> Let CPU DAI drivers set SDMA periperal type directly to support more
> dma types(SPDIF, ESAI) other than only two for SSI.
> This will easily allow some non-SSI drivers to use the imx-pcm-dma
> as well.

Applied, thanks.

--/iFx7UFBKvQAxELg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR8XhxAAoJELSic+t+oim9I4wP/0gVqoqMaLeA75LA/ggwrtpL
iBbJdmVE4vPeYLmpYGgHvES1BDMpmgA/EXalVulhdoaCUa/V5MjQiMrU97sw8YQs
GpUEg6pcVFB+iBZdnt43Tr5rQusZ2OAalURhW5atAGKFqEn3/2sbQtMbU57/B3Qz
vZOiBS2hx7eIlN35wbcbFox70MB351fVolmD7NdLzYx08P5XNfss4B4lJ3OrblV/
eEBSBwTiBftAkSMnb3KyQniACxHV2jKAyp7GDymHL+yl1/qQ5jFDurz/5co3BvzL
+FufAU4/VA8i+jbHpmaep8NzW7xVWGYq+1nRNRvZ64/1TWFaSXV+3Idk61hHYLdh
H49SnUfNOLhgLyMg6wCZ6xTIafOVnrccEU04zk/8WtxS4kHDGF8JN+Osq5nXLZJu
/QQSVBkjVgH6/4eJ4cX1HFkgTHU5bncvjp+uz/ks1+o6MITyvbgAU+pYotzR/BiI
/BPYPO91xfuqFkPVw15f0NTpj8a6wsy72yO+rcKOH+92AfYmRo1eOdTq41mj1ERz
H8DoDml2yvtlnnucN0NgmqHBc0ayhAZXaTVVgG/xJFrLzLWu8qyeCM+NgbRZXn/G
QAQQUKi7H7PUv4gflByhCS21EfmgnKzZX5nxF6PYxXyb/tELQUn3m8xOrl5Q8sMM
bQPG1gFmMqL1/vDOKhzy
=ygfU
-----END PGP SIGNATURE-----

--/iFx7UFBKvQAxELg--

--===============4073202823465751613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4073202823465751613==--
