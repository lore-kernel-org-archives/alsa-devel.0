From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sound: convert snd_seq_subscribers.ref_count from
 atomic_t to refcount_t
Date: Tue, 21 Feb 2017 16:42:54 +0100
Message-ID: <20170221154254.GG6515@twins.programming.kicks-ass.net>
References: <1487690830-30277-1-git-send-email-elena.reshetova@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487690830-30277-1-git-send-email-elena.reshetova@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Elena Reshetova <elena.reshetova@intel.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, gregkh@linuxfoundation.org, perex@perex.cz, tiwai@suse.com, Hans Liljestrand <ishkamiel@gmail.com>, Kees Cook <keescook@chromium.org>, David Windsor <dwindsor@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 21, 2017 at 05:27:10PM +0200, Elena Reshetova wrote:
> diff --git a/sound/core/seq/seq_ports.c b/sound/core/seq/seq_ports.c
> index fe686ee..1ca896b 100644
> --- a/sound/core/seq/seq_ports.c
> +++ b/sound/core/seq/seq_ports.c

> @@ -520,7 +520,6 @@ static int check_and_subscribe_port(struct snd_seq_client *client,
>  	else
>  		list_add_tail(&subs->dest_list, &grp->list_head);
>  	grp->exclusive = exclusive;
> -	atomic_inc(&subs->ref_count);
>  	write_unlock_irq(&grp->list_lock);
>  	err = 0;
>  
> @@ -570,7 +569,6 @@ int snd_seq_port_connect(struct snd_seq_client *connector,
>  		return -ENOMEM;
>  
>  	subs->info = *info;
> -	atomic_set(&subs->ref_count, 0);
>  	INIT_LIST_HEAD(&subs->src_list);
>  	INIT_LIST_HEAD(&subs->dest_list);
>  
> @@ -587,6 +585,7 @@ int snd_seq_port_connect(struct snd_seq_client *connector,
>  	if (err < 0)
>  		goto error_dest;
>  
> +	refcount_set(&subs->ref_count, 2);
>  	return 0;
>  
>   error_dest:
> @@ -613,7 +612,7 @@ int snd_seq_port_disconnect(struct snd_seq_client *connector,
>  	/* look for the connection */
>  	list_for_each_entry(subs, &src->list_head, src_list) {
>  		if (match_subs_info(info, &subs->info)) {
> -			atomic_dec(&subs->ref_count); /* mark as not ready */
> +			refcount_dec(&subs->ref_count); /* mark as not ready */
>  			err = 0;
>  			break;
>  		}

This looks dodgy... someone should look hard at this.
