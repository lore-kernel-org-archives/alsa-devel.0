From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: snd_pcm_drop causing lockup with DMix
Date: Mon, 1 Mar 2010 07:53:25 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003010752570.28127@eeebox2.perex-int.cz>
References: <1267371441.14748.22.camel@satellite>
	<alpine.LNX.2.00.1002281722140.28127@eeebox2.perex-int.cz>
	<1267377313.14982.0.camel@satellite>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id DCC7F24364
	for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2010 07:53:25 +0100 (CET)
In-Reply-To: <1267377313.14982.0.camel@satellite>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 28 Feb 2010, John Lindgren wrote:

> Unfortunately, it doesn't make a difference.

And this one?

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index d9e596e..ae32fab 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -540,7 +540,6 @@ void snd_pcm_direct_clear_timer_queue(snd_pcm_direct_t *dmix)
  int snd_pcm_direct_timer_stop(snd_pcm_direct_t *dmix)
  {
  	snd_timer_stop(dmix->timer);
-	snd_pcm_direct_clear_timer_queue(dmix);
  	return 0;
  }

@@ -1274,6 +1273,7 @@ int snd_pcm_direct_set_timer_params(snd_pcm_direct_t *dmix)
  	snd_timer_params_set_ticks(params, 1);
  	if (dmix->tread) {
  		filter = (1<<SND_TIMER_EVENT_TICK) |
+			 (1<<SND_TIMER_EVENT_STOP) |
  			 dmix->timer_event_suspend |
  			 dmix->timer_event_resume;
  		snd_timer_params_set_filter(params, filter);

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
