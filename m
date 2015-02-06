From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 kernel 2/3] Extend snd_pcm_ops and
	snd_pcm_runtime
Date: Fri, 06 Feb 2015 10:38:45 -0600
Message-ID: <54D4EE15.1010704@linux.intel.com>
References: <1423239388-17745-1-git-send-email-timcussins@eml.cc>
 <1423239388-17745-2-git-send-email-timcussins@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 15AA92605E8
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 17:38:55 +0100 (CET)
In-Reply-To: <1423239388-17745-2-git-send-email-timcussins@eml.cc>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Cussins <timcussins@eml.cc>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/06/2015 10:16 AM, Tim Cussins wrote:
> snd_pcm_ops picks up methods for:
> 
> - start_at
> - start_at_abort
> - start_at_gettime
> 
> For startat requests involving audio hardware clocks, ALSA core
> delegates to the driver using these methods, should they exist.
> 
> snd_pcm_runtime gains fields that contain the current state of
> the startat timer, if any. This allows cancellation and querying.
> 
> Signed-off-by: Tim Cussins <timcussins@eml.cc>
> 
> diff --git a/include/sound/pcm.h b/include/sound/pcm.h
> index 07299b2..a414fec 100644
> --- a/include/sound/pcm.h
> +++ b/include/sound/pcm.h
> @@ -73,6 +73,9 @@ struct snd_pcm_ops {
>  	snd_pcm_uframes_t (*pointer)(struct snd_pcm_substream *substream);
>  	int (*wall_clock)(struct snd_pcm_substream *substream,
>  			  struct timespec *audio_ts);
> +	int (*start_at)(struct snd_pcm_substream *substream, int startat_clock_type, const struct timespec *ts);
> +	int (*start_at_abort)(struct snd_pcm_substream *substream);
> +	int (*start_at_gettime)(struct snd_pcm_substream *substream, int startat_clock_type, struct timespec *current_time);

What is the purpose of this _gettime? If the app relies on regular system time then it doesn't need to use this and if it relies on the link then doesn't this routine duplicate the audio timestamp stuff i am still working on.

>  	int (*copy)(struct snd_pcm_substream *substream, int channel,
>  		    snd_pcm_uframes_t pos,
>  		    void __user *buf, snd_pcm_uframes_t count);
> @@ -368,6 +371,12 @@ struct snd_pcm_ runtime {
>  #ifdef CONFIG_SND_PCM_XRUN_DEBUG
>  	struct snd_pcm_hwptr_log *hwptr_log;
>  #endif
> +
> +	bool startat_timer_running;
> +	/* The following values are valid if startat_timer_running == true */
> +	int startat_clock_type;			/* startat clock type of current timer */
> +	struct timespec startat_start_time;	/* start time of current timer */
> +	void* startat_timer_data;		/* data associated with current timer */
>  };
>  
>  struct snd_pcm_group {		/* keep linked substreams */
> 
