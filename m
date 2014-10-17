From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: fix warnings when kernel
 compiled without GPIOLIB support
Date: Fri, 17 Oct 2014 11:48:38 +0200
Message-ID: <20141017094838.GA1820@sirena.org.uk>
References: <1413477658-35049-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7529925911025117741=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7350E260439
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 12:17:42 +0200 (CEST)
In-Reply-To: <1413477658-35049-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7529925911025117741==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2014 at 09:40:58AM -0700, Anatol Pomozov wrote:
> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>

Applied, with a fixed subject - this isn't just a warning, it's a build
failure.

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUQOXyAAoJECTWi3JdVIfQnVkH/ikLPPbGc+YiGEVZZpg0pO45
E4TJbOU0L2olXfauxtIhZ7Xt9unURMNlZKat010BcS5ufjjQfhfMxsxNt37lOldH
TYEkigNImB+rBTsRAZS4+dBFvyyrEOnFZR28cRAZcAWxmeVZ7zf8OhiDVumzoJ7k
BvbPzUeesM7Dz/+7dvXw2WMuwobK8G4VTC1D/otp7tYJvIQWkah+VG8FeTXF5VnR
G1XI/PWqU/eOzA++fmIym/AlyqYflneAPk4Hav+GUniNfN9lptya0RoV+A38EMo5
wCPwFVNUdXSTIwd6+WSBDNLHZLHtB2y0qd1grIQeTqmkzrrrNjiBbeREmwpE22Q=
=9QDM
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

--===============7529925911025117741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7529925911025117741==--
