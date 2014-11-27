From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 04/11] ASoC: sn95031: Cleanup bias level
	transitions
Date: Thu, 27 Nov 2014 11:15:08 +0000
Message-ID: <20141127111508.GN7712@sirena.org.uk>
References: <1417031880-11364-1-git-send-email-lars@metafoo.de>
 <1417031880-11364-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3092186382719705945=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 85DAC265DB6
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 12:17:14 +0100 (CET)
In-Reply-To: <1417031880-11364-4-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3092186382719705945==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N2xz0hsIMglW2w/Y"
Content-Disposition: inline


--N2xz0hsIMglW2w/Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2014 at 08:57:53PM +0100, Lars-Peter Clausen wrote:
> Since the ASoC core now takes care of setting the bias level to
> SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
> anymore.

Applied, thanks.

--N2xz0hsIMglW2w/Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdwe8AAoJECTWi3JdVIfQiMAH/j2/J4Bp4sMEbd2nH922+wHf
vc6ofHCr6CWJBrzgBYA8Zhm1dEQ5NF/zw4Y6ENMCv5JtJiTXssbISpGzn2hkOLt2
DQrlncIVy3dTav+xkqJA5DVyc61yuQaonB/P05UjHzydec/jg8xb3pr4oR6Q8ToS
M0grXYX29B+SGjLEKI2tUTECw9QULtOVS0bnKwun8Z9Uedhi9EfxRFest6/tAUQR
IeuF+EQ+7NaD+ST7uKn9Xm0x5VT8TZHwBmPLEFAOHy8RdU99mbquqpR+kn3Bi9Ky
adkesTvShGzFootN1ZBz6DfrJAye1+y0FrESK7DbFeR8qDreG7KCtzcEV/S9ieA=
=AzPR
-----END PGP SIGNATURE-----

--N2xz0hsIMglW2w/Y--

--===============3092186382719705945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3092186382719705945==--
