From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Duplicate wake-ups in pcm_lib.c
Date: Tue, 12 Jan 2010 12:15:57 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001121204050.4210@eeebox2.perex-int.cz>
References: <6160a5130912231228g29669e4ctfef9ea8f42633120@mail.gmail.com>
	<alpine.LNX.2.00.0912240922460.2598@eeebox2.perex-int.cz>
	<6160a5131001062059i1ef74831p4210987579feb759@mail.gmail.com>
	<alpine.LNX.2.00.1001071552060.4210@eeebox2.perex-int.cz>
	<6160a5131001111036v355685c9j89e85cd13e82e3dc@mail.gmail.com>
	<alpine.LNX.2.00.1001111949180.4210@eeebox2.perex-int.cz>
	<6160a5131001111246m48448cedrfa83f9ae39cd6403@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id C332210383C
	for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2010 12:15:57 +0100 (CET)
In-Reply-To: <6160a5131001111246m48448cedrfa83f9ae39cd6403@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 11 Jan 2010, pl bossart wrote:

>>> I couldn't figure out who generates this null event, and even better
>>> it does not show in the report printed by my test app. I am somewhat
>>> lost here as to how snd_pcm_playback_poll works.
>>
>> Note that do_poll() in linux/fs/select.c first checks all given fds
>> if there's an event. So probably the userspace just called poll() for a
>> reason in different timing than sound one (processing event from another fd
>> or so). I believe it's normal behaviour.
>
> This was tested with alsa-lib/test/pcm.c; there's only one call to
> poll() with a -1 timeout value. What I fail to understand is why I see
> this null event in pcm_native.c, and nothing reported in userspace by
> the wait_for_poll() loop in alsa-lib/test/pcm.c

Userspace: poll() syscall
Kernel: do_poll()
 	1) call f_ops->poll callback to ensure that poll condition is
 	   not set (it's usually your null event)
 	2) go to sleep and wait for wake_up
 	3) call f_ops->poll callback again to check which fd woke up
 	4) leave to user space

The f_ops->poll callback is called twice in a normal situation.

 					Jaroslav


-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
