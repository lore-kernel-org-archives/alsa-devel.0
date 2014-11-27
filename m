From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/11] ASoC: twl6040: Cleanup manual bias
 level transitions
Date: Thu, 27 Nov 2014 11:18:37 +0000
Message-ID: <20141127111837.GU7712@sirena.org.uk>
References: <1417031880-11364-1-git-send-email-lars@metafoo.de>
 <1417031880-11364-11-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6370819136185605133=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2780F266021
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 12:20:33 +0100 (CET)
In-Reply-To: <1417031880-11364-11-git-send-email-lars@metafoo.de>
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


--===============6370819136185605133==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WWsWR30MuS+K6DX1"
Content-Disposition: inline


--WWsWR30MuS+K6DX1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2014 at 08:58:00PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied, thanks.

--WWsWR30MuS+K6DX1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdwiMAAoJECTWi3JdVIfQ014H/RrN/IF5tpAnP5qvkoGF0MJz
5+tbc/bMhWrvbkKoJvYFLT7f7xOCJ2QpT6ZveDYyAEhjmwfSWtpVLvTIND4qIDNY
5jDjAWSM6g/GP2lWnr0KcKcoPGBDo/rdFRHC152z1Eph4SbtO2YEjmkdDlo0N3IU
y/CBiiv7OflmK9EGlWedHmRlLB7PqicxcEUPbx+WLoretkreYcnKFzuVS5cEOmdO
cWh3uFVLvVYK8gtoGrDbks/Li/67ZzN103ZOOW9cStXNA5a1zcI2KKbz3msOgsQp
4xX+VqysXS5JTBSSz9du3qkKPkeKon/B9BK1KFM6SaPJiOdKf8wdjltv1eKq0KY=
=PED1
-----END PGP SIGNATURE-----

--WWsWR30MuS+K6DX1--

--===============6370819136185605133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6370819136185605133==--
