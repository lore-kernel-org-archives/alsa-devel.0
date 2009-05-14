From: Laurent Pinchart <laurent.pinchart@skynet.be>
Subject: Re: [RFC] ALSA vs. dedicated char device for a USB
	Audio Class gadget driver
Date: Thu, 14 May 2009 22:58:42 +0200
Message-ID: <200905142258.42935.laurent.pinchart@skynet.be>
References: <20090514181808.9ABB1BCE6@ip-64-139-1-69.sjc.megapath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perceval.irobotique.be (perceval.irobotique.be [92.243.18.41])
	by alsa0.perex.cz (Postfix) with ESMTP id A88CA10393B
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 22:55:00 +0200 (CEST)
In-Reply-To: <20090514181808.9ABB1BCE6@ip-64-139-1-69.sjc.megapath.net>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hal Murray <hmurray@megapathdsl.net>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Hal,

first of all, thanks for your answer.

On Thursday 14 May 2009 20:18:07 Hal Murray wrote:
> > I need an API to transfer audio data from userspace to kernelspace. I
> > initially thought about ALSA, but it turns out some assumptions made
> > by ALSA  are not fulfilled by my system. One of the most serious
> > problems is that the  UAC gadget driver doesn't have any audio clock.
> > The only hardware clock  available is the USB device controller
> > interrupts generated at the USB  transfer rate, and those are much
> > faster than the audio sample rate. This will  cause buffer underruns
> > that I need to handle.
>
> You don't need a clock.  The data will come to you at the right rate.  All
> you need to do is pass it on when you have enough to fill up a buffer.  The
> buffer size is fixed.  It's part of the spec for the device you are
> emulating.

I'm not emulating any device. The buffer size is up to me, and I actually have 
a fixed number of small buffers, but that shouldn't make a difference.

> Assume that you get samples one at a time each time the source clock
> ticked. The normal state of your system would be to have a buffer that is
> partially filled.  When a new sample fills up the buffer, you would move it
> from the input side to the ready-for-USB queue and setup a new buffer for
> future input samples.
>
> Soon the USB side will read the queued buffer, you free that buffer and you
> are now back to the normal state of collecting input data.
>
> You are in trouble if that doesn't happen before the nest buffer is ready,
> that is the ready-for-USB queue should normally be empty.  If you can't
> keep it empty it will eventually overflow.  Short chunks of time where the
> queue builds up might be OK.  For debugging, you should probably count
> them.
>
> Now consider the case where you get several samples at a time rather than
> one.  Logically, copy them over one at a time.  That turns into a burst of
> source clocks, but the average will work out right.  Your ready-for-USB
> queue should still be empty most of the time.
>
> If that doesn't make sense, I'll try again.  Consider something like audio
> over a network.  There is no audio clock on the network.  The receiver can
> derive the source clock by watching the data stream.

This is more or less what I'm trying to do, with the difference that I don't 
move samples from the ALSA ring buffer when they arrive but when the USB layer 
asks for more data.

My trouble is that I don't get notified when new samples are written to the 
ALSA ring buffer, and I'm not sure to find out how many samples are present in 
the buffer. If I could get some kind of "sample written" notification, or 
better, compute the size of data present in the ring buffer, my problem would 
be (mostly) solved. From what I understand, such a notification isn't possible 
when the ALSA ring buffer is mmap'ed, as ALSA itself doesn't get notified.

This makes the second approach (reading the number of available samples) 
better, except that some kind of "free-wheeling" mode makes it impossible 
under some circumstances. From what Takashi Iwai explained in a mail to Jon 
Smirl on alsa-devel ("appl_ptr and DMA overrun at end of stream"), "we have 
also mode when appl_ptr is not updated at all (when stop_threshold == 
boundary)". This free-wheeling mode seems to be used by dmix.

Best regards,

Laurent Pinchart
