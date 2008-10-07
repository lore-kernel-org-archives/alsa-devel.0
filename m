From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] snd-core: enlarge snd_card.components for
 up to 4 codecs
Date: Tue, 7 Oct 2008 11:06:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0810071105351.13177@tm8103-a.perex-int.cz>
References: <1223362567.716898.9499@de> <s5htzboomf0.wl%tiwai@suse.de>
	<1223368470.894420.10038@de> <s5hljx0n5jp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E20E71037FD
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 11:06:41 +0200 (CEST)
In-Reply-To: <s5hljx0n5jp.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Wu Fengguang <wfg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 7 Oct 2008, Takashi Iwai wrote:

> Then I agree with increasing the components as a simple workaround.
> 
> How about the patch below?  The control protocol number is increased
> for this change as well.
> 
> 
> thanks,
> 
> Takashi
> 
> diff --git a/include/sound/asound.h b/include/sound/asound.h
> index 3eaf155..fbfe992 100644
> --- a/include/sound/asound.h
> +++ b/include/sound/asound.h
> @@ -696,7 +696,7 @@ struct snd_timer_tread {
>   *                                                                          *
>   ****************************************************************************/
>  
> -#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 5)
> +#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 6)
>  
>  struct snd_ctl_card_info {
>  	int card;			/* card number */
> @@ -707,8 +707,7 @@ struct snd_ctl_card_info {
>  	unsigned char longname[80];	/* name + info text about soundcard */
>  	unsigned char reserved_[16];	/* reserved for future (was ID of mixer) */
>  	unsigned char mixername[80];	/* visual mixer identification */
> -	unsigned char components[80];	/* card components / fine identification, delimited with one space (AC97 etc..) */
> -	unsigned char reserved[48];	/* reserved for future */
> +	unsigned char components[128];	/* card components / fine identification, delimited with one space (AC97 etc..) */
>  };
>  
>  typedef int __bitwise snd_ctl_elem_type_t;
> diff --git a/include/sound/core.h b/include/sound/core.h
> index 558b962..221554e 100644
> --- a/include/sound/core.h
> +++ b/include/sound/core.h
> @@ -114,7 +114,7 @@ struct snd_card {
>  	char shortname[32];		/* short name of this soundcard */
>  	char longname[80];		/* name of this soundcard */
>  	char mixername[80];		/* mixer name */
> -	char components[80];		/* card components delimited with
> +	char components[128];		/* card components delimited with
>  								space */
>  	struct module *module;		/* top-level module */

Acked-by: Jaroslav Kysela <perex@perex.cz>

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
