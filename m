From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Can DMA address, periods, buffer size,
 etc change after hw_params is called?
Date: Thu, 29 Jan 2009 09:11:40 +0100
Message-ID: <498164BC.6080907@ladisch.de>
References: <20090129081825.241be9e4@hcegtvedt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 34031103849
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 09:11:45 +0100 (CET)
In-Reply-To: <20090129081825.241be9e4@hcegtvedt>
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
> I wonder if I must take care handling changes in DMA address, number of
> periods and period size in the prepare callback?
> 
> Or are these locked after the first time prepare is called?

The hardware parameters like buffer/period size and sample format are
set by calling the hw_params callback; they are valid until a call to
hw_free (or another call to hw_params), which doesn't happen while the
stream is running.

The DMA address is selected by the driver in the hw_params callback, but
most drivers let the framework handle this by calling
snd_pcm_lib_malloc_pages().

The prepare and start/stop trigger callbacks are called only between
hw_params/hw_free, but they could be called multiple times, so you
should handle this stuff in the prepare callback only if your device
requires that this is done every time before a stream is started.


Best regards,
Clemens
