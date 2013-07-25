From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: usp-pcm: add CPU DAI driver for
 PCM simulated from USP
Date: Thu, 25 Jul 2013 11:24:53 +0100
Message-ID: <20130725102453.GZ9858@sirena.org.uk>
References: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
 <1374232042-26088-4-git-send-email-Baohua.Song@csr.com>
 <20130719181313.GT9858@sirena.org.uk>
 <CAGsJ_4xNdxFWyN6NUEL36W9n+4Cj=01+QGi+xaeODm9u8pdP9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5004329116008014452=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 37FF0260783
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 12:24:56 +0200 (CEST)
In-Reply-To: <CAGsJ_4xNdxFWyN6NUEL36W9n+4Cj=01+QGi+xaeODm9u8pdP9A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Workgroup.Linux@csr.com, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5004329116008014452==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0w3sVzSwLDVzzp/e"
Content-Disposition: inline


--0w3sVzSwLDVzzp/e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2013 at 05:32:12PM +0800, Barry Song wrote:
> 2013/7/20 Mark Brown <broonie@kernel.org>:

> > Also what exactly is the rate being set - can the driver just figure
> > this out automatically from the sample rate?

> here it is generating the right pcm clock by an internal DIVISOR in USP m=
odule.

> For USP_MODE2:
> 30:21 (R/W) USP_CLK_DIVISOR 10=E2=80=99h0 USP serial clock divider

> For USP_TX_FRAME_CTRL:
> 31:30 (R/W) USP_CLK_DIVISOR 2=E2=80=99h0 This is the two bit [11:10] of
> USP_CLK_DIVISOR in USP_MODE2

> for figuring this out automatically from the sample rate, do you mean
> a lookup table for common sample rate?

That or just calculating it - if you know the input rate and know the
output rate you need then for a simple divisor it should be possible to
calculate the required value.

--0w3sVzSwLDVzzp/e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR8PzxAAoJELSic+t+oim9H0oQAJtoLPxFDBNRGzuqpmPn2lO8
lSeMZj5N/qWYXwexS9vHvehefgTtMe14lgwOLf2OQpu3UI7Qy5My35/NtIOKGXXj
NCOBwOBR+3YpwCn7vu3BzNAo1UZOQorU0ZstcJK7uHt9ufuJ9ysRCtJsnb5fZRsy
YojM9A8a8JcSZKlU2qefg06ALkss2mTwOvthyjQBK8sFmFkVGd6nAA5ZDusKefHV
uOV/ZyBzgonwBUANpCbIho9CuFzF/iUvFoNQgyUNp8ePlUdrG20+50iMKVC7TEhm
uwC6c4BfcjIPDdVkcPXM9hOX9w7gSvQRUc9GOeeVk+AOwqEhtdFvl1jtX+UVpiHE
iJderTKia4Xv97N8/AcCGV4BbNmmU5lhGIZ94r6Eq/J2RE2fGaMCN0sCduxJfnVS
7NkqVFktDAc+ByIWpUlJyi8NNxFO4kfo2MUgak6njla68FXCRSD9TvgrAeoMcN4Q
IVGaOhBlizb6zBdfP0gmieHKqlmsNQJiErpvidU/rNzBKOwFhSTE58043QkoAQYf
05EXNgwkingfRYI9epHBTxj5EDxKrNK2n1o9XHBbO4QkgImI0lhCpOyV8WC9mGW5
xcEoXE105fz1p8xoicLzgeq86xOiCMLCdYMkiHkDA9wGL/YJcGTNh0fl4zzbkn8B
PyhS9AE/Vt2dNEDLUUqJ
=e/jK
-----END PGP SIGNATURE-----

--0w3sVzSwLDVzzp/e--

--===============5004329116008014452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5004329116008014452==--
