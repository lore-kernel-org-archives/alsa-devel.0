From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/11] ASoC: tlv320aic32x4: Cleanup manual
 bias level transitions
Date: Thu, 27 Nov 2014 11:16:45 +0000
Message-ID: <20141127111645.GQ7712@sirena.org.uk>
References: <1417031880-11364-1-git-send-email-lars@metafoo.de>
 <1417031880-11364-7-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2841520494930033400=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 15D0D266046
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 12:18:41 +0100 (CET)
In-Reply-To: <1417031880-11364-7-git-send-email-lars@metafoo.de>
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


--===============2841520494930033400==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dD5edeAjnkY7vejr"
Content-Disposition: inline


--dD5edeAjnkY7vejr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2014 at 08:57:56PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied, thanks.

--dD5edeAjnkY7vejr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdwgdAAoJECTWi3JdVIfQaKoH/3x9aNeoO/+AmKdT7XcArjxT
kNoOZS1r9VC822m0/KIwBLikD4QkpdtAqWFXoMN1bpr3NlfPmtOalUnPIo+G4i3R
ti5jrOqsqNPyOhHWWDSzhi0rNt+4ksfI7HJuFiuiSAYuOcoVDDjTMbPtQdG3RhXx
fwIvoMt5wBvY+xxMMB+AKpqA6bYX4VxpyeDsHG6gbmf3WgzDjhoXl8H9QV2Lvtdb
8mH1AFohyVpldj745Nu6VDDMzHWut0PZZZHLe/cuz6hH9EEOxmd9f5iugD6XsKNA
sj6AjSKnDzEr1vQJb+1iBfj5VQNovxUG0lawFUHVY8aPBhlWpZCCllHw73aClaM=
=0hMo
-----END PGP SIGNATURE-----

--dD5edeAjnkY7vejr--

--===============2841520494930033400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2841520494930033400==--
