From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: samsung: Fix non-DT use of I2S
 controller
Date: Mon, 8 Dec 2014 12:12:00 +0000
Message-ID: <20141208121200.GV11764@sirena.org.uk>
References: <1417809427-5126-1-git-send-email-broonie@kernel.org>
 <CAAgF-Bfv5OaDYu2Ti=9CCoZ9k-1ZhOG-KRfgXJYanKpLWp9ffQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1103929920264066152=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C13E426042E
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 13:12:17 +0100 (CET)
In-Reply-To: <CAAgF-Bfv5OaDYu2Ti=9CCoZ9k-1ZhOG-KRfgXJYanKpLWp9ffQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Padma Venkat <padma.kvr@gmail.com>
Cc: alsa-devel@alsa-project.org, Padmavathi Venna <padma.v@samsung.com>
List-Id: alsa-devel@alsa-project.org


--===============1103929920264066152==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MUnXZt0Uv08c1hBe"
Content-Disposition: inline


--MUnXZt0Uv08c1hBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 08, 2014 at 10:21:52AM +0530, Padma Venkat wrote:
> On 12/6/14, Mark Brown <broonie@kernel.org> wrote:

> > +	}, {
> > +		.name		= "samsung-i2sv4",
> > +		.driver_data	= (kernel_ulong_t)&i2sv5_dai_type_i2s1,

> I think here you need to use i2sv5_dai_type because
> i2sv5_dai_type_i2s1 is introduced for exynos7 on which the i2s1 is of
> type v5 but with slightly modified bit offsets.

OK, though I presume that's wrong too (otherwise it should be v4).

--MUnXZt0Uv08c1hBe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUhZWPAAoJECTWi3JdVIfQC00H/j2lpM97zqgwFUPPSqwerSow
K9TJr+wljyUN2JUbiT94IEuLOyg+/7QwqZdSGLbV5c9M28QPvPCLzmxxMj6hEfmF
L1dZb+NuD6mFDKUrKSlqsXbnCFxZd+42VzPcc89BUuotL+HAkInrxmO0F93DUdjq
9Hm1nBCOetaH3WqFMHBt65w9lRuSQYbhrSdVCLeGEaHQyTmcr7izf++MGV3qrKS1
CHZYvgb7cE2OjMKotD1QMryCD7OLPMvR9lg7G0ItyCgDi6mUuEFgXqT66uf7jDU7
bzoU72qSlqTm7oXma0uM+6wwKql6SIEPmbq+VIwhXSvELR25hVNol79XV1lLOCc=
=Xn6p
-----END PGP SIGNATURE-----

--MUnXZt0Uv08c1hBe--

--===============1103929920264066152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1103929920264066152==--
