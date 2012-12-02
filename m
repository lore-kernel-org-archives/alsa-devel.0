From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 1/1] ASoC: ak5702: add support for
 ak5702 -- 4ch ADC
Date: Sun, 2 Dec 2012 13:23:01 +0900
Message-ID: <20121202042300.GU17981@opensource.wolfsonmicro.com>
References: <CAFsPKCW7N8ZBiazDtmEKLXVCxrZ-00sk9YJTreffAJAcWGv=pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2257152256590897163=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 716CC2650DF
 for <alsa-devel@alsa-project.org>; Sun,  2 Dec 2012 05:23:08 +0100 (CET)
In-Reply-To: <CAFsPKCW7N8ZBiazDtmEKLXVCxrZ-00sk9YJTreffAJAcWGv=pw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paolo Doz <paolo.doz@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============2257152256590897163==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y80AKZIs+e/pKYlV"
Content-Disposition: inline


--y80AKZIs+e/pKYlV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 28, 2012 at 04:54:49PM +0100, Paolo Doz wrote:

> +enum ak5702_clock_mode {
> +    AK5702_CLKPLL_SLAVE,
> +    AK5702_CLKPLL_SLAVE2,

The number one problem with this patch is that it's not following the
kernel coding style at all - please see CodingStyle, checkpatch should
also complain a lot about this.

> +#define AK5702_VERSION "0.5"
> +#define DRV_NAME "ak5702"

The kernel already has perfectly good version numbers, use them - people
aren't going to keep driver specific version numbers up to date anyway.

> +static const struct reg_default ak5702_reg_defaults[] = {
> +    {  0, 0x0000},    /* R0  - Power Management */

Looks a big odd - I'd expect spaces for both { and }.

> +static bool ak5702_writeable(struct device *dev, unsigned int reg)
> +{
> +    return reg < AK5702_MAX_REGISTER;

Should be <= or the #define is misnamed.

> +static const struct soc_enum ak5702_enum[] = {
> +    SOC_ENUM_SINGLE(AK5702_SIG1, 0, 2, ak5702_adca_left12_input),
> +    SOC_ENUM_SINGLE(AK5702_SIG1, 1, 2, ak5702_adca_right12_input),

Don't use a big array of enums, it's error prone and hard to read.  Use
individually named enums like other drivers.

> +    SOC_ENUM("ADCA Left1/2 Capture Source", ak5702_enum[0]),
> +    SOC_ENUM("ADCA Right1/2 Capture Source", ak5702_enum[1]),
> +    SOC_ENUM("ADCB Left1/2 Capture Source", ak5702_enum[2]),
> +    SOC_ENUM("ADCB Right1/2 Capture Source", ak5702_enum[3]),
> +    SOC_ENUM("ADCA Left5 Capture Source", ak5702_enum[4]),
> +    SOC_ENUM("ADCA Right5 Capture Source", ak5702_enum[5]),
> +    SOC_ENUM("ADCB Left5 Capture Source", ak5702_enum[6]),
> +    SOC_ENUM("ADCB Right5 Capture Source", ak5702_enum[7]),

These should all be DAPM controls.

> +    SOC_SINGLE_TLV("Mic A Boost Gain", AK5702_MICG1, 0, 3, 0, mic_tlv),
> +    SOC_SINGLE_TLV("Mic B Boost Gain", AK5702_MICG2, 0, 3, 0, mic_tlv),

Volume, not Gain.

> +        /* power on ADCA */
> +        value = AK5702_PM1_PMADAL |
> +            AK5702_PM1_PMADAR |
> +            AK5702_PM1_PMVCM;
> +        snd_soc_write(codec, AK5702_PM1, value);
> +        /* power up ADCB */
> +        value = AK5702_PM2_PMADBL | AK5702_PM2_PMADBR;
> +        snd_soc_write(codec, AK5702_PM2, value);

Just inline the value to write.

> +        if (params_format(params) == SNDRV_PCM_FORMAT_S16_LE)
> +            value = AK5702_FMT1_TDM128;
> +        else if (params_format(params) == SNDRV_PCM_FORMAT_S32_LE)
> +            value = AK5702_FMT1_TDM256;
> +        else
> +            return -EINVAL;

Use a switch statement for the check for params_format().

> +    case 48000:
> +        if (ak5702->clock_mode == AK5702_CLKPLL_SLAVE2)
> +            value = AK5702_FS1_BCLK_MODE2;
> +        else if (ak5702->clock_mode == AK5702_CLKEXT_SLAVE)
> +            value = AK5702_FS1_SLAVE_256FS; /* mode 3 256fs*/
> +        else
> +            return -EINVAL;

Similarly here.

> +static int ak5702_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
> +        int source, unsigned int freq_in, unsigned int freq_out)
> +{
> +    struct snd_soc_codec *codec = codec_dai->codec;
> +    u8 reg = 0;
> +    pr_debug("Entered %s", __func__);
> +    reg = snd_soc_read(codec, AK5702_PLL1);
> +    switch (pll_id) {
> +    case AK5702_PLL_POWERDOWN:
> +        reg &= (~AK5702_PLL1_PM_MASK);
> +        reg |= AK5702_PLL1_POWERDOWN;
> +        break;

pll_id should be which PLL is being changed, power down is done by
setting the PLL output to zero.

> +    case AK5702_PLL_MASTER:
> +        reg &= (~AK5702_PLL1_MODE_MASK);
> +        reg |= AK5702_PLL1_MASTER | AK5702_PLL1_POWERUP;
> +        break;
> +    case AK5702_PLL_SLAVE:

These probably want to be selected by source.

> +        reg &= (~AK5702_PLL1_MODE_MASK);
> +        reg |= AK5702_PLL1_SLAVE | AK5702_PLL1_POWERUP;

snd_soc_update_bits()

> +    default:
> +        return -ENODEV;

-EINVAL.

> +    if (div_id == AK5702_BCLK_CLKDIV) {

switch.

> +    dev_info(codec->dev, "AK5702 Audio Codec %s", AK5702_VERSION);

Remove this, it's just adding noise to the boot.

> +    codec->control_data = ak5702->regmap;

No need for this, the framework will use dev_get_regmap().

> +static const struct i2c_device_id ak5702_i2c_id[] = {
> +    { "ak5702-codec", 0 },

No -codec, this is a single function device and it appears to be an ADC
rather than a CODEC anyway.

> +    .driver = {
> +        .name = "ak5702-codec",

No -codec.

--y80AKZIs+e/pKYlV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQutebAAoJELSic+t+oim9rQAP/i8d9MoCIQkusdafjbPqR8Ag
hQ0EUHDu1Xl10s4vP+y6meBnSIe5IdBotIRgncJ8di5UAIRyLj/ZG63eOXX07LGV
iVf4o0NSpjB4qxJDK/1F04Pzlz5ctCw0PZozP11F3be56bT/jEyl5KZvkERvqpOq
hD1LO8yVWF236r9F+zCH1OznXGOEdca9Xakn1XDpmcLuvuyo6/uL4Tm89BhX/gho
qRZqmmQpJyY5HE/FjiH+ZpvXAzlTXC+NoCeIQ0z4T436Gzsay3cOoFD9+MJhOZ7O
064m2ToMn28DOiVa3EEomisBLFkIXdSoIaOfuAgR/kq0bnRIhaFMlexZuopsrfuZ
WkYt8Ra0GQEfWNqNfxtCgpX3KF31rRW67ChuMvVMyklUZ4xqVXCeVI9W/IxOMzEq
kIwcvm5xemnJKYT73EL3ys8K3zGnaRbaiVkf1GUDmamZxN5vZ2bxK+NPrMvuw8Ws
+VU4kj/pZGzkt0sejf3YiAkvgcxSBsbr/US73wO5g/DRXttdGxBpufMnAHhobO6k
7kF9htJgZq3DvrOz4q1uoJujdEBQWzRv8Nqr0odYmDmHFNYZEAnvThpYdzqQ7Nii
9tT2aS91303G9E3eC4Z88MHt9ipbUiY3zNWyl6qoDsWIfUExAcnzbMUva1+7NC50
otc3EXQIBRpX2UoxkAbg
=MW2m
-----END PGP SIGNATURE-----

--y80AKZIs+e/pKYlV--

--===============2257152256590897163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2257152256590897163==--
