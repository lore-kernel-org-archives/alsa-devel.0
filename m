From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Problems with snd_pcm_wait(..)
Date: Mon, 11 Jan 2010 12:45:45 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001111242581.4210@eeebox2.perex-int.cz>
References: <4B4B0DD0.8090900@avibit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FCE12458C
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 12:45:46 +0100 (CET)
In-Reply-To: <4B4B0DD0.8090900@avibit.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Markus Luttenberger <m.luttenberger@avibit.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 11 Jan 2010, Markus Luttenberger wrote:

> Hey,
>
>
> I tried to implement a callback functionality with ALSA based on the
> example given at
> http://www.cs.utk.edu/~vose/linux/equalarea.com/alsa-audio.html#interruptex.
> Especially the while-loop is basically the same in my program. However,
> it doesn't work. I can trace the program to snd_pcm_wait(..) which just
> waits endlessly.

Which device you're using? If PulseAudio is in path, there is a bug fixed 
recently:

https://bugzilla.redhat.com/show_bug.cgi?id=534130

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
