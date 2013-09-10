From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: da9055: Update driver name
 to fix breakage due to pmic driver with same name
Date: Tue, 10 Sep 2013 18:07:24 +0100
Message-ID: <20130910170724.GU29403@sirena.org.uk>
References: <1377778108.15438.6.camel@matrix>
 <2E89032DDAA8B9408CB92943514A033751E611AF@SW-EX-MBX01.diasemi.com>
 <20130902103843.GL3084@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E612F5@SW-EX-MBX01.diasemi.com>
 <20130902174121.GV3084@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E6157D@SW-EX-MBX01.diasemi.com>
 <20130904183405.GX3084@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E61991@SW-EX-MBX01.diasemi.com>
 <20130909112643.GX29403@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E630F5@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4005137182016041055=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F2A5261A18
 for <alsa-devel@alsa-project.org>; Tue, 10 Sep 2013 19:07:28 +0200 (CEST)
In-Reply-To: <2E89032DDAA8B9408CB92943514A033751E630F5@SW-EX-MBX01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, "kiran.padwal" <kiran.padwal@kpitcummins.com>, David Dajun Chen <david.chen@diasemi.com>, Ashish Chavan <ashish.chavan@kpitcummins.com>, lrg <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4005137182016041055==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yWPvFVzSs/idg2A5"
Content-Disposition: inline


--yWPvFVzSs/idg2A5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 10, 2013 at 01:05:54PM +0000, Opensource [Adam Thomson] wrote:

> Your suggestion is to move initialisation of the Codec to the MFD core of the
> PMIC driver which to me is unnecessary and limiting and is something I cannot
> agree with. Basically we're at a bit of an impasse here...

What limitations do you see?  I don't see any substantial issues and you
haven't mentioned any.

--yWPvFVzSs/idg2A5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSL1HJAAoJELSic+t+oim96MYP/1SDPXgy/uJfNa4papGUYx9M
UFqC/yKk+P+gjoOmxZrHWLVEUKuws78oBUeH+6MPVGM/nUYMsfdygKAKsciETxR7
hsHp7G9JZ9cBR/6NG4utWsDWNdIcI8w3Ce2KYZV4tK0YodvzUMqGNM9JlLsF9f/V
uwzn5bWwSHFN/FMSpgd/P9qrsEM3wIEGMWvy5YOWf5+QAgwBDbm2DwO2QgqlZm7D
Cqh6TkwhtiJ8MurxtJVA+iRHhiNjjpshjPmyjtYuCDXTfzoR+e9FPNNWvK/0ykPD
Lui6KoRbTjErRqknmfmR14bk/ptjNqbZiGIYl/4YpUvHrfyNva269rnsaCNyUYBR
+7YJSViRldO5NDp5upmTv1mrulAw/v2RXy0CdDWSMqolAo5Fuz38MwPAm1GDvPjC
Y84iwNLVVkvo1qgklkggCs+MJjpAc4TFB6714eW6Jvj4Ou0Dj0RnVEcU/5ltyZ9p
WIuUi81z6RPP0o88H6iSc9tcQIvMhB/d8iOC31SmDh1zgQ6Ptw+uwQ5HL0u4/iii
h/ZRXqUueJKay8mOAlpdMpWTByfv2FLQks2gkuoms/2l8oS7Ct4zO0YV7oYzMVrp
pUAiwQac/dMiDqVVNoaN00X7cdJnuLhuL8iIKHIbXUsYCdzsZcopJEF4lV/o7lFm
LJm3ihch6Ze2Xvpc/hrQ
=99fh
-----END PGP SIGNATURE-----

--yWPvFVzSs/idg2A5--

--===============4005137182016041055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4005137182016041055==--
