From: Rong-Jhe <r93922118@ntu.edu.tw>
Subject: Re: XRUN happens too often.
Date: Thu, 10 Apr 2008 03:29:45 +0000 (UTC)
Message-ID: <loom.20080410T030522-213@post.gmane.org>
References: <loom.20080408T090019-595@post.gmane.org>
	<loom.20080408T113541-885@post.gmane.org>
	<47FB8D57.8030904@cox.net>
	<loom.20080409T051547-963@post.gmane.org> <47FD42F2.70903@cox.net>
	<75b66ecd0804091801q1cf2d7fdq34a1b81048eb78d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 80263243EE
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Apr 2008 05:29:54 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JjnU0-0006kv-E3
	for alsa-devel@alsa-project.org; Thu, 10 Apr 2008 03:29:53 +0000
Received: from 220.128.79.26 ([220.128.79.26])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 10 Apr 2008 03:29:52 +0000
Received: from r93922118 by 220.128.79.26 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 10 Apr 2008 03:29:52 +0000
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

Thanks to all that answer my question.
My application is receiving audio data from newtork and play it with ALSA 
library. 
The environment is in ARM not in PC. The same codes can not perform well in 
ARM as in PC.
I have not seen the implementation of snd_pcm_writei(), and only read the 
document of ALSA to use this function.
I guess snd_pcm_writei() will generate a thread that can write data into the 
DMA of soundcard at each period.
This may explain why the duration of snd_pcm_writei() is not regular, and why 
ALSA lib can use function call to implement mixing without a mixing server.
Sometimes the duration is long and sometimes is short.
This may be caused by the generation of the thread in snd_pcm_writei().

I think the thread plays the role of mixing server and terminates when all the 
periods of buffer are played. Then XRUN state is entered.
In my environment, the speed of receiving audio data from network is slow than 
playing audio data with snd_pcm_writei().
In the beginning, the pcm will enter XRUN state, because the audio data from 
network is not full enough to play.
I use more buffer to receive data and play less buffer with snd_pcm_writei(), 
so the time that audio buffer runs out can be delayed.
The delay can let the thread in snd_pcm_writei() to have enough space to play 
audio data.
When the buffer runs out, the thread in snd_pcm_writei() may still has 
remaining data to play, so XRUN won't happen.

I don't know whether I am right. After I see the implementation of 
snd_pcm_writei(), I may have more correct explanation.
