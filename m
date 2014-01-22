From: <baumber-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Fwd: Re: [alsa-devel] no reset_resume for driver snd-usb-audio
 for logitech headset H600
Date: Wed, 22 Jan 2014 18:12:45 +0100
Message-ID: <BLU0-SMTP858B91706D3BD97C1E57FBA1A70@phx.gbl>
References: <527FA9B6.3000403@hotmail.com>	<BLU0-SMTP389A28B3B37C63ADEE0EE1AA1B20@phx.gbl>	<s5h61pow6hk.wl%tiwai@suse.de>	<BLU0-SMTP103D5034514D3C096609C3AA1BA0@phx.gbl>	<s5hiotfoxbt.wl%tiwai@suse.de> <s5ha9eqab6s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5ha9eqab6s.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 2014-01-20 17:07, Takashi Iwai wrote:
> At Mon, 20 Jan 2014 09:45:58 +0100,
> Takashi Iwai wrote:
>>
>> At Sun, 19 Jan 2014 21:30:58 +0100,
>> <baumber-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org> wrote:
>>>
>>> Hello,
>>>
>>> there must be a misunderstanding;
>>>
>>> There is a functional change, because with the line/patch ".reset_resume = usb_audio_resume," the mixer of the usb headset was not removed during suspend/resume and so the master channel in KDE Mixer was not changed (Headset), which is the correct behaviour.
>>>
>>> Without the line ".reset_resume = usb_audio_resume," in /sound/usb/card.c, the mixer was removed during suspend/resume and re-added, and so the master channel changed in KDE Mixer to the default onboard audio.
>>>
>>> I have tested kernel 3.13rc8, and as you mentioned, the "reset_resume"-messages are gone.
>>> But the behaviour of removing the mixer of the usb_audio_headset occurs, which is, in my opinion, not the correct behaviour, because the chosen master channel/mixer should stay after suspend/resume.
>>>
>>> Could you please take a look at the issue again.

>> Simply adding usb_audio-resume to reset_resume ops doesn't work
>> properly as Clemens already suggested.  It misses the recovery of the
>> current mixer values.  This might work in some cases like S3 (where
>> the device is kept more or less powered on), but it'll be definitely
>> broken in some cases like S4.

For my USB Logitech Headset (ID 046d:0a29 Logitech, Inc. H600 [Wireless Headset]) S3 and S4 are working (mixer resume), when using the "reset_resume" line/patch.
  
> ... and below is a quick fix with mixer resume code.
> It still doesn't handle some quirks, so it might break some devices.

Thank you for your patch/quick fix, I'll try it.

When can I expect a more complete solution for the mixer resume code, in the next kernel releases 3.14 or 3.15?

Thanks, Bernhard

> Takashi
>
> -- >8 --
> From: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
> Subject: [PATCH] ALSA: usb-audio: Resume mixer values properly
>
> Implement reset_resume callback so that the mixer values are properly
> restored.  Still no boot quirks are called, so it might not work well
> on some devices.
>
> Signed-off-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
> ---
>   sound/usb/card.c  | 18 ++++++++--
>   sound/usb/mixer.c | 99 ++++++++++++++++++++++++++++++++++++++++++++-----------
>   sound/usb/mixer.h |  7 ++--
>   3 files changed, 99 insertions(+), 25 deletions(-)
>
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index d979050e6a6a..025224136129 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -691,12 +691,12 @@ static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
>   	}
>
>   	list_for_each_entry(mixer, &chip->mixer_list, list)
> -		snd_usb_mixer_inactivate(mixer);
> +		snd_usb_mixer_suspend(mixer);
>
>   	return 0;
>   }
>
> -static int usb_audio_resume(struct usb_interface *intf)
> +static int __usb_audio_resume(struct usb_interface *intf, bool reset_resume)
>   {
>   	struct snd_usb_audio *chip = usb_get_intfdata(intf);
>   	struct usb_mixer_interface *mixer;
> @@ -711,7 +711,7 @@ static int usb_audio_resume(struct usb_interface *intf)
>   	 * we just notify and restart the mixers
>   	 */
>   	list_for_each_entry(mixer, &chip->mixer_list, list) {
> -		err = snd_usb_mixer_activate(mixer);
> +		err = snd_usb_mixer_resume(mixer, reset_resume);
>   		if (err < 0)
>   			goto err_out;
>   	}
> @@ -723,9 +723,20 @@ static int usb_audio_resume(struct usb_interface *intf)
>   err_out:
>   	return err;
>   }
> +
> +static int usb_audio_resume(struct usb_interface *intf)
> +{
> +	return __usb_audio_resume(intf, false);
> +}
> +
> +static int usb_audio_reset_resume(struct usb_interface *intf)
> +{
> +	return __usb_audio_resume(intf, true);
> +}
>   #else
>   #define usb_audio_suspend	NULL
>   #define usb_audio_resume	NULL
> +#define usb_audio_reset_resume	NULL
>   #endif		/* CONFIG_PM */
>
>   static struct usb_device_id usb_audio_ids [] = {
> @@ -747,6 +758,7 @@ static struct usb_driver usb_audio_driver = {
>   	.disconnect =	usb_audio_disconnect,
>   	.suspend =	usb_audio_suspend,
>   	.resume =	usb_audio_resume,
> +	.reset_resume =	usb_audio_reset_resume,
>   	.id_table =	usb_audio_ids,
>   	.supports_autosuspend = 1,
>   };
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index 44b0ba4feab3..aa9bc19aae68 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -2299,26 +2299,6 @@ requeue:
>   	}
>   }
>
> -/* stop any bus activity of a mixer */
> -void snd_usb_mixer_inactivate(struct usb_mixer_interface *mixer)
> -{
> -	usb_kill_urb(mixer->urb);
> -	usb_kill_urb(mixer->rc_urb);
> -}
> -
> -int snd_usb_mixer_activate(struct usb_mixer_interface *mixer)
> -{
> -	int err;
> -
> -	if (mixer->urb) {
> -		err = usb_submit_urb(mixer->urb, GFP_NOIO);
> -		if (err < 0)
> -			return err;
> -	}
> -
> -	return 0;
> -}
> -
>   /* create the handler for the optional status interrupt endpoint */
>   static int snd_usb_mixer_status_create(struct usb_mixer_interface *mixer)
>   {
> @@ -2417,3 +2397,82 @@ void snd_usb_mixer_disconnect(struct list_head *p)
>   	usb_kill_urb(mixer->urb);
>   	usb_kill_urb(mixer->rc_urb);
>   }
> +
> +#ifdef CONFIG_PM
> +/* stop any bus activity of a mixer */
> +static void snd_usb_mixer_inactivate(struct usb_mixer_interface *mixer)
> +{
> +	usb_kill_urb(mixer->urb);
> +	usb_kill_urb(mixer->rc_urb);
> +}
> +
> +static int snd_usb_mixer_activate(struct usb_mixer_interface *mixer)
> +{
> +	int err;
> +
> +	if (mixer->urb) {
> +		err = usb_submit_urb(mixer->urb, GFP_NOIO);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +int snd_usb_mixer_suspend(struct usb_mixer_interface *mixer)
> +{
> +	snd_usb_mixer_inactivate(mixer);
> +	return 0;
> +}
> +
> +static int restore_mixer_value(struct usb_mixer_elem_info *cval)
> +{
> +	int c, err, idx;
> +
> +	if (cval->cmask) {
> +		idx = 0;
> +		for (c = 0; c < MAX_CHANNELS; c++) {
> +			if (!(cval->cmask & (1 << c)))
> +				continue;
> +			if (cval->cached & (1 << c)) {
> +				err = set_cur_mix_value(cval, c + 1, idx,
> +							cval->cache_val[idx]);
> +				if (err < 0)
> +					return err;
> +			}
> +			idx++;
> +		}
> +	} else {
> +		/* master */
> +		if (cval->cached) {
> +			err = set_cur_mix_value(cval, 0, 0, *cval->cache_val);
> +			if (err < 0)
> +				return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int snd_usb_mixer_resume(struct usb_mixer_interface *mixer, bool reset_resume)
> +{
> +	struct usb_mixer_elem_info *cval;
> +	int id, err;
> +
> +	/* FIXME: any mixer quirks? */
> +
> +	if (reset_resume) {
> +		/* restore cached mixer values */
> +		for (id = 0; id < MAX_ID_ELEMS; id++) {
> +			for (cval = mixer->id_elems[id]; cval;
> +			     cval = cval->next_id_elem) {
> +				err = restore_mixer_value(cval);
> +				if (err < 0)
> +					return err;
> +			}
> +		}
> +	}
> +
> +	return snd_usb_mixer_activate(mixer);
> +}
> +#endif
> diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
> index aab80df201bd..73b1f649447b 100644
> --- a/sound/usb/mixer.h
> +++ b/sound/usb/mixer.h
> @@ -63,8 +63,6 @@ void snd_usb_mixer_notify_id(struct usb_mixer_interface *mixer, int unitid);
>
>   int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
>   				int request, int validx, int value_set);
> -void snd_usb_mixer_inactivate(struct usb_mixer_interface *mixer);
> -int snd_usb_mixer_activate(struct usb_mixer_interface *mixer);
>
>   int snd_usb_mixer_add_control(struct usb_mixer_interface *mixer,
>   			      struct snd_kcontrol *kctl);
> @@ -72,4 +70,9 @@ int snd_usb_mixer_add_control(struct usb_mixer_interface *mixer,
>   int snd_usb_mixer_vol_tlv(struct snd_kcontrol *kcontrol, int op_flag,
>   			  unsigned int size, unsigned int __user *_tlv);
>
> +#ifdef CONFIG_PM
> +int snd_usb_mixer_suspend(struct usb_mixer_interface *mixer);
> +int snd_usb_mixer_resume(struct usb_mixer_interface *mixer, bool reset_resume);
> +#endif
> +
>   #endif /* __USBMIXER_H */
>

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
