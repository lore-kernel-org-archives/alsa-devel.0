From: Ryan Lee <ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v3] ASoC: Add support for Maxim Integrated MAX98927 Amplifier
Date: Thu, 30 Mar 2017 18:18:40 -0700
Message-ID: <CAN4-ojkra_iMUVUjFZM50XT6kdpk_SwoW=9tj0+m781+Qs9Kqw@mail.gmail.com>
References: <1490748828-31701-1-git-send-email-ryans.lee@maximintegrated.com> <20170329142304.qovnyqd6izackny2@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170329142304.qovnyqd6izackny2-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, nh6z-fFIq/eER6g8@public.gmane.org, KCHSU0-KrzQf0k3Iz9BDgjK7y7TUQ@public.gmane.org, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dylan Reid <dgreid-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 29, 2017 at 7:23 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Mar 29, 2017 at 09:53:48AM +0900, Ryan Lee wrote:
>
>> +     case SND_SOC_DAIFMT_CBS_CFM:
>> +             mode = MAX98927_PCM_MASTER_MODE_HYBRID;
>> +     default:
>> +             dev_err(codec->dev, "DAI clock mode unsupported");
>
> Either we don't support _CBS_CFM or there's a missing break there.

This was removed since CVS_CFM is not supported.

>
>> +     switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>> +     case SND_SOC_DAIFMT_I2S:
>> +             max98927->iface |= SND_SOC_DAIFMT_I2S;
>> +
>> +     break;
>
> Please use the kernel coding style as you do in the rest of this
> function.

Modified as requested.

>
>> +     int reg = MAX98927_R0022_PCM_CLK_SETUP;
>> +     int mask = MAX98927_PCM_CLK_SETUP_BSEL_MASK;
>
>> +     regmap_update_bits(max98927->regmap, reg, mask, value);
>
> reg and mask have exactly one user (as you'd expect), just use the
> constants directly here to make things clearer.

Removed reg and mask.

>
>> +     switch (snd_pcm_format_width(params_format(params))) {
>> +     case 16:
>> +             chan_sz = MAX98927_PCM_MODE_CFG_CHANSZ_16;
>> +             max98927->ch_size = 16;
>
> You could just assign ch_size directly.

Sorry I don't fully understand this.
Anyway 'ch_size' will be directly updated from snd_pcm_format_width
information after modification.

>
>> +     /* sampling rate configuration */
>> +     switch (params_rate(params)) {
>> +     case 8000:
>> +             sampling_rate |= MAX98927_PCM_SR_SET1_SR_8000;
>
> sampling_rate is only ever set to a real value in this switch statement,
> you're not oring with anything else so you can just use an assignment
> which would be a lot clearer (it's not obvious what else might go in
> there) and the initial assignment to 0 for this and chan_sz can only
> mask errors.

Removed 'oring'.

>
>> +     /* set sampling rate of IV */
>> +     if (max98927->interleave_mode &&
>> +             sampling_rate > MAX98927_PCM_SR_SET1_SR_16000)
>> +             regmap_update_bits(max98927->regmap,
>
> Please use the kernel coding style, indent the second line of the if
> with the ( so that it doesn't look like part of the conditional code.

Modified as requested.

>
>> +     switch (reg) {
>> +     case MAX98927_R0001_INT_RAW1 ... MAX98927_R0028_ICC_RX_EN_B:
>
>
>> +             return true;
>> +     }
>> +     return false;
>
> It'd be clearer to put the return false in the switch statement like the
> return true, and also consistent with the _volatile_reg() function.

Modified as requested.

>
>> +static const char * const max98927_speaker_source_text[] = {
>> +     "i2s", "reserved", "tone", "pdm"
>> +};
>
> This looks like it should be a DAPM control.

Removed this and added it to 'dai_set_format' function.

>
>> +static const char * const max98927_monomix_output_text[] = {
>> +     "ch_0", "ch_1", "ch_1_2_div"
>> +};
>
> Similarly here.

Removed this since it was already added to DAPM control.

>
>> +     SOC_SINGLE_TLV("Digital Gain", MAX98927_R0036_AMP_VOL_CTRL,
>> +             0, (1<<MAX98927_AMP_VOL_WIDTH)-1, 0,
>> +             max98927_digital_tlv),
>
> All volume controls should end with Volume as per control-names.rst.

Modified as requested.

>
>> +     SOC_SINGLE("Amp DSP Enable", MAX98927_R0052_BROWNOUT_EN,
>> +             MAX98927_BROWNOUT_DSP_SHIFT, 1, 0),
>
> All on/off switches should end with Switch as per control-names.rst.

Modified as requested.

>
>> +static int max98927_probe(struct snd_soc_codec *codec)
>> +{
>
>> +       /* Check Revision ID */
>> +       ret = regmap_read(max98927->regmap,
>> +               MAX98927_R01FF_REV_ID, &reg);
>
> Basic device identification and setup should be done at the chip level
> probe not at the CODEC level so that if there are problems we fail as
> early as possible and so that diagnostic information is available to
> users as soon as possible, even if there's no sound card for the device
> in the system.

Moved to i2c_probe function.

>
>> +     /* Set inital volume (+13dB) */
>
> As with all other CODEC drivers you should leave the hardware defaults
> alone, what makes sense for your system may not make sense for other
> systems and the hardware defaults are a fixed thing.

We recommend to use static +13dB gain when our speaker protection
algorithm is running on DSP. It is not hardware default but mostly
+13dB is being used as default.

>
>> +     /* Boost Output Voltage & Current limit */
>> +     regmap_write(max98927->regmap,
>> +             MAX98927_R0040_BOOST_CTRL0,
>> +             0x1C);
>> +     regmap_write(max98927->regmap,
>> +             MAX98927_R0042_BOOST_CTRL1,
>> +             0x3E);
>
> This should be system specific, these values might be unsafe in some
> systems.

Same as above, most user will use maximum voltage & current limit
value to take advantage of 10V boost amplifier.
I added one more control to change the current limit value.

>
>> +err:
>> +     if (max98927)
>> +             devm_kfree(&i2c->dev, max98927);
>
> There is no need to explicitly free devm_ allocated memory, that's the
> point of devm.

Removed the code.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
