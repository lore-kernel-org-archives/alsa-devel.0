From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 3/3] ASoC: sun4i-i2s: Add regmap field to
 sign extend sample
Date: Thu, 25 Jan 2018 09:41:45 +0100
Message-ID: <20180125084145.f4otos2kavo6rg7t@flea.lan>
References: <20180124141101.12867-1-codekipper@gmail.com>
 <20180124141101.12867-4-codekipper@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0349734385623745413=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id DDDEE2675B2
 for <alsa-devel@alsa-project.org>; Thu, 25 Jan 2018 09:41:46 +0100 (CET)
In-Reply-To: <20180124141101.12867-4-codekipper@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: codekipper@gmail.com
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, be17068@iperbole.bo.it, linux-sunxi@googlegroups.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0349734385623745413==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x6khl46bbijbnw25"
Content-Disposition: inline


--x6khl46bbijbnw25
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 24, 2018 at 03:11:01PM +0100, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>=20
> On the newer SoCs this is set by default to transfer a 0 after
> each sample in each slot. Add the regmap field to configure this
> and set it so that it pads the sample with 0s.
>=20
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 626679057d0f..9fda1240b717 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -139,6 +139,7 @@
>   * @field_fmt_bclk: regmap field to set clk polarity.
>   * @field_fmt_lrclk: regmap field to set frame polarity.
>   * @field_fmt_mode: regmap field to set the operational mode.
> + * @field_fmt_sext: regmap field to set the sign extension.
>   * @field_txchanmap: location of the tx channel mapping register.
>   * @field_rxchanmap: location of the rx channel mapping register.
>   * @field_txchansel: location of the tx channel select bit fields.
> @@ -164,6 +165,7 @@ struct sun4i_i2s_quirks {
>  	struct reg_field		field_fmt_bclk;
>  	struct reg_field		field_fmt_lrclk;
>  	struct reg_field		field_fmt_mode;
> +	struct reg_field		field_fmt_sext;
>  	struct reg_field		field_txchanmap;
>  	struct reg_field		field_rxchanmap;
>  	struct reg_field		field_txchansel;
> @@ -188,6 +190,7 @@ struct sun4i_i2s {
>  	struct regmap_field	*field_fmt_bclk;
>  	struct regmap_field	*field_fmt_lrclk;
>  	struct regmap_field	*field_fmt_mode;
> +	struct regmap_field	*field_fmt_sext;
>  	struct regmap_field	*field_txchanmap;
>  	struct regmap_field	*field_rxchanmap;
>  	struct regmap_field	*field_txchansel;
> @@ -358,6 +361,9 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai =
*dai,
>  				   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
>  				   SUN8I_I2S_FMT0_LRCK_PERIOD(word_size));
> =20
> +	/* Set sign extension to pad out LSB with 0 */
> +	regmap_field_write(i2s->field_fmt_sext, 0);
> +

Your commit log seems to suggest that it's only relevant for the newer
SoCs (which ones?), yet you enable it for all the supported
ones. Either the code or the commit log should be adjusted to be
consistent with the other.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--x6khl46bbijbnw25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlppmEgACgkQ0rTAlCFN
r3R24g//Qq8Hn5WH2EmAF0N1pB5pL4T+mUcye47fpWjqEY8lA6nZToPlkkItkupj
CFRty/jkjruX9ykuz5us0Sm9xXMi5ICb5vOlh7Bk4BIKxssqWaXnmMPN7XQhxYba
zo/9Y/FvY1bqwhR52/oF2jStDplbQIVKKG5pAQG79IcyxvJAKXLGYUZU8JMJxNve
mvNgVUQ/e5IdhWxgeEw/nJXdb2jzDEFgRfbQZb0SVPcBYRt1qrIWSnK1D8dVzCbs
SYCfS6jSsS4CrynFvB5g6j0SNm6Yqqkf1rXw/vuyySRjQ1m5DWJ6JDsathsDaeiC
B7lkt2hoQuxSh7nlzJ/UHLI2mwmhkgJOduJ2kzLD4q10SoVoaPKH44qH5oHbjpFU
+OVoTPJDpvuhBBKyZMxfu4VNtR4Tl8nwv/YOiZkTHo6bKp7GSV3c3lDY9lMgj6vp
wnaVlSeXICWF0sqNieNMIExbSvZ4+9OnHVh7VGC83eahjjg6FFv3BY/DpW3GIYK5
B88HMwMHvg3XiFMAFG2jdO7EiplwPZ4ukcKfliEVWgO+x21FE772J/jUL2/Zm03z
j9F12CZqPetxQwLWFmN46K6retcnauKG91uBPUHDjuYPSTNAUpRjh1ptw2SqO27G
oNE1jJHtC7EMGC8DAJ7qa9XwXQ0koh5XPywforMgRYl/piv7sgM=
=zxor
-----END PGP SIGNATURE-----

--x6khl46bbijbnw25--

--===============0349734385623745413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0349734385623745413==--
