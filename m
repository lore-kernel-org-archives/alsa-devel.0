From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/9] Update FLL calculations on Arizona
	devices
Date: Sun, 9 Mar 2014 08:28:32 +0000
Message-ID: <20140309082832.GP28112@sirena.org.uk>
References: <1394210065-23941-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7744729677184646238=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D33E5265545
 for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2014 09:28:41 +0100 (CET)
In-Reply-To: <1394210065-23941-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============7744729677184646238==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XDjvnsv+LUV9J1kR"
Content-Disposition: inline


--XDjvnsv+LUV9J1kR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 07, 2014 at 04:34:16PM +0000, Charles Keepax wrote:
> Newer versions of the Arizona IP have several differences
> in the FLL configuration. The reference and synchroniser
> paths have slightly difference FRATIO encodings and the
> expanded encoding on the reference path should be used to
> avoid integer mode operation.

Applied all, thanks.

--XDjvnsv+LUV9J1kR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHCYtAAoJELSic+t+oim9yagP/2OghcN537qg3pDSS9ON6/tA
v2Xp4wk28MYXR1Kpw/ukDMxVnpT0wssawdH/O64qt+pvZKbrj5lTALQihsn5IrzG
w9TNsWSHbzNmVjbvOscWcTQvMdtcULpgwfq5kqouERQArVrYJ9uX8JkhO40iv+68
NgfXo6JFD2uWMC/X0jjCI9myeIMKADeJHCSPJTna/teaZJswSNkp5SzAp/LqMj36
u849zpkPwWcP+a1/wFYw27AlovorY1S35/4DbetU2Of8oow+8dIV6k/3FwDuK7Tz
gjzBxFe7qWSf0hzoUr0ueMZpI0MUOII/i7Lho5CfhHg3I9tkPSmV2YSziBHkqPpN
eGKgCzmbwnMNhVGezdv+GJBS5nc/sdl9pilEAGWc069bxayDNnC4iZ0lK5fMoOtf
wYAfVAQwc55nyMnbMfmh3hFYXi7YbajO5oCgfZ052uVh1+GoMd1PxMhT7jd7WiYA
0gBXQTXEr8mqUxlxw8VZhrpfRkgHogMUR2uRA3zaI9xACaYgp8taHDzz04w8YDtV
DL+XxlKiRKruXRLx1P8hmuWhM5Fb5jODRLehYrqniK9jkuwUbiIgroQk/3u4HIKg
jAGZnaJKI7Fskd8gXU2Q0tHSWq1NHuuhnYfd/9t/LUfTxT5o1wIKdq0Keq+KWuzA
wPVHWKx4/NSfvXexcd81
=JqrR
-----END PGP SIGNATURE-----

--XDjvnsv+LUV9J1kR--

--===============7744729677184646238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7744729677184646238==--
