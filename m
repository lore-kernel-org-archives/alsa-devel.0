From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: snd_pcm_drop causing lockup with DMix
Date: Sun, 28 Feb 2010 17:22:27 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002281722140.28127@eeebox2.perex-int.cz>
References: <1267371441.14748.22.camel@satellite>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 641A224468
	for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2010 17:22:28 +0100 (CET)
In-Reply-To: <1267371441.14748.22.camel@satellite>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Lindgren <john.lindgren@tds.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 28 Feb 2010, John Lindgren wrote:

> Hi,
>
> A couple of weeks ago I reported a rather serious bug #4914 that can
> cause a multi-threaded using ALSA to lock up so that it can only be
> ended with SIGKILL.
>
> I maintain the ALSA output part of Audacious, and I need to be able to
> play audio in one thread of the program and then signal that thread to
> stop from another.  The way to do this in ALSA, if I understand
> correctly, is to interrupt the thread that is sending audio with a call
> to snd_pcm_drop.  But using DMix makes the first thread hang up in a
> snd_pcm_wait call with a timeout of -1.
>
> Is anyone working on this bug?  Is there any more help I can provide?

Could you try this patch?

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index d9e596e..8c7ca06 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -1274,6 +1274,7 @@ int snd_pcm_direct_set_timer_params(snd_pcm_direct_t *dmix)
  	snd_timer_params_set_ticks(params, 1);
  	if (dmix->tread) {
  		filter = (1<<SND_TIMER_EVENT_TICK) |
+			 (1<<SND_TIMER_EVENT_STOP) |
  			 dmix->timer_event_suspend |
  			 dmix->timer_event_resume;
  		snd_timer_params_set_filter(params, filter);

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
