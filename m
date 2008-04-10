From: Rong-Jhe <r93922118@ntu.edu.tw>
Subject: Re: XRUN happens too often.
Date: Thu, 10 Apr 2008 08:24:51 +0000 (UTC)
Message-ID: <loom.20080410T082046-684@post.gmane.org>
References: <loom.20080408T090019-595@post.gmane.org>
	<loom.20080408T113541-885@post.gmane.org>
	<47FB8D57.8030904@cox.net>
	<loom.20080409T051547-963@post.gmane.org> <47FD42F2.70903@cox.net>
	<75b66ecd0804091801q1cf2d7fdq34a1b81048eb78d6@mail.gmail.com>
	<loom.20080410T030522-213@post.gmane.org>
	<75b66ecd0804092154m47902330yd2772fef567554bc@mail.gmail.com>
	<loom.20080410T074326-321@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id EF936103827
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Apr 2008 10:25:09 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jjs5f-0002a8-Fs
	for alsa-devel@alsa-project.org; Thu, 10 Apr 2008 08:25:04 +0000
Received: from 220.128.79.26 ([220.128.79.26])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 10 Apr 2008 08:25:03 +0000
Received: from r93922118 by 220.128.79.26 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 10 Apr 2008 08:25:03 +0000
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


> 
> I found that there will be a thread generated after calling snd_pcm_open().
> I use command 'ps' to check it.
> Due to this I guess snd_pcm_writei() only put the data into the buffer of 
the 
> thread 'pcm'.
> 
> This thread then schedules of mixes the audio data, and put it into the 
buffer 
> of ALSA driver.
> ALSA ringbuffer only belongs to ALSA library, and ALSA driver uses anoother 
> buffer in kernel.
> Thus, there must be a thread that can put the data in ALSA ringbuffer into 
the 
> buffer of ALSA driver.
> 

I found that snd_pcm_direct_server_create() in ALSA library will create a 
thread.
This resolves my problem that why ALSA library needn't use a daemon to mixing 
audio like other mixing server.
