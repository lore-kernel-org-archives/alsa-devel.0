From: Owen Williams <owilliams@mixxx.org>
Subject: Re: Regression in Traktor Audio10 driver
 (snd-usb-audio) mixer flags
Date: Wed, 13 Jan 2016 09:58:06 -0500
Message-ID: <1452697086.10729.36.camel@legoogs.cam.corp.google.com>
References: <1451586418.9097.8.camel@mixxx.org>
 <1452262738.27231.46.camel@legoogs.cam.corp.google.com>
 <s5h37u78ah9.wl-tiwai@suse.de> <1452457217.18937.9.camel@mixxx.org>
 <s5htwmjnwot.wl-tiwai@suse.de>
 <1452633881.10729.31.camel@legoogs.cam.corp.google.com>
 <s5h1t9mo32n.wl-tiwai@suse.de> <1452659033.4470.2.camel@mixxx.org>
 <s5hvb6ym190.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f176.google.com (mail-qk0-f176.google.com
 [209.85.220.176])
 by alsa0.perex.cz (Postfix) with ESMTP id AE5DE260421
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2016 15:58:09 +0100 (CET)
Received: by mail-qk0-f176.google.com with SMTP id t64so36006905qke.1
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2016 06:58:09 -0800 (PST)
In-Reply-To: <s5hvb6ym190.wl-tiwai@suse.de>
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

Great, thanks for the fast fix.  What's a good way of tracking the fix
to figure out when it goes through the system and ends up in an ubuntu
kernel?

Also, do you also maintain the pulseaudio configuration for this card?
The current config is completely broken and I've created an alternative
that works but isn't perfect.

thanks,
Owen

On Wed, 2016-01-13 at 07:39 +0100, Takashi Iwai wrote:
> On Wed, 13 Jan 2016 05:23:53 +0100,
> Owen Williams wrote:
> > 
> > Yes, that does allow me to use the mixer flags again.  However I notice
> > when I connect the device it no longer starts up with the flags in the
> > default state I can specify when I connect the card to my mac -- is
> > that the resume functionality that's supposed to work?
> 
> This is likely by the restore via alsactl from the last saved state.
> It's nothing new, this should have been present before, too.  But the
> regression also prevented this happening, so you might notice it now.
> 
> In anyway, I'm going to queue the fix to upstream tree.
> 
> 
> thanks,
> 
> Takashi
> 
> > 
> > 
> > On Tue, 2016-01-12 at 23:17 +0100, Takashi Iwai wrote:
> > > On Tue, 12 Jan 2016 22:24:41 +0100,
> > > Owen Williams wrote:
> > > > 
> > > > Finally found the bad commit:
> > > > SHA da6d276957ea56b9514aa5c8d885edf22f0b3e65
> > > > ALSA: usb-audio: Add resume support for Native Instruments controls
> > > 
> > > Great, thanks for spotting out!
> > > 
> > > > I did upgrade my firmware at some point, perhaps the newer firmware
> > > > changed how this works.  Happy to test whatever patches against a
> > > > newer
> > > > kernel (I'm on Wily, so 4.2.0-23).
> > > 
> > > Could you try the patch below?
> > > 
> > > 
> > > Takashi
> > > 
> > > ---
> > > diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
> > > index 0ce888dceed0..279025650568 100644
> > > --- a/sound/usb/mixer_quirks.c
> > > +++ b/sound/usb/mixer_quirks.c
> > > @@ -793,7 +793,7 @@ static int
> > > snd_nativeinstruments_control_put(struct snd_kcontrol *kcontrol,
> > >  		return 0;
> > >  
> > >  	kcontrol->private_value &= ~(0xff << 24);
> > > -	kcontrol->private_value |= newval;
> > > +	kcontrol->private_value |= (unsigned int)newval << 24;
> > >  	err = snd_ni_update_cur_val(list);
> > >  	return err < 0 ? err : 1;
> > >  }
> > > 
> > > 
> > 
> 
> 
