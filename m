From: Trent Piepho <xyzzy@speakeasy.org>
Subject: problems writing pcm driver
Date: Mon, 20 Aug 2007 13:47:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0708201250360.30669@shell2.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2.sea5.speakeasy.net (mail2.sea5.speakeasy.net
	[69.17.117.4]) by alsa0.perex.cz (Postfix) with ESMTP id 0A0C0103879
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Aug 2007 22:47:51 +0200 (CEST)
Received: from shell2.sea5.speakeasy.net ([69.17.116.3])
	(envelope-sender <xyzzy@speakeasy.org>)
	by mail2.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted
	SMTP for <alsa-devel@alsa-project.org>; 20 Aug 2007 20:47:48 -0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm trying to write an ALSA driver, but there are some thing I'm not clear on
and it's not working as well as I'd like.

Atomicity:
trigger, pointer, and ack are atomic with respect to themselves.  e.g., two
copies of the trigger callback can't be running at the same time.  That much
is clear.  But are they atomic with respect to each other?  Can the trigger
callback run at the same time as the pointer callback?  How about the atomic
callbacks with respect to the non-atomic ones?  Can trigger run at the same
time as prepare?

The pointer callback:
What exactly is the current hardware position?  My hardware has a counter that
tells me how many periods have been DMAed into the buffer.

Suppose my period size is 256 frames and I'm doing audio capture.  If pointer
is called before any DMA transfers have completed, do I return 0?  Now suppose
it's called after one period of audio has been DMAed into the buffer.  Do I
return 255 or 256?  After two periods have been received, should I return 511
or 0?

Why is pointer called so many times?
Here's a log of callbacks and irqs my driver is getting.  I'm using the cycle
counter to give them microsecond timestamps.  My period is 256 frames at
48kHz, so each period is 5333 us.  There are only two periods in the buffer.

Time (us) |  Callback or IRQ
----------------------------------------------
     0.000 trigger - start DMA
   134.513 pointer - count 1, returned 0
   160.254 IRQ - not calling snd_pcm_period_elapsed
  5313.030 IRQ - called snd_pcm_period_elapsed
  5318.808 pointer - count 2, returned 256
           IRQ hander finished
  5348.309 pointer - count 2, returned 256
 10627.526 IRQ - called snd_pcm_period_elapsed
 10633.075 pointer - count 3, returned 0
           IRQ hander finished
 10659.755 pointer - count 3, returned 0
 15941.173 IRQ - called snd_pcm_period_elapsed
 15946.601 pointer - count 4, returned 256
           IRQ hander finished
 15969.743 pointer - count 4, returned 256
[and so on]

The pointer callback is called only 134 us after the trigger, before the first
IRQ or a period of data could possibly be received.  Why is this done?  To get
the position in the buffer to start at?  I assumed the data should start at
the beginning of the buffer, but is this not the case?

You'll notice the first IRQ is received at only 160 us.  The hardware
generates an IRQ when each period _starts_, not when one ends.  So the first
IRQ is ignored, the second IRQ tells me the first period has finished, and so
on.  The hardware counter is the number of periods started; I have to subtract
one to get the number of periods finished.

When the IRQ handler calls snd_pcm_period_elapsed(), that calls the pointer
callback.  That's what I expected from what the docs said.  But about 30 us
after the pointer callback is called the first time, after the irq handler has
exited, it's called again.  What is the purpose of this?  Is it ok that
I return the same value as the previous time it was called?
