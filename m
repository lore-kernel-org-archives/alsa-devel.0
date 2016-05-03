From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v6 2/4] ALSA: compress: Add function to
 indicate the stream has gone bad
Date: Tue, 3 May 2016 17:57:54 +0100
Message-ID: <20160503165754.GC1646@localhost.localdomain>
References: <1461338126-25998-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1461338126-25998-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B94F2670CF
 for <alsa-devel@alsa-project.org>; Tue,  3 May 2016 18:57:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1461338126-25998-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 22, 2016 at 04:15:24PM +0100, Charles Keepax wrote:
> Currently, the avail IOCTL doesn't pass any error status, which
> means typically on error it simply shows no data available. This
> can lead to situations where user-space is waiting indefinitely
> for data that will never come as the DSP has suffered an
> unrecoverable error.
> 
> Add snd_compr_stop_error which end drivers can call to indicate
> the stream has suffered an unrecoverable error and stop it. The
> avail and poll IOCTLs are then updated to report if the stream is
> in an error state to user-space. Allowing the error to propagate
> out. Processing of the actual snd_compr_stop needs to be deferred
> to a worker thread as the end driver may detect the errors during
> an existing operation callback.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Acked-by: Vinod Koul <vinod.koul@intel.com>
> ---
> @@ -400,10 +418,18 @@ static unsigned int snd_compr_poll(struct file *f, poll_table *wait)
>  		return -EFAULT;
>  
>  	mutex_lock(&stream->device->lock);
> -	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
> +
> +	switch (stream->runtime->state) {
> +	case SNDRV_PCM_STATE_OPEN:
>  		retval = -EBADFD;
>  		goto out;
> +	case SNDRV_PCM_STATE_XRUN:
> +		retval = -EPIPE;
> +		goto out;
> +	default:
> +		break;
>  	}

One more issue to fix up before we can submit these I am afraid.
We can't return negative values from snd_compr_poll, I need to
fix both the original -EBADFD and the -EPIPE that my patch adds
here.

I will do a new rev of the patches shortly, sorry about missing
this until now.

Thanks,
Charles
