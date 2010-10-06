From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ### Question on HW Pointer
Date: Wed, 06 Oct 2010 08:46:51 +0200
Message-ID: <4CAC1B5B.6000705@ladisch.de>
References: <001201cb64ee$5beec5c0$13cc5140$@fl-eng.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 39F8E103958
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Oct 2010 08:46:08 +0200 (CEST)
In-Reply-To: <001201cb64ee$5beec5c0$13cc5140$@fl-eng.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Spano <steve@fl-eng.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Steve Spano wrote:
> I think the flow should be as follows (lets consider the dac part)
> 
> Step #1 ) interrupt occurs
> Step #2) dma/transfer begins as kicked off in interrupt routine

So I assume the driver is responsible for telling the hardware to begin
transferring the next period.  Doesn't it do this automatically?

> Step #3) we advance the buffer pointer for the alsa buffer

An interrupt (that is, for ALSA, the call to snd_pcm_period_elapsed)
signals the end of the previous period.

> Step #4) we exit the interrupt
> 
> . then the hardware should start advancing its pointer as it is reading the
> new samples
> 
> .. then sometime later, the alsa layer calls the "hw_pointer" function

The pointer callback can be called at any time.  It will definitely be
called from snd_pcm_period_elapsed, so the buffer pointer must already
have been increased before that call.

> And then we return the current value of the hardware pointer from the board?

Drop the word "then"; the pointer callback _always_ must return the
current value. :)

> So alsa knows how many samples the board has processed from the interrupt?

Yes; ALSA (or the application) wants to know how many samples the board
has processed.  If your DMA controller does not have a register for this,
the pointer must be calculated and updated in the interrupt handler (as
you do).

> Can someone explain how this pointer/etc is supposed to flow and what alsa
> may be using it for? Maybe some latency calculation in a an upper layer?

This, and to know which part of the buffer can be written to (the
hardware pointer indicates which part of the buffer has been processed
by the hardware; the samples after the pointer will be read now or
later).


Regards,
Clemens
