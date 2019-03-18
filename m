From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5682: fix jack type detection
	issue
Date: Mon, 18 Mar 2019 12:04:04 +0000
Message-ID: <20190318120404.GE6221@sirena.org.uk>
References: <20190318071713.20080-1-shumingf@realtek.com>
 <20190318112701.GC6221@sirena.org.uk>
 <10317AB43303BA4884D7AF9C2EBCFF4002B5D5E8@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6451237339201879156=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F21BF80792
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2019 13:04:18 +0100 (CET)
In-Reply-To: <10317AB43303BA4884D7AF9C2EBCFF4002B5D5E8@RTITMBSVM07.realtek.com.tw>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "hou-hsun.lee@intel.com" <hou-hsun.lee@intel.com>, "hychao@google.com" <hychao@google.com>, "lijen@google.com" <lijen@google.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Albert Chen <albertchen@realtek.com>, Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>, "bard.liao@intel.com" <bard.liao@intel.com>, "Flove(HsinFu)" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============6451237339201879156==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h56sxpGKRmy85csR"
Content-Disposition: inline


--h56sxpGKRmy85csR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2019 at 11:33:01AM +0000, Shuming [=E8=8C=83=E6=9B=B8=E9=8A=
=98] wrote:
> Hi Mark,
>=20
> This patch based on "ASoC: rt5682: Check JD status when system resume" pa=
tch.
> But "ASoC: rt5682: Check JD status when system resume" patch doesn't appl=
y yet.

> Could you please check "ASoC: rt5682: Check JD status when system resume"=
 patch first ?
> https://patchwork.kernel.org/patch/10844139/

I have seen that, it's really hard to understand.  In any case, please
resend like I said in the mail.

--h56sxpGKRmy85csR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyPiTMACgkQJNaLcl1U
h9D3SAf9ETlKbhq8GTiVXIIDqRPCm776rN8HY12JsZ2bzfSYZHEDwCLXzAbGHpkf
8cN83yG8cBq1zjUNz38pE48EbC6xMwfojE54gBeZXNz/CRAMoL9bh682J5Lv8k08
nNcF9FGhIRISiiAAWpH++mNM7iukuelZNmVnBwyiD1JZbPq9YF8st0JB+qmjURXx
2ReV+fLk7T0IeN7mL0q8eVNEpI0/JexWm6h2SFwBrkpdAtZ/tFFDwqR915y4HFSJ
/cqkiCWKzePkteAJxltzygdEuF6FAG86PuIqapn0CqCvVJmmFnoacjFYBvoCE2Or
PP8U/xsNRRuhxS1mPKNTRr7BDVDKug==
=7wld
-----END PGP SIGNATURE-----

--h56sxpGKRmy85csR--

--===============6451237339201879156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6451237339201879156==--
