From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: Finding xruun sources in cs46xx
Date: Mon, 8 Nov 2004 18:43:56 +0100
Message-ID: <20041108184356.6cdb742a@mango.fruits.de>
References: <20041108181705.456b1aea@mango.fruits.de>
	<Pine.HPX.4.33n.0411081835301.16893-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (pop.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id ED020240
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2004 18:43:45 +0100 (MET)
In-Reply-To: <Pine.HPX.4.33n.0411081835301.16893-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 8 Nov 2004 18:39:21 +0100 (MET)
Clemens Ladisch <clemens@ladisch.de> wrote:

> Florian Schmidt wrote:
> > I wonder: how can i approach finding the source of these xruns? Would the
> > xrun debugging messages of ALSA provide a starting point?
> 
> Yes, they show the point where the interrupt finally occurred which
> should be immediately after the code that blocked interrupt for too
> long.
> 

Ok, now when you want them to happen, they don't show up :)

Ah, ok, here we go. I sometimes see these:

Nov  8 18:27:29 mango kernel: Unexpected hw_pointer value [1] (stream = 0, delta: -48, max jitter = 64): wrong interrupt acknowledge?
Nov  8 18:27:29 mango kernel:  [<f088ea51>] snd_pcm_period_elapsed+0x1b1/0x3a0 [snd_pcm] (8)
Nov  8 18:27:29 mango kernel:  [<c0105d0a>] common_interrupt+0x1a/0x20 (4)
Nov  8 18:27:29 mango kernel:  [<f08cc831>] snd_cs46xx_interrupt+0x1d1/0x210 [snd_cs46xx] (48)
Nov  8 18:27:29 mango kernel:  [<c0132358>] handle_IRQ_event+0x38/0x80 (32)
Nov  8 18:27:29 mango kernel:  [<c0132a69>] do_hardirq+0x69/0x110 (36)
Nov  8 18:27:29 mango kernel:  [<c0132b10>] do_irqd+0x0/0xc0 (20)
Nov  8 18:27:29 mango kernel:  [<c0132ba7>] do_irqd+0x97/0xc0 (4)
Nov  8 18:27:29 mango kernel:  [<c012a053>] kthread+0xa3/0xb0 (20)
Nov  8 18:27:29 mango kernel:  [<c0129fb0>] kthread+0x0/0xb0 (20)
Nov  8 18:27:29 mango kernel: Unexpected hw_pointer value [1] (stream = 1, delta: -32, max jitter = 64): wrong interrupt acknowledge?
Nov  8 18:27:29 mango kernel:  [<f088ea51>] snd_pcm_period_elapsed+0x1b1/0x3a0 [snd_pcm] (8)
Nov  8 18:27:29 mango kernel:  [<c0105d0a>] common_interrupt+0x1a/0x20 (4)
Nov  8 18:27:29 mango kernel:  [<f08cc831>] snd_cs46xx_interrupt+0x1d1/0x210 [snd_cs46xx] (48)
Nov  8 18:27:29 mango kernel:  [<c0132358>] handle_IRQ_event+0x38/0x80 (32)
Nov  8 18:27:29 mango kernel:  [<c0132a69>] do_hardirq+0x69/0x110 (36)
Nov  8 18:27:29 mango kernel:  [<c0132b10>] do_irqd+0x0/0xc0 (20)
Nov  8 18:27:29 mango kernel:  [<c0132ba7>] do_irqd+0x97/0xc0 (4)
Nov  8 18:27:29 mango kernel:  [<c012a053>] kthread+0xa3/0xb0 (20)
Nov  8 18:27:29 mango kernel:  [<c0129fb0>] kthread+0x0/0xb0 (20)
Nov  8 18:27:29 mango kernel:  [<c0103e75>] kernel_thread_helper+0x5/0x10 (16)


This is a different kind:

Nov  8 18:42:10 mango kernel: XRUN: pcmC0D0p
Nov  8 18:42:10 mango kernel:  [<f088eb05>] snd_pcm_period_elapsed+0x265/0x3a0 [snd_pcm] (8)
Nov  8 18:42:10 mango kernel:  [<f08cc831>] snd_cs46xx_interrupt+0x1d1/0x210 [snd_cs46xx] (56)
Nov  8 18:42:10 mango kernel:  [<c0132358>] handle_IRQ_event+0x38/0x80 (32)
Nov  8 18:42:10 mango kernel:  [<c0132a69>] do_hardirq+0x69/0x110 (36)
Nov  8 18:42:10 mango kernel:  [<c0132b10>] do_irqd+0x0/0xc0 (20)
Nov  8 18:42:10 mango kernel:  [<c0132ba7>] do_irqd+0x97/0xc0 (4)
Nov  8 18:42:10 mango kernel:  [<c012a053>] kthread+0xa3/0xb0 (20)
Nov  8 18:42:10 mango kernel:  [<c0129fb0>] kthread+0x0/0xb0 (20)
Nov  8 18:42:10 mango kernel:  [<c0103e75>] kernel_thread_helper+0x5/0x10 (16)
Nov  8 18:42:10 mango kernel: XRUN: pcmC0D0p
Nov  8 18:42:10 mango kernel:  [<f088eb05>] snd_pcm_period_elapsed+0x265/0x3a0 [snd_pcm] (8)
Nov  8 18:42:10 mango kernel:  [<f08cc831>] snd_cs46xx_interrupt+0x1d1/0x210 [snd_cs46xx] (56)
Nov  8 18:42:10 mango kernel:  [<c0132358>] handle_IRQ_event+0x38/0x80 (32)
Nov  8 18:42:10 mango kernel:  [<c0132a69>] do_hardirq+0x69/0x110 (36)
Nov  8 18:42:10 mango kernel:  [<c0132b10>] do_irqd+0x0/0xc0 (20)
Nov  8 18:42:10 mango kernel:  [<c0132ba7>] do_irqd+0x97/0xc0 (4)
Nov  8 18:42:10 mango kernel:  [<c012a053>] kthread+0xa3/0xb0 (20)
Nov  8 18:42:10 mango kernel:  [<c0129fb0>] kthread+0x0/0xb0 (20)
Nov  8 18:42:10 mango kernel:  [<c0103e75>] kernel_thread_helper+0x5/0x10 (16)

Do these show anything helpful?

> > And one more question: what happens to an IRQ raised by a pci device which
> > get's ignored [either due to a cli or because it's masked by another IRQ
> > with a higher prio]?
> 
> PCI uses level-triggered interrupts, i.e., the interrupt line stays in
> raised state until the driver tells the device that the interrupt has
> been handled.

Ahhh, ok. Thanks!

flo


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
