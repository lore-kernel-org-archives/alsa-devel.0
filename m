From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: fsl_spdif: Fix clock source for
 rxclk rate measurement
Date: Tue, 29 Apr 2014 12:07:54 -0700
Message-ID: <20140429190754.GM15125@sirena.org.uk>
References: <1398697671-4635-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6528028537050876017=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B3674265055
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 21:08:12 +0200 (CEST)
In-Reply-To: <1398697671-4635-1-git-send-email-Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6528028537050876017==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1hVIwB4NpNcOOTEe"
Content-Disposition: inline


--1hVIwB4NpNcOOTEe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 28, 2014 at 11:07:51PM +0800, Nicolin Chen wrote:
> The rxclk rate actually uses sysclk, ipg clock for example, as its
> reference clock to calculate it. But the driver currently doesn't
> pass a correct clock source. So fix it.

Applied, thanks.

--1hVIwB4NpNcOOTEe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTX/iHAAoJELSic+t+oim9jksP/3eWERi8VGSDFHPdqahcuQhq
9zb8s+HnYI714UAeDVIqJgAZ7xQQfrxqEIUVa8e9AC5wIKyTO0fFajWrop9eSyit
bUj3fd9arvUiVVUQDeABfLsEj6T1Irj6kRfbBX7Uey6ZwWS2o5ynOmYeEJm5kJ/x
VKHd5nxGgsiVE/xX6EDOULMAjbDx91GJaK/xK/4h2PenTLpsBNhqDi0QpyhP7j+m
OqCyt8Hw/VlZUEVOMyfLUOrhspjtwPJyaDejKkUojCS4s/btb7alWeOPL1x74Jda
upL+czWtw+7MvHEmlEj+UBWH6Iyk0XXzmd7xtZqMuadU0p4wxBo9EaZrreA3KWmP
iNrd529RicsTHfNnX2P/KieS6rxDoZVfMCOIjs+TU9W28YIHm3ZIJdM3+1Rld0vt
a5fb0KG/hEqV82oXaZySKxq+B9P0gRJdnL4BPvUOvBpMgiJHQt/7+4xwNi+pU6Sy
QZzrsejLjlqrxgEfJD9HKXEcK9mAfMTuJgE76/4ghv9idFEbxRoB2pU25kxmqGco
NBPAMJuQh+wpi09fVxwNVYoIhTusY9AfsQQMP4cPxJuZrYpuvZiO6P76rNTlKZQ+
A6i1ISMGO2FNj/Qdqd1BRh1Gs2Pwu6xh3LJGK9efj6BhvpTy1HQXlrQidWPGPIAx
fFFKqf17Rb0AKIhfRl7P
=AVD1
-----END PGP SIGNATURE-----

--1hVIwB4NpNcOOTEe--

--===============6528028537050876017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6528028537050876017==--
