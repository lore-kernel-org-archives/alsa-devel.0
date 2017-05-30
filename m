From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] gpiolib: remove unused variable 'i'
Date: Tue, 30 May 2017 12:02:44 +0100
Message-ID: <27b3397e-ab06-9e50-1b17-8127f9f72418@canonical.com>
References: <20170530094420.31076-1-colin.king@canonical.com>
 <20170530105811.xaoomponlr2rwn4i@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1394089593817759831=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A8013266A56
 for <alsa-devel@alsa-project.org>; Tue, 30 May 2017 13:02:47 +0200 (CEST)
In-Reply-To: <20170530105811.xaoomponlr2rwn4i@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-gpio@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1394089593817759831==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="45sS2E1AiDQiWoIcepKHNj1DKThIwrm9a"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--45sS2E1AiDQiWoIcepKHNj1DKThIwrm9a
Content-Type: multipart/mixed; boundary="noPbq7PdJl89N6ajbrTkAsCUcRMRHXIEi";
 protected-headers="v1"
From: Colin Ian King <colin.king@canonical.com>
To: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <27b3397e-ab06-9e50-1b17-8127f9f72418@canonical.com>
Subject: Re: [PATCH] gpiolib: remove unused variable 'i'
References: <20170530094420.31076-1-colin.king@canonical.com>
 <20170530105811.xaoomponlr2rwn4i@sirena.org.uk>
In-Reply-To: <20170530105811.xaoomponlr2rwn4i@sirena.org.uk>

--noPbq7PdJl89N6ajbrTkAsCUcRMRHXIEi
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 30/05/17 11:58, Mark Brown wrote:
> On Tue, May 30, 2017 at 10:44:20AM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Fixes smatch warning: unused variable 'i' [-Wunused-variable]
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  drivers/gpio/gpiolib.c                   | 2 --
>>  sound/soc/generic/audio-graph-scu-card.c | 2 +-
>>  2 files changed, 1 insertion(+), 3 deletions(-)
>=20
> You've got two unrelated patches in one here (as a quick review of your=

> CC list would probably have warned you...).
>=20
Oops, my bad. V2 resent.


--noPbq7PdJl89N6ajbrTkAsCUcRMRHXIEi--

--45sS2E1AiDQiWoIcepKHNj1DKThIwrm9a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQI2BAEBCAAgBQJZLVFUGRxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20ACgkQaMKH
38aoAiYgsQ/8DA2+Q42+K1DA0ky1rNUiCzcHyQPFinFgVhELj83HzRsKTA5GSfSh
BB7RZmaIV9I4SjxlUta3CPOBaiz58PVAmGK+Nl/stQ4XcGM20Vo1FGA6utf0p7mf
jpRk3oOMY7XqCFqfseiKXk1TYwmNME31xn8wE6i0Cy8wbgOkwWOdEPz4+nix8Mg5
aIT7BK2gQsxIdcaWPlxqS5sFVQSc0h73R+mngxAShlGTWDcCTDgMV1t1D2SMQNdN
3IFsKgwK7Dam3Jld4kukJSt7GUqM0NxMui64ZVeWrnUGyrPssDKyK4++gNKtGWEa
vLURIKHS/IzP/3L4Hy3B0s2We69vBRJ1a7WIM+8a4+SDRkrweXfqdbhG2v8lI4YO
gT6s40kTiJ4OYo2aPJIzRkDXxBdazQTQjUZbA2r/oZbWipDqYUvPi+b9Fj5Yoy2p
C6nkh3r1Vv9q3eXoYWdlL6fBKt0rd7z8GUTMy3x3w8Bv+L3ILiwlxMKjLtOBFVXm
vfVkj12EHRazBASeVLj1fPxUZzbm09wg20ljSenYrzyo18xtFcBxtAMGkvbWXcPf
2LtJK3Clw5cbckIzyYe/wvHjz6JuLHpr+0CsexAkE6Q8uKb3/33qCntLcM2WdmcB
EjAcILVp90ZLIR17NZXASR+aG4pUDmH2Cl6KBoaWkY2KjCA7TjM+hWU=
=2yOj
-----END PGP SIGNATURE-----

--45sS2E1AiDQiWoIcepKHNj1DKThIwrm9a--

--===============1394089593817759831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1394089593817759831==--
