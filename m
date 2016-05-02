From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: nau8825: non-clock jack
 detection for power saving at standby
Date: Mon, 2 May 2016 17:27:15 +0100
Message-ID: <20160502162715.GK6292@sirena.org.uk>
References: <1461917718-25211-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5913706692503946668=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 99347260438
 for <alsa-devel@alsa-project.org>; Mon,  2 May 2016 18:27:24 +0200 (CEST)
In-Reply-To: <1461917718-25211-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5913706692503946668==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lildS9pRFgpM/xzO"
Content-Disposition: inline


--lildS9pRFgpM/xzO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 29, 2016 at 04:15:17PM +0800, John Hsu wrote:

> @@ -614,8 +623,10 @@ int nau8825_enable_jack_detect(struct snd_soc_codec =
*codec,
>  		NAU8825_HSD_AUTO_MODE | NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L,
>  		NAU8825_HSD_AUTO_MODE | NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L);
> =20
> -	regmap_update_bits(regmap, NAU8825_REG_INTERRUPT_MASK,
> -		NAU8825_IRQ_HEADSET_COMPLETE_EN | NAU8825_IRQ_EJECT_EN, 0);
> +	/* Change jack type detection interruption to non-clock architecture
> +	 * for power saving less 1mW. Move these configuration about inter-
> +	 * ruption at auto mode to auto irq setup function.
> +	 */
> =20

This comment is about the change you're making to the code rather than
something that should be in the code.

> +	/* Clear all interruption status */
> +	nau8825_int_status_clear_all(regmap);
> +
> +	/* Mask all interruptions except jack insertion interruption */
> +	regmap_write(regmap, NAU8825_REG_INTERRUPT_DIS_CTRL, 0xfffe);

So if any other interrupts occur then things will break...

> -	regmap_read(regmap, NAU8825_REG_IRQ_STATUS, &active_irq);
> +	if (regmap_read(regmap, NAU8825_REG_IRQ_STATUS, &active_irq)) {
> +		dev_err(nau8825->dev, "failed to clear interruption\n");
> +		return IRQ_NONE;
> +	}

This is a read, not a write, and it's better to report the error code if
the read failed.  This should probably be a separate patch.

>  static const struct regmap_config nau8825_regmap_config =3D {
> -	.val_bits =3D 16,
> -	.reg_bits =3D 16,
> +	.val_bits =3D NAU8825_REG_DATA_LEN,
> +	.reg_bits =3D NAU8825_REG_ADDR_LEN,

This appears to be an unrelated change which it's not clear helps the
reader, these defines only seem to be used in htis one place.

> @@ -1134,7 +1244,26 @@ static int nau8825_configure_sysclk(struct nau8825=
 *nau8825, int clk_id,
>  	struct regmap *regmap =3D nau8825->regmap;
>  	int ret;
> =20
> +	if (!nau8825_is_jack_inserted(nau8825->regmap) &&
> +		clk_id !=3D NAU8825_CLK_DIS) {
> +		/* For power saving less 1mW, the jack type detection inter-
> +		 * ruption changes to non-clock architecture. Therefore, the
> +		 * clock should be disabled and not allowed to config any clock
> +		 * when no headset connected.
> +		 */
> +		dev_warn(nau8825->dev, "Souldn't enable any clock when no headset conn=
ected\n");
> +		return 0;
> +	}

This is ignoring the attempt to set up a clock but returning success
which is going to break things, printing the warning is dubious (a
system could be built without detection for example, or a speaker driver
connected) but probably OK in itself but the fact that we don't tell the
caller may make things worse.

> +		nau8825_eject_jack(nau8825);
> +		snd_soc_jack_report(nau8825->jack, 0, SND_JACK_HEADSET);
> +	}
> +	enable_irq(nau8825->irq);

The interrupt is optional (that bug appears to be already present in the
driver but should be fixed).

--lildS9pRFgpM/xzO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXJ3/iAAoJECTWi3JdVIfQzFYH/2z/8Cx/eSCCmRGvWgVRewgM
7/P3vmfeOiyOB8PhU97ORdn/Kkz5dQjgQ8VfQmW6tTa3SHmMLHS3Kk4i/hHQs2Q4
RlWTHkTglFnMu4yU04Lx9RShXZ28/UPZMUtQVkd6oATgOZ7PEMhaHwM6CAPKCzP4
BEd0fVRvGO/eMV0CUwrI5htIDkLwWoGCifxaN6isfKxx+71mzN8fjFFo8tuBcF8A
QGGCImil5WbyzckTYtr3culiOkpY625uCl3mBR7/kBGGdlqoDDdgAGTbvlrhFvbE
A/7eUvqVBq8omeKt1ZKO4FxiAlPXQmWIKV9pbg5dZWjihXzDP54qNNUZcPOq0EY=
=BTJH
-----END PGP SIGNATURE-----

--lildS9pRFgpM/xzO--

--===============5913706692503946668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5913706692503946668==--
