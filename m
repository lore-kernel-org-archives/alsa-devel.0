From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel][PATCH] ASoC: wm8960: Add shared_lrclk and capless
 to device tree
Date: Wed, 19 Nov 2014 17:48:09 +0000
Message-ID: <20141119174809.GG22111@sirena.org.uk>
References: <1416400568-7512-1-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mOKeRhn3B7HglGBY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416400568-7512-1-git-send-email-b50113@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <b50113@freescale.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, lars@metafoo.de, ckeepax@opensource.wolfsonmicro.com, Li.Xiubo@freescale.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--mOKeRhn3B7HglGBY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2014 at 08:36:08PM +0800, Zidan Wang wrote:
> wm8960 codec has a wm8960_data struct which has two fields shared_lrclk and capless.

Please ensure your changelog is wrapped within 80 columns.

> ---
>  sound/soc/codecs/wm8960.c | 49 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 18 deletions(-)

Any DT bindings need to have a bindings document as well.

--mOKeRhn3B7HglGBY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUbNfYAAoJECTWi3JdVIfQAFAH/j1+xp3C53PkHBtbW6117jkN
uP5Q8aD/vq89dq7bqEIUhVeBAyiqYiZAhT5j07KQB1ITHGNOOZcVUjLSDmtT1wEE
GeOi5j88LDbNoiJh51X0DY4iaoWlvPJaxK0T/myKrlVrM80puj6JxQiYUnnqAJSd
Y5/CXbYuasMLfQy9/9y/lIBg7MV2owcSrea0j/d3LFFTJtI4VzAjiNeVF7AJ62RO
hT0KT8EgtORT3pOUI/3wchF5rpHejW81+XCUgzjosEtM3v2OTQTCL59eViTZQZ+R
Cb9T8DIaENwQi7PvyTils/WqMZHYftOlF+yBr89Yz04ffBs2Dcu7WhEMHbEfdEE=
=uRTk
-----END PGP SIGNATURE-----

--mOKeRhn3B7HglGBY--
