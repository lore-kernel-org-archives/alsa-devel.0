From: Nicolas Boullis <nboullis@debian.org>
Subject: Re: How to deal with cards with a large on-board buffer?
Date: Thu, 4 May 2006 03:18:06 +0200
Message-ID: <20060504011806.GB6067@home>
References: <20060502234125.GC4109@home> <s5hirongupx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hirongupx.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, May 03, 2006 at 02:26:34PM +0200, Takashi Iwai wrote:
> At Wed, 3 May 2006 01:41:25 +0200, Nicolas Boullis wrote:
> > 
> > To make it short, the trouble is that, to get correct working, it seems 
> > to require that the audio buffer be kept at some minimal fill level. Is 
> > there a way I can enforce this?
>  
> It's no way because the data is fed from the application.
> If less than watermark (usually equivalent with period size) is
> available, it's simply an underrun.

Do you mean that userspace applications are expected to always have a 
period worth of data available? Then I guess I should force the period 
size to be larger than the buffer size...


> > Browsing at the code, I found out the fifo_size element of the 
> > snd_pcm_hardware_t type, that is not documented in Takashi Iwai's 
> > excellent "Writing an ALSA Driver" guide. Is it something that might be 
> > used to enforce this? (I tried, of course, but my test was 
> > unsuccessful...)
> 
> No, it's an obsoleted field and actually not used in the driver.

OK, I see.


> > Any idea how to correctly deal with such a beast? I tried a few ones, 
> > but none was really successful...
> 
> Are you using a system timer or any dedicated irq source?

It's a dedicated irq source for the chip.


> The first thing to do is to find out the bottleneck.

Sorry, but what bottleneck?


> You have two
> transfers running asynchronously: on the hardware buffer and between
> memory <-> h/w buffer.  I guess the former is running continuously,

You're right.


> but how the latter transfer is implemented?

The CPU-side mmaps some on-chip memory. Within this memory, there is a 
32-slot circular buffer, used with a "read pointer" and a "write 
pointer" to implement a FIFO. The CPU-side only updates the write 
pointer, and writes to the buffer. The elements in the buffer are 
pointers to and size of buffers that contain the actual data, and that 
are meant to be trasfered to the hardware buffer. The chip itself 
decides when to transfer a buffer, and updates the "read pointer".


> Anyway, the source code would reveal problems better.

Of course. You can grab the relevant part of the source code at 
http://dxr3.sourceforge.net/download/em8300_alsa.c but you should be 
warned that the code is not really clean, and that I'm somewhat ashamed 
to show it.

If you're willing to help me, feel free to ask any question about my 
code. Some explanation anyway: I wanted to avoid memory transfers 
within the driver, so I though I would allocate a large buffer, split it 
in 32 chunks, and set up the DMA slots each to one of those buffers. 
Whenever an interrupt is raised, I set the "write pointer" such that it 
considers the FIFO to be full.


Thanks,

Nicolas


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
