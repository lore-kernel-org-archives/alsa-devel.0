From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 01/11] ASoC: core: missing set_fmt
 should not be complaint
Date: Thu, 8 Mar 2012 18:24:28 +0000
Message-ID: <20120308182427.GA3638@opensource.wolfsonmicro.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<1331225990-27308-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7301579757981544713=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B8A622415E
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 19:24:29 +0100 (CET)
In-Reply-To: <1331225990-27308-2-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============7301579757981544713==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="41bjdpi19TcwJlr2"
Content-Disposition: inline


--41bjdpi19TcwJlr2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 09, 2012 at 12:59:40AM +0800, Shawn Guo wrote:
> Not having a DAI link set_fmt operation is perfectly normal and
> should not be complaint.

Applied, thanks.  I'll wait for Timur's review on the rest before
applying.

--41bjdpi19TcwJlr2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWPlAAAoJEBus8iNuMP3dBJQP/i0WEsFr0O5ld0gf2/o4aJuJ
++wdAM7rK5FYDnZ28Xm6zydFrwMHZ/jd5sPSGQDqf4l9XKnMYMoGCIdu0yMFrlbm
dXGaiZF/kNVSO09l+llHjst4gOyCydSR4S0tZWCPQ7/AkggsKMlbe8Qyv7jDVD9y
F3E95OYa5S9ONzZN7+lxUZftXw79ImqXIrvhogHxIZsnfUKWpz8o6Wt98OCNNoFY
kGgzCcEzMWLd0ArW4nx0RmhQxizf6x3djUIQ3qGNcR7HH+aVCtnX+4UpC2ugdeOf
ARZLAv5Lhq9YaBGKECrw/84N1zfmCxZi9yz+UZSgCcU/WMdpR5FKIWvOAe/5rLLb
gLudNE9DU8umDyj2RWTVjKoDT3F3GLP1Un2irnVD2MGyvtaknEs8KgKm9FnQf0Lh
681oQfEuhinj615U3W4Cz9G3h/81Jb0ZZRaILnOszDQDTQOHE14lzFNmIxm6O9iV
VfuRMVzE+JNrv9qJTV/3augsuuc+/1KltTEWkQnnxmznsSS+j3oG3LATn/Xqcq6P
AKvhRmpHsSBRNSSIQt/z7OPFJfaU+SKwG6N2P+T1WdAw4QofRvBCXuH+r3elByAp
yfUEBE2L5uPIKTq+QWuu9quFdpqIosA6b59bYp4bwgHQNL69LkW3A1NuzGzIig/F
g/XmazDg/egCCJ3KlxUP
=LnIe
-----END PGP SIGNATURE-----

--41bjdpi19TcwJlr2--

--===============7301579757981544713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7301579757981544713==--
