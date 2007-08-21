From: Timur Tabi <timur@freescale.com>
Subject: Re: problems writing pcm driver
Date: Tue, 21 Aug 2007 16:30:26 -0500
Message-ID: <46CB5972.5000603@freescale.com>
References: <Pine.LNX.4.58.0708201250360.30669@shell2.speakeasy.net>	<s5hd4xhkytk.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0708210907460.30669@shell2.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id BD63D1038BD
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Aug 2007 23:30:31 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.58.0708210907460.30669@shell2.speakeasy.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Trent Piepho wrote:

> The driver writing howto says for hw_params, "is that this callback is
> non-atomic (schedulable)."
> 
> If it's non-atomic, that would mean to me that it can be called multiple
> times at once, and at the same time as other callbacks.  But, you're saying
> that's not the case?

Sounds like the documentation using a wrong definition of "atomic".  Perhaps 
it's confused with GFP_ATOMIC, which is a parameter used for kmalloc() when 
you don't want the kernel to schedule another task.

> Suppose the ring buffer has 256 frames of valid data in it, from position 0
> to position 255.  Do I return 255 or 256?  It could be either one,
> depending on how your ring buffer operates.

If you have 256 frames of valid data in a 256-frame buffer, then you are about 
to have an underrun condition.  I think it would be better if your driver 
reported an underrun before it got the 256th frame.  Just don't allow the 
buffer to be completely full.

Most circular buffers don't really support that concept anyway - they 
generally require at least one empty slot.

> I have the pointer callback read a hardware register to get the number of
> frames transferred.  Maybe I should instead have the irq handler save this
> register in the chip struct, and just read the value from there in the
> pointer callback?  This means I have to use locking between the irq handler
> and the pointer callback, which I have been able to avoid so far.

Is reading a hardware register really that slow?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
