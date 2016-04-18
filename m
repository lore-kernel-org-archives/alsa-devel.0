From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic32x4: Add SPI support
Date: Mon, 18 Apr 2016 11:35:54 +0100
Message-ID: <20160418103554.GR3217@sirena.org.uk>
References: <1460745059-5737-1-git-send-email-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3791133141285495475=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C6252650B0
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 12:36:03 +0200 (CEST)
In-Reply-To: <1460745059-5737-1-git-send-email-nh6z@nh6z.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeremy McDermond <nh6z@nh6z.net>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3791133141285495475==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="//h4sZKAxcnndsN6"
Content-Disposition: inline


--//h4sZKAxcnndsN6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 15, 2016 at 11:30:59AM -0700, Jeremy McDermond wrote:
> The TLV320AIC32x4 support the control channel over either SPI or I2C.
> Added the proper interfacing with regmap to make the driver able to
> handle either possibility.
>=20
> Signed-off-by: Jeremy McDermond <nh6z@nh6z.net>
> ---
>  sound/soc/codecs/Kconfig         |   5 +-
>  sound/soc/codecs/tlv320aic32x4.c | 181 +++++++++++++++++++++++++++++++++=
++----
>  2 files changed, 165 insertions(+), 21 deletions(-)

Instead of putting everything in one file please split the driver so it
has separate core and I2C modules and then add a SPI module like we do
for newer drivers.

>  config SND_SOC_TLV320AIC32X4
> -	tristate
> +	tristate "Texas Instruments TLV320AIC32x4 CODECs"
> +	depends on SND_SOC_I2C_AND_SPI

Making the driver directly user selectable is a separate change and
should be in a separate patch.

--//h4sZKAxcnndsN6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFLiKAAoJECTWi3JdVIfQGj4H/2JNUtjoRSQmOT9KEZP8LfSB
qeBw64U1YZR/z93YvKWHwBGt/QP8iIxkK/m/jTdjk/+wylmmT614ADwsAiF1RB6H
zymHUFJrkcs0W77mYNYhhI4P5fHopFHyfxBi0AFyfONamGz92A8YXG7rnoBi3W8D
8yaKPyLB13mg865hqKL7BYP7+72P9/ta07VZ4WCS9IN94QmTyXoHB7OF3QmUbRkc
MumcXMCgXPH5TXlnNnIAFbuhzAu/GOQburb9/Oh5505xu4xMvqUbHVPPYCmGzPjb
Drc7uaC+8B/q9c9HZ6Xw5VOKEJ1hvxavg+OcxQgpUL3Y4aw/tl4oa7Gqy/g92y8=
=yU65
-----END PGP SIGNATURE-----

--//h4sZKAxcnndsN6--

--===============3791133141285495475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3791133141285495475==--
