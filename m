From: Owen Williams <owilliams@mixxx.org>
Subject: Re: Regression in Traktor Audio10 driver
 (snd-usb-audio) mixer flags
Date: Tue, 12 Jan 2016 16:24:41 -0500
Message-ID: <1452633881.10729.31.camel@legoogs.cam.corp.google.com>
References: <1451586418.9097.8.camel@mixxx.org>
 <1452262738.27231.46.camel@legoogs.cam.corp.google.com>
 <s5h37u78ah9.wl-tiwai@suse.de> <1452457217.18937.9.camel@mixxx.org>
 <s5htwmjnwot.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f66.google.com (mail-qg0-f66.google.com
 [209.85.192.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 7424F260508
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2016 22:24:44 +0100 (CET)
Received: by mail-qg0-f66.google.com with SMTP id 6so46607432qgy.3
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2016 13:24:44 -0800 (PST)
In-Reply-To: <s5htwmjnwot.wl-tiwai@suse.de>
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

Finally found the bad commit:
SHA da6d276957ea56b9514aa5c8d885edf22f0b3e65
ALSA: usb-audio: Add resume support for Native Instruments controls

I did upgrade my firmware at some point, perhaps the newer firmware
changed how this works.  Happy to test whatever patches against a newer
kernel (I'm on Wily, so 4.2.0-23).

Owen


On Tue, 2016-01-12 at 07:22 +0100, Takashi Iwai wrote:
> On Sun, 10 Jan 2016 21:20:17 +0100,
> Owen Williams wrote:
> > 
> > Unfortunately I can't narrow the problem down more specifically than
> > the changes from Ubuntu-3.18.0-14.14 to Ubuntu-3.19.0-1.1.  If I try to
> > git bisect between those, I end up with commits that don't have the
> > proper debian packaging information so I can't build packages.  Any
> > ideas?  I see a bunch of merges for the sound subsystem in the 3.19
> > branch so if can figure out how to build debs I bet the problem is in
> > there.
> 
> Well, usually you'd need to install the kernel manually without
> packaging.  There aren't so wide spread files / directories, so it's
> not too hard to manage manually.
> 
> 
> Takashi
> 
> > 
> > On Sat, 2016-01-09 at 08:42 +0100, Takashi Iwai wrote:
> > > On Fri, 08 Jan 2016 15:18:58 +0100,
> > > Owen Williams wrote:
> > > > 
> > > > Sorry to bump my own thread, but I don't know how else to report
> > > > bugs to
> > > > ALSA (I think the bug tracker was abandoned a while back?).  I'm
> > > > willing
> > > > to do work to diagnose and fix this problem (I'm comfortable
> > > > building
> > > > kernels, doing git bisect, using gdb, etc) but I need some guidance
> > > > about how to start.
> > > 
> > > If the problem is easily reproducible, could you try bisection?
> > > This is the best way to spot out the cause.
> > > 
> > > 
> > > thanks,
> > > 
> > > Takashi
> > > 
> > > > On Thu, 2015-12-31 at 13:26 -0500, Owen Williams wrote:
> > > > > Sometime between kernels 3.13 (ubuntu 14.04) and 3.19 (15.04)
> > > > > there was
> > > > > a regression that caused the mixer elements of the Traktor
> > > > > Audio10
> > > > > driver to stop responding to changes to True.  I have an older
> > > > > machine
> > > > > still running 14.04, and if I open alsamixer I can see and
> > > > > interact
> > > > > with the 8 basic boolean switches:
> > > > > 
> > > > > numid=3,iface=MIXER,name='Direct Thru Channel A'
> > > > >   ; type=BOOLEAN,access=rw------,values=1
> > > > >   : values=off
> > > > > numid=4,iface=MIXER,name='Direct Thru Channel B'
> > > > >   ; type=BOOLEAN,access=rw------,values=1
> > > > >   : values=off
> > > > > numid=5,iface=MIXER,name='Direct Thru Channel C'
> > > > >   ; type=BOOLEAN,access=rw------,values=1
> > > > >   : values=off
> > > > > numid=6,iface=MIXER,name='Direct Thru Channel D'
> > > > >   ; type=BOOLEAN,access=rw------,values=1
> > > > >   : values=off
> > > > > numid=7,iface=MIXER,name='Phono Input Channel A'
> > > > >   ; type=BOOLEAN,access=rw------,values=1
> > > > >   : values=off
> > > > > numid=8,iface=MIXER,name='Phono Input Channel B'
> > > > >   ; type=BOOLEAN,access=rw------,values=1
> > > > >   : values=off
> > > > > numid=9,iface=MIXER,name='Phono Input Channel C'
> > > > >   ; type=BOOLEAN,access=rw------,values=1
> > > > >   : values=off
> > > > > numid=10,iface=MIXER,name='Phono Input Channel D'
> > > > >   ; type=BOOLEAN,access=rw------,values=1
> > > > >   : values=off
> > > > > 
> > > > > 
> > > > > or I can use amixer:
> > > > > amixer -c T10 cset numid=8 on
> > > > > 
> > > > > 
> > > > > however on my newer machine, with ubuntu 15.04 and 15.10, I am
> > > > > unable
> > > > > to change the values to true.  I am a member of the audio group
> > > > > and I
> > > > > have also tried with sudo, but when I try to set the value on
> > > > > nothing
> > > > > happens:
> > > > > 
> > > > > $ amixer -c T10 cset numid=8 on
> > > > > numid=8,iface=MIXER,name='Phono Input Channel B'
> > > > >   ; type=BOOLEAN,access=rw------,values=1
> > > > >   : values=off
> > > > > 
> > > > > The fun part is, if I connect the card to my mac I can set
> > > > > startup
> > > > > conditions for these flags.  I can set them to true, and when I
> > > > > connect
> > > > > to my linux machines the flags start up as true.  And then, even
> > > > > on the
> > > > > newer kernel, I can turn them off!  But I can't turn them back on
> > > > > again.
> > > > > 
> > > > > This sound card is the one I'd like to recommend officially for
> > > > > the
> > > > > Mixxx DJ project so I'd really like to get to the bottom of this
> > > > > issue.
> > > > > 
> > > > > 
> > > > > thanks,
> > > > > Owen Williams
> > > > > 
> > > > > A Lead Developer, Mixxx.org
> > > > 
> > > > 
> > > > _______________________________________________
> > > > Alsa-devel mailing list
> > > > Alsa-devel@alsa-project.org
> > > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > > > 
> > > 
> > > 
> > 
> 
> 
