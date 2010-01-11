From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Duplicate wake-ups in pcm_lib.c
Date: Mon, 11 Jan 2010 19:51:29 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001111949180.4210@eeebox2.perex-int.cz>
References: <6160a5130912231228g29669e4ctfef9ea8f42633120@mail.gmail.com>
	<alpine.LNX.2.00.0912240922460.2598@eeebox2.perex-int.cz>
	<6160a5131001062059i1ef74831p4210987579feb759@mail.gmail.com>
	<alpine.LNX.2.00.1001071552060.4210@eeebox2.perex-int.cz>
	<6160a5131001111036v355685c9j89e85cd13e82e3dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 59BF924441
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 19:51:30 +0100 (CET)
In-Reply-To: <6160a5131001111036v355685c9j89e85cd13e82e3dc@mail.gmail.com>
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

>> The improved and more clean fix in now in my tree:
>>
>> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=1250932e48d3b698415b1f04775433cf1da688d6
>>
>
> The race condition is definitely gone. However I still see a NULL
> event in snd_pcm_playback_poll() in pcm_native.c.

> [13312.755305] ALSA: null poll event, avail 265 avail_min 8192
>
> I couldn't figure out who generates this null event, and even better
> it does not show in the report printed by my test app. I am somewhat
> lost here as to how snd_pcm_playback_poll works.

Note that do_poll() in linux/fs/select.c first checks all given fds
if there's an event. So probably the userspace just called poll() for a 
reason in different timing than sound one (processing event from another 
fd or so). I believe it's normal behaviour.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
