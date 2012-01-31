From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add support for TI LM49453 Audio
	codec
Date: Tue, 31 Jan 2012 20:12:07 +0000
Message-ID: <20120131201153.GG3429@opensource.wolfsonmicro.com>
References: <290463D19D2E064191F1F96ECA480A89434AAB43C3@EXMAIL02.scwf.nsc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4368279021373696879=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E02CC24386
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 21:12:35 +0100 (CET)
In-Reply-To: <290463D19D2E064191F1F96ECA480A89434AAB43C3@EXMAIL02.scwf.nsc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Reddy, MR Swami" <MR.Swami.Reddy@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4368279021373696879==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uc35eWnScqDcQrv5"
Content-Disposition: inline


--uc35eWnScqDcQrv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 31, 2012 at 03:59:57AM -0800, Reddy, MR Swami wrote:

> ASoC: Add support for TI LM49453 Audio codec

This is a really good improvement on the previous version but there's
still several issues and I'm still having a hard time understanding how
you didn't see some of them in testing.

> +static struct reg_default lm49453_reg_defs[] = {
> +       { 0, 0x00}, { 1, 0x00}, { 2, 0x00}, { 3, 0x00}, /*R3*/

The indentation here is *really* strange - you've no space before the }.
The comments are also pretty redundant given that the reg_default
already contains the register address.

Looking at the register defines in the header it seems like a lot of
these should be omitted - you've got registers up to 0x5 then you jump
up to page 1 starting at 0x80 so nothing between those two needs to be
in the defaults table.  The reason we have the register address in there
is to support devices with sparse register maps like this.

> +static const struct snd_kcontrol_new lm49453_sidetone_mixer_controls[] = {
> +/* Sidetone supports mono only */
> +SOC_SINGLE_TLV("Sidetone ADCL Volume", LM49453_P0_STN_VOL_ADCL_REG,
> +               0, 0x3F, 0, digital_tlv),
> +SOC_SINGLE_TLV("Sidetone ADCR Volume", LM49453_P0_STN_VOL_ADCR_REG,
> +               0, 0x3F, 0, digital_tlv),
> +SOC_SINGLE_TLV("Sidetone DMIC1L Volume", LM49453_P0_STN_VOL_DMIC1L_REG,
> +               0, 0x3F, 0, digital_tlv),
> +SOC_SINGLE_TLV("Sidetone DMIC1R Volume", LM49453_P0_STN_VOL_DMIC1R_REG,
> +               0, 0x3F, 0, digital_tlv),
> +SOC_SINGLE_TLV("Sidetone DMIC2L Volume", LM49453_P0_STN_VOL_DMIC2L_REG,
> +               0, 0x3F, 0, digital_tlv),
> +SOC_SINGLE_TLV("Sidetone DMIC2R Volume", LM49453_P0_STN_VOL_DMIC2R_REG,
> +               0, 0x3F, 0, digital_tlv),
> +SOC_DAPM_SINGLE("Sidetone Enable Switch", LM49453_P0_DMIX_CLK_SEL_REG, 2, 1, 0),

Just Sidetone Switch, Switch implies enable/disable.  You also shouldn't
have plain SOC_ controls mixed with the DAPM ones, the mixer should only
have DAPM controls.

> +       SOC_DAPM_ENUM("Mic2Mode", lm49453_mic2mode_enum),
> +       SOC_DAPM_ENUM("DMIC12 SRC", lm49453_dmic12_cfg_enum),
> +       SOC_DAPM_ENUM("DMIC34 SRC", lm49453_dmic34_cfg_enum),

These shouldn't be in the regular ALSA controls, they should be attached
to a DAPM widget.

> +       /* Capture path filter enable */
> +       SOC_DAPM_SINGLE("DMIC1 HPFilter Switch",
> +                       LM49453_P0_ADC_FX_ENABLES_REG, 0, 1, 0),

This shouldn't be a DAPM control.  I'm surprised this doesn't crash when
used...

> +       SND_SOC_DAPM_PGA("Sidetone", SND_SOC_NOPM, 0, 0, NULL, 0),

Why have this separately to the mixer for the sidetone?  It doesn't
actually do anything...

> +       /* EP map */
> +       { "EPOUT", "Earpiece Enable", "HPL DAC" },

Earpiece Enable should be a control of some kind for this to do anything
useful, and if it were a control it should be called Switch.

> +       { "LSOUTL", "Speaker Left Enable", "LSL DAC"},
> +       { "LSOUTR", "Speaker Left Enable", "LSR DAC"},

Similarly here and elsewhere.

> +       /* Sidetone map */
> +       { "Sidetone Mixer", "Sidetone Enable Switch", "ADC Left" },
> +       { "Sidetone Mixer", "Sidetone Enable Switch", "ADC Right" },
> +       { "Sidetone Mixer", "Sidetone Enable Switch", "DMIC1 Left" },
> +       { "Sidetone Mixer", "Sidetone Enable Switch", "DMIC1 Right" },
> +       { "Sidetone Mixer", "Sidetone Enable Switch", "DMIC2 Left" },
> +       { "Sidetone Mixer", "Sidetone Enable Switch", "DMIC2 Right" },

This looks very wrong.  Aside from the "Sidetone Enable Switch" naming
you've got *all* the inputs controlled by the same switch - is that
really the case?  If it is you don't really have individual controls on
the inputs and you'd be better just putting a switch on the output of
the sidetone.

> +       state->in = freq_in;
> +       state->out = freq_out;

> +       snd_soc_write(codec, LM49453_P0_FLL_REF_FREQL_REG, (state->in & 0xff));
> +       snd_soc_write(codec, LM49453_P0_FLL_REF_FREQH_REG,
> +                            ((state->in >> 8) & 0xff));

So the PLL only supports inputs in the range 0-65535Hz?  You probably
want to validate the input range...

> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETLL_REG,
> +                            state->out & 0xff);
> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETLH_REG,
> +                            (state->out >> 8) & 0xff);
> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETHL_REG,
> +                            (state->out >> 16) & 0xff);
> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETHH_REG,
> +                            (state->out >> 24) & 0xff);

Ditto here, though it's less urgent as the range is much greater, though
does the device really support up to 4.2GHz?  That's *very* high for an
audio device.

> +       dev_dbg(codec->dev, "\n in lm49453_hw_params\n");

I'm not a big fan of stuff like this, and the leading \n is certainly
out of style for the kernel.

> +       switch (lm49453->sysclk) {
> +       case 12288000:
> +       case 26000000:
> +       case 19000000:
> +               pll_clk = ~BIT(4);
> +               break;
> +       case 48000:
> +       case 32576:
> +               pll_clk = BIT(4);
> +               break;

This doesn't appear to be talking to the PLL configuration above which
is *very* weird.

> +static int lm49453_hp_mute(struct snd_soc_dai *dai, int mute)
> +{
> +       if (mute)
> +               snd_soc_update_bits(dai->codec, LM49453_P0_DAC_DSP_REG,
> +                                   BIT(1)|BIT(0), BIT(1)|BIT(0));
> +       return 0;
> +}

Once this has activated the mute the headphone will stay muted for ever
as it can only ever mute.  That's probably not desirable.

> +       case SND_SOC_BIAS_STANDBY:
> +               if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
> +                       regcache_sync(lm49453->regmap);
> +               break;
> +
> +       case SND_SOC_BIAS_OFF:
> +               reg = LM49453_PMC_SETUP_CHIP_EN;
> +               snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG,
> +                                   LM49453_PMC_SETUP_CHIP_EN, reg);
> +               break;

This seems wrong, on STANDBY->OFF you disable the chip enable bit (which
is fine) but on OFF->STANDBY you only sync the cache (which is fine) and
don't reenable the chip (which seems like it's something you should do).

> +       /* Get the codec into a known state */
> +       reg = LM49453_RESET_REG_RST;
> +       snd_soc_update_bits(codec, LM49453_P0_RESET_REG, BIT(0), reg);
> +       if (ret != 0) {
> +               dev_err(codec->dev, "Failed to reset codec: %d\n", ret);
> +               return ret;
> +       }

You should move this into the I2C probe, best to get control of the
device as soon as possible.

--uc35eWnScqDcQrv5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKEsBAAoJEBus8iNuMP3d1g0P/iUGsL6iVSmhnVt4dF6fJ6Dx
JyH436Efu6tSTnrQC8jiGNcC6gI+psHQcPGLb2lKXQNwYqtbr9R82XQjN3umZ8+y
pLXtXsFiHOCC9Ex5iEWbDBirf5zRcnOrpx8MUMaKs72HzAzRSa1UT7pJyHLR7GFT
okQjDIwoTa7Xfg2E+k3WGyW2s9MeLn4nTly1uWr568Hti+RpY7zrZRi4MBAprC/V
e2DDGOOSEk2HpnR/XUIkd+hSu7GSrcV3762ajClgVQEFEhLpAyG+IIGYBdro5yzu
t1QU6dQZdlye4D8GPZuOYBNPMXH0I//DjqiVIG+tz4AohF/fMDWaYyNn0bDBiC1u
+4bt4LEQJBNwbC7VVRZDQpEuOSVjz/SofcWrHjcTVLhMr4Iqg+A4ckboeD65Ngs0
2789pqkMdlXnZNHdWFsopydVzf4/jufobLVBn3Hr2nCG5Nil0KVWUHd98sLbUV8J
5PoVmePm41h0V/3fxVBCaoLZST3oFQcPJ8RDCp9uW15QP71WOYrUSt7T5rp5uoU5
tk6j47HCRrVnNczYV2J6vOC++73HfXAGSBvU7GPXjmHV1o5HpxATAaBC4jyG4MHI
05ObPl2CJW9WGQxzp4kYf6q3lwMu6fQ0ApkQPgYkupjxMyFa1aSHgI+IBlpKWMdL
amo/F/g48o9B0mu4hJiT
=pmI3
-----END PGP SIGNATURE-----

--uc35eWnScqDcQrv5--

--===============4368279021373696879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4368279021373696879==--
