From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: Re: alsa error /dev/snd/pcmC1D1c failed: No such
	file or directory
Date: Wed, 24 Jul 2002 12:03:13 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207241903.MAA25182@cmn29.stanford.edu>
References: <Pine.LNX.4.33.0207242047110.578-100000@pnote.perex-int.cz>
Mime-Version: 1.0 (NeXT Mail 3.3 v148.2.1)
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cm-mail.stanford.edu (cm-mail.Stanford.EDU [171.64.197.135])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA25852
	for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2002 21:03:49 +0200
In-Reply-To: <Pine.LNX.4.33.0207242047110.578-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Gary Scavone <gary@ccrma.Stanford.EDU>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > However, I still feel that my original gripe (the error message
> > output) is valid.  In all other cases that I'm aware of, you never
> > automatically spit out an error message to stderr or stdout.  Why
> > should it be different in this case?  There is an error retrieval
> > mechanism in place, namely snd_strerror().
>
> Have you realized, that we have snd_lib_error_set_handler() function? If
> you create an empty callback, you'll get no error messages. I think that
> the default behaviour is good for command-line tools.

Ok, so there is a workaround....

However I still think this is wrong (sorry for the
insistence). The default behavior might be good for a command
line tool, but not all tools that use the library are command
line tools. AFAIK the default behavior of libraries is to not
go around printing things on stdout/stderr by default. If some
command line tool wants to have verbose error reporting on, it
should turn it on (not the opposite!).

-- Fernando


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
