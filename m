From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Can DMA address, periods, buffer size,
 etc change after hw_params is called?
Date: Thu, 29 Jan 2009 10:59:51 +0100
Message-ID: <49817E17.8040401@ladisch.de>
References: <20090129081825.241be9e4@hcegtvedt>	<498164BC.6080907@ladisch.de>	<20090129094332.2728c908@hcegtvedt>	<49816FA2.3030108@ladisch.de>
	<20090129103554.4a02cb04@hcegtvedt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id F3367103851
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 10:59:55 +0100 (CET)
In-Reply-To: <20090129103554.4a02cb04@hcegtvedt>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hans-Christian Egtvedt wrote:
> Okay, so to be sure I setup and release my cyclic DMA buffer safely I
> could use the following model:
> 
> in prepare callback setup the DMA buffer, once when called. The
> hardware parameters should not change at this point.
> 
> If I get a hw_params callback after a prepare, then release the DMA
> buffer, and set it up again in the prepare callback?
> 
> Final cleanup of the DMA buffer can/should be done in hw_free?

This would work, but doing it in the hw_params callback would be a
little more simple:
* In hw_params, free the old buffer (if it exists), then setup the
  buffer;
* in hw_free, free the buffer.

As a rule of thumb, the callbacks open/close, hw_params/hw_free and
start/stop trigger are mostly symmetrical, and any resources should be
allocated and freed in the functions that belong together.  (The start
trigger is a special case because it uses two callbacks, prepare and
trigger with TRIGGER_START.)

The hw_params and prepare callbacks can be called multiple times.

> Is there a flow chart which shows how the different callbacks can be
> called?

Not yet.


Best regards,
Clemens
