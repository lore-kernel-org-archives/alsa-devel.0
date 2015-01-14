From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: 88pm860x: Replace w->codec
 snd_soc_dapm_to_codec(w->dapm)
Date: Wed, 14 Jan 2015 19:51:35 +0000
Message-ID: <20150114195135.GK3043@sirena.org.uk>
References: <1420901048-5756-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1712488118860440428=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 370BD26525F
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 20:51:53 +0100 (CET)
In-Reply-To: <1420901048-5756-1-git-send-email-lars@metafoo.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============1712488118860440428==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fUvfsPTz/SzOZDdw"
Content-Disposition: inline


--fUvfsPTz/SzOZDdw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 10, 2015 at 03:44:04PM +0100, Lars-Peter Clausen wrote:
> The codec field of the snd_soc_widget struct is eventually going to be
> removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Applied all, thanks.

--fUvfsPTz/SzOZDdw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUtsjGAAoJECTWi3JdVIfQUqwH/jzzycXHBWToYJ6N1uRQvKXo
MKCqA7naZSuSJeSgmMovfvObpW7crb8Q7Vgk/o7UXdYjU1jKHMHMVKYt0a0KtHsR
DsWEZD9EUPxzeVIurlpzxIKmmf/0802SpKXFnQZNIxDL/OnLYede4T1iNnIJYJJH
xz3tyra2zGRjNm7gYN6IG2ywrBtzmKiFuqJGuOxupr4Jh8WhedXstOJHCf6Yy+Y1
0j9noYiKR4sefeUpXFvRWNBRsPNfywK87i6hZi5q+WzxeN8b3dP3/LryhCLnrqZ6
39Km+rnCkcdaznozxB7cEP7sqELy+5msJNIzbg3GaxBV7+GqhheAgD6EAAAlf1c=
=ckGB
-----END PGP SIGNATURE-----

--fUvfsPTz/SzOZDdw--

--===============1712488118860440428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1712488118860440428==--
