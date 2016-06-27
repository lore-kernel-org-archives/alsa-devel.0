From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8810: Add driver for Nuvoton
	codec chip NAU88C10
Date: Mon, 27 Jun 2016 18:15:46 +0100
Message-ID: <20160627171546.GE17217@sirena.org.uk>
References: <1466152834-29615-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0865337710486129795=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 043A8266F37
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2016 19:15:54 +0200 (CEST)
In-Reply-To: <1466152834-29615-1-git-send-email-KCHSU0@nuvoton.com>
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
Cc: YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0865337710486129795==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
Content-Disposition: inline


--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 17, 2016 at 04:40:34PM +0800, John Hsu wrote:

> +static int nau8810_reg_write(void *context, unsigned int reg,
> +			      unsigned int value)
> +{
> +	struct i2c_client *client = context;
> +	uint8_t buf[2];
> +	__be16 *out = (void *)buf;
> +	int ret;
> +
> +	*out = cpu_to_be16((reg << 9) | value);
> +	ret = i2c_master_send(client, buf, sizeof(buf));

...

> +	reg_buf = (uint8_t)(reg << 1);
> +	xfer[0].addr = client->addr;
> +	xfer[0].len = sizeof(reg_buf);
> +	xfer[0].buf = &reg_buf;
> +	xfer[0].flags = 0;
> +
> +	xfer[1].addr = client->addr;
> +	xfer[1].len = sizeof(val_buf);
> +	xfer[1].buf = (uint8_t *)&val_buf;
> +	xfer[1].flags = I2C_M_RD;

This looks like a regmap with 7 bit registers and 9 bit value.  Why
aren't we just using the standard regmap support for this?

> +static const struct soc_enum nau8810_enum[] = {
> +	SOC_ENUM_SINGLE(NAU8810_REG_COMP, NAU8810_ADCCM_SFT,
> +		ARRAY_SIZE(nau8810_companding), nau8810_companding),

Don't define a big array of enums, this makes the code both hard to read
and error prone when we index into the array by hard coded raw numbers.
Just define each enum as a variable and then reference it by address
like we do for enums in other drivers.

> +	SOC_SINGLE("Digital Loopback Switch", NAU8810_REG_COMP,
> +		NAU8810_ADDAP_SFT, 1, 0),

This looks like it should be a DAPM control.

> +	SOC_SINGLE_TLV("Playback Gain", NAU8810_REG_DACGAIN,
> +		NAU8810_DACGAIN_SFT, 0xff, 0, digital_tlv),

All volume controls should have names ending in Volume so that userspace
tools can know how to presen them.

> +static int nau8810_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct nau8810 *nau8810 = snd_soc_codec_get_drvdata(codec);
> +	int ret = 0;
> +
> +	nau8810->div_id = div_id;
> +	if (div_id != NAU8810_MCLK_DIV_MCLK)
> +		/* Defer the master clock prescaler configuration to DAI
> +		 * hardware parameter if master clock from MCLK because
> +		 * it needs runtime fs information to get the proper div.
> +		 */
> +		ret = nau8810_config_clkdiv(nau8810, div, 0);
> +
> +	return ret;
> +}

You shouldn't be implementing new set_clkdiv() operations, there's no
point in having each machine driver figure out the internal clocking of
the device.  Just specify the clocks coming into the device and have
the driver figure out what to do with them.

> +static int nau8810_probe(struct snd_soc_codec *codec)
> +{
> +	struct nau8810 *nau8810 = snd_soc_codec_get_drvdata(codec);
> +
> +	regmap_write(nau8810->regmap, NAU8810_REG_RESET, 0x00);

This will break the regmap cache if the driver is ever rebound to a
card, do this once on I2C probe.

--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXcV9BAAoJECTWi3JdVIfQOM8H/2CzskemOaG3J9AB87RVSsx4
Cchd4wiJhp6oTWd1miG6z1jaemluuPVzdPmRYC+Ip5zBpd5stfPXnEZfvUOLci6B
uwjoGcvuM8CytNxAuxOvnLoQ9By6ZeWM03KIQZH/guiIQ+iI9EvFUV0tGaksG3jE
+6J71APhAHS8RSOlc87U1IZbpiV7/0t5NKDflU2YK2jEPHKnOy6XoVKi5oBK9slW
9Fhak+6ER9QTAE0N8seDwr35illuMJBGO83AMoNZPPczv1hGCYlZ8zfNGjqhtZV9
16GuSdFGWoivFZx+yCz+xzmR8Wo3mNel2PtMabX2XiR0fQVKbjocXIXC8VsCmTE=
=adOG
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--

--===============0865337710486129795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0865337710486129795==--
