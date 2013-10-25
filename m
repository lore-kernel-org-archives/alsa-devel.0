From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND v2 2/4] ASoC: cs42l52: increase
 MAX_REGISTER for regmap_register_patch
Date: Fri, 25 Oct 2013 21:22:12 +0100
Message-ID: <20131025202212.GW2443@sirena.org.uk>
References: <1382713277-10306-1-git-send-email-brian.austin@cirrus.com>
 <1382713277-10306-3-git-send-email-brian.austin@cirrus.com>
 <20131025153736.GA26122@sirena.org.uk>
 <alpine.DEB.2.10.1310251244140.11514@heelrod.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1389303416068637788=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B18C22616E9
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 22:22:14 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.10.1310251244140.11514@heelrod.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1389303416068637788==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6xt4iF4AXd+9lYde"
Content-Disposition: inline


--6xt4iF4AXd+9lYde
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 25, 2013 at 12:49:50PM -0500, Brian Austin wrote:

> 		ret = _regmap_write(map, regs[i].reg, regs[i].def);
> 		if (ret != 0) {

That's it, yes...  it's due to writeable_register() enforcing the
max_register check.  Hrm, having looked again I'm not seeing a quick and
obvious solution to this so I'll go ahead and apply your patch though we
should fix things so that it's not needed.

> But it does not seem to apply later.
> I believe that if I call regcache_cache_bypass it might work.

If it does that's odd, the patch application is done with bypass enabled
so it should have no effect.

--6xt4iF4AXd+9lYde
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSatLxAAoJELSic+t+oim9tHAP/i0Z6DjcEt4wXOkDQYOfT6Au
hxFOK4T0QRpP82+0raoIrmY2PE0jRGs1yakXBQtOlIXOheCGcBhjeUhjlQhPfjcq
F2cYRMo8heVY6hy6GvrrrixO2z++1J6UoIcqyX7pUlASXiWJ3K317KT723eSYq+A
huMaxmYoOcUgIhke2HFPKAB2rn49fD39wNLJSxH+jKT1cxxdfBBjfsEalKt7wZ9K
vuv/C1UKRt865KwQuOmlfSPp9VhTHi7iZS8+pJpzvn+geCTdu3SPCo2r9yAffCjc
529hjIH9Vmfe4V6RKDPuhi+wgjJ1TM8xXubJtxCFVyjZvLgtWwRvHbpsJAlrMII5
C4wIOk8UmtkXtYXJYFiqJTA9wjglUaGRF4ji6+5T2TSMEhD77n18ek+ttQAc5S3J
bX4QAsTsC+FCMxu5jdOy8uzqWa1MSXtehltzTfLrb2SDB8xmecZn+o86jPn94Hmq
YNjyEdrORxGx4H/5ydw04JlF8bHM8KbJ3siCEo8Ow7fA3CBjuxhhM6HkEsUXOLH2
m3M5hb/tZuyHXkCIJSz52RJevlu4RD7KxYqSGXf/oje8S73C2SlkG/TyuLOMGN+i
ANNGWdzl0L6Cga61t/+YqW6o1XZIxnLy5xNubkVtC43ssqztdqGDgEw+wMkWLdhb
IHHPZf40m6Np2QRHLmLb
=cb62
-----END PGP SIGNATURE-----

--6xt4iF4AXd+9lYde--

--===============1389303416068637788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1389303416068637788==--
