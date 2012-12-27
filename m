From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 001/001] ASoC: Replace max98090 Device
	Driver
Date: Thu, 27 Dec 2012 17:26:30 +0000
Message-ID: <20121227172628.GG5005@opensource.wolfsonmicro.com>
References: <A453F1AE3B5DC14DB19666C506CE75A7108684F28F@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7422473392289375814=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 93F95264ECA
 for <alsa-devel@alsa-project.org>; Thu, 27 Dec 2012 18:26:33 +0100 (CET)
In-Reply-To: <A453F1AE3B5DC14DB19666C506CE75A7108684F28F@ITSVLEX06.it.maxim-ic.internal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerry Wong <Jerry.Wong@maximintegrated.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============7422473392289375814==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PW0Eas8rCkcu1VkF"
Content-Disposition: inline


--PW0Eas8rCkcu1VkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 13, 2012 at 11:19:29AM -0800, Jerry Wong wrote:

For legibility please submit future revisions as a two stage patch
series, one removing the old driver and another adding the new one.

> +/* codec platform data */
> +struct max98090_pdata {
> +
> +       int irq;

This should be passed in using the normal mechanism provided by the bus,
not custom implemented.

> +       int power_over_performance;

This doesn't look like platform data to me, it looks like something that
should be configured dynamically at runtime.

> +       /* Equalizers for DAC */
> +       struct max98090_eq_cfg *eq_cfg;
> +       unsigned int eq_cfgcnt;

Coefficients should be configured using SND_SOC_BYTES().  Some older
drivers use this method but it's deprecated.

> +       { 0xE0, 0x00 }, /* E0 */
> +       { 0xE1, 0x00 }, /* E1 */
> +       { 0xE2, 0x00 }, /* E2 */

Do these number-only registers actually exist in the published register
map or are they undefined?  If they're undefined and not used by
software there's no need to include them here.

> +       switch (reg) {
> +       case M98090_REG_01_IRQ_STATUS:
> +       case M98090_REG_02_JACK_STATUS:
> +       case M98090_REG_FF_REV_ID:

Including the register number in the constants seems to rather defeat
the point of having symbolic names for the registers; it means people
still have to remember the register numbers.

> +static int max98090_get_enab_tlv(struct snd_kcontrol *kcontrol,
> +                               struct snd_ctl_elem_value *ucontrol)

What's the relevance of _tlv here?  It looks like these are normal get
and sets.

> +static const char * max98090_dsts_text[] =
> +       { "None", "Left", "Right", "Left and Right" };
> +
> +static const struct soc_enum max98090_dsts_enum =
> +       SOC_ENUM_SINGLE(M98090_REG_1A_LVL_SIDETONE, M98090_DSTS_SHIFT,
> +               ARRAY_SIZE(max98090_dsts_text), max98090_dsts_text);


> +static const struct snd_kcontrol_new max98090_snd_controls[] = {

> +       SOC_SINGLE("DMIC MIC Left Enable", M98090_REG_13_MIC_CFG1,
> +               M98090_DIGMICL_SHIFT, M98090_DIGMICL_NUM - 1, 0),
> +       SOC_SINGLE("DMIC MIC Right Enable", M98090_REG_13_MIC_CFG1,
> +               M98090_DIGMICR_SHIFT, M98090_DIGMICR_NUM - 1, 0),

This looks like it should be DAPM.

> +       SOC_ENUM_EXT("External MIC Mux", max98090_extmic_mux_enum,
> +               max98090_extmic_mux_get, max98090_extmic_mux_set),

Likewise.

> +       SOC_ENUM("Digital Sidetone Source", max98090_dsts_enum),

DAPM.

> +       SOC_SINGLE_EXT_TLV("Digital Sidetone Level Volume",
> +               M98090_REG_1A_LVL_SIDETONE, M98090_DVST_SHIFT,
> +               M98090_DVST_NUM - 1, 1, max98090_get_enab_tlv,
> +               max98090_put_enab_tlv, max98090_micboost_tlv),

Level Volume?

> +       SOC_SINGLE_TLV("Digital Gain Volume", M98090_REG_27_DAI_LVL,
> +               M98090_DAI_LVL_DVG_SHIFT, M98090_DAI_LVL_DVG_NUM - 1, 0,
> +               max98090_dvg_tlv),

Gain Volume?

> +       SOC_SINGLE("Digital EQ 3 Band Enable", M98090_REG_41_DSP_EQ_EN,
> +               M98090_EQ3BANDEN_SHIFT, M98090_EQ3BANDEN_NUM - 1, 0),

Switch.

> +       SOC_SINGLE("DAC HP Playback Performance Mode", M98090_REG_43_DAC_CFG,
> +               M98090_DAC_PERFMODE_SHIFT, M98090_DAC_PERFMODE_NUM - 1, 0),
> +       SOC_SINGLE("DAC High Performance Mode", M98090_REG_43_DAC_CFG,
> +               M98090_DACHP_SHIFT, M98090_DACHP_NUM - 1, 0),

These should either be enumerations with real names of Switches if it's
just an on/off (looks like the former).

> +       SOC_SINGLE_TLV("Headphone Left Volume", M98090_REG_2C_LVL_HP_LEFT,
> +               M98090_HPVOLL_SHIFT, M98090_HPVOLL_NUM - 1, 0,
> +               max98090_hp_tlv),
> +       SOC_SINGLE_TLV("Headphone Right Volume", M98090_REG_2D_LVL_HP_RIGHT,
> +               M98090_HPVOLR_SHIFT, M98090_HPVOLR_NUM - 1, 0,
> +               max98090_hp_tlv),

Should be a single stereo control (and similarly for the other output
controls).

> +       SOC_SINGLE("Quick Setup System Clock", M98090_REG_04_QCFG_SYS_CLK,
> +               M98090_CLK_ALL_SHIFT, M98090_CLK_ALL_NUM - 1, 0),

What do these controls do?


> +       if (val >= 1) {
> +               if (w->reg == M98090_REG_10_LVL_MIC1)
> +                       max98090->mic1pre = val - 1; /* Update for volatile */
> +               else
> +                       max98090->mic2pre = val - 1; /* Update for volatile */
> +       }

Use braces consistently within an if statemeent - if you use them for
the outer one use them for the inner one too.

> +static const struct snd_soc_dapm_route max98090_dapm_routes[] = {
> +
> +       {"MIC1 Input", NULL, "MIC1"},
> +       {"MIC2 Input", NULL, "MIC2"},
> +       {"MIC1 Input", NULL, "MICBIAS"},
> +       {"MIC2 Input", NULL, "MICBIAS"},

Unless this chip is *very* unusual I expect the bias is something that's
connected externally and therefore these connections should be being
made by the machine driver.

> +
> +       /* Check for user calculated MI and NI ratios */
> +       for (i = 0; i < ARRAY_SIZE(user_pclk_rates); i++) {
> +               if ((user_pclk_rates[i] == max98090->sysclk) &&
> +                       (user_lrclk_rates[i] == max98090->lrclk)) {
> +                       dev_info(codec->dev,
> +                               "Found user supported PCLK to LRCLK rates\n");
> +                       dev_info(codec->dev, "i %d ni %lld mi %lld\n",
> +                               i, ni_value[i], mi_value[i]);

dev_dbg() would be fine but dev_info() is too loud.

> +/*
> + * This accommodates an inverted logic in the MAX98090 chip
> + * for Bit Clock Invert (BCI). The inverted logic is only seen
> + * for the case of TDM mode. The remaining cases have normal logic.
> + */
> +               if (max98090->tdm_slots > 1) {
> +                       regval ^= M98090_DAI_BCI_MASK;
> +               }

Coding style, the indentation is inconsistent here and no braces for
single line if () statements.

> +               if (max98090->jack_state == M98090_JACK_STATE_HEADSET) {
> +                       /*
> +                        * Set to normal bias level.
> +                        */
> +                       snd_soc_update_bits(codec, M98090_REG_12_MIC_BIAS,
> +                               M98090_MBVSEL_MASK, M98090_MBVSEL_2V4);
> +
> +                       snd_soc_update_bits(codec, M98090_REG_3E_PWR_EN_IN,
> +                               M98090_PWR_MBEN_MASK, M98090_PWR_MBEN_MASK);
> +               }

This looks suspicous, why does the headset state have any bearing here?

> +static int max98090_dai_digital_mute(struct snd_soc_dai *codec_dai, int mute)
> +{
> +       struct snd_soc_codec *codec = codec_dai->codec;
> +       int regval;
> +
> +       dev_info(codec->dev, "max98090_dai_digital_mute\n");

Drop this, it's not conveying any useful information.

> +static void max98090_dmic_switch(struct snd_soc_codec *codec, int state)
> +{

I have no idea what this function is supposed to do...

> +static void max98090_headset_button_event(struct snd_soc_codec *codec)
> +{
> +       dev_info(codec->dev, "max98090_headset_button_event\n");
> +}

Delete this, it doesn't do anything except log.

> +       switch (reg & (M98090_LSNS_MASK | M98090_JKSNS_MASK)) {
> +               case M98090_LSNS_MASK | M98090_JKSNS_MASK:
> +               {
> +                       dev_info(codec->dev, "No Headset Detected\n");
> +
> +                       max98090->jack_state = M98090_JACK_STATE_NO_HEADSET;
> +
> +                       max98090_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +
> +                       snd_soc_dapm_disable_pin(&codec->dapm, "HPL");
> +                       snd_soc_dapm_disable_pin(&codec->dapm, "HPR");
> +                       snd_soc_dapm_force_enable_pin(&codec->dapm, "SPKL");
> +                       snd_soc_dapm_force_enable_pin(&codec->dapm, "SPKR");
> +                       snd_soc_dapm_disable_pin(&codec->dapm, "MIC1");
> +                       snd_soc_dapm_disable_pin(&codec->dapm, "MIC2");
> +                       snd_soc_dapm_force_enable_pin(&codec->dapm, "DMIC1");
> +                       snd_soc_dapm_force_enable_pin(&codec->dapm, "DMIC2");
> +                       max98090_dmic_switch(codec, 1);
> +
> +                       break;
> +               }

This doesn't look obviously sensible...  calling set_bias_level()
outside of DAPM is going to get overridden in pretty short order,
none of the DAPM pin setting looks like a good idea (especially not
forcing on the speakers whenever there's no headset) and there's no DAPM
sync to make any of this take effect.  I'm a bit confused about the
intended effect.  I also can't see any interaction with soc-jack...

What is this code actually intended to do?

> +       dev_info(codec->dev, "***** max98090_interrupt *****\n");
> +

There's lots of these noisy, uninformative prints at info level
throughout the driver.

> +       /* Send work to be scheduled */
> +       if (active & M98090_IRQ_CLD_MASK) {
> +               dev_info(codec->dev, "M98090_IRQ_CLD_MASK\n");
> +       }

This doesn't actually schedule anything...

> +       ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_I2C);
> +       if (ret != 0) {
> +               dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
> +               return ret;
> +       }

SND_SOC_REGMAP.

> +       if ( (request_threaded_irq(pdata->irq, NULL,
> +               max98090_interrupt, IRQF_TRIGGER_FALLING,
> +               "max98090_interrupt", codec)) < 0) {
> +               dev_info(codec->dev, "request_irq failed\n");
> +       }
> +       /*
> +        * Clear any old interrupts.

Coding style and it's not terribly helpful to hide the return code from
users.

> +       /* Turn on VCM bandgap reference */
> +       snd_soc_write(codec, M98090_REG_42_BIAS_CNTL,
> +               M98090_VCM_MODE_MASK);

This shouldn't be managed at runtime?

> +/*
> + * Driver revision
> + */
> +#define MAX98090_REVISION                      "0.01.00"

The kernel already has perfectly good versioning.

--PW0Eas8rCkcu1VkF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ3IS7AAoJELSic+t+oim9NSYP+QFAiMI3jIxMhT6h3maCDHLD
pPWKdSjcGDJF4BYLUp2cMFHyxbhKetKE8k4PsntgvA7NDD09j4GjYXEAYNsOJbnZ
71+7Kum1TC9FlE02O9vhgGOAg0XXutPLMav0ek3HfG/h/l/Zi/EyyApfAFYWLz3f
BVnNPeI+BReql4efFWPxUmUGvV5Wmpb4Sm4AeOrL+ZnNodzl/x1wMeLU9AZ7sFGH
VtuhjVWGZEyDeHXjAPEA5IIXOvXgrpWQJRYPXgYTVWbISyTFEc5D7Q1Fr5KXlWZV
dpjDxq5Dx/AJE3zt9ZrOLHziy84wMSdaQzst5JRfnwCLHlHXYiusDB7/BAtXOCxO
YtP/GHqm35J2KC7WD3DQBfXTeYmWm+TaSSEcW699gRnHiNWRRXDnhtekVrN0HlF3
RcfXcHOoodSSZCJf01B35SkAdLtbGYzHGYe9YXVNNbezwSEcZ1dKyK6LQkmD/dwe
ZNZIy3czGYCkZNdYI8XkQqDORHLEyNAizwQ1iRz1tF2XMqZRRxt7nintmdc1If7X
MbAi7xqnranFBXu+gTnSSegIMgX+bi2UZpxSf08HuFORpBSiZg08IFoTlNKwJLiy
vc9/wC1AoXPHm7LKbT1MhYYunAoiiWlBzGFDakcBUWhRsnEkwRZWrwKQEBu8efkX
dWp2xw11A26RT56bSwop
=wtho
-----END PGP SIGNATURE-----

--PW0Eas8rCkcu1VkF--

--===============7422473392289375814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7422473392289375814==--
