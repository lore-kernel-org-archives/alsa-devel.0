From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/11] ASoC: lm49453: Cleanup manual bias
 level transitions
Date: Thu, 27 Nov 2014 11:14:49 +0000
Message-ID: <20141127111449.GM7712@sirena.org.uk>
References: <1417031880-11364-1-git-send-email-lars@metafoo.de>
 <1417031880-11364-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0533036939635388066=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ECEC0265DEA
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 12:16:54 +0100 (CET)
In-Reply-To: <1417031880-11364-3-git-send-email-lars@metafoo.de>
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


--===============0533036939635388066==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ppsrYgrxaSr1H4kc"
Content-Disposition: inline


--ppsrYgrxaSr1H4kc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2014 at 08:57:52PM +0100, Lars-Peter Clausen wrote:
> Since the ASoC core now takes care of setting the bias level to
> SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
> anymore.

Applied, thanks.

--ppsrYgrxaSr1H4kc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdweoAAoJECTWi3JdVIfQHM0H/0cMsURp8bUDHWRAbK702B9D
3qxpPvTHumYUxbkLshFMw7W1XNdDSKxH0i3/XOmebrDauuWeridx6YvzaxPDyPVd
8yDr3P4+qwRejoLd/u25rhk7lbLPNNgHQvHqo1KUPseNBkqn+qf2ZhMIfE8u6y9H
GvJhqwbLFx6sUwlw+5Qhn9hU3t7R7WAL4i3grFCS/B1tQRuuShe5VMTImLk7p3nx
VEyedxPctRAdtT0LGdC3SWvXb4ni/qJlW0thGtNoFkb5wzx9rN6uBsbTAIr2dqSl
8vsOdRQC5+d/p6o9YOY+MFiSHQ5+o04uXXX8dq/+B7jiIp+Yf61lspm72rpbYWM=
=7ndQ
-----END PGP SIGNATURE-----

--ppsrYgrxaSr1H4kc--

--===============0533036939635388066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0533036939635388066==--
