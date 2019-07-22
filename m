From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: rt1308: Convert headers to SPDX
Date: Mon, 22 Jul 2019 11:58:21 +0100
Message-ID: <20190722105821.GA4756@sirena.org.uk>
References: <20190719063302.18858-1-shumingf@realtek.com>
 <20190719164623.GA14800@sirena.org.uk>
 <10317AB43303BA4884D7AF9C2EBCFF4002BBE03D@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7902776512893919765=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C25DCF8015B
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 12:58:23 +0200 (CEST)
In-Reply-To: <10317AB43303BA4884D7AF9C2EBCFF4002BBE03D@RTITMBSVM07.realtek.com.tw>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>, "Flove(HsinFu)" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7902776512893919765==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline


--huq684BweRXVnRxX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 02:07:47AM +0000, Shuming [=E8=8C=83=E6=9B=B8=E9=8A=
=98] wrote:
> > On Fri, Jul 19, 2019 at 02:33:02PM +0800, shumingf@realtek.com wrote:

> > > @@ -1,12 +1,10 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > >  /*
> > >   * rt1308.c  --  RT1308 ALSA SoC amplifier component driver
> > >   *

> > Please convert the entire comment block to a C++ one so this looks more
> > intentional.

> I convert the comment like below.
> -// SPDX-License-Identifier: GPL-2.0
> +/* SPDX-License-Identifier: GPL-2.0 */

That's a C comment, not a C++ comment.  I'm saying convert the whole
block there to C++ rather than add one random line that's C++ next to
some C comments.

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl01lsoACgkQJNaLcl1U
h9AoiAf/auFYz4RjtbylZXfauNgPiXzsCzybUEt6/F3FPmXllUIEoyt0wrVwfSzF
ajReoiS/oo+FKuTIyTDhkqb2QkVyyBP9pYp5+JVHHj/By0YLCCafG4v0t7Gm+yP/
H+KvmNMms0uQdNmGKu8sYtcRTEyXFZhfsaKdGpDR6dgcppYE3Fx7PTDC4JX0uh3S
FX5igvVQ6YdHzDrbZkap4kIVAI+y1QP0P+lW4IR/KI5NPGJJlj5ToBrjQI6YJY09
gnXJrBfHOIyz0cbP9NMAlEgkekqwwwCtAIeGwJpS+O/yZqnUBvtkcn2VqnQa9Zx4
bt+vkavl8SMVmS5B2qGk0R+aYJQbww==
=J7vK
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--

--===============7902776512893919765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7902776512893919765==--
