From: Arthur Marsh <arthur.marsh@internode.on.net>
Subject: Re: lock-up when loading desktop
Date: Mon, 13 Oct 2014 23:34:41 +1030
Message-ID: <543BCDE9.7010308@internode.on.net>
References: <543B2438.1050002@internode.on.net>	<s5ha950zeyi.wl-tiwai@suse.de>	<543BB942.5060602@internode.on.net>
 <s5h7g04ywgg.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [150.101.137.141])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ACED26043C
 for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2014 15:04:48 +0200 (CEST)
In-Reply-To: <s5h7g04ywgg.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Takashi Iwai wrote, on 13/10/14 23:10:

> OK, then could you check whether reverting only the last one (of two)
> does *NOT* fix the issue?  I think it shouldn't, but let us confirm.

Thanks for the feedback. Sorry, I'm not good on git commands. Having 
applied the two reversions previously, how do I get my git tree back to 
the same state as Linus' git head (ie undo the reversions)?

I could then apply the second reversion only and test that.

>
> The alsa-info.sh shows the lockdep messages.  I assume that it's seen
> even before 3.17+?

I didn't see ALSA-related lockdep messages in 3.17.0 or earlier, and 
have had the lockdep validator option enabled on kernels for several 
months now.

>
> Last but not least, please check whether nonatomic flag is set wrongly
> by some reason like the patch below.  (Check the kernel message after
> boot or try to playback some PCM).
>
>
> Takashi
>
> ---
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index 85fe1a216225..9c7cbd1b839e 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -2275,6 +2275,9 @@ static int snd_pcm_open(struct file *file, struct snd_pcm *pcm, int stream)
>   	int err;
>   	wait_queue_t wait;
>
> +	if (WARN_ON(pcm->nonatomic))
> +		return -EINVAL;
> +
>   	if (pcm == NULL) {
>   		err = -ENODEV;
>   		goto __error1;
>
>

I can apply this patch, but I'm not entirely sure how to check for the 
state of the nonatomic flag.

Regards,

Arthur.
