From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: XRUN happens too often.
Date: Thu, 10 Apr 2008 10:20:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0804101019560.13990@tm8103.perex-int.cz>
References: <loom.20080408T090019-595@post.gmane.org>
	<loom.20080408T113541-885@post.gmane.org>
	<47FB8D57.8030904@cox.net> <loom.20080409T051547-963@post.gmane.org>
	<47FD42F2.70903@cox.net>
	<75b66ecd0804091801q1cf2d7fdq34a1b81048eb78d6@mail.gmail.com>
	<loom.20080410T030522-213@post.gmane.org>
	<75b66ecd0804092154m47902330yd2772fef567554bc@mail.gmail.com>
	<loom.20080410T074326-321@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id AF96A24400
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Apr 2008 10:20:51 +0200 (CEST)
In-Reply-To: <loom.20080410T074326-321@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rong-Jhe <r93922118@ntu.edu.tw>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 10 Apr 2008, Rong-Jhe wrote:

> > ALSA does not generate threads for you like this.  I was referring to
> > your application's audio thread, assuming that your app is indeed
> > multithreaded.
> > 
> > The duration probably varies because the call to snd_pcm_writei() will
> > block until there is enough space in the ALSA ringbuffer to receive
> > your data.
> > 
> > Lee
> > 
> 
> I found that there will be a thread generated after calling 
> snd_pcm_open(). I use command 'ps' to check it. Due to this I guess 
> snd_pcm_writei() only put the data into the buffer of the thread 'pcm'.

Nope, you probably use dmix plugin. This thread is only for management for 
shared device and has nothing to do with sample transfers.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
