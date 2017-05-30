From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ALSA: sound/core/pcm_timer.c: include
 pcm_local.h and remove some extraneous tabs
Date: Tue, 30 May 2017 03:22:33 -0700
Message-ID: <1496139753.2618.21.camel@perches.com>
References: <20170530095830.31534-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0182.hostedemail.com
 [216.40.44.182])
 by alsa0.perex.cz (Postfix) with ESMTP id DE12B266A56
 for <alsa-devel@alsa-project.org>; Tue, 30 May 2017 12:22:48 +0200 (CEST)
In-Reply-To: <20170530095830.31534-1-colin.king@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin King <colin.king@canonical.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2017-05-30 at 10:58 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> We need to include pcm_local.h to clean up some smatch warnings:
> 
> symbol 'snd_pcm_timer_done' was not declared. Should it be static?
> symbol 'snd_pcm_timer_init' was not declared. Should it be static?
> symbol 'snd_pcm_timer_resolution_change' was not declared. Should
>   it be static?
> 
> Also remove some extraneous tabs on empty lines.

Thanks.  trivia:

> diff --git a/sound/core/pcm_timer.c b/sound/core/pcm_timer.c
[]
> @@ -33,7 +35,7 @@ void snd_pcm_timer_resolution_change(struct snd_pcm_substream *substream)
>  {
>  	unsigned long rate, mult, fsize, l, post;
>  	struct snd_pcm_runtime *runtime = substream->runtime;
> -	
> +
>          mult = 1000000000;
>  	rate = runtime->rate;

Maybe fix the mult indentation too?
