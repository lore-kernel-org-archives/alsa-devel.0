From: John Lindgren <john.lindgren@tds.net>
Subject: Re: snd_pcm_drop causing lockup with DMix
Date: Sun, 28 Feb 2010 12:15:13 -0500
Message-ID: <1267377313.14982.0.camel@satellite>
References: <1267371441.14748.22.camel@satellite>
	<alpine.LNX.2.00.1002281722140.28127@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 365ED10382D
	for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2010 18:15:20 +0100 (CET)
Received: by gyf2 with SMTP id 2so749044gyf.38
	for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2010 09:15:19 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1002281722140.28127@eeebox2.perex-int.cz>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Unfortunately, it doesn't make a difference.

On Sun, 2010-02-28 at 17:22 +0100, Jaroslav Kysela wrote:
> Could you try this patch?
> 
> diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
> index d9e596e..8c7ca06 100644
> --- a/src/pcm/pcm_direct.c
> +++ b/src/pcm/pcm_direct.c
> @@ -1274,6 +1274,7 @@ int snd_pcm_direct_set_timer_params(snd_pcm_direct_t *dmix)
>   	snd_timer_params_set_ticks(params, 1);
>   	if (dmix->tread) {
>   		filter = (1<<SND_TIMER_EVENT_TICK) |
> +			 (1<<SND_TIMER_EVENT_STOP) |
>   			 dmix->timer_event_suspend |
>   			 dmix->timer_event_resume;
>   		snd_timer_params_set_filter(params, filter);
> 
>  					Jaroslav
> 
> -----
> Jaroslav Kysela <perex@perex.cz>
