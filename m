From: Rong-Jhe <r93922118@ntu.edu.tw>
Subject: Re: XRUN happens too often.
Date: Wed, 9 Apr 2008 12:06:51 +0000 (UTC)
Message-ID: <loom.20080409T051547-963@post.gmane.org>
References: <loom.20080408T090019-595@post.gmane.org>
	<loom.20080408T113541-885@post.gmane.org>
	<47FB8D57.8030904@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 5686A2444E
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Apr 2008 14:07:07 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JjZ4t-00044y-Gx
	for alsa-devel@alsa-project.org; Wed, 09 Apr 2008 12:07:02 +0000
Received: from 220.128.79.26 ([220.128.79.26])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 09 Apr 2008 12:06:59 +0000
Received: from r93922118 by 220.128.79.26 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 09 Apr 2008 12:06:59 +0000
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

> I don't have a direct answer for you, but I have an application that seems
> to be able to write data using writei with no problems at rates up to
> 192 KHz.  You can download it from sourceforge and look at the source.
> 
> http://sourceforge.net/projects/discord/ 
> 
> I copied and adapted from other examples on the web.  Do a search for 
> alsa in
> the source code and it should take you to the initialization function 
> and the
> playing function.
> 

Thanks for your help.
I think that XRUN may happen because the time of using snd_pcm_writei().
I have a problem about snd_pcm_write().
If the pcm is block, when does snd_pcm_writei() return?

I try to write the audio data into the dsp file directly without ALSA library.
The data will be written into DMA of the soundcard.
This action of writting is asynchronous, and the write() returns after 
queueing the data intto the DMA.

I guess the problem may be caused by the late time which the second 
snd_pcm_writei() is called.
The time between two snd_pcm_writei() may be too long, so the pcm enters XRUN 
state.

The period time in this pcm is 21333 us, and the buffer time is 213330 us 
because there are 10 periods in a buffer.

I recorded the time timeA that snd_pcm_writei() is called, and the time timeB 
that snd_pcm_writei() returns.
I calculate the duration between timeA and timeB, and the duration is not 
regular.

If snd_pcm_writei() is synchronous, the duration may be equal to the buffer 
time( 10xperiod time).
According to the measurement, snd_pcm_writei() seems not to be synchronous.
Can anyone tell me the basic theory of snd_pcm_writei(), especially in dmix 
mode.
