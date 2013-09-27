From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8993: drop regulator_bulk_free of
 devm_ allocated data
Date: Fri, 27 Sep 2013 10:48:38 +0100
Message-ID: <20130927094838.GX19304@sirena.org.uk>
References: <CAPgLHd8rbL2mmN+hFb-Jqvy+tu7wyTj702Z0fKNG_KOCW1kd1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8900799923150585543=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9269D265080
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 11:48:55 +0200 (CEST)
In-Reply-To: <CAPgLHd8rbL2mmN+hFb-Jqvy+tu7wyTj702Z0fKNG_KOCW1kd1Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, sachin.kamat@linaro.org, yongjun_wei@trendmicro.com.cn, wfp5p@virginia.edu
List-Id: alsa-devel@alsa-project.org


--===============8900799923150585543==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0btr6/5+bhBdui6J"
Content-Disposition: inline


--0btr6/5+bhBdui6J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2013 at 04:15:54PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> It's not necessary to free regulator consumers allocated with
> devm_regulator_bulk_get.

Applied, thanks.

--0btr6/5+bhBdui6J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSRVRzAAoJELSic+t+oim9fc0P/joFYFyoak9xJ+dblctMZRTo
gABE4l2BrFFRQNJRlyAnXdpdrsocjM1uFXvT0yMNb2iHYSJILBIxZA5pw9wHNl8m
vP+1yJuoR2hs1HoREPq89+b7VnEaI5jF2++9M85RxR0H1b5HlYErc646codrEuJJ
+2Ce9RZOIGXrpHiQK5EB+yq+LqQ5d6YtAw57UyZDfVXTFWWm2msr5ChlmYqhCsvx
NaGjFeu5h+mJ4EcCHIgJj6ffS8ZjExFuKxxsdycTUp0MINa1MKtEKNdTcsBRFZeV
WFZmZct//zT8fILfwWahvvBi0Lk7pOmXVw67W8w6aaWSnhRD6EueL3sIJvJQvMxE
DNJGjs0BGTs+FX0CXSrWQf5WlKiQsfSb4KkPsXCaQ675P4rNWnIBVOZw3CEfWXJB
sRFw6viFiM/9OdLBYKbGrF73dHGrEuSxfVtqWBTPNjuL/bncOjGEqzkVobrCW73m
Gy2JnM0bKipWdOuADcfBIK28zIJYB5+T1Uu/WSz4wdukBe8Ag8eTo4uYjclgcxRM
0iuLUp5sbe3X2nIv1aD1E9wjRsLlcMe7jvfuifzjWDYeNMqYrehcmZmo1IH/k6cR
rZmEZNc2ZRuySK3rmiZurcAlx2V/ilh3v8qn2ZLKuL2fx0WURRCIGLId10Zxczfo
vlZeZyYz42fybHx6Q7MT
=qBF0
-----END PGP SIGNATURE-----

--0btr6/5+bhBdui6J--

--===============8900799923150585543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8900799923150585543==--
