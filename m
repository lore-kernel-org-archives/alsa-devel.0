From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/11] ASoC: twl4030: Cleanup manual bias
 level transitions
Date: Thu, 27 Nov 2014 11:18:13 +0000
Message-ID: <20141127111813.GT7712@sirena.org.uk>
References: <1417031880-11364-1-git-send-email-lars@metafoo.de>
 <1417031880-11364-10-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2535143246568654881=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B2C08266415
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 12:20:09 +0100 (CET)
In-Reply-To: <1417031880-11364-10-git-send-email-lars@metafoo.de>
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


--===============2535143246568654881==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BYnYpLhZORqpXgE3"
Content-Disposition: inline


--BYnYpLhZORqpXgE3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2014 at 08:57:59PM +0100, Lars-Peter Clausen wrote:
> Since the ASoC core now takes care of setting the bias level to
> SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
> anymore.

Applied, thanks.

--BYnYpLhZORqpXgE3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdwh0AAoJECTWi3JdVIfQdVEH/1yMoaEQaBwsfHCKFyzy5J/R
QjuMIv+gbNBORFE0DClOFqahUavGca79ZK69jhclH3RS4fK0Wuvo3fVwpiIBdyuU
zPF4rCsTiGA/F78Kx9G0OejLqJo7S8vsFoGmtfhOi9760Pqk3AgPB+0FCkTFVviq
1oB1lN7GP2IdfXzm+wwjpFpzZuAn5DCO1GJGCMcVTFzCuUHNjvoZpSDT/GmB/D3w
qu/MLHKP9WinUZoHi1B84bTepjErBwnU36JOrfuTB3ageI2GBtVQWFmQc1w+IYlz
RgpjJN2NWXWTTJzJtnDPuSbvW9eq2BaqI+EH3vi+EQ4xVQ1EGNLgLaMnZSJZcvA=
=2fe9
-----END PGP SIGNATURE-----

--BYnYpLhZORqpXgE3--

--===============2535143246568654881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2535143246568654881==--
