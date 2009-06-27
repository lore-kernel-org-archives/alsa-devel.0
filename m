From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: snd_pcm_lib_read1 timeout
Date: Sat, 27 Jun 2009 13:13:49 +0530
Message-ID: <98769532B4BB14429434178695419EAE5B9FD70A@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B4952458B
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Jun 2009 09:43:55 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I found another clue to this but can anyone please explain what could be going wrong?

The execution enters into the following function 

>static int snd_pcm_update_hw_ptr_interrupt(struct snd_pcm_substream >*substream)
>{
>	....
>	new_hw_ptr = hw_base + pos;
this gets updated correctly
>	...
>	hdelta = new_hw_ptr - old_hw_ptr;
>	jdelta = jiffies - runtime->hw_ptr_jiffies;
as far as I don't get into the following loop, am good...the moment I get into this loop my new_hw_ptr gets modified and it does not progress in capture. Any clues?
>	if (((hdelta * HZ) / runtime->rate) > jdelta + HZ/100) {
>		delta = jdelta /
>			(((runtime->period_size * HZ) / runtime->rate)
>								+ HZ/100);
>		hw_ptr_error(substream,
>			     "hw_ptr skipping! [Q] "
>			     "(pos=%ld, delta=%ld, period=%ld, "
>			     "jdelta=%lu/%lu/%lu)\n",
>			     (long)pos, (long)hdelta,
>			     (long)runtime->period_size, jdelta,
>			     ((hdelta * HZ) / runtime->rate), delta);
>		hw_ptr_interrupt = runtime->hw_ptr_interrupt +
>				   runtime->period_size * delta;
>		if (hw_ptr_interrupt >= runtime->boundary)
>			hw_ptr_interrupt -= runtime->boundary;
>		/* rebase to interrupt position */
>		hw_base = new_hw_ptr = hw_ptr_interrupt;
>		/* align hw_base to buffer_size */
>		hw_base -= hw_base % runtime->buffer_size;
>		delta = 0;
>	}
>      ...
>}

Thanks,
Harsha

______________________________________
From: Harsha, Priya 
Sent: Saturday, June 27, 2009 9:18 AM
To: alsa-devel@alsa-project.org
Subject: snd_pcm_lib_read1 timeout

Hi,

I have a basic question;

There is a schedule_timeout() in snd_pcm_lib_read1 -> wait_for_avail_min. When and where does this timeout get signaled? What would be the reason that this timeout happens?


Thanks,
Harsha
