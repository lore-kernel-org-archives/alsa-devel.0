From: Paul Davis <pbd@op.net>
Subject: Re: xrun and snd_pcm_prepare.
Date: Mon, 16 Sep 2002 08:56:02 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209161254.OAA12981@alsa.alsa-project.org>
References: <3D859CC8.7323C2E@multitech.co.in>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA12981
	for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2002 14:54:21 +0200
In-reply-to: Your message of "Mon, 16 Sep 2002 14:26:40 +0530."
             <3D859CC8.7323C2E@multitech.co.in>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Shaju Abraham <shaju@multitech.co.in>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>    In aplay utility to playback music, we see that if the return value
>is -EPIPE, a function xrun() is called. This function does nothing more
>than snd_pcm_prepare(handle).  What is the meaning of receiving a -EPIPE
>return value to a application? and, Why cannot this be done at the
>driver level itself? say in pcm_native.c .

EPIPE signals an xrun (over- or under-run). Its analogous to a POSIX
pipe that has either filled up or has nothing to read. It means that
application has failed to keep up with the hardware.

>Is it ok if this snd_pcm_prepare is called from pcm_native.c instead of
>returning -EPIPE to the application?

no, its not.

behaviour when xruns happen is not automatic. sometimes the driver
will do something, sometimes user space wants to know about it and
take care of the situation with its own approach.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
