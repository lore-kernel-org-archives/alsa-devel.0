From: Rong-Jhe <r93922118@ntu.edu.tw>
Subject: Re: XRUN happens too often.
Date: Thu, 10 Apr 2008 12:19:40 +0000 (UTC)
Message-ID: <loom.20080410T115737-199@post.gmane.org>
References: <loom.20080408T090019-595@post.gmane.org>
	<loom.20080408T113541-885@post.gmane.org>
	<47FB8D57.8030904@cox.net>
	<loom.20080409T051547-963@post.gmane.org> <47FD42F2.70903@cox.net>
	<75b66ecd0804091801q1cf2d7fdq34a1b81048eb78d6@mail.gmail.com>
	<loom.20080410T030522-213@post.gmane.org>
	<75b66ecd0804092154m47902330yd2772fef567554bc@mail.gmail.com>
	<loom.20080410T074326-321@post.gmane.org>
	<Pine.LNX.4.61.0804101019560.13990@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AC86244D6
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Apr 2008 14:19:56 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jjvku-0006Z9-3D
	for alsa-devel@alsa-project.org; Thu, 10 Apr 2008 12:19:53 +0000
Received: from 220.128.79.26 ([220.128.79.26])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 10 Apr 2008 12:19:52 +0000
Received: from r93922118 by 220.128.79.26 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 10 Apr 2008 12:19:52 +0000
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

Jaroslav Kysela <perex <at> perex.cz> writes:

> Nope, you probably use dmix plugin. This thread is only for management for 
> shared device and has nothing to do with sample transfers.
> 
> 						Jaroslav
> 

Sorry, I am confused with the mechanism of ALSA library.
I roughly viewed the implementation of snd_pcm_writei(). In my config, 
snd_pcm_writei() will call snd_pcm_mmap_writei().
In snd_pcm_mmap_writei(), the available space is checked, and will wait for 
available space if the pcm is in block mode and the space is not large enough.
Then snd_pcm_mmap_write_area() is called.
I think that snd_pcm_mmap_commit() do the work of put data into the buffer in 
user space.
Function snd_pcm_mmap_commit() shoud call snd_pcm_dmix_mmap_commit in my 
config.
I saw snd_pcm_dmix_start_timer() here, and snd_pcm_dmix_start_timer() calls 
ioctl().
I don't know which file in ALSA driver will receive this ioctl system call.
Does this function start something like timer, and this timer will put the 
buffer in user space into the buffer in kernel space automatically?
I can't understand this mechanism.
I am confused with the interaction between ALSA library and ALSA driver.
I think the mixing procedure is implemented in user space, and ALSA driver 
only put the mixed buffer from user space to the soundcard.
Am I right?
