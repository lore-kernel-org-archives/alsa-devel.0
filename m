From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: sgtl5000: clean up
	sgtl5000_enable_regulators()
Date: Tue, 17 Dec 2013 11:37:05 +0000
Message-ID: <20131217113705.GP3185@sirena.org.uk>
References: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
 <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
 <00a7a941be434caf829f9fd246879c6d@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131213125129.GV18380@S2101-09.ap.freescale.net>
 <892cbb07bd064f44b2af45f106aeb479@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131216112910.GB30671@S2101-09.ap.freescale.net>
 <20131217015939.GM3185@sirena.org.uk>
 <20131217021610.GA7172@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1501886250100982860=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 11E3926087E
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 12:37:11 +0100 (CET)
In-Reply-To: <20131217021610.GA7172@S2101-09.ap.freescale.net>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============1501886250100982860==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A7rymFNmjC2ggD58"
Content-Disposition: inline


--A7rymFNmjC2ggD58
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 17, 2013 at 10:16:13AM +0800, Shawn Guo wrote:
> On Tue, Dec 17, 2013 at 01:59:39AM +0000, Mark Brown wrote:

> > It's something that the platform needs to address - the core has no way
> > of figuring out what devices might register in future if the platform
> > doesn't tell them.

> Okay.  But is there an established means for platform to tell that?

That's what has_full_constraints() is for.

--A7rymFNmjC2ggD58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsDdeAAoJELSic+t+oim9XCoP+gKLP5BxkBfKCfsp9M4NQGGa
2BG3N1ecD5kzXtdHjJIA74F6SPz5YNFqfU+oZNeWbA2cLdMXy+e5DH7hzB2G5cAP
BfFPvO8fw5zOYWGLh+8abTKqfqAgKRTvEkmCq0QFQ6VDWFMa+/tuPzSZdKq5s9TA
dpDur+k8YJZ3HzcjzqKw+NFxDgZKK6hBIkMdjVFP7WXHhXbRfKDhdlZnVN1fbicr
oLn4UxlU4gLy53z+Aigm0lKLq8/S6vspo9GTnFbqbK5i0XZHz2lYdJrDH/bECQEi
eKTRk0+iY2xSO5T/rzNxMQlthfj/vJ3HB14e6BJ4yh8o7m0jhvHZzI/3bEuWwioC
Ym73Z+LGDYWcMrkgE1Qx7jRaK1X2QYdfwOnuvik/kYsloMu+JHfL9Y6E4Q6FPpJ8
iokxg9uKVXx5kyCSWKSEt+Blbs7uIkO75al0ZNgQX2c41Y/9V6GiWOu718f4DKTm
zyLetOPbx80vyTAJqqAK6jz+P+BozVhWc1sBnsC3iMZnZ8C98AVU3A4npm72VVpc
XNUtlrnEEyP9wnOTrZbgwbwEdj+SyNeTnTaAxkA/Eg+DVDKB1pAhT+X9IlS/Pk1H
cqOn7TPUhGobscRcu0MwGnVrx2OfQj4HlAO81dmQXXSiYWJbmfSHnlGEZIbkOwLZ
iMkxj1tfjC4ZsS+v5a/v
=FJOD
-----END PGP SIGNATURE-----

--A7rymFNmjC2ggD58--

--===============1501886250100982860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1501886250100982860==--
