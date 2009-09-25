From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/4] snd-usb-caiaq: Do not disable local
	interrupts
Date: Fri, 25 Sep 2009 18:00:24 +0200
Message-ID: <20090925160024.GT21654@buzzloop.caiaq.de>
References: <alpine.BSO.2.01.0909220805420.25926@zrgural.vwaro.pbz>
	<1253892138-10827-1-git-send-email-mark@pogo.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 70D9D24422
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Sep 2009 18:00:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1253892138-10827-1-git-send-email-mark@pogo.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Hills <mark@pogo.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 25, 2009 at 04:22:15PM +0100, Mark Hills wrote:
> The driver documentation states that local interrupts are already
> disabled when trigger() is called, so only a spinlock is required.

Hmm. I assume you tested them well. But I remember to have had quite
some trouble at this point on SMP machines and ended up with that
irqsave code. However, if you're sure that fixes a bug or is not
necessary, let's take the patches and I'll test them once I'm back home
around mid Oct.

Btw - your Signed-off-by: is missing on all of them :)

Thanks,
Daniel


> ---
>  sound/usb/caiaq/audio.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
> index 121af06..ce193a5 100644
> --- a/sound/usb/caiaq/audio.c
> +++ b/sound/usb/caiaq/audio.c
> @@ -72,15 +72,14 @@ static void
>  deactivate_substream(struct snd_usb_caiaqdev *dev,
>  		     struct snd_pcm_substream *sub)
>  {
> -	unsigned long flags;
> -	spin_lock_irqsave(&dev->spinlock, flags);
> +	spin_lock(&dev->spinlock);
>  
>  	if (sub->stream == SNDRV_PCM_STREAM_PLAYBACK)
>  		dev->sub_playback[sub->number] = NULL;
>  	else
>  		dev->sub_capture[sub->number] = NULL;
>  
> -	spin_unlock_irqrestore(&dev->spinlock, flags);
> +	spin_unlock(&dev->spinlock);
>  }
>  
>  static int
> -- 
> 1.6.4.4
> 
