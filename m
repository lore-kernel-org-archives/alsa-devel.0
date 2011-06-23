From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack event API - decision needed
Date: Thu, 23 Jun 2011 02:10:47 +0100
Message-ID: <20110623011045.GB20949@opensource.wolfsonmicro.com>
References: <20110620170739.GD32056@opensource.wolfsonmicro.com>
	<4DFF973A.1080404@canonical.com>
	<20110620234053.GA1905@opensource.wolfsonmicro.com>
	<4E008A63.5080403@canonical.com>
	<20110621123908.GA25980@opensource.wolfsonmicro.com>
	<4E01C847.7060505@canonical.com>
	<20110622114826.GD18726@opensource.wolfsonmicro.com>
	<BANLkTikGd+3_=JA5rEkpH0iNGkashgT7DQ@mail.gmail.com>
	<20110622132518.GB21802@opensource.wolfsonmicro.com>
	<20110622210131.GA6861@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C913024554
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 03:10:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110622210131.GA6861@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 22, 2011 at 11:01:31PM +0200, Lennart Poettering wrote:
> On Wed, 22.06.11 14:25, Mark Brown (broonie@opensource.wolfsonmicro.com) wrote:
> > On Wed, Jun 22, 2011 at 02:50:59PM +0200, Kay Sievers wrote:

> Input devices should really just be used for input, i.e. interfacing
> with humans via keyboards, mice, joystick, touchscreens and

Once more: there are several mostly orthogonal issues here which are
getting conflated a bit.  The main ones are:

 - We need to represent the fact that multiple subsystems are working
   with the same jack.
 - People don't like the fact that we're currently reporting state via
   the input API.
 - Even if we invent new interfaces for this we really ought to be able
   to teach userspace about existing kernels.

Like Stephen says the first point is vital and it's the major thing I'm
missing with the idea of doing everything per subsystem but it's the one
which you and Kay aren't really addressing.  We need some way for
userspace to figure out that a jack exists and that it contains multiple
functionalities from multiple subsystems.  If we have a proposal for how
we do that which seems viable then great, but we don't have that yet.

> suchlike. However Jack sensing does not qualify as such. The main reason
> why input device exist to do jack sensing right now appears to be that
> there was no other infrastructure readily available for it. But that is

No, that's not the case.  If you look at the changelogs when this was
added the Zaurus systems that were the main driving force had a bunch of
switches in them, one of which was a microswitch for detecting physical
insertion of jacks, so implementing them as switches was fairly natural.
When I did the more detailed jack support within ALSA and ASoC I looked
at what we were doing at the time, didn't see any massive problems with
it (it probably wouldn't have been my first choice) and just worked with
the existing ABI.

Personally it's not using the input API in particular that I'm concerned
about, it's the fact that the way we're using it at the minute gives us
a single thing to point at in userspace.  Although that said some of the
discussion came from the fact that looking at this does make me think we
have several other problems with how we're using and handling input in
both kernel and userspace right now and perhaps it's best to fix up the
current situation up (at least in userspace) even if we change things
later.

> aren't really clear yet but not for the long run. On top of that there
> actually always has been a more appropriate place for signalling audio
> jack sensing events: the alsa control layer. Because that is what Jack
> sensing ultimately is: audio control. And if you have it in audio

No, not at all - it's easy to make this assumption in the basic PC space
(though you do still have to dismiss HDMI) but as soon as you start to
look at a wider range of systems systems you just start to see issues.
If you've got a jack which only carries audio data then obviously that's
all it's there for but as you start to carry additional functionality
over the one connector it becomes more and more difficult to take that
view.

> On top of that Takashi has patches ready to port HDA over to jack
> sensing via control devices, and hence I believe this is definitely the
> way to go.

I really hope it's not just for HDA, that would again be a loss.

> Jack sensing for video plugs should similarly be handled by the video
> layer -- and actually is handled like that for VGA hotplug already.

Actually one other issue here is that physically the jack sensing is
generally done over the jack as a whole in some way so even if we don't
make it user visible we're going to want some general interface within
the kernel to glue stuff together.

> HDMI is a composite technology, but I don't think this should be used as
> excuse to implement jack sensing via an independent subsystem. If it is
> composite it should simply use the native sensing interfaces for its
> technologies, i.e. send plug notifications via both video and audio
> control, the way they want.

That's certainly simpler for programs which only work within a single
subsystem but as soon as you care about the system as a whole it becomes
less clear, especially given that the proposals to do subsystem specific
things haven't included any suggestion about how userspace should work
out that the different objects are connected to each other.

One of the use cases I thought about with this was that if you're on a
phone call with headset and simultaneously playing a movie via HDMI it's
going to be important to make sure that you work out which jack any
button press events came from in order to decide if you should pause the
move or hang up the call.

> > To summarise some of the issues from the rest of the thread:

> >  - This isn't a new interface at all, it's been implemented in the
> >    kernel for quite some time now (the first switch was added in
> >    2.6.18).  All that's changed here is that PulseAudio is trying to
> >    use the information that the kernel is exporting.

> It's not a new interface, but it will be used for the first time in a
> big way that will find its way into generic distros. That means it is
> still time to get this right before this is too late.

Generic *desktop* distros.  There's also the issue I see with other
non-jack but similar functionality which is currently made available via
the same mechanism - the question which I was asking earlier was how
things currently work for them or if we're just happening to look at
this one problem first.

> You should also not forget that having a fucked up kernel interface
> usually means a lot of additional work to work around that in userspace:
> i.e. in PA we need some way to match up input devices with alsa control
> devices and specific controls. That is messy, requires knowledge and
> logic that would be much much simpler if we could just access jack
> sensing via the same interface as the rest of the audio control stuff we do.

Right, but hopefully this means you can appreciate the concerns that I
and Stephen have expressed about being able to join the different bits
of the jack up with each other for programs which do care about things
over more than one subsystem?

> >  - Many jacks include buttons so need an input device anyway which again
> >    we want to join up with the other functions.

> Well, if you are speaking of headsets here with specific Play and Stop
> buttons then I believe those actually qualify as proper input keys, and
> it is the right thing to route them via the input layer. And if we do X
> and GNOME and Rhythmbox will actually already handle them as they should.

Yes, they do - on a system wide basis.

> >  - We still need to handle cases where the jack isn't particularly
> >    closely connected to the audio subsystem.

> Well, I am tempted to say that this should be handled in kernel. I am
> not convinced that it is a good idea to expose particularities of the hw
> design too much in userspace. In fact, I agree with David that the
> thinkpad laptop driver would best integrate directly with HDA so that in
> userspace no knowledge about their relation would be necessary.

Yeah, that's just one example - I was actually thinking of the sort of
large many function connectors in the style of docking stations you can
get (and I guess docking stations too) and need to get to play together.

> >  - There are other non-audio non-jack things being exposed via the same
> >    interface which we need to have some method for handling even if we
> >    end up doing something audio specific for some subset of jacks.

> This exists for VGA hotplug at least. I see no reason why this shouldn't
> be available for HDMI as well.

That's not my point - I'm talking about things like the docking station
or front proximity detection that are clearly not at all related to
jacks but are going out via the same interface.  If jacks don't
currently work in the application layer due to the way input is handled
then like I said above it looks like we have a bunch of other issues we
also need to cope with.
