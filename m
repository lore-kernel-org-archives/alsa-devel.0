From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 1/5] ASoC: core: Add initial support for
	DAI multicodec
Date: Wed, 16 Jul 2014 22:59:02 +0100
Message-ID: <20140716215902.GG17528@sirena.org.uk>
References: <1404854378-25828-1-git-send-email-bcousson@baylibre.com>
 <1404854378-25828-2-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7548428070881536522=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F1D1926535D
 for <alsa-devel@alsa-project.org>; Wed, 16 Jul 2014 23:59:13 +0200 (CEST)
In-Reply-To: <1404854378-25828-2-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Fabien Parent <fparent@baylibre.com>, misael.lopez@ti.com, lars@metafoo.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7548428070881536522==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3IyuMspwcGTbYISR"
Content-Disposition: inline


--3IyuMspwcGTbYISR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 08, 2014 at 11:19:34PM +0200, Benoit Cousson wrote:
> DAI link assumes a one to one mapping between CPU DAI and CODEC. In
> some cases, the same CPU DAI can be connected to several codecs.
> This is the case for example, if you connect two mono codecs to the
> same I2S link in order to have a stereo card.
> The current ASoC implementation does not allow such setup.

Applied, thanks.

--3IyuMspwcGTbYISR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxvWiAAoJELSic+t+oim9tXQP/3DgdlRXxG+Ub4YFT8/rZjS1
FTuCYNZJnDSrc3uRqJePREnQhifXhaL4Ipa8SUZyYt14uKu9mfcFJRxjz15+PZGX
ovBakILMInNTjHohdkSwHurIceaLO+7a0+Knwp9DxASoXiU3MSrElVlgNBLIntxN
sO2Xx3kOG7FjJ0y79QqNv6dGqUcsopTdWBb6WTeT4+ze1XB70KQOT+c0DDuU41DF
Qf6+9RVzq9gLMZc1AC4LAdKrSE1VT9PgY9pxSPvejzmvB7AwpGvmPcrsReFxKHWB
gNIyO4Mvj5pvIV0mt5Z3TXaJ74ZRglBPrm6zSaVbZmlI6mTF8ZdB16aaPBqYKSC7
neBdTrskuL7VJSL/dVBYhQ24+OH53arbrR1fkB6khS2KEd2h6ULq2bFlRJWwD2Mm
uuxKICbj6YipNNuPXR+OYM4Iyc47U3R4zyWDVnjYJoa6bISebXhILFHCx7UP9qHe
6vkeF4qqNm6phJi1bLCWiy2Tr98FIU5hlX1Btp8BGl7HFEgQ8A66KnHPh53mexk/
SbGREiLJPWIniINlHgH/pjmrlxGil+89tphCAnsvSlAyXxxuotw8GPjle/6U4x0/
p6dYeBzTwHhP9ck49bXUJT/wqWtjdgltxJNnulyiR9SW+G73DNsP2fWHFMtX7XEZ
JqTOrfLomRkj9X3KWleI
=ey95
-----END PGP SIGNATURE-----

--3IyuMspwcGTbYISR--

--===============7548428070881536522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7548428070881536522==--
