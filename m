From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: problems writing pcm driver
Date: Tue, 21 Aug 2007 14:22:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0708210907460.30669@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0708201250360.30669@shell2.speakeasy.net>
	<s5hd4xhkytk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.sea5.speakeasy.net (mail3.sea5.speakeasy.net
	[69.17.117.5]) by alsa0.perex.cz (Postfix) with ESMTP id AD7A21038A4
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Aug 2007 23:22:56 +0200 (CEST)
In-Reply-To: <s5hd4xhkytk.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 21 Aug 2007, Takashi Iwai wrote:
> At Mon, 20 Aug 2007 13:47:48 -0700 (PDT),
> Trent Piepho wrote:
> > Atomicity:
> > trigger, pointer, and ack are atomic with respect to themselves.  e.g., two
> > copies of the trigger callback can't be running at the same time.  That much
> > is clear.  But are they atomic with respect to each other?  Can the trigger
> > callback run at the same time as the pointer callback?  How about the atomic
> > callbacks with respect to the non-atomic ones?  Can trigger run at the same
> > time as prepare?
>
> No, these callbacks are exclusive.  In principle, they are called with
> substream->lock spinlock already held by the PCM core, so they cannot
> be called at the same time as long as belonging to the same PCM
> substream instance.

The driver writing howto says for hw_params, "is that this callback is
non-atomic (schedulable)."

If it's non-atomic, that would mean to me that it can be called multiple
times at once, and at the same time as other callbacks.  But, you're saying
that's not the case?

> > The pointer callback:
> > What exactly is the current hardware position?  My hardware has a counter that
> > tells me how many periods have been DMAed into the buffer.
> >
> > Suppose my period size is 256 frames and I'm doing audio capture.  If pointer
> > is called before any DMA transfers have completed, do I return 0?  Now suppose
> > it's called after one period of audio has been DMAed into the buffer.  Do I
> > return 255 or 256?  After two periods have been received, should I return 511
> > or 0?
>
> The pointer callback returns the position offset of the "ring
> buffer".  It's not the period size.  Usually, a ring buffer consists

Suppose the ring buffer has 256 frames of valid data in it, from position 0
to position 255.  Do I return 255 or 256?  It could be either one,
depending on how your ring buffer operates.

> (snip)
> > exited, it's called again.  What is the purpose of this?  Is it ok that
> > I return the same value as the previous time it was called?
>
> The pointer callback isn't necessarily to be so accurate, but it's
> supposed to be fast.  Hence, yes, it's fine that you return the same
> value as before unless updated via IRQ if the operation takes long
> time.

I have the pointer callback read a hardware register to get the number of
frames transferred.  Maybe I should instead have the irq handler save this
register in the chip struct, and just read the value from there in the
pointer callback?  This means I have to use locking between the irq handler
and the pointer callback, which I have been able to avoid so far.
