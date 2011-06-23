From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack event API - decision needed
Date: Thu, 23 Jun 2011 12:43:19 +0100
Message-ID: <20110623114319.GG21932@opensource.wolfsonmicro.com>
References: <20110620234053.GA1905@opensource.wolfsonmicro.com>
	<4E008A63.5080403@canonical.com>
	<20110621123908.GA25980@opensource.wolfsonmicro.com>
	<4E01C847.7060505@canonical.com>
	<20110622114826.GD18726@opensource.wolfsonmicro.com>
	<BANLkTikGd+3_=JA5rEkpH0iNGkashgT7DQ@mail.gmail.com>
	<20110622132518.GB21802@opensource.wolfsonmicro.com>
	<20110622210131.GA6861@tango.0pointer.de>
	<20110623011045.GB20949@opensource.wolfsonmicro.com>
	<20110623094925.GB25686@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 461D3103846
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 13:43:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110623094925.GB25686@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 23, 2011 at 11:49:25AM +0200, Lennart Poettering wrote:
> On Thu, 23.06.11 02:10, Mark Brown (broonie@opensource.wolfsonmicro.com) wrote:

> >  - We need to represent the fact that multiple subsystems are working
> >    with the same jack.

> Tbh I am not entirely convinced that this is really such an important
> thing. We can't even map audio controls to PCM devices which would be
> vastly more interesting, and we can't even do that.

No disagreement that being able to expose the audio routing within the
devices is needed.

> I can give you a thousand of real-life usecases for wanting to match up
> PCM devices with controls, but the one for wanting to match up HDMI
> audio with HDMI video is much weaker, since machines usually have
> multiple PCM streams, but not multiple HDMI ports.

Apparently that's becoming an issue on desktops with nVidia chipsets -
there's been a moderate amount of discussion on that recently on the
list.

> I am not saying that such a match-up shouldn't be possible, but I'd say
> it could be relatively easy to implement. One option would be to go by
> names. i.e. simply say that if an alsa control device is called "HDMI1
> Jack Sensing", and an X11 XRANDR port is called "HDMI1", then they
> should be the same, and apps should comapre the first words of these
> names, and that both can be traced to the same udev originating device.

You certainly can't assume that the same device will originate all the
functionality on the jack - in embedded systems the way functionality is
built up from blocks on the SoC means that the control bus routing is of
essentially no use in working out how the system looks to the user.

> In fact, something similar is now already in place for external usb
> speakers with built-in volume keys to map X11 XInput keypresses up to PA
> audio devices so that we can map volume keypresses to the appropriate
> audio device in gnome-settings-daemon (note that the latter is not
> making use of this yet, as the infrastructure is still very new): for
> each keypress we can find the originating XInput device, from that we
> can query the kernel device, which we can then find in sysfs. Similarly
> we can find the sysfs device from PA and then do a match-up.

OK, can you point us to a description of what the actual mechanism is
here?  This sounds hopeful, though the fact that nobody knows about it
isn't inspiring.

> If you are thinking about matching up devics across subsystems, you
> should not limit your focus to jack sensing events only: the above
> mentioned key-press use is a lot more interesting -- and is solved.

I have *repeatedly* talked about the need to hook the button presses up
with the rest of the jacks.  Including in the mail you're replying to.

> Also, I'd claim that adding an additional subsystem that covers only
> jack sensing would complicate things even further, since now you have to
> match up audio, video and input devices with this jack sensing device,
> instead of just matching them up directly.

On the other hand it also means you now have to work through any number
of separate APIs (the jack could acquire other functionality beyond
those three) and manually build up a picture of what's there.  I like
the idea that we can point application developers to a thing rather than
them having to infer what's going on from a bunch of separate devices -
the fact that nobody else seems to know about the support you mention is
one of the potential issues with this.

> >  - Even if we invent new interfaces for this we really ought to be able
> >    to teach userspace about existing kernels.

> See, I don't buy this actually. It wouldn't be a regression if we don't
> support the input device based scheme in PA.

On the other hand if we go for doing something completely new it's going
to push back support by I'd guess at least six months.  Which doesn't
seem great.

> > currently work in the application layer due to the way input is handled
> > then like I said above it looks like we have a bunch of other issues we
> > also need to cope with.

> I think bolting proximity detection and docking station stuff into the
> input layer is very wrong too. Both deserve probably their own kind of
> class devices.

I don't really disagree, I'm just saying that we have a broader problem
which we should probably look at those too.
