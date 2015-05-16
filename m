From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8955: Fix setting wrong register
 for WM8955_K_8_0_MASK bits
Date: Sat, 16 May 2015 13:30:50 +0100
Message-ID: <20150516123050.GC1964@sirena.org.uk>
References: <1431652516.5652.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0450729360474128667=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DB7C2614F6
 for <alsa-devel@alsa-project.org>; Sat, 16 May 2015 14:31:06 +0200 (CEST)
In-Reply-To: <1431652516.5652.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0450729360474128667==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2015 at 09:15:16AM +0800, Axel Lin wrote:
> WM8955_K_8_0_MASK bits is controlled by WM8955_PLL_CONTROL_3 rather than
> WM8955_PLL_CONTROL_2.

Applied, thanks.

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVVzh5AAoJECTWi3JdVIfQnewH/jX7dwi3Wv2BCUOQ8PRKRnnC
wXalCfd/vtX46NnClRQ3lqhi1/EvHNC9XlpIqTBeVSSEZZ53fq89MeMZQJUFKVQf
WqqXUtKPtnOQIcB+w+BPCQZW/ZLa/hkOGnV2zlwL9MkxGrZFrE9Qs4kBwxcTHb3r
pp7+8UaXr9aBJS0vw0ZHtyRUeV38o4wOW8g09fZqB61vMoP0rx1wAx2cCuLvxv8p
rYyi9TA2o3skU2EAlliDI8JS6oeKoiNu0OSzmVeKJ/vZPaQ8wa5Ik89mA1K+LELj
T27FkYlFacrLEgfPE7zZR/iCuVnVQml6juYdVFw4ZwwUHrHTh9g/12Kr6jVz0q8=
=1uZZ
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--

--===============0450729360474128667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0450729360474128667==--
