From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: defer the probe if clock
	is not found
Date: Mon, 15 Jul 2013 18:13:44 +0100
Message-ID: <20130715171344.GX11538@sirena.org.uk>
References: <1373900110-19929-1-git-send-email-shawn.guo@linaro.org>
 <20130715161250.GR11538@sirena.org.uk>
 <20130715161941.GD23589@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2248653207175823504=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C8F27261A3D
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 19:13:46 +0200 (CEST)
In-Reply-To: <20130715161941.GD23589@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2248653207175823504==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dZJOqldIUwtPuZvk"
Content-Disposition: inline


--dZJOqldIUwtPuZvk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 16, 2013 at 12:19:43AM +0800, Shawn Guo wrote:
> On Mon, Jul 15, 2013 at 05:12:50PM +0100, Mark Brown wrote:

> > My previous comments about this being better handled in the clock core
> > appear to have been ignored and...

> I'm not really fond of fixing a regression for -rc with involving clock
> core change.  I think we can do that when that becomes a really common
> pattern.

It's already a common pattern (or should be anyway) - look at all the
drivers that fail if they can't get a clock...

--dZJOqldIUwtPuZvk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5C3FAAoJELSic+t+oim9NLwP/1Zg75QBZdOUBwGtW+T2o9I7
s/+5XuDN0i48PBU7t39UVS9WmT0PgaecIOXCDIpqajHGqo/82v5ksUuuYsaCnBhB
iwe7P9uap+fvMmClpCqTPBgfZv/5kmYQ3It8UsZ47joJhWW+O4xVT97oomaSeJuA
gsKJ8nQ6i9HjZJ/+JceklWV7BzqXrmslxeWRW+IFUGRQeGWSj040cFOAzYJEWET8
PuV0YYFbGgpMGCiFzxOLX4eJdKLpSIif5bRBjb+1H4jDYmlx6SSDoxsBa/JES43+
4zttOItO8uc7A2HMVg+Ya6tVt9GnbcmIUZzEkJbCTzfeT3/f0x9OVq/lqbwtjjfQ
A9C8OfG1+VRW2lGbzK4AZQfpfmePyT/IhgojWve4a+P7O94WwCeJ7ElZH8o9SqGT
hT79ZK/KNEiMxxiDwuvYR8vSwZax/jItxZBtpUF2dFmTn61a3hu+iT7YAMP8C1HG
oJleycWnipxZh6JPCCgdJajp08F2UgJ4fNWWZCQpwg2lbfjXUYlM4MUrl0Prl1kB
buOuSQ0zMv1iAOxDY+MuEaK6TqINIIbyv9xhHgl/Mc3EleZuwvL39XduLhE3Pqc0
WCWktQXFAKu9EiS7NKQ7xtQWAfi/WB73FVO8ctLj7YziYu1+S56foUoL1uZ1sOXg
rPUF//ZlqcTEu/oRxvSs
=F7GC
-----END PGP SIGNATURE-----

--dZJOqldIUwtPuZvk--

--===============2248653207175823504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2248653207175823504==--
