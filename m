From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack event API - decision needed
Date: Thu, 23 Jun 2011 01:15:01 +0100
Message-ID: <20110623001501.GA20949@opensource.wolfsonmicro.com>
References: <20110620234053.GA1905@opensource.wolfsonmicro.com>
	<4E008A63.5080403@canonical.com>
	<20110621123908.GA25980@opensource.wolfsonmicro.com>
	<4E01C847.7060505@canonical.com>
	<20110622114826.GD18726@opensource.wolfsonmicro.com>
	<BANLkTikGd+3_=JA5rEkpH0iNGkashgT7DQ@mail.gmail.com>
	<20110622132518.GB21802@opensource.wolfsonmicro.com>
	<BANLkTi=YE0hijDwc_7AUXd7Q0xKuAXWxig@mail.gmail.com>
	<20110622151130.GB3019@opensource.wolfsonmicro.com>
	<20110622214153.GA978@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D1985103A8C
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 02:15:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110622214153.GA978@core.coreip.homeip.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 22, 2011 at 02:41:54PM -0700, Dmitry Torokhov wrote:
> On Wed, Jun 22, 2011 at 04:11:30PM +0100, Mark Brown wrote:

> > The idea of reporting presence status for USB ports doesn't seem
> > obviously bad.

> And so is reporting whether network cable is plugged in. Does not mean
> that it should be routed through input though.

Like I said in the message you're replying to I don't really disagree
with that.  There's a whole section of the mail (which you quoted but I
didn't respond to) where I tried to clarify the several issues here.
Just to reiterate once more it's not the fact that people don't like the
input API, it's the fact that people are proposing solutions which are
obviously less functional than what we've got right now.

> > So if what you want to do is create a new API for this sort of switch
> > rather than do some audio specific thing like you keep saying I guess we
> > could merge some version of the switch API that the Android guys wrote

> I do not think you want to have switch API, it is more a 'connection'
> API that is needed (i.e. we need a way to report and query whether
> something is connected to something else or not).

The reason I called it switch is because that's what both the existing
Android API and the events within input are called.  It's also not just
a case of reporting if things are connected, we need to group these
things together into bundles and link them to multiple other devices in
the system.

> > If we did one of those two things we would still need to deal with all
> > the same permission management issues that we've got for input devices
> > at some point.

> Hmm, the connection changes should normally be infrequent; maybe
> delivering them over netlink in the same fashion we deliver uevents
> woudl make sense. In fact, maybe uevents are all that is needed here.

uevents are what the Android switch API uses.  I think that would have
some of the daemon issues that David raised, though?

> > > case to misuse input. In many modern connector cases the jack senses
> > > are not even buttons anymore, and they should not become buttons for
> > > userspace.

> > I do have some passing familiarity with the physical implementations,
> > thanks.  Note that the presence detection stuff is all reported as
> > *switches* rather than buttons.

> Buttons or switches does not really make much difference. They are not
> really HID devices (unless there are physical switches that can be
> toggled by the user while device is still plugged into a socket).

There are such switches on a vast proportion of jacks out there,
typically presented physically as a button, so we really do want input
devices in the mix.  To repeat again I'm not saying that they need to be
the only way a jack is represented.
