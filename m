From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: max98095: Convert to direct
 regmap API usage
Date: Tue, 24 Sep 2013 11:13:30 +0100
Message-ID: <20130924101329.GS21013@sirena.org.uk>
References: <1379959813-22993-1-git-send-email-broonie@kernel.org>
 <1379959813-22993-3-git-send-email-broonie@kernel.org>
 <CAEUnVG57r+9aAEZey5b8VytsOEpNhdqWR-Q7K9i8nfox4y03mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8020716722428120992=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E0EC32617AE
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2013 12:48:59 +0200 (CEST)
In-Reply-To: <CAEUnVG57r+9aAEZey5b8VytsOEpNhdqWR-Q7K9i8nfox4y03mQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: Peter Hsiang <peter.hsiang@maxim-ic.com>, alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8020716722428120992==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GZcHWaa9CKmuhJmS"
Content-Disposition: inline


--GZcHWaa9CKmuhJmS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2013 at 07:56:53PM -0700, Dylan Reid wrote:

Please remember to delete unneeded context from e-mails, it makes it
much easier to find any new content you've added.

> > +
> > +       .reg_defaults =3D max98095_reg_def,
> > +       .num_reg_defaults =3D ARRAY_SIZE(max98095_reg_def),
> > +       .max_register =3D M98095_0FF_REV_ID,
>=20
> is
> .cache_type =3D REGCACHE_RBTREE,
> needed here?
> I had to add it but only had an old 3.8 to test with.

Yes.

--GZcHWaa9CKmuhJmS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSQWXGAAoJELSic+t+oim9NzYQAIr95tOBDHv0l5WMGf/VF2Wd
1cCEQ2Y7T9SPsVu+yEf7iI3G14KPWTM6zcKGhblGHvqxuaTqr73tzpxWdumgC7HW
7eKzAwvVHkQzeplXRr1hJKdfH4alKXLo4R4473qRZer2mU6UeyAH/UH598QKea5r
RibWghOj4Hhu0POHVtvXK13Ouy7bpLvtd63Vd8HSIaEsIPJE0ZXoFAOvC1S3j54R
L4Mll24Uyp5XMqOtlwqdhBpC/GGEWdPIXUCvkV9JPAqOKERQIPXZdJY8YhnY1H7m
GDtWL7Vps3Me3qxyA0aIVQ/g7Ke98EJETDArL5Xw/u9p3ZMAsSx/InIpSBA0VBBQ
JV6JvUgUbJaJFuUQ8axbd9Qa8A5HYrDNxEvquPnUlUM3fhJ0ciNEKmlSkx8BIRIl
j8/bxtzVBQgh07LWPtbEjDP4MAhThJ733NJnSDZdOaAfBoK7leqSBkmrf7qdNb9W
SgjDAzlTQnRDf/ge7LhQ0rWoDs5YCtkG8caXWI9mC+3DTw+S+0X4FtiXOWPpoM+B
4MLFgMY0+5Gvcv5hwPwznaVBLlpihqPkZPq4F6n1E6I7Dxpd/Axk1mcliY8P9iM7
2yVZInDSiUH7aAM4wCd789GimLeYtll1Dutp5kR8kbr6GiKMaEGZzFKQjlyt0SHT
m2o+SMlE/h5tiO56Zj85
=U6SG
-----END PGP SIGNATURE-----

--GZcHWaa9CKmuhJmS--

--===============8020716722428120992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8020716722428120992==--
