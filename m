From: Tim Blechmann <TimBlechmann@gmx.net>
Subject: Re: [linux-audio-user] snd-hdsp+cardbus=distortion -- the saga
 continues (cardbus driver=culprit?)
Date: Sat, 27 Mar 2004 01:50:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040327015038.473abab7@laptop>
References: <20040326181517.CZPI16557.smtp2.fuse.net@smtp.fuse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040326181517.CZPI16557.smtp2.fuse.net@smtp.fuse.net>
To: linux-audio-user@music.columbia.edu, alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

hi all,

> NOTE: I am cc-ing this to the kernel list in hope someone there might
> have a better insight in this. For the kernel people who intend to
> respond to this, I would greatly appreciate it if you could CC me, as
> I am not subscribed to the kernel list.
i'm following ico's policy in this way ... i hope a kernel guru can try
and help us ...

> I think that this now has to have something to do with the current
> state of the kernel cardbus drivers (pcmcia-cs has not been updated
> since December so I would assume that they are no better than the one=
s
> that are found in the kernel) and possibly the updated hdsp driver
> (although not entirely sure on this last one).
>=20
> Here's the current scoop on the problem:
>=20
> Windows XP -- stuff works great, everything as expected. The only
> thing is that when the computer goes to standby/hibernate, upon
> resuming the sound is all distorted (just like Tim reported it --
> slower, full of artifacts, but you can still discern the original
> sound's content); this most likely has to do with the crappy BIOS my
> notebook has (esp. in respect to the ACPI and APIC -- DSDT table is
> trashed etc.). After distortion occurs, overclocking the computer
> seems to speed the sound up bringing it closer to the desired playbac=
k
> speed but the artifacts remain. Miller Puckette suggested that perhap=
s
> the hdsp is not getting proper clock info from the CPU, something tha=
t
> I have not investigated as of yet as I do not currently have access t=
o
> an external equipment that would provide Word Clock functionality.
i thought about this, too, but somehow, i doubt it ...
to me it seems, that there are 32 samples of the soundfile followed by
32 samples zero ... i can't prove it with different samplerates, but i
recorded the sounds once using a samplerate of 44100

> Although this also sounds a bit weird as the soundcard works just fin=
e
> upon first boot (prior to suspending the computer). No matter how man=
y
> times I reconnect the card and/! or mess with it before suspending th=
e
> computer, everything continues to work as expected.
this is how derek holzer got his hdsp working with linux, too ... i
don't know if i had similar problems on windows, since i don't have
windows installed on my machine, i can't examine this problem ATM...

> Linux:
> Mandrake Community 10.0
> Kernel 2.6.3
> Plenty of RAM and other junk
> IRQ for cardbus and hdsp is shared on 11 (them sharing the same irq
> IIRC should be normal behavior) Alsa 1.0.2 and 1.0.3 tested (1.0.2
> came with the system, 1.0.3 compiled from source) Latest Jack and
> alsaplayer packages compiled from source
>=20
> Hw:0 onboard via82xx
> Hw:1 snd-hdsp
>=20
> ACPI and APIC are disabled due to BIOS issues with the laptop and
> because even with the pci=3Dnoacpi flag in lilo the system still free=
zes
> when inserting cardbus. I saw somewhere a kernel patch that would
> enable use of cardbus with a limited acpi presence (pci=3Dnoacpi) but
> have not tried using it just yet mainly since presence of acpi should
> not have any positive bearing on resolving this issue (if anything, i=
t
> would make it even worse due to IRQ shuffling).
>=20
> Modprobing goes without a hitch, pcmcia service automatically starts,
> the cardbus interface using yenta_socket driver. Snd-hdsp also works
> without a hitch and configuring the soundcard is all ok (hdsploader,
> hdspconf, hdspmixer all check-out fine).
loading the firmware with hdsploader works fine for me, too, but there
is the following message on dmesg's output:
wait for FIFO status <=3D0 failed after 30 iterations

> aplay =96D plughw:1 (or plughw:hw:1 forget the exact syntax =96 curre=
ntly
> booted into Windoze) <soundfile>  plays the sound distorted similarly
> like in Windows after resume.
>=20
> Jackd =96d alsa =96d hw:1 with various flags and sampling rates of ei=
ther
> 44100 or 48000 works without any dropouts. Just like with Tim, no
> distortion is coming through until the sound is played. During the
> sound playback, the distortion is identical to the one during the
> playback without jackd.
could you try to start jack as super user: jackd -R -d alsa -d hw:1
if i do this with sample rates higher than 32000 i get messages like:
delay of xxx usecs exceeds estimated spare time of yyy; restart ...
at the default sample rate of 48000 xxx only about 0.06 % bigger than
yyy...
there are problems reported to be related to the latency timer ... the
above would suggest that, too ...
but it wouldn't explain, this problems with the audio routing ... and i
tried nearly any latency setting i can think off...

> Alsaplayer when connected via jackd also works but again distorted. I
> have to put the playback at 200% speed to get the right =93tempo=94 o=
f the
> song but the sound of the song=92s singer is now very high-pitched
> (chipmunk?). Distortion persists no matter what.
see above ... 32 samples of the soundfile followed by 32 samples zero
=2E..


> Some have suggested switching distros, but my understanding is that
> Tim was running gentoo and I am running Mandrake and we=92re both hav=
ing
> the same problem=85
and timothy is using red hat ...=20

> Tim, I believe also used 2.4 kernel without success, as well as
> pre-1.0 Alsa drivers.
yep...


i just want to add something:
the hdsp has an 26 channel matrix mixer on the external device ... for
the mixing, there is no transfer of the audio data to or from the
computer itself (in fact, you can use it as standalone mixer, unpluggin=
g
it from the computer ... at least thomas charbonnel was working on
that).
if you try to route signal to the computer some of the samples that
should be sent to the computer, are copied to the playback buffer (mayb=
e
the other 32 samples of silence during playback???). since the hardware
is working fine on other computers / windows, it can either happen
inside the buffer of the cardbus bridge or the kernel / alsa driver.
ico, timothy, if you are able to record your output, it would be
interesting to the soundfiles, if you are both playing back and getting
input ... if the missing samples are replaced by the input, there's
probably some kind of wrong offset (please correct me if i'm saying
something completely stupid)...
and ico, timothy, are you able to record with the hdsp?

good night ...

 Tim                          mailto:TimBlechmann@gmx.de
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac
