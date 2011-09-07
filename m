From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] sound: Fix race condition in the pcm_lib
 "wait for space loop
Date: Tue, 6 Sep 2011 20:07:36 -0700
Message-ID: <20110906200736.785edef3@infradead.org>
References: <20110905094947.6ece87c2@infradead.org>
	<20110906155954.bb9c42eb.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 10E1A2468D
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Sep 2011 05:04:14 +0200 (CEST)
In-Reply-To: <20110906155954.bb9c42eb.akpm@linux-foundation.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 6 Sep 2011 15:59:54 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> > --- a/sound/core/pcm_lib.c
> > +++ b/sound/core/pcm_lib.c
> > @@ -1761,6 +1761,10 @@ static int wait_for_avail(struct
> > snd_pcm_substream *substream, snd_pcm_uframes_t avail = 0;
> >  	long wait_time, tout;
> >  
> > +	init_waitqueue_entry(&wait, current);
> > +	add_wait_queue(&runtime->tsleep, &wait);
> > +	set_current_state(TASK_INTERRUPTIBLE);
> 
> Well, this isn't very good either.  if a wakeup gets delivered to
> runtime->tsleep before the set_current_state(), this process will go
> ahead and incorrectly set itself into TASK_INTERRUPTIBLE state.

... and then check the condition for exit, and then set it to
TASK_RUNABLE a the end...

> 
> That looks like it will be dont-care/cant-happen in this case, but
> it's setting a bad example.

agreed that your ordering is more clean/better.....



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
