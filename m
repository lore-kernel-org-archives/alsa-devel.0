From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add support for TI LM49453 Audio
	codec
Date: Tue, 3 Jan 2012 21:17:49 +0000
Message-ID: <20120103211748.GA6832@opensource.wolfsonmicro.com>
References: <290463D19D2E064191F1F96ECA480A89434A67486B@EXMAIL02.scwf.nsc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3F278103815
	for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2012 22:17:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <290463D19D2E064191F1F96ECA480A89434A67486B@EXMAIL02.scwf.nsc.com>
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

On Tue, Jan 03, 2012 at 05:35:26AM -0800, Reddy, MR Swami wrote:

> ASoC: Add support for TI LM49453 Audio codec.

So, overall there's quite a few issues here.  Many of them are fairly
minor but there's a few big ones.  The biggest issue is that this code
won't compile, you need to submit code against development versions of
the kernel.

There's also quite a few errors with the use of snd_soc_update_bits()
that make me wonder how well tested this code is.

> +/* Register default values for LM49453 driver. */
> +static const u8 lm49453_reg_defs[LM49453_MAX_REGISTER + 1] = {
> +       [0x60] = 0x01,
> +       [0x67] = 0x01,

This (and pretty much all I2C/SPI devices) really should be using regmap
directly - the register map is pretty sparse so it would benefit from
the rbtree cache.

> +struct lm49453_priv {
> +       enum snd_soc_control_type control_type;

Not needed since you only support I2C.

> +static const struct snd_kcontrol_new lm49453_headset_left_mixer[] = {
> +SOC_DAPM_SINGLE("Port1_1 HPL", LM49453_P0_DACHPL1_REG, 0, 1, 0),

These should all have " Switch" at the end of the name so the UIs know
how to handle them (similarly for all your other mixer controls).

> +static const struct snd_kcontrol_new lm49453_snd_controls[] = {
> +       SOC_ENUM("Mic2Mode Capture Route", lm49453_mic2mode_enum),
> +       SOC_ENUM("DMIC12 Capture Route", lm49453_dmic12_cfg_enum),
> +       SOC_ENUM("DMIC34 Capture Route", lm49453_dmic34_cfg_enum),

These three look like they should be DAPM?

> +       SOC_SINGLE_TLV("Mic1 Capture Volume", LM49453_P0_ADC_LEVELL_REG,
> +                       0, 6, 0, digital_tlv),
> +       SOC_SINGLE_TLV("Mic2 Capture Volume", LM49453_P0_ADC_LEVELR_REG,
> +                       0, 6, 0, digital_tlv),

The register names suggest that these are really just left and right
channels on the ADC, do they really only affect the microphone paths?

> +       SOC_SINGLE_TLV("PORT1_1_RX_LVL", LM49453_P0_PORT1_RX_LVL1_REG,
> +                       0, 3, 0, port_tlv),

All these should have Volume at the end of their name so that UIs know
how to display them.

> +       SOC_SINGLE_TLV("Sidetone ADCL Volume", LM49453_P0_STN_VOL_ADCL_REG,
> +                       0, 0x3F, 0, digital_tlv),
> +       SOC_SINGLE_TLV("Sidetone ADCR Volume", LM49453_P0_STN_VOL_ADCR_REG,
> +                       0, 0x3F, 0, digital_tlv),

These sidetone controls all look like they could be combined into stereo
controls - is there a pressing reason why are they done as mono?  If
there is a comment would probably help.

> +       SND_SOC_DAPM_INPUT("PORT1_1_RX"),
> +       SND_SOC_DAPM_INPUT("PORT1_2_RX"),
> +       SND_SOC_DAPM_INPUT("PORT1_3_RX"),
> +       SND_SOC_DAPM_INPUT("PORT1_4_RX"),
> +       SND_SOC_DAPM_INPUT("PORT1_5_RX"),
> +       SND_SOC_DAPM_INPUT("PORT1_6_RX"),
> +       SND_SOC_DAPM_INPUT("PORT1_7_RX"),
> +       SND_SOC_DAPM_INPUT("PORT1_8_RX"),
> +       SND_SOC_DAPM_INPUT("PORT2_1_RX"),
> +       SND_SOC_DAPM_INPUT("PORT2_2_RX"),

INPUT widgets should generally be line inputs...  looking at the DAPM
routes these are actually digital widgets floating inside the CODEC.
It's not clear why they're represented though as they don't have any
control associated with them.  If you just need widgets to make the
routing easier then use PGAs, Inputs get treated specially in power
control and are likely to confuse things.

> +       SND_SOC_DAPM_MICBIAS("AMIC1Bias", LM49453_P0_MICL_REG, 6, 0),
> +       SND_SOC_DAPM_MICBIAS("AMIC2Bias", LM49453_P0_MICR_REG, 6, 0),

Don't use MICBIAS widgets, use SUPPLY widgets - MICBIAS widgets will
(eventually) be phased out as SUPPLY widgets do the same job but are
easier to use in machine drivers.

> +       SND_SOC_DAPM_SUPPLY("DMIC1supply", SND_SOC_NOPM, 0, 0, NULL, 0),
> +       SND_SOC_DAPM_SUPPLY("DMIC2supply", SND_SOC_NOPM, 0, 0, NULL, 0),
> +
> +       SND_SOC_DAPM_SUPPLY("Headset Rail", SND_SOC_NOPM, 0, 0, NULL, 0),
> +       SND_SOC_DAPM_SUPPLY("Speaker Rail", SND_SOC_NOPM, 0, 0, NULL, 0),
> +       SND_SOC_DAPM_SUPPLY("Earpiece Rail", SND_SOC_NOPM, 0, 0, NULL, 0),
> +       SND_SOC_DAPM_SUPPLY("Haptic Rail", SND_SOC_NOPM, 0, 0, NULL, 0),

None of these widgets will do anything, they don't have any power bits or
callbacks associated with them so won't do anything.  Just delete them.

> +       /* Port1 TX controls */
> +       SND_SOC_DAPM_OUT_DRV("P1_1_TX", SND_SOC_NOPM, 0, 0, NULL, 0),
> +       SND_SOC_DAPM_OUT_DRV("P1_2_TX", SND_SOC_NOPM, 0, 0, NULL, 0),
> +       SND_SOC_DAPM_OUT_DRV("P1_3_TX", SND_SOC_NOPM, 0, 0, NULL, 0),
> +       SND_SOC_DAPM_OUT_DRV("P1_4_TX", SND_SOC_NOPM, 0, 0, NULL, 0),
> +       SND_SOC_DAPM_OUT_DRV("P1_5_TX", SND_SOC_NOPM, 0, 0, NULL, 0),
> +       SND_SOC_DAPM_OUT_DRV("P1_6_TX", SND_SOC_NOPM, 0, 0, NULL, 0),
> +       SND_SOC_DAPM_OUT_DRV("P1_7_TX", SND_SOC_NOPM, 0, 0, NULL, 0),
> +       SND_SOC_DAPM_OUT_DRV("P1_8_TX", SND_SOC_NOPM, 0, 0, NULL, 0),
> +
> +       /* Port2 TX controls */
> +       SND_SOC_DAPM_OUT_DRV("P2_1_TX", SND_SOC_NOPM, 0, 0, NULL, 0),
> +       SND_SOC_DAPM_OUT_DRV("P2_2_TX", SND_SOC_NOPM, 0, 0, NULL, 0),
> +
> +       SND_SOC_DAPM_MIXER("Port1 Playback", LM49453_P0_AUDIO_PORT1_BASIC_REG,
> +                           0, 0, NULL, 0),
> +       SND_SOC_DAPM_MIXER("Port2 Playback", LM49453_P0_AUDIO_PORT2_BASIC_REG,
> +                           0, 0, NULL, 0),

Similar issues to the capture versions of these apply here.

> +       /* Sidetone controls */
> +       SND_SOC_DAPM_OUT_DRV("Sidetone DAC HPL Playback",
> +                             LM49453_P0_STN_SEL_REG, 0, 0, NULL, 0),
> +       SND_SOC_DAPM_OUT_DRV("Sidetone DAC HPR Playback",
> +                             LM49453_P0_STN_SEL_REG, 1, 0, NULL, 0),

What exactly do these register bits do?  The use of OUT_DRV widgets
looks very suspicious for a sidetone, an output driver would usually be
a power amplifier or transducer driver so I suspect the power sequencing
will be all wrong.  It looks like these are mixer input controls which
wouldn't normally be widgets at all.

> +       { "Port1_8 Mixer", NULL, "PORT1_8_RX_LVL" },
> +       { "Port1_8 Mixer", NULL, "ADC Left" },
> +       { "Port1_8 Mixer", NULL, "ADC Right" },
> +       { "Port1_8 Mixer", NULL, "DMIC1 Left" },
> +       { "Port1_8 Mixer", NULL, "DMIC1 Right" },
> +       { "Port1_8 Mixer", NULL, "DMIC2 Left" },
> +       { "Port1_8 Mixer", NULL, "DMIC2 Right" },

All this looks pretty odd, do the mixers really have no control over
their inputs and just mix every possible input in?

> +       { "AMIC1Bias", NULL, "AMIC1"},
> +       { "Mic1_Input Capture Route", "MIC1", "AMIC1Bias"},

Your CODEC driver should not be connecting the microphone biases, the
connections are board specific.

> +/* PLL P Values array */
> +int pll_p[] = { 143, /* For 8 fs p val */
> +               123, /* For 11.2 fs  p val*/
> +               71, /* For 16 fs p val*/
> +               61, /* For 22.1 fs  p val*/
> +               47, /* For 24 fs  p val*/
> +               35, /* For 32 fs  p val*/
> +               30, /* For 44.1 fs  p val*/
> +               23, /* For 48 fs  p val*/
> +               23  /* For 96fs  p val*/
> +};

> +       switch (lm49453->fs_rate) {
> +       case 8000:
> +               pll_div->p1 = pll_p[0];
> +               break;

Eew, no.  Why are you indexing into the table with magic numbers from a
switch statement to assign constants?  That's not not really legible.
Either put the frequencies into the table and look up in the table or
put the constants directly into the switch statement.

> +static int lm49453_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
> +                              int source, unsigned int freq_in,
> +                              unsigned int freq_out)
> +{
> +       struct snd_soc_codec *codec = codec_dai->codec;
> +       struct lm49453_priv *lm49453 = snd_soc_codec_get_drvdata(codec);
> +       struct pll_state *state;
> +       struct _pll_div pll_div;
> +       unsigned int pwr_mask;
> +       int ret;
> +
> +       memset(&pll_div, 0, sizeof(pll_div));

That memset is just going to mask warnings, it shouldn't be needed.

> +       /* Setting DAC clock dividers based on substream sample rate. */
> +       switch (lm49453->fs_rate) {
> +       case 8000:
> +       case 16000:
> +       case 32000:
> +       case 24000:
> +       case 48000:
> +               val = 256;
> +               break;
> +       case 11025:
> +       case 22050:
> +       case 44100:
> +               val = 216;
> +               break;
> +       case 96000:
> +               val = 127;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }

val really isn't a meaningful variable name...

> +       snd_soc_write(codec, LM49453_P0_ADC_CLK_DIV_REG, val);
> +       snd_soc_write(codec, LM49453_P0_DAC_OT_CLK_DIV_REG, val);
> +       snd_soc_write(codec, LM49453_P0_DAC_HP_CLK_DIV_REG, val);

...and frankly I've no idea what this code is doing, I'd expect a clock
divider configuration to vary depending on the input clock as well as
the sample rate.

> +       switch (lm49453->sysclk) {
> +       case 12288000:
> +       case 26000000:
> +       case 19000000:
> +               val = 0;
> +               break;
> +       case 48000:
> +       case 32576:
> +               val = 1;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG, BIT(4), val);

I don't think this does what you think it does, your mask and value
don't overlap at all.  Have you tested?  The whole thing looks very
suspicous, running audio directly off a 32.768kHz clock would be
unusual.  I rather suspect this ought not to be done in hw_params() at
all but instead should be in set_sysclk().

> +static int lm49453_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
> +                                 int div_id, int div)
> +{
> +       struct snd_soc_codec *codec = codec_dai->codec;
> +
> +       switch (div_id) {
> +       case LM49453_PMC_CLK_DIV:
> +               snd_soc_write(codec, LM49453_P0_PMC_CLK_DIV_REG, div);
> +               break;
> +       case LM49453_HSDET_CLK_DIV:
> +               snd_soc_write(codec, LM49453_P0_HSDET_CLK_DIV_REG, div);
> +               break;
> +       case LM49453_DMIC_CLK_DIV:
> +               snd_soc_write(codec, LM49453_P0_DMIC_CLK_DIV_REG, div);
> +               break;
> +       case LM49453_ADC_CLK_DIV:
> +               snd_soc_write(codec, LM49453_P0_ADC_CLK_DIV_REG, div);
> +               break;
> +       case LM49453_DAC_CLK_DIV:
> +               snd_soc_write(codec, LM49453_P0_DAC_OT_CLK_DIV_REG, div);
> +               break;

Again, not overburned with documentation here but I rather suspect that
the driver ought to be able to figure out how to configure most of these
dividers by itself given the SYSCLK and current sample rate.

> +       switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +       case SND_SOC_DAIFMT_CBS_CFS:
> +               aif_val = !(LM49453_P0_AUDIO_PORT1_BASIC_FMT_BIT);
> +               break;

Use ~ if that's what you mean, though frankly I'm just guessing.

> +       case SND_SOC_DAIFMT_CBS_CFM:
> +               aif_val = LM49453_P0_AUDIO_PORT1_BASIC_FMT_BIT;
> +               break;
> +       case SND_SOC_DAIFMT_CBM_CFS:
> +               aif_val = ~LM49453_P0_AUDIO_PORT1_BASIC_FMT_BIT;
> +               break;
> +       case SND_SOC_DAIFMT_CBM_CFM:
> +               aif_val = LM49453_P0_AUDIO_PORT1_BASIC_FMT_BIT;
> +               break;

You appear to be setting the same setting the same register value for
CBS_CFM as for CBM_CFM.  Are you sure the device can support all these
clocking modes?

> +       snd_soc_update_bits(codec, LM49453_P0_AUDIO_PORT1_BASIC_REG,
> +                           aif_val, aif_val);

Another error with update_bits().

> +static int lm49453_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
> +                                 unsigned int freq, int dir)
> +{
> +       struct snd_soc_codec *codec = dai->codec;
> +       struct lm49453_priv *lm49453 = snd_soc_codec_get_drvdata(codec);
> +
> +       switch (freq) {
> +       case 12288000:  /* Platform System Clock */
> +       case 26000000:  /* 26 MHz */
> +       case 19200000:  /* 19.2 MHz */
> +       case 48000:     /* 48 KHz */
> +       case 32576:     /* 32.576 KHz */

The first comment is specific to your board, the others are blindingly
obvious - I'd suggest removing them all.

> +               lm49453->sysclk = freq;
> +               return 0;
> +       }
> +       return -EINVAL;

Move this into the default: in the switch for legibility.

> +static int lm49453_startup(struct snd_pcm_substream *substream,
> +                          struct snd_soc_dai *codec_dai)
> +{
> +       unsigned int startup_mask;
> +       struct snd_soc_codec *codec = codec_dai->codec;
> +       dev_dbg(codec->dev, "lm49453_startup\n");
> +
> +       startup_mask = LM49453_P0_PMC_SETUP_CHIP_EN |
> +                      LM49453_P0_PMC_SETUP_PLL_EN;
> +       snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG, startup_mask,
> +                           startup_mask);

CHIP_EN should be handled by DAPM or set_bias_level(), PLL_EN looks like
it should be done by set_pll() but possibly also by DAPM.

> +static int lm49453_hp_mute(struct snd_soc_dai *dai, int mute)
> +{
> +       snd_soc_update_bits(dai->codec, LM49453_P0_DAC_DSP_REG, BIT(0),
> +                           (!!mute << 0));
> +       snd_soc_update_bits(dai->codec, LM49453_P0_DAC_DSP_REG, BIT(1),
> +                           (!!mute << 1));

Why are there two separate update bits operations here?

> +       case SND_SOC_BIAS_STANDBY:
> +               if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
> +                       /* Power up with Headset active */

Why are you doing this?  DAPM should be taking care of enabling
outputs...

> +                       reg = snd_soc_read(codec, LM49453_P0_PMC_SETUP_REG);
> +                       reg &= ~(LM49453_P0_PMC_SETUP_CHIP_EN);
> +                       snd_soc_write(codec, LM49453_P0_PMC_SETUP_REG, reg);
> +               }

Use _update_bits().

> +       case SND_SOC_BIAS_OFF:
> +               reg = snd_soc_read(codec, LM49453_P0_PMC_SETUP_REG);
> +               snd_soc_write(codec, LM49453_P0_PMC_SETUP_REG,
> +                             (reg | LM49453_P0_PMC_SETUP_CHIP_EN));

_update_bits() if this should be here at all.

> +               break;
> +               }

Indentation.

> +int lm49453_headset_detected(struct snd_soc_codec *codec)
> +{
> +       u8 val = 0;
> +       val = snd_soc_read(codec, LM49453_P0_HSD_IRQ1_REG);
> +       return (val >> 6) & 1;
> +}
> +EXPORT_SYMBOL_GPL(lm49453_headset_detected);

Don't invent your own API for accessory detection - use the standard
mechanisms we've got for reporting events.

> +static int lm49453_probe(struct snd_soc_codec *codec)
> +{
> +       int ret = 0;
> +       int reg;
> +
> +       codec->dapm.idle_bias_off = 1;

Set this in the snd_soc_codec_driver structure.

> +       .reg_word_size = sizeof(u8),
> +       .reg_cache_default = lm49453_reg_defs,
> +       .compress_type = SND_SOC_RBTREE_COMPRESSION,

This won't compile with current kernels, advanced cache types are no
longer supported in ASoC.  You should use regmap directly.

> +#define LM49453_CLKSRC_MCLK                    1
> +#define LM49453_CLKSRC_PLL_1                   2
> +#define LM49453_CLKSRC_PLL_2                   3
> +#define LM49453_CLKSRC_PORT1_RX                        4
> +#define LM49453_CLKSRC_PORT2_RX                        5
> +#define LM49453_CLKSRC_DAC_HP                  6
> +#define LM49453_CLKSRC_DAC_OT                  7

At no point are any of these referenced in the code...

> +#define LM49453_CLKSRC_ADC                     12
> +#define LM49453_CLKSRC_DMIC1                   13
> +#define LM49453_CLKSRC_DMIC2                   14

Really?

> +/* Clock divider Id's */

' shouldn't be used for plurals.
