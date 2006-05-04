From: Nicolas Boullis <nboullis@debian.org>
Subject: Re: How to deal with cards with a large on-board buffer?
Date: Fri, 5 May 2006 01:36:52 +0200
Message-ID: <20060504233651.GH4831@home>
References: <20060502234125.GC4109@home> <20060503122658.GB11243@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20060503122658.GB11243@turing.informatik.uni-halle.de>
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

On Wed, May 03, 2006 at 02:26:58PM +0200, Clemens Ladisch wrote:
> > 
> > To make it short, the trouble is that, to get correct working, it seems 
> > to require that the audio buffer be kept at some minimal fill level. Is 
> > there a way I can enforce this?
> 
> The card should do this automatically as it initiates the DMA transfers
> by itself.

It does. But then I have problems if the transfered buffer has not been 
filled by the application...


> > Now, just in case someone has a better idea how to make things work, 
> > here is a more comprehensive explanation about how those cards work, *as 
> > far as I could understand* (since I got absolutely no explanation from 
> > the manufacturer):
> >    - there is a rather large on-chip buffer (0x3c00 bytes), that we can 
> >      neither write to or read directly
> 
> So it's just a FIFO that is more or less transparent to the computer?

I guess so.

> >    - we can read pointers to the current read and write positions in 
> >      this buffer
> >    - this buffer is fed by chip-initiated DMA transfers from the main 
> >      memory
> 
> How big are these transfers?

In the current code, they are 4kB (1ksample) or 8kB (2ksample). I can 
specify the size I want, but it does not work with large buffers (8kB is 
already more than half the size of the on-chip buffer). And it seems 
that there are problems when the buffers are not 4kB-aligned.


> >    - the buffers for DMA transfers are declared in a FIFO;
> 
> You mean this chip supports scatter/gather buffers?

I'm not sure what you mean exactly by scatter/gather buffers, but I 
guess it is something like that.


> >    - if the on-chip buffer is "too empty" (don't know exactly when the 
> >      chip decides it is too empty) and no buffer is available for 
> >      DMA transfer, it "sends" some junk to the internal buffer
> 
> Most sound card FIFOs operate like this.

OK, I did not know.


> >    - interruptions are not raised when buffers are DMA-transfered, but 
> >      at fixed 20.2ms interval (stable experimental value)
> 
> The ymfpci and usb drivers deal with a similar problem.

I'll try to give them a look.
But if I understand things correctly, I must ensure that the periods are 
large enough to be played in more than 20.2ms, if I want 
snd_pcm_period_elapsed to be called often enough. Is that right?


Cheers,

Nicolas

PS: sorry if I'm being stupid, I'm not used to writing audio drivers...


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
