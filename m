From: John Lindgren <john.lindgren@tds.net>
Subject: Re: snd_pcm_drop causing lockup with DMix
Date: Mon, 01 Mar 2010 18:52:32 -0500
Message-ID: <1267487552.11621.2.camel@satellite>
References: <1267371441.14748.22.camel@satellite>
	<alpine.LNX.2.00.1002281722140.28127@eeebox2.perex-int.cz>
	<1267377313.14982.0.camel@satellite>
	<alpine.LNX.2.00.1003010752570.28127@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f179.google.com (mail-yw0-f179.google.com
	[209.85.211.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AAA61037FC
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 00:52:35 +0100 (CET)
Received: by ywh9 with SMTP id 9so1499964ywh.23
	for <alsa-devel@alsa-project.org>; Mon, 01 Mar 2010 15:52:34 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1003010752570.28127@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Still no difference.

I also noticed that with or without the patch, Audacious will
occasionally not hang up, and instead the snd_pcm_writei call that is
interrupted will return -EBADFD.  I haven't seen the test case do the
same.

On Mon, 2010-03-01 at 07:53 +0100, Jaroslav Kysela wrote:
> And this one?
> 
> diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
> index d9e596e..ae32fab 100644
> --- a/src/pcm/pcm_direct.c
> +++ b/src/pcm/pcm_direct.c
> @@ -540,7 +540,6 @@ void snd_pcm_direct_clear_timer_queue(snd_pcm_direct_t *dmix)
>   int snd_pcm_direct_timer_stop(snd_pcm_direct_t *dmix)
>   {
>   	snd_timer_stop(dmix->timer);
> -	snd_pcm_direct_clear_timer_queue(dmix);
>   	return 0;
>   }
> 
> @@ -1274,6 +1273,7 @@ int snd_pcm_direct_set_timer_params(snd_pcm_direct_t *dmix)
>   	snd_timer_params_set_ticks(params, 1);
>   	if (dmix->tread) {
>   		filter = (1<<SND_TIMER_EVENT_TICK) |
> +			 (1<<SND_TIMER_EVENT_STOP) |
>   			 dmix->timer_event_suspend |
>   			 dmix->timer_event_resume;
>   		snd_timer_params_set_filter(params, filter);
> 
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
