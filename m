From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Build-in mixer
Date: Fri, 17 Oct 2003 09:41:27 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0310170938390.1221@pnote.perex-int.cz>
References: <s5hy8vminw2.wl@alsa2.suse.de> <200310151453.h9FErp5f001376@oud>
 <s5hsmluilzg.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsmluilzg.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Dan Tihelka <dtihelka@kky.zcu.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 15 Oct 2003, Takashi Iwai wrote:

> At Wed, 15 Oct 2003 10:53:51 -0400,
> Paul Davis wrote:
> >
> > >it's not related with threads, but it invokes a fork for a server
> > >process (a main control only, doesn't do mixing stuffs).
> > >it looks like there is something wrong with this together with xmms.
> > >i've seen that Xlib got a spurious async.
> > >magically enough, the attached patch seems to fix.
> >
> > >From http://www.gtk.org/faq/#AEN477
> >
> > ----------------------------------------------------------------------
> > 5.5. Why does this strange 'x io error' occur when I fork() in my GTK+ app?
> > Why does this strange 'x io error' occur when I fork() in my GTK+ app?
> >
> > This is not really a GTK+ problem, and the problem is not related to
> > fork() either. If the 'x io error' occurs then you probably use the
> > exit() function in order to exit from the child process.
> >
> > When GDK opens an X display, it creates a socket file descriptor. When
> > you use the exit() function, you implicitly close all the open file
> > descriptors, and the underlying X library really doesn't like this.
> >
> > The right function to use here is _exit().
>
> oh yeah, that's it.  replacing two exit() calls in pcm_direct.c with
> _exit() fixes the problem indeed.
> thanks for the info!

I think that only one replacement makes sense - in
snd_pcm_direct_server_create(). Fixed in CVS now.

BTW: An user already reported that _exit() should be used, but he didn't
explain the reason, so I posponed the change to see, if it's really
necessary.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
