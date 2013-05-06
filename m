From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/8] ASoC: spear: Setup dma data in DAI
	probe
Date: Mon, 6 May 2013 20:41:47 +0100
Message-ID: <20130506194147.GG7478@sirena.org.uk>
References: <1366478947-9377-1-git-send-email-lars@metafoo.de>
 <1366478947-9377-7-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2217812341382528028=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 38097261B0F
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2013 21:41:59 +0200 (CEST)
In-Reply-To: <1366478947-9377-7-git-send-email-lars@metafoo.de>
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


--===============2217812341382528028==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JbKQpFqZXJ2T76Sg"
Content-Disposition: inline


--JbKQpFqZXJ2T76Sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 20, 2013 at 07:29:06PM +0200, Lars-Peter Clausen wrote:
> This allows us to access the DAI DMA data when we create the PCM. We'll use
> this when converting spear to generic DMA engine PCM driver.

Applied, thanks.

--JbKQpFqZXJ2T76Sg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRiAd4AAoJELSic+t+oim9neYP+wWXS4FUb80aHxt75EEnY0RL
C+sOGlEgNY9a+m/5XU1d/ZmatcdSobFax8jPqRY1IZkMAWntu5HgBv4KLBktH4sn
uOensb8zNshSzsdGQ8G6JKMaRx+0MtTP7Vv76/3bh2tclJxk0Nc6wk3sfN3JxRn2
TrFi83JowKDXqBuG4+8xq/X7557Q3vmxNoaFOQDRqp1SLXm2thSrd6y0hlJ2+zMP
KpqQoXIp8Cw2LVwimNW/Wl00yClvUKf45EiuoDN+79aCkLEFd/+TdIWM0NmvocXp
nun2q5mTYZuIb48n6jV3w7nAJ+OZSyNp+iZeRrks6oQGF2m86XFEczsUSJV18X/M
mcX8Qvar7y1WAK6avBz4+5bTdCVWSosth4rb3NtXnKN0q56MdE0FL3O4QkIIuw03
EOnvgHFactfIeTizTNa22q0aoCSkG91CvP3vS+ffd3AGSbHZl5DFhVbkmoGQPIgp
59yB563kWCmkcQjg3M1S/saiRzK6o1thM8O0ZzufI6tmpR6zd/qz8sdtlzB3AWvk
sQnH0Cj3zEAS3cAUgQCD1EvNr5df+EPhmHIhJ2U8tKGMl9p2WPEKixQfo+UR6DHn
O4ycNoTxbsHkulfyDlo8SA1FAZ+QQwiyRMNWVER8IXWMFiK+k++9bRQuvmHwWZO/
vwuIXtRETjIyhRYOiPbS
=qLXE
-----END PGP SIGNATURE-----

--JbKQpFqZXJ2T76Sg--

--===============2217812341382528028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2217812341382528028==--
