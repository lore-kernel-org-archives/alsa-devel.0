From: Paul Davis <pbd@op.net>
Subject: Re: asound.conf pcm.tee, anyone know how to use it
Date: Sun, 12 May 2002 22:33:04 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205130232.EAA31315@alsa.alsa-project.org>
References: <20020513004239.56478.qmail@web14108.mail.yahoo.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id EAA31315
	for <alsa-devel@alsa-project.org>; Mon, 13 May 2002 04:32:09 +0200
In-Reply-To: Your message of "Sun, 12 May 2002 17:42:39 PDT."
             <20020513004239.56478.qmail@web14108.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Dave Andruczyk <djandruczyk@yahoo.com>
Cc: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>Please someone correct me if I am mistaken.  Can the pcm.tee option in alsa.co
>n
>(/usr/share/alsa/alsa.conf) be setup so that the output of a program that uses
>alsa natively be monitored by connecting to this "tee" ??

well, the "tee" type allows redirection but its only sane to do it to
a file inode that allows (almost) endless non-blocking read/write. there are
almost no such devices in POSIX unless its a regular file. so you
can't really use it for loopback. its intended for instances where you
want the output to go to an audio interface *and* a file.

there is a way to do "loopback" in ALSA these days, but "tee" is not
it. someone will fill in the blanks (or better yet, write/complete a
HOWTO). 

--p

<obJack>
of course, JACK can do loopback, multiplexing, app-2-app and many
other forms of data routing without any effort on the part of your
application ...
</obJack>

:)

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
