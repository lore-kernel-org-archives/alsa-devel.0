From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: Can DMA address, periods, buffer size,
 etc change after hw_params is called?
Date: Thu, 29 Jan 2009 09:43:32 +0100
Message-ID: <20090129094332.2728c908@hcegtvedt>
References: <20090129081825.241be9e4@hcegtvedt> <498164BC.6080907@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 008FF103854
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 09:43:34 +0100 (CET)
In-Reply-To: <498164BC.6080907@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 29 Jan 2009 09:11:40 +0100
Clemens Ladisch <clemens@ladisch.de> wrote:

> Hans-Christian Egtvedt wrote:
> > I wonder if I must take care handling changes in DMA address,
> > number of periods and period size in the prepare callback?
> > 
> > Or are these locked after the first time prepare is called?
> 
> The hardware parameters like buffer/period size and sample format are
> set by calling the hw_params callback; they are valid until a call to
> hw_free (or another call to hw_params), which doesn't happen while the
> stream is running.
> 

Is there a chance that the following might happen:
 - stop trigger,
 - hw_free
 - hw_params
 - prepare
 - start trigger

I.e. without calling close and open?

> The DMA address is selected by the driver in the hw_params callback,
> but most drivers let the framework handle this by calling
> snd_pcm_lib_malloc_pages().
> 

Yes, this is what I do today. I am considering if I should release the
DMA stuff in hw_free and then in the prepare callback check if it needs
to be prepared again (since it was released in hw_free).

> The prepare and start/stop trigger callbacks are called only between
> hw_params/hw_free, but they could be called multiple times, so you
> should handle this stuff in the prepare callback only if your device
> requires that this is done every time before a stream is started.
> 

Yes, I setup the cyclic DMA buffer the first time I get a prepare
callback, and free the cyclic DMA buffer in the hw_free callback.

This works fine as it is now, but I just want to make sure I handle all
cases which might appear on the way.

-- 
Best regards,
Hans-Christian Egtvedt
