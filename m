From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: hardware channel mixing
Date: Sat, 04 Sep 2004 23:02:59 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094353379.2044.86.camel@localhost>
References: <Pine.HPX.4.33n.0409031451550.24397-100000@studcom.urz.uni-halle.de>
	 <1094254221.6575.94.camel@krustophenia.net>
	 <1094260793.3727.19.camel@localhost>
	 <1094340528.6575.527.camel@krustophenia.net>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1094340528.6575.527.camel@krustophenia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Lee,

On Sat, 2004-09-04 at 19:28, Lee Revell wrote:
> On Fri, 2004-09-03 at 21:19, Manuel Jander wrote:
> > Hi,
> > 
> > [snip]
> > > There is currently no way to open an 8 or 16 channel playback
> > > substream.  There are the various plughw surround plugins, but these
> > > seem to work by allocating several mono/stereo streams.  This is
> > > certainly wasteful - 5.1 surround wastes 2 voices.
> > >  
> > > I have been planning to add another playback device to the emu10k1
> > > driver with one 16-63 channel substream, to correspond to the hw:0,2
> > > capture device which can record up to 64 channels.
> > 
> > There is one problem: If the DMA engine really can demultiplex that many
> > interleaved channels
> 
> It certainly can, works great for capture.  I can record 8 channels at
> 32 frames, it works perfectly.  I suspect I could record more but
> there's some kind of mixer settings bug.

Using one single DMA channel ?

> > , the buffer/period *time* will be pretty low
> 
> Yes, this is called 'low latency', and people generally want it.

Yeah, but if you don't even have enough time to handle IRQs ? That
certainly leaves you very little CPU time for other tasks. Going into
the extreme doesn't work. There must be a minimum of latency.

> > . I
> > think more than 4 or 6 interleaved channels per DMA is not very sane.
> 
> Why?  It's more efficient than handling them in chunks of 4.  This would
> be intended for use by the sound server, in this case jackd; you would
> launch jackd with an 8 channel input and 8 channel output device,
> corresponding to the analog ins and outs on the hardware.  With 16 or 32
> channels the rest are just FX buses.  And this all lives in hardware.

No need to handle them in chunks of specifically 4. But using more than
one single DMA channel to relieve the CPU. If not, it would be better
using programmed I/O instead of DMA.

> >  
> > Using several DMA channels would work, but again thats the same as using
> > several alsa pcm devices plugged together. The voice waste should be
> > eliminated by other means in my opinion.
> > 
> 
> Not needed, the DMA engine can handle all 64 channels.  64 channels of
> 16 bit samples at 48000 hz is 6,144 MB/s.  If the emu10k3 increases the
> DSP samplerate to 96Khz (hopefully!), and enables 32-bit I/O (the DSP is
> already 32 bits but the i/o path is 16), this is still only 24MB/s.  Old
> hard drives can do that easily, and they have to wait for data to arrive
> from moving parts.

Of course it can :D. Thats not the question. The question is if ONE
single DMA _channel_ (not the entire engine) can handle 64 PCM audio
streams. The problem is not bandwith. The problem is that the size of
one single frame gets too close to the max period size.
A PCI bus always uses its full width (32bits mostly), there is no need
to care about that.

> > Would'nt it be time to think about a resource manager ? Something like
> > CheckoutVoice() / CheckinVoice() ? Using a resource manager inside a
> > individual driver already relieves a lot of problems, but maybe using a
> > resource manager at ALSA-LIB level, would not be a bad idea. Just a
> > thought that came to my mind...
> 
> For the general case, we have one, it works great. 
> http://jackit.sf.net.  This is the only thing talks to the sound
> hardware on any serious Linux audio setup.  This notion of voices is
> fairly specific to the emu10k1 hardware, so it wouldn't make much sense
> to manage them anywhere but in the alsa driver.  Check out also
> http://ld10k1.sf.net, which is the DSP patch loader.

No. Most modern audio cards have plenty DMA channels:
Aureal Vortex: 96
NVidia Soundstorm: 256
Trident 4D: 64 (or more)
(that are the few a have read the specs for).

jackd seems great as a resource manager, but currently it is unable to
handle advanced channel paramenters as HRTF, filters, and such (it could
maybe added ?). If you have a mix of different channels with different
capabilities, its not a minor task to allocate them in a apropriate
fashion. You may want to have some kind of software fallback too and you
start getting a headache. Thats where a resource manager could make a
difference.

> The alsa plugin layer is actually almost completely unnecessary on the
> SBLives, because they can do it all (and more) in hardware.  I don't
> know why so many people bash these cards, they are really an amazing
> feat of engineering.  The emu10k1 was originally designed to support an
> early DAW, the EMU APS, in the days of Win95 and Pentium 90s.  Computers
> were not nearly fast enough so they did it all in hardware. 

Its not the only and not the first of that kind... Hopefuly somebody
would implemente something interesting.

Best Regards

Manuel Jander




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
