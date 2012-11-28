From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/14] ASoC: wm8350: Use
	devm_regulator_bulk_get
Date: Wed, 28 Nov 2012 17:38:59 +0000
Message-ID: <20121128173858.GT32691@opensource.wolfsonmicro.com>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
 <1353930587-12907-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5379565122051369306=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1741026172C
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 18:39:00 +0100 (CET)
In-Reply-To: <1353930587-12907-2-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============5379565122051369306==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v15hXiddb3kq3Bam"
Content-Disposition: inline


--v15hXiddb3kq3Bam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2012 at 05:19:34PM +0530, Sachin Kamat wrote:
> devm_regulator_bulk_get() is device managed and makes error
> handling and code cleanup simpler.

Applied, thanks, but *ALWAYS* CC maintainers on patches.

--v15hXiddb3kq3Bam
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQtkwpAAoJELSic+t+oim9HaQP/0XYJ7dUr5WzJVLu3c0hyKgv
Kw9OY7iFlOgd+PDJkpLfvdvdFRSLaCUmB2A9WwKBEXvgZetf0F85IFrw65qzE+EP
Me31JBNhNvDaPbKd5XdU1pRoNwA3XZWFyBnQB0TrV3M/jYPk4CYr60jgRPVZ0Tr9
axnDQMUwIOJltCNbZeO7CCdSINVdUGYUPqvt4L6fQNHklRcN7eOPqV8Wc7Qe91TM
Z13lwl7IiXKo6CatXpjsL6CKrXQpItSokR3j8d7Kvl0YZ7b3vjt89JCqV6jIIG0R
0RRJCXKBp2zGI+/H2dluKHDeSktM12j6OjfUqCGAt6GEmgWKMPS6Hm7wcHo/WA61
C/86MGp9Jcj2zKQahcNdEL4lMd6CHTUHbxkZjpgf7sZeTmtUIYZwqlx34DWcbBQG
vk9c5OXwXMD7X9UhtTBiGEmexNgg0Dx/v6chk1iSqWPY37+mWqoyvNRT9LP0F5jK
vz/MWZbs5Kq2reEetsubaWvM3BetI0YziP0vDKGMhDBlVE95NyVBkMeJxSW4TMYa
I7GrGVgt9BjVsY+Chcw2DimS5sJwvzzM9xPX1f9in25Pa611tU0oayXLoTsxmJIQ
+bdpCJdp6qbbLSEVDht073JWDgCTNVq18prNy1v+QSh9IXDeGErv6MXyY341Le09
+pmWD+jP77CN7C9JKx65
=gh6k
-----END PGP SIGNATURE-----

--v15hXiddb3kq3Bam--

--===============5379565122051369306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5379565122051369306==--
