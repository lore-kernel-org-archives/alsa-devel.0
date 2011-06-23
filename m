From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Jack event API - decision needed
Date: Thu, 23 Jun 2011 11:49:25 +0200
Message-ID: <20110623094925.GB25686@tango.0pointer.de>
References: <4DFF973A.1080404@canonical.com>
	<20110620234053.GA1905@opensource.wolfsonmicro.com>
	<4E008A63.5080403@canonical.com>
	<20110621123908.GA25980@opensource.wolfsonmicro.com>
	<4E01C847.7060505@canonical.com>
	<20110622114826.GD18726@opensource.wolfsonmicro.com>
	<BANLkTikGd+3_=JA5rEkpH0iNGkashgT7DQ@mail.gmail.com>
	<20110622132518.GB21802@opensource.wolfsonmicro.com>
	<20110622210131.GA6861@tango.0pointer.de>
	<20110623011045.GB20949@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id A9DDB2432E
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 11:50:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110623011045.GB20949@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 23.06.11 02:10, Mark Brown (broonie@opensource.wolfsonmicro.com) wrote:

> 
> On Wed, Jun 22, 2011 at 11:01:31PM +0200, Lennart Poettering wrote:
> > On Wed, 22.06.11 14:25, Mark Brown (broonie@opensource.wolfsonmicro.com) wrote:
> > > On Wed, Jun 22, 2011 at 02:50:59PM +0200, Kay Sievers wrote:
> 
> > Input devices should really just be used for input, i.e. interfacing
> > with humans via keyboards, mice, joystick, touchscreens and
> 
> Once more: there are several mostly orthogonal issues here which are
> getting conflated a bit.  The main ones are:
> 
>  - We need to represent the fact that multiple subsystems are working
>    with the same jack.

Tbh I am not entirely convinced that this is really such an important
thing. We can't even map audio controls to PCM devices which would be
vastly more interesting, and we can't even do that.

I can give you a thousand of real-life usecases for wanting to match up
PCM devices with controls, but the one for wanting to match up HDMI
audio with HDMI video is much weaker, since machines usually have
multiple PCM streams, but not multiple HDMI ports.

I am not saying that such a match-up shouldn't be possible, but I'd say
it could be relatively easy to implement. One option would be to go by
names. i.e. simply say that if an alsa control device is called "HDMI1
Jack Sensing", and an X11 XRANDR port is called "HDMI1", then they
should be the same, and apps should comapre the first words of these
names, and that both can be traced to the same udev originating device.

In fact, something similar is now already in place for external usb
speakers with built-in volume keys to map X11 XInput keypresses up to PA
audio devices so that we can map volume keypresses to the appropriate
audio device in gnome-settings-daemon (note that the latter is not
making use of this yet, as the infrastructure is still very new): for
each keypress we can find the originating XInput device, from that we
can query the kernel device, which we can then find in sysfs. Similarly
we can find the sysfs device from PA and then do a match-up.

So, what I am saying here is that doing this cross-subsystem match-up in
other areas is already possible. It's not beautiful, but it works.

If you are thinking about matching up devics across subsystems, you
should not limit your focus to jack sensing events only: the above
mentioned key-press use is a lot more interesting -- and is solved.

Also, I'd claim that adding an additional subsystem that covers only
jack sensing would complicate things even further, since now you have to
match up audio, video and input devices with this jack sensing device,
instead of just matching them up directly.

>  - Even if we invent new interfaces for this we really ought to be able
>    to teach userspace about existing kernels.

See, I don't buy this actually. It wouldn't be a regression if we don't
support the input device based scheme in PA.

> > >  - There are other non-audio non-jack things being exposed via the same
> > >    interface which we need to have some method for handling even if we
> > >    end up doing something audio specific for some subset of jacks.
> 
> > This exists for VGA hotplug at least. I see no reason why this shouldn't
> > be available for HDMI as well.
> 
> That's not my point - I'm talking about things like the docking station
> or front proximity detection that are clearly not at all related to
> jacks but are going out via the same interface.  If jacks don't
> currently work in the application layer due to the way input is handled
> then like I said above it looks like we have a bunch of other issues we
> also need to cope with.

I think bolting proximity detection and docking station stuff into the
input layer is very wrong too. Both deserve probably their own kind of
class devices.

Lennart

-- 
Lennart Poettering - Red Hat, Inc.
