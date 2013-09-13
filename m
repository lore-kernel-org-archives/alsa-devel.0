From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: 88pm860x: array overflow in
 snd_soc_put_volsw_2r_st()
Date: Fri, 13 Sep 2013 18:34:50 +0100
Message-ID: <20130913173450.GS29403@sirena.org.uk>
References: <20130913075248.GC19211@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tLoOelq4LT7wcLdm"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130913075248.GC19211@elgon.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Bill Pemberton <wfp5p@virginia.edu>, Lars-Peter Clausen <lars@metafoo.de>, Sachin Kamat <sachin.kamat@linaro.org>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--tLoOelq4LT7wcLdm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 13, 2013 at 10:52:49AM +0300, Dan Carpenter wrote:
> This is called from snd_ctl_elem_write() with user supplied data so we
> need to add some bounds checking.

Applied, thanks.

--tLoOelq4LT7wcLdm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSM0y3AAoJELSic+t+oim9k9UP/iRBTBjnd8CFrEaHaqa2EVSx
yn7pZ0mOFROyV2u+KAo+jsSfooBjeaHhbftFf8FNYX0d9S0kwu9qIVNgadzjdJDi
yvGoJJhRndUcx28yi82Y/G7XzCBGk/b5mcx52SKdu+n/SvTHgceKCqtfMfy21ltp
e/8UHmiS2vR6JUfFHqnrmcA6pdbG+i5p78WAHqk7ZrQrjsxUZ9OV59W4SVKmHkQQ
bNdFwiw6ADukqvaH4w6qNURjh/ldDdY0cLg3tlgyW2Kz4UuQKKfEVyhvEyKzOuqm
9b9pL5XacBU2t/E292EPhpil/I0jpbFh0xmuOVo6d2yyodaNCBfeyM+3OM0Can2X
MPvUFhneWdUb92UyU/CVkZyxdHUx3o9CM7Y79E6n8JphqoP8z+v1NTUUGHsoNXm9
DBlaAxGQEtuuWRcA5tT95k6Y/pPGSsrOmBsmTFfZz5LFzyJah5wfupbtgRzMVtJG
JWqOg6J7VzJ5hN7V17JdubYn9PjsV8/Mcauuk2DG21YimJAiRemFx5X06v+5BC6D
UyMrB57v448KczbxQvampgHMUaqUmwoXFV6q+uIcxul4cvtF935A5KHphzq51jd4
xfinYFkfK6BXumOtWUMdKEHBXXP2EHzJii7qsfSK/sfvv3zHPxSR9b6L4BYsrPC4
bByXkeKiqWeT65B0ue1p
=NSD5
-----END PGP SIGNATURE-----

--tLoOelq4LT7wcLdm--
