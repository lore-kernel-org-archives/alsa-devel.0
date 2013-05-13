From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/8] ASoC: ep93xx: Setup dma data in DAI
 probe
Date: Mon, 13 May 2013 18:21:21 +0400
Message-ID: <20130513142121.GB16673@sirena.org.uk>
References: <1366478947-9377-1-git-send-email-lars@metafoo.de>
 <1366478947-9377-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5216680709652142951=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DD745264F42
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2013 16:21:28 +0200 (CEST)
In-Reply-To: <1366478947-9377-5-git-send-email-lars@metafoo.de>
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


--===============5216680709652142951==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 20, 2013 at 07:29:04PM +0200, Lars-Peter Clausen wrote:
> This allows us to access the DAI DMA data when we create the PCM. We'll use
> this when converting ep39xx to generic DMA engine PCM driver.

Hrm, it seems to still apply against the current code so I did that.
Hopefully the tooling worked OK but please check.

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRkPbeAAoJELSic+t+oim9CXoP/AxTMc6iN2qbbaxJ9gmV/9PJ
cn6HntwGQnbxepvMDnHzrTAmelvbiMuttkh8hvk854UlVoxHgVBeMK/xcyjSf32p
IeZg1InJkweRGlqIgrvROF//hX5xOU1Y/chwrdBkcem7/jfrf7r4igRUbymEYmMg
C+SrphFtqCpe1PB3LbbnV9RXnSJ/NawxZwCMDUU7a+mtA+FEjr19nFwTOX2RE01E
9il937q/FdN1kcWsb//h7nxVacU5PxB/DDoaQ1ycCgT+TDYyo2+vxTm0X/p0rTzc
pygKOU4IQJzzXhQ7cFL/l+Qaw2HptCml6EsaI1NzYueg6PxOpQXOHqk3wFnmAMwc
Jk58dy1qaroYwwa7KkKgdmEMltaIXOu2+7Vf/+EqA/WrtI6WjNFoRlFp+m2hDNgi
hsxYuBQ3JDe7JY44VJBPOPhhIp6rmCDx/6HZ69OYb8/V29bMy7sqxid0dUG1o243
vHmBupQa/LHiWcXcwSnGP82dJnWr6EaykVxBw21Ijhz+r24JN0Y6iU6n42wGdA/y
lJQENf38aaZOdQpkjf0RMzicf0dq2GDZ1DZEEbpv/ZdramfzXaTDzheZgTUX3gzY
Wn6pI4q3VystahjXwc7iMvsxD3yydONk4qRl2Bt1DGWGsmh/LYBPBOlQWMOqNqWW
WRCEdWR/EANpmNAg/jAG
=3nuP
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--

--===============5216680709652142951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5216680709652142951==--
