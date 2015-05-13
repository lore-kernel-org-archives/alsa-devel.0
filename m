From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: wm8741: Add differential mono
 mode support
Date: Wed, 13 May 2015 15:54:38 +0100
Message-ID: <20150513145438.GV2761@sirena.org.uk>
References: <1431509941-14507-1-git-send-email-ce3a@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9017701797189228717=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CE842265D05
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2015 16:54:50 +0200 (CEST)
In-Reply-To: <1431509941-14507-1-git-send-email-ce3a@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <ce3a@gmx.de>
Cc: ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============9017701797189228717==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kD0q5DIPXzY/lIlp"
Content-Disposition: inline


--kD0q5DIPXzY/lIlp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 11:39:01AM +0200, Sergej Sawazki wrote:
> The WM8741 DAC supports several differential output modes (stereo,
> stereo reversed, mono left, mono right). Add platform data and DT
> bindings to configure it.

Applied, thanks.

--kD0q5DIPXzY/lIlp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVU2WtAAoJECTWi3JdVIfQqRMH/3UG2SX88LyZb/Txc0PhtA53
GBl6yxpwHQHpx9aleSxQduEV/0nVW/v3VTKOOkCHB++tiLmPM3EwGJN3lrIdnOyL
QVFPZ9WhDafC0F3cBHWb0Kk8FnYCVk3y0eNRzbVKrSN2s2UFu6sg2FJQLsZIzhci
It1gc18BYPiQGAKgpamYyqfRw5Fu16Tnje4XaI2McML+saDix7q+49R6xaQutfL9
Cwk9o7dznekyjYFloh+nNT4L/hbC9B8p/voIaQKYmVIGKPro26Bj/+3ce/DbDyc3
eEiufgVC2Fj4o51fsRg6MKXwl5ya6M6P/e6E9I7daGs6QE5TPzKZLxsdPmC6Y8s=
=2kbX
-----END PGP SIGNATURE-----

--kD0q5DIPXzY/lIlp--

--===============9017701797189228717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9017701797189228717==--
