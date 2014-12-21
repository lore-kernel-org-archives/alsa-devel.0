From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: Re: [alsa-devel] [PATCH] sound: pci: hda: patch_analog.c: Remove
 unused function
Date: Sun, 21 Dec 2014 12:40:40 +0100
Message-ID: <CAFo99gZ=SZ=vLUWXzqreSbX2UNqr0vvDXcXyP2qO_v4wS2nQ0g@mail.gmail.com>
References: <1419114679-11752-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <CAN8cciaCGXHJaxQfkgvwCehwAcZvH_m6QaSTv_aUgSd1Y4x+og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAN8cciaCGXHJaxQfkgvwCehwAcZvH_m6QaSTv_aUgSd1Y4x+og@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

2014-12-21 9:00 GMT+01:00 Raymond Yau <superquad.vortex2@gmail.com>:
>>
>> Remove the function ad198x_ch_mode_get() that is not used anywhere.
>>
>> This was partially found by using a static code analysis program called
>> cppcheck.
>>
>> Signed-off-by: Rickard Strandqvist
>> <rickard_strandqvist@spectrumdigital.se>
>> ---
>>  sound/pci/hda/patch_analog.c |    9 ---------
>>  1 file changed, 9 deletions(-)
>>
>> diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
>> index 06275f8..9d5257b 100644
>> --- a/sound/pci/hda/patch_analog.c
>> +++ b/sound/pci/hda/patch_analog.c
>> @@ -707,15 +707,6 @@ static int ad198x_ch_mode_info(struct snd_kcontrol
>> *kcontrol,
>>                                     spec->num_channel_mode);
>>  }
>>
>> -static int ad198x_ch_mode_get(struct snd_kcontrol *kcontrol,
>> -                             struct snd_ctl_elem_value *ucontrol)
>> -{
>> -       struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
>> -       struct ad198x_spec *spec = codec->spec;
>> -       return snd_hda_ch_mode_get(codec, ucontrol, spec->channel_mode,
>> -                                  spec->num_channel_mode,
>> spec->multiout.max_channels);
>> -}
>> -
>>  static int ad198x_ch_mode_put(struct snd_kcontrol *kcontrol,
>>                               struct snd_ctl_elem_value *ucontrol)
>>  {
>> --
>
> Seem all three functions can be removed instead of one
>
> ifdef ENABLE_AD_STATIC_QUIRKS
> static int ad198x_ch_mode_info(struct snd_kcontrol *kcontrol,
>        struct snd_ctl_elem_info *uinfo)
> {
> struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
> struct ad198x_spec *spec = codec->spec;
> return snd_hda_ch_mode_info(codec, uinfo, spec->channel_mode,
>     spec->num_channel_mode);
> }
>
> static int ad198x_ch_mode_get(struct snd_kcontrol *kcontrol,
>       struct snd_ctl_elem_value *ucontrol)
> {
> struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
> struct ad198x_spec *spec = codec->spec;
> return snd_hda_ch_mode_get(codec, ucontrol, spec->channel_mode,
>    spec->num_channel_mode, spec->multiout.max_channels);
> }
>
> static int ad198x_ch_mode_put(struct snd_kcontrol *kcontrol,
>       struct snd_ctl_elem_value *ucontrol)
> {
> struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
> struct ad198x_spec *spec = codec->spec;
> int err = snd_hda_ch_mode_put(codec, ucontrol, spec->channel_mode,
>       spec->num_channel_mode,
>       &spec->multiout.max_channels);
> if (err >= 0 && spec->need_dac_fix)
> spec->multiout.num_dacs = spec->multiout.max_channels / 2;
> return err;
> }
> #endif /* ENABLE_AD_STATIC_QUIRKS */
>



Hi

Yes, that's right :)
The other was included in my list of function that could possibly
deleted after a build test.
I do it now, and will submit a new patch.


Kind regards
Rickard Strandqvist
