From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Adding a "capture" device naming scheme
Date: Wed, 12 Jan 2011 16:38:57 +0800
Message-ID: <AANLkTim=UHh3_gpGir66pEjSG=W9X3uh+--VP_Fiw8xD@mail.gmail.com>
References: <igi861$q8o$1@dough.gmane.org>
	<AANLkTikGo8FMVf_9UMBa+iOhgXXdtWFdePk_7=6zwDhA@mail.gmail.com>
	<s5h62tuipeh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id BBFA72445E
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 09:38:57 +0100 (CET)
Received: by ewy19 with SMTP id 19so121955ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 00:38:57 -0800 (PST)
In-Reply-To: <s5h62tuipeh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/1/12 Takashi Iwai <tiwai@suse.de>

> At Wed, 12 Jan 2011 09:08:37 +0800,
> Raymond Yau wrote:
> >
> > 2011/1/12 Colin Guthrie <gmane@colin.guthr.ie>
> >
> > > Hi,
> > >
> > > As has been pointed out a few times, it's incorrect to use "front:" for
> > > capture, but can we have an official name/wrapper (I'm unsure of the
> > > terminology here) for this so we don't use hw: for recording?
> > >
> > > I'd be in favour of "capture:" or "input:" as these both seem quite
> > > logical and easy to understand.
> > >
> > > It would be used thusly:
> > >
> > >  arecord -f S16_LE -c 2 -D capture:CARD=Intel
> > >
> > > as opposed to the incorrect:
> > >  arecord -f S16_LE -c 2 -D front:CARD=Intel
> > > or the low level:
> > >  arecord -f S16_LE -c 2 -D hw:CARD=Intel
> > >
> >
> > why do you think that it is incorrect to use hw:CARD=xxx for analog
> capture
> > ?
>
> I read Colin meant front:CARD=x is incorrect while hw:CARD is a lowlevel
> access that one doesn't always want.
>
> I'm fine with creating a new name, but wondering which name is best.
> Basically what you want here is the default use-case but without
> dsnoop like the current "default".  (If dsnoop were acceptable,
> "default" should have been used in most places.)
> "capture" may be also too ambiguous for defining that, I'm afraid.
>
>
> thanks,
>
> Takashi
>

Does all HDA codec support multistreaming capture since HDA spec seem have a
limitation on the number of capture stream or just ALSA does not support
multistreaming ?

http://www.intel.com/support/motherboards/desktop/sb/cs-020642.htm
#multistream

some realtek codec put another analog capture device at hw:0,2

It seem that some VIA codec support "multistreaming" capture since it  has
an indepedent ADC which can only connect to the front panel mic and the
driver create have two subdevices

As device 0 support multi channels but those alternate stream support stereo
only

can the HDA driver assign analog_alt_playback and analog_alt_capture in the
same device ?
