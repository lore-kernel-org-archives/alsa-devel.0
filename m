From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Finding xruun sources in cs46xx
Date: Mon, 8 Nov 2004 18:52:36 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411081846480.16893-100000@studcom.urz.uni-halle.de>
References: <20041108184356.6cdb742a@mango.fruits.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 306C22A9
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2004 18:52:37 +0100 (MET)
In-Reply-To: <20041108184356.6cdb742a@mango.fruits.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Florian Schmidt wrote:
> Nov  8 18:42:10 mango kernel: XRUN: pcmC0D0p
> Nov  8 18:42:10 mango kernel:  [<f088eb05>] snd_pcm_period_elapsed+0x265/0x3a0 [snd_pcm] (8)
> Nov  8 18:42:10 mango kernel:  [<f08cc831>] snd_cs46xx_interrupt+0x1d1/0x210 [snd_cs46xx] (56)
> Nov  8 18:42:10 mango kernel:  [<c0132358>] handle_IRQ_event+0x38/0x80 (32)
> Nov  8 18:42:10 mango kernel:  [<c0132a69>] do_hardirq+0x69/0x110 (36)
> Nov  8 18:42:10 mango kernel:  [<c0132b10>] do_irqd+0x0/0xc0 (20)
> Nov  8 18:42:10 mango kernel:  [<c0132ba7>] do_irqd+0x97/0xc0 (4)
> Nov  8 18:42:10 mango kernel:  [<c012a053>] kthread+0xa3/0xb0 (20)
> Nov  8 18:42:10 mango kernel:  [<c0129fb0>] kthread+0x0/0xb0 (20)
> Nov  8 18:42:10 mango kernel:  [<c0103e75>] kernel_thread_helper+0x5/0x10 (16)
>
> Do these show anything helpful?

Not for me.  Are you using a threaded interrupts?

Try asking on LKML.


Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
