From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] sound: pci: hda: patch_analog.c: Remove
 unused function
Date: Sun, 21 Dec 2014 16:00:52 +0800
Message-ID: <CAN8cciaCGXHJaxQfkgvwCehwAcZvH_m6QaSTv_aUgSd1Y4x+og@mail.gmail.com>
References: <1419114679-11752-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f49.google.com (mail-qg0-f49.google.com
 [209.85.192.49])
 by alsa0.perex.cz (Postfix) with ESMTP id A3F3426042B
 for <alsa-devel@alsa-project.org>; Sun, 21 Dec 2014 09:00:53 +0100 (CET)
Received: by mail-qg0-f49.google.com with SMTP id a108so2286703qge.22
 for <alsa-devel@alsa-project.org>; Sun, 21 Dec 2014 00:00:52 -0800 (PST)
In-Reply-To: <1419114679-11752-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

>
> Remove the function ad198x_ch_mode_get() that is not used anywhere.
>
> This was partially found by using a static code analysis program called
cppcheck.
>
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se
>
> ---
>  sound/pci/hda/patch_analog.c |    9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
> index 06275f8..9d5257b 100644
> --- a/sound/pci/hda/patch_analog.c
> +++ b/sound/pci/hda/patch_analog.c
> @@ -707,15 +707,6 @@ static int ad198x_ch_mode_info(struct snd_kcontrol
*kcontrol,
>                                     spec->num_channel_mode);
>  }
>
> -static int ad198x_ch_mode_get(struct snd_kcontrol *kcontrol,
> -                             struct snd_ctl_elem_value *ucontrol)
> -{
> -       struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
> -       struct ad198x_spec *spec = codec->spec;
> -       return snd_hda_ch_mode_get(codec, ucontrol, spec->channel_mode,
> -                                  spec->num_channel_mode,
spec->multiout.max_channels);
> -}
> -
>  static int ad198x_ch_mode_put(struct snd_kcontrol *kcontrol,
>                               struct snd_ctl_elem_value *ucontrol)
>  {
> --

Seem all three functions can be removed instead of one

ifdef ENABLE_AD_STATIC_QUIRKS
static int ad198x_ch_mode_info(struct snd_kcontrol *kcontrol,
       struct snd_ctl_elem_info *uinfo)
{
struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
struct ad198x_spec *spec = codec->spec;
return snd_hda_ch_mode_info(codec, uinfo, spec->channel_mode,
    spec->num_channel_mode);
}

static int ad198x_ch_mode_get(struct snd_kcontrol *kcontrol,
      struct snd_ctl_elem_value *ucontrol)
{
struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
struct ad198x_spec *spec = codec->spec;
return snd_hda_ch_mode_get(codec, ucontrol, spec->channel_mode,
   spec->num_channel_mode, spec->multiout.max_channels);
}

static int ad198x_ch_mode_put(struct snd_kcontrol *kcontrol,
      struct snd_ctl_elem_value *ucontrol)
{
struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
struct ad198x_spec *spec = codec->spec;
int err = snd_hda_ch_mode_put(codec, ucontrol, spec->channel_mode,
      spec->num_channel_mode,
      &spec->multiout.max_channels);
if (err >= 0 && spec->need_dac_fix)
spec->multiout.num_dacs = spec->multiout.max_channels / 2;
return err;
}
#endif /* ENABLE_AD_STATIC_QUIRKS */
