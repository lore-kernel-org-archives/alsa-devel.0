From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: XRUN happens too often.
Date: Thu, 10 Apr 2008 00:54:33 -0400
Message-ID: <75b66ecd0804092154m47902330yd2772fef567554bc@mail.gmail.com>
References: <loom.20080408T090019-595@post.gmane.org>
	<loom.20080408T113541-885@post.gmane.org> <47FB8D57.8030904@cox.net>
	<loom.20080409T051547-963@post.gmane.org> <47FD42F2.70903@cox.net>
	<75b66ecd0804091801q1cf2d7fdq34a1b81048eb78d6@mail.gmail.com>
	<loom.20080410T030522-213@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 0504524488
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Apr 2008 06:54:34 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id w49so5703437pyg.36
	for <alsa-devel@alsa-project.org>; Wed, 09 Apr 2008 21:54:34 -0700 (PDT)
In-Reply-To: <loom.20080410T030522-213@post.gmane.org>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 9, 2008 at 11:29 PM, Rong-Jhe <r93922118@ntu.edu.tw> wrote:
> Thanks to all that answer my question.
>  My application is receiving audio data from newtork and play it with ALSA
>  library.
>  The environment is in ARM not in PC. The same codes can not perform well in
>  ARM as in PC.
>  I have not seen the implementation of snd_pcm_writei(), and only read the
>  document of ALSA to use this function.
>  I guess snd_pcm_writei() will generate a thread that can write data into the
>  DMA of soundcard at each period.
>  This may explain why the duration of snd_pcm_writei() is not regular, and why
>  ALSA lib can use function call to implement mixing without a mixing server.

ALSA does not generate threads for you like this.  I was referring to
your application's audio thread, assuming that your app is indeed
multithreaded.

The duration probably varies because the call to snd_pcm_writei() will
block until there is enough space in the ALSA ringbuffer to receive
your data.

Lee
