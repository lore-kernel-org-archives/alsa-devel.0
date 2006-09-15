From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Driver design question
Date: Fri, 15 Sep 2006 10:47:59 -0400
Message-ID: <1158331680.7948.156.camel@mindpipe>
References: <45095921020000C80000961F@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45095921020000C80000961F@emea1-mh.id2.novell.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@novell.com>
Cc: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-09-14 at 12:29 +0100, Takashi Iwai wrote:
> >>> Lee Revell <rlrevell@joe-job.com> 09/12/06 10:27 PM >>>
> > I have a device here that can play PCM, but it's a weird implementation.
> > Only 2 periods of 0x2000 words per buffer are supported, and there is no
> > DMA - the driver must poll a status register, and when the chip is
> > ready, deliver all 0x2000 words using outw() then send an end xfer
> > command.
> > 
> > I think I need to use an intermediate buffer, and implement copy/silence
> > callbacks that write to this.  Then I plan to use a tasklet or workqueue
> > to do the actual xfer of PCM data to the hardware.  A timer callback
> > will periodically check whether at least 0x2000 words are in the buffer
> > and if so, schedule the tasklet to drain it.
> 
> You can implement it in two ways, at least.
> 
> One is to use copy and silent callbacks.  This is pretty straightforward,
> doesn't need extra buffer, but it cannot use the native mmap.  (alsa-lib
> provides the mmap emulation mode, but it seems not so stable.)
> Also, the buffer and period sizes are very restricitve (in your case, 0x2000
> x 2 words), so many apps might not work well.
> An exampleof this type is isa/sb/emu8000_pcm.c (and some of gus pcm,
> IIRC).
> 
> Another is to use an intermediate buffer as you suggsted.
> In this case, you do _not_ need copy and silent callbacks.  These callbacks
> are the operations to copy and silent the hardware buffers.  WIth an
> intermediate buffer, the copy and silent are done on this buffer, i.e. on
> normal RAM.  What you need instead is the background-running copy
> operation from this intermediate buffer to the hardware via outw.
> 
> This copy task could be done in the interrupt handler (or timer in your case)
> if it's minimum.  If not, it'd be better to take a workq since it can sleep and
> much preemptive.

Thanks very much for the information.

So if I use an intermediate buffer but no copy and silence callbacks, I
must copy the data to the hardware in a workqueue (I have no interrupt
ability and the copy to hardware must be able to sleep).  Where do I
copy the data from, and how do I know when 0x2000 words are available?
By directly accessing runtime->dma_area and the software pointer?  IOW
how do I get the information that would be passed to the copy callback?

Lee


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
