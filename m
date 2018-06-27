From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 1/3] ALSA: hda - Handle error from
	snd_hda_power_up*()
Date: Wed, 27 Jun 2018 10:36:12 +0100
Message-ID: <153009217281.8693.18299158962464248883@mail.alporthouse.com>
References: <20180627091034.22724-1-tiwai@suse.de>
 <20180627091034.22724-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fireflyinternet.com (mail.fireflyinternet.com [109.228.58.192])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F7F6267962
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 11:36:19 +0200 (CEST)
In-Reply-To: <20180627091034.22724-2-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: =?utf-8?b?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Quoting Takashi Iwai (2018-06-27 10:10:32)
> Although snd_hda_power_up() and snd_hda_power_up_pm() may fail, we
> haven't dealt with the error properly in many places.  It's an unusual
> situation but still possible.
> 
> This patch spots these places and adds the proper error paths.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> @@ -5407,7 +5428,9 @@ static int ca0132_volume_put(struct snd_kcontrol *kcontrol,
>                 int dir = get_amp_direction(kcontrol);
>                 unsigned long pval;
>  
> -               snd_hda_power_up(codec);
> +               err = snd_hda_power_up(codec);
> +               if (err < 0)
> +                       return err;
>                 mutex_lock(&codec->control_mutex);
>                 pval = kcontrol->private_value;
>                 kcontrol->private_value = HDA_COMPOSE_AMP_VAL(shared_nid, ch,

Should this be deferred until pm is next acquired?
Or are we regarding pm can only fail nonrecoverably?

> @@ -5436,6 +5459,7 @@ static int ca0132_alt_volume_put(struct snd_kcontrol *kcontrol,
>         long *valp = ucontrol->value.integer.value;
>         hda_nid_t vnid = 0;
>         int changed = 1;
> +       int err;
>  
>         switch (nid) {
>         case 0x02:
> @@ -5456,7 +5480,9 @@ static int ca0132_alt_volume_put(struct snd_kcontrol *kcontrol,
>                 valp++;
>         }
>  
> -       snd_hda_power_up(codec);
> +       err = snd_hda_power_up(codec);
> +       if (err < 0)
> +               return err;
>         ca0132_alt_dsp_volume_put(codec, vnid);
>         mutex_lock(&codec->control_mutex);
>         changed = snd_hda_mixer_amp_volume_put(kcontrol, ucontrol);

> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 5ad6c7e5f92e..b0d757cf7aab 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -3606,7 +3606,8 @@ static void alc269_fixup_mic_mute_hook(void *private_data, int enabled)
>         pinval |= enabled ? AC_PINCTL_VREF_HIZ : AC_PINCTL_VREF_80;
>         if (spec->mute_led_nid) {
>                 /* temporarily power up/down for setting VREF */
> -               snd_hda_power_up_pm(codec);
> +               if (snd_hda_power_up_pm(codec) < 0)
> +                       return;
>                 snd_hda_set_pin_ctl_cache(codec, spec->mute_led_nid, pinval);
>                 snd_hda_power_down_pm(codec);
>         }

Similar questions as for deferred application.

I did not find any imbalance introduced and the error is propagated or
handled,
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
