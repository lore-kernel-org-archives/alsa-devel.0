From: Rong-Jhe <r93922118@ntu.edu.tw>
Subject: Re:
	=?utf-8?q?How_to_kill_thread_server=5Fjob=28=29_in_s?=
	=?utf-8?b?bmRfcGNtX29wZW4oKQ==?=
Date: Mon, 14 Apr 2008 07:47:02 +0000 (UTC)
Message-ID: <loom.20080414T072152-818@post.gmane.org>
References: <loom.20080413T080045-322@post.gmane.org>
	<loom.20080414T020651-351@post.gmane.org>
	<Pine.LNX.4.61.0804140855460.13990@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id A949D24494
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 09:47:16 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JlJPD-0005LS-GB
	for alsa-devel@alsa-project.org; Mon, 14 Apr 2008 07:47:12 +0000
Received: from 220.128.79.26 ([220.128.79.26])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2008 07:47:11 +0000
Received: from r93922118 by 220.128.79.26 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2008 07:47:11 +0000
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

> What you're trying to do? The server process will timeout (ends) 
> itself when dmix clients are inactive.
> 
> 						Jaroslav
> 

Thanks for your response.
My application uses two ways to play audio.
One is using pcm interface in ALSA library, and another is using dsp file.
My goal is to change the ways to play audio dynamically.
The pcm in ALSA library also uses the audio device.
There is only process can open the audio device at a time, so the audio device 
must be closed before changing the way.
For example, if I open dsp file first and use write() to play audio, I need to 
close the dsp file and then open pcm to use snd_pcm_writei().
Similarly, if I open pcm first and use snd_pcm_writei(), I need to close the 
pcm and then open the dsp file immediately.
Sometimes, when I change the way from using pcm to using dsp file, opening dsp 
file will get errors.
I think it may be caused by the busy audio device.
Is there any methods that can indicate whether the audio device used by pcm is 
free?
