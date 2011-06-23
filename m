From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Jack event API - decision needed
Date: Thu, 23 Jun 2011 01:42:36 -0700
Message-ID: <20110623084234.GB2493@core.coreip.homeip.net>
References: <4E008A63.5080403@canonical.com>
	<20110621123908.GA25980@opensource.wolfsonmicro.com>
	<4E01C847.7060505@canonical.com>
	<20110622114826.GD18726@opensource.wolfsonmicro.com>
	<BANLkTikGd+3_=JA5rEkpH0iNGkashgT7DQ@mail.gmail.com>
	<20110622132518.GB21802@opensource.wolfsonmicro.com>
	<BANLkTi=YE0hijDwc_7AUXd7Q0xKuAXWxig@mail.gmail.com>
	<20110622151130.GB3019@opensource.wolfsonmicro.com>
	<20110622214153.GA978@core.coreip.homeip.net>
	<20110623001501.GA20949@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E64FE103ABE
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 10:42:48 +0200 (CEST)
Received: by pvg18 with SMTP id 18so1070096pvg.38
	for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2011 01:42:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110623001501.GA20949@opensource.wolfsonmicro.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 23, 2011 at 01:15:01AM +0100, Mark Brown wrote:
> On Wed, Jun 22, 2011 at 02:41:54PM -0700, Dmitry Torokhov wrote:
> > On Wed, Jun 22, 2011 at 04:11:30PM +0100, Mark Brown wrote:
> 
> > > The idea of reporting presence status for USB ports doesn't seem
> > > obviously bad.
> 
> > And so is reporting whether network cable is plugged in. Does not mean
> > that it should be routed through input though.
> 
> Like I said in the message you're replying to I don't really disagree
> with that.  There's a whole section of the mail (which you quoted but I
> didn't respond to)

That is because I mostly agree with you saying that it should be a
generic API, not alsa or other subsystem-specific solution.

> where I tried to clarify the several issues here.
> Just to reiterate once more it's not the fact that people don't like the
> input API, it's the fact that people are proposing solutions which are
> obviously less functional than what we've got right now.
> 
> > > So if what you want to do is create a new API for this sort of switch
> > > rather than do some audio specific thing like you keep saying I guess we
> > > could merge some version of the switch API that the Android guys wrote
> 
> > I do not think you want to have switch API, it is more a 'connection'
> > API that is needed (i.e. we need a way to report and query whether
> > something is connected to something else or not).
> 
> The reason I called it switch is because that's what both the existing
> Android API and the events within input are called.

And I think we should stop calling them switches, if only to avoid
confusion. Input layer originally had notion of switches representing
physical objects that could be toggled on an off and retain their state
(unlike a button that is expected to auto-release). Later jacks were
added as "switches" (which is something I never liked but end up adding
snice we did not have anything better at the time - still don't).

>  It's also not just
> a case of reporting if things are connected, we need to group these
> things together into bundles and link them to multiple other devices in
> the system.

Hmm, I am not sure I follow. We usually need to calssify and group
devices; there is nothing new here...

> 
> > > If we did one of those two things we would still need to deal with all
> > > the same permission management issues that we've got for input devices
> > > at some point.
> 
> > Hmm, the connection changes should normally be infrequent; maybe
> > delivering them over netlink in the same fashion we deliver uevents
> > woudl make sense. In fact, maybe uevents are all that is needed here.
> 
> uevents are what the Android switch API uses.  I think that would have
> some of the daemon issues that David raised, though?

I'll have to locate original email; I am not subscribed to alsa list.

> 
> > > > case to misuse input. In many modern connector cases the jack senses
> > > > are not even buttons anymore, and they should not become buttons for
> > > > userspace.
> 
> > > I do have some passing familiarity with the physical implementations,
> > > thanks.  Note that the presence detection stuff is all reported as
> > > *switches* rather than buttons.
> 
> > Buttons or switches does not really make much difference. They are not
> > really HID devices (unless there are physical switches that can be
> > toggled by the user while device is still plugged into a socket).
> 
> There are such switches on a vast proportion of jacks out there,
> typically presented physically as a button, so we really do want input
> devices in the mix.  To repeat again I'm not saying that they need to be
> the only way a jack is represented.

And I agree here as well.

Thanks.

-- 
Dmitry
