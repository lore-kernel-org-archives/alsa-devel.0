From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Jack event API - decision needed
Date: Wed, 22 Jun 2011 14:41:54 -0700
Message-ID: <20110622214153.GA978@core.coreip.homeip.net>
References: <4DFF973A.1080404@canonical.com>
	<20110620234053.GA1905@opensource.wolfsonmicro.com>
	<4E008A63.5080403@canonical.com>
	<20110621123908.GA25980@opensource.wolfsonmicro.com>
	<4E01C847.7060505@canonical.com>
	<20110622114826.GD18726@opensource.wolfsonmicro.com>
	<BANLkTikGd+3_=JA5rEkpH0iNGkashgT7DQ@mail.gmail.com>
	<20110622132518.GB21802@opensource.wolfsonmicro.com>
	<BANLkTi=YE0hijDwc_7AUXd7Q0xKuAXWxig@mail.gmail.com>
	<20110622151130.GB3019@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id DD98D24462
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 23:42:05 +0200 (CEST)
Received: by pvg18 with SMTP id 18so821065pvg.38
	for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2011 14:42:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110622151130.GB3019@opensource.wolfsonmicro.com>
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

On Wed, Jun 22, 2011 at 04:11:30PM +0100, Mark Brown wrote:
> On Wed, Jun 22, 2011 at 03:55:46PM +0200, Kay Sievers wrote:
> > On Wed, Jun 22, 2011 at 15:25, Mark Brown
> =

> > > It would really helpful if you could engage with some of the discussi=
on
> > > about this... =A0Apart from anything else "fake" seems a bit misleadi=
ng,
> > > a jack is a physical thing which really exists and which I can point =
to
> > > on the system and in may cases has buttons on it.
> =

> > We should stop misusing input for anything that isn't user a real
> > input device like a keyboard button, mouse, joystick, screen, tablet
> > like interface. Otherwise, I fear, with that logic anything with a
> > physical state change could become an input device. USB would then
> > make a good case too, to have all ports as individual input devices,
> > telling us if anything is plugged in or out, and so on ...
> =

> The idea of reporting presence status for USB ports doesn't seem
> obviously bad.

And so is reporting whether network cable is plugged in. Does not mean
that it should be routed through input though.

> =

> > The kernel's input just has some sensible event relay interface, that
> > should not be the reason to put everything that has a state and can
> > change its state as an input device. People should come up with their
> > own event channel instead of just lazily misuse input for unrelated
> > things.
> =

> So if what you want to do is create a new API for this sort of switch
> rather than do some audio specific thing like you keep saying I guess we
> could merge some version of the switch API that the Android guys wrote
> because they didn't notice the existing functionality.  Currently it'd
> need quite a bit of work from what I remember, it's very basic, and
> there's going to be a transition period where we move all or most of the
> various existing users of switches out of the input API.

I do not think you want to have switch API, it is more a 'connection'
API that is needed (i.e. we need a way to report and query whether
something is connected to something else or not).

> =

> One can, of course, flip this around and say that what we should really
> be doing is factoring the event delivery mechanism out of the input
> layer and into a generic subsystem where it can be reused so we don't
> have to reinvent the wheel.  The transition issues do apply there too
> but probably less so and it seems like we'd end up with less redundant
> code.
> =

> If we did one of those two things we would still need to deal with all
> the same permission management issues that we've got for input devices
> at some point.

Hmm, the connection changes should normally be infrequent; maybe
delivering them over netlink in the same fashion we deliver uevents
woudl make sense. In fact, maybe uevents are all that is needed here.

> =

> > HDMI exposes an ALSA interface if audio is involved, and that ALSA can
> > send events, just as the associated video interface can send video
> > related events. That there is a single connector does again not make a
> > case to use input for it, it's an hot-pluggable audio/video
> > connection, not an input device.
> =

> There's two orthogonal issues here which you keep confusing.  =

> =

> One is that you keep saying to add a new audio specific API to replace
> the existing API.  This seems like a clear loss to me, we're currently
> able to represent multi function jacks as a single object to the
> application layer and we'd loose that ability.  That seems like a
> failure.
> =

> The other is that you don't like the fact that the input layer has been
> used for this stuff.  This seems like a more valid point, the main
> issues are implementation and deployment, but you keep suggesting an
> audio specific solution.
> =

> > > =A0- This isn't a new interface at all, it's been implemented in the
> > > =A0 kernel for quite some time now (the first switch was added in
> > > =A0 2.6.18).
> =

> > Which does not make it correct, or any more tasteful. It's just wrong
> > to misuse input for subsystem specific plugging events not related to
> > input.
> =

> You keep saying subsystem specific here - like I keep on saying I don't
> think that reflects the reality of the hardware we've got currently.
> =

> > If these devices should be removed ever, or at what time if so, is
> > nothing we need to discuss now. But we should not start using them in
> > _new_ stuff. They are just wrong from the beginning.
> =

> Well, deciding that we want to ditch the current API doesn't really help
> people like David who are trying to use the current kernel - userspace
> has a lot of the information right now, it's just having a hard time
> figuring out how to talk to itself.  That's a third mostly orthogonal
> problem.
> =

> > >   All that's changed here is that PulseAudio is trying to
> > > =A0 use the information that the kernel is exporting.
> =

> > Right, And we don't want to use mis-designed interfaces if we don't
> > need to. And as we are not in a hurry and have the option of a native
> > ALSA control interface, we should focus on that.
> =

> I don't think it makes any sense to push for an audio specific solution.
> =

> > > =A0- Mixed function jacks aren't that unusual; if anything they're mo=
re
> > > =A0 common on PCs than anything else. =A0HDMI is the obvious one for =
PC
> > > =A0 class hardware and where these things happen we do need to be abl=
e to
> > > =A0 join the audio and the video up with each other.
> =

> > Sure. But again, HDMI has in no way any button or input. This is about
> > hot-plugging of audio/video devices. Just let ALSA _and_ the video
> > device send the event.
> =

> I'm not so sure about that, I believe there's some mechanism for
> propagating events through HDMI links for things like volume changes
> which we don't currently support and I'd not be surprised if they didn't
> look like buttons.  Besides if you don't like HDMI as an example there's
> also four pole analogue jacks that can do video, audio and buttons.  I'm
> mostly just mentioning HDMI because it's a blatantly obvious example
> seen on PCs.
> =

> Besides, userspace needs some way to figure out that the two events are
> connected and that they're also connected with anything else that
> appared as part of the same accessory detection.
> =

> > > =A0- Many jacks include buttons so need an input device anyway which =
again
> > > =A0 we want to join up with the other functions.
> =

> > I disagree. They are states for the associated class of devices, they
> > are not sensible input devices today and probably will never really be
> > such.
> =

> Please read what I wrote, this is for *buttons*.  For example, I'm
> sitting here with a headset that has play/pause, rewind and fast forward
> buttons on it.  Pretty much every headset used with phones has at least
> one such button.
> =

> > > =A0- We still need to handle cases where the jack isn't particularly
> > > =A0 closely connected to the audio subsystem.
> =

> > Sure, that might need to be solved by some mapping, still makes no
> =

> So again why the push to come up with an audio specific solution?  We
> can see right now that it's got some issues with current hardware.
> =

> > case to misuse input. In many modern connector cases the jack senses
> > are not even buttons anymore, and they should not become buttons for
> > userspace.
> =

> I do have some passing familiarity with the physical implementations,
> thanks.  Note that the presence detection stuff is all reported as
> *switches* rather than buttons.

Buttons or switches does not really make much difference. They are not
really HID devices (unless there are physical switches that can be
toggled by the user while device is still plugged into a socket).

-- =

Dmitry
