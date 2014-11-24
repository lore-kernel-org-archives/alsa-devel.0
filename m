From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: uda1380: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:05:31 +0000
Message-ID: <20141124180531.GP7712@sirena.org.uk>
References: <1416751454-16916-1-git-send-email-lars@metafoo.de>
 <1416751454-16916-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8170195515273010639=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E0D8A260534
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:07:37 +0100 (CET)
In-Reply-To: <1416751454-16916-3-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8170195515273010639==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QAdlk5ze2izLk3Ap"
Content-Disposition: inline


--QAdlk5ze2izLk3Ap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 03:04:14PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied, thanks.

--QAdlk5ze2izLk3Ap
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3NrAAoJECTWi3JdVIfQk30H/3Mzfc/biOSEl+lhsaudGcHf
lT1eSA6r4yHMQCxBb1SkPCHE3P3eid6Ftxa2eHxl3jmRBCYuFGETuH2GClEVYxyK
cTM6b+kj6bjnbmzMwRcg1JWUVEC6rI6xf0rSWZqpxeAx4VVPdCTvtpbJeoy7VC0k
YVPkk0nFDDByrfTyhwOtbGkk0+8X4KoS3qrsHQcqw1zvCPsyUsi5LhkfijS469a2
pTIWZhnhpRb3qk3MrWaAvQO5MCfhkk71ZqPqDqBrwBktU/Epwwj4q4T6T6PHd792
ywZ4YJKOIZpuVeCaTdxLlMNSmfuNN1YermYdB7k1Q1/Pj4Z8I00eFZ2S0Bin5tY=
=tPo3
-----END PGP SIGNATURE-----

--QAdlk5ze2izLk3Ap--

--===============8170195515273010639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8170195515273010639==--
