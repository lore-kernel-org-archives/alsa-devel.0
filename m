From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH v2 0/3] Allow suspend/resume with USB audio.
Date: Tue, 18 Sep 2012 13:24:34 -0700
Message-ID: <CAEUnVG5G67C-ASBKAdLxc-pF+FPP4_HHXpO6XDoV7dbLOTcpaQ@mail.gmail.com>
References: <1347986988-11382-1-git-send-email-dgreid@chromium.org>
 <s5h627bkubb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id B1A542650FD
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 22:24:54 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so160475wgb.20
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 13:24:54 -0700 (PDT)
In-Reply-To: <s5h627bkubb.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 18, 2012 at 12:24 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 18 Sep 2012 09:49:45 -0700,
> Dylan Reid wrote:
>>
>> Problem being addressed:
>> shell one$ aplay -Dhw:<usbcard> file.wav
>> shell two$ echo mem > /sys/power/state
>> After resume, aplay attempts resume, then restart, then after a timeout
>> gets a write error and no audio will be played until it is restarted.
>>
>> During suspend/resume, if the USB port remains powered the audio device
>> will still be present upon resume.  The interface and endpoint have to
>> be reconfigured however.  These patches move the configuration from
>> hw_params to prepare causing re-configuration during resume.
>>
>> Is this the right way to fix this?  Or is there an easier way I am
>> missing?
>>
>> Thanks for looking.
>>
>> v2: fix unused variable warnings.
>
> I think the patches are OK.  If no big objection comes up, I'm going
> to apply it tomorrow.
>
> Meanwhile I found a problem in my patch.  The re-setup might be needed
> if the app changes hw_params again.  So, the flag has to be set in
> hw_params callback instead.  The revised patch is below.

Good catch.  I wrote a quick test that plays something, calls drain, calls
hw_params to a different rate, then start and plays again.  It failed with the
old patch and works with the new one.

Thanks,

Dylan

>
>
> thanks,
>
> Takashi
>
> ===
>
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH v2] ALSA: usb-audio: Avoid unnecessary EP setups in prepare
>
> The recent fix for USB suspend breakage moved the code to set up EP
> from hw_params to prepare, but it means also the EP setup might be
> called multiple times unnecessarily because the prepare callback can
> be called multiple times without starting the stream (e.g. OSS
> emulation).
>
> This patch adds a new flag to struct snd_usb_substream indicating
> whether the setup of EP is required, and do it only when necessary,
> i.e. right after hw_params or suspend.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> v1->v2: set the flag in hw_params callback
>
>  sound/usb/card.c |  2 ++
>  sound/usb/card.h |  1 +
>  sound/usb/pcm.c  | 10 +++++++---
>  3 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 4a469f0..561bb74 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -646,6 +646,8 @@ static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
>                         list_for_each(p, &chip->pcm_list) {
>                                 as = list_entry(p, struct snd_usb_stream, list);
>                                 snd_pcm_suspend_all(as->pcm);
> +                               as->substream[0].need_setup_ep =
> +                                       as->substream[1].need_setup_ep = true;
>                         }
>                 }
>         } else {
> diff --git a/sound/usb/card.h b/sound/usb/card.h
> index 6cc883c..afa4f9e 100644
> --- a/sound/usb/card.h
> +++ b/sound/usb/card.h
> @@ -125,6 +125,7 @@ struct snd_usb_substream {
>         struct snd_usb_endpoint *data_endpoint;
>         struct snd_usb_endpoint *sync_endpoint;
>         unsigned long flags;
> +       bool need_setup_ep;             /* (re)configure EP at prepare? */
>
>         u64 formats;                    /* format bitmasks (all or'ed) */
>         unsigned int num_formats;               /* number of supported audio formats (list) */
> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> index ae783d4..55e19e1 100644
> --- a/sound/usb/pcm.c
> +++ b/sound/usb/pcm.c
> @@ -510,6 +510,7 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
>
>         subs->interface = fmt->iface;
>         subs->altset_idx = fmt->altset_idx;
> +       subs->need_setup_ep = true;
>
>         return 0;
>  }
> @@ -568,9 +569,12 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
>         if (ret < 0)
>                 return ret;
>
> -       ret = configure_endpoint(subs);
> -       if (ret < 0)
> -               return ret;
> +       if (subs->need_setup_ep) {
> +               ret = configure_endpoint(subs);
> +               if (ret < 0)
> +                       return ret;
> +               subs->need_setup_ep = false;
> +       }
>
>         /* some unit conversions in runtime */
>         subs->data_endpoint->maxframesize =
> --
> 1.7.11.5
>
