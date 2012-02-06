From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Remove even more unused
	code
Date: Mon, 6 Feb 2012 19:28:26 +0000
Message-ID: <20120206192826.GB12326@opensource.wolfsonmicro.com>
References: <1328556193-24593-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7110448441309428569=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DEA88243DD
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 20:28:29 +0100 (CET)
In-Reply-To: <1328556193-24593-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felipe Contreras <felipe.contreras@gmail.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7110448441309428569==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 06, 2012 at 07:23:13PM +0000, Mark Brown wrote:
> Now that we're not implement GPIO or microphone support there's no users
> for the read() function any more.

That's microphone detect, not plain microphone.

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMCl1AAoJEBus8iNuMP3dJx0P/1tGTD0Hn2RKSXgU7ENYVeR9
hvVnIxBS9hPPX8GR4g/KSZZjcvXDMKqVZC19F9xgvQdLk9L5Mi3OHsLIgS469S/j
S0GQWENeGt+Gl4nkZKRg7lzlsDiCdxvudkiEVpBKy47vxblBfLB9FW57BSfDaRzz
fFZ5cSeg23tlugbDCromupe4XYM/XSOm2hvKIMhH0Q1T7VLuyDHFJYMECeibOOF3
UWBHjmcgWUVUhQiyBcohywnrvx4WwBldnnwYFUdzL9G9Lc5u3+RjGs0PqcltsPRR
jvTa1jOre7K1o2+tMplvTg4psJ1oRLa71+wz1aKPRNskBR9VxQwktd5qvLxej5gL
B4FakUOQLIOpGlrY9sjNn7taMpy8R7nTKnF6ASiPgIewcRyowQxp5k/WMXJ87kyJ
iEFhTmNN3K79MkP26jHZZwPoKTjCxCQIvWPUR4bKSN/zLoTfMI/q/s21HfkeXWtY
bUGtCuT1VZnxYqo8ZhrHr4Xf90KHPJt091T8FTVCZgV+FH82Pe6pp7lAw1Wv91J/
cdRHtO8I1wf2SjVH3DMUQVx4jonjNX3kbwBAu1S7zBLqL/HxLuKlhZKMpgS4H2Yx
YQ3+VAJ+AP+SJ8u1rVkLeW8m5pWh2e3A1FWPxu1evQrxhaWfDWN6yl4gTpVGB7Q3
ChHGrKIaOcHsmITXHp7/
=q0+c
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--

--===============7110448441309428569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7110448441309428569==--
