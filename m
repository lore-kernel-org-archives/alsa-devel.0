From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Build-in mixer
Date: Wed, 15 Oct 2003 10:53:51 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310151453.h9FErp5f001376@oud>
References: <s5hy8vminw2.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 15 Oct 2003 16:19:57 +0200."
             <s5hy8vminw2.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Dan Tihelka <dtihelka@kky.zcu.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>it's not related with threads, but it invokes a fork for a server
>process (a main control only, doesn't do mixing stuffs).
>it looks like there is something wrong with this together with xmms.
>i've seen that Xlib got a spurious async.
>magically enough, the attached patch seems to fix.

>From http://www.gtk.org/faq/#AEN477

----------------------------------------------------------------------
5.5. Why does this strange 'x io error' occur when I fork() in my GTK+ app?
Why does this strange 'x io error' occur when I fork() in my GTK+ app?

This is not really a GTK+ problem, and the problem is not related to
fork() either. If the 'x io error' occurs then you probably use the
exit() function in order to exit from the child process.

When GDK opens an X display, it creates a socket file descriptor. When
you use the exit() function, you implicitly close all the open file
descriptors, and the underlying X library really doesn't like this.

The right function to use here is _exit().

Erik Mouw contributed the following code example to illustrate
handling fork() and exit().
----------------------------------------------------------------------


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
