From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 009/102] ASoC: rt5640: Remove superfluous
	const
Date: Thu, 20 Feb 2014 10:56:56 +0900
Message-ID: <20140220015656.GX2669@sirena.org.uk>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
 <1392723148-12597-7-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2856209257087800211=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 52A62265635
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 02:57:11 +0100 (CET)
In-Reply-To: <1392723148-12597-7-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2856209257087800211==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n7ExMvyyjc98m0dB"
Content-Disposition: inline


--n7ExMvyyjc98m0dB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:32:21PM +0100, Takashi Iwai wrote:
> As SOC_ENUM_SINGLE_DECL() itself contains const modifier now, we can
> reduce const from its users.

Applied, thanks.

--n7ExMvyyjc98m0dB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWDlAAoJELSic+t+oim9dtEP/2Mk/8tusJzrM6dsS3dYDvgB
F0oFjl4kx+AyVBg334rav7i2RjubywrRhFcWM3d4C8YfJx3o+QnnQ+gKVDGQzA8z
meKnYyEdz2OCL32fSFASAya36TsHczMA3JUMvnsRPdSqNhqoyhs+dnKFjaNFRWBr
me5MkmEfBt3FMLrlpnPy/+XLAX8/y5OD88ggl/59bmL1/xoltIUJNliOZh6iJMbp
xJYHKDwQ11JUZfEY/Ofu+CWWXRuGdCI5SoQG+ZNNx8AyjCUt8POwyDQctfuJi66j
LcE4gywsGYRaPC5OaqpA5J5WtKCong8Ni6yr0VOpvst/tlud6wmlwDUZkWHRnJAU
odihDvG+ys1PJWSfmeIlMLAurp2WqnR3yl9nhFBW/C7ANLReaPz8S1M4WC+Hq8oJ
7XWLH5VGjafYpgo/tBZb6uQvusFTwV04MXR4qT5evhRbBUNWm5sAMigvZ2s8tKqX
Onc0Q0cLos2wwomgRlc2UAP7faLslKvA7JKmIrNk9jrZkWPKKQ3DKyyLhOSHSkyh
4IxQaEdR7sHqo8Bf3AWZ6SEhMyjJ3ZDM0+9JMH0pOsOPHqRVihb8pr6yXbJYF5CL
UL7e1H/zicFWpyUg8/AYw0jJBsbEqGokN05916m2p3J7vGbOdX2sOuyKo25FasZb
/eMmwDaB0SDtZJDTCVc1
=C89S
-----END PGP SIGNATURE-----

--n7ExMvyyjc98m0dB--

--===============2856209257087800211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2856209257087800211==--
