From: John Frankish <john.frankish@outlook.com>
Subject: Re: Intel alsa sound request for Laptops
Date: Sun, 29 Jan 2017 08:15:27 +0000
Message-ID: <DBXPR04MB334ED59C445FC8FA14DC8EEF3480@DBXPR04MB334.eurprd04.prod.outlook.com>
References: <DBXPR04MB334548B939F29F8E6E24790F3490@DBXPR04MB334.eurprd04.prod.outlook.com>
 <s5hwpdf9nzt.wl-tiwai@suse.de>
 <DBXPR04MB334D7AB20A0F4C15ADD0CB2F3490@DBXPR04MB334.eurprd04.prod.outlook.com>
 <s5htw8j9bsu.wl-tiwai@suse.de>
 <DBXPR04MB334707A6AE3893371F3297DF3480@DBXPR04MB334.eurprd04.prod.outlook.com>
 <s5hr33m9ugc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from BAY004-OMC1S16.hotmail.com (bay004-omc1s16.hotmail.com
 [65.54.190.27]) by alsa0.perex.cz (Postfix) with ESMTP id 04FAC266ADD
 for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2017 09:15:30 +0100 (CET)
In-Reply-To: <s5hr33m9ugc.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

> > > > > > For two or three kernel versions of alsa divers now, HDMI has 
> > > > > > been the default alsa device on my laptop (Dell Latitude E7240) - this does not make logical sense.
> > > > > >
> > > > > > In the latest kernel version I use, 4.2.9, alsa sound will not 
> > > > > > work at all unless I load the i915 kernel driver
> > > > > > - this does not make logical sense and means that I cannot use Xvesa.
> > > > > > 
> > > > > > Is it possible to make an alsa feature request for analogue 
> > > > > > sound to be the default alsa device on laptops and for alsa sound to work without the need to load the i915 kernel driver?
> > > > > >
> > > > > It's a configuration issue.  Pass the module option if you prefer the secondary device:
> > > > > 
> > > > > options snd-hda-intel index=1,0
> > > > > 
> > > > Sure, I realise I can do that, but it's not the point and it's awkward to do so with the "live CD-type" distro I use (tinycorelinux).
> > > >
> > > > Laptop sound should work in standalone mode by default - i.e. if 
> > > > laptop uses analogue sound for its built-in speakers then the alsa default should be analogue sound.
> > > > 
> > > > The above notwithstanding, analogue sound should work without needing to load the i915 kernel driver.
> > > > 
> > > For a smart automation, use PulseAudio.  It's exactly for such a purpose.
> > > 
> > > The kernel driver assigns each device just in the order how they are enumerated.
> > > In the case of HD-audio, it's the order of PCI devices.
> > > It's nothing different from any other PCI drivers.
> > >
> > OK, but I should not have to add bloat like pulseaudio in order to have basic sound functionality.
> > 
> For getting the basic sound functionality, you have to set up something.
> You're asking the high-level automation, hence you need something like PA.
>
I'm not asking for high level automation, I'm asking that when I boot my laptop with alsa the built-in speakers work by default

> Of course, you're free to reimplement a wheel if you don't like PA.
> A similar thing can be achieved just by delaying the sound driver module
> loading at udev level, or dynamically evaluating the priority per PCI ID, at udev and assigning the
> index appropriately there. (Just an idea, though.)
>
> > You also don't mention why I should have to load a graphics driver (i915) in order to get analogue sound? That makes no sense at all...
> >
> The lack of i915 influences on the index assignment since the HDMI codec driver probe fails without i915.
> It's the reason why the secondary HD-audio codec appears as the first, eventually it's the analog audio output in your case.
>
I do not use the i915 driver at all - as far as I know, it still has the "pipe state doesn't match" bug - Xvesa doesn't require it and I use the modesetting driver with Xorg (since after more than a year we're still waiting for a stable xf86-video-intel).

You appear to be saying that, even if I work from the console prompt, I need to load the unneeded (and buggy) i915 driver in order to have analogue sound.

All credit to Intel for providing Linux drivers, but this i915/alsa/hdmi saga seems really flaky :(
