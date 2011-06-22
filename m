From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Jack event API - decision needed
Date: Wed, 22 Jun 2011 23:01:31 +0200
Message-ID: <20110622210131.GA6861@tango.0pointer.de>
References: <4DFF4D15.6050809@canonical.com>
	<20110620170739.GD32056@opensource.wolfsonmicro.com>
	<4DFF973A.1080404@canonical.com>
	<20110620234053.GA1905@opensource.wolfsonmicro.com>
	<4E008A63.5080403@canonical.com>
	<20110621123908.GA25980@opensource.wolfsonmicro.com>
	<4E01C847.7060505@canonical.com>
	<20110622114826.GD18726@opensource.wolfsonmicro.com>
	<BANLkTikGd+3_=JA5rEkpH0iNGkashgT7DQ@mail.gmail.com>
	<20110622132518.GB21802@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id CD1FE243DD
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 23:02:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110622132518.GB21802@opensource.wolfsonmicro.com>
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

On Wed, 22.06.11 14:25, Mark Brown (broonie@opensource.wolfsonmicro.com) wrote:

> 
> On Wed, Jun 22, 2011 at 02:50:59PM +0200, Kay Sievers wrote:
> 
> > I'm still pretty sure that there should be no fake input devices
> > involved for any jack related things. Especially not in the simple and
> > common desktop case, where the input devices are created by, and
> > direct child devices of the ALSA card device (like Intel HDA). I'm
> > sure, such things just belong to the ALSA control device directly.
> 
> It would really helpful if you could engage with some of the discussion
> about this...  Apart from anything else "fake" seems a bit misleading,
> a jack is a physical thing which really exists and which I can point to
> on the system and in may cases has buttons on it.

I fully agree with Kay here btw.

Input devices should really just be used for input, i.e. interfacing
with humans via keyboards, mice, joystick, touchscreens and
suchlike. However Jack sensing does not qualify as such. The main reason
why input device exist to do jack sensing right now appears to be that
there was no other infrastructure readily available for it. But that is
a poor excuse, which might be acceptable early in the game where things
aren't really clear yet but not for the long run. On top of that there
actually always has been a more appropriate place for signalling audio
jack sensing events: the alsa control layer. Because that is what Jack
sensing ultimately is: audio control. And if you have it in audio
control this has many benefits: for example it's in the same namespace
as the other audio controls (a very weakly defined namespace, but still
the same namespace), so you could by employing some rules match up mute
and volume controls with their matching jacks.

On top of that Takashi has patches ready to port HDA over to jack
sensing via control devices, and hence I believe this is definitely the
way to go.

Jack sensing for video plugs should similarly be handled by the video
layer -- and actually is handled like that for VGA hotplug already.

HDMI is a composite technology, but I don't think this should be used as
excuse to implement jack sensing via an independent subsystem. If it is
composite it should simply use the native sensing interfaces for its
technologies, i.e. send plug notifications via both video and audio
control, the way they want.

There are a number of other non-input technologies that have been bolted
into the input subsystem, but that is really not an excuse to bolt even
more into them. 

> To summarise some of the issues from the rest of the thread:
> 
>  - This isn't a new interface at all, it's been implemented in the
>    kernel for quite some time now (the first switch was added in
>    2.6.18).  All that's changed here is that PulseAudio is trying to
>    use the information that the kernel is exporting.

It's not a new interface, but it will be used for the first time in a
big way that will find its way into generic distros. That means it is
still time to get this right before this is too late.

You should also not forget that having a fucked up kernel interface
usually means a lot of additional work to work around that in userspace:
i.e. in PA we need some way to match up input devices with alsa control
devices and specific controls. That is messy, requires knowledge and
logic that would be much much simpler if we could just access jack
sensing via the same interface as the rest of the audio control stuff we do.

>  - Mixed function jacks aren't that unusual; if anything they're more
>    common on PCs than anything else.  HDMI is the obvious one for PC
>    class hardware and where these things happen we do need to be able to
>    join the audio and the video up with each other.

As mentioned this is not really an excuse as nothing stops you from
sending out plug events via both the audio and the video subsystem

>  - Many jacks include buttons so need an input device anyway which again
>    we want to join up with the other functions.

Well, if you are speaking of headsets here with specific Play and Stop
buttons then I believe those actually qualify as proper input keys, and
it is the right thing to route them via the input layer. And if we do X
and GNOME and Rhythmbox will actually already handle them as they should.

>  - We still need to handle cases where the jack isn't particularly
>    closely connected to the audio subsystem.

Well, I am tempted to say that this should be handled in kernel. I am
not convinced that it is a good idea to expose particularities of the hw
design too much in userspace. In fact, I agree with David that the
thinkpad laptop driver would best integrate directly with HDA so that in
userspace no knowledge about their relation would be necessary.

>  - There are other non-audio non-jack things being exposed via the same
>    interface which we need to have some method for handling even if we
>    end up doing something audio specific for some subset of jacks.

This exists for VGA hotplug at least. I see no reason why this shouldn't
be available for HDMI as well.

Lennart

-- 
Lennart Poettering - Red Hat, Inc.
