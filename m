From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: fsl_sai: Use usleep_range() instead of msleep()
Date: Fri, 22 Jan 2016 16:48:23 +0000
Message-ID: <20160122164823.GB6588@sirena.org.uk>
References: <1452857725-32414-1-git-send-email-lixiubo@cmss.chinamobile.com>
 <1452857725-32414-2-git-send-email-lixiubo@cmss.chinamobile.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RlE8T3bLnVJqgX61"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452857725-32414-2-git-send-email-lixiubo@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <lixiubo@cmss.chinamobile.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--RlE8T3bLnVJqgX61
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 15, 2016 at 07:35:24PM +0800, Xiubo Li wrote:
> Since msleep() will sleep longer than intended time for values less
> than 20ms, this patch allows the use of usleep_range for just 1ms.
> usleep_range is a finer precision implementation of msleep and is
> designed to be a drop-in replacement for udelay where a precise
> sleep/busy-wait is unnecessary.

A similar change seems to have already been applied.

--RlE8T3bLnVJqgX61
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWol1XAAoJECTWi3JdVIfQR4YH/1/nKA7BG1nrJbdWd169UqaC
nTvpRPOZ0+ajg07RR+Ytlyc3TDh5Lrc5ljEOhcx0wznyCYOGe1GB5vJPm+CO7VWd
koBSUSymk4kl7joU0B6DJdtscK8RWh0jJkptyPzvfqGjL4GoGtmph4tvrI34S4nS
daelHniKtRe5HcuU1DU1V2LxEABqyUjlPGEn3xnYDJUUuoYp4+aNxSEwKf/+VWE1
qXau8Bmwdm47wc3bQdMiQLhmwz/eDKCBJeLudFfIkX+ge3OJ/sYK48rQRE1bGwHi
AIB4mDX5yMLfE3f3rd9+os20EntPLotzDpEF6/k7phW55jDy9x+OAJlrMavTNI8=
=Z+fW
-----END PGP SIGNATURE-----

--RlE8T3bLnVJqgX61--
