From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] ASoC: rt286: fix headphone click/crack
 noise on Dell XPS 9343 I2S mode
Date: Thu, 16 Feb 2017 15:15:45 +0800
Message-ID: <CAAd53p7NynvwT2_2j0Gg6jXC8FmtyXec=gke3-BGOKXC+7WTuw@mail.gmail.com>
References: <20170123053514.6193-1-kai.heng.feng@canonical.com>
 <ABFD875FF5FB574BA706497D987D48D701C1BF09@RTITEXTEMP.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f169.google.com (mail-yw0-f169.google.com
 [209.85.161.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 34A902666EA
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 08:15:47 +0100 (CET)
Received: by mail-yw0-f169.google.com with SMTP id l19so4251888ywc.2
 for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2017 23:15:47 -0800 (PST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D701C1BF09@RTITEXTEMP.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 16, 2017 at 2:53 PM, Bard Liao <bardliao@realtek.com> wrote:
>> -----Original Message-----
>> From: Kai-Heng Feng [mailto:kai.heng.feng@canonical.com]
>> Sent: Monday, January 23, 2017 1:35 PM
>> To: Bard Liao
>> Cc: Oder Chiou; lgirdwood@gmail.com; broonie@kernel.org;
>> alsa-devel@alsa-project.org; Kai-Heng Feng
>> Subject: [PATCH] ASoC: rt286: fix headphone click/crack noise on Dell XPS 9343
>> I2S mode
>>
>> HDA mode does not have these issues because necessary workarounds in
>> linux/sound/pci/hda/patch_realtek.c are already applied. So we can
>> leverage these workaournds into rt286.
>>
>> When jack is plugged, it rapidly generates I2C interrupts, which
>> triggers rt286_irq() and rt286_jack_detect(), which causes the noise.
>> alc_fixup_dell_xps13() in patch_realtek.c sets up a pin that can stop
>> the frantic interrupts, hence fixes the click noise.
>>
>> When rt286 is under powersaving state, play a sound with headphone or
>> plug a headphone in will produce a loud crack sound.
>> alc_shutup_dell_xps13() patch_realtek.c mutes the headphone at plugging.
>> Apply the same workaround to LDO2 power event can make the loud crack
>> sound to a more tolerable pop sound. I found that unconditionally apply
>> the workaround to all related power event can help a little further.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=112611
>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1313434
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  sound/soc/codecs/rt286.c | 67
>> +++++++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 63 insertions(+), 4 deletions(-)
>>
>> diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
>> index 74c0e4e..d041937 100644
>> --- a/sound/soc/codecs/rt286.c
>> +++ b/sound/soc/codecs/rt286.c
>> @@ -36,6 +36,8 @@
>>  #define RT286_VENDOR_ID 0x10ec0286
>>  #define RT288_VENDOR_ID 0x10ec0288
>>
>> +#define AMP_OUT_MUTE 0xb080
>> +
>>  struct rt286_priv {
>>       struct reg_default *index_cache;
>>       int index_cache_size;
>> @@ -47,6 +49,7 @@ struct rt286_priv {
>>       struct delayed_work jack_detect_work;
>>       int sys_clk;
>>       int clk_id;
>> +     void (*mute_hpo_func)(struct snd_soc_codec *codec);
>>  };
>>
>>  static const struct reg_default rt286_index_def[] = {
>> @@ -472,10 +475,51 @@ static int rt286_set_dmic1_event(struct
>> snd_soc_dapm_widget *w,
>>       return 0;
>>  }
>>
>> +/* Add HV, VREF and LDO1 event functions to workaround headphone crack
>> noise */
>> +static int rt286_hv_event(struct snd_soc_dapm_widget *w,
>> +                          struct snd_kcontrol *kcontrol, int event)
>> +{
>> +     struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
>> +     struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
>> +
>> +     if (rt286->mute_hpo_func)
>> +             rt286->mute_hpo_func(codec);
>> +
>> +     return 0;
>> +}
>> +
>> +static int rt286_vref_event(struct snd_soc_dapm_widget *w,
>> +                          struct snd_kcontrol *kcontrol, int event)
>> +{
>> +     struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
>> +     struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
>> +
>> +     if (rt286->mute_hpo_func)
>> +             rt286->mute_hpo_func(codec);
>> +
>> +     return 0;
>> +}
>> +
>> +static int rt286_ldo1_event(struct snd_soc_dapm_widget *w,
>> +                          struct snd_kcontrol *kcontrol, int event)
>> +{
>> +     struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
>> +     struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
>> +
>> +     if (rt286->mute_hpo_func)
>> +             rt286->mute_hpo_func(codec);
>> +
>> +     return 0;
>> +}
>> +
>>  static int rt286_ldo2_event(struct snd_soc_dapm_widget *w,
>>                            struct snd_kcontrol *kcontrol, int event)
>>  {
>>       struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
>> +     struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
>> +
>> +     if (rt286->mute_hpo_func)
>> +             rt286->mute_hpo_func(codec);
>>
>>       switch (event) {
>>       case SND_SOC_DAPM_POST_PMU:
>> @@ -516,16 +560,24 @@ static int rt286_mic1_event(struct
>> snd_soc_dapm_widget *w,
>>       return 0;
>>  }
>>
>> +static void dell_dino_mute_hpo(struct snd_soc_codec *codec)
>> +{
>> +     snd_soc_write(codec, RT286_SET_AMP_GAIN_HPO, AMP_OUT_MUTE);
>> +}
>> +
>
> I didn't see where will headphone be unmute. There is already a
> headphone mute control on the driver. See
>         SND_SOC_DAPM_SWITCH("HPO L", SND_SOC_NOPM, 0, 0,
>                 &hpol_enable_control),
>         SND_SOC_DAPM_SWITCH("HPO R", SND_SOC_NOPM, 0, 0,
>                 &hpor_enable_control),

This is a direct mirror to function alc_shutup_dell_xps13() in
sound/pci/hda/patch_realtek.c.

I'll try to use what you suggest here.

>
>
>>       SND_SOC_DAPM_SUPPLY_S("LDO2", 2, RT286_POWER_CTRL1,
>>               13, 1, rt286_ldo2_event, SND_SOC_DAPM_PRE_PMD |
>> -             SND_SOC_DAPM_POST_PMU),
>> +             SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
>
> Is POST_PMU really what you want?

I found that mute output before any power event has better result than
mute after.

>
>> @@ -1190,6 +1242,11 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
>>               regmap_update_bits(rt286->regmap,
>>                                       RT286_CBJ_CTRL1, 0xf000, 0xb000);
>>       } else {
>> +             /* Fix headphone click noise */
>> +             if (dmi_check_system(dmi_dell_dino))
>> +                     regmap_write(rt286->regmap,
>> +                                     RT286_MIC1_DET_CTRL, 0x0020);
>> +
>
> I need to figure out how 0x0020 works.

It's from commit 3e1b0c4a9d563d7fc6e22dc92613cd3237bb5ce0

>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
