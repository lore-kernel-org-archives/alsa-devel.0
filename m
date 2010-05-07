From: Daniel Mack <daniel@caiaq.de>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Fri, 7 May 2010 13:58:10 +0200
Message-ID: <20100507115810.GN30801@buzzloop.caiaq.de>
References: <g2h74fd948d1004141820ladc1941eo732d059dd678df0a@mail.gmail.com>
	<4BE3E1B9.5020602@ladisch.de> <201005071342.34923.oneukum@suse.de>
	<201005071347.56993.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id E87982454A
	for <alsa-devel@alsa-project.org>;
	Fri,  7 May 2010 13:58:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201005071347.56993.oneukum@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Oliver Neukum <oneukum@suse.de>
Cc: alsa-devel@alsa-project.org, USB list <linux-usb@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Kernel development list <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, iommu@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, Alan Stern <stern@rowland.harvard.edu>, Pedro Ribeiro <pedrib@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 07, 2010 at 01:47:56PM +0200, Oliver Neukum wrote:
> Am Freitag, 7. Mai 2010 13:42:34 schrieb Oliver Neukum:
> > Am Freitag, 7. Mai 2010 11:47:37 schrieb Clemens Ladisch:
> > > > In the particular case of audio drivers, though, the contents of the
> > > > buffers are likely to change after the submission. What we do here
> > > > is that we map the audio stream buffers which are used by ALSA to
> > > > the output URBs, so they're filled asychronously. Once the buffer is
> > > > actually sent out on the bus, it is believed to contain proper audio
> > > > date. If it doesn't, that's due to too tight audio timing or other
> > > > problems. This breaks once buffers are magically bounced in the
> > > > background.
> > > 
> > > At least the audio class and ua101 drivers don't do this and fill the
> > > buffers before they are submitted.
> > > 
> > > > So - long story short: these audio buffers need to be DMA coherent.
> > > 
> > > Does the USB API actually guarantee that all controllers use DMA, i.e.,
> > > that the buffers can be filled after submission?
> > 
> > No, you must not touch buffers after submission. This does not even
> > work if we use DMA, because on some architectures this violates
> > guarantees to the dma primitives. It cannot be done.

We do such tricks on other OS where IRQ latency as high as some tens
of milliseconds. So we queue EHCI transfers well in advance and update
access their contents (for both input and output) from audio context.
I considered implementing this idea to the Linux USB audio driver as
well.

> Or to be precise it could be done with coherent memory, but you'd risk
> transfering partially updated buffers, as you cannot know when DMA will
> be done and we don't guarantee that DMA will be done right as we transfer.

If the memory is coherent, it should be possible. And if buffers are
only partially updated, the audio buffer scheduling is too tight. IOW,
the configured buffer size of audio clients in userspace is too small.

This is OT now I believe, I will start another thread for this topic
once I have something to show.

Thanks,
Daniel
