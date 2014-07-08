From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: core: Fix trivial typo
Date: Tue, 8 Jul 2014 11:58:33 +0200
Message-ID: <20140708095833.GT30458@sirena.org.uk>
References: <1404809172-12151-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4827211932977923792=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EC282610C1
 for <alsa-devel@alsa-project.org>; Tue,  8 Jul 2014 11:59:58 +0200 (CEST)
In-Reply-To: <1404809172-12151-1-git-send-email-sachin.kamat@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@samsung.com>
Cc: alsa-devel@alsa-project.org, spk.linux@gmail.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4827211932977923792==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8Bx+wEju+vH9ym24"
Content-Disposition: inline


--8Bx+wEju+vH9ym24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 08, 2014 at 02:16:12PM +0530, Sachin Kamat wrote:

>  	/*
> -	 * EINVAL means the property does not exist. This is fine providing
> +	 * EINVAL means the property does not exist. This is fine provided
>  	 * card->name was previously set, which is checked later in
>  	 * snd_soc_register_card.
>  	 */

This isn't actually a typo; both variants are equally good English.

--8Bx+wEju+vH9ym24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTu8C+AAoJELSic+t+oim9RosP/jPsP+OKKUUi98GqVM6XAF3A
o87bDZ0j5rnBCvRMxljq8UNyZWLjSp/Ud0XFu/A56Nrk4aq31Xu3iQ30ZRCwvMyz
z0LDo0dIb51UXwOCWQfFY2uch+kzzxWaEUTPd4NF53+9y0+0yOqC0YMQV19B6iFC
QQjFwBt7Cam7atbuac1Uvjrps0tMVVHijwC3z4NLVAdOysL78A0Pbp9BHFEMWrr0
JbtnB3TgpSIEtfbW3OyTn1usp/jPoeB3ykhjsK97SDrDcCNtG0u3PfxPb13/yxVN
vy6ZBJUvNvkWQQAU8zO2glRqj85p3nBICFNG2O4MKErh38DoztN6/lt3cjui3ocT
HjDjy85DFAPAYO/nB7CunXoiSbD7d/cgZkPFD58XOHcHBCkQFtXPjuKqmIfLWCKn
UUr42iGtYZiQ2Btz53rG2VwJqGVHvvZB+xGliYO//BYsDvG1fumFGh4dfWl9PCVc
16+Xh/Qg+arEu8yCnGHePnez42q7Ow2gC3AiJjwtD05djvqGe3hFYnyvRtRK1X/d
S+4DxwG/Jeid5p8aa9ve1x6hrRod643n96jh4A4gQBmg+JkWo7wQr8RR0D/QdZ/r
Sbqh86whvdykEILfh2jK3ZZzt3GseaR23nf2hCM073BHPqg2Q5auG7iP+pLmxF1I
T8EzdywFGep2yuGc1h2t
=IwGa
-----END PGP SIGNATURE-----

--8Bx+wEju+vH9ym24--

--===============4827211932977923792==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4827211932977923792==--
