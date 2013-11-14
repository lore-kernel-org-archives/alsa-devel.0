From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: imx-pcm-fiq: omit fiq counter
 to avoid harm in unbalanced situations
Date: Thu, 14 Nov 2013 13:02:40 +0000
Message-ID: <20131114130240.GQ26614@sirena.org.uk>
References: <1384271198-18974-1-git-send-email-oskar@scara.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2587988200500102511=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 98A6A261A1F
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 14:02:48 +0100 (CET)
In-Reply-To: <1384271198-18974-1-git-send-email-oskar@scara.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oskar Schirmer <oskar@scara.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2587988200500102511==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SRTEifjNkXp0Rce"
Content-Disposition: inline


--4SRTEifjNkXp0Rce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 12, 2013 at 03:46:38PM +0000, Oskar Schirmer wrote:
> Unbalanced calls to snd_imx_pcm_trigger() may result in endless
> FIQ activity and thus provoke eternal sound. While on the first glance,
> the switch statement looks pretty symmetric, the SUSPEND/RESUME

Applied, thanks.

--4SRTEifjNkXp0Rce
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJShMnsAAoJELSic+t+oim9TIAQAJOcYOS1vFXVLpISAKKT7Br6
0NAdB03z356Zoi6Z71GFETBP6H9rZlRGCA3AK4WKFSixYVvxanBHC4DHwxJTkLl6
WsOYg47PBjsE4VhKlrau6oYNGjKOscgxcC++8Lj7Fp/cArnhMRxU+efNwpAB7uMO
egdkXJ2iUrYtQbAMPGu/MmRkY1TCsUHmmeuLdRePiHuFnKAzpVZMI+b6AVqr8+ew
6ZmSRGbz3BH5Q9/FRNqy2yX+ZxZLiECCgyCLSFWUZ/35uGjHm50kTkj4tROap2MV
cl7Rd55veQlodmQBZJjtR83kcvtewO6hOccHBBx5vcCf0YwLG61GateWy8cWzpA3
DsOiHgoCZ0HvGRbPAf7IJufdgYLVkyIgLXH2xTUbS3Q48EOamxrTcqDqsgqwKaE4
UVidDoihStyVjLAQ3hjjGPQ07MS2aY/r7KYks79RpbzAg3x9v4MEVSCh8umsCI5y
bA3I0N86diF7Y4dwK0NMRVshiFkCv6Tg1VvL3tyuLlbvpOqK9TytKrx4aByH2GVt
l2OyVfR7eY4QhGYnYwznQQaozDAGVu6WMcp77b/OdGDZL+xjKIf6jkJBA7ieHneL
87T1Xo6oAt+57YM7VD3/n5Rwu/7w5G5r5ca9KX+gJ0XnUrAL8oZD1742PHw3fTTv
DZYhGtHqB33VeePMmLdu
=xCkV
-----END PGP SIGNATURE-----

--4SRTEifjNkXp0Rce--

--===============2587988200500102511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2587988200500102511==--
