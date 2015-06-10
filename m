From: anish kumar <yesanishhere@gmail.com>
Subject: Re: [PATCH] ASoC: Add max98926 codec driver
Date: Wed, 10 Jun 2015 15:17:55 -0700
Message-ID: <CABCoZhD4OzHDzAZuhHSG0b5jKkDNXZhsNQmViWoqHRRFGSFE9Q@mail.gmail.com>
References: <1432931525-24193-1-git-send-email-yesanishhere@gmail.com>
 <20150602203005.GT14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f194.google.com (mail-lb0-f194.google.com
 [209.85.217.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A76E260442
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 00:17:56 +0200 (CEST)
Received: by lbdu14 with SMTP id u14so6361278lbd.2
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 15:17:55 -0700 (PDT)
In-Reply-To: <20150602203005.GT14071@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Nitin Mittal <nitin.mittal@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 2, 2015 at 1:30 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, May 29, 2015 at 01:32:05PM -0700, Anish Kumar wrote:
>

Commented in the places where i have either
doubt or want to respond. Other changes will
be incorporated in next patch.

> This looks mostly good, there's a few things below but they're mostly
> pretty small and should be easy to update.
>
>> +static const char *const max98926_hpf_cutoff_txt[] = {
>> +     "hpf_disable", "hpf_dc_block", "hpf_enable_100",
>> +     "hpf_enable_200", "hpf_enable_400", "hpf_enable_800",
>> +};
>
> Please write these like other ALSA controls write user visible strings -
> "Disable", "DC Block", "100Hz" and so on.
>
>> +static const char *const max98926_input_txt[] = {
>> +     "Pcm", "Analog",
>> +};
>
> PCM.
>
>> +static struct reg_default max98926_reg[] = {
>> +     { 0x00, 0x00 }, /* Battery Voltage Data */
>> +     { 0x01, 0x00 }, /* Boost Voltage Data */
>> +     { 0x02, 0x00 }, /* Live Status0 */
>> +     { 0x03, 0x00 }, /* Live Status1 */
>> +     { 0x04, 0x00 }, /* Live Status2 */
>
> These and some of the other registers sound like volatile registers
> which shouldn't have defaults since they shouldn't be in the cache at
> all but rather read from the device - and you do in fact have a function
> marking them as volatile further down.
>
>> +static int max98926_dac_event(struct snd_soc_dapm_widget *w,
>> +             struct snd_kcontrol *kcontrol, int event)
>> +{
>> +     struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
>> +     struct max98926_priv *max98926 = snd_soc_codec_get_drvdata(codec);
>> +
>> +     switch (event) {
>> +     case SND_SOC_DAPM_PRE_PMU:
>> +             regmap_update_bits(max98926->regmap,
>> +                     MAX98926_BLOCK_ENABLE, MAX98926_BST_EN_MASK |
>> +                     MAX98926_ADC_IMON_EN_MASK |
>> +                     MAX98926_ADC_VMON_EN_MASK,
>> +                     MAX98926_BST_EN_MASK |
>> +                     MAX98926_ADC_IMON_EN_MASK |
>> +                     MAX98926_ADC_VMON_EN_MASK);
>> +             break;
>
> Why not just use DAPM widgets for these?  BST looks like a boost
> amplifier so should probably be a PGA, IMON and VMON can probably be
> represented usefully as supplies (or could be PGAs routed through when
> recording the signal, presumably users could save a little power by not
> enabling the monitoring if they don't care for some reason).

BST will be PGA widget. I will represent
I/VMON as supplies.
>
>> +static int pdm_ch_zero;
>> +static int pdm_ch_one;
>
> No global variables, store any state you need in driver data.
>
>> +                     MAX98926_PDM_CHANNEL_1_MASK);
>> +     }
>> +     switch (source) {
>
> Coding style: blank line between blocks.
>
>> +     case 0:
>> +             /* enable current */
>> +             regmap_update_bits(max98926->regmap,
>> +                     reg, MAX98926_PDM_CURRENT_MASK,
>> +                     MAX98926_PDM_CURRENT_MASK);
>> +             /* enable source*/
>> +             if (channel == 0)
>> +                     regmap_update_bits(max98926->regmap,
>> +                             reg, MAX98926_PDM_SOURCE_0_MASK,
>> +                             MAX98926_PDM_SOURCE_0_MASK);
>> +             else
>> +                     regmap_update_bits(max98926->regmap,
>> +                             reg, MAX98926_PDM_SOURCE_1_MASK,
>> +                             MAX98926_PDM_SOURCE_1_MASK);
>> +             break;
>> +     case 1:
>> +             /* enable voltage */
>> +             regmap_update_bits(max98926->regmap,
>> +                     reg, MAX98926_PDM_VOLTAGE_MASK,
>> +                     MAX98926_PDM_VOLTAGE_MASK);
>> +             /* enable source*/
>> +             if (channel == 0)
>> +                     regmap_update_bits(max98926->regmap,
>> +                             reg, MAX98926_PDM_SOURCE_0_MASK, 0);
>> +             else
>> +                     regmap_update_bits(max98926->regmap,
>> +                             reg, MAX98926_PDM_SOURCE_1_MASK, 0);
>> +             break;
>
> This seems a bit magic numberish (what are 0 and 1 here?).

answer below
>
>> +static const struct soc_enum max98926_global_enum[] = {
>> +     SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(pdm_text), pdm_text),
>> +};
>
> Not sure what this control is supposed to do?

answer below
>
>> +     SOC_ENUM("Input Sel", max98926_input_sel),
>> +     SOC_ENUM("DAI Input Sel", max98926_dai_input_sel),
>
> These look like DAPM controls?

'Input Sel' is basically as below:
DAC Input Select
Selects the left, right or mix of left + right as the DAC input signal.
00 = Left DAI input (default)
01 = Right DAI input
10 = Left + Right
11 = Left/2 + Right/2
So i think it is best that it is not part
of dapm.

'DAI Input Sel' is the input to the power amplifier.
98926 amplifier can take PCM input from I2S
or can take analog signal. So we need to set
this as control.

>
>> +     SOC_ENUM_EXT("PDM CH0 Enable", max98926_global_enum[0],
>> +             max98926_get_pdm_ch_zero, max98926_put_pdm_ch_zero),
>> +     SOC_ENUM_EXT("PDM CH1 Enable", max98926_global_enum[0],
>> +             max98926_get_pdm_ch_one, max98926_put_pdm_ch_one),

We can get vi feedback in two channels. Customer
can enable either channel 0 or channel 1. Channel 0
source can be voltage or current. So basically i created
kcontrol for that so that we can either enable channel 0, 1
or both.

'PDM CH0 Enable' 1 causes channel 0 to be enabled
for current. So i enable all the relevant bit in put callback.
>
> There's two different controls mapping to one element of an array?
>
>> +static void max98926_set_sense_data(struct max98926_priv *max98926)
>> +{
>> +     if (max98926->intrleave_mode) {
>
> interleave.
>
>> +     switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>> +     case SND_SOC_DAIFMT_CBS_CFS:
>> +             max98926_set_sense_data(max98926);
>> +             break;
>> +     case SND_SOC_DAIFMT_CBM_CFM:
>> +     case SND_SOC_DAIFMT_CBS_CFM:
>> +     case SND_SOC_DAIFMT_CBM_CFS:
>> +     default:
>> +             dev_err(codec->dev, "DAI clock mode unsupported");
>> +             return -EINVAL;
>
> No need to list all the formats you don't support.
>
>> +     }
>> +
>> +     switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>> +     case SND_SOC_DAIFMT_I2S:
>> +     case SND_SOC_DAIFMT_LEFT_J:
>> +             break;
>
> I'm not seeing anything that handles these diffeerently, they are
> different formats so you should only list whichever one is actually
> supported.
>
>> +     default:
>> +             dev_dbg(codec->dev, "format unsupported %d",
>> +                             params_format(params));
>> +             return -EINVAL;
>> +     }
>> +     return max98926_set_clock(max98926, params);
>
> May as well just inline set_clock() here - this appears to be the only
> place it's used.
>
>> +static int max98926_dai_set_sysclk(struct snd_soc_dai *dai,
>> +                                int clk_id, unsigned int freq, int dir)
>> +{
>> +     struct snd_soc_codec *codec = dai->codec;
>> +     struct max98926_priv *max98926 = snd_soc_codec_get_drvdata(codec);
>> +
>> +     max98926->sysclk = freq;
>> +     return 0;
>> +}
>
> You had error checking on sysclk in hw_params(), it'd bet better to do
> that here too so people can tell they set a bad clock before they start
> a stream.
>
>> +     ret = regmap_read(max98926->regmap,
>> +                     MAX98926_VERSION, &reg);
>> +     if ((ret < 0) ||
>> +             ((reg != MAX98926_CHIP_VERSION) &&
>> +             (reg != MAX98926_CHIP_VERSION1))) {
>> +             dev_err(codec->dev, "Failed to read: %x\n", reg);
>> +             return -EINVAL;
>> +     }
>
> You should do this check in the I2C level probe.  The error message is
> also wrong if the register does read but isn't what we expected.
>
> Are you *sure* no new revisions of the device will be made?
yes will remove the revision check as we have
few revisions planned.
>
>> +     /* It's not the default but we need to set DAI_DLY */
>> +     regmap_write(max98926->regmap,
>> +                     MAX98926_FORMAT, MAX98926_DAI_DLY_MASK);
>
> Sounds like this might be the I2S vs left justified configuration?

basically it is dai data delay. Setting this way causes
the MSB to be valid on second active edge after LRCLK
event.
