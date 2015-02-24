From: anish <yesanishhere@gmail.com>
Subject: Re: [PATCH] ASoC: Add max98925 codec driver
Date: Tue, 24 Feb 2015 09:56:02 -0800
Message-ID: <CABCoZhDzC+7Pt7HtFd8PRZKth85mG9WJUSRkjQLA=BOv-zuPFw@mail.gmail.com>
References: <1424318986-18895-1-git-send-email-yesanishhere@gmail.com>
 <20150224090348.GD6236@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f49.google.com (mail-la0-f49.google.com
 [209.85.215.49])
 by alsa0.perex.cz (Postfix) with ESMTP id EC4B22604B1
 for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2015 18:56:02 +0100 (CET)
Received: by labhs14 with SMTP id hs14so4797121lab.4
 for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2015 09:56:02 -0800 (PST)
In-Reply-To: <20150224090348.GD6236@finisterre.sirena.org.uk>
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
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Maxwell McKinnon <Maxwell.McKinnon@maximintegrated.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Nitin Mittal <nitin.mittal@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 24, 2015 at 1:03 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Feb 18, 2015 at 08:09:46PM -0800, Anish Kumar wrote:
>
>> +config SND_SOC_MAX98925
>> +       tristate "Support MAX98925 audio codec"
>> +       depends on I2C
>> +       help
>> +       MAX98925 is a high-efficiency mono
>> +       Class DG audio amplifier. Use this
>> +       option to enable the codec.
>> +
>
> As I said in reply to an earlier version of this patch please format
> this using the normal style for Kconfig entries.
Sorry but i don't understand. I thought i copied the style.
Can you be specific as to the meaning?

>
>> +static const char *const dai_text[] = {
>> +     "left", "right", "leftright", "leftrightdiv2",
>> +};
>> +
>> +static const char *const hpf_text[] = {
>> +     "disable", "dc_block", "100Hz", "200Hz", "400Hz", "800Hz",
>> +};
>
> As I also said in reply to an earlier version please follow the normal
> style for enumeration entries with capitalization, use of spaces and so
> on.

I think the problem is only with "disable" and "dc_block". I will change
it as you said.
>
>> +static struct reg_default max98925_reg[] = {
>> +     { 0x00, 0x00 }, /* Battery Voltage Data */
>> +     { 0x01, 0x00 }, /* Boost Voltage Data */
>> +     { 0x02, 0x00 }, /* Live Status0 */
>> +     { 0x03, 0x00 }, /* Live Status1 */
>> +     { 0x04, 0x00 }, /* Live Status2 */
>
> As I said in reply to a previous version of this patch these seem like
> volatile registers so why do they have defaults defined?

overlooked this.Will remove it.
>
> I'm going to glance through the rest of this but not too closely given
> that a number of issues from the original review appear to remain
> unaddressed and (perhaps more importantly) I'm about to run out of
> batter).
>
>> +static int max98925_reg_put(struct snd_kcontrol *kcontrol,
>> +             struct snd_ctl_elem_value *ucontrol, unsigned int reg,
>> +             unsigned int mask, unsigned int shift)
>> +{
>> +     struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
>> +     struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
>> +     unsigned int sel = ucontrol->value.integer.value[0];
>> +
>> +     regmap_update_bits(max98925->regmap, reg, mask, sel<<shift);
>> +     dev_dbg(codec->dev, "%s: register 0x%02X, value 0x%02X\n",
>> +                             __func__, reg, sel);
>> +     return 0;
>> +}
>
> This looks like a standard control, why is this open coded?  I'd also
> expect some bounds checking on the write.

We wanted mechanism to read/write any register so we used this control.
Is this functionality already available?
>
>> +static int max98925_dac_event(struct snd_soc_dapm_widget *w,
>> +             struct snd_kcontrol *kcontrol, int event)
>> +{
>> +     struct snd_soc_codec *codec = w->codec;
>> +     struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
>> +
>> +     regmap_update_bits(max98925->regmap,
>> +             MAX98925_R036_BLOCK_ENABLE,
>> +             M98925_BST_EN_MASK |
>> +             M98925_ADC_IMON_EN_MASK | M98925_ADC_VMON_EN_MASK,
>> +             M98925_BST_EN_MASK |
>> +             M98925_ADC_IMON_EN_MASK | M98925_ADC_VMON_EN_MASK);
>> +     regmap_write(max98925->regmap,
>> +     MAX98925_R038_GLOBAL_ENABLE, M98925_EN_MASK);
>> +     return 0;
>> +}
>
> It's a bit surprising not to see any of these enables getting turned off
> when we power down - won't that waste power?  Looking at the names I'm
> wondering if these might make more sense as supply widgets.

will change it as supply widgets.
>
>> +static int max98925_spk_gain_put(struct snd_kcontrol *kcontrol,
>> +                             struct snd_ctl_elem_value *ucontrol)
>> +{
>> +     struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
>> +     struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
>> +     unsigned int sel = ucontrol->value.integer.value[0];
>> +
>> +     if (sel < ((1 << M98925_SPK_GAIN_WIDTH) - 1)) {
>> +             regmap_update_bits(max98925->regmap, MAX98925_R02D_GAIN,
>> +                     M98925_SPK_GAIN_MASK, sel << M98925_SPK_GAIN_SHIFT);
>> +             max98925->spk_gain = sel;
>
> Why is this not just a normal control?  I can't see any reference to
> spk_gain elsewhere...  similar things apply to a lot of these controls.

it is used in corresponding get function.
