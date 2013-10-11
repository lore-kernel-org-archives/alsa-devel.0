From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rcar: fixup generation checker
Date: Fri, 11 Oct 2013 19:53:09 +0100
Message-ID: <20131011185309.GG2443@sirena.org.uk>
References: <8738o81e25.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5688648934904520630=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 063AB2656A2
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 20:53:32 +0200 (CEST)
In-Reply-To: <8738o81e25.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5688648934904520630==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nqkreNcslJAfgyzk"
Content-Disposition: inline


--nqkreNcslJAfgyzk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 11, 2013 at 12:07:01AM -0700, Kuninori Morimoto wrote:
> Current rcar is using rsnd_is_gen1/gen2() to checking its
> IP generation, but it needs data mask.
> This patch fixes it up.

Applied, thanks.

--nqkreNcslJAfgyzk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSWEkSAAoJELSic+t+oim9ef0QAJGwgGfT011WmRNcgJZbqPXQ
qnDU1RKL+BfpYYtVp6QISCLDCGXDWvARiY0V534AV9EoBGVCq7EBZmveLGtEJarm
vyQEWATVhHaR3npFDQBTqPG3LKNJGB4GBGh7Iw6Np+aJh6Ypc5frfRcVj+tsMBCK
PGduSmATtGtGiFaKaYX9BvsqJkObjNSwWacsACccuqRi4Ub4JZhk9qkezde7fXtW
JuT+kQw0NSMr8AdkMke2r1i0qZ88LT88L5abhWQ3eCmo6cG/pQKIl4dewsEgY6uN
j7ECDNhuMeHxuo8POnke6phajwsTNzBeSUNmauzC7H/ulzXN/5jyc85sB/rHrPh8
yjHy0qF5/AsezIOdlLMhGNYqjGCrhU+afKjY9ok0mIsUegzpucAid6ap/AWhhkyE
jy85754sjfIQJDDrnGO9ZyrLgmX62xntYth3RaAlpfA5ehcl0KbuskuDPSotEmIM
4ktoc2t/e5Kn3rJB9zPi3BYTEcw4J+rSTMSJX24fdpAInjq2XoYRMqV2AjhMRSGf
o97cFaB+dSquPTUlqAauOlM5ZLas0ebX4+tVvl9rbOeskUIXF3mz4XkNEEad8NGg
krUi7OnelOirtx7O8oJI3JCfKCSogfpQDVsxhL1NMrPtPYBksd5itc85PMTK1lR2
qAOea/IaSmaXfatOclit
=vI2q
-----END PGP SIGNATURE-----

--nqkreNcslJAfgyzk--

--===============5688648934904520630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5688648934904520630==--
