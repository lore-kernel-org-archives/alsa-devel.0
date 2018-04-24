From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: [PATCH 4/4] ALSA: usb: add UAC3 BADD profiles
	support
Date: Tue, 24 Apr 2018 10:51:43 +0300
Message-ID: <CAB=otbScsVWvE35WM8xGrsqYDjntaUgFRM3XSuzktsjZo9op1g@mail.gmail.com>
References: <1523658266-2259-1-git-send-email-ruslan.bilovol@gmail.com>
 <1523658266-2259-5-git-send-email-ruslan.bilovol@gmail.com>
 <s5ha7tzzefw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f173.google.com (mail-ot0-f173.google.com
 [74.125.82.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EDF0266E30
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 09:51:44 +0200 (CEST)
Received: by mail-ot0-f173.google.com with SMTP id 77-v6so14127614otd.4
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 00:51:44 -0700 (PDT)
In-Reply-To: <s5ha7tzzefw.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jorge <jorge.sanjuan@codethink.co.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 19, 2018 at 1:19 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Sat, 14 Apr 2018 00:24:26 +0200,
> Ruslan Bilovol wrote:
>>
>> +static void build_feature_ctl_badd(struct usb_mixer_interface *mixer,
>> +                           unsigned int ctl_mask, int control, int unitid,
>> +                           const struct usbmix_name_map *badd_map)
>> +{
> ....
>> +     kctl = snd_ctl_new1(&usb_feature_unit_ctl, cval);
>> +
>> +     if (!kctl) {
>> +             usb_audio_err(mixer->chip, "cannot malloc kcontrol\n");
>
> No need for error message after malloc failure.  The kernel is already
> chatty about it.

Okay. BTW, I'm trying to avoid separate badd variant of
build_feature_ctl(), so this most probably will go away.

There are many existing places in usb-snd which can be cleaned
up though.

>
>
>> +static int snd_usb_mixer_controls_badd(struct usb_mixer_interface *mixer,
>> +                                    int ctrlif)
>> +{
>> +     struct usb_device *dev = mixer->chip->dev;
>> +     struct usb_interface_assoc_descriptor *assoc;
>> +     int badd_profile = mixer->chip->badd_profile;
>> +     const struct usbmix_ctl_map *map;
>> +     int p_chmask = 0, c_chmask = 0, st_chmask = 0;
>> +     int i;
>> +
>> +     assoc = usb_ifnum_to_if(dev, ctrlif)->intf_assoc;
>> +
>> +     /* Detect BADD capture/playback channels from AS EP descriptors */
>> +     for (i = 0; i < assoc->bInterfaceCount; i++) {
>> +             int intf = assoc->bFirstInterface + i;
>> +
>> +             if (intf != ctrlif) {
>
> In this case, it's better to skip like
>
>                 if (intf == ctrlif)
>                         continue;
>
> so that we can save an indentation for the whole long block.

Good point, will do it

>
>> +     switch (badd_profile) {
>> +     default:
>> +             return -EINVAL;
>> +     case UAC3_FUNCTION_SUBCLASS_GENERIC_IO:
>> +             /*
>> +              * BAIF, BAOF or combination of both
>> +              * IN: Mono or Stereo cfg, Mono alt possible
>> +              * OUT: Mono or Stereo cfg, Mono alt possible
>> +              */
>> +             /* c_chmask := DYNAMIC */
>> +             /* p_chmask := DYNAMIC */
>> +             if (!c_chmask && !p_chmask) {
>> +                     usb_audio_err(mixer->chip,
>> +                             "BADD GENERIC_IO profile: no channels?\n");
>> +                     return -EINVAL;
>> +             }
>> +             break;
>
> Maybe we can simplify the whole switch/case with a table lookup.

Yes, it should be possible, I'll implent it that way

Thanks,
Ruslan

> For example,
>
>         for (f = uac3_func_tables; f->name; f++) {
>                 if (badd_profile == f->subclass)
>                         break;
>         }
>         if (!f->name)
>                 return -EINVAL;
>         if (!uac3_func_has_valid_channels(mixer, f, c_chmask, p_chmask))
>                 return -EINVAL;
>         st_chmask = f->st_chmask;
>
> and in uac3_func_has_valid_channels(),
>
> static bool uac3_func_has_valid_channels()
> {
>         if ((f->c_chmask < 0 && !c_chmask) ||
>             (f->c_chmask >= 0 && f->c_chmask != c_chmask)) {
>                 usb_audio_warn(mixer->chip, "BAAD %s c_chmask mismatch",
>                                 f->name);
>                 return false;
>         }
>         if ((f->p_chmask < 0 && !p_chmask) ||
>             (f->p_chmask >= 0 && f->p_chmask != p_chmask)) {
>                 usb_audio_warn(mixer->chip, "BAAD %s p_chmask mismatch",
>                                 f->name);
>                 return false;
>         }
>         return true;
> }
>
>
> thanks,
>
> Takashi
