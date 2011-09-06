From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] sound: Fix race condition in the pcm_lib
 "wait for space loop
Date: Tue, 6 Sep 2011 15:59:54 -0700
Message-ID: <20110906155954.bb9c42eb.akpm@linux-foundation.org>
References: <20110905094947.6ece87c2@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 09A85243E0
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Sep 2011 00:59:58 +0200 (CEST)
In-Reply-To: <20110905094947.6ece87c2@infradead.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 5 Sep 2011 09:49:47 -0700
Arjan van de Ven <arjan@infradead.org> wrote:

> >From 2e37f0a4b2289962e1a45d8e02f8a7f7adad619f Mon Sep 17 00:00:00 2001
> From: Arjan van de Ven <arjan@linux.intel.com>
> Date: Mon, 5 Sep 2011 09:40:18 -0700
> Subject: [PATCH] sound: Fix race condition in the pcm_lib "wait for space" loop
> 
> The wait_for_avail() function in pcm_lib.c has a race in it (observed in
> practice by an Intel validation group).
> 
> The function is supposed to return once space in the buffer has become
> available, or if some timeout happens.  The entity that creates space (irq
> handler of sound driver and some such) will do a wake up on a waitqueue that
> this function registers for.
> 
> However there are two races in the existing code
> 1) If space became available between the caller noticing there was no space and
>    this function actually sleeping, the wakeup is missed and the timeout
>    condition will happen instead
> 2) If a wakeup happened but not sufficient space became available, the code will loop
>    again and wait for more space. However, if the second wake comes in prior
>    to hitting the schedule_timeout_interruptible(), it will be missed, and
>    potentially you'll wait out until the timeout happens.
> 
> The fix consists of using more careful setting of the current state (so that
> if a wakeup happens in the main loop window, the schedule_timeout() falls
> through) and by checking for available space prior to going into the
> schedule_timeout() loop, but after being on the waitqueue and having the
> state set to interruptible.
> 
> ...
>
> --- a/sound/core/pcm_lib.c
> +++ b/sound/core/pcm_lib.c
> @@ -1761,6 +1761,10 @@ static int wait_for_avail(struct snd_pcm_substream *substream,
>  	snd_pcm_uframes_t avail = 0;
>  	long wait_time, tout;
>  
> +	init_waitqueue_entry(&wait, current);
> +	add_wait_queue(&runtime->tsleep, &wait);
> +	set_current_state(TASK_INTERRUPTIBLE);

Well, this isn't very good either.  if a wakeup gets delivered to
runtime->tsleep before the set_current_state(), this process will go
ahead and incorrectly set itself into TASK_INTERRUPTIBLE state.

That looks like it will be dont-care/cant-happen in this case, but it's
setting a bad example.
