From: Heikki Lindholm <holindho@cs.helsinki.fi>
Subject: Re: POSIX clocks and ALSA
Date: Mon, 26 Nov 2007 18:04:56 +0200
Message-ID: <474AEEA8.6090602@cs.helsinki.fi>
References: <474A763E.7090001@cs.helsinki.fi>
	<Pine.LNX.4.61.0711260848180.7571@tm8103.perex-int.cz>
	<474A9A49.1030208@cs.helsinki.fi>
	<Pine.LNX.4.61.0711261548040.23163@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emh06.mail.saunalahti.fi (emh06.mail.saunalahti.fi
	[62.142.5.116]) by alsa0.perex.cz (Postfix) with ESMTP id 7013824822
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 17:05:00 +0100 (CET)
In-Reply-To: <Pine.LNX.4.61.0711261548040.23163@tm8103.perex-int.cz>
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

Jaroslav Kysela kirjoitti:
> On Mon, 26 Nov 2007, Heikki Lindholm wrote:
> 
>> I had a look at the proposal and the thread at
>> http://thread.gmane.org/gmane.linux.alsa.devel/45237/focus=45573
> 
> My initial implementation following proposal is bellow for review and 
> comments. I also changed timestamps for ALSA timers to use monotonic 
> clocks (can be switched back using a module parameter).
> 
> 					Jaroslav
> 
> diff -r 5e8cab953031 core/pcm_lib.c
> --- a/core/pcm_lib.c	Mon Nov 26 09:00:56 2007 +0100
<...>
> diff -r 5e8cab953031 include/asound.h
> --- a/include/asound.h	Mon Nov 26 09:00:56 2007 +0100
> +++ b/include/asound.h	Mon Nov 26 15:02:57 2007 +0100
> @@ -435,6 +435,13 @@ struct snd_xfern {
>  };
>  
>  enum {
> +	SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY = 0,	/* gettimeofday equivalent */
> +	SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY1,	/* for compatibility, equal to zero */
> +	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC,	/* posix_clock_monotonic equivalent */
> +	SNDRV_PCM_TSTAMP_TYPE_LAST = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC,
> +};

Looks good otherwise, but I'd still like to argue about this 
compatibility point: compatibility with what exactly? When was 
PCM_TSTAMP ioctl deprecated? Before 1.0.0? Has anyone *ever* used it? 
And so, is there any point in adding something not-so-pretty to a new 
feature right from the start. Just declare legacy TSTAMP ioctl users 
scr*wed! :)

The good thing is that this change has, AFAICS, nothing contradicting 
with redesigning the timestamp API, so that could be left open and this 
stuff still applied.

-- Heikki Lindholm
