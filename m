From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: hardware channel mixing
Date: Sat, 04 Sep 2004 19:28:48 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094340528.6575.527.camel@krustophenia.net>
References: <Pine.HPX.4.33n.0409031451550.24397-100000@studcom.urz.uni-halle.de>
	 <1094254221.6575.94.camel@krustophenia.net>
	 <1094260793.3727.19.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1094260793.3727.19.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mjander@users.sourceforge.net
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-09-03 at 21:19, Manuel Jander wrote:
> Hi,
> 
> [snip]
> > Not quite, it's 32 mono substreams, 21 stereo.  Each mono substream
> > requires 2 voices, each stereo substream, three.  There is an extra
> > voice allocated per playback substream that is silent, and is just used
> > to generate the period interrupts.
> > 
> > I have pored over the code, and I don't understand exactly why the extra
> > voice is needed, Jaroslav said something like "if you don't use the
> > extra voice the interrupts are going faster than the voice position".  I
> > think it might be needed so that multiple can playback, each with
> > different period sizes.
> 
> Smells like incomplete hardware spec. Wasting a DMA channel for timing
> purposes sounds pretty stupid, despite it may be the only known way to
> make it work right now.
> 

Doubtful.  The OSS driver does not use the extra voice, so it can be
made to work otherwise.  It looks more like a conscious design decision
to get better latency.

(This is a common knee-jerk reaction to any discussion re: Creative
hardware.  I think people must still be angry with them for "embracing
open source" years ago, then releasing preprocessed, obfuscated drivers
with minimal docs.)

The type of interrupt being used is the channel loop interrupt. 
Presumably this hardware feature is intended for MIDI synth use, and it
was discovered that you could get better output latency for PCM by using
an extra voice as a control channel per substream.

Jaroslav, care to comment? 

> > There is currently no way to open an 8 or 16 channel playback
> > substream.  There are the various plughw surround plugins, but these
> > seem to work by allocating several mono/stereo streams.  This is
> > certainly wasteful - 5.1 surround wastes 2 voices.
> >  
> > I have been planning to add another playback device to the emu10k1
> > driver with one 16-63 channel substream, to correspond to the hw:0,2
> > capture device which can record up to 64 channels.
> 
> There is one problem: If the DMA engine really can demultiplex that many
> interleaved channels

It certainly can, works great for capture.  I can record 8 channels at
32 frames, it works perfectly.  I suspect I could record more but
there's some kind of mixer settings bug.

> , the buffer/period *time* will be pretty low

Yes, this is called 'low latency', and people generally want it.

> . I
> think more than 4 or 6 interleaved channels per DMA is not very sane.

Why?  It's more efficient than handling them in chunks of 4.  This would
be intended for use by the sound server, in this case jackd; you would
launch jackd with an 8 channel input and 8 channel output device,
corresponding to the analog ins and outs on the hardware.  With 16 or 32
channels the rest are just FX buses.  And this all lives in hardware.

>  
> Using several DMA channels would work, but again thats the same as using
> several alsa pcm devices plugged together. The voice waste should be
> eliminated by other means in my opinion.
> 

Not needed, the DMA engine can handle all 64 channels.  64 channels of
16 bit samples at 48000 hz is 6,144 MB/s.  If the emu10k3 increases the
DSP samplerate to 96Khz (hopefully!), and enables 32-bit I/O (the DSP is
already 32 bits but the i/o path is 16), this is still only 24MB/s.  Old
hard drives can do that easily, and they have to wait for data to arrive
from moving parts.

> Would'nt it be time to think about a resource manager ? Something like
> CheckoutVoice() / CheckinVoice() ? Using a resource manager inside a
> individual driver already relieves a lot of problems, but maybe using a
> resource manager at ALSA-LIB level, would not be a bad idea. Just a
> thought that came to my mind...

For the general case, we have one, it works great. 
http://jackit.sf.net.  This is the only thing talks to the sound
hardware on any serious Linux audio setup.  This notion of voices is
fairly specific to the emu10k1 hardware, so it wouldn't make much sense
to manage them anywhere but in the alsa driver.  Check out also
http://ld10k1.sf.net, which is the DSP patch loader.

The alsa plugin layer is actually almost completely unnecessary on the
SBLives, because they can do it all (and more) in hardware.  I don't
know why so many people bash these cards, they are really an amazing
feat of engineering.  The emu10k1 was originally designed to support an
early DAW, the EMU APS, in the days of Win95 and Pentium 90s.  Computers
were not nearly fast enough so they did it all in hardware. 

Lee



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
