From: ted <ted@2600.COM>
Subject: Re: No sound output on PowerBook Titanium II (TAS3001c)
 - update
Date: Wed, 27 Aug 2003 19:27:56 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.NEB.4.44.0308271818370.14997-100000@phalse.2600.com>
References: <Pine.NEB.4.44.0308061613140.5288-100000@phalse.2600.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.NEB.4.44.0308061613140.5288-100000@phalse.2600.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 6 Aug 2003, ted wrote:

> On Tue, 22 Jul 2003, ted wrote:
>
> > On Tue, 22 Jul 2003, Takashi Iwai wrote:
> >
> > > > I've been unable to get the latest stable ALSA to produce any sound at
> > > > all.  I even tried the "loading+unloading dmasound_pmac first" trick, but
> > > > to no avail.  Everything looks fine, but applications using ALSA refuse to
> > > > work or crash.  Using OSS emulation appears to work, but there's no sound
> > > > output at all (yes, I've tried maxing out the mixer controls).
> > > >
> > > > Any ideas?
> > > >
> > > > The kernel driver seems to work pretty well, but it only supports a single
> > > > DSP device (which is rather annoying at times, especially since you
> > > > apparently need one for even just console beeps).
> > > >
> > > > System is a PowerBook Titanium II w/ TAS3001c.  Let me know if you need
> > > > more info.  Thanks!
> > >
> > > please tell me the kernel version.  then i can compare the source of
> > > dmasound_pmac to fix the alsa code.
> >
> > I use Ben's stable tree (from http://www.penguinppc.org/dev/kernel.shtml).
> > I'd be happy to test any code changes.  Just let me know.  Thanks!
>
> Any luck with this?  If someone could give me a little direction, I'd be
> willing to give it a shot myself.  Thanks.

In the process of taking a closer look at this problem, I've made the
following discoveries:

1) I can prevent the crashing of XMMS (when using the ALSA output plugin
v0.9.12) by simply:

	a) setting the output plugin buffer time below 200ms, or
	b) disabling its use of mmap

But, still no sound.


2) aplay thinks everything is fine, but there's no sound (with or without
headphones connected - mixers maxed):

# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Tumbler [PowerMac Tumbler], device 0: PMac Tumbler [PowerMac
Tumbler]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
# aplay /usr/lib/MozillaFirebird/res/samples/test.wav
Playing WAVE '/usr/lib/MozillaFirebird/res/samples/test.wav' : Unsigned 8
bit, Rate 22050 Hz, Mono
# aplay /usr/lib/xcdroast-0.98/sound/test.wav
Playing WAVE '/usr/lib/xcdroast-0.98/sound/test.wav' : Signed 16 bit
Little Endian, Rate 44100 Hz, Stereo
#


3) MPlayer gets stuck in a loop trying to reset the device (two examples
using "-ao alsa9" with the latest MPlayer+Gentoo patches):

[snip]
Checking audio filter chain for 24000Hz/2ch/16bit -> 24000Hz/2ch/16bit...
AF_pre: af format: 2 bps, 2 ch, 24000 hz, big endian signed int
AF_pre: 24000Hz 2ch Signed 16-bit (Big-Endian)
alsa-init: testing and bugreports are welcome.
alsa-init: requested format: 24000 Hz, 2 channels, Signed 16-bit
(Big-Endian)
alsa-init: 1 soundcard found, using: hw:0,0
alsa9: 24000 Hz/2 channels/2 bpf/16384 bytes buffer/Signed 16 bit Big
Endian
AO: [alsa9] 24000Hz 2ch Signed 16-bit (Big-Endian) (2 bps)
Building audio filter chain for 24000Hz/2ch/16bit -> 24000Hz/2ch/16bit...
Starting playback...
alsa-play: unknown status, trying to reset soundcard
alsa-play: unknown status, trying to reset soundcard
alsa-play: unknown status, trying to reset soundcard
...
[snip]


[snip]
Checking audio filter chain for 48000Hz/2ch/16bit -> 48000Hz/2ch/16bit...
AF_pre: af format: 2 bps, 2 ch, 48000 hz, big endian signed int
AF_pre: 48000Hz 2ch Signed 16-bit (Big-Endian)
alsa-init: testing and bugreports are welcome.
alsa-init: requested format: 48000 Hz, 2 channels, Signed 16-bit
(Big-Endian)
alsa-init: 1 soundcard found, using: hw:0,0
alsa9: 48000 Hz/2 channels/2 bpf/16384 bytes buffer/Signed 16 bit Big
Endian
AO: [alsa9] 48000Hz 2ch Signed 16-bit (Big-Endian) (2 bps)
Building audio filter chain for 48000Hz/2ch/16bit -> 48000Hz/2ch/16bit...
Starting playback...
alsa-play: unknown status, trying to reset soundcard
alsa-play: unknown status, trying to reset soundcard
alsa-play: unknown status, trying to reset soundcard
...
[snip]


4) Symptoms are still present in v2.6.0-testX kernels.


Any of this ring any bells for anyone?  I'm willing to go over the code
myself, but I have very little driver programming experience, and
therefore no idea where to begin looking for the problem.  :(

Any tips would be greatly appreciated.  Thanks.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
