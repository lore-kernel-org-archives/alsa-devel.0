From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: sound connector detection
Date: Sun, 02 Jul 2006 10:28:30 +0100
Message-ID: <1151832510.5536.32.camel@localhost.localdomain>
References: <1151671786.13412.6.camel@localhost>
	<200607011609.59426.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200607011609.59426.dtor@insightbb.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, Johannes Berg <johannes@sipsolutions.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Sat, 2006-07-01 at 16:09 -0400, Dmitry Torokhov wrote:
> I am not too happy with putting this kind of switches into input layer,
> it should be reserved for "real" buttons, ones that user can explicitely
> push or toggle 

Playing devil's advocate, by inserting a headphone cable, you push the
switch - the user can explicitly control that switch but inserting or
removing the cable...

> (lid switch is on the edge here but it and sleep button
> are used for similar purposes so it makes sense to have it in input layer
> too). But "cable X connected" kind of events is too much [for input layer,
> there could well be a separate layer for it]. If we go this way we'd have
> to move cable detection code from network to input layer as well ;)

I have mixed feelings about this and can see it from both sides. In a
lot of cases, we need to report these "switch" events to userspace as
only userspace can determine the correct action. Taking some examples,
just from the Zaurus:

Upon lid closure should:
  - the screen/backlight be turned off?
  - the device suspended?

Upon insertion of a headphone jack should:
  - the external speaker be turned on/off?
  - does the jack connect to headphones, a headset, mic or line in
source? (no autodetection so the user has to select and only then can
the mixer be appropriately configured)

Only userspace can make these decisions so we need to pass them there so
it can decide how to handle things. In the case of the Zaurus, we have a
program called zaurusd which listens for the events and knows how to
handle them (http://svn.o-hand.com/view/misc/trunk/zaurusd/). It turns
these events into something the user can influence with scripts.

There is also a question of which USB client to load when  USB client is
detected - again, this insertion event really needs to be passed to
userspace for a decision. I've not touched this issue yet and adding
switch events for client cable detection would probably get frowned
upon?

One thing the input system does well is pass simple switch events to
userspace though its event devices. Not using the input system for
switch like events like these is going to result in code duplication.

I can understand the concern with not wanting to fill the input
subsystem with events that have a tenuous relationship to input devices.
Perhaps the solution is to separate the events layer from the input
layer and start to allow it to handle more generic events?

One of the issues is the ownership of the events data. Currently, you
can't tag a given source of events to a given soundcard. Perhaps each
soundcard would create a separate events device but we need to think
about things like this. Some switch events have no real parent (like the
lid switch on the Zaurus which if anything does belong to the keyboard
driver). Others like the headphone switch on the zaurus arguably belong
to the ASoC sound device (not in mainline yet but coming soon).

In the audio case, there is perhaps an argument for some kind of
scenarios handling where the mixer has some predefined states which get
activated given certain circumstances. The Zaurus ASoC implementations
already sort of implement this having controls which set the headphone
jack mode (headphones, headset, mic, line, off). There is still a need
to ask userspace what was inserted though which requires some kind of
event system.

Even if the audio situation improves, it doesn't solve the general event
case either. Can anyone see a way forward? Would some kind of generic
event code that any device could add to its sysfs directory work? Could
such a thing be abstracted from the input system code?

Richard


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
