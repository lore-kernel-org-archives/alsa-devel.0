From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: hardware channel mixing
Date: Sun, 05 Sep 2004 01:06:06 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094360766.6575.636.camel@krustophenia.net>
References: <Pine.HPX.4.33n.0409031451550.24397-100000@studcom.urz.uni-halle.de>
	 <1094254221.6575.94.camel@krustophenia.net>
	 <1094260793.3727.19.camel@localhost>
	 <1094340528.6575.527.camel@krustophenia.net>
	 <1094353379.2044.86.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1094353379.2044.86.camel@localhost>
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

On Sat, 2004-09-04 at 23:02, Manuel Jander wrote:
> Hi Lee,
> 
> On Sat, 2004-09-04 at 19:28, Lee Revell wrote:
> > On Fri, 2004-09-03 at 21:19, Manuel Jander wrote:
> > > Hi,
> > > 
> > > [snip]
> > > > There is currently no way to open an 8 or 16 channel playback
> > > > substream.  There are the various plughw surround plugins, but these
> > > > seem to work by allocating several mono/stereo streams.  This is
> > > > certainly wasteful - 5.1 surround wastes 2 voices.
> > > >  
> > > > I have been planning to add another playback device to the emu10k1
> > > > driver with one 16-63 channel substream, to correspond to the hw:0,2
> > > > capture device which can record up to 64 channels.
> > > 
> > > There is one problem: If the DMA engine really can demultiplex that many
> > > interleaved channels
> > 
> > It certainly can, works great for capture.  I can record 8 channels at
> > 32 frames, it works perfectly.  I suspect I could record more but
> > there's some kind of mixer settings bug.
> 
> Using one single DMA channel ?
> 

Yes.  Although, this is a unique feature of the FX8010 capture device. 
For capture there is only a single DMA channel for the FX8010 and you
set bits in a hardware register to select which of the the 64 FX8010
outputs you want to record.  The hardware imposes some sanity, there is
a fixed table of allowed buffer sizes, and the number of channels record
must be a power of two.

The playback hardware does not work this way.  You can only do one mono
PCM stream per DMA channel.  My proposal would still use one DMA channel
per mono PCM, but where the driver currently will only allocate voices
one or two at a time (which is two or three with the extra voice), this
would use 17 voices - 16 "data channels" and the "control channel" aka
the extra voice.

> > > , the buffer/period *time* will be pretty low
> > 
> > Yes, this is called 'low latency', and people generally want it.
> 
> Yeah, but if you don't even have enough time to handle IRQs ? That
> certainly leaves you very little CPU time for other tasks. Going into
> the extreme doesn't work. There must be a minimum of latency.
> 

I agree, 32 frames is a bit extreme, this is what I use for stress
testing.  I think 8 channels at 32 frames is exactly the limit of the
hardware.  You actually can't record 4 channels at 32 frames, because
that would require a smaller buffer than the hardware supports, so you
have to record more channels to get lower latency.

> > > . I
> > > think more than 4 or 6 interleaved channels per DMA is not very sane.
> > 
> > Why?  It's more efficient than handling them in chunks of 4.  This would
> > be intended for use by the sound server, in this case jackd; you would
> > launch jackd with an 8 channel input and 8 channel output device,
> > corresponding to the analog ins and outs on the hardware.  With 16 or 32
> > channels the rest are just FX buses.  And this all lives in hardware.
> 
> No need to handle them in chunks of specifically 4. But using more than
> one single DMA channel to relieve the CPU. If not, it would be better
> using programmed I/O instead of DMA.
> 

I am not sure I understand.  How would it tax the CPU more heavily?  You
end up doing more work at each interrupt, but you have fewer interrupts.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
