From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/6] ASoC: rt5645: add device tree support
Date: Fri, 1 May 2015 17:32:47 +0100
Message-ID: <20150501163247.GC22845@sirena.org.uk>
References: <1430389127-24609-1-git-send-email-bardliao@realtek.com>
 <1430389127-24609-4-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7260033883603541926=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E9DF32605F5
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 18:32:58 +0200 (CEST)
In-Reply-To: <1430389127-24609-4-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, yang.a.fang@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, koro.chen@mediatek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============7260033883603541926==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XYConPLwA5Qz0vOT"
Content-Disposition: inline


--XYConPLwA5Qz0vOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 30, 2015 at 06:18:45PM +0800, Bard Liao wrote:

> +- realtek,dmic-en : Boolean. Indicate DMIC is used.

Why is this in DT as opposed to being configured by the DAPM routing or
something - what is the concrete effect of this?  Also...

> +- realtek,dmic1-data-pin
> +- realtek,dmic2-data-pin
> +  Indicate which pin is used for each DMIC.

...should it be combined with these (eg, if one of these properties is
specified should that imply that DMIC is enabled)?  We should also have
something saying what the value for these properties is.

> +- realtek,en-jd-func
> +  Boolean. Indicate if codec IRQ is used or not. It is usually used for JD
> +  and/or headset button detection.

I'm not sure I understand what this is for?  I'd expect that the
interrupt would be used if specified, though if a GPIO is specified I
guess that'd override it.

--XYConPLwA5Qz0vOT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQ6qvAAoJECTWi3JdVIfQPYIH/04jsYEBaEOtpNxE1XznB+lT
QBLSPvPU8xOT1GNJE5PmKfVXshMTMse8zGfrw5wiZuxbOT8x68K6l87LNDjUVguV
iujVpqKMlP8yT2t4IaFjl1Vl3QLXCP+yoVWeB9+AOkiRUbgVUxNbLpvT9ZALfVGI
tKmvRGWTLR+3IQwqjIe4+unK9U+HBwigCjIB5N+JbQRYDep0X1w0W1C/cNZY+ztA
xdW6/w++PxJcWFY9RLzchTC1mG+1hOhYjrrkUSb2UBqKmfEnVlJmrfOb+W2eyvTU
bB1Xr6pk++J5kyNSIM+MqH/cRI1FFd8AQDiJ11RzHSXBabYVsigvAzoYAiONiOE=
=btJA
-----END PGP SIGNATURE-----

--XYConPLwA5Qz0vOT--

--===============7260033883603541926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7260033883603541926==--
