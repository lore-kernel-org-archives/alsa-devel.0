From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: Can DMA address, periods, buffer size,
 etc change after hw_params is called?
Date: Thu, 29 Jan 2009 11:10:34 +0100
Message-ID: <20090129111034.632c5dcf@hcegtvedt>
References: <20090129081825.241be9e4@hcegtvedt> <498164BC.6080907@ladisch.de>
	<20090129094332.2728c908@hcegtvedt> <49816FA2.3030108@ladisch.de>
	<20090129103554.4a02cb04@hcegtvedt> <49817E17.8040401@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BAF8103869
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 11:10:37 +0100 (CET)
In-Reply-To: <49817E17.8040401@ladisch.de>
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

On Thu, 29 Jan 2009 10:59:51 +0100
Clemens Ladisch <clemens@ladisch.de> wrote:

> Hans-Christian Egtvedt wrote:
> > Okay, so to be sure I setup and release my cyclic DMA buffer safely
> > I could use the following model:
> > 
> > in prepare callback setup the DMA buffer, once when called. The
> > hardware parameters should not change at this point.
> > 
> > If I get a hw_params callback after a prepare, then release the DMA
> > buffer, and set it up again in the prepare callback?
> > 
> > Final cleanup of the DMA buffer can/should be done in hw_free?
> 
> This would work, but doing it in the hw_params callback would be a
> little more simple:
> * In hw_params, free the old buffer (if it exists), then setup the
>   buffer;

I think I was not 100% clear, in addition to call
snd_pcm_lib_malloc_pages() in hw_params, I also need to hand over the
DMA buffer information to a prepare function in the DMA driver I use
with this sound hardware.

So I follow the scheme for free/setup of buffers for my DMA controller
setup as well.

hw_params, release DMA controller if exists, then prepare DMA
controller.

> * in hw_free, free the buffer.
> 

Which I do by calling snd_pcm_lib_free_pages().

and then in hw_free, release DMA controller if exists.

> As a rule of thumb, the callbacks open/close, hw_params/hw_free and
> start/stop trigger are mostly symmetrical, and any resources should be
> allocated and freed in the functions that belong together.  (The start
> trigger is a special case because it uses two callbacks, prepare and
> trigger with TRIGGER_START.)
> 
> The hw_params and prepare callbacks can be called multiple times.
> 

Noted, which means I should reprepare my DMA controller as well every
time I get a hw_params callback and do snd_pcm_lib_malloc_pages().

> > Is there a flow chart which shows how the different callbacks can be
> > called?
> 
> Not yet.
> 

Would probably help me a lot to see the actual flow of the callbacks.

-- 
Best regards,
Hans-Christian Egtvedt
