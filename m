From: Owen Williams <owilliams@mixxx.org>
Subject: Re: Regression in Traktor Audio10 driver
 (snd-usb-audio) mixer flags
Date: Tue, 12 Jan 2016 23:23:53 -0500
Message-ID: <1452659033.4470.2.camel@mixxx.org>
References: <1451586418.9097.8.camel@mixxx.org>
 <1452262738.27231.46.camel@legoogs.cam.corp.google.com>
 <s5h37u78ah9.wl-tiwai@suse.de> <1452457217.18937.9.camel@mixxx.org>
 <s5htwmjnwot.wl-tiwai@suse.de>
 <1452633881.10729.31.camel@legoogs.cam.corp.google.com>
 <s5h1t9mo32n.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f51.google.com (mail-qg0-f51.google.com
 [209.85.192.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 671B726048C
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2016 05:23:56 +0100 (CET)
Received: by mail-qg0-f51.google.com with SMTP id b35so316264636qge.0
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2016 20:23:56 -0800 (PST)
In-Reply-To: <s5h1t9mo32n.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Yes, that does allow me to use the mixer flags again.  However I notice
when I connect the device it no longer starts up with the flags in the
default state I can specify when I connect the card to my mac -- is
that the resume functionality that's supposed to work?


On Tue, 2016-01-12 at 23:17 +0100, Takashi Iwai wrote:
> On Tue, 12 Jan 2016 22:24:41 +0100,
> Owen Williams wrote:
> > 
> > Finally found the bad commit:
> > SHA da6d276957ea56b9514aa5c8d885edf22f0b3e65
> > ALSA: usb-audio: Add resume support for Native Instruments controls
> 
> Great, thanks for spotting out!
> 
> > I did upgrade my firmware at some point, perhaps the newer firmware
> > changed how this works.  Happy to test whatever patches against a
> > newer
> > kernel (I'm on Wily, so 4.2.0-23).
> 
> Could you try the patch below?
> 
> 
> Takashi
> 
> ---
> diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
> index 0ce888dceed0..279025650568 100644
> --- a/sound/usb/mixer_quirks.c
> +++ b/sound/usb/mixer_quirks.c
> @@ -793,7 +793,7 @@ static int
> snd_nativeinstruments_control_put(struct snd_kcontrol *kcontrol,
>  		return 0;
>  
>  	kcontrol->private_value &= ~(0xff << 24);
> -	kcontrol->private_value |= newval;
> +	kcontrol->private_value |= (unsigned int)newval << 24;
>  	err = snd_ni_update_cur_val(list);
>  	return err < 0 ? err : 1;
>  }
> 
> 
