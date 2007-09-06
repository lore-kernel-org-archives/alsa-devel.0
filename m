From: James Pearson <james-p@moving-picture.com>
Subject: Re: Problems with 32 bit apps on 64 bit OS using dmix
 and snd-ioctl32
Date: Thu, 06 Sep 2007 13:15:11 +0100
Message-ID: <46DFEF4F.5060705@moving-picture.com>
References: <46DE8EB0.90208@moving-picture.com>
	<s5hd4wx8ec0.wl%tiwai@suse.de>	<46DEBF69.6070307@moving-picture.com>	<s5hodgh6sqf.wl%tiwai@suse.de>	<46DECCEA.4060306@moving-picture.com>	<s5hk5r56qin.wl%tiwai@suse.de>	<46DEDF4B.7050108@moving-picture.com>	<s5hbqch6nrf.wl%tiwai@suse.de>	<46DFD5DB.6030204@moving-picture.com>	<s5h642o6p8h.wl%tiwai@suse.de>	<46DFEAD5.7040806@moving-picture.com>
	<s5h3axs6lo2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moving-picture.com (mpc-26.sohonet.co.uk [193.203.82.251])
	by alsa0.perex.cz (Postfix) with ESMTP id CF00F24476
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 14:15:11 +0200 (CEST)
In-Reply-To: <s5h3axs6lo2.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> Ah, I see the point.
> 
> With ALSA 1.0.15rc1, we can safely uncomment #if 0 .. #endif in
> timer32_new.c and timer32_old.c.  These no longer conflict with
> existing ioctls.  I forgot about it.
> 
> The patch is below.
> 
> 
> Takashi
> 
> diff -r adfe4179d670 acore/ioctl32/timer32_new.c
> --- a/acore/ioctl32/timer32_new.c	Fri Aug 31 12:22:35 2007 +0200
> +++ b/acore/ioctl32/timer32_new.c	Thu Sep 06 14:06:40 2007 +0200
> @@ -88,18 +88,11 @@ struct ioctl32_mapper timer_mappers[] = 
>  	{ SNDRV_TIMER_IOCTL_INFO32, AP(timer_info) },
>  	MAP_COMPAT(SNDRV_TIMER_IOCTL_PARAMS),
>  	{ SNDRV_TIMER_IOCTL_STATUS32, AP(timer_status) },
> -#if 0
> -	/* ** FIXME **
> -	 * The following four entries are disabled because they conflict
> -	 * with the TCOC* definitions.
> -	 * Unfortunately, the current ioctl32 wrapper uses a single
> -	 * hash table for all devices.  Once when the wrapper is fixed
> -	 * with the table based on devices, they'll be back again.
> -	 */
> +	/* The ioctls are changed, so we can enable them again */
> +	/* The old ioctls conflict with TIOC_* definitions */
>  	MAP_COMPAT(SNDRV_TIMER_IOCTL_START),
>  	MAP_COMPAT(SNDRV_TIMER_IOCTL_STOP),
>  	MAP_COMPAT(SNDRV_TIMER_IOCTL_CONTINUE),
>  	MAP_COMPAT(SNDRV_TIMER_IOCTL_PAUSE),
> -#endif
>  	{ 0 },
>  };
> diff -r adfe4179d670 acore/ioctl32/timer32_old.c
> --- a/acore/ioctl32/timer32_old.c	Fri Aug 31 12:22:35 2007 +0200
> +++ b/acore/ioctl32/timer32_old.c	Thu Sep 06 14:06:40 2007 +0200
> @@ -88,18 +88,11 @@ struct ioctl32_mapper timer_mappers[] = 
>  	{ SNDRV_TIMER_IOCTL_INFO32, AP(timer_info) },
>  	MAP_COMPAT(SNDRV_TIMER_IOCTL_PARAMS),
>  	{ SNDRV_TIMER_IOCTL_STATUS32, AP(timer_status) },
> -#if 0
> -	/* ** FIXME **
> -	 * The following four entries are disabled because they conflict
> -	 * with the TCOC* definitions.
> -	 * Unfortunately, the current ioctl32 wrapper uses a single
> -	 * hash table for all devices.  Once when the wrapper is fixed
> -	 * with the table based on devices, they'll be back again.
> -	 */
> +	/* The ioctls are changed, so we can enable them again */
> +	/* The old ioctls conflict with TIOC_* definitions */
>  	MAP_COMPAT(SNDRV_TIMER_IOCTL_START),
>  	MAP_COMPAT(SNDRV_TIMER_IOCTL_STOP),
>  	MAP_COMPAT(SNDRV_TIMER_IOCTL_CONTINUE),
>  	MAP_COMPAT(SNDRV_TIMER_IOCTL_PAUSE),
> -#endif
>  	{ 0 },
>  };

Thanks!

I guess this change also needs to go into the next rc ...

James
