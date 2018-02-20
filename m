From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: max9759: Add Amplifier Driver
Date: Tue, 20 Feb 2018 12:05:21 +0000
Message-ID: <20180220120521.GC6378@sirena.org.uk>
References: <1519047958-22583-1-git-send-email-narmstrong@baylibre.com>
 <1519047958-22583-3-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5208672026671580661=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F22C266F0D
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 13:05:23 +0100 (CET)
In-Reply-To: <1519047958-22583-3-git-send-email-narmstrong@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============5208672026671580661==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 19, 2018 at 02:45:58PM +0100, Neil Armstrong wrote:

> +++ b/sound/soc/codecs/max9759.c
> @@ -0,0 +1,207 @@
> +// SPDX-Licence-Identifier: GPL-2.0
> +/*
> + * MAX9759 Amplifier Driver
> + *

Please don't mix C and C++ style comments like this, make it all a C++
comment - it looks more intentional.  Otherwise this looks good so I'll
apply, please send an incremental fixup.

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqMDwEACgkQJNaLcl1U
h9BKqQf+I8r9vpHpGAJfRSiXdFwKEDA9HVOxBRLQVV4FOhfaThFShCf1TPJMbMS7
oGAbl6/DuKNlpabrrkCv7jWipyVCDOWPN/YvvpWph6RbIHwUhBZEF4BucOclXGhD
kgKEEQBsSCpjZfALXqRKfdCWTe8gFnX+pAi/eP3cDChfvmDdQSlEx1siEh6ffTDW
wKoGAl/DlYmygtOKzBe4I8/KHgbV2Dmd9/WvPqdTPCiGD0LpFJV3RmYM6TlQjQxA
DAYRtPQ9+DU0ZvDV4lKKa7Pso18edxsVyk1L7mBp+HOqOTxkByHRq/R+ZOJKuDkg
GfODTxFqESv8pyFbXA54t4Q6Dv25dA==
=1WAN
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--

--===============5208672026671580661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5208672026671580661==--
