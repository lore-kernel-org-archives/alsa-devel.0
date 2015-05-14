From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/11] ASoC: sta32x: Replace direct
 snd_soc_codec dapm field access
Date: Thu, 14 May 2015 20:14:37 +0100
Message-ID: <20150514191437.GT2761@sirena.org.uk>
References: <1431595203-12851-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0092847285978561114=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C10726058F
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2015 21:14:57 +0200 (CEST)
In-Reply-To: <1431595203-12851-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, Sven Brandau <brandau@gmx.de>, Liam Girdwood <lgirdwood@gmail.com>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Jerry Wong <jerry.wong@maximintegrated.com>, Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
List-Id: alsa-devel@alsa-project.org


--===============0092847285978561114==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oYHLzUxHEKq3fcvW"
Content-Disposition: inline


--oYHLzUxHEKq3fcvW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 14, 2015 at 11:19:53AM +0200, Lars-Peter Clausen wrote:
> The dapm field of the snd_soc_codec struct is eventually going to be
> removed, in preparation for this replace all manual access to
> codec->dapm.bias_level with snd_soc_codec_get_bias_level().

Applied all, thanks.

--oYHLzUxHEKq3fcvW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVVPQcAAoJECTWi3JdVIfQhcoH/R56G6eLN42ZDa3ciMoFRha0
8k5RsBuEpcKgNZRgICRZfBKBF8K/6Prtx/Z+X6s/iOHE61RTRyqDVhM0Or1cF4AC
LYTk6alkJIJlO68HDEA3xlpY/S8/1GlCvn+D4M1sICNAhvF/e0Zs9YzN6yHaY04A
ltk3OCazZQ93A9PyidCgSJwBlOEP5UInwnZ5ZEs0oFbSQuYKvv/4c5i8gQ/9P4Kb
D4kLkZJ/cy54LneE4jPU/QZ1q61SbdNr+ieKps+jp1VxiIaQj/3sYUP4gN+z8RX7
klfBfaRcMSWvdZlCrn9ovbC6PQwvSUqk+7YzRqo6ihOc0+hXCDvicxDCeSZrfKw=
=GAhE
-----END PGP SIGNATURE-----

--oYHLzUxHEKq3fcvW--

--===============0092847285978561114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0092847285978561114==--
