From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 20/21] ASoC: codecs: Enable AB8500 CODEC
	for Device Tree
Date: Thu, 26 Jul 2012 16:24:42 +0100
Message-ID: <20120726152442.GR3099@opensource.wolfsonmicro.com>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-21-git-send-email-lee.jones@linaro.org>
 <20120726115055.GD3099@opensource.wolfsonmicro.com>
 <501150E5.6010503@linaro.org>
 <20120726144336.GL3099@opensource.wolfsonmicro.com>
 <50116005.6050008@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4938778358576265718=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BF0D0265EF9
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 17:24:41 +0200 (CEST)
In-Reply-To: <50116005.6050008@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, sameo@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, linus.walleij@stericsson.com
List-Id: alsa-devel@alsa-project.org


--===============4938778358576265718==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zOr5JpMIiGv/Oaxu"
Content-Disposition: inline


--zOr5JpMIiGv/Oaxu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 26, 2012 at 04:19:33PM +0100, Lee Jones wrote:

> Okay, so your suggestion is to strip out all of the sub-devices
> under the AB8500. It's doable, but will take some restructuring and
> thinking about. This is a job for another day. I think it's okay to
> continue with the current semantics for the time-being. The line
> we're discussing does need to be split out though. I didn't mean to
> merge it in with the ASoC stuff.

Yes, well any that aren't reusable at any rate.  If you could relocate
the device into another SoC integation that'd be different.

--zOr5JpMIiGv/Oaxu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQEWEvAAoJEBus8iNuMP3dc7gP/3X+R0n3oHn9a5jis3fUJN6Z
bKkOnPzGVc5UmEgUMgX/YhiUQkxyKS704sT6PogZXURXJA/u8g1EBW2uFdidBLkd
VdCd746SqeCIvZQhC9aFv5Pe7GlzP3u4JWpk4zKzXHghMmYkMGcnoO+rJ+4zvfwA
DgG5iL/2mRlqWSc7SZI2CKZRR0/AkpSvqCQrmM8GnjuqXhi7Bm2XoPz6H1rXiHyx
yafxTEJ7Akq/kny/hm0hFEz7Kq342kcxha9Ge572fjYZaHWfIx0cLWZw6rjWSy44
szQ/O7RNbEUoBWiQfpzD2jNMLQraRgLZpjH6Zd8BiX2NbQRAVTKO8xIVNx733Hz+
YlyfUSGVIjZ0BxIfFWmw9c5TXoA9b+kL0J2hQ6dQEvLBP4l8es1grU4bXZol7m9P
6qVQpw6F2pjvezFGT76prATyicW0+edNKKdg6gKYYh7o01NMVykRnK0AIhGc3kOh
dPeJQ6qxLDWp5YYRFGTKL/9F3foTAU5UhyXNlEbe/gOFqoX2YmyxS6iHgFIvG2PL
4Bb8DVWDkuqDKZm4uT5ueZ6RqWPgzAPdiwDmJxf+X4ng9kx1SlepVdCxa/yaGl18
sI5rCm1Vwj9fIrXENq0o0lnYT1lZBeQXtueNk+xq9UDOMTtqczvPTh+duNzatdJK
KJ90WDMhi1xErUvWF0Uh
=V/FS
-----END PGP SIGNATURE-----

--zOr5JpMIiGv/Oaxu--

--===============4938778358576265718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4938778358576265718==--
