From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: DMA buffer gets played only once
Date: Thu, 6 Sep 2007 06:39:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0709060557160.31808@shell4.speakeasy.net>
References: <46DE4AB1.20206@hrz.tu-chemnitz.de>
	<1188983079.7844.1208974467@webmail.messagingengine.com>
	<46DE7422.5020900@hrz.tu-chemnitz.de> <s5hbqch8e5o.wl%tiwai@suse.de>
	<46DF83C6.1090002@hrz.tu-chemnitz.de>
	<Pine.LNX.4.58.0709052207551.31808@shell4.speakeasy.net>
	<46DF99E6.30608@hrz.tu-chemnitz.de> <46DF9DB7.80705@hrz.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail4.sea5.speakeasy.net (mail4.sea5.speakeasy.net
	[69.17.117.6]) by alsa0.perex.cz (Postfix) with ESMTP id 6AD72103904
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 15:39:25 +0200 (CEST)
In-Reply-To: <46DF9DB7.80705@hrz.tu-chemnitz.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Markus Franke <markus.franke@s2002.tu-chemnitz.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 6 Sep 2007, Markus Franke wrote:
> I just found out that the problem of multiple calls of
> TRIGGER_START/TRIGGER_STOP might be caused by using ossplay (oss
> emulation layer) for testing. If I use aplay, TRIGGER_START gets called
> once but then Alsa goes in a loop continuously calling pcm_pointer().
> Return values of pcm_pointer() look like the following:

I found it very helpful to print timestamps for the various calls (trigger,
pointer, and my IRQ handler).  The code inside the #if 0, around lines 53 and
191, is what I wrote to use the time cycle counter for accurate timestamps.
http://linuxtv.org/hg/v4l-dvb/file/tip/linux/drivers/media/video/cx88/cx88-alsa.c


> ---snip---
> pcm_pointer returns 0
> pcm_pointer returns 1024
> pcm_pointer returns 2048
> pcm_pointer returns 3072

This is where a timestamp would be nice.  Is pcm_pointer getting called after
each period is elapsed, in microseconds?  Or is the pointer advancing much too
quickly?  It should take about 23220 us for the pointer to increase by 1024
frames at 44.1 kHz.

AFAIK, the only way a driver has to communicate with ALSA during pcm capture
or playback is via the return value of the pointer callback, and when and how
often the driver calls snd_pcm_period_elapsed().

If ALSA is detecting an underrun, it must be something about those two
functions that is causing it.

Be sure to check the period and buffer size from the runtime in your
callbacks, if you haven't already.  They might not be what you expected them
to be, which would easily explain the problem.
