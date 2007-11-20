From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-cvslog] alsa-lib: pcm - Limit the avail_min
	minimum size
Date: Tue, 20 Nov 2007 20:36:16 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0711202032280.8761@tm8103.perex-int.cz>
References: <ALOGGER1195568961.31@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DEFB24A8C
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 20:36:17 +0100 (CET)
In-Reply-To: <ALOGGER1195568961.31@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Nov 2007, Takashi Iwai wrote:

> changeset:   2352:39d34d6a4587
> tag:         tip
> user:        tiwai
> date:        Tue Nov 20 15:29:10 2007 +0100
> files:       src/pcm/pcm.c
> description:
> pcm - Limit the avail_min minimum size
> 
> Fix avail_min if it's less than period_size.  The too small avail_min
> is simply useless and the cause of CPU hog with rate plugin.
> 
> 
> diff -r b1d1733e52f8 -r 39d34d6a4587 src/pcm/pcm.c
> --- a/src/pcm/pcm.c	Mon Nov 19 08:07:19 2007 +0100
> +++ b/src/pcm/pcm.c	Tue Nov 20 15:29:10 2007 +0100
> @@ -5577,6 +5577,12 @@ int snd_pcm_sw_params_set_avail_min(snd_
>  #endif
>  {
>  	assert(pcm && params);
> +	/* Fix avail_min if it's below period size.  The period_size
> +	 * defines the minimal wake-up timing accuracy, so it doesn't
> +	 * make sense to set below that.
> +	 */
> +	if (val < pcm->period_size)
> +		val = pcm->period_size;
>  	params->avail_min = val;
>  	return 0;
>  }

I think that this patch is wrong. We may use system timers to increase 
(fine-tune) "interrupt" latencies for pcm streams - see tick time in 
driver and library.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
