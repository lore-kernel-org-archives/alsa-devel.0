From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add support for TI LM49453 Audio
	codec
Date: Fri, 27 Jan 2012 14:35:26 +0000
Message-ID: <20120127143525.GA15596@opensource.wolfsonmicro.com>
References: <290463D19D2E064191F1F96ECA480A89434AAB3793@EXMAIL02.scwf.nsc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0064547985106124507=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8F139244A2
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2012 15:35:28 +0100 (CET)
In-Reply-To: <290463D19D2E064191F1F96ECA480A89434AAB3793@EXMAIL02.scwf.nsc.com>
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
Cc: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood, Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============0064547985106124507==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 27, 2012 at 05:46:02AM -0800, Reddy, MR Swami wrote:

Overall this is a substantial improvement on your last version but
there's still quite a few issues here.  Looking at some of the issues
I'm concerned about how you're testing this, there are some things here
that I'd expect the core to complain about when you load the driver.

> +/* Register default values for LM49453 river. */
> +static const u8 lm49453_reg_defs[LM49453_MAX_REGISTER] = {

Please use the regmap API as previously requested.  If anything this is
going backwards as you've used a big table rather than

	[reg] = value

but really, use the regmap API.  The long term goal is to remove the
register cache from ASoC completely.

> +static const struct snd_kcontrol_new lm49453_headset_left_mixer[] = {
> +SOC_DAPM_SINGLE("Port1_1 HPL Switch", LM49453_P0_DACHPL1_REG, 0, 1, 0),

These controls are all going to end up called "HPL Mixer Port1_1 HPL
Switch" and so on which probably isn't what you want.  You shouldn't
have the "HPL" in any of the individual mixer controls, the prefixing is
enough to let the user know this is affecting the HPL mixer.  The same
issue applies to all your mixer controls.

> +static const struct snd_kcontrol_new lm49453_snd_controls[] = {
> +       SOC_DAPM_ENUM("Mic2Mode Capture Route", lm49453_mic2mode_enum),
> +       SOC_DAPM_ENUM("DMIC12 Capture Route", lm49453_dmic12_cfg_enum),
> +       SOC_DAPM_ENUM("DMIC34 Capture Route", lm49453_dmic34_cfg_enum),

Why are these appearing as regular controls?  DAPM controls should be
attached to widgets...

> +       /* Sidetone supports mono only */
> +       SOC_SINGLE_TLV("Sidetone ADCL Volume", LM49453_P0_STN_VOL_ADCL_REG,
> +                       0, 0x3F, 0, digital_tlv),
> +       SOC_SINGLE_TLV("Sidetone ADCR Volume", LM49453_P0_STN_VOL_ADCR_REG,
> +                       0, 0x3F, 0, digital_tlv),
> +       SOC_SINGLE_TLV("Sidetone DMIC1L Volume", LM49453_P0_STN_VOL_DMIC1L_REG,
> +                       0, 0x3F, 0, digital_tlv),
> +       SOC_SINGLE_TLV("Sidetone DMIC1R Volume", LM49453_P0_STN_VOL_DMIC1R_REG,
> +                       0, 0x3F, 0, digital_tlv),
> +       SOC_SINGLE_TLV("Sidetone DMIC2L Volume", LM49453_P0_STN_VOL_DMIC2L_REG,
> +                       0, 0x3F, 0, digital_tlv),
> +       SOC_SINGLE_TLV("Sidetone DMIC2R Volume", LM49453_P0_STN_VOL_DMIC2R_REG,
> +                       0, 0x3F, 0, digital_tlv),

These should probably line up with the relevant mixer controls.

> +       SND_SOC_DAPM_INPUT("AMIC1"), /* Headset mic */

Why is this specifically the headset mic?

> +       /* HP mapping */
> +       { "HPL Mixer", "PORT1_1_RX_LVL Volume", "PORT1_1_RX" },
> +       { "HPL Mixer", "PORT1_2_RX_LVL Volume", "PORT1_2_RX" },
> +       { "HPL Mixer", "PORT1_3_RX_LVL Volume", "PORT1_3_RX"},
> +       { "HPL Mixer", "PORT1_4_RX_LVL Volume", "PORT1_4_RX" },
> +       { "HPL Mixer", "PORT1_5_RX_LVL Volume", "PORT1_5_RX" },
> +       { "HPL Mixer", "PORT1_6_RX_LVL Volume", "PORT1_6_RX" },
> +       { "HPL Mixer", "PORT1_7_RX_LVL Volume", "PORT1_7_RX" },
> +       { "HPL Mixer", "PORT1_8_RX_LVL Volume", "PORT1_8_RX" },

This doesn't line up with the switches that are in the DAPM controls for
the mixers, the Volume controls are nothing to do with DAPM.

> +       { "Port2_1 Mixer", "Port1_1 Port2_1 Switch", "PORT1_1_RX_LVL Volume" },

PORT1_1_RX_LVL Volume is not a DAPM widget.  I'm very surprised this
driver manages to register without generating errors, how have you
tested this?

> +       snd_soc_write(codec, LM49453_P0_FLL_REF_FREQL_REG,
> +                            LM49453_FLL_REF_FREQ_VAL & 0xff);
> +       snd_soc_write(codec, LM49453_P0_FLL_REF_FREQH_REG,
> +                            (LM49453_FLL_REF_FREQ_VAL >> 8) & 0xff);
> +
> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETLL_REG,
> +                            LM49453_VCO_TARGET_VAL & 0xff);
> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETLH_REG,
> +                            (LM49453_VCO_TARGET_VAL >> 8) & 0xff);
> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETHL_REG,
> +                            (LM49453_VCO_TARGET_VAL >> 16) & 0xff);
> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETHH_REG,
> +                            (LM49453_VCO_TARGET_VAL >> 24) & 0xff);

This appears to completely ignore the parameters the user passed in, how
can this ever work?

> +static int lm49453_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
> +                                 unsigned int freq, int dir)
> +{
> +       struct snd_soc_codec *codec = dai->codec;
> +       struct lm49453_priv *lm49453 = snd_soc_codec_get_drvdata(codec);
> +
> +       switch (freq) {
> +       case 12288000:  /* Platform System Clock */

What does this comment mean?

> +static int lm49453_startup(struct snd_pcm_substream *substream,
> +                          struct snd_soc_dai *codec_dai)
> +{
> +       unsigned int startup_mask;
> +       struct snd_soc_codec *codec = codec_dai->codec;
> +       dev_dbg(codec->dev, "lm49453_startup\n");
> +
> +       startup_mask = LM49453_PMC_SETUP_CHIP_EN | LM49453_PMC_SETUP_PLL_EN;
> +       snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG, startup_mask,
> +                           startup_mask);

This looks like it should be DAPM or bias level manaement, and indeed
CHIP_EN is disabled by bias management.

> +static int lm49453_hp_mute(struct snd_soc_dai *dai, int mute)
> +{
> +       snd_soc_update_bits(dai->codec, LM49453_P0_DAC_DSP_REG, BIT(1)|BIT(0),
> +                           BIT(1)|BIT(0));
> +       return 0;
> +}

This completely ignores the mute parameter.

> +static int __init lm49453_modinit(void)
> +{
> +       int ret;
> +       ret = i2c_add_driver(&lm49453_i2c_driver);
> +       if (ret != 0)
> +               pr_err("Failed to register LM49453 I2C driver: %d\n", ret);
> +
> +       return ret;
> +}
> +module_init(lm49453_modinit);

Use module_i2c_driver.

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPIrYmAAoJEBus8iNuMP3dQ0kQAJcV65ReimU5FLClg+mbOymh
oXn8AaKL44MP8d9jeXoV1eNI/aRQjs+FsUvhblUsbZzsa8p7cyryNQGIw8wR59f1
FyH5fRF6srkYEj0aSrHXnaaNVEx2ChqvOuz/Mw6xqCIY6Dr6dtLAStbd/t5k/wuD
/hC/H4XugT5o74vf7d684E5m3lDrScWZDSYpIhOKS8o+yJU+L9oWrcoKdCN5wPkD
MfFSQihU4VPN3vLTw/adgopz3QIQ0b7KlOAFSxGVfNfm9rrH1AYMElUeBoiSsvDQ
4EALrsf8/78iy6iw6ScjVh8Hpy4KRV7d6gqzxtliosC5NH84vaW0UqwM1y+1llKJ
nVGDkACr0akF+fBQWJ/OhscqPcW5V1A/xhZ39K2qcLK+D1fsRSHaII+/JzSVjNIb
WwxmLwVfkk5SsYKQZDsWO6pQqulrZkRFClQa+VVPOvnbw06OhfMKst5hLFO4EEC8
W6bNuYh6C7zAk1MpVOfYtvrc44kGtfYuhiHvNPWR8v1yj/sbJzF48l5inBQBy8if
exU+2vFyYqCaInjMnHxazFNIKAQkkEYgxLLTdg93ddKoArBfaSZYdv+zwC75rthx
EXU9j5gdw+mTLa0iyiQMZRSwmaU24MLe2Zt3A0Q9aU2Tz2eonvHm9EchvmyKOfL3
70R0K700EWDnara/poGO
=17y7
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--

--===============0064547985106124507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0064547985106124507==--
