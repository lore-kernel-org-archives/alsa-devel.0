From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: New PCM API extension
Date: Sun, 23 Feb 2003 16:01:52 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302232100.WAA06673@alsa.alsa-project.org>
References: <3E591FD3.5DA500C5@libero.it>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail09.voicenet.com (mail09.voicenet.com [207.103.0.43])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id WAA06673
	for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2003 22:00:10 +0100
In-reply-to: Your message of "Sun, 23 Feb 2003 20:24:03 +0100."
             <3E591FD3.5DA500C5@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Jaroslav Kysela <perex@suse.cz>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> where the buffer is auto-silenced that they need to write samples into the
>> specific position. Reset is nice, but you cannot tell the count of frames
>> to be skipped without filling.
>
>However I think that auto-silence is not the best thing we've designed.
>
>We're using an interrupt handler to do what a rt-like user space process
>should do.
>
>We'd have many things that might be solvable (like saturation in dmix by
>example) in this way, but we've (rightly) choosen not to do it to
>respect the general principle "never do in kernel space what is doable
>in user space".
>
>Sometimes I think that auto silence is an unfortunate exception and I'd
>prefer we'd try to move in the opposite direction.

i think that its similar to the discussion we had 2 weeks ago about
callbacks abramo. alsa-lib could provide functions to do auto-silence,
but the question remains: where and when are they called? the kernel
provides a clearly defined point of control where this can happen if
the user has asked for it and its needed. trying to do it in user
space is clearly a nicer idea, but its hard to see where it should
happen, or how to make sure it does happen if it has been requested.


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
