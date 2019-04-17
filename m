From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt1308: Add RT1308 amplifier driver
Date: Wed, 17 Apr 2019 16:05:18 +0100
Message-ID: <20190417150518.GB5703@sirena.org.uk>
References: <20190416022246.10121-1-derek.fang@realtek.com>
 <20190416153510.GE4834@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B8280116192E@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9108283763397514483=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9DF4FF8071F
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2019 17:05:33 +0200 (CEST)
In-Reply-To: <BC6F7617C38F3E4E8CA887E07B35B8280116192E@RTITMBSVM07.realtek.com.tw>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Albert Chen <albertchen@realtek.com>, "bard.liao@intel.com" <bard.liao@intel.com>, Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>, "Flove(HsinFu)" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============9108283763397514483==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2019 at 11:40:28AM +0000, Derek [=E6=96=B9=E5=BE=B7=E7=BE=
=A9] wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> > The ones here with comments look an awful lot like they're system speci=
fic config
> > which should be left up to either platform data (or DT/ACPI configurati=
on) or
> > done at runtime (like gains).  Some of the others like the pads configu=
ration
> > might also fit into that.

> We don't open the DA gain setting for user at runtime, so have to set
> a default level in the init list.=20

That's not the way Linux drivers generally work...  is there some
technical reason for that or is it just some kind of policy decision?

> > > +static void rt1308_reset(struct regmap *regmap) {
> > > +	regmap_write(regmap, RT1308_RESET, 0); }
> >=20
> > If we do need the init list shouldn't we also do a reninit every time w=
e do a reset?

> The init list is only set at driver probe, not every time after resetting.

This is what I'm pointing out; if you don't restore these values then
why set them at all?

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly3QK0ACgkQJNaLcl1U
h9C7+wf/UfUp4n5zlF22r52NE8YVYZZOOo4jaKt/LfvYKWykZpdnbOkKv1Q/gSEJ
JgZFnIpCveuosIvws0Otr8Btw2jy0y8iKPRqJ4hb2eKIiUeFkWNdkQUdtYlBJRVV
XWFXVDSONrGhliQqzJ/JfoKiu6MKP89dZ6qgYsEiUeDu5lkj9uDlR0Toe3OpgIAh
kcJt6dBMuUHfgsnYUqAAqxKqo0CsqywooguWF4IX8mirGzebhAFgGbIK+8bgAQdM
6MA0noAEzNZ67OxT4iVqN0TMFvv4Qj/DKWGhI5Ggu0PQqK8MlhZaP6P6RBFIk+QO
kYmfrtxgIV7Z0LLg87hj8ef0cI6/UQ==
=tcM3
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--

--===============9108283763397514483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9108283763397514483==--
